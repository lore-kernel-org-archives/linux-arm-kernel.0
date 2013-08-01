From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  1 Aug 2013 17:07:32 +0200
Subject: [PATCHv2 6/9] ARM: kirkwood: convert the mv88f6281gtw_ge board to DT
In-Reply-To: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375369655-1310-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit converts the mv88f6281gtw_ge Kirkwood board to use a
Device Tree representation, except for the Ethernet devices and the
DSA switch. Even though the mv643xx_eth driver has a DT binding,
converting this board to use it is for now left on the side because it
doesn't use a simple PHY, but a DSA switch instead.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 125 ++++++++++++++++++
 arch/arm/mach-kirkwood/Kconfig                 |  14 +-
 arch/arm/mach-kirkwood/Makefile                |   2 +-
 arch/arm/mach-kirkwood/board-dt.c              |   3 +
 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c |  50 +++++++
 arch/arm/mach-kirkwood/common.h                |   6 +
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c | 172 -------------------------
 8 files changed, 193 insertions(+), 180 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
 create mode 100644 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c
 delete mode 100644 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 277685f..d168bed 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -84,6 +84,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
 	kirkwood-lschlv2.dtb \
 	kirkwood-lsxhl.dtb \
 	kirkwood-mplcec4.dtb \
+	kirkwood-mv88f6281gtw-ge.dtb \
 	kirkwood-netgear_readynas_duo_v2.dtb \
 	kirkwood-ns2.dtb \
 	kirkwood-ns2lite.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
new file mode 100644
index 0000000..13e3576
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
@@ -0,0 +1,125 @@
+/*
+ * Marvell 88F6281 GTW GE Board
+ *
+ * Lennert Buytenhek <buytenh@marvell.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * This file contains the definitions that are common between the 6281
+ * and 6282 variants of the Marvell Kirkwood Development Board.
+ */
+
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+/include/ "kirkwood-6281.dtsi"
+
+/ {
+	model = "Marvell 88F6281 GTW GE Board";
+	compatible = "marvell,mv88f6281gtw-ge", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp at f1000000 {
+		pinctrl at 10000 {
+			pmx_usb_led: pmx-usb-led {
+				marvell,pins = "mpp12";
+				marvell,function = "gpo";
+			};
+
+			pmx_leds: pmx-leds {
+				marvell,pins = "mpp20", "mpp21";
+				marvell,function = "gpio";
+			};
+
+			pmx_keys: pmx-keys {
+				marvell,pins = "mpp46", "mpp47";
+				marvell,function = "gpio";
+			};
+		};
+
+		spi at 10600 {
+			pinctrl-0 = <&pmx_spi>;
+			pinctrl-names = "default";
+			status = "okay";
+
+			flash at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "mx25l12805d";
+				reg = <0>;
+				spi-max-frequency = <50000000>;
+				mode = <0>;
+			};
+		};
+
+		serial at 12000 {
+			pinctrl-0 = <&pmx_uart0>;
+			pinctrl-names = "default";
+			clock-frequency = <200000000>;
+			status = "ok";
+		};
+
+		ehci at 50000 {
+			status = "okay";
+		};
+
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_leds &pmx_usb_led>;
+		pinctrl-names = "default";
+
+		green-status {
+			label = "gtw:green:Status";
+			gpios = <&gpio0 20 0>;
+		};
+
+		red-status {
+			label = "gtw:red:Status";
+			gpios = <&gpio0 21 0>;
+		};
+
+		green-usb {
+			label = "gtw:green:USB";
+			gpios = <&gpio0 12 0>;
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_keys>;
+		pinctrl-names = "default";
+
+		button at 1 {
+			label = "SWR Button";
+			linux,code = <0x198>; /* KEY_RESTART */
+			gpios = <&gpio1 15 1>;
+		};
+		button at 2 {
+			label = "WPS Button";
+			linux,code = <0x211>; /* KEY_WPS_BUTTON */
+			gpios = <&gpio1 14 1>;
+		};
+	};
+};
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 48c61ad..f624162 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -5,13 +5,6 @@ menu "Marvell Kirkwood Implementations"
 config KIRKWOOD_LEGACY
 	bool
 
-config MACH_MV88F6281GTW_GE
-	bool "Marvell 88F6281 GTW GE Board"
-	select KIRKWOOD_LEGACY
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell 88F6281 GTW GE Board.
-
 config MACH_NET2BIG_V2
 	bool "LaCie 2Big Network v2 NAS Board"
 	select KIRKWOOD_LEGACY
@@ -113,6 +106,13 @@ config MACH_DLINK_KIRKWOOD_DT
 	  Kirkwood-based D-Link NASes such as DNS-320 & DNS-325,
 	  using Flattened Device Tree.
 
+config MACH_MV88F6281GTW_GE_DT
+	bool "Marvell 88F6281 GTW GE Board (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell 88F6281 GTW GE Board (Flattened Device Tree).
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index c58723d..0dcc5d4 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -1,7 +1,6 @@
 obj-y				+= common.o pcie.o
 obj-$(CONFIG_KIRKWOOD_LEGACY)	+= irq.o mpp.o
 
-obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
 obj-$(CONFIG_MACH_NET2BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
@@ -13,3 +12,4 @@ obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
 
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
 obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
+obj-$(CONFIG_MACH_MV88F6281GTW_GE_DT)	+= board-mv88f6281gtw_ge.o
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index fac0f8e..b129c65 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -109,6 +109,9 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("dlink,dns-kirkwood"))
 		dnskw_init();
 
+	if (of_machine_is_compatible("marvell,mv88f6281gtw-ge"))
+		mv88f6281gtw_ge_init();
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
diff --git a/arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c b/arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c
new file mode 100644
index 0000000..ee5eea6
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c
@@ -0,0 +1,50 @@
+/*
+ * arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c
+ *
+ * Marvell 88F6281 GTW GE Board Setup
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/timer.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/ethtool.h>
+#include <linux/gpio.h>
+#include <net/dsa.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/pci.h>
+#include <mach/kirkwood.h>
+#include "common.h"
+
+static struct mv643xx_eth_platform_data mv88f6281gtw_ge_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_NONE,
+	.speed		= SPEED_1000,
+	.duplex		= DUPLEX_FULL,
+};
+
+static struct dsa_chip_data mv88f6281gtw_ge_switch_chip_data = {
+	.port_names[0]	= "lan1",
+	.port_names[1]	= "lan2",
+	.port_names[2]	= "lan3",
+	.port_names[3]	= "lan4",
+	.port_names[4]	= "wan",
+	.port_names[5]	= "cpu",
+};
+
+static struct dsa_platform_data mv88f6281gtw_ge_switch_plat_data = {
+	.nr_chips	= 1,
+	.chip		= &mv88f6281gtw_ge_switch_chip_data,
+};
+
+void __init mv88f6281gtw_ge_init(void)
+{
+	kirkwood_ge00_init(&mv88f6281gtw_ge_ge00_data);
+	kirkwood_ge00_switch_init(&mv88f6281gtw_ge_switch_plat_data, NO_IRQ);
+}
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 9d8caae..cc639bb 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -65,6 +65,12 @@ void dnskw_init(void);
 static inline void dnskw_init(void) {};
 #endif
 
+#ifdef CONFIG_MACH_MV88F6281GTW_GE_DT
+void mv88f6281gtw_ge_init(void);
+#else
+static inline void mv88f6281gtw_ge_init(void) {};
+#endif
+
 /* early init functions not converted to fdt yet */
 char *kirkwood_id(void);
 void kirkwood_l2_init(void);
diff --git a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
deleted file mode 100644
index ba384b9..0000000
--- a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
+++ /dev/null
@@ -1,172 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
- *
- * Marvell 88F6281 GTW GE Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
-#include <linux/irq.h>
-#include <linux/mtd/physmap.h>
-#include <linux/timer.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/ethtool.h>
-#include <linux/gpio.h>
-#include <linux/leds.h>
-#include <linux/input.h>
-#include <linux/gpio_keys.h>
-#include <linux/spi/flash.h>
-#include <linux/spi/spi.h>
-#include <net/dsa.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/pci.h>
-#include <mach/kirkwood.h>
-#include "common.h"
-#include "mpp.h"
-
-static struct mv643xx_eth_platform_data mv88f6281gtw_ge_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_NONE,
-	.speed		= SPEED_1000,
-	.duplex		= DUPLEX_FULL,
-};
-
-static struct dsa_chip_data mv88f6281gtw_ge_switch_chip_data = {
-	.port_names[0]	= "lan1",
-	.port_names[1]	= "lan2",
-	.port_names[2]	= "lan3",
-	.port_names[3]	= "lan4",
-	.port_names[4]	= "wan",
-	.port_names[5]	= "cpu",
-};
-
-static struct dsa_platform_data mv88f6281gtw_ge_switch_plat_data = {
-	.nr_chips	= 1,
-	.chip		= &mv88f6281gtw_ge_switch_chip_data,
-};
-
-static const struct flash_platform_data mv88f6281gtw_ge_spi_slave_data = {
-	.type		= "mx25l12805d",
-};
-
-static struct spi_board_info __initdata mv88f6281gtw_ge_spi_slave_info[] = {
-	{
-		.modalias	= "m25p80",
-		.platform_data	= &mv88f6281gtw_ge_spi_slave_data,
-		.irq		= -1,
-		.max_speed_hz	= 50000000,
-		.bus_num	= 0,
-		.chip_select	= 0,
-	},
-};
-
-static struct gpio_keys_button mv88f6281gtw_ge_button_pins[] = {
-	{
-		.code		= KEY_RESTART,
-		.gpio		= 47,
-		.desc		= "SWR Button",
-		.active_low	= 1,
-	}, {
-		.code		= KEY_WPS_BUTTON,
-		.gpio		= 46,
-		.desc		= "WPS Button",
-		.active_low	= 1,
-	},
-};
-
-static struct gpio_keys_platform_data mv88f6281gtw_ge_button_data = {
-	.buttons	= mv88f6281gtw_ge_button_pins,
-	.nbuttons	= ARRAY_SIZE(mv88f6281gtw_ge_button_pins),
-};
-
-static struct platform_device mv88f6281gtw_ge_buttons = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.num_resources	= 0,
-	.dev		= {
-		.platform_data	= &mv88f6281gtw_ge_button_data,
-	},
-};
-
-static struct gpio_led mv88f6281gtw_ge_led_pins[] = {
-	{
-		.name		= "gtw:green:Status",
-		.gpio		= 20,
-		.active_low	= 0,
-	}, {
-		.name		= "gtw:red:Status",
-		.gpio		= 21,
-		.active_low	= 0,
-	}, {
-		.name		= "gtw:green:USB",
-		.gpio		= 12,
-		.active_low	= 0,
-	},
-};
-
-static struct gpio_led_platform_data mv88f6281gtw_ge_led_data = {
-	.leds		= mv88f6281gtw_ge_led_pins,
-	.num_leds	= ARRAY_SIZE(mv88f6281gtw_ge_led_pins),
-};
-
-static struct platform_device mv88f6281gtw_ge_leds = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &mv88f6281gtw_ge_led_data,
-	},
-};
-
-static unsigned int mv88f6281gtw_ge_mpp_config[] __initdata = {
-	MPP12_GPO,	/* Status#_USB pin  */
-	MPP20_GPIO,	/* Status#_GLED pin */
-	MPP21_GPIO,	/* Status#_RLED pin */
-	MPP46_GPIO,	/* WPS_Switch pin   */
-	MPP47_GPIO,	/* SW_Init pin      */
-	0
-};
-
-static void __init mv88f6281gtw_ge_init(void)
-{
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_init();
-	kirkwood_mpp_conf(mv88f6281gtw_ge_mpp_config);
-
-	kirkwood_ehci_init();
-	kirkwood_ge00_init(&mv88f6281gtw_ge_ge00_data);
-	kirkwood_ge00_switch_init(&mv88f6281gtw_ge_switch_plat_data, NO_IRQ);
-	spi_register_board_info(mv88f6281gtw_ge_spi_slave_info,
-				ARRAY_SIZE(mv88f6281gtw_ge_spi_slave_info));
-	kirkwood_spi_init();
-	kirkwood_uart0_init();
-	platform_device_register(&mv88f6281gtw_ge_leds);
-	platform_device_register(&mv88f6281gtw_ge_buttons);
-}
-
-static int __init mv88f6281gtw_ge_pci_init(void)
-{
-	if (machine_is_mv88f6281gtw_ge())
-		kirkwood_pcie_init(KW_PCIE0);
-
-	return 0;
-}
-subsys_initcall(mv88f6281gtw_ge_pci_init);
-
-MACHINE_START(MV88F6281GTW_GE, "Marvell 88F6281 GTW GE Board")
-	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.atag_offset	= 0x100,
-	.init_machine	= mv88f6281gtw_ge_init,
-	.map_io		= kirkwood_map_io,
-	.init_early	= kirkwood_init_early,
-	.init_irq	= kirkwood_init_irq,
-	.init_time	= kirkwood_timer_init,
-	.restart	= kirkwood_restart,
-MACHINE_END
-- 
1.8.1.2
