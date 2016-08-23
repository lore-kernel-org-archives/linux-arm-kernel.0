From: woogyom.kim@gmail.com (Milo Kim)
Date: Tue, 23 Aug 2016 18:13:37 +0900
Subject: [PATCH 2/4] ARM: dts: exynos: Use 'hpd-gpios' instead of 'hpd-gpio'
In-Reply-To: <1471943619-6102-1-git-send-email-woogyom.kim@gmail.com>
References: <1471943619-6102-1-git-send-email-woogyom.kim@gmail.com>
Message-ID: <1471943619-6102-3-git-send-email-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables getting a HPD GPIO descriptor quickly.
The exynos-hdmi driver uses "hpd" for HDMI hot plug detection.

	static int hdmi_resources_init(struct hdmi_context *hdata)
	{
		...
		hdata->hpd_gpio = devm_gpiod_get(dev, "hpd", GPIOD_IN);
		...
	}

This calls 'of_find_gpio()' and it generates the GPIO consumer ID by referring
GPIO suffix. So 'hpd-gpios' is preferred on getting a GPIO descriptor.

However, if the device tree uses 'hpd-gpio', then the exynos-hdmi driver
always retries to get a GPIO descriptor because the first GPIO suffix is not
'gpio' but 'gpios'. So you always see the debug message below.

	of_get_named_gpiod_flags: can't parse 'hpd-gpios' property of node '/soc/hdmi at 14530000[0]'

Use the preferred property, 'hpd-gpios' instead of 'hpd-gpio'.

Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: dri-devel at lists.freedesktop.org
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt | 4 ++--
 arch/arm/boot/dts/exynos4210-universal_c210.dts                  | 2 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi                  | 2 +-
 arch/arm/boot/dts/exynos5250-arndale.dts                         | 2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts                        | 2 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi                    | 2 +-
 arch/arm/boot/dts/exynos5250-spring.dts                          | 2 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts                       | 2 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts                        | 2 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi               | 2 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts                        | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt b/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
index a2ec4c1..6394ea9 100644
--- a/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
+++ b/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
@@ -9,7 +9,7 @@ Required properties:
 - reg: physical base address of the hdmi and length of memory mapped
 	region.
 - interrupts: interrupt number to the cpu.
-- hpd-gpio: following information about the hotplug gpio pin.
+- hpd-gpios: following information about the hotplug gpio pin.
 	a) phandle of the gpio controller node.
 	b) pin number within the gpio controller.
 	c) optional flags and pull up/down.
@@ -56,7 +56,7 @@ Example:
 		compatible = "samsung,exynos4212-hdmi";
 		reg = <0x14530000 0x100000>;
 		interrupts = <0 95 0>;
-		hpd-gpio = <&gpx3 7 1>;
+		hpd-gpios = <&gpx3 7 1>;
 		ddc = <&hdmi_ddc_node>;
 		phy = <&hdmi_phy_node>;
 		samsung,syscon-phandle = <&pmu_system_controller>;
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 9a75e3e..cf95202 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -269,7 +269,7 @@
 };
 
 &hdmi {
-	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
+	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_hpd>;
 	hdmi-en-supply = <&hdmi_en>;
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 58ad48e7..be644fe 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -227,7 +227,7 @@
 };
 
 &hdmi {
-	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
+	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_hpd>;
 	vdd-supply = <&ldo8_reg>;
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index ea70603..3d981f3 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -152,7 +152,7 @@
 };
 
 &hdmi {
-	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_LOW>;
+	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_LOW>;
 	vdd_osc-supply = <&ldo10_reg>;
 	vdd_pll-supply = <&ldo8_reg>;
 	vdd-supply = <&ldo8_reg>;
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 381af13..7f27263 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -116,7 +116,7 @@
 };
 
 &hdmi {
-	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
+	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 };
 
 &i2c_0 {
diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index fadbea7..1055d25 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -260,7 +260,7 @@
 };
 
 &hdmi {
-	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
+	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_hpd_irq>;
 	phy = <&hdmiphy>;
diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index 44f4292..1d52a79 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -91,7 +91,7 @@
 };
 
 &hdmi {
-	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
+	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_hpd_irq>;
 	phy = <&hdmiphy>;
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index fe4e091..f6f256f 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -179,7 +179,7 @@
 
 &hdmi {
 	status = "okay";
-	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
+	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_hpd_irq>;
 	ddc = <&i2c_2>;
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index ed8f342..2954646 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -130,7 +130,7 @@
 
 &hdmi {
 	status = "okay";
-	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
+	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_hpd_irq>;
 };
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index d562530..47c113c 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -250,7 +250,7 @@
 
 &hdmi {
 	status = "okay";
-	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
+	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_hpd_irq>;
 
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 5ec71e2..51a8bca 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -179,7 +179,7 @@
 
 &hdmi {
 	status = "okay";
-	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
+	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_hpd_irq>;
 	ddc = <&i2c_2>;
-- 
1.9.1
