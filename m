From: andrew@lunn.ch (Andrew Lunn)
Date: Sat,  1 Sep 2012 11:26:25 +0200
Subject: [PATCH 1/2] ARM: Kirkwood: ehci-orion: Add device tree binding
Message-ID: <1346491586-23480-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on previous work by Michael Walle and Jason Cooper.

Made their work actually work, which required added interrupt from DT
and auxdata, along with setting the dma_mask, which DT does not
currently do.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/usb/ehci-orion.txt         |   19 +++++++
 drivers/usb/host/ehci-orion.c                      |   59 +++++++++++++++++++-
 2 files changed, 75 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-orion.txt

diff --git a/Documentation/devicetree/bindings/usb/ehci-orion.txt b/Documentation/devicetree/bindings/usb/ehci-orion.txt
new file mode 100644
index 0000000..1bd704e
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ehci-orion.txt
@@ -0,0 +1,19 @@
+* EHCI controller, Orion Marvell variants
+
+Required properties:
+- compatible: must be "marvell,orion-ehci"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: The EHCI interrupt
+- phy-version: Can be one of:
+  "NA" - Don't touch the phy, something else has already configured it.
+  "orion5x" - PHY setup as specified by the Orion5x Errata
+
+Example:
+
+	ehci at 50000 {
+		compatible = "marvell,orion-ehci";
+		reg = <0x50000 0x1000>;
+		interrupts = <19>;
+		phy-version = "NA";
+	};
diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index b34b928..605feb09 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -14,6 +14,9 @@
 #include <linux/mbus.h>
 #include <linux/clk.h>
 #include <linux/platform_data/ehci-orion.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
 
 #define rdl(off)	__raw_readl(hcd->regs + (off))
 #define wrl(off, val)	__raw_writel((val), hcd->regs + (off))
@@ -181,6 +184,27 @@ ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
 	}
 }
 
+static const int get_phy_version(struct device_node *np)
+{
+	const char *pm;
+	int err;
+
+	err = of_property_read_string(np, "phy-version", &pm);
+
+	if (err < 0)
+		return err;
+
+
+	if (!strcasecmp(pm, "NA"))
+		return EHCI_PHY_NA;
+	if (!strcasecmp(pm, "orion5x"))
+		return EHCI_PHY_ORION;
+
+	return -ENODEV;
+}
+
+static u64 ehci_orion_dma_mask = DMA_BIT_MASK(32);
+
 static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 {
 	struct orion_ehci_data *pd = pdev->dev.platform_data;
@@ -191,13 +215,17 @@ static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 	struct clk *clk;
 	void __iomem *regs;
 	int irq, err;
+	enum orion_ehci_phy_ver phy_version;
 
 	if (usb_disabled())
 		return -ENODEV;
 
 	pr_debug("Initializing Orion-SoC USB Host Controller\n");
 
-	irq = platform_get_irq(pdev, 0);
+	if (pdev->dev.of_node)
+		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	else
+		irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
 		dev_err(&pdev->dev,
 			"Found HC with no IRQ. Check %s setup!\n",
@@ -215,6 +243,14 @@ static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	/*
+	 * Right now device-tree probed devices don't get dma_mask
+	 * set. Since shared usb code relies on it, set it here for
+	 * now. Once we have dma capability bindings this can go away.
+	 */
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &ehci_orion_dma_mask;
+
 	if (!request_mem_region(res->start, resource_size(res),
 				ehci_orion_hc_driver.description)) {
 		dev_dbg(&pdev->dev, "controller already in use\n");
@@ -262,7 +298,14 @@ static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 	/*
 	 * setup Orion USB controller.
 	 */
-	switch (pd->phy_version) {
+	if (pdev->dev.of_node) {
+		phy_version = get_phy_version(pdev->dev.of_node);
+		if (phy_version < 0)
+			goto err3;
+	} else
+		phy_version = pd->phy_version;
+
+	switch (phy_version) {
 	case EHCI_PHY_NA:	/* dont change USB phy settings */
 		break;
 	case EHCI_PHY_ORION:
@@ -317,9 +360,19 @@ static int __exit ehci_orion_drv_remove(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:orion-ehci");
 
+static const struct of_device_id ehci_orion_dt_ids[] __devinitdata = {
+	{ .compatible = "marvell,orion-ehci", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ehci_orion_dt_ids);
+
 static struct platform_driver ehci_orion_driver = {
 	.probe		= ehci_orion_drv_probe,
 	.remove		= __exit_p(ehci_orion_drv_remove),
 	.shutdown	= usb_hcd_platform_shutdown,
-	.driver.name	= "orion-ehci",
+	.driver = {
+		.name	= "orion-ehci",
+		.owner  = THIS_MODULE,
+		.of_match_table = of_match_ptr(ehci_orion_dt_ids),
+	},
 };
-- 
1.7.10.4
