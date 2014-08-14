From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 14 Aug 2014 23:01:50 +0200
Subject: [PATCH v2 4/4] ARM: dts: rockchip: add rk3066 and rk3188 dma
 controllers
In-Reply-To: <3132019.Q6dzkQ3ylK@diego>
References: <3132019.Q6dzkQ3ylK@diego>
Message-ID: <3850151.02fuKfV6F5@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add both the cpu and peripheral pl330 dma controllers present in rk3188 socs.
The first dma controller can change between secure and non-secure mode. Both
instances are added but the non-secure variant is left disabled by default,
as on the majority of boards the bootloader leaves it in secure mode.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 8caf85d..b5bd3a6 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -28,6 +28,44 @@
 		i2c4 = &i2c4;
 	};
 
+	amba {
+		compatible = "arm,amba-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		dmac1_s: dma-controller at 20018000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x20018000 0x4000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&cru ACLK_DMA1>;
+			clock-names = "apb_pclk";
+		};
+
+		dmac1_ns: dma-controller at 2001c000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x2001c000 0x4000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&cru ACLK_DMA1>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		dmac2: dma-controller at 20078000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x20078000 0x4000>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&cru ACLK_DMA2>;
+			clock-names = "apb_pclk";
+		};
+	};
+
 	xin24m: oscillator {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
-- 
1.9.0
