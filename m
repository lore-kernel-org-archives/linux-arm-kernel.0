From: zonque@gmail.com (Daniel Mack)
Date: Thu, 26 Jul 2012 21:16:22 +0200
Subject: [PATCH v2 2/7] MMC: pxa-mci: add DT bindings
In-Reply-To: <1343330187-20049-1-git-send-email-zonque@gmail.com>
References: <1343330187-20049-1-git-send-email-zonque@gmail.com>
Message-ID: <1343330187-20049-3-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Chris Ball <cjb@laptop.org>
---
 Documentation/devicetree/bindings/mmc/pxa-mmc.txt | 25 +++++++++++
 drivers/mmc/host/pxamci.c                         | 52 +++++++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/pxa-mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/pxa-mmc.txt b/Documentation/devicetree/bindings/mmc/pxa-mmc.txt
new file mode 100644
index 0000000..b7025de
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/pxa-mmc.txt
@@ -0,0 +1,25 @@
+* PXA MMC drivers
+
+Driver bindings for the PXA MCI (MMC/SDIO) interfaces
+
+Required properties:
+- compatible: Should be "marvell,pxa-mmc".
+- vmmc-supply: A regulator for VMMC
+
+Optional properties:
+- marvell,detect-delay-ms: sets the detection delay timeout in ms.
+- marvell,gpio-power: GPIO spec for the card power enable pin
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the pxa-mmc driver.
+
+Examples:
+
+mmc0: mmc at 41100000 {
+	compatible = "marvell,pxa-mmc";
+	reg = <0x41100000 0x1000>;
+	interrupts = <23>;
+	cd-gpios = <&gpio 23 0>;
+	wp-gpios = <&gpio 24 0>;
+};
+
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index cb2dc0e..11df800 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -30,6 +30,9 @@
 #include <linux/regulator/consumer.h>
 #include <linux/gpio.h>
 #include <linux/gfp.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_device.h>
 
 #include <asm/sizes.h>
 
@@ -573,6 +576,50 @@ static irqreturn_t pxamci_detect_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id pxa_mmc_dt_ids[] = {
+        { .compatible = "marvell,pxa-mmc" },
+        { }
+};
+
+MODULE_DEVICE_TABLE(of, pxa_mmc_dt_ids);
+
+static int __devinit pxamci_of_init(struct platform_device *pdev)
+{
+        struct device_node *np = pdev->dev.of_node;
+        struct pxamci_platform_data *pdata;
+        u32 tmp;
+
+        if (!np)
+                return 0;
+
+        pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+        if (!pdata)
+                return -ENOMEM;
+
+	pdata->gpio_card_detect =
+		of_get_named_gpio(np, "cd-gpios", 0);
+	pdata->gpio_card_ro =
+		of_get_named_gpio(np, "wp-gpios", 0);
+
+	/* pxa-mmc specific */
+	pdata->gpio_power =
+		of_get_named_gpio(np, "pxa-mmc,gpio-power", 0);
+
+	if (of_property_read_u32(np, "pxa-mmc,detect-delay-ms", &tmp) == 0)
+		pdata->detect_delay_ms = tmp;
+
+        pdev->dev.platform_data = pdata;
+
+        return 0;
+}
+#else
+static int __devinit pxamci_of_init(struct platform_device *pdev)
+{
+        return 0;
+}
+#endif
+
 static int pxamci_probe(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
@@ -580,6 +627,10 @@ static int pxamci_probe(struct platform_device *pdev)
 	struct resource *r, *dmarx, *dmatx;
 	int ret, irq, gpio_cd = -1, gpio_ro = -1, gpio_power = -1;
 
+	ret = pxamci_of_init(pdev);
+	if (ret)
+		return ret;
+
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 	if (!r || irq < 0)
@@ -866,6 +917,7 @@ static struct platform_driver pxamci_driver = {
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(pxa_mmc_dt_ids),
 #ifdef CONFIG_PM
 		.pm	= &pxamci_pm_ops,
 #endif
-- 
1.7.11.2
