From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Thu, 13 Sep 2012 17:25:35 +0530
Subject: [RFC] [PATCH 2/2] ARM: EXYNOS4: CPUIDLE: Add C2 state
In-Reply-To: <1347537335-26657-1-git-send-email-chander.kashyap@linaro.org>
References: <1347537335-26657-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1347537335-26657-3-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enter into c2 state:
1. ARM should be off
2. All local power domains should be off
3. All IPs belonging to TOP domain should not be in use

In this state TOP domain remains in retention state.

Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>
Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Cc: Kisoo Yu <ksoo.yu@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c |  373 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 364 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 5e489a7..7445088 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -23,8 +23,10 @@
 #include <asm/cpuidle.h>
 #include <mach/regs-pmu.h>
 #include <mach/pmu.h>
+#include <mach/regs-clock.h>
 
 #include <plat/cpu.h>
+#include <plat/pm.h>
 
 #define REG_DIRECTGO_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
 			S5P_INFORM7 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
@@ -33,7 +35,130 @@
 			S5P_INFORM6 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
 			(S5P_VA_SYSRAM + 0x20) : S5P_INFORM1))
 
-#define S5P_CHECK_AFTR		0xFCBA0D10
+/* IROM/u-boot checks on this for LP mode */
+#define S5P_CHECK_LPM		0xFCBA0D10
+
+/* Pad Retention Bit mask */
+#define WAKEUP_FROM_LOWPOWER	(0x1 << 28)
+
+/*
+ * Mask for IPs which needs to be checked before entering C2.
+ * These IPs do not fall under any local power domain.
+ */
+#define CLK_GATE_MDMA		(0x1 << 2)
+#define CLK_GATE_SMMUMDMA	(0x1 << 5)
+#define CLK_GATE_QEMDMA		(0x1 << 8)
+#define LPA_IP_IMAGE_MASK	(CLK_GATE_MDMA \
+				 | CLK_GATE_SMMUMDMA \
+				 | CLK_GATE_QEMDMA)
+
+#define CLK_GATE_PDMA0		(0x1 << 0)
+#define CLK_GATE_PDMA1		(0x1 << 1)
+#define CLK_GATE_TSI		(0x1 << 4)
+#define CLK_GATE_MMC		(0x1F << 5)
+#define CLK_GATE_ONENAND	(0x1 << 15)
+#define CLK_GATE_NFCON		(0x1 << 16)
+#define LPA_IP_FSYS_MASK	(CLK_GATE_PDMA0 \
+				 | CLK_GATE_PDMA1 \
+				 | CLK_GATE_TSI \
+				 | CLK_GATE_MMC \
+				 | CLK_GATE_ONENAND \
+				 | CLK_GATE_NFCON)
+
+#define CLK_GATE_I2C		(0xFF << 6)
+#define CLK_GATE_TSADC		(0x1 << 15)
+#define CLK_GATE_SPI		(0x7 << 16)
+#define CLK_GATE_I2S		(0x3 << 20)
+#define CLK_GATE_PCM		(0x3 << 22)
+#define CLK_GATE_SPDIF		(0x1 << 26)
+#define CLK_GATE_AC97		(0x1 << 27)
+#define LPA_IP_PERIL_MASK	(CLK_GATE_I2C \
+				 | CLK_GATE_TSADC \
+				 | CLK_GATE_SPI \
+				 | CLK_GATE_I2S \
+				 | CLK_GATE_PCM \
+				 | CLK_GATE_SPDIF \
+				 | CLK_GATE_AC97)
+
+#define CLK_GATE_WDT		(0x1 << 14)
+#define CLK_GATE_KEYIF		(0x1 << 16)
+#define LPA_IP_PERIR		(CLK_GATE_WDT | CLK_GATE_KEYIF)
+
+/* GPIO Offsets */
+#define GPIO_BANK_OFFSET	0x20
+#define GPIO_PUD_OFFSET		0x08
+#define GPIO_CON_PDN_OFFSET	0x10
+#define GPIO_PUD_PDN_OFFSET	0x14
+
+#define AFTR_MODE_INDEX		1
+#define LPA_MODE_INDEX		2
+
+/* Host Controller reg offsets */
+#define HCCONTROL_OFFSET	0x4
+#define USBSTS_OFFSET		0x14
+#define DSTS_OFFSET		0x808
+#define GOTGCTL_OFFSET		0
+
+static	void __iomem *gpio_base1, *gpio_base2, *gpio_base3,
+		*ehci_usbsts, *ohci_hccontrol, *usbd_dsts, *usbd_gotgctl;
+
+/* Save the current register values */
+static struct sleep_save exynos4_lpa_save[] = {
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_TOP),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_CAM),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_TV),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_LCD0),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_MAUDIO),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_FSYS),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_PERIL0),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_PERIL1),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_DMC),
+};
+
+static struct sleep_save exynos4210_lpa_save[] = {
+	SAVE_ITEM(EXYNOS4210_CLKSRC_MASK_LCD1),
+};
+
+/* Default register values, need to be initialized before entering C2 */
+static struct sleep_save exynos4_set_clksrc[] = {
+	{ .reg = EXYNOS4_CLKSRC_MASK_TOP	, .val = 0x00000001, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_CAM	, .val = 0x11111111, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_TV		, .val = 0x00000111, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_LCD0	, .val = 0x00001111, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_MAUDIO	, .val = 0x00000001, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_FSYS	, .val = 0x01011111, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_PERIL0	, .val = 0x01111111, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_PERIL1	, .val = 0x01110111, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_DMC	, .val = 0x00010000, },
+};
+
+static struct sleep_save exynos4210_set_clksrc[] = {
+	{ .reg = EXYNOS4210_CLKSRC_MASK_LCD1	, .val = 0x00001111, },
+};
+
+/* To check clock gating */
+static struct sleep_save exynos4_lpa_clkgate[] = {
+	{ .reg = EXYNOS4_CLKGATE_IP_FSYS	, .val = LPA_IP_FSYS_MASK, },
+	{ .reg = EXYNOS4_CLKGATE_IP_PERIL	, .val = LPA_IP_PERIL_MASK, },
+};
+
+static struct sleep_save exynos4210_lpa_clkgate[] = {
+	{ .reg = EXYNOS4210_CLKGATE_IP_IMAGE	, .val = LPA_IP_IMAGE_MASK, },
+	{ .reg = EXYNOS4210_CLKGATE_IP_PERIR	, .val = LPA_IP_PERIR, },
+};
+
+/* To check power gating */
+static struct sleep_save exynos4_lpa_pwrgate[] = {
+	{ .reg = S5P_PMU_LCD0_CONF	, .val = S5P_INT_LOCAL_PWR_EN, },
+	{ .reg = S5P_PMU_MFC_CONF	, .val = S5P_INT_LOCAL_PWR_EN, },
+	{ .reg = S5P_PMU_G3D_CONF	, .val = S5P_INT_LOCAL_PWR_EN, },
+	{ .reg = S5P_PMU_CAM_CONF	, .val = S5P_INT_LOCAL_PWR_EN, },
+	{ .reg = S5P_PMU_TV_CONF	, .val = S5P_INT_LOCAL_PWR_EN, },
+};
+
+static struct sleep_save exynos4210_lpa_pwrgate[] = {
+	{ .reg = S5P_PMU_LCD1_CONF	, .val = S5P_INT_LOCAL_PWR_EN, },
+};
 
 static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
@@ -49,6 +174,15 @@ static struct cpuidle_state exynos4_cpuidle_set[] __initdata = {
 		.name			= "C1",
 		.desc			= "ARM power down",
 	},
+	[2] = {
+		/* C2: CPU0 OFF, CPU1 OFF, Local PDs Off, Top Retention */
+		.enter			= exynos4_enter_lowpower,
+		.exit_latency		= 1500,
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "C2",
+		.desc			= "ARM power down TOP RET",
+	},
 };
 
 static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
@@ -59,12 +193,69 @@ static struct cpuidle_driver exynos4_idle_driver = {
 	.en_core_tk_irqen	= 1,
 };
 
-/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
+static void enable_gpio_retention(void __iomem *gpio_base,
+					unsigned int end)
+{
+	unsigned int val;
+
+	end += (unsigned int)gpio_base;
+
+	while ((unsigned int)gpio_base < end) {
+
+		/* Keep the previous state in C2 mode */
+		__raw_writel(0xFFFF, gpio_base + GPIO_CON_PDN_OFFSET);
+
+		/* Pull up-down state in C2 is same as normal */
+		val = __raw_readl(gpio_base + GPIO_PUD_OFFSET);
+		__raw_writel(val, gpio_base + GPIO_PUD_PDN_OFFSET);
+
+		gpio_base += GPIO_BANK_OFFSET;
+	}
+}
+
+static void exynos4_gpio_retention(void)
+{
+	enable_gpio_retention(gpio_base1, 0x200);
+	enable_gpio_retention(gpio_base2, 0x200);
+	enable_gpio_retention(gpio_base3, 0x20);
+}
+
+/* Check clock Gating: if all clocks gated, return 0, else return -1  */
+static int check_clock_gating(struct sleep_save *ptr, int count)
+{
+	for (; count > 0; count--, ptr++)
+		if (__raw_readl(ptr->reg) & ptr->val)
+			return -1;
+
+	return 0;
+}
+
+/*
+ * Check the local power domains:
+ * if all PDs power gated, return 0, else return -1
+ */
+static int check_power_gating(struct sleep_save *ptr, int count)
+{
+	for (; count > 0; count--, ptr++)
+		if ((__raw_readl(ptr->reg) & ptr->val) == S5P_INT_LOCAL_PWR_EN)
+			return -1;
+
+	return 0;
+}
+
+/*
+ * Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR.
+ * Enable all the possible wakeup sources for C2
+ */
 static void exynos4_set_wakeupmask(int index)
 {
-	unsigned long mask = __raw_readl(S5P_WAKEUP_MASK) & 0xFFF00000;
-	if (index == 1)
-		__raw_writel(mask | 0x0000ff3e, S5P_WAKEUP_MASK);
+	unsigned long mask = __raw_readl(S5P_WAKEUP_MASK) & 0xBFF00000;
+
+	if (index == AFTR_MODE_INDEX)
+		__raw_writel(mask | 0x0000FF3E, S5P_WAKEUP_MASK);
+	else
+		/* Bit 30: Edge/Level Interrupt trigger detection for PMU */
+		__raw_writel(mask | 0x400F0000, S5P_WAKEUP_MASK);
 }
 
 static unsigned int g_pwr_ctrl, g_diag_reg;
@@ -93,7 +284,17 @@ static int idle_finisher(unsigned long flags)
 	return 1;
 }
 
-static void exynos4_do_idle(int index, int pd_conf, int lp_mode_magic)
+static void activate_pads(void)
+{
+	__raw_writel(WAKEUP_FROM_LOWPOWER, S5P_PAD_RET_GPIO_OPTION);
+	__raw_writel(WAKEUP_FROM_LOWPOWER, S5P_PAD_RET_UART_OPTION);
+	__raw_writel(WAKEUP_FROM_LOWPOWER, S5P_PAD_RET_MMCA_OPTION);
+	__raw_writel(WAKEUP_FROM_LOWPOWER, S5P_PAD_RET_MMCB_OPTION);
+	__raw_writel(WAKEUP_FROM_LOWPOWER, S5P_PAD_RET_EBIA_OPTION);
+	__raw_writel(WAKEUP_FROM_LOWPOWER, S5P_PAD_RET_EBIB_OPTION);
+}
+
+static void exynos4_do_idle(int index, int pd_conf)
 {
 	unsigned long tmp;
 
@@ -103,7 +304,7 @@ static void exynos4_do_idle(int index, int pd_conf, int lp_mode_magic)
 	exynos_sys_powerdown_conf(pd_conf);
 
 	__raw_writel(virt_to_phys(s3c_cpu_resume), REG_DIRECTGO_ADDR);
-	__raw_writel(lp_mode_magic, REG_DIRECTGO_FLAG);
+	__raw_writel(S5P_CHECK_LPM, REG_DIRECTGO_FLAG);
 
 	save_cpu_arch_register();
 
@@ -142,10 +343,100 @@ static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
-	exynos4_do_idle(index, SYS_AFTR, S5P_CHECK_AFTR);
+	exynos4_do_idle(index, SYS_AFTR);
 	return index;
 }
 
+static int exynos4_enter_core0_lpa(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
+{
+	/* Put GPIOs in retention state */
+	exynos4_gpio_retention();
+
+	/*
+	 * Save the current contents of clock source registers and set them
+	 * to default values before entering Low Power mode.
+	 */
+	s3c_pm_do_save(exynos4_lpa_save, ARRAY_SIZE(exynos4_lpa_save));
+
+	if (soc_is_exynos4210()) {
+		s3c_pm_do_save(exynos4_lpa_save, ARRAY_SIZE(exynos4_lpa_save));
+		s3c_pm_do_restore_core(exynos4210_set_clksrc,
+					ARRAY_SIZE(exynos4210_set_clksrc));
+	}
+
+	s3c_pm_do_restore_core(exynos4_set_clksrc,
+				ARRAY_SIZE(exynos4_set_clksrc));
+
+	exynos4_do_idle(index, SYS_LPA);
+
+	/*Restore the register values with saved ones */
+	s3c_pm_do_restore_core(exynos4_lpa_save, ARRAY_SIZE(exynos4_lpa_save));
+
+	if (soc_is_exynos4210())
+		s3c_pm_do_restore_core(exynos4210_lpa_save,
+					ARRAY_SIZE(exynos4210_lpa_save));
+
+	/* Activate PADs from retention state */
+	activate_pads();
+
+	return index;
+}
+
+/*
+ * Returns:
+ * -1 if busy, 0 if in suspended state
+ */
+static int check_usb_state(void)
+{
+	unsigned int val = __raw_readl(EXYNOS4_CLKGATE_IP_FSYS);
+	/*
+	* Check usb for: Active/Suspended state using
+	* OHCI-HcControl[7:6]	Bus state = SUSPENDED = 0x3
+	*
+	* EHCI:	USBSTS[12]	Set when entire bus is in suspended state
+	*
+	* OTG: (Only Device mode is supported in Exynos4)
+	* GOTGCTL[19]		Set when Connected in Device Mode
+	* DSTS[0]		Set when in Suspended State
+	*/
+	if (val & (0x1 << 12)) {
+		if (!(((__raw_readl(ohci_hccontrol) >> 6) & 0x3) == 0x3)
+			|| !(__raw_readl(ehci_usbsts) & (0x1 << 12)))
+			return -1;
+	}
+
+	if (val & (0x1 << 13)) {
+		if ((__raw_readl(usbd_gotgctl) & (0x1 << 19))
+		&& !(__raw_readl(usbd_dsts) & 0x1))
+			return -1;
+	}
+
+	return 0;
+}
+
+/* Decides the suitable low power mode to enter */
+static int decide_lp_mode(void)
+{
+	if (check_power_gating(exynos4_lpa_pwrgate,
+				ARRAY_SIZE(exynos4_lpa_pwrgate))
+		|| (check_power_gating(exynos4210_lpa_pwrgate,
+					ARRAY_SIZE(exynos4_lpa_pwrgate))))
+		return AFTR_MODE_INDEX;
+
+	if (check_clock_gating(exynos4_lpa_clkgate,
+				ARRAY_SIZE(exynos4_lpa_clkgate))
+		|| (check_clock_gating(exynos4210_lpa_clkgate,
+					ARRAY_SIZE(exynos4_lpa_clkgate))))
+		return AFTR_MODE_INDEX;
+
+	if (check_usb_state())
+		return AFTR_MODE_INDEX;
+
+	return LPA_MODE_INDEX;
+}
+
 static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
@@ -158,8 +449,14 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 
 	if (new_index == 0)
 		return arm_cpuidle_simple_enter(dev, drv, new_index);
-	else
+
+	new_index = (index == AFTR_MODE_INDEX) ?
+			AFTR_MODE_INDEX : decide_lp_mode();
+
+	if (new_index == AFTR_MODE_INDEX)
 		return exynos4_enter_core0_aftr(dev, drv, new_index);
+	else
+		return exynos4_enter_core0_lpa(dev, drv, new_index);
 }
 
 static int __init exynos4_init_cpuidle(void)
@@ -195,6 +492,64 @@ static int __init exynos4_init_cpuidle(void)
 		}
 	}
 
+	gpio_base1 = ioremap(EXYNOS4_PA_GPIO1, SZ_4K);
+	if (gpio_base1 == NULL) {
+		pr_err("unable to ioremap for gpio_base1\n");
+		goto err_ioremap1;
+	}
+
+	gpio_base2 = ioremap(EXYNOS4_PA_GPIO2, SZ_4K);
+	if (gpio_base2 == NULL) {
+		pr_err("unable to ioremap for gpio_base1\n");
+		goto err_ioremap2;
+	}
+
+	gpio_base3 = ioremap(EXYNOS4_PA_GPIO3, SZ_256);
+	if (gpio_base3 == NULL) {
+		pr_err("unable to ioremap for gpio_base1\n");
+		goto err_ioremap3;
+	}
+
+	ohci_hccontrol = ioremap(EXYNOS4_PA_OHCI + HCCONTROL_OFFSET, SZ_4);
+	if (ohci_hccontrol == NULL) {
+		pr_err("unable to ioremap for ohci_hccontrol\n");
+		goto err_ohci;
+	}
+
+	ehci_usbsts = ioremap(EXYNOS4_PA_EHCI + USBSTS_OFFSET, SZ_4);
+	if (ehci_usbsts == NULL) {
+		pr_err("unable to ioremap for ehci_usbsts\n");
+		goto err_ehci;
+	}
+
+	usbd_dsts = ioremap(EXYNOS4_PA_HSOTG + DSTS_OFFSET, SZ_4);
+	if (usbd_dsts == NULL) {
+		pr_err("unable to ioremap for usbd_dsts\n");
+		goto err_usb_device;
+	}
+
+	usbd_gotgctl = ioremap(EXYNOS4_PA_HSOTG + GOTGCTL_OFFSET, SZ_4);
+	if (usbd_gotgctl == NULL) {
+		pr_err("unable to ioremap for usbd_gotgctl\n");
+		goto err_usbd_gotgctl;
+	}
 	return 0;
+
+err_usbd_gotgctl:
+	iounmap(usbd_dsts);
+err_usb_device:
+	iounmap(ehci_usbsts);
+err_ehci:
+	iounmap(ohci_hccontrol);
+err_ohci:
+	iounmap(gpio_base3);
+err_ioremap3:
+	iounmap(gpio_base2);
+err_ioremap2:
+	iounmap(gpio_base1);
+err_ioremap1:
+	cpuidle_unregister_driver(&exynos4_idle_driver);
+	cpuidle_unregister_device(device);
+	return -EIO;
 }
 device_initcall(exynos4_init_cpuidle);
-- 
1.7.9.5
