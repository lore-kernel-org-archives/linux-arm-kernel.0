From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 26 May 2015 11:44:42 +0200
Subject: [PATCH 1/3] spi: orion: Fix maximum baud rates for Armada 370/XP
In-Reply-To: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1432633484-18758-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit df59fa7f4bca "spi: orion: support armada extended baud
rates" was too optimistic for the maximum baud rate that the Armada
SoCs can support. According to the hardware datasheet the maximum
frequency supported by the Armada 370 SoC is tclk/4. But for the
Armada XP, Armada 38x and Armada 39x SoCs the limitation is 50MHz and
for the Armada 375 it is tclk/15.

Currently the armada-370-spi compatible is only used by the Armada 370
and the Armada XP device tree. On Armada 370, tclk cannot be higher
than 200MHz. In order to be able to handle both SoCs, we can take the
minimum of 50MHz and tclk/4.

A proper solution is adding a compatible string for each SoC, but it
can't be done as a fix for compatibility reason (we can't modify
device tree that have been already released) and it will be part of a
separate patch.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reported-by: Kostya Porotchkin <kostap@marvell.com>
Cc: <stable@vger.kernel.org> #Fixes df59fa7f4bca
---
 drivers/spi/spi-orion.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 861664776672..ff97cabdaa81 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -61,6 +61,12 @@ enum orion_spi_type {
 
 struct orion_spi_dev {
 	enum orion_spi_type	typ;
+	/*
+	 * min_divisor and max_hz should be exclusive, the only we can
+	 * have both is for managing the armada-370-spi case with old
+	 * device tree
+	 */
+	unsigned long		max_hz;
 	unsigned int		min_divisor;
 	unsigned int		max_divisor;
 	u32			prescale_mask;
@@ -387,8 +393,9 @@ static const struct orion_spi_dev orion_spi_dev_data = {
 
 static const struct orion_spi_dev armada_spi_dev_data = {
 	.typ = ARMADA_SPI,
-	.min_divisor = 1,
+	.min_divisor = 4,
 	.max_divisor = 1920,
+	.max_hz = 50000000,
 	.prescale_mask = ARMADA_SPI_CLK_PRESCALE_MASK,
 };
 
@@ -454,7 +461,21 @@ static int orion_spi_probe(struct platform_device *pdev)
 		goto out;
 
 	tclk_hz = clk_get_rate(spi->clk);
-	master->max_speed_hz = DIV_ROUND_UP(tclk_hz, devdata->min_divisor);
+
+	/*
+	 * With old device tree, armada-370-spi could be used with
+	 * Armada XP, however for this SoC the maximum frequency is
+	 * 50MHz instead of tclk/4. On Armada 370, tclk cannot be
+	 * higher than 200MHz. So, in order to be able to handle both
+	 * SoCs, we can take the minimum of 50MHz and tclk/4.
+	 */
+	if (of_device_is_compatible(pdev->dev.of_node,
+					"marvell,armada-370-spi"))
+		master->max_speed_hz = min(devdata->max_hz,
+				DIV_ROUND_UP(tclk_hz, devdata->min_divisor));
+	else
+		master->max_speed_hz =
+			DIV_ROUND_UP(tclk_hz, devdata->min_divisor);
 	master->min_speed_hz = DIV_ROUND_UP(tclk_hz, devdata->max_divisor);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.1.0
