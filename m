From: linux@prisktech.co.nz (Tony Prisk)
Date: Fri, 11 Jan 2013 08:09:46 +1300
Subject: [PATCH v2] gpio: vt8500: memory cleanup missing
Message-ID: <1357844986-21891-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is missing a .remove callback, and the fail path on
probe is incomplete.

If an error occurs in vt8500_add_chips, gpio_base is not unmapped.
The driver is also ignoring the return value from this function so
if a chip fails to register it completes as successful.

Replaced pr_err with dev_err in vt8500_add_chips since the device is
available.

There is also no .remove callback defined. To allow removing the
registered chips, I have moved *vtchip to be a static global.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
v2:
Remove global variable and use platform_set_drvdata instead.

 drivers/gpio/gpio-vt8500.c |   51 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-vt8500.c b/drivers/gpio/gpio-vt8500.c
index b53320a..87e59b5 100644
--- a/drivers/gpio/gpio-vt8500.c
+++ b/drivers/gpio/gpio-vt8500.c
@@ -233,10 +233,12 @@ static int vt8500_add_chips(struct platform_device *pdev, void __iomem *base,
 			sizeof(struct vt8500_gpio_chip) * data->num_banks,
 			GFP_KERNEL);
 	if (!vtchip) {
-		pr_err("%s: failed to allocate chip memory\n", __func__);
+		dev_err(&pdev->dev, "failed to allocate chip memory\n");
 		return -ENOMEM;
 	}
 
+	platform_set_drvdata(pdev, vtchip);
+
 	for (i = 0; i < data->num_banks; i++) {
 		vtchip[i].base = base;
 		vtchip[i].regs = &data->banks[i];
@@ -261,6 +263,7 @@ static int vt8500_add_chips(struct platform_device *pdev, void __iomem *base,
 
 		gpiochip_add(chip);
 	}
+
 	return 0;
 }
 
@@ -273,36 +276,64 @@ static struct of_device_id vt8500_gpio_dt_ids[] = {
 
 static int vt8500_gpio_probe(struct platform_device *pdev)
 {
+	int ret;
 	void __iomem *gpio_base;
-	struct device_node *np;
+	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 				of_match_device(vt8500_gpio_dt_ids, &pdev->dev);
 
-	if (!of_id) {
-		dev_err(&pdev->dev, "Failed to find gpio controller\n");
+	if (!np) {
+		dev_err(&pdev->dev, "GPIO node missing in devicetree\n");
 		return -ENODEV;
 	}
 
-	np = pdev->dev.of_node;
-	if (!np) {
-		dev_err(&pdev->dev, "Missing GPIO description in devicetree\n");
-		return -EFAULT;
+	if (!of_id) {
+		dev_err(&pdev->dev, "No matching driver data\n");
+		return -ENODEV;
 	}
 
 	gpio_base = of_iomap(np, 0);
 	if (!gpio_base) {
 		dev_err(&pdev->dev, "Unable to map GPIO registers\n");
-		of_node_put(np);
 		return -ENOMEM;
 	}
 
-	vt8500_add_chips(pdev, gpio_base, of_id->data);
+	ret = vt8500_add_chips(pdev, gpio_base, of_id->data);
+	if (ret) {
+		iounmap(gpio_base);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int vt8500_gpio_remove(struct platform_device *pdev)
+{
+	int i;
+	int ret;
+	const struct vt8500_gpio_data *data;
+	struct vt8500_gpio_chip *vtchip = platform_get_drvdata(pdev);
+	void __iomem *gpio_base = vtchip[0].base;
+	const struct of_device_id *of_id =
+				of_match_device(vt8500_gpio_dt_ids, &pdev->dev);
+
+	data = of_id->data;
+
+	for (i = 0; i < data->num_banks; i++) {
+		ret = gpiochip_remove(&vtchip[i].chip);
+		if (ret)
+			dev_warn(&pdev->dev, "gpiochip_remove returned %d\n",
+				 ret);
+	}
+
+	iounmap(gpio_base);
 
 	return 0;
 }
 
 static struct platform_driver vt8500_gpio_driver = {
 	.probe		= vt8500_gpio_probe,
+	.remove		= vt8500_gpio_remove,
 	.driver		= {
 		.name	= "vt8500-gpio",
 		.owner	= THIS_MODULE,
-- 
1.7.9.5
