From: maxime.hadjinlian@gmail.com (Maxime Hadjinlian)
Date: Sat, 16 Nov 2013 23:08:28 +0100
Subject: [PATCH] ARM: Kirkwood: DT board setup for LaPlug
Message-ID: <1384639708-6868-1-git-send-email-maxime.hadjinlian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT board setup for the LaCie NAS LaPlug.

Chipset list:
- CPU MARVELL 88FR131 800Mhz
- SDRAM memory: 128MB DDR2-800 400Mhz
- 1 Ethernet Gigabit port (PHY MARVELL 88E1318)
- 1 Mini PCI-Express port
- 1 NAND 512 MB
- 1 push button
- 2 LEDs (red and blue)
- 4 USB Ports

Signed-off-by: Maxime Hadjinlian <maxime.hadjinlian@gmail.com>
---
 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/kirkwood-nsplug.dts | 178 ++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-nsplug.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d57c1a6..38b0604 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -96,6 +96,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
 	kirkwood-ns2mini.dtb \
 	kirkwood-nsa310.dtb \
 	kirkwood-nsa310a.dtb \
+	kirkwood-nsplug.dtb \
 	kirkwood-openblocks_a6.dtb \
 	kirkwood-openblocks_a7.dtb \
 	kirkwood-sheevaplug.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-nsplug.dts b/arch/arm/boot/dts/kirkwood-nsplug.dts
new file mode 100644
index 0000000..45ab517
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-nsplug.dts
@@ -0,0 +1,178 @@
+/*
+ * Copyright (C) 2013 Maxime Hadjinlian <maxime.hadjinlian@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+
+/ {
+  model = "LaCie LaPlug";
+  compatible = "lacie,nsplug", "marvell,kirkwood-88f6192", "marvell,kirkwood";
+
+  memory {
+    device_type = "memory";
+    reg = <0x00000000 0x8000000>; /* 128 MB */
+  };
+
+  chosen {
+    bootargs = "console=ttyS0,115200n8 earlyprintk";
+  };
+
+  mbus {
+    ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
+    pcie-controller {
+      status = "okay";
+      pcie at 1,0 {
+        status = "okay";
+      };
+    };
+  };
+
+  ocp at f1000000 {
+
+    serial at 12000 {
+      pinctrl-0 = <&pmx_uart0>;
+      pinctrl-names = "default";
+      status = "okay";
+    };
+
+    i2c at 11000 {
+      pinctrl-0 = <&pmx_twsi0>;
+      pinctrl-names = "default";
+      status = "okay";
+
+      eeprom at 50 {
+        compatible = "at,24c04";
+        pagesize = <16>;
+        reg = <0x50>;
+      };
+    };
+
+    pinctrl: pinctrl at 10000 {
+      pmx_usb_power_enable: pmx-usb-power-enable {
+        marvell,pins = "mpp14";
+        marvell,function = "gpio";
+      };
+    };
+
+    nand at 3000000 {
+      /* Total size : 512MB */
+      status = "okay";
+
+      partition at 0 {
+        label = "u-boot";
+        reg = <0x0 0x100000>; /* 1MB */
+        read-only;
+      };
+
+      partition at 100000 {
+        label = "uImage";
+        reg = <0x100000 0x1000000>; /* 16MB */
+      };
+
+      partition at 1100000 {
+        label = "rootfs";
+        reg = <0x1100000 0x1EF00000>; /* 495MB */
+      };
+    };
+  };
+
+  gpio_keys {
+    compatible = "gpio-keys";
+    #address-cells = <1>;
+    #size-cells = <0>;
+
+    button at 1{
+      label = "Power push button";
+      linux,code = <116>;
+      gpios = <&gpio1 0 0>;
+    };
+  };
+
+  gpio-leds {
+    compatible = "gpio-leds";
+
+    red-fail {
+      label = "ns_plug_v2:red:power";
+      gpios = <&gpio0 12 0>;
+    };
+    blue-power {
+      label = "ns_plug_v2:blue:power";
+      gpios = <&gpio0 29 0>;
+      linux,default-trigger = "default-on";
+    };
+  };
+
+  gpio_poweroff {
+    compatible = "gpio-poweroff";
+    gpios = <&gpio0 31 0>;
+  };
+
+  regulators {
+    compatible = "simple-bus";
+    #address-cells = <1>;
+    #size-cells = <0>;
+    pinctrl-0 = <&pmx_usb_power_enable>;
+    pinctrl-names = "default";
+
+    usb_power_back1: regulator at 1 {
+      compatible = "regulator-fixed";
+      reg = <1>;
+      regulator-name = "USB Power Back 1";
+      regulator-min-microvolt = <5000000>;
+      regulator-max-microvolt = <5000000>;
+      enable-active-high;
+      regulator-always-on;
+      regulator-boot-on;
+      gpio = <&gpio0 15 0>;
+    };
+
+    usb_power_back2: regulator at 2 {
+      compatible = "regulator-fixed";
+      reg = <2>;
+      regulator-name = "USB Power Back 2";
+      regulator-min-microvolt = <5000000>;
+      regulator-max-microvolt = <5000000>;
+      enable-active-high;
+      regulator-always-on;
+      regulator-boot-on;
+      gpio = <&gpio0 28 0>;
+    };
+
+    usb_power_front: regulator at 3 {
+      compatible = "regulator-fixed";
+      reg = <3>;
+      regulator-name = "USB Power Front";
+      regulator-min-microvolt = <5000000>;
+      regulator-max-microvolt = <5000000>;
+      enable-active-high;
+      regulator-always-on;
+      regulator-boot-on;
+      gpio = <&gpio1 3 0>;
+    };
+  };
+
+};
+
+&mdio {
+  status = "okay";
+
+  ethphy0: ethernet-phy at 0 {
+    device_type = "ethernet-phy";
+    reg = <0>;
+  };
+};
+
+&eth0 {
+  status = "okay";
+  ethernet0-port at 0 {
+    phy-handle = <&ethphy0>;
+  };
+};
+
-- 
1.8.4.2
