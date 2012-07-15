From: florian@openwrt.org (Florian Fainelli)
Date: Sun, 15 Jul 2012 16:49:10 +0200
Subject: [PATCH 4/8] ARM: MCS814X: add DTS file for Tigal/Robotech RBT-832
In-Reply-To: <1342363754-30808-1-git-send-email-florian@openwrt.org>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
Message-ID: <1342363754-30808-5-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This DTS files defines the following specifities:
- 32MB of RAM
- 5 GPIO controlled LEDs
- LED activity for the Ethernet port
- MTD partitions

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/arm/boot/dts/rbt-832.dts            |   83 ++++++++++++++++++++++++++++++
 arch/arm/mach-mcs814x/Kconfig            |    9 ++++
 arch/arm/mach-mcs814x/Makefile.boot      |    2 +
 arch/arm/mach-mcs814x/board-mcs8140-dt.c |    1 +
 4 files changed, 95 insertions(+)
 create mode 100644 arch/arm/boot/dts/rbt-832.dts

diff --git a/arch/arm/boot/dts/rbt-832.dts b/arch/arm/boot/dts/rbt-832.dts
new file mode 100644
index 0000000..cc7fab8
--- /dev/null
+++ b/arch/arm/boot/dts/rbt-832.dts
@@ -0,0 +1,83 @@
+/*
+ * rbt-832.dts - Device Tree file for Tigal RBT-832
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
+	model = "Tigal RBT-832";
+	compatible = "tigal,rbt-832", "moschip,mcs8140", "moschip,mcs814x";
+
+	chosen {
+		bootargs = "mem=32M console=ttyS0,115200 earlyprintk";
+	};
+
+	ahb {
+		vci {
+			eth0: ethernet at 40084000 {
+				nuport-mac,link-activity = <0x01>;
+			};
+
+			adc {
+				sdram: memory at 0,0 {
+					reg = <0 0 0x2000000>;
+				};
+
+				nor: flash at 7,0 {
+
+					partition at 0 {
+						label = "ArmBoot";
+						reg = <0 0x40000>;
+					};
+					partition at 30000 {
+						label = "Enviroment";
+						reg = <0x40000 0x20000>;
+					};
+					partition at 50000 {
+						label = "bZimage";
+						reg = <0x60000 0x1a0000>;
+					};
+					partition at 150000 {
+						label = "UserFS";
+						reg = <0x200000 0x600000>;
+					};
+				};
+			};
+
+			leds {
+				compatible = "gpio-leds";
+
+				ethernet {
+					label = "rbt-832:red:ethernet";
+					gpios = <&gpio 0 0>;	// gpio 0 active high
+				};
+
+				usb0 {
+					label = "rbt-832:red:usb0";
+					gpios = <&gpio 4 0>;	// gpio 4 active high
+				};
+
+				usb1 {
+					label = "rbt-832:red:usb1";
+					gpios = <&gpio 3 0>;	// gpio 3 active high
+				};
+
+				usb2 {
+					label = "rbt-832:red:usb2";
+					gpios = <&gpio 2 0>;	// gpio 2 active high
+				};
+
+				usb3 {
+					label = "rbt-832:red:usb3";
+					gpios = <&gpio 1 0>;	// gpio 1 active high
+				};
+			};
+		};
+	};
+};
+
diff --git a/arch/arm/mach-mcs814x/Kconfig b/arch/arm/mach-mcs814x/Kconfig
index c89422f..604537b 100644
--- a/arch/arm/mach-mcs814x/Kconfig
+++ b/arch/arm/mach-mcs814x/Kconfig
@@ -6,6 +6,15 @@ config MCS8140
 
 menu "Moschip MCS8140 boards"
 
+config MACH_RBT_832
+	bool "Tigal RBT-832"
+	select MCS8140
+	select NEW_LEDS
+	select LEDS_CLASS
+	select LEDS_GPIO
+	help
+	  Machine support for the Tigal RBT-832 board
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-mcs814x/Makefile.boot b/arch/arm/mach-mcs814x/Makefile.boot
index 414db8b..3153a7c 100644
--- a/arch/arm/mach-mcs814x/Makefile.boot
+++ b/arch/arm/mach-mcs814x/Makefile.boot
@@ -1,3 +1,5 @@
     zreladdr-y := 0x00008000
  params_phys-y := 0x00000008
  initrd_phys-y := 0x00400000
+
+dtb-$(CONFIG_MACH_RBT_832) += rbt-832.dtb
diff --git a/arch/arm/mach-mcs814x/board-mcs8140-dt.c b/arch/arm/mach-mcs814x/board-mcs8140-dt.c
index 5d13283..6f0804d 100644
--- a/arch/arm/mach-mcs814x/board-mcs8140-dt.c
+++ b/arch/arm/mach-mcs814x/board-mcs8140-dt.c
@@ -27,6 +27,7 @@ static void __init mcs814x_dt_device_init(void)
 }
 
 static const char *mcs8140_dt_board_compat[] __initdata = {
+	"tigal,rbt-832",
 	"moschip,mcs8140",
 	NULL,	/* sentinel */
 };
-- 
1.7.10.4
