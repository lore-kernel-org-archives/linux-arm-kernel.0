From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 27 Dec 2013 21:15:58 +0100
Subject: [PATCH v2 4/8] ARM: shmobile: genmai: Add RSPI children
In-Reply-To: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
References: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1388175362-17132-5-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

On this board, only rspi4 is in use. Its bus contains a single device
(a wm8978 audio codec).

As the RSPI driver itself doesn't use DT yet, we have to instantiate the
SPI child device in C code, too, for both genmai and genmai-reference.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
New in v2

 arch/arm/mach-shmobile/board-genmai-reference.c |   11 +++++++++++
 arch/arm/mach-shmobile/board-genmai.c           |   11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index 7630c1053e32..2f8094b3add2 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
@@ -21,11 +21,21 @@
 #include <linux/clk-provider.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/spi/spi.h>
 #include <mach/common.h>
 #include <mach/r7s72100.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
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
 #ifdef CONFIG_COMMON_CLK
@@ -34,6 +44,7 @@ static void __init genmai_add_standard_devices(void)
 	r7s72100_clock_init();
 #endif
 	r7s72100_add_dt_devices();
+	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
diff --git a/arch/arm/mach-shmobile/board-genmai.c b/arch/arm/mach-shmobile/board-genmai.c
index a1f6fe1fb06f..7c912d337828 100644
--- a/arch/arm/mach-shmobile/board-genmai.c
+++ b/arch/arm/mach-shmobile/board-genmai.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/sh_eth.h>
+#include <linux/spi/spi.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r7s72100.h>
@@ -41,11 +42,21 @@ static const struct resource ether_resources[] __initconst = {
 	DEFINE_RES_IRQ(gic_iid(359)),
 };
 
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
 
+	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
 	platform_device_register_resndata(&platform_bus, "r7s72100-ether", -1,
 					  ether_resources,
 					  ARRAY_SIZE(ether_resources),
-- 
1.7.9.5
