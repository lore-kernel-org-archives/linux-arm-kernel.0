From: briannorris@chromium.org (Brian Norris)
Date: Fri, 13 May 2016 13:50:18 -0700
Subject: [PATCH] ARM64: dts: rockchip: assign default rates for core rk3399
 clocks
Message-ID: <1463172618-96001-1-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xing Zheng <zhengxing@rock-chips.com>

These clocks are all core clocks used by many blocks/peripherals, many
of whose drivers don't set their clock rates at all. Let's assign
reasonable default clock rates for these core clocks, so that these
peripherals get something reasonable by default, and also so that if
child devices want to select a clock rate themselves, their muxes have
some reasonable parent clock rates to branch off of (rather than just
the boot-time defaults).

This helps the eMMC PHY, for one, to get a reasonable ACLK rate.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 46f325a143b0..6fa9cc332482 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -478,6 +478,22 @@
 		reg = <0x0 0xff760000 0x0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+		assigned-clocks =
+			<&cru PLL_GPLL>, <&cru PLL_CPLL>,
+			<&cru PLL_NPLL>,
+			<&cru ACLK_PERIHP>, <&cru HCLK_PERIHP>,
+			<&cru PCLK_PERIHP>,
+			<&cru ACLK_PERILP0>, <&cru HCLK_PERILP0>,
+			<&cru PCLK_PERILP0>,
+			<&cru HCLK_PERILP1>, <&cru PCLK_PERILP1>;
+		assigned-clock-rates =
+			 <594000000>,  <800000000>,
+			<1000000000>,
+			 <150000000>,   <75000000>,
+			  <37500000>,
+			 <100000000>,  <100000000>,
+			  <50000000>,
+			 <100000000>,   <50000000>;
 	};
 
 	grf: syscon at ff770000 {
-- 
2.8.0.rc3.226.g39d4020
