From: apinski@cavium.com (Andrew Pinski)
Date: Sat, 24 May 2014 00:02:11 -0700
Subject: [PATCH 16/24] ARM64:ILP32 use the standard start_thread for ILP32 so
 the processor state is not AARCH32.
In-Reply-To: <1400914939-9708-1-git-send-email-apinski@cavium.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
Message-ID: <1400914939-9708-17-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we have both ILP32 and AARCH32 compiled in, we need use the non compat start thread for ILP32.  We have to use TIF_32BIT_AARCH64 explicit due to header depency issues.

Thanks,
Andrew Pinski

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/include/asm/processor.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index ee487f3..c61deaf 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -103,6 +103,15 @@ static inline void start_thread(struct pt_regs *regs, unsigned long pc,
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
1.7.2.5
