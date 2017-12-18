From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 18 Dec 2017 10:18:00 +0100
Subject: [net-next: PATCH 4/8] net: mvmdio: add ACPI support
In-Reply-To: <1513588684-15647-1-git-send-email-mw@semihalf.com>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
Message-ID: <1513588684-15647-5-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introducing ACPI support for the mvmdio driver by adding
acpi_match_table with two entries:

* "MRVL0100" for the SMI operation
* "MRVL0101" for the XSMI mode

Also clk enabling is skipped, because the tables do not contain
such data and clock maintenance relies on the firmware. The
MDIO bus is registered using newly introduced
fwnode_mdiobus_register().

Memory region used by mvmdio driver is usually placed in the middle
of the address space of the network controller (e.g. NETA or PP2).
The MDIO base address is obtained without requesting memory region
(by devm_ioremap() call), later overlapping resources are
requested by the network driver, where care is taken to avoid
concurrent access.

This way of solving problem occurred to be not sufficient with ACPI,
because resources declared in the table and used once, appear as
'in-use' in the OS. This patch also ensures releasing resources by
mvmdio driver prior to initializing the network controller driver.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvmdio.c | 42 +++++++++++++++++++-
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 0495487..31d758a 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -17,6 +17,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -279,9 +280,19 @@ static int orion_mdio_probe(struct platform_device *pdev)
 	struct resource *r;
 	struct mii_bus *bus;
 	struct orion_mdio_dev *dev;
+	const struct acpi_device_id *acpi_id;
+	bool use_acpi = false;
 	int i, ret;
 
-	type = (enum orion_mdio_bus_type)of_device_get_match_data(&pdev->dev);
+	if (has_acpi_companion(&pdev->dev)) {
+		acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
+					    &pdev->dev);
+		type = (enum orion_mdio_bus_type)acpi_id->driver_data;
+		use_acpi = true;
+	} else {
+		type =
+		 (enum orion_mdio_bus_type)of_device_get_match_data(&pdev->dev);
+	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
@@ -319,7 +330,7 @@ static int orion_mdio_probe(struct platform_device *pdev)
 
 	init_waitqueue_head(&dev->smi_busy_wait);
 
-	for (i = 0; i < ARRAY_SIZE(dev->clk); i++) {
+	for (i = 0; !use_acpi && i < ARRAY_SIZE(dev->clk); i++) {
 		dev->clk[i] = of_clk_get(pdev->dev.of_node, i);
 		if (IS_ERR(dev->clk[i]))
 			break;
@@ -350,6 +361,8 @@ static int orion_mdio_probe(struct platform_device *pdev)
 
 	if (pdev->dev.of_node)
 		ret = of_mdiobus_register(bus, pdev->dev.of_node);
+	else if (use_acpi)
+		ret = fwnode_mdiobus_register(bus, pdev->dev.fwnode);
 	else
 		ret = mdiobus_register(bus);
 	if (ret < 0) {
@@ -357,6 +370,15 @@ static int orion_mdio_probe(struct platform_device *pdev)
 		goto out_mdio;
 	}
 
+	/* In case of ACPI resources declared in the tables and used
+	 * once, appear as 'in-use' in the OS. Make sure they are released,
+	 * before the network driver possibly requests it again during
+	 * its initialization. The care is taken there to avoid
+	 * concurrent access to this memory region.
+	 */
+	if (use_acpi)
+		release_resource(r);
+
 	platform_set_drvdata(pdev, bus);
 
 	return 0;
@@ -365,6 +387,11 @@ static int orion_mdio_probe(struct platform_device *pdev)
 	if (dev->err_interrupt > 0)
 		writel(0, dev->regs + MVMDIO_ERR_INT_MASK);
 
+	if (use_acpi) {
+		release_resource(r);
+		return ret;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(dev->clk); i++) {
 		if (IS_ERR(dev->clk[i]))
 			break;
@@ -385,6 +412,9 @@ static int orion_mdio_remove(struct platform_device *pdev)
 		writel(0, dev->regs + MVMDIO_ERR_INT_MASK);
 	mdiobus_unregister(bus);
 
+	if (has_acpi_companion(&pdev->dev))
+		return 0;
+
 	for (i = 0; i < ARRAY_SIZE(dev->clk); i++) {
 		if (IS_ERR(dev->clk[i]))
 			break;
@@ -402,12 +432,20 @@ static const struct of_device_id orion_mdio_match[] = {
 };
 MODULE_DEVICE_TABLE(of, orion_mdio_match);
 
+static const struct acpi_device_id orion_mdio_acpi_match[] = {
+	{ "MRVL0100", BUS_TYPE_SMI },
+	{ "MRVL0101", BUS_TYPE_XSMI },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, orion_mdio_acpi_match);
+
 static struct platform_driver orion_mdio_driver = {
 	.probe = orion_mdio_probe,
 	.remove = orion_mdio_remove,
 	.driver = {
 		.name = "orion-mdio",
 		.of_match_table = orion_mdio_match,
+		.acpi_match_table = ACPI_PTR(orion_mdio_acpi_match),
 	},
 };
 
-- 
2.7.4
