From: rsahu@apm.com (Rameshwar Prasad Sahu)
Date: Mon, 19 Jan 2015 18:11:08 +0530
Subject: [PATCH v3 2/3] arm64: dts: Add APM X-Gene DMA device and DMA clock
 DTS nodes
In-Reply-To: <1421671269-19441-1-git-send-email-rsahu@apm.com>
References: <1421671269-19441-1-git-send-email-rsahu@apm.com>
Message-ID: <1421671269-19441-3-git-send-email-rsahu@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree node for APM X-Gene SoC
DMA controller and DMA clock.

Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index f1ad9c2..e20da23 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -103,6 +103,9 @@
 		#size-cells = <2>;
 		ranges;

+		/* DDR range is 42-bit addressing */
+		dma-ranges = <0x40 0x0 0x40 0x0 0x1ff 0xffffffff>;
+
 		clocks {
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -352,6 +355,15 @@
 				reg-names = "csr-reg";
 				clock-output-names = "pcie4clk";
 			};
+
+			dmaclk: dmaclk at 1f27c000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				reg = <0x0 0x1f27c000 0x0 0x1000>;
+				reg-names = "csr-reg";
+				clock-output-names = "dmaclk";
+			};
 		};

 		pcie0: pcie at 1f2b0000 {
@@ -656,5 +668,21 @@
 			interrupts = <0x0 0x41 0x4>;
 			clocks = <&rngpkaclk 0>;
 		};
+
+		dma: dma at 1f270000 {
+			compatible = "apm,xgene-dma";
+			device_type = "dma";
+			reg = <0x0 0x1f270000 0x0 0x10000>,
+			      <0x0 0x1f200000 0x0 0x10000>,
+			      <0x0 0x1b008000 0x0 0x2000>;
+			reg-names = "dma_csr", "ring_csr", "ring_cmd";
+			interrupts = <0x0 0x82 0x4>,
+				     <0x0 0xb8 0x4>,
+				     <0x0 0xb9 0x4>,
+				     <0x0 0xba 0x4>,
+				     <0x0 0xbb 0x4>;
+			dma-coherent;
+			clocks = <&dmaclk 0>;
+		};
 	};
 };
--
1.8.2.1
