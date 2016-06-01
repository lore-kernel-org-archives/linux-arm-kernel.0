From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 01 Jun 2016 10:02:21 +0200
Subject: [PATCH v3 12/12] ARM: dts: exynos: Fix LAN and HUB after bootloader
 initialization on Odroid U3
In-Reply-To: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1464768141-25420-13-git-send-email-k.kozlowski@samsung.com>
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
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 31cdc036fda4..23e30e4609df 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -99,11 +99,15 @@
 	clock-names = "refclk";
 	clocks = <&pmu_system_controller 0>;
 	refclk-frequency = <24000000>;
+
+	power-sequence;
+	ext-supply = <&buck8_reg>;
 };
 
 &ehci {
 	port at 1 {
 		status = "okay";
+		usb-pwrseq = <&usb3503>;
 	};
 	port at 2 {
 		status = "okay";
-- 
1.9.1
