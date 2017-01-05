From: joerg.krause@embedded.rocks (=?UTF-8?q?J=C3=B6rg=20Krause?=)
Date: Thu,  5 Jan 2017 18:37:53 +0100
Subject: [PATCH v2] ARM: dts: sun7i: Add wifi dt node on Banana Pro
Message-ID: <20170105173753.14024-1-joerg.krause@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Banana Pro has an AMPAK AP6181 WiFi+Bluetooth module. The WiFi part
is a BCM43362 IC connected to MMC3 of the A20 SoC via SDIO. The IC also
takes a power enable signal via GPIO.

This commit adds a device-tree node to power it up, so the mmc subsys
can scan it, and enables the mmc controller which is connected to it.

As the wifi enable pin of the AP6181 module is not really a regulator,
switch the mmc3 node to the mmc-pwrseq framework for controlling it.
This more accurately reflectes how the hardware actually works.

Signed-off-by: J?rg Krause <joerg.krause@embedded.rocks>
---
Changes v2 (suggested by Maxime Ripard):
  - rename pwrseq node to clarify the function rather what it's
    connected to
  - use dash instead of underscore for the pwrseq node name
  - remove setting pull-ups for mmc3 (default since commit 37bc56128d92)

---
 arch/arm/boot/dts/sun7i-a20-bananapro.dts | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
index 19d63d4049de..77f8fb76c157 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
@@ -76,6 +76,13 @@
 		};
 	};
 
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vmmc3_pin_bananapro>;
+		reset-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>;
+	};
+
 	reg_gmac_3v3: gmac-3v3 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -87,17 +94,6 @@
 		enable-active-high;
 		gpio = <&pio 7 23 GPIO_ACTIVE_HIGH>;
 	};
-
-	reg_vmmc3: vmmc3 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&vmmc3_pin_bananapro>;
-		regulator-name = "vmmc3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		enable-active-high;
-		gpio = <&pio 7 22 GPIO_ACTIVE_HIGH>;
-	};
 };
 
 &ahci {
@@ -166,10 +162,20 @@
 &mmc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins_a>;
-	vmmc-supply = <&reg_vmmc3>;
+	vmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
 	non-removable;
+	wakeup-source;
 	status = "okay";
+
+	brcmf: bcrmf at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&pio>;
+		interrupts = <7 15 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "host-wake";
+	};
 };
 
 &ohci0 {
-- 
2.11.0
