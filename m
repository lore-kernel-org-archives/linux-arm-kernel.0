From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 14 Aug 2014 23:01:25 +0200
Subject: [PATCH v2 3/4] ARM: dts: rockchip: add rk3288 dma controllers
In-Reply-To: <3132019.Q6dzkQ3ylK@diego>
References: <3132019.Q6dzkQ3ylK@diego>
Message-ID: <13040520.xInaTtH0pm@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add both the bus and peripheral pl330 dma controllers present in rk3288 socs.
The first dma controller can change between secure and non-secure mode. Both
instances are added but the non-secure variant is left disabled by default,
as on the majority of boards the bootloader leaves it in secure mode.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 5950b0a..add0e11 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -62,6 +62,44 @@
 		};
 	};
 
+	amba {
+		compatible = "arm,amba-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		dmac_peri: dma-controller at ff250000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0xff250000 0x4000>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&cru ACLK_DMAC2>;
+			clock-names = "apb_pclk";
+		};
+
+		dmac_bus_ns: dma-controller at ff600000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0xff600000 0x4000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&cru ACLK_DMAC1>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		dmac_bus_s: dma-controller at ffb20000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0xffb20000 0x4000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&cru ACLK_DMAC1>;
+			clock-names = "apb_pclk";
+		};
+	};
+
 	xin24m: oscillator {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
-- 
1.9.0
