From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 13 Oct 2009 19:58:00 -0400
Subject: [PATCH] ep93xx: add errata info about pwm outputs
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB8080@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EP93xx User's guide has an error about the number of pwm
channels available in the various chips.  Add comments about
this in the driver since the guide will probably never get
updated.

  EP9301/02 only have pwm.1, pin PMWOUT is not on the chip
  EP9307 only has pwm.0, pin PWMOUT1 (EGPIO14) is not on the chip
  EP9312/15 have both pwm0 and pwm.1

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index f95dc16..f30be28 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -648,6 +648,7 @@ static struct platform_device ep93xx_pwm1_device = {
 
 void __init ep93xx_register_pwm(int pwm0, int pwm1)
 {
+	/* NOTE: EP9301/02 do not have PWMOUT */
 	if (pwm0)
 		platform_device_register(&ep93xx_pwm0_device);
 
diff --git a/drivers/misc/ep93xx_pwm.c b/drivers/misc/ep93xx_pwm.c
index ba46941..de9f405 100644
--- a/drivers/misc/ep93xx_pwm.c
+++ b/drivers/misc/ep93xx_pwm.c
@@ -9,12 +9,18 @@
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
  *
- *  EP9307 has only one channel:
- *    - PWMOUT
+ * The EP93xx User's Guide has an error about the number of pwm channels
+ * available in the various chips.
  *
- *  EP9301/02/12/15 have two channels:
- *    - PWMOUT
- *    - PWMOUT1 (alternate function for EGPIO14)
+ * EP9301 and EP9302 only have one pwm output:
+ *	pwm.1 - PWMOUT1 (alternate function for EGPIO14)
+ *
+ * EP9307 also only has one pwm output:
+ *	pwm.0 - PWMOUT
+ *
+ * EP9312 and EP9315 have two pwm outputs:
+ *	pwm.0 - PWMOUT
+ *	pwm.1 - PWMOUT1 (alternate function for EGPIO14)
  */
 
 #include <linux/module.h> 
