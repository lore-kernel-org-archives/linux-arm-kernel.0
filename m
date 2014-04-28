From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 12:01:32 -0700
Subject: [PATCH 06/15] pinctrl: sunxi: Libraryse the driver
In-Reply-To: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1398711701-11309-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow to have multiple drivers using the same core code, and
eventually, retire pinctrl-sunxi-pins.h

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 22 +++++++++++++++-------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h |  3 +++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 763a896f0eff..1f2d6730b5bf 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -787,10 +787,10 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 	return 0;
 }
 
-static int sunxi_pinctrl_probe(struct platform_device *pdev)
+int sunxi_pinctrl_init(struct platform_device *pdev,
+		       const struct sunxi_pinctrl_desc *desc)
 {
 	struct device_node *node = pdev->dev.of_node;
-	const struct of_device_id *device;
 	struct pinctrl_pin_desc *pins;
 	struct sunxi_pinctrl *pctl;
 	struct reset_control *rstc;
@@ -810,11 +810,7 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(pctl->membase))
 		return PTR_ERR(pctl->membase);
 
-	device = of_match_device(sunxi_pinctrl_match, &pdev->dev);
-	if (!device)
-		return -ENODEV;
-
-	pctl->desc = (const struct sunxi_pinctrl_desc *)device->data;
+	pctl->desc = desc;
 
 	ret = sunxi_pinctrl_build_state(pdev);
 	if (ret) {
@@ -940,6 +936,18 @@ pinctrl_error:
 	return ret;
 }
 
+static int sunxi_pinctrl_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *device;
+
+	device = of_match_device(sunxi_pinctrl_match, &pdev->dev);
+	if (!device)
+		return -ENODEV;
+
+	return sunxi_pinctrl_init(pdev,
+				  (const struct sunxi_pinctrl_desc *)device->data);
+}
+
 static struct platform_driver sunxi_pinctrl_driver = {
 	.probe = sunxi_pinctrl_probe,
 	.driver = {
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index 9775a5003b01..8169ba598876 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -252,4 +252,7 @@ static inline u32 sunxi_irq_status_offset(u16 irq)
 	return irq_num * IRQ_STATUS_IRQ_BITS;
 }
 
+int sunxi_pinctrl_init(struct platform_device *pdev,
+		       const struct sunxi_pinctrl_desc *desc);
+
 #endif /* __PINCTRL_SUNXI_H */
-- 
1.9.1
