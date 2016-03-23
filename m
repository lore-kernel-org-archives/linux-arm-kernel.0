From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Mar 2016 17:38:31 +0100
Subject: [PATCH v3 08/19] ARM: sun5i: Add DRAM gates
In-Reply-To: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1458751122-23976-9-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DRAM gates control whether the image / display devices on the SoC have
access to the DRAM clock or not.

Enable it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13.dtsi | 22 +++++++++++++++++++++-
 arch/arm/boot/dts/sun5i-r8.dtsi  |  2 +-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 9669b03f20f3..d3d2b19c97f1 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -62,7 +62,7 @@
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
 			clocks = <&ahb_gates 36>, <&ahb_gates 44>, <&de_be_clk>,
-				 <&tcon_ch0_clk>;
+				 <&tcon_ch0_clk>, <&dram_gates 26>;
 			status = "disabled";
 		};
 	};
@@ -151,6 +151,26 @@
 					     "apb1_uart3";
 		};
 
+		dram_gates: clk at 01c20100 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun5i-a13-dram-gates-clk",
+				     "allwinner,sun4i-a10-gates-clk";
+			reg = <0x01c20100 0x4>;
+			clocks = <&pll5 0>;
+			clock-indices = <0>,
+					<1>,
+					<25>,
+					<26>,
+					<29>,
+					<31>;
+			clock-output-names = "dram_ve",
+					     "dram_csi",
+					     "dram_de_fe",
+					     "dram_de_be",
+					     "dram_ace",
+					     "dram_iep";
+		};
+
 		de_be_clk: clk at 01c20104 {
 			#clock-cells = <0>;
 			#reset-cells = <0>;
diff --git a/arch/arm/boot/dts/sun5i-r8.dtsi b/arch/arm/boot/dts/sun5i-r8.dtsi
index b1e4e0170d51..691d3de75b35 100644
--- a/arch/arm/boot/dts/sun5i-r8.dtsi
+++ b/arch/arm/boot/dts/sun5i-r8.dtsi
@@ -53,7 +53,7 @@
 			allwinner,pipeline = "de_be0-lcd0-tve0";
 			clocks = <&ahb_gates 34>, <&ahb_gates 36>,
 				 <&ahb_gates 44>, <&de_be_clk>,
-				 <&tcon_ch1_clk>;
+				 <&tcon_ch1_clk>, <&dram_gates 26>;
 			status = "disabled";
 		};
 	};
-- 
2.7.3
