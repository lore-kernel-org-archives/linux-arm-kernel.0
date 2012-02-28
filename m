From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 Feb 2012 18:43:26 +0000
Subject: [PATCH v2] ARM: kirkwood: covert orion-spi to fdt.
In-Reply-To: <4a9b37f69d6cec5049627b8afa777bb010af05f6.1330381705.git.jason@lakedaemon.net>
References: <4a9b37f69d6cec5049627b8afa777bb010af05f6.1330381705.git.jason@lakedaemon.net>
Message-ID: <10078cadd3ab4e8f2a0a642f810be6adbec4d477.1330454040.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Globalscale Dreamplug (Marvell Kirkwood Development Platform),
2MB of NOR flash are used to hold the bootloader, bootloader
environment, and devicetree blob.  It is connected via spi.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
Changes from v1:

    - checkpatch clean.
    - compiles, boots, registers partitions correctly.
    - removed WIP tag.
    - removed most '#ifdef CONFIG_OF's as suggested by Arnd
    - added tclk and clock_fix elements to struct orion_spi
    - remove/undo partial conversion to module_platform_driver()

 arch/arm/boot/dts/kirkwood-dreamplug.dts |   34 ++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dt.c        |   40 -----------------------------
 arch/arm/mach-kirkwood/common.c          |    7 +++++
 drivers/spi/spi-orion.c                  |   41 +++++++++++++++++++++++++++---
 4 files changed, 78 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index 8a5dff8..bdf2ddc 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -22,4 +22,38 @@
 		interrupts = <33>;
 		clock-frequency = <200000000>;
 	};
+
+	spi at f1010600 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		compatible = "marvell,orion-spi";
+		reg = <0xf1010600 0x1ff>;
+		clock-frequency = <200000000>;
+
+		flash at 0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			compatible = "macronix,mx25l1606e", "jedec-flash";
+
+			spi-max-frequency = <50000000>;
+			reg = <0>;
+
+			partition at 0 {
+				label = "U-Boot";
+				reg = <0x0 0x100000>;
+			};
+
+			partition at 100000 {
+				label = "U-Boot Environment";
+				reg = <0x100000 0x080000>;
+			};
+
+			partition at 180000 {
+				label = "Flattened Device Tree";
+				reg = <0x180000 0x080000>;
+			};
+		};
+	};
 };
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index fbe6405..4960e63 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -39,42 +39,6 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
 	{ }
 };
 
-struct mtd_partition dreamplug_partitions[] = {
-	{
-		.name	= "u-boot",
-		.size	= SZ_512K,
-		.offset = 0,
-	},
-	{
-		.name	= "u-boot env",
-		.size	= SZ_64K,
-		.offset = SZ_512K + SZ_512K,
-	},
-	{
-		.name	= "dtb",
-		.size	= SZ_64K,
-		.offset = SZ_512K + SZ_512K + SZ_512K,
-	},
-};
-
-static const struct flash_platform_data dreamplug_spi_slave_data = {
-	.type		= "mx25l1606e",
-	.name		= "spi_flash",
-	.parts		= dreamplug_partitions,
-	.nr_parts	= ARRAY_SIZE(dreamplug_partitions),
-};
-
-static struct spi_board_info __initdata dreamplug_spi_slave_info[] = {
-	{
-		.modalias	= "m25p80",
-		.platform_data	= &dreamplug_spi_slave_data,
-		.irq		= -1,
-		.max_speed_hz	= 50000000,
-		.bus_num	= 0,
-		.chip_select	= 0,
-	},
-};
-
 static struct mv643xx_eth_platform_data dreamplug_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
 };
@@ -140,10 +104,6 @@ static void __init dreamplug_init(void)
 	 */
 	kirkwood_mpp_conf(dreamplug_mpp_config);
 
-	spi_register_board_info(dreamplug_spi_slave_info,
-				ARRAY_SIZE(dreamplug_spi_slave_info));
-	kirkwood_spi_init();
-
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&dreamplug_ge00_data);
 	kirkwood_ge01_init(&dreamplug_ge01_data);
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index cc15426..4868dbd 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -15,6 +15,7 @@
 #include <linux/ata_platform.h>
 #include <linux/mtd/nand.h>
 #include <linux/dma-mapping.h>
+#include <linux/of.h>
 #include <net/dsa.h>
 #include <asm/page.h>
 #include <asm/timex.h>
@@ -481,6 +482,7 @@ static int __init kirkwood_clock_gate(void)
 {
 	unsigned int curr = readl(CLOCK_GATING_CTRL);
 	u32 dev, rev;
+	struct device_node *dp;
 
 	kirkwood_pcie_id(&dev, &rev);
 	printk(KERN_DEBUG "Gating clock of unused units\n");
@@ -524,6 +526,11 @@ static int __init kirkwood_clock_gate(void)
 	} else  /* keep this bit set for devices that don't have PCIe1 */
 		kirkwood_clk_ctrl |= CGC_PEX1;
 
+	dp = of_find_node_by_path("/");
+	if (dp && of_device_is_available(of_find_compatible_node(dp, NULL,
+							  "marvell,orion-spi")))
+		kirkwood_clk_ctrl |= CGC_RUNIT;
+
 	/* Now gate clock the required units */
 	writel(kirkwood_clk_ctrl, CLOCK_GATING_CTRL);
 	printk(KERN_DEBUG " after: 0x%08x\n", readl(CLOCK_GATING_CTRL));
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 13448c8..becd489 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -18,6 +18,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/orion_spi.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <asm/unaligned.h>
 
 #define DRIVER_NAME			"orion_spi"
@@ -45,6 +46,8 @@ struct orion_spi {
 	void __iomem		*base;
 	unsigned int		max_speed;
 	unsigned int		min_speed;
+	unsigned int		tclk;
+	unsigned int		clock_fix;
 	struct orion_spi_info	*spi_info;
 };
 
@@ -104,7 +107,7 @@ static int orion_spi_baudrate_set(struct spi_device *spi, unsigned int speed)
 
 	orion_spi = spi_master_get_devdata(spi->master);
 
-	tclk_hz = orion_spi->spi_info->tclk;
+	tclk_hz = orion_spi->tclk;
 
 	/*
 	 * the supported rates are: 4,6,8...30
@@ -360,7 +363,7 @@ static int orion_spi_setup(struct spi_device *spi)
 	orion_spi = spi_master_get_devdata(spi->master);
 
 	/* Fix ac timing if required.   */
-	if (orion_spi->spi_info->enable_clock_fix)
+	if (orion_spi->clock_fix)
 		orion_spi_setbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
 				  (1 << 14));
 
@@ -474,6 +477,7 @@ static int __init orion_spi_probe(struct platform_device *pdev)
 	master->setup = orion_spi_setup;
 	master->transfer = orion_spi_transfer;
 	master->num_chipselect = ORION_NUM_CHIPSELECTS;
+	master->dev.of_node = pdev->dev.of_node;
 
 	dev_set_drvdata(&pdev->dev, master);
 
@@ -481,8 +485,26 @@ static int __init orion_spi_probe(struct platform_device *pdev)
 	spi->master = master;
 	spi->spi_info = spi_info;
 
-	spi->max_speed = DIV_ROUND_UP(spi_info->tclk, 4);
-	spi->min_speed = DIV_ROUND_UP(spi_info->tclk, 30);
+	if (spi_info)
+		spi->tclk = spi_info->tclk;
+
+	of_property_read_u32(master->dev.of_node,
+				"clock-frequency", &spi->tclk);
+
+	if (!spi->tclk) {
+		dev_err(&pdev->dev, "cannot set clock rate\n");
+		status = -EINVAL;
+		goto out;
+	}
+
+	spi->max_speed = DIV_ROUND_UP(spi->tclk, 4);
+	spi->min_speed = DIV_ROUND_UP(spi->tclk, 30);
+
+	if (spi_info)
+		spi->clock_fix = spi_info->enable_clock_fix;
+
+	if (of_find_property(master->dev.of_node, "spi-clock-fix", NULL))
+		spi->clock_fix = 1;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
@@ -541,10 +563,21 @@ static int __exit orion_spi_remove(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
 
+#ifdef CONFIG_OF
+static struct of_device_id spi_orion_of_match_table[] __devinitdata = {
+	{ .compatible = "marvell,orion-spi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, spi_orion_of_match_table);
+#else /* CONFIG_OF */
+#define spi_orion_of_match_table NULL
+#endif /* CONFIG_OF */
+
 static struct platform_driver orion_spi_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = spi_orion_of_match_table,
 	},
 	.remove		= __exit_p(orion_spi_remove),
 };
-- 
1.7.3.4
