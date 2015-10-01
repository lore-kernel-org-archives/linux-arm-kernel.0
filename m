From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 1 Oct 2015 17:56:20 +0200
Subject: [PATCH 2/4] ARM: dts: Add Ethernet node to STiH407 family
In-Reply-To: <1443714982-16251-1-git-send-email-maxime.coquelin@st.com>
References: <1443714982-16251-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1443714982-16251-3-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STiH407 family uses the Synopsys IP.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih407-family.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 582154b..c944d3a 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -653,5 +653,32 @@
 			clocks          = <&clk_sysin>;
 			status		= "okay";
 		};
+
+		ethernet0: dwmac at 9630000 {
+			device_type = "network";
+			status = "disabled";
+			compatible = "st,stih407-dwmac", "snps,dwmac", "snps,dwmac-3.710";
+			reg = <0x9630000 0x8000>, <0x80 0x4>;
+			reg-names = "stmmaceth", "sti-ethconf";
+
+			st,syscon = <&syscfg_sbc_reg 0x80>;
+			st,gmac_en;
+			resets = <&softreset STIH407_ETH1_SOFTRESET>;
+			reset-names = "stmmaceth";
+
+			interrupts = <GIC_SPI 98 IRQ_TYPE_NONE>,
+				     <GIC_SPI 99 IRQ_TYPE_NONE>;
+			interrupt-names = "macirq", "eth_wake_irq";
+
+			/* DMA Bus Mode */
+			snps,pbl = <8>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_rgmii1>;
+
+			clock-names = "stmmaceth", "sti-ethclk";
+			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>,
+				 <&clk_s_c0_flexgen CLK_ETH_PHY>;
+		};
 	};
 };
-- 
1.9.1
