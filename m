From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 06 Feb 2012 16:18:33 -0500
Subject: [PATCH][RFC] tracing/rcu: Add trace_##name##__rcuidle() static
 tracepoint for inside rcu_idle_exit() sections
In-Reply-To: <20120203194005.GK2382@linux.vnet.ibm.com>
References: <20120202174337.GS2518@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021257340.2759@xanadu.home>
 <20120202190708.GE2518@linux.vnet.ibm.com> <87obtgc1xx.fsf@ti.com>
 <4F2B1307.5010207@gmail.com>
 <1328223819.5882.133.camel@gandalf.stny.rr.com>
 <20120202232736.GL2518@linux.vnet.ibm.com>
 <1328237131.5882.135.camel@gandalf.stny.rr.com>
 <20120203060458.GF2380@linux.vnet.ibm.com>
 <1328295309.5882.178.camel@gandalf.stny.rr.com>
 <20120203194005.GK2382@linux.vnet.ibm.com>
Message-ID: <1328563113.2200.39.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As I have said, I may find a better solution than to create a
TRACE_EVENT_IDLE(), and I believe I have :-)

A added a new static inline function that lets *any* tracepoint be used
inside a rcu_idle_exit() section. And this also solves the problem where
the same tracepoint may be used inside a rcu_idle_exit() section as well
as outside of one.

I added a new tracepoint function with a "_rcuidle" extension. All
tracepoints can be used with either the normal "trace_foobar()"
function, or the "trace_foobar_rcuidle()" function when inside a
rcu_idle_exit() section.

Ideally, this patch would be broken up into two commits. The first would
change the tracepoint.h to introduce the new trace_foobar_rcuidle()
static inline, and the second patch would change the power tracepoints
to use this tracepoint function. For the RFC, I'm keeping it as a single
patch.

Another nice aspect about this patch is that "static inline"s are not
compiled into text when not used. So only the tracepoints that actually
use the _rcuidle() version will have them defined in the actual text
that is booted.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-trace.git/include/linux/tracepoint.h
===================================================================
--- linux-trace.git.orig/include/linux/tracepoint.h
+++ linux-trace.git/include/linux/tracepoint.h
@@ -114,7 +114,7 @@ static inline void tracepoint_synchroniz
  * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
  * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
  */
-#define __DO_TRACE(tp, proto, args, cond)				\
+#define __DO_TRACE(tp, proto, args, cond, pre, post)			\
 	do {								\
 		struct tracepoint_func *it_func_ptr;			\
 		void *it_func;						\
@@ -123,6 +123,7 @@ static inline void tracepoint_synchroniz
 		if (!(cond))						\
 			return;						\
 		rcu_read_lock_sched_notrace();				\
+		pre;							\
 		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
 		if (it_func_ptr) {					\
 			do {						\
@@ -132,6 +133,7 @@ static inline void tracepoint_synchroniz
 			} while ((++it_func_ptr)->func);		\
 		}							\
 		rcu_read_unlock_sched_notrace();			\
+		post;							\
 	} while (0)
 
 /*
@@ -139,7 +141,7 @@ static inline void tracepoint_synchroniz
  * not add unwanted padding between the beginning of the section and the
  * structure. Force alignment to the same alignment as the section start.
  */
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args)	\
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
 	extern struct tracepoint __tracepoint_##name;			\
 	static inline void trace_##name(proto)				\
 	{								\
@@ -147,7 +149,17 @@ static inline void tracepoint_synchroniz
 			__DO_TRACE(&__tracepoint_##name,		\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
-				TP_CONDITION(cond));			\
+				TP_CONDITION(cond),,);			\
+	}								\
+	static inline void trace_##name##_rcuidle(proto)		\
+	{								\
+		if (static_branch(&__tracepoint_##name.key))		\
+			__DO_TRACE(&__tracepoint_##name,		\
+				TP_PROTO(data_proto),			\
+				TP_ARGS(data_args),			\
+				TP_CONDITION(cond),			\
+				rcu_idle_exit(),			\
+				rcu_idle_enter());			\
 	}								\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto), void *data)	\
@@ -190,7 +202,7 @@ static inline void tracepoint_synchroniz
 	EXPORT_SYMBOL(__tracepoint_##name)
 
 #else /* !CONFIG_TRACEPOINTS */
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args)	\
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
 	static inline void trace_##name(proto)				\
 	{ }								\
 	static inline int						\
Index: linux-trace.git/arch/x86/kernel/process.c
===================================================================
--- linux-trace.git.orig/arch/x86/kernel/process.c
+++ linux-trace.git/arch/x86/kernel/process.c
@@ -377,8 +377,8 @@ static inline int hlt_use_halt(void)
 void default_idle(void)
 {
 	if (hlt_use_halt()) {
-		trace_power_start(POWER_CSTATE, 1, smp_processor_id());
-		trace_cpu_idle(1, smp_processor_id());
+		trace_power_start_rcuidle(POWER_CSTATE, 1, smp_processor_id());
+		trace_cpu_idle_rcuidle(1, smp_processor_id());
 		current_thread_info()->status &= ~TS_POLLING;
 		/*
 		 * TS_POLLING-cleared state must be visible before we
@@ -391,7 +391,7 @@ void default_idle(void)
 		else
 			local_irq_enable();
 		current_thread_info()->status |= TS_POLLING;
-		trace_power_end(smp_processor_id());
+		trace_power_end_rcuidle(smp_processor_id());
 		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 	} else {
 		local_irq_enable();
@@ -450,8 +450,8 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
 static void mwait_idle(void)
 {
 	if (!need_resched()) {
-		trace_power_start(POWER_CSTATE, 1, smp_processor_id());
-		trace_cpu_idle(1, smp_processor_id());
+		trace_power_start_rcuidle(POWER_CSTATE, 1, smp_processor_id());
+		trace_cpu_idle_rcuidle(1, smp_processor_id());
 		if (this_cpu_has(X86_FEATURE_CLFLUSH_MONITOR))
 			clflush((void *)&current_thread_info()->flags);
 
@@ -461,8 +461,8 @@ static void mwait_idle(void)
 			__sti_mwait(0, 0);
 		else
 			local_irq_enable();
-		trace_power_end(smp_processor_id());
-		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
+		trace_power_end_rcuidle(smp_processor_id());
+		trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 	} else
 		local_irq_enable();
 }
@@ -474,13 +474,13 @@ static void mwait_idle(void)
  */
 static void poll_idle(void)
 {
-	trace_power_start(POWER_CSTATE, 0, smp_processor_id());
-	trace_cpu_idle(0, smp_processor_id());
+	trace_power_start_rcuidle(POWER_CSTATE, 0, smp_processor_id());
+	trace_cpu_idle_rcuidle(0, smp_processor_id());
 	local_irq_enable();
 	while (!need_resched())
 		cpu_relax();
-	trace_power_end(smp_processor_id());
-	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
+	trace_power_end_rcuidle(smp_processor_id());
+	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 }
 
 /*
