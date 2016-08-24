From: woogyom.kim@gmail.com (Milo Kim)
Date: Wed, 24 Aug 2016 11:25:21 +0900
Subject: [PATCH v2 1/4] ARM: dts: exynos: Enable HDMI for Arndale Octa board
In-Reply-To: <1472005524-3489-1-git-send-email-woogyom.kim@gmail.com>
References: <1472005524-3489-1-git-send-email-woogyom.kim@gmail.com>
Message-ID: <1472005524-3489-2-git-send-email-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Support HDMI display data channel
  I2C #2 is assigned for the HDMI DDC. It enables the EDID access.

* GPIO for HDMI hot plug detect
  GPX3_7 is used. The HPD awareness is done when the GPIO is active high and
  single ended.

* Enable HDMI block in Exynos5420
  HDMI PLL consumes 1.0V LDO6 (PVDD_ANAIP_1V0) and HDMI oscillator requires
  1.8V LDO7 (PVDD_ANAIP_1V8).

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: dri-devel at lists.freedesktop.org
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 39a3b81..df362a2 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -70,6 +70,23 @@
 	status = "disabled";
 };
 
+&i2c_2 {
+	samsung,i2c-slave-addr = <0x50>;
+	status = "okay";
+
+	hdmiddc at 50 {
+		compatible = "samsung,exynos4210-hdmiddc";
+		reg = <0x50>;
+	};
+};
+
+&hdmi {
+	hpd-gpios = <&gpx3 7 GPIO_OPEN_SOURCE>;
+	vdd_osc-supply = <&ldo7_reg>;
+	vdd_pll-supply = <&ldo6_reg>;
+	status = "okay";
+};
+
 &hsi2c_4 {
 	status = "okay";
 
-- 
1.9.1
