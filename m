From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Sun,  9 Sep 2018 01:57:04 +0530
Subject: [PATCH 3/6] tracing: Add tp_pstore cmdline to have tracepoints go to
 pstore
In-Reply-To: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
Message-ID: <f65e9fa6e047b9b14d4f64362f9fe1f89b306050.1536430404.git.saiprakash.ranjan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the kernel command line tp_pstore option that will have
tracepoints go to persistent ram buffer as well as to the
trace buffer for further debugging. This is similar to tp_printk
cmdline option of ftrace.

Pstore support for event tracing is already added and we enable
logging to pstore only if cmdline is specified.

Passing "tp_pstore" will activate logging to pstore. To turn it
off, the sysctl /proc/sys/kernel/tracepoint_pstore can have '0'
echoed into it. Note, this only works if the cmdline option is
used. Echoing 1 into the sysctl file without the cmdline option
will have no affect.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 .../admin-guide/kernel-parameters.txt         | 21 ++++++++
 include/linux/ftrace.h                        |  6 ++-
 kernel/sysctl.c                               |  7 +++
 kernel/trace/Kconfig                          | 22 +++++++-
 kernel/trace/trace.c                          | 51 +++++++++++++++++++
 kernel/trace/trace.h                          |  7 +++
 6 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..622cf64d4e5b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4519,6 +4519,27 @@
 			frequency tracepoints such as irq or sched, can cause
 			the system to live lock.
 
+	tp_pstore[FTRACE]
+			Have the tracepoints sent to persistent ram buffer for
+			debugging. This is useful for debugging early boot up
+			and other kernel issues where the system hangs or
+			reboots due to some unclocked access or some buggy
+			driver. Instead of spamming the console with unwanted
+			logs, we can send the logs to pstore buffer for further
+			debugging.
+
+			Last occurred events in the pstore log will be helpful
+			in identifying the reset cause.
+
+			For example, to trace sched event, add to the command
+			line:
+				trace_event=sched tp_pstore
+
+			To turn off having tracepoints sent to pstore,
+				echo 0 > /proc/sys/kernel/tracepoint_pstore
+			Note, echoing 1 into this file without the
+			tracepoint_pstore kernel cmdline option has no effect.
+
 	traceoff_on_warning
 			[FTRACE] enable this option to disable tracing when a
 			warning is hit. This turns off "tracing_on". Tracing can
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a397907e8d72..7c3074e7ec6b 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -900,6 +900,7 @@ enum ftrace_dump_mode;
 
 extern enum ftrace_dump_mode ftrace_dump_on_oops;
 extern int tracepoint_printk;
+extern int tracepoint_pstore;
 
 extern void disable_trace_on_warning(void);
 extern int __disable_trace_on_warning;
@@ -907,9 +908,12 @@ extern int __disable_trace_on_warning;
 int tracepoint_printk_sysctl(struct ctl_table *table, int write,
 			     void __user *buffer, size_t *lenp,
 			     loff_t *ppos);
+int tracepoint_pstore_sysctl(struct ctl_table *table, int write,
+			     void __user *buffer, size_t *lenp,
+			     loff_t *ppos);
 
 #else /* CONFIG_TRACING */
-static inline void  disable_trace_on_warning(void) { }
+static inline void disable_trace_on_warning(void) { }
 #endif /* CONFIG_TRACING */
 
 #ifdef CONFIG_FTRACE_SYSCALLS
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cc02050fd0c4..3cc1223b8955 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -653,6 +653,13 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= tracepoint_printk_sysctl,
 	},
+	{
+		.procname	= "tracepoint_pstore",
+		.data		= &tracepoint_pstore,
+		.maxlen		= sizeof(tracepoint_pstore),
+		.mode		= 0644,
+		.proc_handler	= tracepoint_pstore_sysctl,
+	},
 #endif
 #ifdef CONFIG_KEXEC_CORE
 	{
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 5e3de28c7677..d0eed268ee85 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -774,6 +774,27 @@ config TRACING_EVENTS_GPIO
 	help
 	  Enable tracing events for gpio subsystem
 
+config TRACING_EVENTS_IO
+	bool "Trace IO read/write events"
+	help
+	  Enable tracing events for IO read/write operations.
+	  This is useful for debugging random hangs or resets
+	  caused due to unclocked access or some buggy driver.
+
+	  Output of this trace event can be overwhelming and hence
+	  dynamic filtering option based on dynamic debug library
+	  is provided to narrow down the issues.
+
+	  Eg: Trace all register read/write of mmc subsystem with
+	  below command line:
+
+	    dyndbg="file drivers/mmc/* +p" trace_event=io
+
+	  See Documentation/admin-guide/dynamic-debug-howto.rst for
+	  more info on using dynamic debug.
+
+	  If unsure, say N.
+
 config GCOV_PROFILE_FTRACE
 	bool "Enable GCOV profiling on ftrace subsystem"
 	depends on GCOV_KERNEL
@@ -789,4 +810,3 @@ config GCOV_PROFILE_FTRACE
 endif # FTRACE
 
 endif # TRACING_SUPPORT
-
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bf6f1d70484d..018cbbefb769 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -73,6 +73,11 @@ struct trace_iterator *tracepoint_print_iter;
 int tracepoint_printk;
 static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
 
+/* Pipe tracepoints to pstore */
+struct trace_iterator *tracepoint_pstore_iter;
+int tracepoint_pstore;
+static DEFINE_STATIC_KEY_FALSE(tracepoint_pstore_key);
+
 /* For tracers that don't implement custom flags */
 static struct tracer_opt dummy_tracer_opt[] = {
 	{ }
@@ -238,6 +243,14 @@ static int __init set_tracepoint_printk(char *str)
 }
 __setup("tp_printk", set_tracepoint_printk);
 
+static int __init set_tracepoint_pstore(char *str)
+{
+	if ((strcmp(str, "=0") != 0 && strcmp(str, "=off") != 0))
+		tracepoint_pstore = 1;
+	return 1;
+}
+__setup("tp_pstore", set_tracepoint_pstore);
+
 unsigned long long ns2usecs(u64 nsec)
 {
 	nsec += 500;
@@ -2376,11 +2389,45 @@ int tracepoint_printk_sysctl(struct ctl_table *table, int write,
 	return ret;
 }
 
+static DEFINE_MUTEX(tracepoint_pstore_mutex);
+
+int tracepoint_pstore_sysctl(struct ctl_table *table, int write,
+			     void __user *buffer, size_t *lenp,
+			     loff_t *ppos)
+{
+	int save_tracepoint_pstore;
+	int ret;
+
+	mutex_lock(&tracepoint_pstore_mutex);
+	save_tracepoint_pstore = tracepoint_pstore;
+
+	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+
+	if (!tracepoint_pstore_iter)
+		tracepoint_pstore = 0;
+
+	if (save_tracepoint_pstore == tracepoint_pstore)
+		goto out;
+
+	if (tracepoint_pstore)
+		static_key_enable(&tracepoint_pstore_key.key);
+	else
+		static_key_disable(&tracepoint_pstore_key.key);
+
+ out:
+	mutex_unlock(&tracepoint_pstore_mutex);
+
+	return ret;
+}
+
 void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
 {
 	if (static_key_false(&tracepoint_printk_key.key))
 		output_printk(fbuffer);
 
+	if (static_key_false(&tracepoint_pstore_key.key))
+		pstore_event_call(fbuffer);
+
 	event_trigger_unlock_commit(fbuffer->trace_file, fbuffer->buffer,
 				    fbuffer->event, fbuffer->entry,
 				    fbuffer->flags, fbuffer->pc);
@@ -8596,6 +8643,10 @@ void __init early_trace_init(void)
 		else
 			static_key_enable(&tracepoint_printk_key.key);
 	}
+
+	if (tracepoint_pstore)
+		static_key_enable(&tracepoint_pstore_key.key);
+
 	tracer_alloc_buffers();
 }
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 3b8c0e24ab30..edc28d0c27eb 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1843,5 +1843,12 @@ static inline void tracer_hardirqs_off(unsigned long a0, unsigned long a1) { }
 #endif
 
 extern struct trace_iterator *tracepoint_print_iter;
+extern struct trace_iterator *tracepoint_pstore_iter;
+
+#ifdef CONFIG_PSTORE_FTRACE
+extern void pstore_event_call(struct trace_event_buffer *fbuffer);
+#else
+static inline void pstore_event_call(struct trace_event_buffer *fbuffer) { }
+#endif
 
 #endif /* _LINUX_KERNEL_TRACE_H */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
