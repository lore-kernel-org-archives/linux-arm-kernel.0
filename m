From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 26 Jan 2015 15:54:39 +0100
Subject: [PATCH v2 1/2] pm: at91: pm_slowclock: fix suspend/resume hang up in
 timeouts
In-Reply-To: <1422284080-32446-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1422265068-22974-1-git-send-email-wenyou.yang@atmel.com>
 <1422284080-32446-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1422284080-32446-2-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed timeout on XTAL, PLL lock and Master Clock Ready, hang if
something went wrong instead of continuing in unknown condition. There
is not much we can do if a PLL lock never ends, we are running in SRAM
and we will not be able to connect back the sdram or ddram in order to
be able to fire up a message or just panic.

As a bonus, not decounting the timeout register in slow clock mode
reduce cumulated suspend time and resume time from ~17ms to ~15ms.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 arch/arm/mach-at91/pm_slowclock.S | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
index 2001877..79dfdbe 100644
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -34,11 +34,6 @@
  */
 #undef SLOWDOWN_MASTER_CLOCK
 
-#define MCKRDY_TIMEOUT		1000
-#define MOSCRDY_TIMEOUT 	1000
-#define PLLALOCK_TIMEOUT	1000
-#define PLLBLOCK_TIMEOUT	1000
-
 pmc	.req	r0
 sdramc	.req	r1
 ramc1	.req	r2
@@ -50,56 +45,36 @@ tmp2	.req	r5
  * Wait until master clock is ready (after switching master clock source)
  */
 	.macro wait_mckrdy
-	mov	tmp2, #MCKRDY_TIMEOUT
-1:	sub	tmp2, tmp2, #1
-	cmp	tmp2, #0
-	beq	2f
-	ldr	tmp1, [pmc, #AT91_PMC_SR]
+1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
 	tst	tmp1, #AT91_PMC_MCKRDY
 	beq	1b
-2:
 	.endm
 
 /*
  * Wait until master oscillator has stabilized.
  */
 	.macro wait_moscrdy
-	mov	tmp2, #MOSCRDY_TIMEOUT
-1:	sub	tmp2, tmp2, #1
-	cmp	tmp2, #0
-	beq	2f
-	ldr	tmp1, [pmc, #AT91_PMC_SR]
+1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
 	tst	tmp1, #AT91_PMC_MOSCS
 	beq	1b
-2:
 	.endm
 
 /*
  * Wait until PLLA has locked.
  */
 	.macro wait_pllalock
-	mov	tmp2, #PLLALOCK_TIMEOUT
-1:	sub	tmp2, tmp2, #1
-	cmp	tmp2, #0
-	beq	2f
-	ldr	tmp1, [pmc, #AT91_PMC_SR]
+1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
 	tst	tmp1, #AT91_PMC_LOCKA
 	beq	1b
-2:
 	.endm
 
 /*
  * Wait until PLLB has locked.
  */
 	.macro wait_pllblock
-	mov	tmp2, #PLLBLOCK_TIMEOUT
-1:	sub	tmp2, tmp2, #1
-	cmp	tmp2, #0
-	beq	2f
-	ldr	tmp1, [pmc, #AT91_PMC_SR]
+1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
 	tst	tmp1, #AT91_PMC_LOCKB
 	beq	1b
-2:
 	.endm
 
 	.text
-- 
2.1.4
