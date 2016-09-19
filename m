From: eric@anholt.net (Eric Anholt)
Date: Mon, 19 Sep 2016 17:13:14 +0100
Subject: [PATCH 3/3] arm64: Add the Raspberry Pi firmware's interface to the
 FXL6408.
In-Reply-To: <20160919161314.25858-1-eric@anholt.net>
References: <20160919161314.25858-1-eric@anholt.net>
Message-ID: <20160919161314.25858-3-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gets us hotplug detection of HDMI, so that graphics now works at
boot.  Tested with watching the output of xrandr while plugging and
unplugging the HDMI cable.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
index 7841b724e340..2460b47737e9 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
@@ -23,8 +23,25 @@
 			linux,default-trigger = "default-on";
 		};
 	};
+
+	soc {
+		fxl6408: firmware-gpio-128 {
+			compatible = "raspberrypi,firmware-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			firmware = <&firmware>;
+			ngpios = <8>;
+			gpio-line-names = "BT_ON", "WL_ON", "", "LAN_RUN", "HPD_N", "CAM_GPIO0", "CAM_GPIO1", "PWR_LOW_N";
+
+			raspberrypi,firmware-gpio-offset = <128>;
+		};
+	};
 };
 
 &uart1 {
 	status = "okay";
 };
+
+&hdmi {
+	hpd-gpios = <&fxl6408 4 GPIO_ACTIVE_HIGH>;
+};
-- 
2.9.3
