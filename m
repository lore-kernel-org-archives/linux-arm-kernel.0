From: credmonster@gmail.com (Chris Redmon)
Date: Wed, 12 Apr 2017 22:20:38 -0400
Subject: [PATCH 1/3] tracing: Introduce traces for major and minor page faults
In-Reply-To: <20170413022040.10156-1-credmonster@gmail.com>
References: <20170413022040.10156-1-credmonster@gmail.com>
Message-ID: <20170413022040.10156-2-credmonster@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tracing for major page faults is helpful especially for diagnosing
realtime latency issues (such as failure to mlock() something on a
realtime code path)

Signed-off-by: Chris Redmon <credmonster@gmail.com>
---
 include/trace/events/fault.h | 87 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 include/trace/events/fault.h

diff --git a/include/trace/events/fault.h b/include/trace/events/fault.h
new file mode 100644
index 000000000000..c4803f859750
--- /dev/null
+++ b/include/trace/events/fault.h
@@ -0,0 +1,87 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fault
+
+#if !defined(_TRACE_FAULT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_FAULT_H
+
+#include <asm/ptrace.h>
+#include <linux/tracepoint.h>
+#include <linux/types.h>
+
+/*
+ * Event class for major/minor page faults:
+ */
+DECLARE_EVENT_CLASS(fault_major_minor_class,
+
+	TP_PROTO(
+		unsigned long address, struct pt_regs *regs,
+		unsigned long status, ktime_t start_time,
+		unsigned int flags, unsigned int fault),
+
+	TP_ARGS(address, regs, status, start_time, flags, fault),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, address)
+		__field(unsigned long, instruction_pointer)
+		__field(unsigned long, status)
+		__field(unsigned int, duration)
+		__field(unsigned int, flags)
+		__field(unsigned int, fault)
+	),
+
+	TP_fast_assign(
+		__entry->address = address;
+		__entry->instruction_pointer = (regs ? instruction_pointer(regs) : 0);
+		__entry->status = (unsigned long) status;
+		__entry->duration = ktime_to_us(ktime_sub(ktime_get(), start_time));
+		__entry->flags = flags;
+		__entry->fault = fault;
+	),
+
+	TP_printk("address=%pf ip=%pf status=0x%lx duration=%uus flags=%s fault=%s",
+		(void *)__entry->address, (void *)__entry->instruction_pointer,
+		__entry->status,
+		__entry->duration,
+		__print_flags(__entry->flags, "|",
+			      {FAULT_FLAG_WRITE, "WRITE"},
+			      {FAULT_FLAG_MKWRITE, "MKWRITE"},
+			      {FAULT_FLAG_ALLOW_RETRY, "ALLOW_RETRY"},
+			      {FAULT_FLAG_RETRY_NOWAIT, "RETRY_NOWAIT"},
+			      {FAULT_FLAG_KILLABLE, "KILLABLE"},
+			      {FAULT_FLAG_TRIED, "TRIED"},
+			      {FAULT_FLAG_USER, "USER"}),
+		__print_flags(__entry->fault, "|",
+			      {VM_FAULT_OOM, "OOM"},
+			      {VM_FAULT_SIGBUS, "SIGBUS"},
+			      {VM_FAULT_MAJOR, "MAJOR"},
+			      {VM_FAULT_WRITE, "WRITE"},
+			      {VM_FAULT_HWPOISON, "HWPOISON"},
+			      {VM_FAULT_HWPOISON_LARGE, "HWPOISON_LARGE"},
+			      {VM_FAULT_NOPAGE, "NOPAGE"},
+			      {VM_FAULT_LOCKED, "LOCKED"},
+			      {VM_FAULT_RETRY, "RETRY"},
+			      {VM_FAULT_FALLBACK, "FALLBACK"})
+		)
+);
+
+#define DEFINE_PAGE_FAULT_MAJOR_MINOR_EVENT(name)			\
+DEFINE_EVENT(fault_major_minor_class, name,				\
+	TP_PROTO(unsigned long address,	struct pt_regs *regs,		\
+		  unsigned long status, ktime_t start_time,		\
+		  unsigned int flags, unsigned int fault),		\
+	TP_ARGS(address, regs, status, start_time, flags, fault));
+
+/*
+ * Tracepoint for major page faults:
+ */
+DEFINE_PAGE_FAULT_MAJOR_MINOR_EVENT(fault_major);
+
+/*
+ * Tracepoint for minor page faults:
+ */
+DEFINE_PAGE_FAULT_MAJOR_MINOR_EVENT(fault_minor);
+
+#endif /* _TRACE_FAULT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.12.2.599.gcf11a67
