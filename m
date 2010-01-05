From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 5 Jan 2010 15:08:41 -0700
Subject: [PATCH] ep93xx: register the pwm devices on the edb93xx dev boards
Message-ID: <201001051508.41896.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ep93xx: register the pwm devices on the edb93xx dev boards

Add the platform init code to register the pwm devices that exist
on the various edb93xx development boards.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index a4a7be3..cee7e91 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -118,12 +118,33 @@ static void __init edb93xx_register_i2c(void)
 	}
 }
 
+
+/*************************************************************************
+ * EDB93xx pwm
+ *************************************************************************/
+static void __init edb93xx_register_pwm(void)
+{
+	if (machine_is_edb9301() ||
+	    machine_is_edb9302() || machine_is_edb9302a()) {
+		/* EP9301 and EP9302 only have pwm.1 (EGPIO14) */
+		ep93xx_register_pwm(0, 1);
+	} if (machine_is_edb9307() || machine_is_edb9307a()) {
+		/* EP9307 only has pwm.0 (PWMOUT) */
+		ep93xx_register_pwm(1, 0);
+	} else {
+		/* EP9312 and EP9315 have both */
+		ep93xx_register_pwm(1, 1);
+	}
+}
+
+
 static void __init edb93xx_init_machine(void)
 {
 	ep93xx_init_devices();
 	edb93xx_register_flash();
 	ep93xx_register_eth(&edb93xx_eth_data, 1);
 	edb93xx_register_i2c();
+	edb93xx_register_pwm();
 }
 
 
