From: jonghwa3.lee@samsung.com (Jonghwa Lee)
Date: Fri, 26 Sep 2014 16:23:22 +0900
Subject: [PATCH 2/2] ARM: EXYNOS3250: Add initial support EXYNOS3250
 suspend/resume.
In-Reply-To: <1411716202-31644-1-git-send-email-jonghwa3.lee@samsung.com>
References: <1411716202-31644-1-git-send-email-jonghwa3.lee@samsung.com>
Message-ID: <1411716202-31644-3-git-send-email-jonghwa3.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds data and callback needed for exynos3250's suspend/resume.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 arch/arm/mach-exynos/regs-pmu.h |    4 ++++
 arch/arm/mach-exynos/suspend.c  |   31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 322f132..b5125dc1 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -131,6 +131,10 @@
 #define S5P_CORE_LOCAL_PWR_EN			0x3
 #define S5P_CORE_WAKEUP_FROM_LOCAL_CFG		(0x3 << 8)
 
+/* Only for EXYNOS3250 */
+#define	S5P_PAD_RET_MMCC_OPTION			0x30C8
+#define	S5P_PAD_RET_SPI_OPTION			0x31C8
+
 /* Only for EXYNOS4210 */
 #define S5P_CMU_CLKSTOP_LCD1_LOWPWR	0x1154
 #define S5P_CMU_RESET_LCD1_LOWPWR	0x1174
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index b41d146..de7d6d5 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -87,6 +87,12 @@ struct exynos_pm_data *pm_data;
 
 static u32 exynos_irqwake_intmask = 0xffffffff;
 
+static const struct exynos_wkup_irq exynos3250_wkup_irq[] = {
+	{ 105, BIT(1) }, /* RTC alarm */
+	{ 106, BIT(2) }, /* RTC tick */
+	{ /* sentinel */ },
+};
+
 static const struct exynos_wkup_irq exynos4_wkup_irq[] = {
 	{ 76, BIT(1) }, /* RTC alarm */
 	{ 77, BIT(2) }, /* RTC tick */
@@ -99,6 +105,19 @@ static const struct exynos_wkup_irq exynos5250_wkup_irq[] = {
 	{ /* sentinel */ },
 };
 
+unsigned int exynos3250_release_ret_regs[] = {
+	S5P_PAD_RET_MAUDIO_OPTION,
+	S5P_PAD_RET_GPIO_OPTION,
+	S5P_PAD_RET_UART_OPTION,
+	S5P_PAD_RET_MMCA_OPTION,
+	S5P_PAD_RET_MMCB_OPTION,
+	S5P_PAD_RET_MMCC_OPTION,
+	S5P_PAD_RET_EBIA_OPTION,
+	S5P_PAD_RET_EBIB_OPTION,
+	S5P_PAD_RET_SPI_OPTION,
+	REG_TABLE_END,
+};
+
 unsigned int exynos_release_ret_regs[] = {
 	S5P_PAD_RET_MAUDIO_OPTION,
 	S5P_PAD_RET_GPIO_OPTION,
@@ -288,6 +307,15 @@ static const struct platform_suspend_ops exynos_suspend_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
+static const struct exynos_pm_data exynos3250_pm_data = {
+	.wkup_irq	= exynos3250_wkup_irq,
+	.release_ret_regs = exynos3250_release_ret_regs,
+	.pm_suspend	= exynos_pm_suspend,
+	.pm_resume	= exynos_pm_resume,
+	.pm_prepare	= exynos_pm_prepare,
+	.cpu_suspend	= exynos_cpu_suspend,
+};
+
 static const struct exynos_pm_data exynos4_pm_data = {
 	.wkup_irq	= exynos4_wkup_irq,
 	.wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
@@ -314,6 +342,9 @@ static const struct exynos_pm_data exynos5250_pm_data = {
 
 static struct of_device_id exynos_pmu_of_device_ids[] = {
 	{
+		.compatible = "samsung,exynos3250-pmu",
+		.data = &exynos3250_pm_data,
+	}, {
 		.compatible = "samsung,exynos4210-pmu",
 		.data = &exynos4_pm_data,
 	}, {
-- 
1.7.9.5
