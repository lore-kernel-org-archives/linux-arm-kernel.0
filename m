From: woogyom.kim@gmail.com (Milo Kim)
Date: Wed, 31 Aug 2016 15:08:47 +0900
Subject: [PATCH v4] ARM: dts: exynos: Enable HDMI for Arndale Octa board
Message-ID: <20160831060847.1350-1-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* GPIO for HDMI hot plug detect
  GPX3_7 is used. The HPD awareness is done when the GPIO is active high.

* Enable HDMI block in Exynos5420
  HDMI VDD and PLL consume 1.0V LDO6 (PVDD_ANAIP_1V0) and HDMI oscillator
  requires 1.8V LDO7 (PVDD_ANAIP_1V8).

* Support HDMI display data channel
  I2C #2 is assigned for the HDMI DDC. It enables the EDID access.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 39a3b81..d2ad48e 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -70,6 +70,15 @@
 	status = "disabled";
 };
 
+&hdmi {
+	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
+	vdd_osc-supply = <&ldo7_reg>;
+	vdd_pll-supply = <&ldo6_reg>;
+	vdd-supply = <&ldo6_reg>;
+	ddc = <&i2c_2>;
+	status = "okay";
+};
+
 &hsi2c_4 {
 	status = "okay";
 
@@ -347,6 +356,10 @@
 	};
 };
 
+&i2c_2 {
+	status = "okay";
+};
+
 &mmc_0 {
 	status = "okay";
 	broken-cd;
-- 
2.9.3
