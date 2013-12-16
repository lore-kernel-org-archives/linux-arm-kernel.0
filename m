From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Mon, 16 Dec 2013 21:24:15 +0100
Subject: [RFC PATCH 04/10] ARM: at91: enclose at91_aic_xx calls in
 IS_ENABLED(CONFIG_OLD_IRQ_AT91) blocks
In-Reply-To: <1387225461-6201-1-git-send-email-b.brezillon@overkiz.com>
References: <1387225461-6201-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1387225461-6201-5-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enclose at91_aic_xx calls in IS_ENABLED(CONFIG_OLD_IRQ_AT91) blocks in
order to prepare the migration to the new AIC driver.

In the new AIC driver the suspend/resume functions are called by the
generic irq framework and are no longer needed in the PM specific code.

Moreover, the new AIC driver no longer exposes the at91_aic_base variable
which is used by the at91_aic_read functions.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/mach-at91/pm.c    |   32 ++++++++++++++++++++------------
 arch/arm/mach-at91/setup.c |    3 ++-
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index d43b79f..1dc6ed3 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -207,16 +207,19 @@ static int at91_pm_enter(suspend_state_t state)
 		at91_pinctrl_gpio_suspend();
 	else
 		at91_gpio_suspend();
-	at91_irq_suspend();
 
-	pr_debug("AT91: PM - wake mask %08x, pm state %d\n",
-			/* remember all the always-wake irqs */
-			(at91_pmc_read(AT91_PMC_PCSR)
-					| (1 << AT91_ID_FIQ)
-					| (1 << AT91_ID_SYS)
-					| (at91_get_extern_irq()))
-				& at91_aic_read(AT91_AIC_IMR),
-			state);
+	if (IS_ENABLED(CONFIG_OLD_IRQ_AT91) && at91_aic_base) {
+		at91_irq_suspend();
+
+		pr_debug("AT91: PM - wake mask %08x, pm state %d\n",
+				/* remember all the always-wake irqs */
+				(at91_pmc_read(AT91_PMC_PCSR)
+						| (1 << AT91_ID_FIQ)
+						| (1 << AT91_ID_SYS)
+						| (at91_get_extern_irq()))
+					& at91_aic_read(AT91_AIC_IMR),
+				state);
+	}
 
 	switch (state) {
 		/*
@@ -281,12 +284,17 @@ static int at91_pm_enter(suspend_state_t state)
 			goto error;
 	}
 
-	pr_debug("AT91: PM - wakeup %08x\n",
-			at91_aic_read(AT91_AIC_IPR) & at91_aic_read(AT91_AIC_IMR));
+	if (IS_ENABLED(CONFIG_OLD_IRQ_AT91) && at91_aic_base)
+		pr_debug("AT91: PM - wakeup %08x\n",
+			 at91_aic_read(AT91_AIC_IPR) &
+			 at91_aic_read(AT91_AIC_IMR));
 
 error:
 	target_state = PM_SUSPEND_ON;
-	at91_irq_resume();
+
+	if (IS_ENABLED(CONFIG_OLD_IRQ_AT91) && at91_aic_base)
+		at91_irq_resume();
+
 	if (of_have_populated_dt())
 		at91_pinctrl_gpio_resume();
 	else
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 7d3f7cc..fa98176 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -49,7 +49,8 @@ void __init at91_init_irq_default(void)
 void __init at91_init_interrupts(unsigned int *priority)
 {
 	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority, at91_boot_soc.extern_irq);
+	if (IS_ENABLED(CONFIG_OLD_IRQ_AT91))
+		at91_aic_init(priority, at91_boot_soc.extern_irq);
 
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
-- 
1.7.9.5
