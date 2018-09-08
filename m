From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Sat, 8 Sep 2018 19:07:38 +0800
Subject: [PATCH v2 22/22] pinctrl: mediatek: add eint support to MT8183
 pinctrl driver
In-Reply-To: <cover.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
Message-ID: <17745498577a9d4492deee861d71a135de5b8473.1536404280.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Just add eint support to MT8183 pinctrl driver as usual as
happens on the other SoCs.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8183.c |  8 ++++++++
 drivers/pinctrl/mediatek/pinctrl-paris.c  | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
index 9d5aa27..6262fd3 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
@@ -492,11 +492,19 @@ static const char * const mt8183_pinctrl_register_base_names[] = {
 	"iocfg6", "iocfg7", "iocfg8",
 };
 
+static const struct mtk_eint_hw mt8183_eint_hw = {
+	.port_mask = 7,
+	.ports     = 6,
+	.ap_num    = 212,
+	.db_cnt    = 13,
+};
+
 static const struct mtk_pin_soc mt8183_data = {
 	.reg_cal = mt8183_reg_cals,
 	.pins = mtk_pins_mt8183,
 	.npins = ARRAY_SIZE(mtk_pins_mt8183),
 	.ngrps = ARRAY_SIZE(mtk_pins_mt8183),
+	.eint_hw = &mt8183_eint_hw,
 	.gpio_m = 0,
 	.ies_present = true,
 	.base_names = mt8183_pinctrl_register_base_names,
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 50d6893..9f4224f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -718,6 +718,22 @@ static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
 	return pinctrl_gpio_direction_output(chip->base + gpio);
 }
 
+static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
+	const struct mtk_pin_desc *desc;
+
+	if (!hw->eint)
+		return -ENOTSUPP;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[offset];
+
+	if (desc->eint.eint_n == EINT_NA)
+		return -ENOTSUPP;
+
+	return mtk_eint_find_irq(hw->eint, desc->eint.eint_n);
+}
+
 static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 			       unsigned long config)
 {
@@ -751,6 +767,7 @@ static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
 	chip->direction_output	= mtk_gpio_direction_output;
 	chip->get		= mtk_gpio_get;
 	chip->set		= mtk_gpio_set;
+	chip->to_irq		= mtk_gpio_to_irq,
 	chip->set_config	= mtk_gpio_set_config,
 	chip->base		= -1;
 	chip->ngpio		= hw->soc->npins;
@@ -871,6 +888,11 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev,
 	if (err)
 		return err;
 
+	err = mtk_build_eint(hw, pdev);
+	if (err)
+		dev_warn(&pdev->dev,
+			 "Failed to add EINT, but pinctrl still can work\n");
+
 	/* Build gpiochip should be after pinctrl_enable is done */
 	err = mtk_build_gpiochip(hw, pdev->dev.of_node);
 	if (err) {
-- 
2.7.4
