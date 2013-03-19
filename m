From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 19 Mar 2013 19:07:29 +0100
Subject: [PATCH 1/4] leds: leds-ns2: fix oops at module removal
In-Reply-To: <1363716452-18870-1-git-send-email-simon.guinot@sequanux.org>
References: <1363716452-18870-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1363716452-18870-2-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a regression introduced by commit 72052fcc10
("leds: leds-ns2: add device tree binding").

When the driver is initialized with device tree data, platform_data
pointer is NULL. This causes a kernel oops at removal.

To fix this bug, num_leds is moved into driver_data and platform_data
is not longer used from ns2_led_remove().

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 drivers/leds/leds-ns2.c |   38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/leds/leds-ns2.c b/drivers/leds/leds-ns2.c
index d978171..81af8e9 100644
--- a/drivers/leds/leds-ns2.c
+++ b/drivers/leds/leds-ns2.c
@@ -306,10 +306,21 @@ static const struct of_device_id of_ns2_leds_match[] = {
 };
 #endif /* CONFIG_OF_GPIO */
 
+struct ns2_led_priv {
+	int num_leds;
+	struct ns2_led_data leds_data[];
+};
+
+static inline int sizeof_ns2_led_priv(int num_leds)
+{
+	return sizeof(struct ns2_led_priv) +
+		      (sizeof(struct ns2_led_data) * num_leds);
+}
+
 static int ns2_led_probe(struct platform_device *pdev)
 {
 	struct ns2_led_platform_data *pdata = pdev->dev.platform_data;
-	struct ns2_led_data *leds_data;
+	struct ns2_led_priv *priv;
 	int i;
 	int ret;
 
@@ -330,21 +341,23 @@ static int ns2_led_probe(struct platform_device *pdev)
 		return -EINVAL;
 #endif /* CONFIG_OF_GPIO */
 
-	leds_data = devm_kzalloc(&pdev->dev, sizeof(struct ns2_led_data) *
-				 pdata->num_leds, GFP_KERNEL);
-	if (!leds_data)
+	priv = devm_kzalloc(&pdev->dev,
+			    sizeof_ns2_led_priv(pdata->num_leds), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
+	priv->num_leds = pdata->num_leds;
 
-	for (i = 0; i < pdata->num_leds; i++) {
-		ret = create_ns2_led(pdev, &leds_data[i], &pdata->leds[i]);
+	for (i = 0; i < priv->num_leds; i++) {
+		ret = create_ns2_led(pdev, &priv->leds_data[i],
+				     &pdata->leds[i]);
 		if (ret < 0) {
 			for (i = i - 1; i >= 0; i--)
-				delete_ns2_led(&leds_data[i]);
+				delete_ns2_led(&priv->leds_data[i]);
 			return ret;
 		}
 	}
 
-	platform_set_drvdata(pdev, leds_data);
+	platform_set_drvdata(pdev, priv);
 
 	return 0;
 }
@@ -352,13 +365,12 @@ static int ns2_led_probe(struct platform_device *pdev)
 static int ns2_led_remove(struct platform_device *pdev)
 {
 	int i;
-	struct ns2_led_platform_data *pdata = pdev->dev.platform_data;
-	struct ns2_led_data *leds_data;
+	struct ns2_led_priv *priv;
 
-	leds_data = platform_get_drvdata(pdev);
+	priv = platform_get_drvdata(pdev);
 
-	for (i = 0; i < pdata->num_leds; i++)
-		delete_ns2_led(&leds_data[i]);
+	for (i = 0; i < priv->num_leds; i++)
+		delete_ns2_led(&priv->leds_data[i]);
 
 	platform_set_drvdata(pdev, NULL);
 
-- 
1.7.10.4
