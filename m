From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Fri, 11 Oct 2013 17:52:15 +0530
Subject: [RFC PATCH 4/4] ARM64: Support for 32-bit big endian userspace
In-Reply-To: <1381494135-15085-1-git-send-email-ankit.jindal@linaro.org>
References: <1381494135-15085-1-git-send-email-ankit.jindal@linaro.org>
Message-ID: <1381494135-15085-5-git-send-email-ankit.jindal@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set PSTATE.E for compatible binaries when using 64-bit BE kernel

Signed-off-by: Ankit Jindal <ankit.jindal@linaro.org>
Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
---
 arch/arm64/include/asm/processor.h |    3 +++
 arch/arm64/kernel/signal32.c       |    4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index ab239b2..d72f5c0 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -107,6 +107,9 @@ static inline void compat_start_thread(struct pt_regs *regs, unsigned long pc,
 	regs->pstate = COMPAT_PSR_MODE_USR;
 	if (pc & 1)
 		regs->pstate |= COMPAT_PSR_T_BIT;
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	regs->pstate |= COMPAT_PSR_E_BIT;
+#endif
 	regs->compat_sp = sp;
 }
 #endif
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index e393174..8f5b72e 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -481,6 +481,10 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		spsr &= ~COMPAT_PSR_T_BIT;
 	}
 
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	spsr |= COMPAT_PSR_E_BIT;
+#endif
+
 	if (ka->sa.sa_flags & SA_RESTORER) {
 		retcode = ptr_to_compat(ka->sa.sa_restorer);
 	} else {
-- 
1.7.9.5
