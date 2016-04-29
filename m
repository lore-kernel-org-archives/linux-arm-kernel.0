From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 29 Apr 2016 12:59:50 +0200
Subject: [RFT PATCH 2/3] ARM: dts: exynos: Provide regulator for usb3503 on
 Odroid to fix device detection
In-Reply-To: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
References: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1461927591-7864-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Odroid U3 (Exynos4412-based) board if USB was initialized by
bootloader (in U-Boot "usb start" before tftpboot), the HUB after
successful probing was not visible in the system ("lsusb"). Connected
devices were not visible neither.

The USB3503 takes optional regulator so provide one - buck8 on Odroid
U3.

Additionally switch the control of buck8 to GPIO mode. It is faster than
I2C/register mode and it is the easiest way to disable it (regulator
state is a logical OR state of GPIO and register value).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index d73aa6c58fe3..5308a955ede4 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -74,6 +74,7 @@
 	regulator-name = "BUCK8_P3V3";
 	regulator-min-microvolt = <3300000>;
 	regulator-max-microvolt = <3300000>;
+	maxim,ena-gpios = <&gpa1 1 GPIO_ACTIVE_HIGH>;
 };
 
 /* VDDQ for MSHC (eMMC card) */
@@ -98,6 +99,7 @@
 	clock-names = "refclk";
 	clocks = <&pmu_system_controller 0>;
 	refclk-frequency = <24000000>;
+	vdd33-supply = <&buck8_reg>;
 };
 
 &ehci {
-- 
1.9.1
