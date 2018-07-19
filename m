From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 19 Jul 2018 18:00:49 +0200
Subject: [RFT 09/10] ARM: exynos: Remove legacy setting of external wakeup
 interrupts
In-Reply-To: <20180719160050.22566-1-krzk@kernel.org>
References: <20180719160050.22566-1-krzk@kernel.org>
Message-ID: <20180719160050.22566-10-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Exynos/S5Pv210 pin-controller driver is taking care about setting
the external wakeup interrupts mask, the legacy code can be removed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-exynos/common.h  |  2 --
 arch/arm/mach-exynos/suspend.c | 16 ++++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index dcd21bb95e3b..035e51c5f0fc 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -113,8 +113,6 @@ void exynos_firmware_init(void);
 void exynos_set_boot_flag(unsigned int cpu, unsigned int mode);
 void exynos_clear_boot_flag(unsigned int cpu, unsigned int mode);
 
-extern u32 exynos_get_eint_wake_mask(void);
-
 #ifdef CONFIG_PM_SLEEP
 extern void __init exynos_pm_init(void);
 #else
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 991938e19e17..554d6ea2cb3c 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -88,6 +88,11 @@ static const struct exynos_wkup_irq exynos5250_wkup_irq[] = {
 	{ /* sentinel */ },
 };
 
+static u32 exynos_read_eint_wakeup_mask(void)
+{
+	return pmu_raw_readl(EXYNOS_EINT_WAKEUP_MASK);
+}
+
 static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 {
 	const struct exynos_wkup_irq *wkup_irq;
@@ -271,8 +276,10 @@ static int exynos5420_cpu_suspend(unsigned long arg)
 
 static void exynos_pm_set_wakeup_mask(void)
 {
-	/* Set wake-up mask registers */
-	pmu_raw_writel(exynos_get_eint_wake_mask(), EXYNOS_EINT_WAKEUP_MASK);
+	/*
+	 * Set wake-up mask registers
+	 * EXYNOS_EINT_WAKEUP_MASK is set by pinctrl driver in late suspend.
+	 */
 	pmu_raw_writel(exynos_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
 }
 
@@ -482,6 +489,7 @@ static void exynos5420_pm_resume(void)
 
 static int exynos_suspend_enter(suspend_state_t state)
 {
+	u32 eint_wakeup_mask = exynos_read_eint_wakeup_mask();
 	int ret;
 
 	s3c_pm_debug_init();
@@ -489,10 +497,10 @@ static int exynos_suspend_enter(suspend_state_t state)
 	S3C_PMDBG("%s: suspending the system...\n", __func__);
 
 	S3C_PMDBG("%s: wakeup masks: %08x,%08x\n", __func__,
-			exynos_irqwake_intmask, exynos_get_eint_wake_mask());
+		  exynos_irqwake_intmask, eint_wakeup_mask);
 
 	if (exynos_irqwake_intmask == -1U
-	    && exynos_get_eint_wake_mask() == -1U) {
+	    && eint_wakeup_mask == EXYNOS_EINT_WAKEUP_MASK_DISABLED) {
 		pr_err("%s: No wake-up sources!\n", __func__);
 		pr_err("%s: Aborting sleep\n", __func__);
 		return -EINVAL;
-- 
2.14.1
