From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 05 May 2016 14:34:26 +0200
Subject: [RFC v2 13/13] ARM: dts: exynos: Fix LAN and HUB after bootloader
 initialization on Odroid U3
In-Reply-To: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462451666-17945-14-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Odroid U3 (Exynos4412-based) board if USB was initialized by
bootloader (in U-Boot "usb start" before tftpboot), the HUB (usb3503)
and LAN (smsc95xx) after after successful probing were not visible in the
system ("lsusb").

In such case the devices had to be fully reset before configuring.
Reset by GPIO (called RESET_N pin) and by RESET field in STCD register
in usb3503 HUB are not sufficient. Instead full reset has to be done by
disabling and enabling regulator.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 2 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts       | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 14e653e32e0f..efa204a85c83 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -67,7 +67,7 @@
 		};
 	};
 
-	emmc_pwrseq: pwrseq {
+	emmc_pwrseq: pwrseq1 {
 		pinctrl-0 = <&sd1_cd>;
 		pinctrl-names = "default";
 		compatible = "mmc-pwrseq-emmc";
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 31cdc036fda4..3da0e6b3c32a 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -41,6 +41,11 @@
 		cooling-levels = <0 102 170 230>;
 	};
 
+	lan_pwrseq: pwrseq2 {
+		compatible = "mmc-pwrseq-simple";
+		ext-supply = <&buck8_reg>;
+	};
+
 	thermal-zones {
 		cpu_thermal: cpu-thermal {
 			cooling-maps {
@@ -104,6 +109,7 @@
 &ehci {
 	port at 1 {
 		status = "okay";
+		usb-pwrseq = <&lan_pwrseq>;
 	};
 	port at 2 {
 		status = "okay";
-- 
1.9.1
