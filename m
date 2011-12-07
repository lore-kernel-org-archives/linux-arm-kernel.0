From: linux_arm@lakedaemon.net (Jason Cooper)
Date: Wed,  7 Dec 2011 19:40:40 +0000
Subject: [PATCH V3] arm: kirkwood: add dreamplug support.
In-Reply-To: <cover.1312906908.git.jason@lakedaemon.net>
References: <cover.1312906908.git.jason@lakedaemon.net>
Message-ID: <1323286840-9796-1-git-send-email-linux_arm@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copied guruplug-setup.c and did s/guruplug/dreamplug/g.  Then, switched
to SPI based NOR flash.

Signed-off-by: Jason Cooper <linux_arm@lakedaemon.net>
---
Changes from v1

   - attempting dts, looking for pointers.

Changes from v2

   - resubmit as MACH_TYPE_DREAMPLUG (3550) is in arm/for-next, rebased
     against same.
   - removed lame fdt attempt, others are working on kirkwood fdt.  Will
     convert once kirkwood fdt is mainline.
   - s/boot_params/atag_offset/
   - added kirkwood_reset
   - 1 checkpatch.pl warning (help in Kconfig), looks the same as all
     other kirkwood boards...

 arch/arm/mach-kirkwood/Kconfig           |    6 +
 arch/arm/mach-kirkwood/Makefile          |    1 +
 arch/arm/mach-kirkwood/dreamplug-setup.c |  151 ++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-kirkwood/dreamplug-setup.c

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 7fc603b..e93c610 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -44,6 +44,12 @@ config MACH_GURUPLUG
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell GuruPlug Reference Board.
 
+config MACH_DREAMPLUG
+	bool "Marvell DreamPlug Reference Board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell DreamPlug Reference Board.
+
 config MACH_TS219
 	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 5dcaa81..c443a13 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
 obj-$(CONFIG_MACH_SHEEVAPLUG)		+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_ESATA_SHEEVAPLUG)	+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_GURUPLUG)		+= guruplug-setup.o
+obj-$(CONFIG_MACH_DREAMPLUG)		+= dreamplug-setup.o
 obj-$(CONFIG_MACH_DOCKSTAR)		+= dockstar-setup.o
 obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
diff --git a/arch/arm/mach-kirkwood/dreamplug-setup.c b/arch/arm/mach-kirkwood/dreamplug-setup.c
new file mode 100644
index 0000000..09cdd95
--- /dev/null
+++ b/arch/arm/mach-kirkwood/dreamplug-setup.c
@@ -0,0 +1,151 @@
+/*
+ * arch/arm/mach-kirkwood/dreamplug-setup.c
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
+static void __init dreamplug_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_init();
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
+
+MACHINE_START(DREAMPLUG, "Marvell DreamPlug Reference Board")
+	/* Maintainer: Siddarth Gore <gores@marvell.com> */
+	.atag_offset    = 0x100,
+	.init_machine	= dreamplug_init,
+	.map_io		= kirkwood_map_io,
+	.init_early	= kirkwood_init_early,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &kirkwood_timer,
+	.restart        = kirkwood_restart,
+MACHINE_END
-- 
1.7.0.4
