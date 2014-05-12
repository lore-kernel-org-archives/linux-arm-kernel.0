From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Mon, 12 May 2014 15:54:06 +0530
Subject: [PATCH v3 3/5] ARM: dts: enable hdmi for exynos5420 based peach-pit
 board
In-Reply-To: <1399890248-27409-1-git-send-email-rahul.sharma@samsung.com>
References: <1399890248-27409-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1399890248-27409-4-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Enable hdmi for exynos5420 based peach-pit board.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts |   19 +++++++++++++++++++
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi  |    7 +++++++
 arch/arm/boot/dts/exynos5420.dtsi          |    5 +++++
 3 files changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index fae33dd..8248255 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -137,6 +137,25 @@
 	};
 };
 
+&i2c_2	{
+	status = "okay";
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-max-bus-freq = <66000>;
+	samsung,i2c-slave-addr = <0x50>;
+
+	hdmiddc at 50 {
+		reg = <0x50>;
+	};
+};
+
+&hdmi {
+	status = "okay";
+	hpd-gpio = <&gpx3 7 2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_hpd_irq>;
+	ddc = <&i2c_2>;
+};
+
 /*
  * Use longest HW watchdog in SoC (32 seconds) since the hardware
  * watchdog provides no debugging information (compared to soft/hard
diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index ba686e4..fc17797 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -66,6 +66,13 @@
 			samsung,pin-pud = <0>;
 			samsung,pin-drv = <0>;
 		};
+
+		hdmi_hpd_irq: hdmi-hpd-irq {
+			samsung,pins = "gpx3-7";
+			samsung,pin-function = <0>;
+			samsung,pin-pud = <1>;
+			samsung,pin-drv = <0>;
+		};
 	};
 
 	pinctrl at 13410000 {
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
