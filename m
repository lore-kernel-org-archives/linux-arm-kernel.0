From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 23 Oct 2015 09:54:56 +0800
Subject: [PATCH v3 3/3] ARM: dts: rockchip: Add the OTP gpio pinctrl
In-Reply-To: <1445565296-31517-1-git-send-email-wxt@rock-chips.com>
References: <1445565296-31517-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1445565296-31517-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the "init" anf "sleep" pinctrl as the OTP gpio state.
We need the OTP pin is gpio state before resetting the TSADC controller,
since the tshut polarity will generate a high signal.

"init" pinctrl property is defined by Doug's Patch[0].

Patch[0]:
https://patchwork.kernel.org/patch/7454311/

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
  - Add the "sleep" pinctrl as the gpio state in PATCH[3/3]

Changes in v2:
  - Add some commits for more obvious in PATCH[2/2]

Changes in v1:
  - As the Doug comments, drop the thermal driver patchs since
    we can with pinctrl changing to work.
  - As the Doug's patch to add the 'init' property.

 arch/arm/boot/dts/rk3288.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 906e938..13ff09a 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -447,8 +447,10 @@
 		clock-names = "tsadc", "apb_pclk";
 		resets = <&cru SRST_TSADC>;
 		reset-names = "tsadc-apb";
-		pinctrl-names = "default";
-		pinctrl-0 = <&otp_out>;
+		pinctrl-names = "init", "default", "sleep";
+		pinctrl-0 = <&otp_gpio>;
+		pinctrl-1 = <&otp_out>;
+		pinctrl-2 = <&otp_gpio>;
 		#thermal-sensor-cells = <1>;
 		rockchip,hw-tshut-temp = <95000>;
 		status = "disabled";
@@ -1273,6 +1275,10 @@
 		};
 
 		tsadc {
+			otp_gpio: otp-gpio {
+				rockchip,pins = <0 10 RK_FUNC_GPIO &pcfg_pull_none>;
+			};
+
 			otp_out: otp-out {
 				rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_none>;
 			};
-- 
1.9.1
