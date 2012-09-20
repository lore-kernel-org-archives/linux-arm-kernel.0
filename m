From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Sep 2012 10:53:15 +0200
Subject: [RFC 4/6] pinctrl: samsung: Parse bank-specific eint offset from DT
In-Reply-To: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
References: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348131197-25506-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs, like Exynos4x12, have non-linear layout of EINT control
registers and so current way of calculating register addresses does not
work correctly for them.

This patch adds parsing of samsung,eint-offset property from bank nodes
and uses the read values instead of calculating the offsets from bank
index.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos.c  | 5 ++---
 drivers/pinctrl/pinctrl-samsung.c | 5 +++++
 drivers/pinctrl/pinctrl-samsung.h | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index 3cbc632..836ac36 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -146,7 +146,7 @@ static struct exynos_geint_data *exynos_get_eint_data(irq_hw_number_t hw,
 	struct samsung_pin_bank *bank = d->ctrl->pin_banks;
 	struct exynos_geint_data *eint_data;
 	unsigned int nr_banks = d->ctrl->nr_banks, idx;
-	unsigned int irq_base = 0, eint_offset = 0;
+	unsigned int irq_base = 0;
 
 	if (hw >= d->ctrl->nr_gint) {
 		dev_err(d->dev, "unsupported ext-gpio interrupt\n");
@@ -159,7 +159,6 @@ static struct exynos_geint_data *exynos_get_eint_data(irq_hw_number_t hw,
 		if ((hw >= irq_base) && (hw < (irq_base + bank->nr_pins)))
 			break;
 		irq_base += bank->nr_pins;
-		eint_offset += 4;
 	}
 
 	if (idx == nr_banks) {
@@ -175,7 +174,7 @@ static struct exynos_geint_data *exynos_get_eint_data(irq_hw_number_t hw,
 
 	eint_data->bank	= bank;
 	eint_data->pin = hw - irq_base;
-	eint_data->eint_offset = eint_offset;
+	eint_data->eint_offset = bank->eint_offset;
 	return eint_data;
 }
 
diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index ff1d001..03bf743 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -832,6 +832,11 @@ static int samsung_pinctrl_parse_dt_bank(struct samsung_pin_bank *bank,
 
 	bank->eint_type = EINT_TYPE_GPIO;
 
+	ret = of_property_read_u32(np, "samsung,eint-offset", &val);
+	if (ret)
+		return ret;
+	bank->eint_offset = val;
+
 	return 0;
 }
 
diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index db1907c..72303f1 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -122,6 +122,7 @@ struct samsung_pin_bank {
 	u8		conpdn_width;
 	u8		pudpdn_width;
 	enum eint_type	eint_type;
+	u32		eint_offset;
 	u32		irq_base;
 	const char	*name;
 };
-- 
1.7.12
