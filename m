From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Sun,  9 Sep 2018 01:57:07 +0530
Subject: [PATCH 6/6] dynamic_debug: Add flag for dynamic event tracing
In-Reply-To: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
Message-ID: <3f0166ff19ae44dbf92cbb239ebf25fa8a4f243c.1536430404.git.saiprakash.ranjan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Debugging a specific driver or subsystem can be a lot easier
if we can trace events specific to that driver or subsystem.
This type of filtering can be achieved using existing
dynamic debug library which provides a way to filter based
on files, functions and modules.

Using this, provide an additional flag 'e' to filter event
tracing to specified input.

For example, tracing all IO read/write can be overwhelming
and of no use when debugging a specific driver or a subsystem.
So switch to dynamic event tracing for register accesses.

Example for tracing register accesses in drivers/soc/qcom/*
and the pstore output is given below:

  # dyndbg="file drivers/soc/qcom/* +e" trace_event=io tp_pstore
  # reboot -f
  # mount -t pstore pstore /sys/fs/pstore
  # cat /sys/fs/pstore/event-ramoops-0
    io_write: type=writel cpu=1 ts:1423596253 data=0xffff00000d2065a4 caller=qcom_smsm_probe+0x524/0x670
    io_write: type=writel cpu=1 ts:1423945889 data=0xffff00000d206608 caller=qcom_smsm_probe+0x524/0x670

Note: Tracing is activated only when flag is enabled either
through command line or through dynamic debug control file.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 include/asm-generic/io-instrumented.h | 28 +++++++++++++++++++++++++--
 include/linux/dynamic_debug.h         |  1 +
 lib/dynamic_debug.c                   |  1 +
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/io-instrumented.h b/include/asm-generic/io-instrumented.h
index 7b050e2487ed..023f28571ea3 100644
--- a/include/asm-generic/io-instrumented.h
+++ b/include/asm-generic/io-instrumented.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_GENERIC_IO_INSTRUMENTED_H
 #define _ASM_GENERIC_IO_INSTRUMENTED_H
 
+#include <linux/dynamic_debug.h>
+
 #if defined(CONFIG_TRACING_EVENTS_IO)
 #include <linux/tracepoint-defs.h>
 
@@ -19,7 +21,7 @@ static inline void do_trace_io_read(const char *type, void *addr) {}
 #define __raw_write(v, a, _l)	({						\
 	volatile void __iomem *_a = (a);					\
 	if (io_tracepoint_active(__tracepoint_io_write))			\
-		do_trace_io_write(__stringify(write##_l), (void __force *)(_a));\
+		dynamic_io_write(__stringify(write##_l), (void __force *)(_a));	\
 	arch_raw_write##_l((v), _a);						\
 	})
 
@@ -32,7 +34,7 @@ static inline void do_trace_io_read(const char *type, void *addr) {}
 	_t __a;									\
 	const volatile void __iomem *_a = (a);					\
 	if (io_tracepoint_active(__tracepoint_io_read))				\
-		do_trace_io_read(__stringify(read##_l), (void __force *)(_a));	\
+		dynamic_io_read(__stringify(read##_l), (void __force *)(_a));	\
 	__a = arch_raw_read##_l(_a);						\
 	__a;									\
 	})
@@ -42,4 +44,26 @@ static inline void do_trace_io_read(const char *type, void *addr) {}
 #define __raw_readl(a)	__raw_read((a), l, u32)
 #define __raw_readq(a)	__raw_read((a), q, u64)
 
+#if defined(CONFIG_DYNAMIC_DEBUG) && defined(CONFIG_TRACING_EVENTS_IO)
+#define dynamic_io_write(type, addr)					\
+do {									\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, type);		\
+	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_EVENT))		\
+		do_trace_io_write(type, addr);				\
+} while (0)
+
+#define dynamic_io_read(type, addr)					\
+do {									\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, type);		\
+	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_EVENT))		\
+		do_trace_io_read(type, addr);				\
+} while (0)
+#elif defined(CONFIG_TRACING_EVENTS_IO)
+#define dynamic_io_write(type, addr)	do_trace_io_write(type, addr)
+#define dynamic_io_read(type, addr)	do_trace_io_read(type, addr)
+#else
+#define dynamic_io_write(type, addr)
+#define dynamic_io_read(type, addr)
+#endif /* CONFIG_DYNAMIC_DEBUG && CONFIG_TRACING_EVENTS_IO */
+
 #endif /* _ASM_GENERIC_IO_INSTRUMENTED_H */
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2fd8006153c3..14e595c51002 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -32,6 +32,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+#define _DPRINTK_FLAGS_EVENT		(1<<5)
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
 #else
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c7c96bc7654a..694957a8ae54 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -78,6 +78,7 @@ static inline const char *trim_prefix(const char *path)
 
 static struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_PRINT, 'p' },
+	{ _DPRINTK_FLAGS_EVENT, 'e' },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
 	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
