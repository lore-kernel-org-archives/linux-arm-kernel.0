From: dianders@chromium.org (Doug Anderson)
Date: Thu, 17 Apr 2014 10:59:30 -0700
Subject: [PATCH 7/7] ARM: tegra: Add the EC i2c tunnel to tegra124-venice2
In-Reply-To: <1397757570-19750-1-git-send-email-dianders@chromium.org>
References: <1397757570-19750-1-git-send-email-dianders@chromium.org>
Message-ID: <1397757570-19750-8-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the EC i2c tunnel (and devices under it) to the
tegra124-venice2 device tree.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/tegra124-venice2.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index c17283c..df97d15 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -8,6 +8,7 @@
 	compatible = "nvidia,venice2", "nvidia,tegra124";
 
 	aliases {
+		i2c20 = "/spi at 0,7000d400/cros-ec at 0/i2c-tunnel";
 		rtc0 = "/i2c at 0,7000d000/pmic at 40";
 		rtc1 = "/rtc at 0,7000e000";
 	};
@@ -813,6 +814,32 @@
 
 			google,cros-ec-spi-msg-delay = <2000>;
 
+			i2c-tunnel {
+				compatible = "google,cros-ec-i2c-tunnel";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				google,remote-bus = <0>;
+
+				charger: bq24735 at 9 {
+					compatible = "ti,bq24735";
+					reg = <0x9>;
+					interrupt-parent = <&gpio>;
+					interrupts = <TEGRA_GPIO(J, 0)
+							GPIO_ACTIVE_HIGH>;
+					ti,ac-detect-gpios = <&gpio
+							TEGRA_GPIO(J, 0)
+							GPIO_ACTIVE_HIGH>;
+				};
+
+				battery: sbs-battery at b {
+					compatible = "sbs,sbs-battery";
+					reg = <0xb>;
+					sbs,i2c-retry-count = <2>;
+					sbs,poll-retry-count = <1>;
+				};
+			};
+
 			cros-ec-keyb {
 				compatible = "google,cros-ec-keyb";
 				keypad,num-rows = <8>;
-- 
1.9.1.423.g4596e3a
