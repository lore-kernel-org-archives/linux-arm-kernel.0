From: niklas.cassel@axis.com (Niklas Cassel)
Date: Wed, 21 Feb 2018 09:59:59 +0100
Subject: [PATCH v2 7/8] ARM: dts: artpec: add disabled node for PCIe endpoint
 mode
In-Reply-To: <20180221090000.18091-1-niklas.cassel@axis.com>
References: <20180221090000.18091-1-niklas.cassel@axis.com>
Message-ID: <20180221090000.18091-8-niklas.cassel@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCIe controller in the artpec6 SoC supports both root complex and
endpoint mode, however, the controller can only be used in one of the
modes.

Both pci nodes are disabled by default. A DTS file can enable one of
them, depending on what mode it wants to run.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
Changes since V1:
removed unused properties "interrupts" and "interrupt-names"

 arch/arm/boot/dts/artpec6.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index 1c46df0c03ce..b7720be8afb1 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -154,6 +154,10 @@
 		interrupt-affinity = <&cpu0>, <&cpu1>;
 	};
 
+	/*
+	 * Both pci nodes cannot be enabled at the same time,
+	 * leave the unwanted node as disabled.
+	 */
 	pcie: pcie at f8050000 {
 		compatible = "axis,artpec6-pcie", "snps,dw-pcie";
 		reg = <0xf8050000 0x2000
@@ -181,6 +185,20 @@
 		status = "disabled";
 	};
 
+	pcie_ep: pcie_ep@f8050000 {
+		compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
+		reg = <0xf8050000 0x2000
+		       0xf8051000 0x2000
+		       0xf8040000 0x1000
+		       0xc0000000 0x20000000>;
+		reg-names = "dbi", "dbi2", "phy", "addr_space";
+		num-ib-windows = <6>;
+		num-ob-windows = <2>;
+		num-lanes = <2>;
+		axis,syscon-pcie = <&syscon>;
+		status = "disabled";
+	};
+
 	pinctrl: pinctrl at f801d000 {
 		compatible = "axis,artpec6-pinctrl";
 		reg = <0xf801d000 0x400>;
-- 
2.14.2
