From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 17 May 2013 18:24:32 +0200
Subject: [PATCH 6/6] pinctrl: exynos: Handle suspend/resume of GPIO EINT
 registers
In-Reply-To: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
Message-ID: <1368807872-2601-7-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some GPIO EINT control registers needs to be preserved across
suspend/resume cycle. This patch extends the driver to take care of
this.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos.c | 83 ++++++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-exynos.h |  1 +
 2 files changed, 84 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index 4f868e5..908d24a 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -196,6 +196,12 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+struct exynos_eint_gpio_save {
+	u32 eint_con;
+	u32 eint_fltcon0;
+	u32 eint_fltcon1;
+};
+
 /*
  * exynos_eint_gpio_init() - setup handling of external gpio interrupts.
  * @d: driver data of samsung pinctrl driver.
@@ -229,6 +235,11 @@ static int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
 			dev_err(dev, "gpio irq domain add failed\n");
 			return -ENXIO;
 		}
+
+		bank->soc_priv = devm_kzalloc(d->dev,
+			sizeof(struct exynos_eint_gpio_save), GFP_KERNEL);
+		if (!bank->soc_priv)
+			return -ENOMEM;
 	}
 
 	return 0;
@@ -528,6 +539,58 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 	return 0;
 }
 
+static void exynos_pinctrl_suspend_bank(
+				struct samsung_pinctrl_drv_data *drvdata,
+				struct samsung_pin_bank *bank)
+{
+	struct exynos_eint_gpio_save *save = bank->soc_priv;
+	void __iomem *regs = drvdata->virt_base;
+
+	save->eint_con = readl(regs + EXYNOS_GPIO_ECON_OFFSET
+						+ bank->eint_offset);
+	save->eint_fltcon0 = readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
+						+ 2 * bank->eint_offset);
+	save->eint_fltcon1 = readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
+						+ 2 * bank->eint_offset + 4);
+}
+
+static void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
+{
+	struct samsung_pin_ctrl *ctrl = drvdata->ctrl;
+	struct samsung_pin_bank *bank = ctrl->pin_banks;
+	int i;
+
+	for (i = 0; i < ctrl->nr_banks; ++i, ++bank)
+		if (bank->eint_type == EINT_TYPE_GPIO)
+			exynos_pinctrl_suspend_bank(drvdata, bank);
+}
+
+static void exynos_pinctrl_resume_bank(
+				struct samsung_pinctrl_drv_data *drvdata,
+				struct samsung_pin_bank *bank)
+{
+	struct exynos_eint_gpio_save *save = bank->soc_priv;
+	void __iomem *regs = drvdata->virt_base;
+
+	writel(save->eint_con, regs + EXYNOS_GPIO_ECON_OFFSET
+						+ bank->eint_offset);
+	writel(save->eint_fltcon0, regs + EXYNOS_GPIO_EFLTCON_OFFSET
+						+ 2 * bank->eint_offset);
+	writel(save->eint_fltcon1, regs + EXYNOS_GPIO_EFLTCON_OFFSET
+						+ 2 * bank->eint_offset + 4);
+}
+
+static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
+{
+	struct samsung_pin_ctrl *ctrl = drvdata->ctrl;
+	struct samsung_pin_bank *bank = ctrl->pin_banks;
+	int i;
+
+	for (i = 0; i < ctrl->nr_banks; ++i, ++bank)
+		if (bank->eint_type == EINT_TYPE_GPIO)
+			exynos_pinctrl_resume_bank(drvdata, bank);
+}
+
 /* pin banks of exynos4210 pin-controller 0 */
 static struct samsung_pin_bank exynos4210_pin_banks0[] = {
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
@@ -591,6 +654,8 @@ struct samsung_pin_ctrl exynos4210_pin_ctrl[] = {
 		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos4210-gpio-ctrl0",
 	}, {
 		/* pin-controller instance 1 data */
@@ -605,6 +670,8 @@ struct samsung_pin_ctrl exynos4210_pin_ctrl[] = {
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos4210-gpio-ctrl1",
 	}, {
 		/* pin-controller instance 2 data */
@@ -686,6 +753,8 @@ struct samsung_pin_ctrl exynos4x12_pin_ctrl[] = {
 		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos4x12-gpio-ctrl0",
 	}, {
 		/* pin-controller instance 1 data */
@@ -700,6 +769,8 @@ struct samsung_pin_ctrl exynos4x12_pin_ctrl[] = {
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos4x12-gpio-ctrl1",
 	}, {
 		/* pin-controller instance 2 data */
@@ -710,6 +781,8 @@ struct samsung_pin_ctrl exynos4x12_pin_ctrl[] = {
 		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos4x12-gpio-ctrl2",
 	}, {
 		/* pin-controller instance 3 data */
@@ -720,6 +793,8 @@ struct samsung_pin_ctrl exynos4x12_pin_ctrl[] = {
 		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos4x12-gpio-ctrl3",
 	},
 };
@@ -798,6 +873,8 @@ struct samsung_pin_ctrl exynos5250_pin_ctrl[] = {
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos5250-gpio-ctrl0",
 	}, {
 		/* pin-controller instance 1 data */
@@ -808,6 +885,8 @@ struct samsung_pin_ctrl exynos5250_pin_ctrl[] = {
 		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos5250-gpio-ctrl1",
 	}, {
 		/* pin-controller instance 2 data */
@@ -818,6 +897,8 @@ struct samsung_pin_ctrl exynos5250_pin_ctrl[] = {
 		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos5250-gpio-ctrl2",
 	}, {
 		/* pin-controller instance 3 data */
@@ -828,6 +909,8 @@ struct samsung_pin_ctrl exynos5250_pin_ctrl[] = {
 		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos5250-gpio-ctrl3",
 	},
 };
diff --git a/drivers/pinctrl/pinctrl-exynos.h b/drivers/pinctrl/pinctrl-exynos.h
index 9b1f77a..3c91c35 100644
--- a/drivers/pinctrl/pinctrl-exynos.h
+++ b/drivers/pinctrl/pinctrl-exynos.h
@@ -19,6 +19,7 @@
 
 /* External GPIO and wakeup interrupt related definitions */
 #define EXYNOS_GPIO_ECON_OFFSET		0x700
+#define EXYNOS_GPIO_EFLTCON_OFFSET	0x800
 #define EXYNOS_GPIO_EMASK_OFFSET	0x900
 #define EXYNOS_GPIO_EPEND_OFFSET	0xA00
 #define EXYNOS_WKUP_ECON_OFFSET		0xE00
-- 
1.8.2.1
