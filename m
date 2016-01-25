From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 25 Jan 2016 15:14:08 +0000
Subject: [PATCH v2 1/2] arm64: dts: move juno pcie-controller to base file
Message-ID: <1453734849-13790-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCIe controller is found on all Juno SoC version. However it's not
functional on R0 due to some hardware bug.

In preparation to add Juno R2 support, this patch moves the
pcie-controller defination to base DTS file. It's marked as disabled by
default and is enabled for Juno R1 explicitly.

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-r1.dts    | 25 ++++---------------------
 2 files changed, 26 insertions(+), 21 deletions(-)

v1->v2:
	- Moved pcie-controller to juno-base.dtsi

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index dd5158eb5872..b501721baf77 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -75,6 +75,28 @@
 		};
 	};
 
+	pcie_ctlr: pcie-controller at 40000000 {
+		compatible = "arm,juno-r1-pcie", "plda,xpressrich3-axi", "pci-host-ecam-generic";
+		device_type = "pci";
+		reg = <0 0x40000000 0 0x10000000>;	/* ECAM config space */
+		bus-range = <0 255>;
+		linux,pci-domain = <0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		dma-coherent;
+		ranges = <0x01000000 0x00 0x5f800000 0x00 0x5f800000 0x0 0x00800000>,
+			 <0x02000000 0x00 0x50000000 0x00 0x50000000 0x0 0x08000000>,
+			 <0x42000000 0x40 0x00000000 0x40 0x00000000 0x1 0x00000000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &gic 0 0 0 136 4>,
+				<0 0 0 2 &gic 0 0 0 137 4>,
+				<0 0 0 3 &gic 0 0 0 138 4>,
+				<0 0 0 4 &gic 0 0 0 139 4>;
+		msi-parent = <&v2m_0>;
+		status = "disabled";
+	};
+
 	scpi {
 		compatible = "arm,scpi";
 		mboxes = <&mailbox 1>;
diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index 8826f834f54f..d95d9e7e2dc0 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -172,29 +172,12 @@
 	};
 
 	#include "juno-base.dtsi"
-
-	pcie-controller at 40000000 {
-		compatible = "arm,juno-r1-pcie", "plda,xpressrich3-axi", "pci-host-ecam-generic";
-		device_type = "pci";
-		reg = <0 0x40000000 0 0x10000000>;	/* ECAM config space */
-		bus-range = <0 255>;
-		linux,pci-domain = <0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		dma-coherent;
-		ranges = <0x01000000 0x00 0x5f800000 0x00 0x5f800000 0x0 0x00800000>,
-			 <0x02000000 0x00 0x50000000 0x00 0x50000000 0x0 0x08000000>,
-			 <0x42000000 0x40 0x00000000 0x40 0x00000000 0x1 0x00000000>;
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &gic 0 0 0 136 4>,
-				<0 0 0 2 &gic 0 0 0 137 4>,
-				<0 0 0 3 &gic 0 0 0 138 4>,
-				<0 0 0 4 &gic 0 0 0 139 4>;
-		msi-parent = <&v2m_0>;
-	};
 };
 
 &memtimer {
 	status = "okay";
 };
+
+&pcie_ctlr {
+	status = "okay";
+};
-- 
1.9.1
