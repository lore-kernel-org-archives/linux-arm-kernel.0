From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 12:47:38 +0800
Subject: [PATCH 20/22] pinctrl-nomadik: Allow Device Tree driver probing
In-Reply-To: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1338353260-10097-21-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nomadik GPIO controller now relies on Nomadik pinctrl, however
the pinctrl driver is not currently started by any ux500 platform.
This is requred or GPIOs do not work at all.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index b8e01c3..b26395d 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -24,6 +24,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/pinconf.h>
@@ -1688,18 +1689,34 @@ static struct pinctrl_desc nmk_pinctrl_desc = {
 	.owner = THIS_MODULE,
 };
 
+static const struct of_device_id nmk_pinctrl_match[] = {
+	{
+		.compatible = "stericsson,nmk_pinctrl",
+		.data = (void *)PINCTRL_NMK_DB8500,
+	},
+	{},
+};
+
 static int __devinit nmk_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *platid = platform_get_device_id(pdev);
+	struct device_node *np = pdev->dev.of_node;
 	struct nmk_pinctrl *npct;
+	unsigned int version = 0;
 	int i;
 
 	npct = devm_kzalloc(&pdev->dev, sizeof(*npct), GFP_KERNEL);
 	if (!npct)
 		return -ENOMEM;
 
+	if (platid)
+		version = platid->driver_data;
+	else if (np)
+		version = (unsigned int)
+			of_match_device(nmk_pinctrl_match, &pdev->dev)->data;
+
 	/* Poke in other ASIC variants here */
-	if (platid->driver_data == PINCTRL_NMK_DB8500)
+	if (version == PINCTRL_NMK_DB8500)
 		nmk_pinctrl_db8500_init(&npct->soc);
 
 	/*
@@ -1758,6 +1775,7 @@ static struct platform_driver nmk_pinctrl_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "pinctrl-nomadik",
+		.of_match_table = nmk_pinctrl_match,
 	},
 	.probe = nmk_pinctrl_probe,
 	.id_table = nmk_pinctrl_id,
-- 
1.7.9.5
