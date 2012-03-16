From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 Mar 2012 04:21:26 +0000
Subject: [PATCH 6/9 v2] ARM: kirkwood: fdt: facilitate new boards during fdt
 migration
In-Reply-To: <cover.1331868507.git.jason@lakedaemon.net>
References: <cover.1331868507.git.jason@lakedaemon.net>
Message-ID: <232cbb0b517d8497ff1e5ad22d48ef2713b473e6.1331868507.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move all dreamplug-specific code out of board-dt.c and into
board-dreamplug.c.  This way new boards that are added during the
conversion to fdt don't clutter up board-dt.c.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---

Changes from v1:

    - This code was broken out into a separate patch so that it could apply
      cleanly to code already in arm-soc/next/boards
    - protected the declaration of dreamplug_init() in common.h with #ifdef on
      CONFIG_MACH_DREAMPLUG_DT

 arch/arm/mach-kirkwood/Makefile          |    1 +
 arch/arm/mach-kirkwood/board-dreamplug.c |  152 ++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dt.c        |  133 +--------------------------
 arch/arm/mach-kirkwood/common.h          |    8 ++
 4 files changed, 162 insertions(+), 132 deletions(-)
 create mode 100644 arch/arm/mach-kirkwood/board-dreamplug.c

diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index acbc5e1..e299a95 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
 
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
+obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
new file mode 100644
index 0000000..9854539
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-dreamplug.c
@@ -0,0 +1,152 @@
+/*
+ * Copyright 2012 (C), Jason Cooper <jason@lakedaemon.net>
+ *
+ * arch/arm/mach-kirkwood/board-dreamplug.c
+ *
+ * Marvell DreamPlug Reference Board Init for drivers not converted to
+ * flattened device tree yet.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/partitions.h>
+#include <linux/ata_platform.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/gpio.h>
+#include <linux/leds.h>
+#include <linux/mtd/physmap.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/orion_spi.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <mach/kirkwood.h>
+#include <mach/bridge-regs.h>
+#include <plat/mvsdio.h>
+#include "common.h"
+#include "mpp.h"
+
+struct mtd_partition dreamplug_partitions[] = {
+	{
+		.name	= "u-boot",
+		.size	= SZ_512K,
+		.offset = 0,
+	},
+	{
+		.name	= "u-boot env",
+		.size	= SZ_64K,
+		.offset = SZ_512K + SZ_512K,
+	},
+	{
+		.name	= "dtb",
+		.size	= SZ_64K,
+		.offset = SZ_512K + SZ_512K + SZ_512K,
+	},
+};
+
+static const struct flash_platform_data dreamplug_spi_slave_data = {
+	.type		= "mx25l1606e",
+	.name		= "spi_flash",
+	.parts		= dreamplug_partitions,
+	.nr_parts	= ARRAY_SIZE(dreamplug_partitions),
+};
+
+static struct spi_board_info __initdata dreamplug_spi_slave_info[] = {
+	{
+		.modalias	= "m25p80",
+		.platform_data	= &dreamplug_spi_slave_data,
+		.irq		= -1,
+		.max_speed_hz	= 50000000,
+		.bus_num	= 0,
+		.chip_select	= 0,
+	},
+};
+
+static struct mv643xx_eth_platform_data dreamplug_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
+};
+
+static struct mv643xx_eth_platform_data dreamplug_ge01_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
+};
+
+static struct mv_sata_platform_data dreamplug_sata_data = {
+	.n_ports	= 1,
+};
+
+static struct mvsdio_platform_data dreamplug_mvsdio_data = {
+	/* unfortunately the CD signal has not been connected */
+};
+
+static struct gpio_led dreamplug_led_pins[] = {
+	{
+		.name			= "dreamplug:blue:bluetooth",
+		.gpio			= 47,
+		.active_low		= 1,
+	},
+	{
+		.name			= "dreamplug:green:wifi",
+		.gpio			= 48,
+		.active_low		= 1,
+	},
+	{
+		.name			= "dreamplug:green:wifi_ap",
+		.gpio			= 49,
+		.active_low		= 1,
+	},
+};
+
+static struct gpio_led_platform_data dreamplug_led_data = {
+	.leds		= dreamplug_led_pins,
+	.num_leds	= ARRAY_SIZE(dreamplug_led_pins),
+};
+
+static struct platform_device dreamplug_leds = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &dreamplug_led_data,
+	}
+};
+
+static unsigned int dreamplug_mpp_config[] __initdata = {
+	MPP0_SPI_SCn,
+	MPP1_SPI_MOSI,
+	MPP2_SPI_SCK,
+	MPP3_SPI_MISO,
+	MPP47_GPIO,	/* Bluetooth LED */
+	MPP48_GPIO,	/* Wifi LED */
+	MPP49_GPIO,	/* Wifi AP LED */
+	0
+};
+
+void __init dreamplug_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_mpp_conf(dreamplug_mpp_config);
+
+	spi_register_board_info(dreamplug_spi_slave_info,
+				ARRAY_SIZE(dreamplug_spi_slave_info));
+	kirkwood_spi_init();
+
+	kirkwood_ehci_init();
+	kirkwood_ge00_init(&dreamplug_ge00_data);
+	kirkwood_ge01_init(&dreamplug_ge01_data);
+	kirkwood_sata_init(&dreamplug_sata_data);
+	kirkwood_sdio_init(&dreamplug_mvsdio_data);
+
+	platform_device_register(&dreamplug_leds);
+}
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 9bd35ac..975ad01 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -3,7 +3,7 @@
  *
  * arch/arm/mach-kirkwood/board-dt.c
  *
- * Marvell DreamPlug Reference Board Setup
+ * Flattened Device Tree board initialization
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
@@ -12,149 +12,18 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/partitions.h>
-#include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_fdt.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/gpio.h>
-#include <linux/leds.h>
-#include <linux/mtd/physmap.h>
-#include <linux/spi/flash.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/orion_spi.h>
-#include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <mach/kirkwood.h>
 #include <mach/bridge-regs.h>
-#include <plat/mvsdio.h>
 #include "common.h"
-#include "mpp.h"
 
 static struct of_device_id kirkwood_dt_match_table[] __initdata = {
 	{ .compatible = "simple-bus", },
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
-static struct mv643xx_eth_platform_data dreamplug_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
-};
-
-static struct mv643xx_eth_platform_data dreamplug_ge01_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
-};
-
-static struct mv_sata_platform_data dreamplug_sata_data = {
-	.n_ports	= 1,
-};
-
-static struct mvsdio_platform_data dreamplug_mvsdio_data = {
-	/* unfortunately the CD signal has not been connected */
-};
-
-static struct gpio_led dreamplug_led_pins[] = {
-	{
-		.name			= "dreamplug:blue:bluetooth",
-		.gpio			= 47,
-		.active_low		= 1,
-	},
-	{
-		.name			= "dreamplug:green:wifi",
-		.gpio			= 48,
-		.active_low		= 1,
-	},
-	{
-		.name			= "dreamplug:green:wifi_ap",
-		.gpio			= 49,
-		.active_low		= 1,
-	},
-};
-
-static struct gpio_led_platform_data dreamplug_led_data = {
-	.leds		= dreamplug_led_pins,
-	.num_leds	= ARRAY_SIZE(dreamplug_led_pins),
-};
-
-static struct platform_device dreamplug_leds = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &dreamplug_led_data,
-	}
-};
-
-static unsigned int dreamplug_mpp_config[] __initdata = {
-	MPP0_SPI_SCn,
-	MPP1_SPI_MOSI,
-	MPP2_SPI_SCK,
-	MPP3_SPI_MISO,
-	MPP47_GPIO,	/* Bluetooth LED */
-	MPP48_GPIO,	/* Wifi LED */
-	MPP49_GPIO,	/* Wifi AP LED */
-	0
-};
-
-static void __init dreamplug_init(void)
-{
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_mpp_conf(dreamplug_mpp_config);
-
-	spi_register_board_info(dreamplug_spi_slave_info,
-				ARRAY_SIZE(dreamplug_spi_slave_info));
-	kirkwood_spi_init();
-
-	kirkwood_ehci_init();
-	kirkwood_ge00_init(&dreamplug_ge00_data);
-	kirkwood_ge01_init(&dreamplug_ge01_data);
-	kirkwood_sata_init(&dreamplug_sata_data);
-	kirkwood_sdio_init(&dreamplug_mvsdio_data);
-
-	platform_device_register(&dreamplug_leds);
-}
-
 static void __init kirkwood_dt_init(void)
 {
 	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index c382447..4737578 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -51,6 +51,14 @@ void kirkwood_nand_init_rnb(struct mtd_partition *parts, int nr_parts, int (*dev
 void kirkwood_audio_init(void);
 void kirkwood_restart(char, const char *);
 
+/* board init functions for boards not fully converted to fdt */
+#ifdef CONFIG_MACH_DREAMPLUG_DT
+void dreamplug_init(void);
+#else
+static inline void dreamplug_init(void) {};
+#endif
+
+/* early init functions not converted to fdt yet */
 char *kirkwood_id(void);
 void kirkwood_l2_init(void);
 void kirkwood_rtc_init(void);
-- 
1.7.3.4
