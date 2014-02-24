From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Mon, 24 Feb 2014 20:52:56 +0200
Subject: [PATCH] ARM: dts: keystone: add AEMIF/NAND device entry
Message-ID: <1393267976-15709-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add AEMIF/NAND device entry.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---

Based on
git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
keystone/master

 arch/arm/boot/dts/k2hk-evm.dts  | 52 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone.dtsi | 13 +++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
index 1d8ea6e..a08581b 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -84,3 +84,55 @@
 &usb {
 	status = "okay";
 };
+
+&aemif {
+	cs0 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		clock-ranges;
+		ranges;
+
+		ti,cs-chipselect = <0>;
+		/* all timings in nanoseconds */
+		ti,cs-min-turnaround-ns = <12>;
+		ti,cs-read-hold-ns = <6>;
+		ti,cs-read-strobe-ns = <23>;
+		ti,cs-read-setup-ns = <9>;
+		ti,cs-write-hold-ns = <8>;
+		ti,cs-write-strobe-ns = <23>;
+		ti,cs-write-setup-ns = <8>;
+
+		nand at 0,0 {
+			compatible = "ti,keystone-nand","ti,davinci-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0 0 0x4000000
+			       1 0 0x0000100>;
+
+			ti,davinci-chipselect = <0>;
+			ti,davinci-mask-ale = <0x2000>;
+			ti,davinci-mask-cle = <0x4000>;
+			ti,davinci-mask-chipsel = <0>;
+			nand-ecc-mode = "hw";
+			ti,davinci-ecc-bits = <4>;
+			nand-on-flash-bbt;
+
+			partition at 0 {
+				label = "u-boot";
+				reg = <0x0 0x100000>;
+				read-only;
+			};
+
+			partition at 100000 {
+				label = "params";
+				reg = <0x100000 0x80000>;
+				read-only;
+			};
+
+			partition at 180000 {
+				label = "ubifs";
+				reg = <0x180000 0x7E80000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 4eceb46..af80cb2 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -266,5 +266,18 @@
 			ti,ngpio = <32>;
 			ti,davinci-gpio-unbanked = <32>;
 		};
+
+		aemif: aemif at 21000A00 {
+			compatible = "ti,keystone-aemif", "ti,davinci-aemif";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			clocks = <&clkaemif>;
+			clock-names = "aemif";
+			clock-ranges;
+
+			reg = <0x21000A00 0x00000100>;
+			ranges = <0 0 0x30000000 0x10000000
+				  1 0 0x21000A00 0x00000100>;
+		};
 	};
 };
-- 
1.8.3.2
