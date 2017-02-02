From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  2 Feb 2017 15:45:15 +0100
Subject: [PATCH 05/13] ARM: at91: pm: use struct members directly
In-Reply-To: <20170202144523.11706-1-alexandre.belloni@free-electrons.com>
References: <20170202144523.11706-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170202144523.11706-6-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the pm_data struct members directly instead of caching them. This saves
a few load and store operations.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm_suspend.S | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index ed317657e760..3ee282c051e0 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -22,6 +22,7 @@
 pmc	.req	r0
 tmp1	.req	r4
 tmp2	.req	r5
+pm_data	.req	r9
 
 /*
  * Wait until master clock is ready (after switching master clock source)
@@ -87,26 +88,17 @@ ENTRY(at91_pm_suspend_in_sram)
 	mov	tmp1, #0
 	mcr	p15, 0, tmp1, c7, c10, 4
 
-	ldr	tmp1, [r0, #PM_DATA_PMC]
-	str	tmp1, .pmc_base
-	ldr	tmp1, [r0, #PM_DATA_RAMC0]
-	str	tmp1, .sramc_base
-	ldr	tmp1, [r0, #PM_DATA_RAMC1]
-	str	tmp1, .sramc1_base
-	ldr	tmp1, [r0, #PM_DATA_MEMCTRL]
-	str	tmp1, .memtype
-	ldr	tmp1, [r0, #PM_DATA_MODE]
-	str	tmp1, .pm_mode
+	mov	pm_data, r0
 
 	/* Active the self-refresh mode */
 	mov	r0, #SRAMC_SELF_FRESH_ACTIVE
 	bl	at91_sramc_self_refresh
 
-	ldr	r0, .pm_mode
+	ldr	r0, [pm_data, #PM_DATA_MODE]
 	tst	r0, #AT91_PM_SLOW_CLOCK
 	beq	skip_disable_main_clock
 
-	ldr	pmc, .pmc_base
+	ldr	pmc, [pm_data, #PM_DATA_PMC]
 
 	/* Save Master clock setting */
 	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
@@ -135,16 +127,16 @@ ENTRY(at91_pm_suspend_in_sram)
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
 
 skip_disable_main_clock:
-	ldr	pmc, .pmc_base
+	ldr	pmc, [pm_data, #PM_DATA_PMC]
 
 	/* Wait for interrupt */
 	at91_cpu_idle
 
-	ldr	r0, .pm_mode
+	ldr	r0, [pm_data, #PM_DATA_MODE]
 	tst	r0, #AT91_PM_SLOW_CLOCK
 	beq	skip_enable_main_clock
 
-	ldr	pmc, .pmc_base
+	ldr	pmc, [pm_data, #PM_DATA_PMC]
 
 	/* Turn on the main oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
@@ -195,8 +187,8 @@ ENDPROC(at91_pm_suspend_in_sram)
  */
 
 ENTRY(at91_sramc_self_refresh)
-	ldr	r1, .memtype
-	ldr	r2, .sramc_base
+	ldr	r1, [pm_data, #PM_DATA_MEMCTRL]
+	ldr	r2, [pm_data, #PM_DATA_RAMC0]
 
 	cmp	r1, #AT91_MEMCTRL_MC
 	bne	ddrc_sf
@@ -245,7 +237,7 @@ ddrc_sf:
 	str	r3, [r2, #AT91_DDRSDRC_LPR]
 
 	/* If using the 2nd ddr controller */
-	ldr	r2, .sramc1_base
+	ldr	r2, [pm_data, #PM_DATA_RAMC1]
 	cmp	r2, #0
 	beq	no_2nd_ddrc
 
@@ -277,7 +269,7 @@ ddrc_exit_sf:
 	str	r3, [r2, #AT91_DDRSDRC_LPR]
 
 	/* If using the 2nd ddr controller */
-	ldr	r2, .sramc1_base
+	ldr	r2, [pm_data, #PM_DATA_RAMC1]
 	cmp	r2, #0
 	ldrne	r3, .saved_sam9_mdr1
 	strne	r3, [r2, #AT91_DDRSDRC_MDR]
@@ -308,16 +300,6 @@ exit_sramc_sf:
 	mov	pc, lr
 ENDPROC(at91_sramc_self_refresh)
 
-.pmc_base:
-	.word 0
-.sramc_base:
-	.word 0
-.sramc1_base:
-	.word 0
-.memtype:
-	.word 0
-.pm_mode:
-	.word 0
 .saved_mckr:
 	.word 0
 .saved_pllar:
-- 
2.11.0
