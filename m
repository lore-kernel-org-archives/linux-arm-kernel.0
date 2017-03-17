From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Fri, 17 Mar 2017 11:32:42 +0800
Subject: [PATCH v2 1/3] arm64: dts: rockchip: add amba node support for RK3368
 SoCs
In-Reply-To: <1489721564-32203-1-git-send-email-jay.xu@rock-chips.com>
References: <1489721564-32203-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1489721564-32203-2-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two dmacs found on RK3368 SoCs, peripher dmac and bus dmac,
and the dmacs are same as previous SoCs' dmac.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
changes since v1:
- none

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index a635adc..c9be1b2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -204,6 +204,37 @@
 				     <&cpu_b2>, <&cpu_b3>;
 	};
 
+	amba {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		dmac_peri: dma-controller at ff250000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x0 0xff250000 0x0 0x4000>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&cru ACLK_DMAC_PERI>;
+			clock-names = "apb_pclk";
+			arm,pl330-broken-no-flushp;
+			peripherals-req-type-burst;
+		};
+
+		dmac_bus: dma-controller at ff600000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x0 0xff600000 0x0 0x4000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&cru ACLK_DMAC_BUS>;
+			clock-names = "apb_pclk";
+			arm,pl330-broken-no-flushp;
+			peripherals-req-type-burst;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
-- 
1.9.1
