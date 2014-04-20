From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Sun, 20 Apr 2014 16:54:04 +0530
Subject: [PATCH 7/7] ARM: dts: enable hdmi for exynos5420 based peach-pit board
In-Reply-To: <1397993044-14564-1-git-send-email-rahul.sharma@samsung.com>
References: <1397993044-14564-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1397993044-14564-8-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Enable hdmi for exynos5420 based peach-pit board.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts |   26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5420.dtsi          |    5 +++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 4d61a5e..5b70522 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -54,6 +54,13 @@
 			samsung,pin-pud = <0>;
 			samsung,pin-drv = <0>;
 		};
+
+		hdmi_hpd_irq: hdmi-hpd-irq {
+		        samsung,pins = "gpx3-7";
+			samsung,pin-function = <0>;
+			samsung,pin-pud = <1>;
+			samsung,pin-drv = <0>;
+		};
 	};
 
 	pinctrl at 14010000 {
@@ -222,4 +229,23 @@
 	watchdog at 101D0000 {
 		timeout-sec = <32>;
 	};
+
+	i2c at 12C80000 {
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <66000>;
+		samsung,i2c-slave-addr = <0x50>;
+		status = "okay";
+
+		hdmiddc at 50 {
+			reg = <0x50>;
+		};
+	};
+
+	hdmi at 14530000 {
+		hpd-gpio = <&gpx3 7 2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_hpd_irq>;
+		ddc = <&i2c_2>;
+		status = "okay";
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 663fca9..f474e96 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -642,10 +642,15 @@
 		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel",
 			"sclk_hdmiphy", "mout_hdmi";
 		status = "disabled";
+		phy = <&hdmiphy>;
 		phys = <&simple_phys 0>;
 		phy-names = "hdmiphy";
 	};
 
+	hdmiphy: hdmiphy at 145D0000 {
+		reg = <0x145D0000 0x20>;
+	};
+
 	mixer at 14450000 {
 		compatible = "samsung,exynos5420-mixer";
 		reg = <0x14450000 0x10000>;
-- 
1.7.9.5
