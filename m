From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 15 May 2014 20:34:23 +0530
Subject: [PATCH v5 3/4] ARM: dts: enable hdmi for exynos5420 based peach-pit
 board
In-Reply-To: <1400166264-3428-1-git-send-email-rahul.sharma@samsung.com>
References: <1400166264-3428-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1400166264-3428-4-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Enable hdmi for exynos5420 based peach-pit board.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos5420.dtsi          |    5 +++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index fae33dd..84f1a35 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -74,6 +74,13 @@
 		samsung,pin-pud = <0>;
 		samsung,pin-drv = <0>;
 	};
+
+	hdmi_hpd_irq: hdmi-hpd-irq {
+		samsung,pins = "gpx3-7";
+		samsung,pin-function = <0>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <0>;
+	};
 };
 
 &rtc {
@@ -137,6 +144,21 @@
 	};
 };
 
+&i2c_2	{
+	status = "okay";
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-max-bus-freq = <66000>;
+	samsung,i2c-slave-addr = <0x50>;
+};
+
+&hdmi {
+	status = "okay";
+	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_hpd_irq>;
+	ddc = <&i2c_2>;
+};
+
 /*
  * Use longest HW watchdog in SoC (32 seconds) since the hardware
  * watchdog provides no debugging information (compared to soft/hard
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 016992c..df4422c 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -648,9 +648,14 @@
 			 <&clock CLK_MOUT_HDMI>;
 		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel",
 			"sclk_hdmiphy", "mout_hdmi";
+		phy = <&hdmiphy>;
 		status = "disabled";
 	};
 
+	hdmiphy: hdmiphy at 145D0000 {
+		reg = <0x145D0000 0x20>;
+	};
+
 	mixer: mixer at 14450000 {
 		compatible = "samsung,exynos5420-mixer";
 		reg = <0x14450000 0x10000>;
-- 
1.7.9.5
