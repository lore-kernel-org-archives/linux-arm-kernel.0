From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 30 Sep 2015 01:14:11 +0300
Subject: [PATCH v5 14/23] arm64:ilp32 use the native LP64 'start_thread' for
 ILP32 threads
In-Reply-To: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1443564860-31208-15-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

If we have both ILP32 and AARCH32 compiled in, we need use the non compat start
thread for ILP32.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index f1bba0c..d766f29 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -28,6 +28,7 @@
 #ifdef __KERNEL__
 
 #include <linux/string.h>
+#include <linux/thread_info.h>
 
 #include <asm/fpsimd.h>
 #include <asm/hw_breakpoint.h>
@@ -123,6 +124,15 @@ static inline void start_thread(struct pt_regs *regs, unsigned long pc,
 static inline void compat_start_thread(struct pt_regs *regs, unsigned long pc,
 				       unsigned long sp)
 {
+#ifdef CONFIG_ARM64_ILP32
+	/* ILP32 thread are started the same way as LP64 threads.
+	   Note we cannot use is_ilp32_compat_task here as that
+	   would introduce a header depency issue.  */
+	if (test_thread_flag(TIF_32BIT_AARCH64)) {
+		start_thread(regs, pc, sp);
+		return;
+	}
+#endif
 	start_thread_common(regs, pc);
 	regs->pstate = COMPAT_PSR_MODE_USR;
 	if (pc & 1)
-- 
2.1.4
