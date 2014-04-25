From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:42:31 +0100
Subject: [PATCH 130/222] leds: leds-pwm: add DT support for LEDs wired to
 supply
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeWV-0007Lw-HK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The non-DT driver allowed an active low property to be specified, but DT
is missing this in its description.  Add the property to the DT binding
document, making it optional.  It defaults to active high, which retains
compatibility with existing descriptions.

This should only be used for causes where the LED is wired to supply,
and the PWM does not sensibly support its own inversion.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 Documentation/devicetree/bindings/leds/leds-pwm.txt | 2 ++
 drivers/leds/leds-pwm.c                             | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-pwm.txt b/Documentation/devicetree/bindings/leds/leds-pwm.txt
index 7297107cf832..6c6583c35f2f 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm.txt
+++ b/Documentation/devicetree/bindings/leds/leds-pwm.txt
@@ -13,6 +13,8 @@ node's name represents the name of the corresponding LED.
   For the pwms and pwm-names property please refer to:
   Documentation/devicetree/bindings/pwm/pwm.txt
 - max-brightness : Maximum brightness possible for the LED
+- active-low : (optional) For PWMs where the LED is wired to supply
+  rather than ground.
 - label :  (optional)
   see Documentation/devicetree/bindings/leds/common.txt
 - linux,default-trigger :  (optional)
diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 8bd225df14de..f5cf1b0f2748 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -154,6 +154,7 @@ static int led_pwm_create_of(struct device *dev, struct led_pwm_priv *priv)
 
 		led.default_trigger = of_get_property(child,
 						"linux,default-trigger", NULL);
+		led.active_low = of_property_read_bool(child, "active-low");
 		of_property_read_u32(child, "max-brightness",
 				     &led.max_brightness);
 
-- 
1.8.3.1
