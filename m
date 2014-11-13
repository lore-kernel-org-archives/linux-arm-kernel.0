From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Nov 2014 10:32:54 +0100
Subject: [PATCH 2/4] ARM: integrator: move debug LEDs to syscon LED driver
In-Reply-To: <1415871176-11368-1-git-send-email-linus.walleij@linaro.org>
References: <1415871176-11368-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1415871176-11368-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Integrator debug block is a simple set of registers, make
it a syscon and register the four LEDs on the Integrator/AP
baseboard as syscon LEDs.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integrator.dtsi | 36 +++++++++++++++++++++++++++++
 arch/arm/mach-integrator/leds.c   | 48 ++-------------------------------------
 2 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/arch/arm/boot/dts/integrator.dtsi b/arch/arm/boot/dts/integrator.dtsi
index 5546630c4fd2..5d27087d5248 100644
--- a/arch/arm/boot/dts/integrator.dtsi
+++ b/arch/arm/boot/dts/integrator.dtsi
@@ -82,5 +82,41 @@
 			reg = <0x19000000 0x1000>;
 			interrupts = <4>;
 		};
+
+		syscon {
+			/* Debug registers mapped as syscon */
+			compatible = "syscon";
+			reg = <0x1a000000 0x10>;
+
+			led at 04.0 {
+				compatible = "register-bit-led";
+				offset = <0x04>;
+				mask = <0x01>;
+				label = "integrator:green0";
+				linux,default-trigger = "heartbeat";
+				default-state = "on";
+			};
+			led at 04.1 {
+				compatible = "register-bit-led";
+				offset = <0x04>;
+				mask = <0x02>;
+				label = "integrator:yellow";
+				default-state = "off";
+			};
+			led at 04.2 {
+				compatible = "register-bit-led";
+				offset = <0x04>;
+				mask = <0x04>;
+				label = "integrator:red";
+				default-state = "off";
+			};
+			led at 04.3 {
+				compatible = "register-bit-led";
+				offset = <0x04>;
+				mask = <0x08>;
+				label = "integrator:green1";
+				default-state = "off";
+			};
+		};
 	};
 };
diff --git a/arch/arm/mach-integrator/leds.c b/arch/arm/mach-integrator/leds.c
index f1dcb57a59e2..56f243744b98 100644
--- a/arch/arm/mach-integrator/leds.c
+++ b/arch/arm/mach-integrator/leds.c
@@ -16,12 +16,8 @@
 
 #if defined(CONFIG_NEW_LEDS) && defined(CONFIG_LEDS_CLASS)
 
-#define ALPHA_REG __io_address(INTEGRATOR_DBG_BASE)
-#define LEDREG	(__io_address(INTEGRATOR_DBG_BASE) + INTEGRATOR_DBG_LEDS_OFFSET)
-
 struct integrator_led {
 	struct led_classdev	cdev;
-	u8			mask;
 };
 
 /*
@@ -32,40 +28,9 @@ static const struct {
 	const char *name;
 	const char *trigger;
 } integrator_leds[] = {
-	{ "integrator:green0", "heartbeat", },
-	{ "integrator:yellow", },
-	{ "integrator:red", },
-	{ "integrator:green1", },
 	{ "integrator:core_module", "cpu0", },
 };
 
-static void integrator_led_set(struct led_classdev *cdev,
-			      enum led_brightness b)
-{
-	struct integrator_led *led = container_of(cdev,
-						 struct integrator_led, cdev);
-	u32 reg = __raw_readl(LEDREG);
-
-	if (b != LED_OFF)
-		reg |= led->mask;
-	else
-		reg &= ~led->mask;
-
-	while (__raw_readl(ALPHA_REG) & 1)
-		cpu_relax();
-
-	__raw_writel(reg, LEDREG);
-}
-
-static enum led_brightness integrator_led_get(struct led_classdev *cdev)
-{
-	struct integrator_led *led = container_of(cdev,
-						 struct integrator_led, cdev);
-	u32 reg = __raw_readl(LEDREG);
-
-	return (reg & led->mask) ? LED_FULL : LED_OFF;
-}
-
 static void cm_led_set(struct led_classdev *cdev,
 			      enum led_brightness b)
 {
@@ -93,19 +58,10 @@ static int __init integrator_leds_init(void)
 		if (!led)
 			break;
 
-
 		led->cdev.name = integrator_leds[i].name;
-
-		if (i == 4) { /* Setting for LED in core module */
-			led->cdev.brightness_set = cm_led_set;
-			led->cdev.brightness_get = cm_led_get;
-		} else {
-			led->cdev.brightness_set = integrator_led_set;
-			led->cdev.brightness_get = integrator_led_get;
-		}
-
+		led->cdev.brightness_set = cm_led_set;
+		led->cdev.brightness_get = cm_led_get;
 		led->cdev.default_trigger = integrator_leds[i].trigger;
-		led->mask = BIT(i);
 
 		if (led_classdev_register(NULL, &led->cdev) < 0) {
 			kfree(led);
-- 
1.9.3
