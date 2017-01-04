From: joerg.krause@embedded.rocks (=?UTF-8?q?J=C3=B6rg=20Krause?=)
Date: Wed,  4 Jan 2017 15:22:49 +0100
Subject: [PATCH 1/2] ARM: dts: sun7i: Add wifi dt node on Banana Pro
Message-ID: <20170104142250.22171-1-joerg.krause@embedded.rocks>
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
 arch/arm/boot/dts/sun7i-a20-bananapro.dts | 35 ++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
index 19d63d4049de..439ad50dcd4a 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
@@ -76,6 +76,13 @@
 		};
 	};
 
+	mmc3_pwrseq: mmc3_pwrseq {
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
@@ -166,10 +162,25 @@
 &mmc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins_a>;
-	vmmc-supply = <&reg_vmmc3>;
+	vmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&mmc3_pwrseq>;
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
+};
+
+&mmc3_pins_a {
+	/* AP6181 requires pull-up */
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 };
 
 &ohci0 {
-- 
2.11.0
