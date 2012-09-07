From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  7 Sep 2012 17:55:34 +0100
Subject: [PATCH v2 7/7] ARM: virt: arch_timers: enable access to physical
 timers
In-Reply-To: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1347036934-8519-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If booting in HYP mode, it makes sense to enable the use of the
physical timers, so the kernel can use them directly.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/hyp-stub.S | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 7060941..65b2417 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -142,6 +142,19 @@ THUMB(	orr	r7, #(1 << 30)	)	@ HSCTLR.TE
 	and	r7, #0x1f		@ Preserve HPMN
 	mcr	p15, 4, r7, c1, c1, 1	@ HDCR
 
+#if !defined(ZIMAGE) && defined(CONFIG_ARM_ARCH_TIMER)
+	@ make CNTP_* and CNTPCT accessible from PL1
+	mrc	p15, 0, r7, c0, c1, 1	@ ID_PFR1
+	lsr	r7, #16
+	and	r7, #0xf
+	cmp	r7, #1
+	bne	1f
+	mrc	p15, 4, r7, c14, c1, 0	@ CNTHCTL
+	orr	r7, r7, #3		@ PL1PCEN | PL1PCTEN
+	mcr	p15, 4, r7, c14, c1, 0	@ CNTHCTL
+1:
+#endif
+
 	bic	r7, r4, #MODE_MASK
 	orr	r7, r7, #SVC_MODE
 THUMB(	orr	r7, r7, #PSR_T_BIT	)
-- 
1.7.12
