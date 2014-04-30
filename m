From: dianders@chromium.org (Doug Anderson)
Date: Wed, 30 Apr 2014 10:44:10 -0700
Subject: [PATCH v3 7/7] ARM: tegra: Add the EC i2c tunnel to tegra124-venice2
In-Reply-To: <1398879850-9111-1-git-send-email-dianders@chromium.org>
References: <1398879850-9111-1-git-send-email-dianders@chromium.org>
Message-ID: <1398879850-9111-8-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the EC i2c tunnel (and devices under it) to the
tegra124-venice2 device tree.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Tested-by: Andrew Bresticker <abrestic@chromium.org>
Tested-by: Stephen Warren <swarren@nvidia.com>
---
Changes in v3: None
Changes in v2:
- Removed i2c20 alias for i2c tunnel

 arch/arm/boot/dts/tegra124-venice2.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index c17283c..89cf776 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -813,6 +813,32 @@
 
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
