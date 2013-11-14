From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Nov 2013 18:35:37 -0800
Subject: [PATCH 8/8] ARM: dts: Fix omap2 specific dtsi files by adding the
 missing entries
In-Reply-To: <1384396537-3486-1-git-send-email-tony@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
Message-ID: <1384396537-3486-9-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like we're missing few entries for omap2 and the drivers
have only worked because of the omap hwmod building the devices
for the missing entries.

Let's fix the missing entries so we don't need to rely on hwmod
for the basic data and can then later on remove the duplicate
data from hwmod. Otherwise device tree only drivers will not
work properly.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap2.dtsi    | 96 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap2420.dtsi | 23 ++++++++++
 arch/arm/boot/dts/omap2430.dtsi | 49 +++++++++++++++++++++
 3 files changed, 168 insertions(+)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index a2bfcde..d0c5b37 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/omap.h>
 
 #include "skeleton.dtsi"
@@ -21,6 +22,8 @@
 		serial0 = &uart1;
 		serial1 = &uart2;
 		serial2 = &uart3;
+		i2c0 = &i2c1;
+		i2c1 = &i2c2;
 	};
 
 	cpus {
@@ -53,6 +56,28 @@
 		ranges;
 		ti,hwmods = "l3_main";
 
+		aes: aes at 480a6000 {
+			compatible = "ti,omap2-aes";
+			ti,hwmods = "aes";
+			reg = <0x480a6000 0x50>;
+			dmas = <&sdma 9 &sdma 10>;
+			dma-names = "tx", "rx";
+		};
+
+		hdq1w: 1w at 480b2000 {
+			compatible = "ti,omap2420-1w";
+			ti,hwmods = "hdq1w";
+			reg = <0x480b2000 0x1000>;
+			interrupts = <58>;
+		};
+
+		mailbox: mailbox at 48094000 {
+			compatible = "ti,omap2-mailbox";
+			ti,hwmods = "mailbox";
+			reg = <0x48094000 0x200>;
+			interrupts = <26>;
+		};
+
 		intc: interrupt-controller at 1 {
 			compatible = "ti,omap2-intc";
 			interrupt-controller;
@@ -63,6 +88,7 @@
 
 		sdma: dma-controller at 48056000 {
 			compatible = "ti,omap2430-sdma", "ti,omap2420-sdma";
+			ti,hwmods = "dma";
 			reg = <0x48056000 0x1000>;
 			interrupts = <12>,
 				     <13>,
@@ -73,21 +99,91 @@
 			#dma-requests = <64>;
 		};
 
+		i2c1: i2c at 48070000 {
+			compatible = "ti,omap2-i2c";
+			ti,hwmods = "i2c1";
+			reg = <0x48070000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <56>;
+			dmas = <&sdma 27 &sdma 28>;
+			dma-names = "tx", "rx";
+		};
+
+		i2c2: i2c at 48072000 {
+			compatible = "ti,omap2-i2c";
+			ti,hwmods = "i2c2";
+			reg = <0x48072000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <57>;
+			dmas = <&sdma 29 &sdma 30>;
+			dma-names = "tx", "rx";
+		};
+
+		mcspi1: mcspi at 48098000 {
+			compatible = "ti,omap2-mcspi";
+			ti,hwmods = "mcspi1";
+			reg = <0x48098000 0x100>;
+			interrupts = <65>;
+			dmas = <&sdma 35 &sdma 36 &sdma 37 &sdma 38
+				&sdma 39 &sdma 40 &sdma 41 &sdma 42>;
+			dma-names = "tx0", "rx0", "tx1", "rx1",
+				    "tx2", "rx2", "tx3", "rx3";
+		};
+
+		mcspi2: mcspi at 4809a000 {
+			compatible = "ti,omap2-mcspi";
+			ti,hwmods = "mcspi2";
+			reg = <0x4809a000 0x100>;
+			interrupts = <66>;
+			dmas = <&sdma 43 &sdma 44 &sdma 45 &sdma 46>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
+		};
+
+		rng: rng at 480a0000 {
+			compatible = "ti,omap2-rng";
+			ti,hwmods = "rng";
+			reg = <0x480a0000 0x50>;
+			interrupts = <36>;
+		};
+
+		sham: sham at 480a4000 {
+			compatible = "ti,omap2-sham";
+			ti,hwmods = "sham";
+			reg = <0x480a4000 0x64>;
+			interrupts = <51>;
+			dmas = <&sdma 13>;
+			dma-names = "rx";
+		};
+
 		uart1: serial at 4806a000 {
 			compatible = "ti,omap2-uart";
 			ti,hwmods = "uart1";
+			reg = <0x4806a000 0x2000>;
+			interrupts = <72>;
+			dmas = <&sdma 49 &sdma 50>;
+			dma-names = "tx", "rx";
 			clock-frequency = <48000000>;
 		};
 
 		uart2: serial at 4806c000 {
 			compatible = "ti,omap2-uart";
 			ti,hwmods = "uart2";
+			reg = <0x4806c000 0x400>;
+			interrupts = <73>;
+			dmas = <&sdma 51 &sdma 52>;
+			dma-names = "tx", "rx";
 			clock-frequency = <48000000>;
 		};
 
 		uart3: serial at 4806e000 {
 			compatible = "ti,omap2-uart";
 			ti,hwmods = "uart3";
+			reg = <0x4806e000 0x400>;
+			interrupts = <74>;
+			dmas = <&sdma 53 &sdma 54>;
+			dma-names = "tx", "rx";
 			clock-frequency = <48000000>;
 		};
 
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index c8f9c55..60c605d 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -114,6 +114,15 @@
 			dma-names = "tx", "rx";
 		};
 
+		msdi1: mmc at 4809c000 {
+			compatible = "ti,omap2420-mmc";
+			ti,hwmods = "msdi1";
+			reg = <0x4809c000 0x80>;
+			interrupts = <83>;
+			dmas = <&sdma 61 &sdma 62>;
+			dma-names = "tx", "rx";
+		};
+
 		timer1: timer at 48028000 {
 			compatible = "ti,omap2420-timer";
 			reg = <0x48028000 0x400>;
@@ -121,5 +130,19 @@
 			ti,hwmods = "timer1";
 			ti,timer-alwon;
 		};
+
+		wd_timer2: wdt at 48022000 {
+			compatible = "ti,omap2-wdt";
+			ti,hwmods = "wd_timer2";
+			reg = <0x48022000 0x80>;
+		};
 	};
 };
+
+&i2c1 {
+	compatible = "ti,omap2420-i2c";
+};
+
+&i2c2 {
+	compatible = "ti,omap2420-i2c";
+};
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index c535a5a..d624345 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -175,6 +175,25 @@
 			dma-names = "tx", "rx";
 		};
 
+		mmc1: mmc at 4809c000 {
+			compatible = "ti,omap2-hsmmc";
+			reg = <0x4809c000 0x200>;
+			interrupts = <83>;
+			ti,hwmods = "mmc1";
+			ti,dual-volt;
+			dmas = <&sdma 61>, <&sdma 62>;
+			dma-names = "tx", "rx";
+		};
+
+		mmc2: mmc at 480b4000 {
+			compatible = "ti,omap2-hsmmc";
+			reg = <0x480b4000 0x200>;
+			interrupts = <86>;
+			ti,hwmods = "mmc2";
+			dmas = <&sdma 47>, <&sdma 48>;
+			dma-names = "tx", "rx";
+		};
+
 		timer1: timer at 49018000 {
 			compatible = "ti,omap2420-timer";
 			reg = <0x49018000 0x400>;
@@ -182,5 +201,35 @@
 			ti,hwmods = "timer1";
 			ti,timer-alwon;
 		};
+
+		mcspi3: mcspi at 480b8000 {
+			compatible = "ti,omap2-mcspi";
+			ti,hwmods = "mcspi3";
+			reg = <0x480b8000 0x100>;
+			interrupts = <91>;
+			dmas = <&sdma 15 &sdma 16 &sdma 23 &sdma 24>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
+		};
+
+		usb_otg_hs: usb_otg_hs at 480ac000 {
+			compatible = "ti,omap2-musb";
+			ti,hwmods = "usb_otg_hs";
+			reg = <0x480ac000 0x1000>;
+			interrupts = <93>;
+		};
+
+		wd_timer2: wdt at 49016000 {
+			compatible = "ti,omap2-wdt";
+			ti,hwmods = "wd_timer2";
+			reg = <0x49016000 0x80>;
+		};
 	};
 };
+
+&i2c1 {
+	compatible = "ti,omap2430-i2c";
+};
+
+&i2c2 {
+	compatible = "ti,omap2430-i2c";
+};
-- 
1.8.1.1
