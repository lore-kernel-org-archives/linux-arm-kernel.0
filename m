From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 26 Jan 2015 15:54:40 +0100
Subject: [PATCH v2 2/2] pm: at91: pm_slowclock: remove clocks which are
 already stopped when entering slow clock mode
In-Reply-To: <1422284080-32446-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1422265068-22974-1-git-send-email-wenyou.yang@atmel.com>
 <1422284080-32446-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1422284080-32446-3-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assume USB PLL and PLL B are already stopped before entering sleep mode,
print a warning if this isn't the case.

Removed PLL B from slow clock code, all drivers are supposed to properly
unprepare clocks.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 arch/arm/mach-at91/pm.c           | 12 ++++++++++++
 arch/arm/mach-at91/pm_slowclock.S | 31 -------------------------------
 2 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 81f2f12..a561442 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -98,6 +98,18 @@ static int at91_pm_verify_clocks(void)
 		}
 	}
 
+	/* Drivers should have previously suspended USB PLL */
+	if (at91_pmc_read(AT91_CKGR_UCKR) & AT91_PMC_UPLLEN) {
+		pr_err("AT91: PM - Suspend-to-RAM with USB PLL running\n");
+		return 0;
+	}
+
+	/* Drivers should have previously suspended PLL B */
+	if (at91_pmc_read(AT91_PMC_SR) & AT91_PMC_LOCKB) {
+		pr_err("AT91: PM - Suspend-to-RAM with PLL B running\n");
+		return 0;
+	}
+
 	return 1;
 }
 
diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
index 79dfdbe..75d8b19 100644
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -68,15 +68,6 @@ tmp2	.req	r5
 	beq	1b
 	.endm
 
-/*
- * Wait until PLLB has locked.
- */
-	.macro wait_pllblock
-1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
-	tst	tmp1, #AT91_PMC_LOCKB
-	beq	1b
-	.endm
-
 	.text
 
 /* void at91_slow_clock(void __iomem *pmc, void __iomem *sdramc,
@@ -182,13 +173,6 @@ sdr_sr_done:
 	orr	tmp1, tmp1, #(1 << 29)		/* bit 29 always set */
 	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
 
-	/* Save PLLB setting and disable it */
-	ldr	tmp1, [pmc, #AT91_CKGR_PLLBR]
-	str	tmp1, .saved_pllbr
-
-	mov	tmp1, #AT91_PMC_PLLCOUNT
-	str	tmp1, [pmc, #AT91_CKGR_PLLBR]
-
 	/* Turn off the main oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
 	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
@@ -204,18 +188,6 @@ sdr_sr_done:
 
 	wait_moscrdy
 
-	/* Restore PLLB setting */
-	ldr	tmp1, .saved_pllbr
-	str	tmp1, [pmc, #AT91_CKGR_PLLBR]
-
-	tst	tmp1, #(AT91_PMC_MUL &  0xff0000)
-	bne	1f
-	tst	tmp1, #(AT91_PMC_MUL & ~0xff0000)
-	beq	2f
-1:
-	wait_pllblock
-2:
-
 	/* Restore PLLA setting */
 	ldr	tmp1, .saved_pllar
 	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
@@ -294,9 +266,6 @@ ram_restored:
 .saved_pllar:
 	.word 0
 
-.saved_pllbr:
-	.word 0
-
 .saved_sam9_lpr:
 	.word 0
 
-- 
2.1.4
