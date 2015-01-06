From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue,  6 Jan 2015 15:15:53 +0100
Subject: [PATCH] pm: at91: pm_slowclock: improve reliability of suspend/resume
In-Reply-To: <B256D81BAE5131468A838E5D7A243641BFCD1D0C@penmbx01>
References: <B256D81BAE5131468A838E5D7A243641BFCD1D0C@penmbx01>
Message-ID: <1420553753-13795-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assume USB PLL and PLL B are already stopped before entering sleep mode,
print a warning if this isn't the case.

Removed timeout on XTAL, PLL lock and Master Clock Ready, hang if
something went wrong instead of continuing in unknown condition. There
is not much we can do if a PLL lock never ends, we are running in SRAM
and we will not be able to connect back the sdram or ddram in order to
be able to fire up a message or just panic.

As a bonus, not decounting the timeout register in slow clock mode
reduce cumulated suspend time and resume time from ~17ms to ~15ms.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 arch/arm/mach-at91/pm.c           |  12 +++++
 arch/arm/mach-at91/pm_slowclock.S | 101 ++------------------------------------
 2 files changed, 16 insertions(+), 97 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index d213a00..3b0d804 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -168,6 +168,18 @@ static int at91_pm_verify_clocks(void)
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
 #endif
diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
index 6194749..530b996 100644
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -33,12 +33,6 @@
  */
 #undef SLOWDOWN_MASTER_CLOCK
 
-#define MCKRDY_TIMEOUT		1000
-#define MOSCRDY_TIMEOUT 	1000
-#define PLLALOCK_TIMEOUT	1000
-#define PLLBLOCK_TIMEOUT	1000
-#define UPLLLOCK_TIMEOUT	1000
-
 pmc	.req	r0
 sdramc	.req	r1
 ramc1	.req	r2
@@ -46,76 +40,32 @@ memctrl	.req	r3
 tmp1	.req	r4
 tmp2	.req	r5
 ddrcid	.req	r6
-flag	.req	r7
 
 /*
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
-	.endm
-
-/*
- * Wait until PLLB has locked.
- */
-	.macro wait_pllblock
-	mov	tmp2, #PLLBLOCK_TIMEOUT
-1:	sub	tmp2, tmp2, #1
-	cmp	tmp2, #0
-	beq	2f
-	ldr	tmp1, [pmc, #AT91_PMC_SR]
-	tst	tmp1, #AT91_PMC_LOCKB
-	beq	1b
-2:
-	.endm
-
-/*
- * Wait until UTMI PLL has locked.
- */
-	.macro wait_uplllock
-	mov	tmp2, #UPLLLOCK_TIMEOUT
-1:	sub	tmp2, tmp2, #1
-	cmp	tmp2, #0
-	beq	2f
-	ldr	tmp1, [pmc, #AT91_PMC_SR]
-	tst	tmp1, #AT91_PMC_LOCKU
-	beq	1b
-2:
 	.endm
 
 /*
@@ -126,6 +76,7 @@ flag	.req	r7
 #if defined(CONFIG_CPU_V7)
 	dsb
 
+	/* Disable the processor clock */
 	mov	tmp1, #AT91_PMC_PCK
 	str	tmp1, [pmc, #AT91_PMC_SCDR]
 
@@ -234,25 +185,6 @@ sdr_sr_done:
 	mov 	tmp1, #AT91_PMC_SYS_DDR
 	str	tmp1, [pmc, #AT91_PMC_SCDR]
 
-	/* Save PLLB setting and disable it */
-	ldr	tmp1, [pmc, #AT91_CKGR_PLLBR]
-	str	tmp1, .saved_pllbr
-
-	mov	tmp1, #AT91_PMC_PLLCOUNT
-	str	tmp1, [pmc, #AT91_CKGR_PLLBR]
-
-	/* Disable UTMI PLL */
-	ldr	tmp1, [pmc, #AT91_CKGR_UCKR]
-	tst	tmp1, #AT91_PMC_UPLLEN
-	beq	1f
-	mov	flag, #1
-	bic	tmp1, tmp1, #AT91_PMC_UPLLEN
-	str	tmp1, [pmc, #AT91_CKGR_UCKR]
-	b	2f
-1:
-	mov	flag, #0
-2:
-
 	/* Save Master clock setting */
 	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
 	str	tmp1, .saved_mckr
@@ -338,28 +270,6 @@ sdr_sr_done:
 
 	wait_mckrdy
 
-	/* Turn on UTMI PLL */
-	cmp	flag, #1
-	bne	1f
-	ldr	tmp1, [pmc, #AT91_CKGR_UCKR]
-	orr	tmp1, tmp1, #AT91_PMC_UPLLEN
-	str	tmp1, [pmc, #AT91_CKGR_UCKR]
-
-	wait_uplllock
-1:
-
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
 	/* Enable MPDDRC Clock*/
 	cmp	ddrcid, #0
 	beq	4f
@@ -421,9 +331,6 @@ ram_restored:
 .saved_pllar:
 	.word 0
 
-.saved_pllbr:
-	.word 0
-
 .saved_sam9_lpr:
 	.word 0
 
-- 
2.1.4
