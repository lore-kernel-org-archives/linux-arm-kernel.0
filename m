From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 22 May 2013 16:03:17 +0200
Subject: [PATCH v3 6/6] pinctrl: exynos: Handle suspend/resume of GPIO EINT
 registers
In-Reply-To: <CAD=FV=VYhBP+V6SQt5SkFZszdVxSJ6AZk-C-zx1Di-RZBYhGvw@mail.gmail.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <4536937.hnhaYZLnaG@amdc1227>
 <CAD=FV=VYhBP+V6SQt5SkFZszdVxSJ6AZk-C-zx1Di-RZBYhGvw@mail.gmail.com>
Message-ID: <3059629.yu4Ei1BXhd@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some GPIO EINT control registers needs to be preserved across
suspend/resume cycle. This patch extends the driver to take care of
this.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---

Changes since v2:
 - Fixed error path
Changes since v1:
 - Added optional debugging messages
 - Added proper error path in initialization

 drivers/pinctrl/pinctrl-exynos.c | 116 ++++++++++++++++++++++++++++++++++++++-
 drivers/pinctrl/pinctrl-exynos.h |   1 +
 2 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index 4f868e5..2d76f66 100644
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
@@ -204,8 +210,8 @@ static int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
 {
 	struct samsung_pin_bank *bank;
 	struct device *dev = d->dev;
-	unsigned int ret;
-	unsigned int i;
+	int ret;
+	int i;
 
 	if (!d->irq) {
 		dev_err(dev, "irq number not available\n");
@@ -227,11 +233,29 @@ static int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
 				bank->nr_pins, &exynos_gpio_irqd_ops, bank);
 		if (!bank->irq_domain) {
 			dev_err(dev, "gpio irq domain add failed\n");
-			return -ENXIO;
+			ret = -ENXIO;
+			goto err_domains;
+		}
+
+		bank->soc_priv = devm_kzalloc(d->dev,
+			sizeof(struct exynos_eint_gpio_save), GFP_KERNEL);
+		if (!bank->soc_priv) {
+			irq_domain_remove(bank->irq_domain);
+			ret = -ENOMEM;
+			goto err_domains;
 		}
 	}
 
 	return 0;
+
+err_domains:
+	for (--i, --bank; i >= 0; --i, --bank) {
+		if (bank->eint_type != EINT_TYPE_GPIO)
+			continue;
+		irq_domain_remove(bank->irq_domain);
+	}
+
+	return ret;
 }
 
 static void exynos_wkup_irq_unmask(struct irq_data *irqd)
@@ -528,6 +552,72 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
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
+
+	pr_debug("%s: save     con %#010x\n", bank->name, save->eint_con);
+	pr_debug("%s: save fltcon0 %#010x\n", bank->name, save->eint_fltcon0);
+	pr_debug("%s: save fltcon1 %#010x\n", bank->name, save->eint_fltcon1);
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
+	pr_debug("%s:     con %#010x => %#010x\n", bank->name,
+			readl(regs + EXYNOS_GPIO_ECON_OFFSET
+			+ bank->eint_offset), save->eint_con);
+	pr_debug("%s: fltcon0 %#010x => %#010x\n", bank->name,
+			readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
+			+ 2 * bank->eint_offset), save->eint_fltcon0);
+	pr_debug("%s: fltcon1 %#010x => %#010x\n", bank->name,
+			readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
+			+ 2 * bank->eint_offset + 4), save->eint_fltcon1);
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
@@ -591,6 +681,8 @@ struct samsung_pin_ctrl exynos4210_pin_ctrl[] = {
 		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos4210-gpio-ctrl0",
 	}, {
 		/* pin-controller instance 1 data */
@@ -605,6 +697,8 @@ struct samsung_pin_ctrl exynos4210_pin_ctrl[] = {
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos4210-gpio-ctrl1",
 	}, {
 		/* pin-controller instance 2 data */
@@ -686,6 +780,8 @@ struct samsung_pin_ctrl exynos4x12_pin_ctrl[] = {
 		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos4x12-gpio-ctrl0",
 	}, {
 		/* pin-controller instance 1 data */
@@ -700,6 +796,8 @@ struct samsung_pin_ctrl exynos4x12_pin_ctrl[] = {
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos4x12-gpio-ctrl1",
 	}, {
 		/* pin-controller instance 2 data */
@@ -710,6 +808,8 @@ struct samsung_pin_ctrl exynos4x12_pin_ctrl[] = {
 		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos4x12-gpio-ctrl2",
 	}, {
 		/* pin-controller instance 3 data */
@@ -720,6 +820,8 @@ struct samsung_pin_ctrl exynos4x12_pin_ctrl[] = {
 		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos4x12-gpio-ctrl3",
 	},
 };
@@ -798,6 +900,8 @@ struct samsung_pin_ctrl exynos5250_pin_ctrl[] = {
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos5250-gpio-ctrl0",
 	}, {
 		/* pin-controller instance 1 data */
@@ -808,6 +912,8 @@ struct samsung_pin_ctrl exynos5250_pin_ctrl[] = {
 		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos5250-gpio-ctrl1",
 	}, {
 		/* pin-controller instance 2 data */
@@ -818,6 +924,8 @@ struct samsung_pin_ctrl exynos5250_pin_ctrl[] = {
 		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
 		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.label		= "exynos5250-gpio-ctrl2",
 	}, {
 		/* pin-controller instance 3 data */
@@ -828,6 +936,8 @@ struct samsung_pin_ctrl exynos5250_pin_ctrl[] = {
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
