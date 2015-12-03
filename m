From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Thu,  3 Dec 2015 15:35:23 +0200
Subject: [PATCH v4 4/5] ARM: dts: apq8064: add pcie devicetree node
In-Reply-To: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <1449149725-27607-5-git-send-email-stanimir.varbanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the pcie dt node so that it can probe and used.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi |   36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index a4c1762b53ea..847150fbfdbf 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -659,5 +659,41 @@
 			compatible = "qcom,tcsr-apq8064", "syscon";
 			reg = <0x1a400000 0x100>;
 		};
+
+		pcie: pci at 1b500000 {
+			compatible = "qcom,pcie-apq8064", "snps,dw-pcie";
+			reg = <0x1b500000 0x1000
+			       0x1b502000 0x80
+			       0x1b600000 0x100
+			       0x0ff00000 0x100000>;
+			reg-names = "dbi", "elbi", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x81000000 0 0 0x0fe00000 0 0x00100000   /* I/O */
+				  0x82000000 0 0 0x08000000 0 0x07e00000>; /* memory */
+			interrupts = <GIC_SPI 238 IRQ_TYPE_NONE>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			clocks = <&gcc PCIE_A_CLK>,
+				 <&gcc PCIE_H_CLK>,
+				 <&gcc PCIE_PHY_REF_CLK>;
+			clock-names = "core", "iface", "phy";
+			resets = <&gcc PCIE_ACLK_RESET>,
+				 <&gcc PCIE_HCLK_RESET>,
+				 <&gcc PCIE_POR_RESET>,
+				 <&gcc PCIE_PCI_RESET>,
+				 <&gcc PCIE_PHY_RESET>;
+			reset-names = "axi", "ahb", "por", "pci", "phy";
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5
