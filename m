From: niklas.cassel@axis.com (Niklas Cassel)
Date: Fri, 14 Oct 2016 15:09:13 +0200
Subject: [RESEND PATCH 3/3] ARM: dts: artpec: add pcie support
Message-ID: <1476450553-4652-1-git-send-email-niklass@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas Cassel <niklas.cassel@axis.com>

Add PCIe support to the ARTPEC-6 SoC. This uses the existing
pcie-artpec6 driver.
So, all that is needed is device tree entries in the DTS.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 arch/arm/boot/dts/artpec6-devboard.dts |  4 ++++
 arch/arm/boot/dts/artpec6.dtsi         | 29 ++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/artpec6-devboard.dts b/arch/arm/boot/dts/artpec6-devboard.dts
index f823ed3..9dfe845 100644
--- a/arch/arm/boot/dts/artpec6-devboard.dts
+++ b/arch/arm/boot/dts/artpec6-devboard.dts
@@ -46,6 +46,10 @@
 	status = "okay";
 };
 
+&pcie {
+	status = "okay";
+};
+
 &ethernet {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index 3fac4c4..effaa4a 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -66,7 +66,7 @@
 		};
 	};
 
-	syscon {
+	syscon: syscon at f8000000 {
 		compatible = "axis,artpec6-syscon", "syscon";
 		reg = <0xf8000000 0x48>;
 	};
@@ -145,6 +145,33 @@
 		interrupt-parent = <&intc>;
 	};
 
+	pcie: pcie at f8050000 {
+		compatible = "axis,artpec6-pcie", "snps,dw-pcie";
+		reg = <0xf8050000 0x2000
+		       0xf8040000 0x1000
+		       0xc0000000 0x2000>;
+		reg-names = "dbi", "phy", "config";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+			  /* downstream I/O */
+		ranges = <0x81000000 0 0 0xc0002000 0 0x00010000
+			  /* non-prefetchable memory */
+			  0x82000000 0 0xc0012000 0xc0012000 0 0x1ffee000>;
+		num-lanes = <2>;
+		bus-range = <0x00 0xff>;
+		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &intc GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &intc GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &intc GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+		axis,syscon-pcie = <&syscon>;
+		status = "disabled";
+	};
+
 	amba at 0 {
 		compatible = "simple-bus";
 		#address-cells = <0x1>;
-- 
2.1.4
