From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 02 Apr 2015 16:36:16 +0200
Subject: [PATCH 2/2] ARM: dts: Fix pinctrl settings for S2MPS11 RTC alarm IRQ
 on Arndale Octa
In-Reply-To: <1427985376-20420-1-git-send-email-k.kozlowski@samsung.com>
References: <1427985376-20420-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1427985376-20420-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Arndale Octa the S2MPS11 RTC alarm interrupt was not handled at all
because of wrong configuration of interrupt and gpx3-2.
1. Interrupt is signaled by falling edge.
2. This GPIO line is hard-wired on the board to PVDD_APIO_1V8 through a
   resistor so pull-up/down must be disabled.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index d78fcd997ce6..97346df31d41 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -87,7 +87,9 @@
 			s2mps11,buck4-ramp-enable = <1>;
 
 			interrupt-parent = <&gpx3>;
-			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&s2mps11_irq>;
 
 			s2mps11_osc: clocks {
 				#clock-cells = <1>;
@@ -379,3 +381,12 @@
 	clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
 	clock-names = "rtc", "rtc_src";
 };
+
+&pinctrl_0 {
+	s2mps11_irq: s2mps11-irq {
+		samsung,pins = "gpx3-2";
+		samsung,pin-function = <0xf>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+};
-- 
1.9.1
