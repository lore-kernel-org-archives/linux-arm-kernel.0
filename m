From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 09 Feb 2015 14:57:23 +0100
Subject: [PATCH v2] ARM: dts: exynos5420: Add maudio power domain
Message-ID: <1423490243-7675-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maudio power domain to Exynos 5420 DTSI file so its state could be
tracked. This actually won't power down this domain because the pl330
dmaengine driver (for adma channel) uses IRQ safe runtime PM. Thus the
patch should not introduce any functional change except of visibility of
this domain to the system.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

---

Changes sinve v1:
1. Use generic power domain bindings (suggested by Javier).
2. Add Javier's reviewed-by.
---
 arch/arm/boot/dts/exynos5420.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 9dc2e9773b30..28c4a2f4b991 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -288,6 +288,12 @@
 			      "pclk1", "clk1", "pclk2", "clk2";
 	};
 
+	mau_pd: power-domain at 100440E0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x100440E0 0x20>;
+		#power-domain-cells = <0>;
+	};
+
 	pinctrl_0: pinctrl at 13400000 {
 		compatible = "samsung,exynos5420-pinctrl";
 		reg = <0x13400000 0x1000>;
@@ -346,6 +352,7 @@
 			#dma-cells = <1>;
 			#dma-channels = <6>;
 			#dma-requests = <16>;
+			power-domains = <&mau_pd>;
 		};
 
 		pdma0: pdma at 121A0000 {
@@ -415,6 +422,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
 		status = "disabled";
+		power-domains = <&mau_pd>;
 	};
 
 	i2s1: i2s at 12D60000 {
-- 
1.9.1
