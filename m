From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 28 Nov 2014 17:49:26 +0100
Subject: [PATCH 1/2] pinctrl: at91: allow disabled gpio controllers
Message-ID: <1417193367-12422-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows to have gpio controller with status set to disabled.

gpio_banks represents all the gpio banks available on the device whereas
nbanks represents the gpio banks used. Having a disabled gpio controller
involves that nbanks value is lower than gpio_banks and that some
pointers in the gpio_chips array are NULL. This patch deals with these
specific cases.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

Hi,

Without this patch, pinctrl is broken on sama5d4 because pinctrl-at91 doesn't
support unused gpio bank.


 drivers/pinctrl/pinctrl-at91.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 94643bb..95ae122 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -981,7 +981,8 @@ static void at91_pinctrl_child_count(struct at91_pinctrl *info,
 
 	for_each_child_of_node(np, child) {
 		if (of_device_is_compatible(child, gpio_compat)) {
-			info->nbanks++;
+			if (of_device_is_available(child))
+				info->nbanks++;
 		} else {
 			info->nfunctions++;
 			info->ngroups += of_get_child_count(child);
@@ -1003,11 +1004,11 @@ static int at91_pinctrl_mux_mask(struct at91_pinctrl *info,
 	}
 
 	size /= sizeof(*list);
-	if (!size || size % info->nbanks) {
+	if (!size || size % gpio_banks) {
 		dev_err(info->dev, "wrong mux mask array should be by %d\n", info->nbanks);
 		return -EINVAL;
 	}
-	info->nmux = size / info->nbanks;
+	info->nmux = size / gpio_banks;
 
 	info->mux_mask = devm_kzalloc(info->dev, sizeof(u32) * size, GFP_KERNEL);
 	if (!info->mux_mask) {
@@ -1185,7 +1186,7 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 {
 	struct at91_pinctrl *info;
 	struct pinctrl_pin_desc *pdesc;
-	int ret, i, j, k;
+	int ret, i, j, k, ngpio_chips_enabled = 0;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -1200,12 +1201,14 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 	 * to obtain references to the struct gpio_chip * for them, and we
 	 * need this to proceed.
 	 */
-	for (i = 0; i < info->nbanks; i++) {
-		if (!gpio_chips[i]) {
-			dev_warn(&pdev->dev, "GPIO chip %d not registered yet\n", i);
-			devm_kfree(&pdev->dev, info);
-			return -EPROBE_DEFER;
-		}
+	for (i = 0; i < gpio_banks; i++) {
+		if (gpio_chips[i])
+			ngpio_chips_enabled++;
+	}
+	if (ngpio_chips_enabled < info->nbanks) {
+		dev_warn(&pdev->dev, "All GPIO chips are not registered yet\n");
+		devm_kfree(&pdev->dev, info);
+		return -EPROBE_DEFER;
 	}
 
 	at91_pinctrl_desc.name = dev_name(&pdev->dev);
@@ -1234,8 +1237,9 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	/* We will handle a range of GPIO pins */
-	for (i = 0; i < info->nbanks; i++)
-		pinctrl_add_gpio_range(info->pctl, &gpio_chips[i]->range);
+	for (i = 0; i < gpio_banks; i++)
+		if (gpio_chips[i])
+			pinctrl_add_gpio_range(info->pctl, &gpio_chips[i]->range);
 
 	dev_info(&pdev->dev, "initialized AT91 pinctrl driver\n");
 
@@ -1681,6 +1685,8 @@ static void at91_gpio_probe_fixup(void)
 
 	for (i = 0; i < gpio_banks; i++) {
 		at91_gpio = gpio_chips[i];
+		if (!at91_gpio)
+			continue;
 
 		/*
 		 * GPIO controller are grouped on some SoC:
-- 
2.0.3
