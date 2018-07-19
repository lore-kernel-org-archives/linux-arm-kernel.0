From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 19 Jul 2018 18:00:48 +0200
Subject: [RFT 08/10] ARM: s5pv210: Remove legacy setting of external wakeup
 interrupts
In-Reply-To: <20180719160050.22566-1-krzk@kernel.org>
References: <20180719160050.22566-1-krzk@kernel.org>
Message-ID: <20180719160050.22566-9-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Exynos/S5Pv210 pin-controller driver is taking care about setting
the external wakeup interrupts mask, the legacy code can be removed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s5pv210/common.h |  1 -
 arch/arm/mach-s5pv210/pm.c     | 16 ++++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s5pv210/common.h b/arch/arm/mach-s5pv210/common.h
index 0a188134deae..cb36058bc35e 100644
--- a/arch/arm/mach-s5pv210/common.h
+++ b/arch/arm/mach-s5pv210/common.h
@@ -10,7 +10,6 @@
 #define __ARCH_ARM_MACH_S5PV210_COMMON_H
 
 #ifdef CONFIG_PM_SLEEP
-u32 exynos_get_eint_wake_mask(void);
 void s5pv210_cpu_resume(void);
 void s5pv210_pm_init(void);
 #else
diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
index f491249ab658..b336df0c57f3 100644
--- a/arch/arm/mach-s5pv210/pm.c
+++ b/arch/arm/mach-s5pv210/pm.c
@@ -32,6 +32,11 @@ static struct sleep_save s5pv210_core_save[] = {
  */
 static u32 s5pv210_irqwake_intmask = 0xffffffff;
 
+static u32 s5pv210_read_eint_wakeup_mask(void)
+{
+	return __raw_readl(S5P_EINT_WAKEUP_MASK);
+}
+
 /*
  * Suspend helpers.
  */
@@ -59,8 +64,10 @@ static void s5pv210_pm_prepare(void)
 {
 	unsigned int tmp;
 
-	/* Set wake-up mask registers */
-	__raw_writel(exynos_get_eint_wake_mask(), S5P_EINT_WAKEUP_MASK);
+	/*
+	 * Set wake-up mask registers
+	 * S5P_EINT_WAKEUP_MASK is set by pinctrl driver in late suspend.
+	 */
 	__raw_writel(s5pv210_irqwake_intmask, S5P_WAKEUP_MASK);
 
 	/* ensure at least INFORM0 has the resume address */
@@ -89,6 +96,7 @@ static void s5pv210_pm_prepare(void)
  */
 static int s5pv210_suspend_enter(suspend_state_t state)
 {
+	u32 eint_wakeup_mask = s5pv210_read_eint_wakeup_mask();
 	int ret;
 
 	s3c_pm_debug_init();
@@ -96,10 +104,10 @@ static int s5pv210_suspend_enter(suspend_state_t state)
 	S3C_PMDBG("%s: suspending the system...\n", __func__);
 
 	S3C_PMDBG("%s: wakeup masks: %08x,%08x\n", __func__,
-			s5pv210_irqwake_intmask, exynos_get_eint_wake_mask());
+			s5pv210_irqwake_intmask, eint_wakeup_mask);
 
 	if (s5pv210_irqwake_intmask == -1U
-	    && exynos_get_eint_wake_mask() == -1U) {
+	    && eint_wakeup_mask == -1U) {
 		pr_err("%s: No wake-up sources!\n", __func__);
 		pr_err("%s: Aborting sleep\n", __func__);
 		return -EINVAL;
-- 
2.14.1
