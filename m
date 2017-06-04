From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  4 Jun 2017 10:50:09 +0200
Subject: [PATCH 4/4 v4] ARM: dts: add Gemini PATA/SATA support
In-Reply-To: <20170604085009.11902-1-linus.walleij@linaro.org>
References: <20170604085009.11902-1-linus.walleij@linaro.org>
Message-ID: <20170604085009.11902-4-linus.walleij@linaro.org>
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
ChangeLog v3->v4:
- No changes, just resending to keep the patch set together.
ChangeLog v2->v3:
- No changes, just resending to keep the patch set together.
- Cut the timings also from the second device instance.
ChangeLog v1->v2:
- Cut the timings - we open code these in the driver instead.
- Reference syscon node for clocks and resets as requested by
  the devicetree reviewers.
- Use reset line #defines from the new header file.

PATA maintainers: this file will be applied by me through the ARM
SoC git tree. It is provided for reference only so you see how
it will be used.
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
index 8e833744e855..49cce9e9d51f 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -83,6 +83,19 @@
 			clock-names = "PCLK", "EXTCLK";
 		};
 
+		sata: sata at 46000000 {
+			compatible = "cortina,gemini-sata-bridge";
+			reg = <0x46000000 0x100>;
+			resets = <&syscon GEMINI_RESET_SATA0>,
+				 <&syscon GEMINI_RESET_SATA1>;
+			reset-names = "sata0", "sata1";
+			clocks = <&syscon GEMINI_CLK_GATE_SATA0>,
+				 <&syscon GEMINI_CLK_GATE_SATA1>;
+			clock-names = "SATA0_PCLK", "SATA1_PCLK";
+			syscon = <&syscon>;
+			status = "disabled";
+		};
+
 		intcon: interrupt-controller at 48000000 {
 			compatible = "faraday,ftintc010";
 			reg = <0x48000000 0x1000>;
@@ -178,6 +191,28 @@
 			};
 		};
 
+		ata at 63000000 {
+			compatible = "cortina,gemini-pata", "faraday,ftide010";
+			reg = <0x63000000 0x1000>;
+			interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+			resets = <&syscon GEMINI_RESET_IDE>;
+			clocks = <&syscon GEMINI_CLK_GATE_IDE>;
+			clock-names = "PCLK";
+			sata = <&sata>;
+			status = "disabled";
+		};
+
+		ata at 63400000 {
+			compatible = "cortina,gemini-pata", "faraday,ftide010";
+			reg = <0x63400000 0x1000>;
+			interrupts = <5 IRQ_TYPE_EDGE_RISING>;
+			resets = <&syscon GEMINI_RESET_IDE>;
+			clocks = <&syscon GEMINI_CLK_GATE_IDE>;
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
