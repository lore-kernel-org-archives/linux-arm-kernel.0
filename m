From: jon.mason@broadcom.com (Jon Mason)
Date: Mon, 28 Nov 2016 14:31:30 -0500
Subject: [PATCH 1/2] arm64: dts: NS2: enable GICv2m for PAXB/PAXC interfaces
In-Reply-To: <1480361491-22221-1-git-send-email-jon.mason@broadcom.com>
References: <1480361491-22221-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1480361491-22221-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PAXB and PAXC PCIe interfaces on NS2 have been using the iProc event
queue to handle MSI. With the gicv2m support ready, we should now switch
to gicv2m for MSI handling

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 104 ++++++++++++++++++++++++++--------
 1 file changed, 80 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 4fcdeca..69775a8 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -115,7 +115,7 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 281 IRQ_TYPE_NONE>;
+		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 281 IRQ_TYPE_NONE>;
 
 		linux,pci-domain = <0>;
 
@@ -136,18 +136,7 @@
 		phys = <&pci_phy0>;
 		phy-names = "pcie-phy";
 
-		msi-parent = <&msi0>;
-		msi0: msi at 20020000 {
-			compatible = "brcm,iproc-msi";
-			msi-controller;
-			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 277 IRQ_TYPE_NONE>,
-				     <GIC_SPI 278 IRQ_TYPE_NONE>,
-				     <GIC_SPI 279 IRQ_TYPE_NONE>,
-				     <GIC_SPI 280 IRQ_TYPE_NONE>;
-			brcm,num-eq-region = <1>;
-			brcm,num-msi-msg-region = <1>;
-		};
+		msi-parent = <&v2m0>;
 	};
 
 	pcie4: pcie at 50020000 {
@@ -156,7 +145,7 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 305 IRQ_TYPE_NONE>;
+		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 305 IRQ_TYPE_NONE>;
 
 		linux,pci-domain = <4>;
 
@@ -177,16 +166,7 @@
 		phys = <&pci_phy1>;
 		phy-names = "pcie-phy";
 
-		msi-parent = <&msi4>;
-		msi4: msi at 50020000 {
-			compatible = "brcm,iproc-msi";
-			msi-controller;
-			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 301 IRQ_TYPE_NONE>,
-				     <GIC_SPI 302 IRQ_TYPE_NONE>,
-				     <GIC_SPI 303 IRQ_TYPE_NONE>,
-				     <GIC_SPI 304 IRQ_TYPE_NONE>;
-		};
+		msi-parent = <&v2m0>;
 	};
 
 	soc: soc {
@@ -331,6 +311,82 @@
 			      <0x65260000 0x1000>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0xf) |
 				      IRQ_TYPE_LEVEL_HIGH)>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x652e0000 0x80000>;
+
+			v2m0: v2m at 00000 {
+				compatible = "arm,gic-v2m-frame";
+				interrupt-parent = <&gic>;
+				msi-controller;
+				reg = <0x00000 0x1000>;
+				arm,msi-base-spi = <72>;
+				arm,msi-num-spis = <16>;
+			};
+
+			v2m1: v2m at 10000 {
+				compatible = "arm,gic-v2m-frame";
+				interrupt-parent = <&gic>;
+				msi-controller;
+				reg = <0x10000 0x1000>;
+				arm,msi-base-spi = <88>;
+				arm,msi-num-spis = <16>;
+			};
+
+			v2m2: v2m at 20000 {
+				compatible = "arm,gic-v2m-frame";
+				interrupt-parent = <&gic>;
+				msi-controller;
+				reg = <0x20000 0x1000>;
+				arm,msi-base-spi = <104>;
+				arm,msi-num-spis = <16>;
+			};
+
+			v2m3: v2m at 30000 {
+				compatible = "arm,gic-v2m-frame";
+				interrupt-parent = <&gic>;
+				msi-controller;
+				reg = <0x30000 0x1000>;
+				arm,msi-base-spi = <120>;
+				arm,msi-num-spis = <16>;
+			};
+
+			v2m4: v2m at 40000 {
+				compatible = "arm,gic-v2m-frame";
+				interrupt-parent = <&gic>;
+				msi-controller;
+				reg = <0x40000 0x1000>;
+				arm,msi-base-spi = <136>;
+				arm,msi-num-spis = <16>;
+			};
+
+			v2m5: v2m at 50000 {
+				compatible = "arm,gic-v2m-frame";
+				interrupt-parent = <&gic>;
+				msi-controller;
+				reg = <0x50000 0x1000>;
+				arm,msi-base-spi = <152>;
+				arm,msi-num-spis = <16>;
+			};
+
+			v2m6: v2m at 60000 {
+				compatible = "arm,gic-v2m-frame";
+				interrupt-parent = <&gic>;
+				msi-controller;
+				reg = <0x60000 0x1000>;
+				arm,msi-base-spi = <168>;
+				arm,msi-num-spis = <16>;
+			};
+
+			v2m7: v2m at 70000 {
+				compatible = "arm,gic-v2m-frame";
+				interrupt-parent = <&gic>;
+				msi-controller;
+				reg = <0x70000 0x1000>;
+				arm,msi-base-spi = <184>;
+				arm,msi-num-spis = <16>;
+			};
 		};
 
 		cci at 65590000 {
-- 
2.7.4
