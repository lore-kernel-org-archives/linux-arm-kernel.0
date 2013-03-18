From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 18 Mar 2013 22:31:50 +0100
Subject: [PATCH 1/6] pinctrl: samsung: Protect bank registers with a spinlock
In-Reply-To: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
References: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1363642315-10331-2-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Certain pin control registers can be accessed from different contexts,
i.e. pinctrl, gpio and irq functions. This makes the locking provided by
pin control core insufficient.

This patch adds necessary locking using a per bank spinlock as it was
done in the old Samsung GPIO driver.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pinctrl/pinctrl-exynos.c  | 11 +++++++++++
 drivers/pinctrl/pinctrl-samsung.c | 24 ++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-samsung.h |  2 ++
 3 files changed, 37 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index 538b9dd..cf7700e 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -26,6 +26,7 @@
 #include <linux/of_irq.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/err.h>
 
 #include <asm/mach/irq.h>
@@ -81,6 +82,7 @@ static int exynos_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 	unsigned int shift = EXYNOS_EINT_CON_LEN * pin;
 	unsigned int con, trig_type;
 	unsigned long reg_con = ctrl->geint_con + bank->eint_offset;
+	unsigned long flags;
 	unsigned int mask;
 
 	switch (type) {
@@ -118,11 +120,15 @@ static int exynos_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 	shift = pin * bank->func_width;
 	mask = (1 << bank->func_width) - 1;
 
+	spin_lock_irqsave(&bank->slock, flags);
+
 	con = readl(d->virt_base + reg_con);
 	con &= ~(mask << shift);
 	con |= EXYNOS_EINT_FUNC << shift;
 	writel(con, d->virt_base + reg_con);
 
+	spin_unlock_irqrestore(&bank->slock, flags);
+
 	return 0;
 }
 
@@ -258,6 +264,7 @@ static int exynos_wkup_irq_set_type(struct irq_data *irqd, unsigned int type)
 	unsigned long reg_con = d->ctrl->weint_con + bank->eint_offset;
 	unsigned long shift = EXYNOS_EINT_CON_LEN * pin;
 	unsigned long con, trig_type;
+	unsigned long flags;
 	unsigned int mask;
 
 	switch (type) {
@@ -295,11 +302,15 @@ static int exynos_wkup_irq_set_type(struct irq_data *irqd, unsigned int type)
 	shift = pin * bank->func_width;
 	mask = (1 << bank->func_width) - 1;
 
+	spin_lock_irqsave(&bank->slock, flags);
+
 	con = readl(d->virt_base + reg_con);
 	con &= ~(mask << shift);
 	con |= EXYNOS_EINT_FUNC << shift;
 	writel(con, d->virt_base + reg_con);
 
+	spin_unlock_irqrestore(&bank->slock, flags);
+
 	return 0;
 }
 
diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index 3475b92..b1d4ac8 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -27,6 +27,7 @@
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/irqdomain.h>
+#include <linux/spinlock.h>
 
 #include "core.h"
 #include "pinctrl-samsung.h"
@@ -289,6 +290,7 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 	struct samsung_pin_bank *bank;
 	void __iomem *reg;
 	u32 mask, shift, data, pin_offset, cnt;
+	unsigned long flags;
 
 	drvdata = pinctrl_dev_get_drvdata(pctldev);
 	pins = drvdata->pin_groups[group].pins;
@@ -303,11 +305,15 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 		mask = (1 << bank->func_width) - 1;
 		shift = pin_offset * bank->func_width;
 
+		spin_lock_irqsave(&bank->slock, flags);
+
 		data = readl(reg);
 		data &= ~(mask << shift);
 		if (enable)
 			data |= drvdata->pin_groups[group].func << shift;
 		writel(data, reg);
+
+		spin_unlock_irqrestore(&bank->slock, flags);
 	}
 }
 
@@ -338,6 +344,7 @@ static int samsung_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 	struct samsung_pinctrl_drv_data *drvdata;
 	void __iomem *reg;
 	u32 data, pin_offset, mask, shift;
+	unsigned long flags;
 
 	bank = gc_to_pin_bank(range->gc);
 	drvdata = pinctrl_dev_get_drvdata(pctldev);
@@ -348,11 +355,16 @@ static int samsung_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 	mask = (1 << bank->func_width) - 1;
 	shift = pin_offset * bank->func_width;
 
+	spin_lock_irqsave(&bank->slock, flags);
+
 	data = readl(reg);
 	data &= ~(mask << shift);
 	if (!input)
 		data |= FUNC_OUTPUT << shift;
 	writel(data, reg);
+
+	spin_unlock_irqrestore(&bank->slock, flags);
+
 	return 0;
 }
 
@@ -376,6 +388,7 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 	enum pincfg_type cfg_type = PINCFG_UNPACK_TYPE(*config);
 	u32 data, width, pin_offset, mask, shift;
 	u32 cfg_value, cfg_reg;
+	unsigned long flags;
 
 	drvdata = pinctrl_dev_get_drvdata(pctldev);
 	pin_to_reg_bank(drvdata, pin - drvdata->ctrl->base, &reg_base,
@@ -406,6 +419,8 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 	if (!width)
 		return -EINVAL;
 
+	spin_lock_irqsave(&bank->slock, flags);
+
 	mask = (1 << width) - 1;
 	shift = pin_offset * width;
 	data = readl(reg_base + cfg_reg);
@@ -420,6 +435,9 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 		data &= mask;
 		*config = PINCFG_PACK(cfg_type, data);
 	}
+
+	spin_unlock_irqrestore(&bank->slock, flags);
+
 	return 0;
 }
 
@@ -479,16 +497,21 @@ static const struct pinconf_ops samsung_pinconf_ops = {
 static void samsung_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 {
 	struct samsung_pin_bank *bank = gc_to_pin_bank(gc);
+	unsigned long flags;
 	void __iomem *reg;
 	u32 data;
 
 	reg = bank->drvdata->virt_base + bank->pctl_offset;
 
+	spin_lock_irqsave(&bank->slock, flags);
+
 	data = readl(reg + DAT_REG);
 	data &= ~(1 << offset);
 	if (value)
 		data |= 1 << offset;
 	writel(data, reg + DAT_REG);
+
+	spin_unlock_irqrestore(&bank->slock, flags);
 }
 
 /* gpiolib gpio_get callback function */
@@ -859,6 +882,7 @@ static struct samsung_pin_ctrl *samsung_pinctrl_get_soc_data(
 
 	bank = ctrl->pin_banks;
 	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
+		spin_lock_init(&bank->slock);
 		bank->drvdata = d;
 		bank->pin_base = ctrl->nr_pins;
 		ctrl->nr_pins += bank->nr_pins;
diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index e2d4e67..b9dbe79 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -119,6 +119,7 @@ struct samsung_pinctrl_drv_data;
  * @irq_domain: IRQ domain of the bank.
  * @gpio_chip: GPIO chip of the bank.
  * @grange: linux gpio pin range supported by this bank.
+ * @slock: spinlock protecting bank registers
  */
 struct samsung_pin_bank {
 	u32		pctl_offset;
@@ -137,6 +138,7 @@ struct samsung_pin_bank {
 	struct irq_domain *irq_domain;
 	struct gpio_chip gpio_chip;
 	struct pinctrl_gpio_range grange;
+	spinlock_t slock;
 };
 
 /**
-- 
1.8.1.5
