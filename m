From: christophe.roullier@st.com (Christophe Roullier)
Date: Wed, 2 May 2018 16:18:40 +0200
Subject: [PATCH V2 5/8] ARM: dts: stm32: Add ethernet dwmac on stm32mp1
In-Reply-To: <1525270723-18241-1-git-send-email-christophe.roullier@st.com>
References: <1525270723-18241-1-git-send-email-christophe.roullier@st.com>
Message-ID: <1525270723-18241-6-git-send-email-christophe.roullier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Ethernet support (Synopsys MAC IP 4.20a) on stm32mp1 SOC.
Enable feature supported by the stmmac driver, such as TSO.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 86421ba..79def3b 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -179,5 +179,35 @@
 			clocks = <&rcc USART1_K>;
 			status = "disabled";
 		};
+
+		stmmac_axi_config_0: stmmac-axi-config {
+			snps,wr_osr_lmt = <0x7>;
+			snps,rd_osr_lmt = <0x7>;
+			snps,blen = <0 0 0 0 16 8 4>;
+		};
+
+		ethernet0: ethernet at 5800a000 {
+			compatible = "st,stm32mp1-dwmac", "snps,dwmac-4.20a";
+			reg = <0x5800a000 0x2000>;
+			reg-names = "stmmaceth";
+			interrupts-extended = <&intc GIC_SPI 61 IRQ_TYPE_NONE>;
+			interrupt-names = "macirq";
+			clock-names = "stmmaceth",
+				      "mac-clk-tx",
+				      "mac-clk-rx",
+				      "ethstp",
+				      "syscfg-clk";
+			clocks = <&rcc ETHMAC>,
+				 <&rcc ETHTX>,
+				 <&rcc ETHRX>,
+				 <&rcc ETHSTP>,
+				 <&rcc SYSCFG>;
+			st,syscon = <&syscfg 0x4>;
+			snps,mixed-burst;
+			snps,pbl = <2>;
+			snps,axi-config = <&stmmac_axi_config_0>;
+			snps,tso;
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1
