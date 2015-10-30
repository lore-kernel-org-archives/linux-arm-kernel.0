From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Oct 2015 15:21:02 +0100
Subject: [PATCH 16/19] ARM: sun5i: dt: Add DRAM gates
In-Reply-To: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1446214865-3972-17-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DRAM gates control whether the image / display devices on the SoC have
access to the DRAM clock or not.

Enable it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi |  5 +++--
 arch/arm/boot/dts/sun5i-a13.dtsi  |  2 +-
 arch/arm/boot/dts/sun5i-r8.dtsi   |  2 +-
 arch/arm/boot/dts/sun5i.dtsi      | 19 +++++++++++++++++++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 0981a9e2db3b..c996b5d1851a 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -67,7 +67,7 @@
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
 			clocks = <&ahb_gates 36>, <&ahb_gates 43>,
 				 <&ahb_gates 44>, <&de_be_clk>,
-				 <&tcon_ch1_clk>;
+				 <&tcon_ch1_clk>, <&dram_gates 26>;
 			status = "disabled";
 		};
 
@@ -76,7 +76,8 @@
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
 			clocks = <&ahb_gates 36>, <&ahb_gates 44>,
-				 <&de_be_clk>, <&tcon_ch0_clk>;
+				 <&de_be_clk>, <&tcon_ch0_clk>,
+				 <&dram_gates 26>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 130644d7e054..17b36b942d38 100644
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
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 861c5a621e70..426db76c0fe6 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -338,6 +338,25 @@
 			clock-output-names = "usb_ohci0", "usb_phy";
 		};
 
+		dram_gates: clk at 01c20100 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun5i-a13-dram-gates-clk";
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
-- 
2.6.2
