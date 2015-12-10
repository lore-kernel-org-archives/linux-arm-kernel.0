From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 10 Dec 2015 13:46:39 +0800
Subject: [PATCH 3/3] arm: dts: rockchip: move the public part to rk3288-evb
 common
In-Reply-To: <1449726399-12507-1-git-send-email-zyw@rock-chips.com>
References: <1449726399-12507-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1449726399-12507-3-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rk3288-evb-act8846 and rk3288-evb-rk808 are the power boards of
rk3288-evb, they provide the same power supply interface to the
motherboard. Sort out them, put the public part to rk3288-evb.dtsi,
such as gmac and cpu-supply, leaving only the power section.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

 arch/arm/boot/dts/rk3288-evb-act8846.dts |  4 ----
 arch/arm/boot/dts/rk3288-evb-rk808.dts   | 27 -----------------------
 arch/arm/boot/dts/rk3288-evb.dtsi        | 37 +++++++++++++++++++++++++++-----
 3 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rk3288-evb-act8846.dts
index 7b768b7..e662147 100644
--- a/arch/arm/boot/dts/rk3288-evb-act8846.dts
+++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
@@ -65,10 +65,6 @@
 	};
 };
 
-&cpu0 {
-	cpu0-supply = <&vdd_cpu>;
-};
-
 &i2c0 {
 	clock-frequency = <400000>;
 
diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rk3288-evb-rk808.dts
index 18eb6cb..736b08b 100644
--- a/arch/arm/boot/dts/rk3288-evb-rk808.dts
+++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
@@ -43,17 +43,6 @@
 
 / {
 	compatible = "rockchip,rk3288-evb-rk808", "rockchip,rk3288";
-
-	ext_gmac: external-gmac-clock {
-		compatible = "fixed-clock";
-		clock-frequency = <125000000>;
-		clock-output-names = "ext_gmac";
-		#clock-cells = <0>;
-	};
-};
-
-&cpu0 {
-	cpu0-supply = <&vdd_cpu>;
 };
 
 &i2c0 {
@@ -244,19 +233,3 @@
 		};
 	};
 };
-
-&gmac {
-	phy-supply = <&vcc_phy>;
-	phy-mode = "rgmii";
-	clock_in_out = "input";
-	snps,reset-gpio = <&gpio4 7 0>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 1000000>;
-	assigned-clocks = <&cru SCLK_MAC>;
-	assigned-clock-parents = <&ext_gmac>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii_pins>;
-	tx_delay = <0x30>;
-	rx_delay = <0x10>;
-	status = "ok";
-};
diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index f6d2e78..4faabdb 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -89,6 +89,13 @@
 		pwms = <&pwm0 0 1000000 PWM_POLARITY_INVERTED>;
 	};
 
+	ext_gmac: external-gmac-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "ext_gmac";
+		#clock-cells = <0>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
@@ -160,6 +167,10 @@
 	};
 };
 
+&cpu0 {
+	cpu0-supply = <&vdd_cpu>;
+};
+
 &emmc {
 	broken-cd;
 	bus-width = <8>;
@@ -172,11 +183,6 @@
 	status = "okay";
 };
 
-&hdmi {
-	ddc-i2c-bus = <&i2c5>;
-	status = "okay";
-};
-
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
@@ -191,6 +197,27 @@
 	vqmmc-supply = <&vccio_sd>;
 };
 
+&gmac {
+	phy-supply = <&vcc_phy>;
+	phy-mode = "rgmii";
+	clock_in_out = "input";
+	snps,reset-gpio = <&gpio4 7 0>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 1000000>;
+	assigned-clocks = <&cru SCLK_MAC>;
+	assigned-clock-parents = <&ext_gmac>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	tx_delay = <0x30>;
+	rx_delay = <0x10>;
+	status = "ok";
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c5>;
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 };
-- 
2.6.3
