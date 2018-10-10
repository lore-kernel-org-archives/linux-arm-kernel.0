From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 10 Oct 2018 15:07:37 +0300
Subject: [PATCH v3 22/22] arm64: dts: ls104x: use a pseudo-bus to constrain
 usb dma size
In-Reply-To: <20181010120737.30300-1-laurentiu.tudor@nxp.com>
References: <20181010120737.30300-1-laurentiu.tudor@nxp.com>
Message-ID: <20181010120737.30300-20-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Wrap the usb controllers in an intermediate simple-bus and use it to
constrain the dma address size of these usb controllers to the 40 bits
that they generate toward the interconnect.
This is required because the SoC uses 48 bits address sizes and this
mismatch would lead to smmu context faults because the usb generates
40-bit addresses while the smmu page tables are populated with 48-bit
wide addresses.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 58 +++++++++++--------
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 58 +++++++++++--------
 2 files changed, 66 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 9fb3ac0fa87c..44a1964e560b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -647,31 +647,39 @@
 				 <&clockgen 4 0>;
 		};
 
-		usb0: usb3 at 2f00000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0x2f00000 0x0 0x10000>;
-			interrupts = <0 60 0x4>;
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-		};
-
-		usb1: usb3 at 3000000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3000000 0x0 0x10000>;
-			interrupts = <0 61 0x4>;
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-		};
-
-		usb2: usb3 at 3100000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3100000 0x0 0x10000>;
-			interrupts = <0 63 0x4>;
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
+		usb_aux_bus: usb_aux_bus {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			compatible = "simple-bus";
+			ranges;
+			dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
+
+			usb0: usb3 at 2f00000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x2f00000 0x0 0x10000>;
+				interrupts = <0 60 0x4>;
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+			};
+
+			usb1: usb3 at 3000000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3000000 0x0 0x10000>;
+				interrupts = <0 61 0x4>;
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+			};
+
+			usb2: usb3 at 3100000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3100000 0x0 0x10000>;
+				interrupts = <0 63 0x4>;
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+			};
 		};
 
 		sata: sata at 3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index f19cf6087235..edee071aaefd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -608,31 +608,39 @@
 				 <&clockgen 4 1>;
 		};
 
-		usb0: usb at 2f00000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0x2f00000 0x0 0x10000>;
-			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-		};
-
-		usb1: usb at 3000000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3000000 0x0 0x10000>;
-			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-		};
-
-		usb2: usb at 3100000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3100000 0x0 0x10000>;
-			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
+		usb_aux_bus: usb_aux_bus {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			compatible = "simple-bus";
+			ranges;
+			dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
+
+			usb0: usb at 2f00000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x2f00000 0x0 0x10000>;
+				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+			};
+
+			usb1: usb at 3000000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3000000 0x0 0x10000>;
+				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+			};
+
+			usb2: usb at 3100000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3100000 0x0 0x10000>;
+				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+			};
 		};
 
 		sata: sata at 3200000 {
-- 
2.17.1
