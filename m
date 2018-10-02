From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed,  3 Oct 2018 07:59:51 +0900
Subject: [PATCH 2/2] arm64: dts: uniphier: add SD controller nodes
In-Reply-To: <1538521191-16333-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538521191-16333-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1538521191-16333-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SD controller nodes for LD20 and PXs3.
LD20 does not support the UHS mode, while PXs3 supports it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi    | 14 ++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |  4 ++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi    | 18 ++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 6932cef..ee92605 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -528,6 +528,20 @@
 			cdns,phy-dll-delay-sdclk-hsmmc = <21>;
 		};
 
+		sd: sdhc at 5a400000 {
+			compatible = "socionext,uniphier-sd-v3.1.1";
+			status = "disabled";
+			reg = <0x5a400000 0x800>;
+			interrupts = <0 76 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_sd>;
+			clocks = <&sd_clk 0>;
+			reset-names = "host";
+			resets = <&sd_rst 0>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+		};
+
 		soc_glue: soc-glue at 5f800000 {
 			compatible = "socionext,uniphier-ld20-soc-glue",
 				     "simple-mfd", "syscon";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index c1bb607..1ad149c 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -75,6 +75,10 @@
 	status = "okay";
 };
 
+&sd {
+	status = "okay";
+};
+
 &eth0 {
 	status = "okay";
 	phy-handle = <&ethphy0>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index fd2bcd4..f3f19f5 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -341,6 +341,24 @@
 			cdns,phy-dll-delay-sdclk-hsmmc = <21>;
 		};
 
+		sd: sdhc at 5a400000 {
+			compatible = "socionext,uniphier-sd-v3.1.1";
+			status = "disabled";
+			reg = <0x5a400000 0x800>;
+			interrupts = <0 76 4>;
+			pinctrl-names = "default", "uhs";
+			pinctrl-0 = <&pinctrl_sd>;
+			pinctrl-1 = <&pinctrl_sd_uhs>;
+			clocks = <&sd_clk 0>;
+			reset-names = "host";
+			resets = <&sd_rst 0>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+		};
+
 		soc_glue: soc-glue at 5f800000 {
 			compatible = "socionext,uniphier-pxs3-soc-glue",
 				     "simple-mfd", "syscon";
-- 
2.7.4
