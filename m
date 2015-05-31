From: dt.tangr@gmail.com (Daniel Tang)
Date: Sun, 31 May 2015 19:44:02 +1000
Subject: [PATCH] devicetree: Add support for I2C and related devices to
 TI-NSPIRE platform
Message-ID: <1433065442-92750-1-git-send-email-dt.tangr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree entries for I2C hardware to the TI-NSPIRE
platforms that have it.

It also adds support for the touchpad that communicates over the I2C
bus.


Signed-off-by: Daniel Tang <dt.tangr@gmail.com>
---
 arch/arm/boot/dts/nspire-cx.dts | 13 +++++++++++++
 arch/arm/boot/dts/nspire-tp.dts | 14 ++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/nspire-cx.dts b/arch/arm/boot/dts/nspire-cx.dts
index 08e0b81..e369e3b 100644
--- a/arch/arm/boot/dts/nspire-cx.dts
+++ b/arch/arm/boot/dts/nspire-cx.dts
@@ -104,9 +104,22 @@
 			#size-cells = <1>;
 
 			i2c at 90050000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
 				compatible = "snps,designware-i2c";
 				reg = <0x90050000 0x1000>;
 				interrupts = <20>;
+
+				clocks = <&apb_pclk>;
+
+				i2c-sda-falling-time-ns = <810>;
+				i2c-scl-falling-time-ns = <2410>;
+
+				touchpad at 20 {
+					compatible = "synaptics_i2c";
+					reg = <0x20>;
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/nspire-tp.dts b/arch/arm/boot/dts/nspire-tp.dts
index 621391c..49fb97a 100644
--- a/arch/arm/boot/dts/nspire-tp.dts
+++ b/arch/arm/boot/dts/nspire-tp.dts
@@ -41,4 +41,18 @@
 / {
 	model = "TI-NSPIRE Touchpad";
 	compatible = "ti,nspire-tp";
+
+	i2c at gpio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		compatible = "i2c-gpio";
+		gpios = < &gpio 3 0 /* sda */
+			  &gpio 1 0 /* scl */ >;
+
+		touchpad at 20 {
+			compatible = "synaptics_i2c";
+			reg = <0x20>;
+		};
+	};
 };
-- 
2.2.1
