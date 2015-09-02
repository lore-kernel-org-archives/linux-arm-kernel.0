From: dianders@chromium.org (Douglas Anderson)
Date: Wed,  2 Sep 2015 14:54:22 -0700
Subject: [PATCH] ARM: dts: Add the hdmi-ddc pinctrl settings for rk3288
Message-ID: <1441230862-17376-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pins for i2c5 can either be configured as "I2C5" which means that
they're controlled by the normal RK3288 I2C controller or as "EDP / HDMI
I2C".  It's unclear why EDP is referenced here since apparently setting
the mux to this position enables I2C communication using the dw_hdmi
block with a patch like <https://patchwork.kernel.org/patch/7098101/>.

There appear to be some reasons why using the builtin I2C controller in
dw_hdmi is better than using the normal RK3288 I2C controller, so boards
based on rk3288 might eventually want to use this pinmux if it's known
to work.

Once driver support in dw_hdmi lands, boards would use this by selecting
this pinctrl for the HDMI block and then _not_ specifying a ddc-i2c-bus
and _not_ setting the status to "okay" for i2c5 (which uses the same
pins).

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/rk3288.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 906e938..055b488 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -923,6 +923,13 @@
 			#interrupt-cells = <2>;
 		};
 
+		hdmi {
+			hdmi_ddc: hdmi-ddc {
+				rockchip,pins = <7 19 RK_FUNC_2 &pcfg_pull_none>,
+						<7 20 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
 		pcfg_pull_up: pcfg-pull-up {
 			bias-pull-up;
 		};
-- 
2.5.0.457.gab17608
