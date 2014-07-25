From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 25 Jul 2014 16:05:29 -0400
Subject: [PATCH v2 1/5] tracing: Do not do anything special with
 tracepoint_string when tracing is disabled
In-Reply-To: <1406318733-26754-1-git-send-email-nicolas.pitre@linaro.org>
References: <1406318733-26754-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1406318733-26754-2-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steven Rostedt <rostedt@goodmis.org>

When CONFIG_TRACING is not enabled, there's no reason to save the trace
strings either by the linker or as a static variable that can be
referenced later. Simply pass back the string that is given to
tracepoint_string().

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 include/linux/ftrace_event.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/ftrace_event.h b/include/linux/ftrace_event.h
index cff3106ffe..b29636327d 100644
--- a/include/linux/ftrace_event.h
+++ b/include/linux/ftrace_event.h
@@ -574,6 +574,7 @@ do {									\
 		__trace_printk(ip, fmt, ##args);			\
 } while (0)
 
+#ifdef CONFIG_TRACING
 /**
  * tracepoint_string - register constant persistent string to trace system
  * @str - a constant persistent string that will be referenced in tracepoints
@@ -607,6 +608,15 @@ do {									\
 		___tp_str;						\
 	})
 #define __tracepoint_string	__attribute__((section("__tracepoint_str")))
+#else
+/*
+ * tracepoint_string() is used to save the string address for userspace
+ * tracing tools. When tracing isn't configured, there's no need to save
+ * anything.
+ */
+# define tracepoint_string(str) str
+# define __tracepoint_string
+#endif
 
 #ifdef CONFIG_PERF_EVENTS
 struct perf_event;
-- 
1.8.4.108.g55ea5f6
