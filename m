From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  8 Sep 2011 17:04:13 +0100
Subject: [PATCH v2 2/3] ARM: iwmmxt: Port problematic iwmmxt support code to
	v7/Thumb-2
In-Reply-To: <1315497854-13311-1-git-send-email-dave.martin@linaro.org>
References: <1315497854-13311-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1315497854-13311-3-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iwmmxt code contains some code to implement a pseudo-ISB, but
this is not buildable for Thumb-2.

This patch replaces the pseudo-ISB with a real one for Thumb-2
kernels.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/kernel/iwmmxt.S |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index a087838..7e049b0 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -319,8 +319,17 @@ ENTRY(iwmmxt_task_switch)
 	PJ4(eor r1, r1, #0xf)
 	PJ4(mcr	p15, 0, r1, c1, c0, 2)
 
+/*
+ * This should be ported to XSC()/PJ4() when everyone has new enough binutils
+ * to support the -march=...+iwmmxt command-line option syntax.
+ */
+#if __LINUX_ARM_ARCH__ < 7 || defined(IWMMXT_LEGACY_ASSEMBLER)
 	mrc	p15, 0, r1, c2, c0, 0
 	sub	pc, lr, r1, lsr #32		@ cpwait and return
+#else
+	isb					@ ISB needed instead on ARMv7
+	mov	pc, lr
+#endif
 
 /*
  * Remove Concan ownership of given task
-- 
1.7.4.1
