From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 15 Oct 2015 11:41:06 +0800
Subject: [PATCH 1/2] ARM: at91/pm: move enter sleep code to a procedure
In-Reply-To: <1444880467-18598-1-git-send-email-wenyou.yang@atmel.com>
References: <1444880467-18598-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1444880467-18598-2-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To make the code more legible and to prepare for the ULP1 support
in the future, move the Master clock, PLLA, MOR handling code and
the sleep code to a separate procedure.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 arch/arm/mach-at91/pm_suspend.S |  132 ++++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 0d95f48..825347b 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -105,77 +105,19 @@ ENTRY(at91_pm_suspend_in_sram)
 
 	ldr	r0, .pm_mode
 	tst	r0, #AT91_PM_SLOW_CLOCK
-	beq	skip_disable_main_clock
+	beq	standby_mode
 
-	ldr	pmc, .pmc_base
-
-	/* Save Master clock setting */
-	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
-	str	tmp1, .saved_mckr
+ulp0_mode:
+	bl	at91_pm_ulp0_mode
+	b	pm_exit
 
-	/*
-	 * Set the Master clock source to slow clock
-	 */
-	bic	tmp1, tmp1, #AT91_PMC_CSS
-	str	tmp1, [pmc, #AT91_PMC_MCKR]
-
-	wait_mckrdy
-
-	/* Save PLLA setting and disable it */
-	ldr	tmp1, [pmc, #AT91_CKGR_PLLAR]
-	str	tmp1, .saved_pllar
-
-	mov	tmp1, #AT91_PMC_PLLCOUNT
-	orr	tmp1, tmp1, #(1 << 29)		/* bit 29 always set */
-	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
-
-	/* Turn off the main oscillator */
-	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
-	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
-	orr	tmp1, tmp1, #AT91_PMC_KEY
-	str	tmp1, [pmc, #AT91_CKGR_MOR]
-
-skip_disable_main_clock:
+standby_mode:
 	ldr	pmc, .pmc_base
 
 	/* Wait for interrupt */
 	at91_cpu_idle
 
-	ldr	r0, .pm_mode
-	tst	r0, #AT91_PM_SLOW_CLOCK
-	beq	skip_enable_main_clock
-
-	ldr	pmc, .pmc_base
-
-	/* Turn on the main oscillator */
-	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
-	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
-	orr	tmp1, tmp1, #AT91_PMC_KEY
-	str	tmp1, [pmc, #AT91_CKGR_MOR]
-
-	wait_moscrdy
-
-	/* Restore PLLA setting */
-	ldr	tmp1, .saved_pllar
-	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
-
-	tst	tmp1, #(AT91_PMC_MUL &  0xff0000)
-	bne	3f
-	tst	tmp1, #(AT91_PMC_MUL & ~0xff0000)
-	beq	4f
-3:
-	wait_pllalock
-4:
-
-	/*
-	 * Restore master clock setting
-	 */
-	ldr	tmp1, .saved_mckr
-	str	tmp1, [pmc, #AT91_PMC_MCKR]
-
-	wait_mckrdy
-
-skip_enable_main_clock:
+pm_exit:
 	/* Exit the self-refresh mode */
 	mov	r0, #SRAMC_SELF_FRESH_EXIT
 	bl	at91_sramc_self_refresh
@@ -309,6 +251,68 @@ exit_sramc_sf:
 	mov	pc, lr
 ENDPROC(at91_sramc_self_refresh)
 
+/*
+ * void at91_pm_ulp0_mode(void)
+ */
+ENTRY(at91_pm_ulp0_mode)
+	ldr	pmc, .pmc_base
+
+	/* Save PMC_MCKR config */
+	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
+	str	tmp1, .saved_mckr
+
+	/* Switch master clock source to slow clock */
+	bic	tmp1, tmp1, #AT91_PMC_CSS
+	str	tmp1, [pmc, #AT91_PMC_MCKR]
+
+	wait_mckrdy
+
+	/* Save PLLA config, then and disable PLLA */
+	ldr	tmp1, [pmc, #AT91_CKGR_PLLAR]
+	str	tmp1, .saved_pllar
+
+	mov	tmp1, #AT91_PMC_PLLCOUNT
+	orr	tmp1, tmp1, #(1 << 29)
+	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
+
+	/* Turn off the main oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	/* Wait for interrupt */
+	at91_cpu_idle
+
+	/* Turn on the main oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	wait_moscrdy
+
+	/* Restore PLLA config */
+	ldr	tmp1, .saved_pllar
+	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
+
+	tst	tmp1, #(AT91_PMC_MUL &  0xff0000)
+	bne	1f
+	tst	tmp1, #(AT91_PMC_MUL & ~0xff0000)
+	beq	2f
+1:
+	wait_pllalock
+2:
+
+	/* Restore PMC_MCKR config */
+	ldr	tmp1, .saved_mckr
+	str	tmp1, [pmc, #AT91_PMC_MCKR]
+
+	wait_mckrdy
+
+	mov	pc, lr
+ENDPROC(at91_pm_ulp0_mode)
+
 .pmc_base:
 	.word 0
 .sramc_base:
-- 
1.7.9.5
