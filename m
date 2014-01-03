From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri,  3 Jan 2014 16:34:16 +0100
Subject: [PATCH 3/3] ARM: shmobile: Koelsch: Add QSPI support
In-Reply-To: <1388763256-25851-1-git-send-email-geert@linux-m68k.org>
References: <1388763256-25851-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1388763256-25851-4-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Enable support for the Spansion s25fl512s SPI FLASH on the Koelsch board:
  - Add QSPI platform device, resources, platform data, and pinmux,
  - Add FLASH data and MTD partitions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/mach-shmobile/board-koelsch.c |   61 ++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index de7cc64b1f37..723ed54b38be 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -25,12 +25,17 @@
 #include <linux/input.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
 #include <linux/phy.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/rcar-du.h>
 #include <linux/platform_device.h>
 #include <linux/sh_eth.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/rspi.h>
+#include <linux/spi/spi.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a7791.h>
@@ -148,6 +153,55 @@ static const struct gpio_keys_platform_data koelsch_keys_pdata __initconst = {
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
 };
 
+/* QSPI */
+static const struct resource qspi_resources[] __initconst = {
+	DEFINE_RES_MEM(0xe6b10000, 0x1000),
+	DEFINE_RES_IRQ(gic_spi(184)),
+};
+
+static const struct rspi_plat_data qspi_pdata __initconst = {
+	.num_chipselect = 1,
+};
+
+/* SPI Flash memory (Spansion S25FL512SAGMFIG11 64 MiB) */
+static struct mtd_partition spi_flash_part[] = {
+	{
+		.name		= "loader",
+		.offset		= 0x00000000,
+		.size		= 512 * 1024,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	{
+		.name		= "bootenv",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 512 * 1024,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	{
+		.name		= "data",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+static const struct flash_platform_data spi_flash_data = {
+	.name		= "m25p80",
+	.parts		= spi_flash_part,
+	.nr_parts	= ARRAY_SIZE(spi_flash_part),
+	.type		= "s25fl512s",
+};
+
+static const struct spi_board_info spi_info[] __initconst = {
+	{
+		.modalias	= "m25p80",
+		.platform_data	= &spi_flash_data,
+		.mode		= SPI_MODE_0,
+		.max_speed_hz	= 30000000,
+		.bus_num	= 0,
+		.chip_select	= 0,
+	},
+};
+
 static const struct pinctrl_map koelsch_pinctrl_map[] = {
 	/* DU */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7791", "pfc-r8a7791",
@@ -165,6 +219,8 @@ static const struct pinctrl_map koelsch_pinctrl_map[] = {
 				  "eth_rmii", "eth"),
 	PIN_MAP_MUX_GROUP_DEFAULT("r8a7791-ether", "pfc-r8a7791",
 				  "intc_irq0", "intc"),
+	/* QSPI */
+	PIN_MAP_MUX_GROUP_DEFAULT("qspi.0", "pfc-r8a7791", "qspi", "qspi"),
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7791",
 				  "scif0_data_d", "scif0"),
@@ -190,6 +246,11 @@ static void __init koelsch_add_standard_devices(void)
 	platform_device_register_data(&platform_bus, "gpio-keys", -1,
 				      &koelsch_keys_pdata,
 				      sizeof(koelsch_keys_pdata));
+	platform_device_register_resndata(&platform_bus, "qspi", 0,
+					  qspi_resources,
+					  ARRAY_SIZE(qspi_resources),
+					  &qspi_pdata, sizeof(qspi_pdata));
+	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
 
 	koelsch_add_du_device();
 }
-- 
1.7.9.5
