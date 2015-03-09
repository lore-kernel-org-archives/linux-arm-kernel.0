From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 9 Mar 2015 11:44:03 +0800
Subject: [PATCH v2.0 1/3] pm: at91: pm_slowclock: remove the unused code
 related with SLOWDOWN_MASTER_CLOCK
In-Reply-To: <1425872581-7570-1-git-send-email-wenyou.yang@atmel.com>
References: <1425872581-7570-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1425872643-7632-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SLOWDOWN_MASTER_CLOCK definition is not used, remove the redundant code.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm_slowclock.S |   37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
index 8ab80e5..ae86fca 100644
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -11,20 +11,11 @@
  * published by the Free Software Foundation.
  *
  */
-
 #include <linux/linkage.h>
 #include <linux/clk/at91_pmc.h>
 #include <mach/hardware.h>
 #include <mach/at91_ramc.h>
 
-/*
- * When SLOWDOWN_MASTER_CLOCK is defined we will also slow down the Master
- * clock during suspend by adjusting its prescalar and divisor.
- * NOTE: This hasn't been shown to be stable on SAM9s; and on the RM9200 there
- *       are errata regarding adjusting the prescalar and divisor.
- */
-#undef SLOWDOWN_MASTER_CLOCK
-
 pmc	.req	r0
 sdramc	.req	r1
 ramc1	.req	r2
@@ -175,18 +166,6 @@ sdr_sr_done:
 
 	wait_mckrdy
 
-#ifdef SLOWDOWN_MASTER_CLOCK
-	/*
-	 * Set the Master Clock PRES and MDIV fields.
-	 *
-	 * See AT91RM9200 errata #27 and #28 for details.
-	 */
-	mov	tmp1, #0
-	str	tmp1, [pmc, #AT91_PMC_MCKR]
-
-	wait_mckrdy
-#endif
-
 	/* Save PLLA setting and disable it */
 	ldr	tmp1, [pmc, #AT91_CKGR_PLLAR]
 	str	tmp1, .saved_pllar
@@ -243,22 +222,6 @@ sdr_sr_done:
 	wait_pllalock
 4:
 
-#ifdef SLOWDOWN_MASTER_CLOCK
-	/*
-	 * First set PRES if it was not 0,
-	 * than set CSS and MDIV fields.
-	 *
-	 * See AT91RM9200 errata #27 and #28 for details.
-	 */
-	ldr	tmp1, .saved_mckr
-	tst	tmp1, #AT91_PMC_PRES
-	beq	2f
-	and	tmp1, tmp1, #AT91_PMC_PRES
-	str	tmp1, [pmc, #AT91_PMC_MCKR]
-
-	wait_mckrdy
-#endif
-
 	/*
 	 * Restore master clock setting
 	 */
-- 
1.7.9.5
