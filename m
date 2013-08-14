From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Aug 2013 10:58:34 +0100
Subject: [PATCH] ARM: dts: Enable USB hub on Arndale
Message-ID: <1376474314-32491-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

The Arndale has a SMSC USB3503 connected in hardware only mode like a PHY,
support it using the usb-nop-xceiv binding.

Note that due to a regrettable decision to use a regulator to represent
the reset signal this uses a fixed voltage regulator to do that, there
is a plan to use the reset controller binding once that is merged so it
does not seem worthwhile to fix the usb-nop-xceiv driver at this point.

Signed-off-by: Mark Brown <broonie@linaro.org>
---

This doesn't 100% work right now since we don't yet have a solution to
ensure that this gets started after the USB controller but those
modifications are small (or can be done at runtime with module loading).

 arch/arm/boot/dts/exynos5250-arndale.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 96d528d..e477e23 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -539,4 +539,22 @@
 	rtc {
 		status = "okay";
 	};
+
+	usb_hub_bus {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		// SMSC USB3503 connected in hardware only mode as a PHY
+		usb_hub: usb_hub {
+			compatible = "smsc,usb3503a";
+
+			reset-gpios = <&gpx3 5 1>;
+			connect-gpios = <&gpd1 7 1>;
+		};
+	};
+
+	usb at 12110000 {
+		usb-phy = <&usb2_phy>;
+	};
 };
-- 
1.8.4.rc2
