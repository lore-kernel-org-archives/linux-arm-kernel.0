From: dianders@chromium.org (Doug Anderson)
Date: Tue, 29 Jul 2014 16:24:31 -0700
Subject: [PATCH 1/3] ARM: dts: Turn on USB host vbus on rk3288-evb
In-Reply-To: <1406676273-20701-1-git-send-email-dianders@chromium.org>
References: <1406676273-20701-1-git-send-email-dianders@chromium.org>
Message-ID: <1406676273-20701-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no phy driver that works on the Rockchip board for either USB
host port yet.  For now just hardcode the vbus signal to be on all the
time which makes both the dwc2 host and the EHCI port work.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/rk3288-evb.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 749e20d..efd625e 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -35,6 +35,18 @@
 			debounce-interval = <100>;
 		};
 	};
+
+	/* This turns on vbus for both host0 (ehci) and host1 (dwc2) */
+	usb_host_vbus_regulator: usb-host-vbus-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_host_vbus>;
+		regulator-name = "usb-host-vbus";
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &i2c0 {
@@ -71,4 +83,10 @@
 			rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
+
+	usb-host {
+		usb_host_vbus: usb-host-vbus {
+			rockchip,pins = <0 14 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
-- 
2.0.0.526.g5318336
