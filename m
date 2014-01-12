From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 11:48:41 +0100
Subject: [PATCH V3 3/5] ARM: shmobile: genmai: Add RSPI support
In-Reply-To: <1389523723-2288-1-git-send-email-geert@linux-m68k.org>
References: <1389523723-2288-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1389523723-2288-4-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add RSPI platform device, resources, platform data, and SPI child.

On this board, only rspi4 is in use. Its bus contains a single device
(a wm8978 audio codec).

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
V2:
  - Correct platform device names ("rspi%u.0" -> "rspi.%u")
  - Add missing platform data
  - Correct summary (resources -> platform devices)
V3:
  - Move platform devices from setup-r7s72100.c to board-genmai.c, as
    genmai-reference will use devices instantiated from DT
  - Merge with "ARM: shmobile: genmai: Add RSPI children", as this now
    touches the same file
  - Instantiate SPI children in C on genmai only, as genmai-reference will
    instantiate them from DT

 arch/arm/mach-shmobile/board-genmai.c |   45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-genmai.c b/arch/arm/mach-shmobile/board-genmai.c
index a1f6fe1fb06f..f85628e24de4 100644
--- a/arch/arm/mach-shmobile/board-genmai.c
+++ b/arch/arm/mach-shmobile/board-genmai.c
@@ -21,6 +21,8 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/sh_eth.h>
+#include <linux/spi/rspi.h>
+#include <linux/spi/spi.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r7s72100.h>
@@ -41,11 +43,54 @@ static const struct resource ether_resources[] __initconst = {
 	DEFINE_RES_IRQ(gic_iid(359)),
 };
 
+/* RSPI */
+#define RSPI_RESOURCE(idx, baseaddr, irq)				\
+static const struct resource rspi##idx##_resources[] __initconst = {	\
+	DEFINE_RES_MEM(baseaddr, 0x24),					\
+	DEFINE_RES_IRQ(irq),		/* SPEI */			\
+	DEFINE_RES_IRQ(irq + 1),	/* SPRI */			\
+	DEFINE_RES_IRQ(irq + 2),	/* SPTI */			\
+}
+
+RSPI_RESOURCE(0, 0xe800c800, gic_iid(270));
+RSPI_RESOURCE(1, 0xe800d000, gic_iid(273));
+RSPI_RESOURCE(2, 0xe800d800, gic_iid(276));
+RSPI_RESOURCE(3, 0xe800e000, gic_iid(279));
+RSPI_RESOURCE(4, 0xe800e800, gic_iid(282));
+
+static const struct rspi_plat_data rspi_pdata __initconst = {
+	.data_width	= 8,
+	.txmode		= false,
+	.spcr2		= false,
+	.num_chipselect	= 1,
+};
+
+#define r7s72100_register_rspi(idx)					\
+	platform_device_register_resndata(&platform_bus, "rspi", idx,	\
+					rspi##idx##_resources,		\
+					ARRAY_SIZE(rspi##idx##_resources), \
+					&rspi_pdata, sizeof(rspi_pdata))
+
+static const struct spi_board_info spi_info[] __initconst = {
+	{
+		.modalias               = "wm8978",
+		.max_speed_hz           = 5000000,
+		.bus_num                = 4,
+		.chip_select            = 0,
+	},
+};
+
 static void __init genmai_add_standard_devices(void)
 {
 	r7s72100_clock_init();
 	r7s72100_add_dt_devices();
 
+	r7s72100_register_rspi(0);
+	r7s72100_register_rspi(1);
+	r7s72100_register_rspi(2);
+	r7s72100_register_rspi(3);
+	r7s72100_register_rspi(4);
+	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
 	platform_device_register_resndata(&platform_bus, "r7s72100-ether", -1,
 					  ether_resources,
 					  ARRAY_SIZE(ether_resources),
-- 
1.7.9.5
