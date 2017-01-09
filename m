From: joerg.krause@embedded.rocks (=?UTF-8?q?J=C3=B6rg=20Krause?=)
Date: Mon,  9 Jan 2017 21:36:38 +0100
Subject: [PATCH v3] ARM: dts: sun7i: Add wifi dt node on Banana Pro
Message-ID: <20170109203638.29546-1-joerg.krause@embedded.rocks>
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
Changes v3 suggested by Maxime Ripard):
  - do not set the wakeup-source property for the mmc3 node as it is
    suspicious and propably does not work

Changes v2 (suggested by Maxime Ripard):
  - rename pwrseq node to clarify the function rather what it's
    connected to
  - use dash instead of underscore for the pwrseq node name
  - remove setting pull-ups for mmc3 (default since commit 37bc56128d92)

---
 arch/arm/boot/dts/sun7i-a20-bananapro.dts | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
index f1a33560710f..c17e6407fee0 100644
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
@@ -170,10 +166,19 @@
 &mmc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins_a>;
-	vmmc-supply = <&reg_vmmc3>;
+	vmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
 	non-removable;
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
