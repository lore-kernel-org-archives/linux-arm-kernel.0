From: yanjiang.jin@windriver.com (yanjiang.jin at windriver.com)
Date: Tue, 2 May 2017 17:47:18 +0800
Subject: [PATCH] arm: proc-v7-3level.S: SOC_LS1021A: clear TTBCR.T1SZ
In-Reply-To: <20170502094718.188172-1-yanjiang.jin@windriver.com>
References: <20170502094718.188172-1-yanjiang.jin@windriver.com>
Message-ID: <20170502094718.188172-2-yanjiang.jin@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yanjiang Jin <yanjiang.jin@windriver.com>

The macro "v7_ttb_setup" will set "TTBCR.T1SZ" only when
"PHYS_OFFSET <= PAGE_OFFSET".
But if we load the second kernel during kdump boot, PHYS_OFFSET may be
greater than PAGE_OFFSET, we don't want to set this bit, but TTBCR.T1SZ
is still not zero since the first kernel's value is reserved.
In this circumstance, the second kernel would hang once the MMU is enabled.

Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
---
 arch/arm/mm/proc-v7-3level.S | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index 5e5720e..b6ca5eb 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -140,12 +140,16 @@ ENDPROC(cpu_v7_set_pte_ext)
 	 * otherwise booting secondary CPUs would end up using TTBR1 for the
 	 * identity mapping set up in TTBR0.
 	 */
-	orrls	\tmp, \tmp, #TTBR1_SIZE				@ TTBCR.T1SZ
-	mcr	p15, 0, \tmp, c2, c0, 2				@ TTBCR
+
+#ifdef CONFIG_SOC_LS1021A
+	bic	\tmp, \tmp, #TTBR1_SIZE		@ clear TTBCR.T1SZ first
+#endif
+	orrls	\tmp, \tmp, #TTBR1_SIZE		@ TTBCR.T1SZ
+	mcr	p15, 0, \tmp, c2, c0, 2		@ TTBCR
 	mov	\tmp, \ttbr1, lsr #20
 	mov	\ttbr1, \ttbr1, lsl #12
 	addls	\ttbr1, \ttbr1, #TTBR1_OFFSET
-	mcrr	p15, 1, \ttbr1, \tmp, c2			@ load TTBR1
+	mcrr	p15, 1, \ttbr1, \tmp, c2	@ load TTBR1
 	.endm
 
 	/*
-- 
1.9.1
