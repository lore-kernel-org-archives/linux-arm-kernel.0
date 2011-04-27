From: camhirundo@gmail.com (Hirundo Cam)
Date: Thu, 28 Apr 2011 00:34:46 +0800
Subject: [PATCH] kirkwood: add dir-665 support
Message-ID: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is a hack to dir-665 by referencing mv88f6281gtw_ge board.
LEDs, GPIO, Buttons remains unknown.

To use this patch, u-boot must also be modified.

Signed-off-by: Hirundo Cam <camhirundo@gmail.com>
---
 arch/arm/mach-kirkwood/Kconfig            |    6 ++
 arch/arm/mach-kirkwood/Makefile           |    1 +
 arch/arm/mach-kirkwood/mv88f6281_dir665.c |  107 +++++++++++++++++++++++++++++
 arch/arm/tools/mach-types                 |    1 +
 4 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-kirkwood/mv88f6281_dir665.c

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 7fc603b..296d97f 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -26,6 +26,12 @@ config MACH_MV88F6281GTW_GE
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell 88F6281 GTW GE Board.
 
+config MACH_MV88F6281_DIR665
+	bool "Marvell 88F6281 DIR665 Board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  88F6281 DIR665 Board.
+
 config MACH_SHEEVAPLUG
 	bool "Marvell SheevaPlug Reference Board"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 5dcaa81..f86649f 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -3,6 +3,7 @@ obj-y				+= common.o addr-map.o irq.o pcie.o mpp.o
 obj-$(CONFIG_MACH_DB88F6281_BP)		+= db88f6281-bp-setup.o
 obj-$(CONFIG_MACH_RD88F6192_NAS)	+= rd88f6192-nas-setup.o
 obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
+obj-$(CONFIG_MACH_MV88F6281_DIR665)	+= mv88f6281_dir665.o
 obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
 obj-$(CONFIG_MACH_SHEEVAPLUG)		+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_ESATA_SHEEVAPLUG)	+= sheevaplug-setup.o
diff --git a/arch/arm/mach-kirkwood/mv88f6281_dir665.c b/arch/arm/mach-kirkwood/mv88f6281_dir665.c
new file mode 100644
index 0000000..41aa7ef
--- /dev/null
+++ b/arch/arm/mach-kirkwood/mv88f6281_dir665.c
@@ -0,0 +1,107 @@
+/*
+ * arch/arm/mach-kirkwood/mv88f6281_dir665.c
+ *
+ * Marvell 88F6281 DIR-665 Board Setup
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/mtd/physmap.h>
+#include <linux/timer.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/ethtool.h>
+#include <linux/gpio.h>
+#include <linux/leds.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/orion_spi.h>
+#include <net/dsa.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/pci.h>
+#include <mach/kirkwood.h>
+#include "common.h"
+#include "mpp.h"
+
+static struct mv643xx_eth_platform_data mv88f6281_dir665_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_NONE,
+	.speed		= SPEED_1000,
+	.duplex		= DUPLEX_FULL,
+};
+
+static struct mv643xx_eth_platform_data mv88f6281_dir665_ge01_data = {
+	.phy_addr	= MV643XX_ETH_PHY_NONE,
+	.speed		= SPEED_1000,
+	.duplex		= DUPLEX_FULL,
+};
+
+static struct dsa_chip_data mv88f6281_dir665_switch_chip_data = {
+	.port_names[0]	= "lan4",
+	.port_names[1]	= "lan3",
+	.port_names[2]	= "lan2",
+	.port_names[3]	= "lan1",
+	.port_names[6]	= "cpu",
+};
+
+static struct dsa_platform_data mv88f6281_dir665_switch_plat_data = {
+	.nr_chips	= 1,
+	.chip		= &mv88f6281_dir665_switch_chip_data,
+};
+
+static const struct flash_platform_data mv88f6281_dir665_spi_slave_data = {
+	.type		= "mx25l12805d",
+};
+
+static struct spi_board_info __initdata mv88f6281_dir665_spi_slave_info[] = {
+	{
+		.modalias	= "m25p80",
+		.platform_data	= &mv88f6281_dir665_spi_slave_data,
+		.irq		= -1,
+		.max_speed_hz	= 50000000,
+		.bus_num	= 0,
+		.chip_select	= 0,
+	},
+};
+
+static void __init mv88f6281_dir665_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_init();
+
+	kirkwood_ehci_init();
+	kirkwood_ge00_init(&mv88f6281_dir665_ge00_data);
+	kirkwood_ge01_init(&mv88f6281_dir665_ge01_data);
+	kirkwood_ge00_switch_init(&mv88f6281_dir665_switch_plat_data, NO_IRQ);
+	spi_register_board_info(mv88f6281_dir665_spi_slave_info,
+				ARRAY_SIZE(mv88f6281_dir665_spi_slave_info));
+	kirkwood_spi_init();
+	kirkwood_uart0_init();
+}
+
+static int __init mv88f6281_dir665_pci_init(void)
+{
+	if (machine_is_mv88f6281_dir665())
+		kirkwood_pcie_init(KW_PCIE0);
+
+	return 0;
+}
+subsys_initcall(mv88f6281_dir665_pci_init);
+
+MACHINE_START(MV88F6281_DIR665, "Marvell 88F6281 DIR665 Board")
+	.boot_params	= 0x00000100,
+	.init_machine	= mv88f6281_dir665_init,
+	.map_io		= kirkwood_map_io,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &kirkwood_timer,
+MACHINE_END
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 7ca41f0..02d008d 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -1099,3 +1099,4 @@ ecuv5			MACH_ECUV5		ECUV5			3421
 hsgx6d			MACH_HSGX6D		HSGX6D			3422
 dawad7			MACH_DAWAD7		DAWAD7			3423
 sam9repeater		MACH_SAM9REPEATER	SAM9REPEATER		3424
+mv88f6281_dir665	MACH_MV88F6281_DIR665	MV88F6281_DIR665	3425
-- 
1.7.3.5
