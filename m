From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:17 +0900
Subject: [PATCH 21/26] ARM: shmobile: Lager:add SPI FLASH support on QSPI
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <24cf82f44213fe4d36157d9920b59420159616ec.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

This patch enables Spansion S25FL512SAGMFIG11 chip on QSPI,
Add support for the QSPI interface on Lager.

Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 64 ++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index d47052e..04cb932 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -39,6 +39,11 @@
 #include <mach/r8a7790.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/mtd.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/rspi.h>
+#include <linux/spi/spi.h>
 
 /* DU */
 static struct rcar_du_encoder_data lager_du_encoders[] = {
@@ -166,6 +171,59 @@ static const struct resource ether_resources[] __initconst = {
 	DEFINE_RES_IRQ(gic_spi(162)),
 };
 
+/* SPI Flash memory (Spansion S25FL512SAGMFIG11 64Mb) */
+static struct mtd_partition spi_flash_part[] = {
+	/* Reserved for user loader program, read-only */
+	{
+		.name = "loader",
+		.offset = 0,
+		.size = SZ_256K,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	/* Reserved for user program, read-only */
+	{
+		.name = "user",
+		.offset = MTDPART_OFS_APPEND,
+		.size = SZ_4M,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	/* All else is writable (e.g. JFFS2) */
+	{
+		.name = "flash",
+		.offset = MTDPART_OFS_APPEND,
+		.size = MTDPART_SIZ_FULL,
+		.mask_flags = 0,
+	},
+};
+
+static struct flash_platform_data spi_flash_data = {
+	.name           = "m25p80",
+	.parts          = spi_flash_part,
+	.nr_parts       = ARRAY_SIZE(spi_flash_part),
+	.type           = "s25fl512s",
+};
+
+static const struct rspi_plat_data qspi_pdata __initconst = {
+	.num_chipselect	= 1,
+};
+
+static const struct spi_board_info spi_info[] __initconst = {
+	{
+		.modalias               = "m25p80",
+		.platform_data          = &spi_flash_data,
+		.mode                   = SPI_MODE_0,
+		.max_speed_hz           = 30000000,
+		.bus_num                = 0,
+		.chip_select            = 0,
+	},
+};
+
+/* QSPI resource */
+static const struct resource qspi_resources[] __initconst = {
+	DEFINE_RES_MEM(0xe6b10000, 0x1000),
+	DEFINE_RES_IRQ(gic_spi(184)),
+};
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* DU (CN10: ARGB0, CN13: LVDS) */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
@@ -223,6 +281,12 @@ static void __init lager_add_standard_devices(void)
 					  &ether_pdata, sizeof(ether_pdata));
 
 	lager_add_du_device();
+
+	platform_device_register_resndata(&platform_bus, "qspi", 0,
+					  qspi_resources,
+					  ARRAY_SIZE(qspi_resources),
+					  &qspi_pdata, sizeof(qspi_pdata));
+	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
 }
 
 /*
-- 
1.8.4
