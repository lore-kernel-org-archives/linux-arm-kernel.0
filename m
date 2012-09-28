From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 28 Sep 2012 16:28:43 +0200
Subject: [RFC PATCH 12/16] pinctrl: exynos: Set pin function to EINT in
 irq_set_type of wake-up EINT
In-Reply-To: <1348842527-22460-1-git-send-email-t.figa@samsung.com>
References: <1348842527-22460-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348842527-22460-13-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pins used as wake-up interrupts need to be configured as EINTs. This
patch adds the required configuration code to exynos_wkup_irq_set_type,
to set the pin as EINT when its interrupt trigger type is configured.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index 829c92c..001d2ec 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -257,6 +257,7 @@ static int exynos_wkup_irq_set_type(struct irq_data *irqd, unsigned int type)
 	unsigned long reg_con = d->ctrl->weint_con + bank->eint_offset;
 	unsigned long shift = EXYNOS_EINT_CON_LEN * pin;
 	unsigned long con, trig_type;
+	unsigned int mask;
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -288,6 +289,16 @@ static int exynos_wkup_irq_set_type(struct irq_data *irqd, unsigned int type)
 	con &= ~(EXYNOS_EINT_CON_MASK << shift);
 	con |= trig_type << shift;
 	writel(con, d->virt_base + reg_con);
+
+	reg_con = bank->pctl_offset;
+	shift = pin * bank->func_width;
+	mask = (1 << bank->func_width) - 1;
+
+	con = readl(d->virt_base + reg_con);
+	con &= ~(mask << shift);
+	con |= EXYNOS_EINT_FUNC << shift;
+	writel(con, d->virt_base + reg_con);
+
 	return 0;
 }
 
-- 
1.7.12
