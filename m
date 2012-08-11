From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 11 Aug 2012 12:04:37 +0100
Subject: [PATCH 7/7] ARM: virt: arch_timers: enable access to physical timers
In-Reply-To: <1344683077-12841-1-git-send-email-marc.zyngier@arm.com>
References: <1344683077-12841-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1344683077-12841-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If booting in HYP mode, it makes sense to enable the use of the
physical timers, so the kernel can use them directly.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/hyp-stub.S |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 4ff46fa..8c288ba 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -137,6 +137,19 @@ THUMB(	orr	r7, #(1 << 30)	)	@ HSCTLR.TE
 	mcr	p15, 4, r7, c1, c0, 0	@ HSCTLR
 	isb
 
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
1.7.8.6
