From: dev@lynxeye.de (Lucas Stach)
Date: Tue, 22 Jan 2013 22:46:09 +0100
Subject: [PATCH v2 3/3] ARM: DT: tegra: Add Toradex Iris carrier board with
 T20 512MB COM
In-Reply-To: <1358891169-5939-1-git-send-email-dev@lynxeye.de>
References: <1358423961-24318-1-git-send-email-dev@lynxeye.de>
 <1358891169-5939-1-git-send-email-dev@lynxeye.de>
Message-ID: <1358891169-5939-3-git-send-email-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device tree for the Toradex Iris carrier board used
together with a Colibri T20 512MB COM.

The Iris has the following features, in brackets the current status:
- DVI and VGA output through DVI-I connector (DVI-D enabled and tested)
- LVDS output
- 1 USB host port (enabled and tested)
- 1 USB OTG port (enabled)
- 100 MBit Ethernet (enabled and tested)
- 5 UART ports  (2 on 10way headers enabled and tested)
- 1 MicroSD Slot (enabled and tested)
- Audio connectors (enabled, only HP out and Line-in tested)
- i2c RTC
- GPIO connector (enabled, only sparsely tested)
- external i2c bus
- 4 PWM out
- analog in

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
v2:
- unify regulator node between module and carrier
- use correct regulator for sdhci
---
 Documentation/devicetree/bindings/arm/tegra.txt |  1 +
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/tegra20-iris-512.dts          | 89 +++++++++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra20-iris-512.dts

diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
index ccd4ef4..ed9c853 100644
--- a/Documentation/devicetree/bindings/arm/tegra.txt
+++ b/Documentation/devicetree/bindings/arm/tegra.txt
@@ -31,3 +31,4 @@ board-specific compatible values:
   nvidia,ventana
   nvidia,whistler
   toradex,colibri_t20-512
+  toradex,iris
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5c13de2..b756c51 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -134,6 +134,7 @@ dtb-$(CONFIG_ARCH_SPEAR6XX)+= spear600-evb.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun4i-a10-cubieboard.dtb \
 	sun5i-a13-olinuxino.dtb
 dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
+	tegra20-iris-512.dtb \
 	tegra20-medcom-wide.dtb \
 	tegra20-paz00.dtb \
 	tegra20-plutux.dtb \
diff --git a/arch/arm/boot/dts/tegra20-iris-512.dts b/arch/arm/boot/dts/tegra20-iris-512.dts
new file mode 100644
index 0000000..52f1103
--- /dev/null
+++ b/arch/arm/boot/dts/tegra20-iris-512.dts
@@ -0,0 +1,89 @@
+/dts-v1/;
+
+/include/ "tegra20-colibri-512.dtsi"
+
+/ {
+	model = "Toradex Colibri T20 512MB on Iris";
+	compatible = "toradex,iris", "toradex,colibri_t20-512", "nvidia,tegra20";
+
+	host1x {
+		hdmi {
+			status = "okay";
+		};
+	};
+
+	pinmux {
+		state_default: pinmux {
+			hdint {
+				nvidia,tristate = <0>;
+			};
+
+			i2cddc {
+				nvidia,tristate = <0>;
+			};
+
+			sdio4 {
+				nvidia,tristate = <0>;
+			};
+
+			uarta {
+				nvidia,tristate = <0>;
+			};
+
+			uartd {
+				nvidia,tristate = <0>;
+			};
+		};
+	};
+
+	usb at c5000000 {
+		status = "okay";
+		dr_mode = "otg";
+	};
+
+	usb at c5008000 {
+		status = "okay";
+	};
+
+	serial at 70006000 {
+		status = "okay";
+	};
+
+	serial at 70006300 {
+		status = "okay";
+	};
+
+	i2c_ddc: i2c at 7000c400 {
+		status = "okay";
+	};
+
+	sdhci at c8000600 {
+		status = "okay";
+		bus-width = <4>;
+		vmmc-supply = <&vcc_sd_reg>;
+		vqmmc-supply = <&vcc_sd_reg>;
+	};
+
+	regulators {
+		regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "usb_host_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-boot-on;
+			regulator-always-on;
+			gpio = <&gpio 178 0>;
+		};
+
+		vcc_sd_reg: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "vcc_sd";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+	};
+};
-- 
1.8.0.2
