From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 8 May 2014 23:32:54 +0300
Subject: [PATCH v2] ARM: dts: k2e-evm: add AEMIF/NAND device entry
In-Reply-To: <1399575560-31090-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1399575560-31090-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1399581174-2561-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add AEMIF/NAND device entry.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 arch/arm/boot/dts/k2e-evm.dts | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/k2e-evm.dts b/arch/arm/boot/dts/k2e-evm.dts
index d60ce34..fb7afab 100644
--- a/arch/arm/boot/dts/k2e-evm.dts
+++ b/arch/arm/boot/dts/k2e-evm.dts
@@ -65,3 +65,55 @@
 		reg = <0x50>;
 	};
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
+				reg = <0x180000 0x1FE80000>;
+			};
+		};
+	};
+};
-- 
1.8.3.2
