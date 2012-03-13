From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 Mar 2012 01:57:46 +0000
Subject: [PATCH 4/7 v4] ARM: kirkwood: add dreamplug (fdt) support.
In-Reply-To: <cover.1331601448.git.jason@lakedaemon.net>
References: <cover.1331601448.git.jason@lakedaemon.net>
Message-ID: <0032addd7e94c5d4d1a3a0be77fe79bcffee53db.1331601448.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initially, copied guruplug-setup.c and did s/guruplug/dreamplug/g.
Then, switched to SPI based NOR flash.

After talking to Arnd Bergman, chose an incremental approach to adding
devicetree support.  First, we use the dtb to tell us we are on the
dreamplug, then we gradually port over drivers.

Driver porting will start with the uart (see next patch), and progress
from there.  Next, all drivers not needing common clock (kirkwood_tclk)
or pinmux.  Then, remain drivers as that support hits the tree.

We need to absorb kirkwood_init() into kirkwood_dt_init() so that as we
convert drivers, we can remove the platform call, eg
kirkwood_rtc_init().  This maintains compatibility with non-fdt
configurations because they still call kirkwood_init() in common.c.

As drivers are converted, we will reinstate the 'static' qualifier in
common.c.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---

Changes from v3:

* squashed absorbing kirkwood_init() into board-dt.c into this patch
* split dreamplug_init() out of board-dt.c into board-dreamplug.c to facilitate
  other boards coming in during conversion process.
* removed Acked's and Reviewed-By's as code has changed significantly and
  absorbed several other patches.

Changes from v2:

* s/marvell,/mrvl,/g for compatible properties

 arch/arm/boot/dts/kirkwood-dreamplug.dts |   17 ++++
 arch/arm/boot/dts/kirkwood.dtsi          |    6 +
 arch/arm/mach-kirkwood/Kconfig           |   14 +++
 arch/arm/mach-kirkwood/Makefile          |    2 +
 arch/arm/mach-kirkwood/Makefile.boot     |    2 +
 arch/arm/mach-kirkwood/board-dreamplug.c |  151 ++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dt.c        |   76 +++++++++++++++
 arch/arm/mach-kirkwood/common.c          |   12 +-
 arch/arm/mach-kirkwood/common.h          |   12 +++
 9 files changed, 286 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-dreamplug.dts
 create mode 100644 arch/arm/boot/dts/kirkwood.dtsi
 create mode 100644 arch/arm/mach-kirkwood/board-dreamplug.c
 create mode 100644 arch/arm/mach-kirkwood/board-dt.c

diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
new file mode 100644
index 0000000..9946d01
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -0,0 +1,17 @@
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+
+/ {
+	model = "Globalscale Technologies Dreamplug";
+	compatible = "globalscale,dreamplug-003-ds2001", "globalscale,dreamplug", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
new file mode 100644
index 0000000..702b955
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -0,0 +1,6 @@
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "mrvl,kirkwood";
+};
+
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 7fc603b..90ceab7 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -44,6 +44,20 @@ config MACH_GURUPLUG
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell GuruPlug Reference Board.
 
+config ARCH_KIRKWOOD_DT
+	bool "Marvell Kirkwood Flattened Device Tree"
+	select USE_OF
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell Kirkwood using flattened device tree.
+
+config MACH_DREAMPLUG_DT
+	bool "Marvell DreamPlug (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell DreamPlug (Flattened Device Tree).
+
 config MACH_TS219
 	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 5dcaa81..e299a95 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -20,3 +20,5 @@ obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
 
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
+obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
+obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
index 760a0ef..16f9385 100644
--- a/arch/arm/mach-kirkwood/Makefile.boot
+++ b/arch/arm/mach-kirkwood/Makefile.boot
@@ -1,3 +1,5 @@
    zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
+
+dtb-$(CONFIG_MACH_DREAMPLUG_DT) += kirkwood-dreamplug.dtb
diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
new file mode 100644
index 0000000..3b37315
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-dreamplug.c
@@ -0,0 +1,151 @@
+/*
+ * Copyright 2012 (C), Jason Cooper <jason@lakedaemon.net>
+ *
+ * arch/arm/mach-kirkwood/board-dt.c
+ *
+ * Marvell DreamPlug Reference Board Setup
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
+#include <mach/kirkwood.h>
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
+	kirkwood_uart0_init();
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
new file mode 100644
index 0000000..ce008f2
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -0,0 +1,76 @@
+/*
+ * Copyright 2012 (C), Jason Cooper <jason@lakedaemon.net>
+ *
+ * arch/arm/mach-kirkwood/board-dt.c
+ *
+ * Marvell DreamPlug Reference Board Setup
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <mach/bridge-regs.h>
+#include "common.h"
+
+static struct of_device_id kirkwood_dt_match_table[] __initdata = {
+	{ .compatible = "simple-bus", },
+	{ }
+};
+
+static void __init kirkwood_dt_init(void)
+{
+	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
+
+	/*
+	 * Disable propagation of mbus errors to the CPU local bus,
+	 * as this causes mbus errors (which can occur for example
+	 * for PCI aborts) to throw CPU aborts, which we're not set
+	 * up to deal with.
+	 */
+	writel(readl(CPU_CONFIG) & ~CPU_CONFIG_ERROR_PROP, CPU_CONFIG);
+
+	kirkwood_setup_cpu_mbus();
+
+#ifdef CONFIG_CACHE_FEROCEON_L2
+	kirkwood_l2_init();
+#endif
+
+	/* internal devices that every board has */
+	kirkwood_rtc_init();
+	kirkwood_wdt_init();
+	kirkwood_xor0_init();
+	kirkwood_xor1_init();
+	kirkwood_crypto_init();
+
+#ifdef CONFIG_KEXEC
+	kexec_reinit = kirkwood_enable_pcie;
+#endif
+
+	if (of_machine_is_compatible("globalscale,dreamplug"))
+		dreamplug_init();
+
+	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
+}
+
+static const char *kirkwood_dt_board_compat[] = {
+	"globalscale,dreamplug",
+	NULL
+};
+
+DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)")
+	/* Maintainer: Jason Cooper <jason@lakedaemon.net> */
+	.map_io		= kirkwood_map_io,
+	.init_early	= kirkwood_init_early,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &kirkwood_timer,
+	.init_machine	= kirkwood_dt_init,
+	.restart	= kirkwood_restart,
+	.dt_compat	= kirkwood_dt_board_compat,
+MACHINE_END
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index eacf7f5..ae90f60 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -162,7 +162,7 @@ void __init kirkwood_nand_init_rnb(struct mtd_partition *parts, int nr_parts,
 /*****************************************************************************
  * SoC RTC
  ****************************************************************************/
-static void __init kirkwood_rtc_init(void)
+void __init kirkwood_rtc_init(void)
 {
 	orion_rtc_init(RTC_PHYS_BASE, IRQ_KIRKWOOD_RTC);
 }
@@ -278,7 +278,7 @@ void __init kirkwood_crypto_init(void)
 /*****************************************************************************
  * XOR0
  ****************************************************************************/
-static void __init kirkwood_xor0_init(void)
+void __init kirkwood_xor0_init(void)
 {
 	kirkwood_clk_ctrl |= CGC_XOR0;
 
@@ -290,7 +290,7 @@ static void __init kirkwood_xor0_init(void)
 /*****************************************************************************
  * XOR1
  ****************************************************************************/
-static void __init kirkwood_xor1_init(void)
+void __init kirkwood_xor1_init(void)
 {
 	kirkwood_clk_ctrl |= CGC_XOR1;
 
@@ -302,7 +302,7 @@ static void __init kirkwood_xor1_init(void)
 /*****************************************************************************
  * Watchdog
  ****************************************************************************/
-static void __init kirkwood_wdt_init(void)
+void __init kirkwood_wdt_init(void)
 {
 	orion_wdt_init(kirkwood_tclk);
 }
@@ -391,7 +391,7 @@ void __init kirkwood_audio_init(void)
 /*
  * Identify device ID and revision.
  */
-static char * __init kirkwood_id(void)
+char * __init kirkwood_id(void)
 {
 	u32 dev, rev;
 
@@ -434,7 +434,7 @@ static char * __init kirkwood_id(void)
 	}
 }
 
-static void __init kirkwood_l2_init(void)
+void __init kirkwood_l2_init(void)
 {
 #ifdef CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH
 	writel(readl(L2_CONFIG_REG) | L2_WRITETHROUGH, L2_CONFIG_REG);
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 9071a39..194daa9 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -51,6 +51,18 @@ void kirkwood_nand_init_rnb(struct mtd_partition *parts, int nr_parts, int (*dev
 void kirkwood_audio_init(void);
 void kirkwood_restart(char, const char *);
 
+/* board init functions for drivers not converted to fdt */
+void dreamplug_init(void);
+
+/* early init functions not converted to fdt yet */
+char *kirkwood_id(void);
+void kirkwood_l2_init(void);
+void kirkwood_rtc_init(void);
+void kirkwood_wdt_init(void);
+void kirkwood_xor0_init(void);
+void kirkwood_xor1_init(void);
+void kirkwood_crypto_init(void);
+
 extern int kirkwood_tclk;
 extern struct sys_timer kirkwood_timer;
 
-- 
1.7.3.4
