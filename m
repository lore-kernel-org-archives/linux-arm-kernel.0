From: jason@lakedaemon.net (Jason Cooper)
Date: Wed,  7 Mar 2012 03:44:52 +0000
Subject: [PATCH 11/14] ARM: kirkwood: ehci-orion: add device tree binding
In-Reply-To: <cover.1331090356.git.jason@lakedaemon.net>
References: <cover.1331090356.git.jason@lakedaemon.net>
Message-ID: <8d2def2acb877d133bfbfb29a5afeb7aa6a7f954.1331090356.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Walle <michael@walle.cc>

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 .../devicetree/bindings/usb/ehci-orion.txt         |    5 ++
 drivers/usb/host/ehci-orion.c                      |   50 +++++++++++++++++++-
 2 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-orion.txt

diff --git a/Documentation/devicetree/bindings/usb/ehci-orion.txt b/Documentation/devicetree/bindings/usb/ehci-orion.txt
new file mode 100644
index 0000000..b46d825
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ehci-orion.txt
@@ -0,0 +1,5 @@
+Marvell Orion SoC USB controller
+
+Required properties :
+ - compatible : should be "mrvl,orion-ehci".
+ - phy_version : should be "orion".
diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 6c6a5a3..f1dec1d 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -12,6 +12,8 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/mbus.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <plat/ehci-orion.h>
 
 #define rdl(off)	__raw_readl(hcd->regs + (off))
@@ -191,6 +193,29 @@ ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
 	}
 }
 
+static const char *phy_versions[] = {
+	[EHCI_PHY_NA]		= "",
+	[EHCI_PHY_ORION]	= "orion",
+	[EHCI_PHY_DD]		= "dd", /* XXX dd? */
+	[EHCI_PHY_KW]		= "kirkwood",
+};
+
+static const int get_phy_version(struct device_node *np)
+{
+	const char *pm;
+	int err, i;
+
+	err = of_property_read_string(np, "phy-version", &pm);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < ARRAY_SIZE(phy_versions); i++)
+		if (!strcasecmp(pm, phy_versions[i]))
+			return i;
+
+	return -ENODEV;
+}
+
 static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 {
 	struct orion_ehci_data *pd = pdev->dev.platform_data;
@@ -200,6 +225,7 @@ static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 	struct ehci_hcd *ehci;
 	void __iomem *regs;
 	int irq, err;
+	enum orion_ehci_phy_ver phy_version;
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -267,7 +293,15 @@ static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 	/*
 	 * setup Orion USB controller.
 	 */
-	switch (pd->phy_version) {
+	if (pdev->dev.of_node) {
+		phy_version = get_phy_version(pdev->dev.of_node);
+		if (phy_version < 0)
+			goto err3;
+	} else {
+		phy_version = pd->phy_version;
+	}
+
+	switch (phy_version) {
 	case EHCI_PHY_NA:	/* dont change USB phy settings */
 		break;
 	case EHCI_PHY_ORION:
@@ -312,9 +346,21 @@ static int __exit ehci_orion_drv_remove(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:orion-ehci");
 
+#ifdef CONFIG_OF
+static const struct of_device_id ehci_orion_dt_ids[] __devinitdata = {
+	{ .compatible = "mrvl,orion-ehci", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ehci_orion_dt_ids);
+#endif
+
 static struct platform_driver ehci_orion_driver = {
 	.probe		= ehci_orion_drv_probe,
 	.remove		= __exit_p(ehci_orion_drv_remove),
 	.shutdown	= usb_hcd_platform_shutdown,
-	.driver.name	= "orion-ehci",
+	.driver = {
+		.name	= "orion-ehci",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(ehci_orion_dt_ids),
+	},
 };
-- 
1.7.3.4
