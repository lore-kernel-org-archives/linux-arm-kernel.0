From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 11 Mar 2014 16:54:54 +0900
Subject: [PATCH 5/5] ARM: dts: exynos4412-trats2: Add ADC's dt data to get
 temperature of SoC/battery
In-Reply-To: <1394524494-30641-1-git-send-email-cw00.choi@samsung.com>
References: <1394524494-30641-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1394524494-30641-6-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch use ADC to get the temperature of SoC/battery by using NTC thermistor
driver in hwmon. NTC thermistor driver covnvert ADC's raw data to temperature
by using following variables:

- pullup-uv    : Voltage
- pullup-ohm   : Pull-up resistance
- pulldown-ohm : Pull-down resistance
- io-channels  : It means ADC channel.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 4f851cc..fc517c3 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -106,6 +106,27 @@
 		};
 	};
 
+	adc: adc at 126C0000 {
+		vdd-supply = <&ldo3_reg>;
+		status = "okay";
+
+		ncp15wb473 at 0 {
+			compatible = "ntc,ncp15wb473";
+			pullup-uv = <1800000>;	 /* VCC_1.8V_AP */
+			pullup-ohm = <100000>;	 /* 100K */
+			pulldown-ohm = <100000>; /* 100K */
+			io-channels = <&adc 1>;  /* AP temperature */
+		};
+
+		ncp15wb473 at 1 {
+			compatible = "ntc,ncp15wb473";
+			pullup-uv = <1800000>;	 /* VCC_1.8V_AP */
+			pullup-ohm = <100000>;	 /* 100K */
+			pulldown-ohm = <100000>; /* 100K */
+			io-channels = <&adc 2>;  /* Battery temperature */
+		};
+	};
+
 	i2c at 13890000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-slave-addr = <0x10>;
-- 
1.8.0
