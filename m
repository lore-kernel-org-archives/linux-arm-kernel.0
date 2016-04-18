From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Mon, 18 Apr 2016 17:19:43 -0400
Subject: [PATCH 1/3] ARM: dts: imx6q-b850v3: Remove ldb panel
Message-ID: <1461014385-26027-1-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove ldb panel entry for the following reasons:
- The b850v3 has an onboard LVDS to DisplayPort converter (STDP4028). So
we should not limit the monitors that can be connected by hardcoding the
auo,b133htn01 1080p panel.
- The default resolution on the LVDS interface needs to be WXGA or less.
Otherwise when a 1080p monitor is connected to the HDMI port there is no
output on both the LVDS and HDMI ports since a single IPU on i.MX6 can
not handle two 1080p displays. With the panel entry removed from the
devicetree, drm driver defaults the resolution on LVDS interface to XGA.

Once in userspace, applications can set the desired resolution on LVDS
interface over IPU2 CRTC.

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 arch/arm/boot/dts/imx6q-b850v3.dts | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
index 984d000..dc4b06f 100644
--- a/arch/arm/boot/dts/imx6q-b850v3.dts
+++ b/arch/arm/boot/dts/imx6q-b850v3.dts
@@ -51,18 +51,6 @@
 	chosen {
 		stdout-path = &uart3;
 	};
-
-	panel-lvds0 {
-		compatible = "auo,b133htn01";
-		backlight = <&backlight_lvds>;
-		ddc-i2c-bus = <&mux2_i2c2>;
-
-		port {
-			panel_in_lvds0: endpoint {
-				remote-endpoint = <&lvds0_out>;
-			};
-		};
-	};
 };
 
 &ldb {
@@ -77,14 +65,6 @@
 		fsl,data-mapping = "spwg";
 		fsl,data-width = <24>;
 		status = "okay";
-
-		port at 4 {
-			reg = <4>;
-
-			lvds0_out: endpoint {
-				remote-endpoint = <&panel_in_lvds0>;
-			};
-		};
 	};
 };
 
-- 
2.8.1
