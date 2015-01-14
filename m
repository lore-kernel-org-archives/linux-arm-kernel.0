From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 14 Jan 2015 11:08:07 +0100
Subject: [PATCH 1/3] pinctrl: at91: allow disabled pio controllers
In-Reply-To: <1421230089-1418-1-git-send-email-ludovic.desroches@atmel.com>
References: <1421230089-1418-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1421230089-1418-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91 pinctrl was not designed to support disabled or unused pio controllers.
All the pio controllers have to be declared, then set status to
disabled if you don't want to use it.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/pinctrl/pinctrl-at91.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index dfd021e..fc9afb4 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -178,6 +178,7 @@ struct at91_pinctrl {
 	struct pinctrl_dev	*pctl;
 
 	int			nbanks;
+	int			nactive_banks;
 
 	uint32_t		*mux_mask;
 	int			nmux;
@@ -982,6 +983,8 @@ static void at91_pinctrl_child_count(struct at91_pinctrl *info,
 	for_each_child_of_node(np, child) {
 		if (of_device_is_compatible(child, gpio_compat)) {
 			info->nbanks++;
+			if (of_device_is_available(child))
+				info->nactive_banks;
 		} else {
 			info->nfunctions++;
 			info->ngroups += of_get_child_count(child);
@@ -1145,8 +1148,12 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 	dev_dbg(&pdev->dev, "mux-mask\n");
 	tmp = info->mux_mask;
 	for (i = 0; i < info->nbanks; i++) {
+		if (!gpio_chips[i]) {
+			tmp += info->nmux;
+			continue;
+		}
 		for (j = 0; j < info->nmux; j++, tmp++) {
-			dev_dbg(&pdev->dev, "%d:%d\t0x%x\n", i, j, tmp[0]);
+			dev_dbg(&pdev->dev, "pio%c:periphal %c\t0x%x\n", 'A' + i, 'A' + j, tmp[0]);
 		}
 	}
 
@@ -1185,7 +1192,7 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 {
 	struct at91_pinctrl *info;
 	struct pinctrl_pin_desc *pdesc;
-	int ret, i, j, k;
+	int ret, i, j, k, ngpio_chips_enabled = 0;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -1201,11 +1208,15 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 	 * need this to proceed.
 	 */
 	for (i = 0; i < info->nbanks; i++) {
-		if (!gpio_chips[i]) {
-			dev_warn(&pdev->dev, "GPIO chip %d not registered yet\n", i);
-			devm_kfree(&pdev->dev, info);
-			return -EPROBE_DEFER;
-		}
+		if (gpio_chips[i])
+			ngpio_chips_enabled++;
+	}
+	if (ngpio_chips_enabled < info->nactive_banks) {
+		dev_warn(&pdev->dev,
+			 "All GPIO chips are not registered yet (%d/%d)\n",
+			 ngpio_chips_enabled, info->nactive_banks);
+		devm_kfree(&pdev->dev, info);
+		return -EPROBE_DEFER;
 	}
 
 	at91_pinctrl_desc.name = dev_name(&pdev->dev);
@@ -1235,7 +1246,8 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 
 	/* We will handle a range of GPIO pins */
 	for (i = 0; i < info->nbanks; i++)
-		pinctrl_add_gpio_range(info->pctl, &gpio_chips[i]->range);
+		if (gpio_chips[i])
+			pinctrl_add_gpio_range(info->pctl, &gpio_chips[i]->range);
 
 	dev_info(&pdev->dev, "initialized AT91 pinctrl driver\n");
 
@@ -1682,6 +1694,8 @@ static void at91_gpio_probe_fixup(void)
 
 	for (i = 0; i < gpio_banks; i++) {
 		at91_gpio = gpio_chips[i];
+		if (!at91_gpio)
+			continue;
 
 		/*
 		 * GPIO controller are grouped on some SoC:
-- 
2.2.0
