From: michael@walle.cc (Michael Walle)
Date: Sun,  3 Jun 2012 22:17:58 +0200
Subject: [PATCH 3/3] ARM: kirkwood: use devicetree for SPI on dreamplug
In-Reply-To: <1338754678-17000-1-git-send-email-michael@walle.cc>
References: <1338754678-17000-1-git-send-email-michael@walle.cc>
Message-ID: <1338754678-17000-3-git-send-email-michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the device tree for the SPI driver and partition layout.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/kirkwood-dreamplug.dts |   28 +++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dreamplug.c |   40 ------------------------------
 2 files changed, 28 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index a5376b8..f31d2b5 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -20,5 +20,33 @@
 			clock-frequency = <200000000>;
 			status = "ok";
 		};
+
+		spi at 10600 {
+			status = "okay";
+
+			m25p40 at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "mx25l1606e";
+				reg = <0>;
+				spi-max-frequency = <50000000>;
+				mode = <0>;
+
+				partition at 0 {
+					reg = <0x0 0x80000>;
+					label = "u-boot";
+				};
+
+				partition at 100000 {
+					reg = <0x100000 0x10000>;
+					label = "u-boot env";
+				};
+
+				partition at 180000 {
+					reg = <0x180000 0x10000>;
+					label = "dtb";
+				};
+			};
+		};
 	};
 };
diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
index 55e357a..b3aba7d 100644
--- a/arch/arm/mach-kirkwood/board-dreamplug.c
+++ b/arch/arm/mach-kirkwood/board-dreamplug.c
@@ -36,42 +36,6 @@
 #include "common.h"
 #include "mpp.h"
 
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
@@ -137,10 +101,6 @@ void __init dreamplug_init(void)
 	 */
 	kirkwood_mpp_conf(dreamplug_mpp_config);
 
-	spi_register_board_info(dreamplug_spi_slave_info,
-				ARRAY_SIZE(dreamplug_spi_slave_info));
-	kirkwood_spi_init();
-
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&dreamplug_ge00_data);
 	kirkwood_ge01_init(&dreamplug_ge01_data);
-- 
1.7.2.5
