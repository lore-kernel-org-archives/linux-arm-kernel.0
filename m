From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 18 Nov 2015 00:16:50 +0300
Subject: [PATCH v6 10/19] arm64:ilp32 use the native LP64 'start_thread' for
 ILP32 threads
In-Reply-To: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1447795019-30176-11-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

If we have both ILP32 and AARCH32 compiled in, we need use the non compat start
thread for ILP32.

Reviewed-by: David Daney <ddaney@caviumnetworks.com>

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
---
 arch/arm64/include/asm/processor.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index a415dd0..e244cb4 100644
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
