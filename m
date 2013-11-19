From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 19 Nov 2013 13:13:06 -0500
Subject: [PATCH 2/4] keystone: dts: add/modify clock nodes
In-Reply-To: <1384884788-29137-1-git-send-email-m-karicheri2@ti.com>
References: <1384884788-29137-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1384884788-29137-2-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

K2 SoC has separate ref clock inputs for various clocks. This patch
adds following changes:-
 - Add separate ref clock nodes for ARM, DDR3A, DDR3B and PA PLL input
   clocks
 - While at it, rename  refclkmain to refclksys based on device User
   Guide naming convention

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/keystone-clocks.dtsi |   48 ++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-clocks.dtsi b/arch/arm/boot/dts/keystone-clocks.dtsi
index d6713b1..3f1cf28 100644
--- a/arch/arm/boot/dts/keystone-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-clocks.dtsi
@@ -13,17 +13,45 @@ clocks {
 	#size-cells = <1>;
 	ranges;
 
-	refclkmain: refclkmain {
+	refclksys: refclksys {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <122880000>;
-		clock-output-names = "refclk-main";
+		clock-output-names = "refclk-sys";
+	};
+
+	refclkpass: refclkpass {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <122880000>;
+		clock-output-names = "refclk-pass";
+	};
+
+	refclkarm: refclkarm {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "refclk-arm";
+	};
+
+	refclkddr3a: refclkddr3a {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <100000000>;
+		clock-output-names = "refclk-ddr3a";
+	};
+
+	refclkddr3b: refclkddr3b {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <100000000>;
+		clock-output-names = "refclk-ddr3b";
 	};
 
 	mainpllclk: mainpllclk at 2310110 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,main-pll-clock";
-		clocks = <&refclkmain>;
+		clocks = <&refclksys>;
 		reg = <0x02620350 4>, <0x02310110 4>;
 		reg-names = "control", "multiplier";
 		fixed-postdiv = <2>;
@@ -32,47 +60,43 @@ clocks {
 	papllclk: papllclk at 2620358 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkmain>;
+		clocks = <&refclkpass>;
 		clock-output-names = "pa-pll-clk";
 		reg = <0x02620358 4>;
 		reg-names = "control";
-		fixed-postdiv = <6>;
 	};
 
 	ddr3allclk: ddr3apllclk at 2620360 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkmain>;
+		clocks = <&refclkddr3a>;
 		clock-output-names = "ddr-3a-pll-clk";
 		reg = <0x02620360 4>;
 		reg-names = "control";
-		fixed-postdiv = <6>;
 	};
 
 	ddr3bllclk: ddr3bpllclk at 2620368 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkmain>;
+		clocks = <&refclkddr3b>;
 		clock-output-names = "ddr-3b-pll-clk";
 		reg = <0x02620368 4>;
 		reg-names = "control";
-		fixed-postdiv = <6>;
 	};
 
 	armpllclk: armpllclk at 2620370 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkmain>;
+		clocks = <&refclkarm>;
 		clock-output-names = "arm-pll-clk";
 		reg = <0x02620370 4>;
 		reg-names = "control";
-		fixed-postdiv = <6>;
 	};
 
 	mainmuxclk: mainmuxclk at 2310108 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,pll-mux-clock";
-		clocks = <&mainpllclk>, <&refclkmain>;
+		clocks = <&mainpllclk>, <&refclksys>;
 		reg = <0x02310108 4>;
 		bit-shift = <23>;
 		bit-mask = <1>;
-- 
1.7.9.5
