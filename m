From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 19 Jun 2013 22:22:21 +0900
Subject: [PATCH 3/5] ARM: shmobile: bockw: add SPI FLASH support
In-Reply-To: <1371648143-18376-1-git-send-email-horms+renesas@verge.net.au>
References: <1371648143-18376-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371648143-18376-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch enables Spansion S25FL008K chip on HSPI0

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index a4251cc..7d42f12 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -20,11 +20,14 @@
 
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
+#include <linux/mtd/partitions.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a7778.h>
@@ -84,10 +87,40 @@ static struct i2c_board_info i2c0_devices[] = {
 	},
 };
 
+/* HSPI*/
+static struct mtd_partition m25p80_spi_flash_partitions[] = {
+	{
+		.name	= "data(spi)",
+		.size	= 0x0100000,
+		.offset	= 0,
+	},
+};
+
+static struct flash_platform_data spi_flash_data = {
+	.name		= "m25p80",
+	.type		= "s25fl008k",
+	.parts		= m25p80_spi_flash_partitions,
+	.nr_parts	= ARRAY_SIZE(m25p80_spi_flash_partitions),
+};
+
+static struct spi_board_info spi_board_info[] __initdata = {
+	{
+		.modalias	= "m25p80",
+		.max_speed_hz	= 104000000,
+		.chip_select	= 0,
+		.bus_num	= 0,
+		.mode		= SPI_MODE_0,
+		.platform_data	= &spi_flash_data,
+	},
+};
+
 static const struct pinctrl_map bockw_pinctrl_map[] = {
 	/* Ether */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7778",
 				  "ether_rmii", "ether"),
+	/* HSPI0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-hspi.0", "pfc-r8a7778",
+				  "hspi0_a", "hspi0"),
 	/* SCIF0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
 				  "scif0_data_a", "scif0"),
@@ -111,9 +144,12 @@ static void __init bockw_init(void)
 	r8a7778_add_standard_devices();
 	r8a7778_add_ether_device(&ether_platform_data);
 	r8a7778_add_i2c_device(0);
+	r8a7778_add_hspi_device(0);
 
 	i2c_register_board_info(0, i2c0_devices,
 				ARRAY_SIZE(i2c0_devices));
+	spi_register_board_info(spi_board_info,
+				ARRAY_SIZE(spi_board_info));
 	pinctrl_register_mappings(bockw_pinctrl_map,
 				  ARRAY_SIZE(bockw_pinctrl_map));
 	r8a7778_pinmux_init();
-- 
1.8.2.1
