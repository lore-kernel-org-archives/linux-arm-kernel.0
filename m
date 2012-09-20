From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Sep 2012 10:51:39 +0200
Subject: [PATCH 1/6] pinctrl: exynos: Set pin function to EINT in irq_set_type
 of GPIO EINTa
In-Reply-To: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
References: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348131104-24828-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pins used as GPIO interrupts need to be configured as EINTs. This patch
adds the required configuration code to exynos_gpio_irq_set_type,
to set the pin as EINT when its interrupt trigger is configured.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos.c | 12 ++++++++++++
 drivers/pinctrl/pinctrl-exynos.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index 447818d..c2fa85f 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -76,9 +76,11 @@ static int exynos_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 	struct samsung_pinctrl_drv_data *d = irqd->domain->host_data;
 	struct samsung_pin_ctrl *ctrl = d->ctrl;
 	struct exynos_geint_data *edata = irq_data_get_irq_handler_data(irqd);
+	struct samsung_pin_bank *bank = edata->bank;
 	unsigned int shift = EXYNOS_EINT_CON_LEN * edata->pin;
 	unsigned int con, trig_type;
 	unsigned long reg_con = ctrl->geint_con + edata->eint_offset;
+	unsigned int mask;
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -110,6 +112,16 @@ static int exynos_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 	con &= ~(EXYNOS_EINT_CON_MASK << shift);
 	con |= trig_type << shift;
 	writel(con, d->virt_base + reg_con);
+
+	reg_con = bank->pctl_offset;
+	shift = edata->pin * bank->func_width;
+	mask = (1 << bank->func_width) - 1;
+
+	con = readl(d->virt_base + reg_con);
+	con &= ~(mask << shift);
+	con |= EXYNOS_EINT_FUNC << shift;
+	writel(con, d->virt_base + reg_con);
+
 	return 0;
 }
 
diff --git a/drivers/pinctrl/pinctrl-exynos.h b/drivers/pinctrl/pinctrl-exynos.h
index 5f27ba9..31d0a06 100644
--- a/drivers/pinctrl/pinctrl-exynos.h
+++ b/drivers/pinctrl/pinctrl-exynos.h
@@ -144,6 +144,7 @@ enum exynos4210_gpio_xc_start {
 #define EXYNOS_WKUP_EMASK_OFFSET	0xF00
 #define EXYNOS_WKUP_EPEND_OFFSET	0xF40
 #define EXYNOS_SVC_OFFSET		0xB08
+#define EXYNOS_EINT_FUNC		0xF
 
 /* helpers to access interrupt service register */
 #define EXYNOS_SVC_GROUP_SHIFT		3
-- 
1.7.12
