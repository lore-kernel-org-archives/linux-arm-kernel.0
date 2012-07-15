From: florian@openwrt.org (Florian Fainelli)
Date: Sun, 15 Jul 2012 16:49:11 +0200
Subject: [PATCH 5/8] ARM: MCS814x: add DTS file for Devolo dLAN USB Extender
In-Reply-To: <1342363754-30808-1-git-send-email-florian@openwrt.org>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
Message-ID: <1342363754-30808-6-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Devolo's dLAN USB Extender board:
- 16MB of SDRAM available
- GPIO for the USB port activity
- MTD partition map

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/arm/boot/dts/dlan-usb-extender.dts  |   68 ++++++++++++++++++++++++++++++
 arch/arm/mach-mcs814x/Kconfig            |    9 ++++
 arch/arm/mach-mcs814x/Makefile.boot      |    1 +
 arch/arm/mach-mcs814x/board-mcs8140-dt.c |    1 +
 4 files changed, 79 insertions(+)
 create mode 100644 arch/arm/boot/dts/dlan-usb-extender.dts

diff --git a/arch/arm/boot/dts/dlan-usb-extender.dts b/arch/arm/boot/dts/dlan-usb-extender.dts
new file mode 100644
index 0000000..4adfaa3
--- /dev/null
+++ b/arch/arm/boot/dts/dlan-usb-extender.dts
@@ -0,0 +1,68 @@
+/*
+ * dlan-usb-extender.dts - Device Tree file for Devolo dLAN USB Extender
+ *
+ * Copyright (C) 2012, Florian Fainelli <florian@openwrt.org>
+ *
+ * Licensed under GPLv2
+ */
+
+/dts-v1/;
+/include/ "mcs8140.dtsi"
+
+/ {
+	model = "Devolo dLAN USB Extender";
+	compatible = "devolo,dlan-usb-extender", "moschip,mcs8140", "moschip,mcs814x";
+
+	chosen {
+		bootargs = "mem=16M console=ttyS0,57600 earlyprintk";
+	};
+
+	ahb {
+		vci {
+
+			adc {
+				sdram: memory at 0,0 {
+					reg = <0 0 0x1000000>;
+				};
+
+				nor: flash at 7,0 {
+
+					partition at 0 {
+						label = "ArmBoot";
+						reg = <0 0x30000>;
+					};
+					partition at 30000 {
+						label = "Config1";
+						reg = <0x30000 0x10000>;
+					};
+					partition at 40000 {
+						label = "Config2";
+						reg = <0x40000 0x10000>;
+					};
+					partition at 50000 {
+						label = "bZimage";
+						reg = <0x50000 0x100000>;
+					};
+					partition at 150000 {
+						label = "UserFS";
+						reg = <0x150000 0x3C0000>;
+					};
+					partition at 50001 {
+						label = "Combined";
+						reg = <0x50000 0x4C0000>;
+					};
+				};
+			};
+
+			leds {
+				compatible = "gpio-leds";
+
+				usb {
+					label = "dlan-usb-extender:green:usb";
+					gpios = <&gpio 19 0>;	// gpio 19 active high
+				};
+			};
+		};
+	};
+};
+
diff --git a/arch/arm/mach-mcs814x/Kconfig b/arch/arm/mach-mcs814x/Kconfig
index 604537b..aa312d1 100644
--- a/arch/arm/mach-mcs814x/Kconfig
+++ b/arch/arm/mach-mcs814x/Kconfig
@@ -6,6 +6,15 @@ config MCS8140
 
 menu "Moschip MCS8140 boards"
 
+config MACH_DLAN_USB_EXT
+	bool "Devolo dLAN USB Extender"
+	select MCS8140
+	select NEW_LEDS
+	select LEDS_CLASS
+	select LEDS_GPIO
+	help
+	  Machine support for the Devolo dLAN USB Extender
+
 config MACH_RBT_832
 	bool "Tigal RBT-832"
 	select MCS8140
diff --git a/arch/arm/mach-mcs814x/Makefile.boot b/arch/arm/mach-mcs814x/Makefile.boot
index 3153a7c..60dfcf6 100644
--- a/arch/arm/mach-mcs814x/Makefile.boot
+++ b/arch/arm/mach-mcs814x/Makefile.boot
@@ -2,4 +2,5 @@
  params_phys-y := 0x00000008
  initrd_phys-y := 0x00400000
 
+dtb-$(CONFIG_MACH_DLAN_USB_EXT) += dlan-usb-extender.dtb
 dtb-$(CONFIG_MACH_RBT_832) += rbt-832.dtb
diff --git a/arch/arm/mach-mcs814x/board-mcs8140-dt.c b/arch/arm/mach-mcs814x/board-mcs8140-dt.c
index 6f0804d..766166b 100644
--- a/arch/arm/mach-mcs814x/board-mcs8140-dt.c
+++ b/arch/arm/mach-mcs814x/board-mcs8140-dt.c
@@ -27,6 +27,7 @@ static void __init mcs814x_dt_device_init(void)
 }
 
 static const char *mcs8140_dt_board_compat[] __initdata = {
+	"devolo,dlan-usb-extender",
 	"tigal,rbt-832",
 	"moschip,mcs8140",
 	NULL,	/* sentinel */
-- 
1.7.10.4
