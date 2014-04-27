From: larry.bassel@linaro.org (Larry Bassel)
Date: Sun, 27 Apr 2014 12:44:13 -0700
Subject: [PATCH 2/3] arm64: add support for context tracking
In-Reply-To: <1398627854-9617-1-git-send-email-larry.bassel@linaro.org>
References: <1398627854-9617-1-git-send-email-larry.bassel@linaro.org>
Message-ID: <1398627854-9617-3-git-send-email-larry.bassel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@linaro.org>

Add the macros and defines needed to implement
context tracking on arm64.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Larry Bassel <larry.bassel@linaro.org>
---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/kernel/entry.S            | 16 ++++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e6e4d37..152d92b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -55,6 +55,7 @@ config ARM64
 	select RTC_LIB
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
+	select HAVE_CONTEXT_TRACKING
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 720e70b..301ea6a 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -108,6 +108,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SINGLESTEP		21
 #define TIF_32BIT		22	/* 32bit process */
 #define TIF_SWITCH_MM		23	/* deferred switch_mm */
+#define TIF_NOHZ                24
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index eda7755..76b09d8 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -30,6 +30,22 @@
 #include <asm/unistd32.h>
 
 /*
+ * Context tracking subsystem.  Used to instrument transitions
+ * between user and kernel mode.
+ */
+	.macro ct_user_exit
+#ifdef CONFIG_CONTEXT_TRACKING
+	bl	context_tracking_user_exit
+#endif
+	.endm
+
+	.macro ct_user_enter
+#ifdef CONFIG_CONTEXT_TRACKING
+	bl	context_tracking_user_enter
+#endif
+	.endm
+
+/*
  * Bad Abort numbers
  *-----------------
  */
-- 
1.8.3.2
