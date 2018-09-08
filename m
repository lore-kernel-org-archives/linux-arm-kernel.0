From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Sun,  9 Sep 2018 01:57:05 +0530
Subject: [PATCH 4/6] arm64/io: Add tracepoint for register accesses
In-Reply-To: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
Message-ID: <84677d700f0e894142bf3460292c695bb1a946e4.1536430404.git.saiprakash.ranjan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generic IO read/write i.e., __raw_{read,write}{b,l,w,q} are
typically used to read/write from/to memory mapped registers,
which can cause hangs or some undefined behaviour if access
unclocked. Tracing these register accesses can be very helpful
to debug such issues during initial development stages.
This can be used later for tracing arm IO register accesses.

Sample output format of register access trace is below:

  io_write: type=writel cpu=3 ts:1424714326 data=0xffff00000d1065a4 caller=qcom_smsm_probe+0x52c/0x678
  io_write: type=writel cpu=3 ts:1424962659 data=0xffff00000d106608 caller=qcom_smsm_probe+0x52c/0x678

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 arch/arm64/kernel/io.c         | 22 +++++++++++
 include/asm-generic/io-trace.h | 70 ++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 include/asm-generic/io-trace.h

diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
index 79b17384effa..a9db07f66477 100644
--- a/arch/arm64/kernel/io.c
+++ b/arch/arm64/kernel/io.c
@@ -19,6 +19,10 @@
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/io.h>
+#include <linux/sched/clock.h>
+
+#define CREATE_TRACE_POINTS
+#include <asm-generic/io-trace.h>
 
 /*
  * Copy data from IO memory space to "real" memory space.
@@ -106,3 +110,21 @@ void __memset_io(volatile void __iomem *dst, int c, size_t count)
 	}
 }
 EXPORT_SYMBOL(__memset_io);
+
+#if defined(CONFIG_TRACING_EVENTS_IO)
+void do_trace_io_write(const char *type, void *addr)
+{
+	trace_io_write(type, raw_smp_processor_id(), sched_clock(), addr,
+		       _RET_IP_);
+}
+EXPORT_SYMBOL(do_trace_io_write);
+EXPORT_TRACEPOINT_SYMBOL(io_write);
+
+void do_trace_io_read(const char *type, void *addr)
+{
+	trace_io_read(type, raw_smp_processor_id(), sched_clock(), addr,
+		      _RET_IP_);
+}
+EXPORT_SYMBOL(do_trace_io_read);
+EXPORT_TRACEPOINT_SYMBOL(io_read);
+#endif
diff --git a/include/asm-generic/io-trace.h b/include/asm-generic/io-trace.h
new file mode 100644
index 000000000000..e57b52d8976a
--- /dev/null
+++ b/include/asm-generic/io-trace.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM io
+
+#if !defined(CONFIG_TRACING_EVENTS_IO)
+#define NOTRACE
+#endif
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE io-trace
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH asm-generic
+
+#if !defined(_TRACE_IO_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_IO_H
+
+#include <linux/tracepoint.h>
+
+/*
+ * Tracepoint for generic IO read/write, i.e., __raw_{read,write}{b,l,w,q}()
+ */
+DECLARE_EVENT_CLASS(io_trace_class,
+
+	TP_PROTO(const char *type, int cpu, u64 ts, void *addr,
+		 unsigned long ret_ip),
+
+	TP_ARGS(type, cpu, ts, addr, ret_ip),
+
+	TP_STRUCT__entry(
+		__string(	type,		type	)
+		__field(	int,		cpu	)
+		__field(	u64,		ts	)
+		__field(	void *,		addr	)
+		__field(	unsigned long,	ret_ip	)
+	),
+
+	TP_fast_assign(
+		__assign_str(type, type);
+		__entry->cpu	= cpu;
+		__entry->ts	= ts;
+		__entry->addr	= addr;
+		__entry->ret_ip	= ret_ip;
+	),
+
+	TP_printk("type=%s cpu=%d ts:%llu data=0x%lx caller=%pS",
+		  __get_str(type), __entry->cpu, __entry->ts,
+		  (unsigned long)__entry->addr, (void *)__entry->ret_ip)
+);
+
+DEFINE_EVENT(io_trace_class, io_read,
+
+	TP_PROTO(const char *type, int cpu, u64 ts, void *addr,
+		 unsigned long ret_ip),
+
+	TP_ARGS(type, cpu, ts, addr, ret_ip)
+);
+
+DEFINE_EVENT(io_trace_class, io_write,
+
+	TP_PROTO(const char *type, int cpu, u64 ts, void *addr,
+		 unsigned long ret_ip),
+
+	TP_ARGS(type, cpu, ts, addr, ret_ip)
+);
+
+#endif /* _TRACE_IO_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
