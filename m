From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 04 Dec 2014 11:47:55 +0100
Subject: [PATCH v3 3/3] ARM: dts: exynos5420: Add clock for audss pinctrl
 (fixing GPIO setup failure)
In-Reply-To: <1417690075-13483-1-git-send-email-k.kozlowski@samsung.com>
References: <1417690075-13483-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1417690075-13483-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinctrl for audio subsystem needs 'mau_epll' clock to be enabled in
order to properly access memory during GPIO setup.

After introducing runtime PM to pl330 DMA driver the 'mau_epll' was
gated, because the "amba" clock was disabled and there were no more
users of mau_epll.

This lead to system hang just before probing i2s0 because
samsung_pinmux_setup() tried to access memory from audss block which was
gated.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index ba686e40eac7..c0ca0da36ade 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -696,6 +696,9 @@
 	};
 
 	pinctrl at 03860000 {
+		clocks = <&clock CLK_MAU_EPLL>;
+		clock-names = "block";
+
 		gpz: gpz {
 			gpio-controller;
 			#gpio-cells = <2>;
-- 
1.9.1
