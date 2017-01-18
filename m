From: jerry.huang@nxp.com (Changming Huang)
Date: Wed, 18 Jan 2017 16:12:17 +0800
Subject: [PATCH v4 2/3] USB3/DWC3: Add property "snps,
 incr-burst-type-adjustment" for INCR burst type
In-Reply-To: <1484727138-3264-1-git-send-email-jerry.huang@nxp.com>
References: <1484727138-3264-1-git-send-email-jerry.huang@nxp.com>
Message-ID: <1484727138-3264-2-git-send-email-jerry.huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Property "snps,incr-burst-type-adjustment = <x>, <y>..." for USB3.0 DWC3.
When Just one value means INCRx mode with fix burst type.
When more than one value, means undefined length burst mode, USB controller
can use the length less than or equal to the largest enabled burst length.

While enabling undefined length INCR burst type and INCR16 burst type,
get better write performance on NXP Layerscape platform:
around 3% improvement (from 364MB/s to 375MB/s).

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
---
Changes in v4:
  - change definition for this property.
Changes in v3:
  - add new property for INCR burst in usb node.

 Documentation/devicetree/bindings/usb/dwc3.txt |    6 ++++++
 arch/arm/boot/dts/ls1021a.dtsi                 |    1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi |    2 ++
 4 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index e3e6983..a68dbfc 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -55,6 +55,11 @@ Optional properties:
 	fladj_30mhz_sdbnd signal is invalid or incorrect.
 
  - <DEPRECATED> tx-fifo-resize: determines if the FIFO *has* to be reallocated.
+ - snps,incr-burst-type-adjustment: Value for INCR burst type of GSBUSCFG0
+	register, undefined length INCR burst type enable and INCRx type.
+	When just one value, which means INCRX burst mode. When more than one
+	value, which means undefined length INCR burst type enabled.
+	The values can be 1, 4, 8, 16, 32, 64, 128 and 256.
 
 This is usually a subnode to DWC3 glue to which it is connected.
 
@@ -63,4 +68,5 @@ dwc3 at 4a030000 {
 	reg = <0x4a030000 0xcfff>;
 	interrupts = <0 92 4>
 	usb-phy = <&usb2_phy>, <&usb3,phy>;
+	snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 };
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 368e219..6eee0d5 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -627,6 +627,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		pcie at 3400000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 97d331e..04ffd66 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -482,6 +482,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb3 at 3000000 {
@@ -491,6 +492,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb2: usb3 at 3100000 {
@@ -500,6 +502,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		sata: sata at 3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index d058e56..902cc93 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -710,6 +710,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb3 at 3110000 {
@@ -720,6 +721,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		ccn at 4000000 {
-- 
1.7.9.5
