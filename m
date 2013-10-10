From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Oct 2013 15:52:13 +0200
Subject: [PATCH] ARM: integrator: get the CM control register by proxy
Message-ID: <1381413133-16096-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CM_CTRL register was accessed directly from the LED driver,
which does not work now that we get the base for the register
from the device tree. Add an accessor function to do this and
make the LED driver compile again.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/core.c            | 8 ++++++++
 arch/arm/mach-integrator/include/mach/cm.h | 3 ++-
 arch/arm/mach-integrator/leds.c            | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 4cdfd73..c07c821 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -94,6 +94,14 @@ int __init integrator_init(bool is_cp)
 static DEFINE_RAW_SPINLOCK(cm_lock);
 
 /**
+ * cm_get - get the value from the CM_CTRL register
+ */
+u32 cm_get(void)
+{
+	return readl(cm_base + INTEGRATOR_HDR_CTRL_OFFSET);
+}
+
+/**
  * cm_control - update the CM_CTRL register.
  * @mask: bits to change
  * @set: bits to set
diff --git a/arch/arm/mach-integrator/include/mach/cm.h b/arch/arm/mach-integrator/include/mach/cm.h
index 202e6a5..ae6085f 100644
--- a/arch/arm/mach-integrator/include/mach/cm.h
+++ b/arch/arm/mach-integrator/include/mach/cm.h
@@ -1,6 +1,7 @@
 /*
- * update the core module control register.
+ * access the core module control register.
  */
+u32 cm_get(void);
 void cm_control(u32, u32);
 
 #define CM_CTRL	__io_address(INTEGRATOR_HDR_CTRL)
diff --git a/arch/arm/mach-integrator/leds.c b/arch/arm/mach-integrator/leds.c
index 7a7f6d3..ed82535 100644
--- a/arch/arm/mach-integrator/leds.c
+++ b/arch/arm/mach-integrator/leds.c
@@ -78,7 +78,7 @@ static void cm_led_set(struct led_classdev *cdev,
 
 static enum led_brightness cm_led_get(struct led_classdev *cdev)
 {
-	u32 reg = readl(CM_CTRL);
+	u32 reg = cm_get();
 
 	return (reg & CM_CTRL_LED) ? LED_FULL : LED_OFF;
 }
-- 
1.8.3.1
