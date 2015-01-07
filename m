From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 07 Jan 2015 10:50:32 +0100
Subject: [PATCH] ARM: dts: exynos4412-trats2: Add Maxim 77693 fuel gauge node
Message-ID: <1420624232-31238-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for fuel gauge present in Maxim 77693 PMIC. This allows control
over battery charging state on Trats2 board.

The fuel gauge is compatible with max17042 battery driver (Maxim
17042/17047/17050).  Although datasheet rev 2.2 for MAX77693 describes
fuel gauge as Maxim 17042-like, the chip on Trats2 board identifies
itself as Maxim 17047-like.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 496a05faca37..7b3e58d781d8 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -15,6 +15,7 @@
 /dts-v1/;
 #include "exynos4412.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Samsung Trats 2 based on Exynos4412";
@@ -24,6 +25,7 @@
 		i2c9 = &i2c_ak8975;
 		i2c10 = &i2c_cm36651;
 		i2c11 = &i2c_max77693;
+		i2c12 = &i2c_max77693_fuel;
 	};
 
 	memory {
@@ -562,6 +564,22 @@
 		};
 	};
 
+	i2c_max77693_fuel: i2c-gpio-3 {
+		compatible = "i2c-gpio";
+		gpios = <&gpf1 5 GPIO_ACTIVE_HIGH>, <&gpf1 4 GPIO_ACTIVE_HIGH>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		max77693-fuel-gauge at 36 {
+			compatible = "maxim,max17047";
+			interrupt-parent = <&gpx2>;
+			interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+			reg = <0x36>;
+		};
+	};
+
 	mmc at 12550000 {
 		num-slots = <1>;
 		broken-cd;
-- 
1.9.1
