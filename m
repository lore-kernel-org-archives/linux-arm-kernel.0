From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Jun 2017 23:56:46 +0200
Subject: [PATCH] ARM: dts: add Gemini PATA/SATA support
Message-ID: <20170613215646.22106-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAS4229B and SQ201 Gemini systems have a PATA controller
which is linked to a SATA bridge in the SoC. Enable both
platforms to use the PATA/SATA devices.

Cc: John Feng-Hsin Chiang <john453@faraday-tech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
The driver has been merged to the libata tree. The clock and reset
lines are added with numerical values as we do not want to
depend on <dt-bindings/*> headers in the merge window. Will
be fixed post-rc1.
---
 arch/arm/boot/dts/gemini-nas4220b.dts | 10 ++++++++++
 arch/arm/boot/dts/gemini-sq201.dts    | 10 ++++++++++
 arch/arm/boot/dts/gemini.dtsi         | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/gemini-nas4220b.dts b/arch/arm/boot/dts/gemini-nas4220b.dts
index 7668ba52158e..55f6a4f1f801 100644
--- a/arch/arm/boot/dts/gemini-nas4220b.dts
+++ b/arch/arm/boot/dts/gemini-nas4220b.dts
@@ -98,5 +98,15 @@
 				read-only;
 			};
 		};
+
+		sata: sata at 46000000 {
+			cortina,gemini-ata-muxmode = <0>;
+			cortina,gemini-enable-sata-bridge;
+			status = "okay";
+		};
+
+		ata at 63000000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
index 46309e79cc7b..4d200f0bcd45 100644
--- a/arch/arm/boot/dts/gemini-sq201.dts
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -93,6 +93,12 @@
 			};
 		};
 
+		sata: sata at 46000000 {
+			cortina,gemini-ata-muxmode = <0>;
+			cortina,gemini-enable-sata-bridge;
+			status = "okay";
+		};
+
 		pci at 50000000 {
 			status = "okay";
 			interrupt-map-mask = <0xf800 0 0 7>;
@@ -114,5 +120,9 @@
 				<0x6000 0 0 3 &pci_intc 1>,
 				<0x6000 0 0 4 &pci_intc 2>;
 		};
+
+		ata at 63000000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 0beaa4ef757e..141d8d3a1d07 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -81,6 +81,19 @@
 			clock-names = "PCLK", "EXTCLK";
 		};
 
+		sata: sata at 46000000 {
+			compatible = "cortina,gemini-sata-bridge";
+			reg = <0x46000000 0x100>;
+			resets = <&syscon 26>,
+				 <&syscon 27>;
+			reset-names = "sata0", "sata1";
+			clocks = <&syscon 10>,
+				 <&syscon 11>;
+			clock-names = "SATA0_PCLK", "SATA1_PCLK";
+			syscon = <&syscon>;
+			status = "disabled";
+		};
+
 		intcon: interrupt-controller at 48000000 {
 			compatible = "faraday,ftintc010";
 			reg = <0x48000000 0x1000>;
@@ -176,6 +189,28 @@
 			};
 		};
 
+		ata at 63000000 {
+			compatible = "cortina,gemini-pata", "faraday,ftide010";
+			reg = <0x63000000 0x1000>;
+			interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+			resets = <&syscon 2>;
+			clocks = <&syscon 14>;
+			clock-names = "PCLK";
+			sata = <&sata>;
+			status = "disabled";
+		};
+
+		ata at 63400000 {
+			compatible = "cortina,gemini-pata", "faraday,ftide010";
+			reg = <0x63400000 0x1000>;
+			interrupts = <5 IRQ_TYPE_EDGE_RISING>;
+			resets = <&syscon 2>;
+			clocks = <&syscon 14>;
+			clock-names = "PCLK";
+			sata = <&sata>;
+			status = "disabled";
+		};
+
 		dma-controller at 67000000 {
 			compatible = "faraday,ftdma020", "arm,pl080", "arm,primecell";
 			/* Faraday Technology FTDMAC020 variant */
-- 
2.9.4
