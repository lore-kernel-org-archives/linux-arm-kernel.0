From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 29 Jan 2018 10:41:28 +0530
Subject: [PATCH 14/15] ARM: dts: ipq8074: Add pcie nodes
In-Reply-To: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1517202689-14212-15-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver/phy support for ipq8074 is available now.
So enabling the nodes in DT.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 155 +++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 07d3bf7..9bfbad9 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -24,7 +24,7 @@
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
-		pinctrl at 1000000 {
+		tlmm: pinctrl at 1000000 {
 			compatible = "qcom,ipq8074-pinctrl";
 			reg = <0x1000000 0x300000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
@@ -227,6 +227,159 @@
 			dma-names = "tx", "rx", "cmd";
 			status = "disabled";
 		};
+
+		pcie_phy0: phy at 86000 {
+			compatible = "qcom,ipq8074-qmp-pcie-phy";
+			reg = <0x86000 0x1000>;
+			#phy-cells = <0>;
+			clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
+			clock-names = "pipe_clk";
+			clock-output-names = "pcie20_phy0_pipe_clk";
+
+			resets = <&gcc GCC_PCIE0_PHY_BCR>,
+				<&gcc GCC_PCIE0PHY_PHY_BCR>;
+			reset-names = "phy",
+				      "common";
+		};
+
+		pcie0: pci at 20000000 {
+			compatible = "qcom,pcie-ipq8074";
+			reg =  <0x20000000 0xf1d
+				0x20000F20 0xa8
+				0x80000 0x2000
+				0x20100000 0x1000>;
+			reg-names = "dbi", "elbi", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie_phy0>;
+			phy-names = "pciephy";
+
+			ranges = <0x81000000 0 0x20200000 0x20200000
+				  0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0x20300000 0x20300000
+				  0 0x00d00000>; /* non-prefetchable memory */
+
+			interrupts = <GIC_SPI 52 IRQ_TYPE_NONE>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 75
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 78
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 79
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 83
+					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
+				 <&gcc GCC_PCIE0_AXI_M_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_CLK>,
+				 <&gcc GCC_PCIE0_AHB_CLK>,
+				 <&gcc GCC_PCIE0_AUX_CLK>;
+
+			clock-names = "iface",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "aux";
+			resets = <&gcc GCC_PCIE0_PIPE_ARES>,
+				 <&gcc GCC_PCIE0_SLEEP_ARES>,
+				 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
+				 <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
+				 <&gcc GCC_PCIE0_AHB_ARES>,
+				 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>;
+			reset-names = "pipe",
+				      "sleep",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "axi_m_sticky";
+			status = "disabled";
+		};
+
+		pcie_phy1: phy at 8e000 {
+			compatible = "qcom,ipq8074-qmp-pcie-phy";
+			reg = <0x8e000 0x1000>;
+			#phy-cells = <0>;
+			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
+			clock-names = "pipe_clk";
+			clock-output-names = "pcie20_phy1_pipe_clk";
+
+			resets = <&gcc GCC_PCIE1_PHY_BCR>,
+				<&gcc GCC_PCIE1PHY_PHY_BCR>;
+			reset-names = "phy",
+				      "common";
+		};
+
+		pcie1: pci at 10000000 {
+			compatible = "qcom,pcie-ipq8074";
+			reg =  <0x10000000 0xf1d
+				0x10000F20 0xa8
+				0x88000 0x2000
+				0x10100000 0x1000>;
+			reg-names = "dbi", "elbi", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie_phy1>;
+			phy-names = "pciephy";
+
+			ranges = <0x81000000 0 0x10200000 0x10200000
+				  0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0x10300000 0x10300000
+				  0 0x00d00000>; /* non-prefetchable memory */
+
+			interrupts = <0 85 0>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 142
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 143
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 144
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 145
+					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
+				 <&gcc GCC_PCIE1_AXI_M_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_CLK>,
+				 <&gcc GCC_PCIE1_AHB_CLK>,
+				 <&gcc GCC_PCIE1_AUX_CLK>;
+			clock-names = "iface",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "aux";
+			resets = <&gcc GCC_PCIE1_PIPE_ARES>,
+				 <&gcc GCC_PCIE1_SLEEP_ARES>,
+				 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE1_AXI_MASTER_ARES>,
+				 <&gcc GCC_PCIE1_AXI_SLAVE_ARES>,
+				 <&gcc GCC_PCIE1_AHB_ARES>,
+				 <&gcc GCC_PCIE1_AXI_MASTER_STICKY_ARES>;
+			reset-names = "pipe",
+				      "sleep",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "axi_m_sticky";
+			status = "disabled";
+		};
 	};
 
 	cpus {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
