From: biao.huang@mediatek.com (Biao Huang)
Date: Wed, 3 Feb 2016 09:24:46 +0800
Subject: [PATCH 2/2] pinctrl: mediatek: Add gpio_request_enable support
In-Reply-To: <1454462686-770-1-git-send-email-biao.huang@mediatek.com>
References: <1454462686-770-1-git-send-email-biao.huang@mediatek.com>
Message-ID: <1454462686-770-3-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the .gpio_request_enable() callbacks in struct pinmux_ops
in mediatek pinctrl driver. Make sure that when gpio_request is called,
GPIO on the pin is enabled.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 6eb01c9..cbc2204 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -43,6 +43,7 @@
 
 #define MAX_GPIO_MODE_PER_REG 5
 #define GPIO_MODE_BITS        3
+#define GPIO_MODE_PREFIX "GPIO"
 
 static const char * const mtk_gpio_functions[] = {
 	"func0", "func1", "func2", "func3",
@@ -735,12 +736,47 @@ static int mtk_pmx_set_mux(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int mtk_pmx_find_gpio_mode(struct mtk_pinctrl *pctl,
+				unsigned offset)
+{
+	const struct mtk_desc_pin *pin = pctl->devdata->pins + offset;
+	const struct mtk_desc_function *func = pin->functions;
+
+	while (func && func->name) {
+		if (!strncmp(func->name, GPIO_MODE_PREFIX,
+			sizeof(GPIO_MODE_PREFIX)-1))
+			return func->muxval;
+		func++;
+	}
+	return -EINVAL;
+}
+
+static int mtk_pmx_gpio_request_enable(struct pinctrl_dev *pctldev,
+				    struct pinctrl_gpio_range *range,
+				    unsigned offset)
+{
+	unsigned long muxval;
+	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	muxval = mtk_pmx_find_gpio_mode(pctl, offset);
+
+	if (muxval < 0) {
+		dev_err(pctl->dev, "invalid gpio pin %d.\n", offset);
+		return -EINVAL;
+	}
+
+	mtk_pmx_set_mode(pctldev, offset, muxval);
+
+	return 0;
+}
+
 static const struct pinmux_ops mtk_pmx_ops = {
 	.get_functions_count	= mtk_pmx_get_funcs_cnt,
 	.get_function_name	= mtk_pmx_get_func_name,
 	.get_function_groups	= mtk_pmx_get_func_groups,
 	.set_mux		= mtk_pmx_set_mux,
 	.gpio_set_direction	= mtk_pmx_gpio_set_direction,
+	.gpio_request_enable	= mtk_pmx_gpio_request_enable,
 };
 
 static int mtk_gpio_direction_input(struct gpio_chip *chip,
-- 
1.7.9.5
