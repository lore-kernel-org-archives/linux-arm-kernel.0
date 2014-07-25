From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jul 2014 15:23:44 +0200
Subject: [PATCH 2/6] leds: add device tree bindings for syscon LEDs
In-Reply-To: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
References: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1406294628-16079-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device tree bindings used by syscon-based LEDs.

Cc: devicetree at vger.kernel.org
Cc: Bryan Wu <cooloney@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/leds/leds-syscon.txt       | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-syscon.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-syscon.txt b/Documentation/devicetree/bindings/leds/leds-syscon.txt
new file mode 100644
index 000000000000..460b9c3d1bd3
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-syscon.txt
@@ -0,0 +1,83 @@
+Device Tree Bindings for Syscon LEDs
+
+Required properties:
+- compatible : must be "syscon-leds".
+- regmap : a phandle to a syscon node containing a regmap
+
+Each LED is represented as a sub-node of the syscon-leds device. Each
+node's name represents the name of the corresponding LED.
+
+LED sub-node properties:
+- offset : register offset to the register controlling this LED
+- mask : bit mask for the bit controlling this LED in the register
+  typically 0x01, 0x02, 0x04 ...
+- label : (optional)
+  see Documentation/devicetree/bindings/leds/common.txt
+- linux,default-trigger : (optional)
+  see Documentation/devicetree/bindings/leds/common.txt
+- default-state: (optional) The initial state of the LED. Valid
+  values are "on", "off", and "keep". If the LED is already on or off
+  and the default-state property is set the to same value, then no
+  glitch should be produced where the LED momentarily turns off (or
+  on). The "keep" setting will keep the LED at whatever its current
+  state is, without producing a glitch.  The default is off if this
+  property is not present.
+
+Example:
+
+leds: leds at 08 {
+	compatible = "syscon-leds";
+	regmap = <&syscon>;
+
+	led at bit0 {
+		offset = <0x08>;
+		mask = <0x01>;
+		label = "versatile:0";
+		linux,default-trigger = "heartbeat";
+		default-state = "on";
+	};
+	led at bit1 {
+		offset = <0x08>;
+		mask = <0x02>;
+		label = "versatile:1";
+		linux,default-trigger = "mmc0";
+		default-state = "off";
+	};
+	led at bit2 {
+		offset = <0x08>;
+		mask = <0x04>;
+		label = "versatile:2";
+		linux,default-trigger = "cpu0";
+		default-state = "off";
+	};
+	led at bit3 {
+		offset = <0x08>;
+		mask = <0x08>;
+		label = "versatile:3";
+		default-state = "off";
+	};
+	led at bit4 {
+		offset = <0x08>;
+		mask = <0x10>;
+		label = "versatile:4";
+		default-state = "off";
+	};
+	led at bit5 {
+		offset = <0x08>;
+		mask = <0x20>;
+		label = "versatile:5";
+		default-state = "off";
+	};
+	led at bit6 {
+		offset = <0x08>;
+		mask = <0x40>;
+		label = "versatile:6";
+		default-state = "off";
+	};
+	led at bit7 {
+		offset = <0x08>;
+		mask = <0x80>;
+		label = "versatile:7";
+		default-state = "off";
+	};
+};
-- 
1.9.3
