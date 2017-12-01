From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri,  1 Dec 2017 14:44:47 +0100
Subject: [PATCH v4 06/10] pinctrl: axp209: add programmable ADC muxing value
In-Reply-To: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
References: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
Message-ID: <a4f348914450705f1f784a2148559e19caf9e9fd.1512135804.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare for patches that will add support for a new PMIC that has a
different GPIO adc muxing value, add an adc_mux within axp20x_pctl
structure and use it.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/pinctrl/pinctrl-axp209.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index 3fae81f..504e96c 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -49,6 +49,7 @@ struct axp20x_pctrl_desc {
 	/* Stores the pins supporting ADC function. Bit offset is pin number. */
 	u8				adc_mask;
 	u8				gpio_status_offset;
+	u8				adc_mux;
 };
 
 struct axp20x_pinctrl_function {
@@ -79,6 +80,7 @@ static const struct axp20x_pctrl_desc axp20x_data = {
 	.ldo_mask = BIT(0) | BIT(1),
 	.adc_mask = BIT(0) | BIT(1),
 	.gpio_status_offset = 4,
+	.adc_mux = AXP20X_MUX_ADC,
 };
 
 static int axp20x_gpio_get_reg(unsigned offset)
@@ -333,7 +335,7 @@ static void axp20x_build_funcs_groups(struct platform_device *pdev)
 	 * See comment in axp20x_pmx_set_mux.
 	 */
 	pctl->funcs[AXP20X_FUNC_ADC].name = "adc";
-	pctl->funcs[AXP20X_FUNC_ADC].muxval = AXP20X_MUX_ADC;
+	pctl->funcs[AXP20X_FUNC_ADC].muxval = pctl->desc->adc_mux;
 
 	/* Every pin supports GPIO_OUT and GPIO_IN functions */
 	for (i = 0; i <= AXP20X_FUNC_GPIO_IN; i++) {
-- 
git-series 0.9.1
