From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue,  9 Apr 2013 00:41:28 +0200
Subject: [PATCH v2 2/3] ARM: Kirkwood: DT board setup for CloudBox
In-Reply-To: <1365460889-22965-1-git-send-email-simon.guinot@sequanux.org>
References: <1365460889-22965-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1365460889-22965-3-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT board setup for the LaCie NAS CloudBox. The CloudBox
is a low cost NAS based on the Network Space v2.

Chipset list:
- CPU MARVELL 88F6702 1Ghz
- SDRAM memory: 256MB DDR2-800 (2x128MB x8) 400Mhz
- 1 Ethernet Gigabit port (PHY MARVELL 88E1318)
- SPI flash, NOR 512KB
- 1 push button
- 2 LEDs (red and blue)

There is no EEPROM and no USB ports embedded.

Note that this board must not be confused with the Network Space Mini v2
which is embedded in a previous LaCie product also named CloudBox.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
Changes for v2:
 - Rebase against Jason's branch marvell/mvebu/boards.
 - Remove i2c pinctrl declaration (not used).
 - For all modified files, respect alphabetical order while inserting cloudbox
   entries.
 - Enhance patch description to avoid confusion between the two LaCie
   products named CloudBox.

 arch/arm/boot/dts/Makefile              |    3 +-
 arch/arm/boot/dts/kirkwood-cloudbox.dts |   89 +++++++++++++++++++++++++++++++
 arch/arm/configs/kirkwood_defconfig     |    1 +
 arch/arm/mach-kirkwood/Kconfig          |    7 +++
 arch/arm/mach-kirkwood/Makefile         |    1 +
 arch/arm/mach-kirkwood/board-dt.c       |   14 ++---
 arch/arm/mach-kirkwood/board-ns2.c      |    3 +-
 arch/arm/mach-kirkwood/common.h         |    6 +++
 8 files changed, 116 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-cloudbox.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 125211d..c56f20f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -51,7 +51,8 @@ dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
 dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
 	integratorcp.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
-dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
+	kirkwood-dns320.dtb \
 	kirkwood-dns325.dtb \
 	kirkwood-dockstar.dtb \
 	kirkwood-dreamplug.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-cloudbox.dts b/arch/arm/boot/dts/kirkwood-cloudbox.dts
new file mode 100644
index 0000000..5f21d4e
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-cloudbox.dts
@@ -0,0 +1,89 @@
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+/include/ "kirkwood-6281.dtsi"
+
+/ {
+	model = "LaCie CloudBox";
+	compatible = "lacie,cloudbox", "marvell,kirkwood-88f6702", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			pinctrl-0 = < &pmx_spi &pmx_uart0
+					&pmx_cloudbox_sata0 >;
+			pinctrl-names = "default";
+
+			pmx_cloudbox_sata0: pmx-cloudbox-sata0 {
+				marvell,pins = "mpp15";
+				marvell,function = "sata0";
+			};
+		};
+
+		serial at 12000 {
+			clock-frequency = <166666667>;
+			status = "okay";
+		};
+
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <1>;
+		};
+
+		spi at 10600 {
+			status = "okay";
+
+			flash at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "mx25l4005a";
+				reg = <0>;
+				spi-max-frequency = <20000000>;
+				mode = <0>;
+
+				partition at 0 {
+					reg = <0x0 0x80000>;
+					label = "u-boot";
+				};
+			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		button at 1 {
+			label = "Power push button";
+			linux,code = <116>;
+			gpios = <&gpio0 16 1>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		red-fail {
+			label = "cloudbox:red:fail";
+			gpios = <&gpio0 14 0>;
+		};
+		blue-sata {
+			label = "cloudbox:blue:sata";
+			gpios = <&gpio0 15 0>;
+		};
+	};
+
+	gpio_poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio0 17 0>;
+	};
+};
diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 0421d0f..7205a7a 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -30,6 +30,7 @@ CONFIG_MACH_SHEEVAPLUG=y
 CONFIG_MACH_T5325=y
 CONFIG_MACH_TS219=y
 CONFIG_MACH_TS41X=y
+CONFIG_MACH_CLOUDBOX_DT=y
 CONFIG_MACH_DLINK_KIRKWOOD_DT=y
 CONFIG_MACH_DOCKSTAR_DT=y
 CONFIG_MACH_DREAMPLUG_DT=y
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 938395a..45ab2f5 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -146,6 +146,13 @@ config ARCH_KIRKWOOD_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Kirkwood using flattened device tree.
 
+config MACH_CLOUDBOX_DT
+	bool "LaCie CloudBox NAS (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	help
+	  Say 'Y' here if you want your kernel to support the LaCie
+	  CloudBox NAS, using Flattened Device Tree.
+
 config MACH_DLINK_KIRKWOOD_DT
 	bool "D-Link Kirkwood-based NAS (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 5f1285d..cdbca32 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
 
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
+obj-$(CONFIG_MACH_CLOUDBOX_DT)		+= board-ns2.o
 obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
 obj-$(CONFIG_MACH_DOCKSTAR_DT)		+= board-dockstar.o
 obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index e5a3cfe..7904758 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -139,11 +139,12 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("keymile,km_kirkwood"))
 		km_kirkwood_init();
 
-	if (of_machine_is_compatible("lacie,inetspace_v2") ||
-	    of_machine_is_compatible("lacie,netspace_v2") ||
-	    of_machine_is_compatible("lacie,netspace_max_v2") ||
+	if (of_machine_is_compatible("lacie,cloudbox") ||
+	    of_machine_is_compatible("lacie,inetspace_v2") ||
 	    of_machine_is_compatible("lacie,netspace_lite_v2") ||
-	    of_machine_is_compatible("lacie,netspace_mini_v2"))
+	    of_machine_is_compatible("lacie,netspace_max_v2") ||
+	    of_machine_is_compatible("lacie,netspace_mini_v2") ||
+	    of_machine_is_compatible("lacie,netspace_v2"))
 		ns2_init();
 
 	if (of_machine_is_compatible("mpl,cec4"))
@@ -174,11 +175,12 @@ static const char * const kirkwood_dt_board_compat[] = {
 	"buffalo,lsxl",
 	"iom,ix2-200",
 	"keymile,km_kirkwood",
+	"lacie,cloudbox",
 	"lacie,inetspace_v2",
-	"lacie,netspace_max_v2",
-	"lacie,netspace_v2",
 	"lacie,netspace_lite_v2",
+	"lacie,netspace_max_v2",
 	"lacie,netspace_mini_v2",
+	"lacie,netspace_v2",
 	"mpl,cec4",
 	"netgear,readynas-duo-v2",
 	"plathome,openblocks-a6",
diff --git a/arch/arm/mach-kirkwood/board-ns2.c b/arch/arm/mach-kirkwood/board-ns2.c
index f2ea3b7..f8f6605 100644
--- a/arch/arm/mach-kirkwood/board-ns2.c
+++ b/arch/arm/mach-kirkwood/board-ns2.c
@@ -27,7 +27,8 @@ void __init ns2_init(void)
 	/*
 	 * Basic setup. Needs to be called early.
 	 */
-	if (of_machine_is_compatible("lacie,netspace_lite_v2") ||
+	if (of_machine_is_compatible("lacie,cloudbox") ||
+	    of_machine_is_compatible("lacie,netspace_lite_v2") ||
 	    of_machine_is_compatible("lacie,netspace_mini_v2"))
 		ns2_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
 	kirkwood_ge00_init(&ns2_ge00_data);
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 7ee8670..3147be2 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -153,6 +153,12 @@ void usi_topkick_init(void);
 static inline void usi_topkick_init(void) {};
 #endif
 
+#ifdef CONFIG_MACH_CLOUDBOX_DT
+void cloudbox_init(void);
+#else
+static inline void cloudbox_init(void) {};
+#endif
+
 /* early init functions not converted to fdt yet */
 char *kirkwood_id(void);
 void kirkwood_l2_init(void);
-- 
1.7.10.4
