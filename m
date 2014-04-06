From: linux@baker-net.org.uk (Adam Baker)
Date: Sun,  6 Apr 2014 22:42:49 +0100
Subject: [PATCH 3/3] ARM: kirkwood: rename kirwood-nsa310-common to 3x0-common
In-Reply-To: <1396820569-3841-1-git-send-email-linux@baker-net.org.uk>
References: <5341C91D.4060007@baker-net.org.uk>
 <1396820569-3841-1-git-send-email-linux@baker-net.org.uk>
Message-ID: <1396820569-3841-3-git-send-email-linux@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Rename the include file kirkwood-nsa310-common.dtsi as
 it is now also used for NSA320. There is also an NSA325
 but that appears not to be as similar so is unlikely to
 want to share an include file.

Signed-off-by: Adam Baker <linux@baker-net.org.uk>
---
 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi |  157 -------------------------
 arch/arm/boot/dts/kirkwood-nsa310.dts         |    2 +-
 arch/arm/boot/dts/kirkwood-nsa310a.dts        |    2 +-
 arch/arm/boot/dts/kirkwood-nsa320.dts         |    2 +-
 arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi |  157 +++++++++++++++++++++++++
 5 files changed, 160 insertions(+), 160 deletions(-)
 delete mode 100644 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi

diff --git a/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi b/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
deleted file mode 100644
index 843b8b5..0000000
--- a/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
+++ /dev/null
@@ -1,157 +0,0 @@
-#include "kirkwood.dtsi"
-#include "kirkwood-6281.dtsi"
-
-/ {
-	model = "ZyXEL NSA310";
-
-	ocp at f1000000 {
-		pinctrl: pinctrl at 10000 {
-
-			pmx_usb_power: pmx-usb-power {
-				marvell,pins = "mpp21";
-				marvell,function = "gpio";
-			};
-
-			pmx_pwr_off: pmx-pwr-off {
-				marvell,pins = "mpp48";
-				marvell,function = "gpio";
-			};
-
-			pmx_btn_reset: pmx-btn-reset {
-				marvell,pins = "mpp36";
-				marvell,function = "gpio";
-			};
-
-			pmx_btn_copy: pmx-btn-copy {
-				marvell,pins = "mpp37";
-				marvell,function = "gpio";
-			};
-
-			pmx_btn_power: pmx-btn-power {
-				marvell,pins = "mpp46";
-				marvell,function = "gpio";
-			};
-
-			pmx_led_copy_green: pmx-led-copy-green {
-				marvell,pins = "mpp39";
-				marvell,function = "gpio";
-			};
-
-			pmx_led_copy_red: pmx-led-copy-red {
-				marvell,pins = "mpp40";
-				marvell,function = "gpio";
-			};
-		};
-
-		serial at 12000 {
-			status = "ok";
-		};
-
-		sata at 80000 {
-			status = "okay";
-			nr-ports = <2>;
-		};
-
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
-	gpio_poweroff {
-		compatible = "gpio-poweroff";
-		pinctrl-0 = <&pmx_pwr_off>;
-		pinctrl-names = "default";
-		gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
-	};
-
-	gpio_keys {
-		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-0 = <&pmx_btn_reset &pmx_btn_copy &pmx_btn_power>;
-		pinctrl-names = "default";
-
-		button at 1 {
-			label = "Power Button";
-			linux,code = <KEY_POWER>;
-			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
-		};
-		button at 2 {
-			label = "Copy Button";
-			linux,code = <KEY_COPY>;
-			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
-		};
-		button at 3 {
-			label = "Reset Button";
-			linux,code = <KEY_RESTART>;
-			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-0 = <&pmx_usb_power>;
-		pinctrl-names = "default";
-
-		usb0_power: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "USB Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
-		};
-	};
-};
-
-&nand {
-	status = "okay";
-	chip-delay = <35>;
-
-	partition at 0 {
-		label = "uboot";
-		reg = <0x0000000 0x0100000>;
-		read-only;
-	};
-	partition at 100000 {
-		label = "uboot_env";
-		reg = <0x0100000 0x0080000>;
-	};
-	partition at 180000 {
-		label = "key_store";
-		reg = <0x0180000 0x0080000>;
-	};
-	partition at 200000 {
-		label = "info";
-		reg = <0x0200000 0x0080000>;
-	};
-	partition at 280000 {
-		label = "etc";
-		reg = <0x0280000 0x0a00000>;
-	};
-	partition at c80000 {
-		label = "kernel_1";
-		reg = <0x0c80000 0x0a00000>;
-	};
-	partition at 1680000 {
-		label = "rootfs1";
-		reg = <0x1680000 0x2fc0000>;
-	};
-	partition at 4640000 {
-		label = "kernel_2";
-		reg = <0x4640000 0x0a00000>;
-	};
-	partition at 5040000 {
-		label = "rootfs2";
-		reg = <0x5040000 0x2fc0000>;
-	};
-};
diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index 372f701..989846a 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-#include "kirkwood-nsa310-common.dtsi"
+#include "kirkwood-nsa3x0-common.dtsi"
 
 / {
 	compatible = "zyxel,nsa310", "marvell,kirkwood-88f6281", "marvell,kirkwood";
diff --git a/arch/arm/boot/dts/kirkwood-nsa310a.dts b/arch/arm/boot/dts/kirkwood-nsa310a.dts
index ead7a36..d0a6025 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310a.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310a.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-#include "kirkwood-nsa310-common.dtsi"
+#include "kirkwood-nsa3x0-common.dtsi"
 
 /*
  * There are at least two different NSA310 designs. This variant does
diff --git a/arch/arm/boot/dts/kirkwood-nsa320.dts b/arch/arm/boot/dts/kirkwood-nsa320.dts
index 6c8f692..fc20baf 100644
--- a/arch/arm/boot/dts/kirkwood-nsa320.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa320.dts
@@ -11,7 +11,7 @@
 
 /dts-v1/;
 
-#include "kirkwood-nsa310-common.dtsi"
+#include "kirkwood-nsa3x0-common.dtsi"
 
 / {
 	model = "Zyxel NSA320";
diff --git a/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi b/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
new file mode 100644
index 0000000..843b8b5
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
@@ -0,0 +1,157 @@
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+
+/ {
+	model = "ZyXEL NSA310";
+
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_usb_power: pmx-usb-power {
+				marvell,pins = "mpp21";
+				marvell,function = "gpio";
+			};
+
+			pmx_pwr_off: pmx-pwr-off {
+				marvell,pins = "mpp48";
+				marvell,function = "gpio";
+			};
+
+			pmx_btn_reset: pmx-btn-reset {
+				marvell,pins = "mpp36";
+				marvell,function = "gpio";
+			};
+
+			pmx_btn_copy: pmx-btn-copy {
+				marvell,pins = "mpp37";
+				marvell,function = "gpio";
+			};
+
+			pmx_btn_power: pmx-btn-power {
+				marvell,pins = "mpp46";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_copy_green: pmx-led-copy-green {
+				marvell,pins = "mpp39";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_copy_red: pmx-led-copy-red {
+				marvell,pins = "mpp40";
+				marvell,function = "gpio";
+			};
+		};
+
+		serial at 12000 {
+			status = "ok";
+		};
+
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <2>;
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
+	gpio_poweroff {
+		compatible = "gpio-poweroff";
+		pinctrl-0 = <&pmx_pwr_off>;
+		pinctrl-names = "default";
+		gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_btn_reset &pmx_btn_copy &pmx_btn_power>;
+		pinctrl-names = "default";
+
+		button at 1 {
+			label = "Power Button";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		};
+		button at 2 {
+			label = "Copy Button";
+			linux,code = <KEY_COPY>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
+		};
+		button at 3 {
+			label = "Reset Button";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_usb_power>;
+		pinctrl-names = "default";
+
+		usb0_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "USB Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&nand {
+	status = "okay";
+	chip-delay = <35>;
+
+	partition at 0 {
+		label = "uboot";
+		reg = <0x0000000 0x0100000>;
+		read-only;
+	};
+	partition at 100000 {
+		label = "uboot_env";
+		reg = <0x0100000 0x0080000>;
+	};
+	partition at 180000 {
+		label = "key_store";
+		reg = <0x0180000 0x0080000>;
+	};
+	partition at 200000 {
+		label = "info";
+		reg = <0x0200000 0x0080000>;
+	};
+	partition at 280000 {
+		label = "etc";
+		reg = <0x0280000 0x0a00000>;
+	};
+	partition at c80000 {
+		label = "kernel_1";
+		reg = <0x0c80000 0x0a00000>;
+	};
+	partition at 1680000 {
+		label = "rootfs1";
+		reg = <0x1680000 0x2fc0000>;
+	};
+	partition at 4640000 {
+		label = "kernel_2";
+		reg = <0x4640000 0x0a00000>;
+	};
+	partition at 5040000 {
+		label = "rootfs2";
+		reg = <0x5040000 0x2fc0000>;
+	};
+};
-- 
1.7.10.4
