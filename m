From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 26 May 2015 11:44:43 +0200
Subject: [PATCH 2/3] spi: orion: Fix extended baud rates for each Armada SoCs
In-Reply-To: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1432633484-18758-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit df59fa7f4bca "spi: orion: support armada extended baud
rates" made the assumptions that all the Armada SoCs supported the
same maximum frequency. However, according the hardware datasheet, the
maximum frequency supported by the Armada 370 SoC is tclk/4, for the
Armada XP, Armada 38x and Armada 39x SoCs the limitation is 50MHz and
for the Armada 375 it is tclk/15.

This patch introduces new compatible strings to handle all these
case. In order to be future proof a compatible was created for each
SoC even if currently some SoCs seem using the same IP.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/spi/spi-orion.txt          |  8 +++-
 drivers/spi/spi-orion.c                            | 47 ++++++++++++++++++++--
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-orion.txt b/Documentation/devicetree/bindings/spi/spi-orion.txt
index 50c3a3de61c1..51d63df3d99d 100644
--- a/Documentation/devicetree/bindings/spi/spi-orion.txt
+++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
@@ -1,7 +1,13 @@
 Marvell Orion SPI device
 
 Required properties:
-- compatible : should be "marvell,orion-spi" or "marvell,armada-370-spi".
+- compatible : should be on of the following:
+    - "marvell,orion-spi" for the Orion, mv78x00, Kirkwood and Dove SoCs
+    - "marvell,armada-370-spi", for the Armada 370 SoCs
+    - "marvell,armada-375-spi", for the Armada 375 SoCs
+    - "marvell,armada-380-spi", for the Armada 38x SoCs
+    - "marvell,armada-390-spi", for the Armada 38x SoCs
+    - "marvell,armada-xp-spi", for the Armada XP SoCs
 - reg : offset and length of the register set for the device
 - cell-index : Which of multiple SPI controllers is this.
 Optional properties:
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index ff97cabdaa81..8cad107a5b3f 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -391,7 +391,7 @@ static const struct orion_spi_dev orion_spi_dev_data = {
 	.prescale_mask = ORION_SPI_CLK_PRESCALE_MASK,
 };
 
-static const struct orion_spi_dev armada_spi_dev_data = {
+static const struct orion_spi_dev armada_370_spi_dev_data = {
 	.typ = ARMADA_SPI,
 	.min_divisor = 4,
 	.max_divisor = 1920,
@@ -399,9 +399,46 @@ static const struct orion_spi_dev armada_spi_dev_data = {
 	.prescale_mask = ARMADA_SPI_CLK_PRESCALE_MASK,
 };
 
+static const struct orion_spi_dev armada_xp_spi_dev_data = {
+	.typ = ARMADA_SPI,
+	.max_hz = 50000000,
+	.max_divisor = 1920,
+	.prescale_mask = ARMADA_SPI_CLK_PRESCALE_MASK,
+};
+
+static const struct orion_spi_dev armada_375_spi_dev_data = {
+	.typ = ARMADA_SPI,
+	.min_divisor = 15,
+	.max_divisor = 1920,
+	.prescale_mask = ARMADA_SPI_CLK_PRESCALE_MASK,
+};
+
 static const struct of_device_id orion_spi_of_match_table[] = {
-	{ .compatible = "marvell,orion-spi", .data = &orion_spi_dev_data, },
-	{ .compatible = "marvell,armada-370-spi", .data = &armada_spi_dev_data, },
+	{
+		.compatible = "marvell,orion-spi",
+		.data = &orion_spi_dev_data,
+	},
+	{
+		.compatible = "marvell,armada-370-spi",
+		.data = &armada_370_spi_dev_data,
+	},
+	{
+		.compatible = "marvell,armada-375-spi",
+		.data = &armada_375_spi_dev_data,
+	},
+	{
+		.compatible = "marvell,armada-380-spi",
+		.data = &armada_xp_spi_dev_data,
+	},
+	{
+		.compatible = "marvell,armada-390-spi",
+		.data = &armada_xp_spi_dev_data,
+	},
+	{
+		.compatible = "marvell,armada-xp-spi",
+		.data = &armada_xp_spi_dev_data,
+	},
+
 	{}
 };
 MODULE_DEVICE_TABLE(of, orion_spi_of_match_table);
@@ -473,9 +510,11 @@ static int orion_spi_probe(struct platform_device *pdev)
 					"marvell,armada-370-spi"))
 		master->max_speed_hz = min(devdata->max_hz,
 				DIV_ROUND_UP(tclk_hz, devdata->min_divisor));
-	else
+	else if (devdata->min_divisor)
 		master->max_speed_hz =
 			DIV_ROUND_UP(tclk_hz, devdata->min_divisor);
+	else
+		master->max_speed_hz = devdata->max_hz;
 	master->min_speed_hz = DIV_ROUND_UP(tclk_hz, devdata->max_divisor);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.1.0
