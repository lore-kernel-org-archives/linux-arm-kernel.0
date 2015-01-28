From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 17:08:44 +0100
Subject: [PATCH] pinctrl: hide PCONFDUMP in #ifdef
Message-ID: <4217929.mzU2TuSLSj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zynq and qcom-spmi pinctrl drivers both use pin_config_item arrays
to provide extra interfaces in debugfs. This structure and the
PCONFDUMP macro are not defined if CONFIG_DEBUG_FS is turned off,
so we get build errors like:

pinctrl/qcom/pinctrl-spmi-gpio.c:139:37: error: array type has incomplete element type
 static const struct pin_config_item pmic_conf_items[ARRAY_SIZE(pmic_gpio_bindings)] = {
                                     ^
pinctrl/qcom/pinctrl-spmi-gpio.c:140:2: error: implicit declaration of function 'PCONFDUMP' [-Werror=implicit-function-declaration]
  PCONFDUMP(PMIC_GPIO_CONF_PULL_UP,  "pull up strength", NULL, true),
  ^
pinctrl/qcom/pinctrl-spmi-gpio.c:139:37: warning: 'pmic_conf_items' defined but not used [-Wunused-variable]
 static const struct pin_config_item pmic_conf_items[ARRAY_SIZE(pmic_gpio_bindings)] = {

Lacking any better idea to solve this nicely, this patch uses #ifdef
to hide the structures, just like the pinctrl core does.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index 8aa05e2eb705..36252df3c737 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -924,9 +924,11 @@ static const struct pinconf_generic_params zynq_dt_params[] = {
 	{"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
 };
 
+#ifdef CONFIG_DEBUG_FS
 static const struct pin_config_item zynq_conf_items[ARRAY_SIZE(zynq_dt_params)] = {
 	PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
 };
+#endif
 
 static unsigned int zynq_pinconf_iostd_get(u32 reg)
 {
@@ -1101,7 +1103,9 @@ static struct pinctrl_desc zynq_desc = {
 	.confops = &zynq_pinconf_ops,
 	.num_custom_params = ARRAY_SIZE(zynq_dt_params),
 	.custom_params = zynq_dt_params,
+#ifdef CONFIG_DEBUG_FS
 	.custom_conf_items = zynq_conf_items,
+#endif
 	.owner = THIS_MODULE,
 };
 
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index bbf99a715b63..0f11a26d932b 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -136,10 +136,12 @@ static const struct pinconf_generic_params pmic_gpio_bindings[] = {
 	{"qcom,drive-strength",		PMIC_GPIO_CONF_STRENGTH,	0},
 };
 
+#ifdef CONFIG_DEBUG_FS
 static const struct pin_config_item pmic_conf_items[ARRAY_SIZE(pmic_gpio_bindings)] = {
 	PCONFDUMP(PMIC_GPIO_CONF_PULL_UP,  "pull up strength", NULL, true),
 	PCONFDUMP(PMIC_GPIO_CONF_STRENGTH, "drive-strength", NULL, true),
 };
+#endif
 
 static const char *const pmic_gpio_groups[] = {
 	"gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7", "gpio8",
@@ -744,7 +746,9 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 	pctrldesc->npins = npins;
 	pctrldesc->num_custom_params = ARRAY_SIZE(pmic_gpio_bindings);
 	pctrldesc->custom_params = pmic_gpio_bindings;
+#ifdef CONFIG_DEBUG_FS
 	pctrldesc->custom_conf_items = pmic_conf_items;
+#endif
 
 	for (i = 0; i < npins; i++, pindesc++) {
 		pad = &pads[i];
