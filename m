From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 2 Apr 2010 11:59:05 -0500
Subject: [PATCH] ep93xx: gpio.c: local functions should be static
In-Reply-To: <0D753D10438DA54287A00B027084269763682CDD93@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B027084269763682CDD93@AUSP01VMBX24.collaborationhost.net>
Message-ID: <0D753D10438DA54287A00B0270842697636A7E997B@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ryan,

Any comments on this?

Regards,
Hartley

-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of H Hartley Sweeten
Sent: Tuesday, March 09, 2010 1:58 PM
To: ARM Kernel
Cc: ryan at bluewatersys.com
Subject: [PATCH] ep93xx: gpio.c: local functions should be static

The functions ep93xx_gpio_update_int_params and ep93xx_gpio_int_mask
are not exported and should be static.  This was overlooked when
moving the code from core.c.

Also, change the comment to better indicate what this code is for.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/gpio.c b/arch/arm/mach-ep93xx/gpio.c
index cc377ae..cf547ad 100644
--- a/arch/arm/mach-ep93xx/gpio.c
+++ b/arch/arm/mach-ep93xx/gpio.c
@@ -25,7 +25,7 @@
 #include <mach/hardware.h>
 
 /*************************************************************************
- * GPIO handling for EP93xx
+ * Interrupt handling for EP93xx on-chip GPIOs
  *************************************************************************/
 static unsigned char gpio_int_unmasked[3];
 static unsigned char gpio_int_enabled[3];
@@ -40,7 +40,7 @@ static const u8 eoi_register_offset[3]		= { 0x98, 0xb4, 0x54 };
 static const u8 int_en_register_offset[3]	= { 0x9c, 0xb8, 0x58 };
 static const u8 int_debounce_register_offset[3]	= { 0xa8, 0xc4, 0x64 };
 
-void ep93xx_gpio_update_int_params(unsigned port)
+static void ep93xx_gpio_update_int_params(unsigned port)
 {
 	BUG_ON(port > 2);
 
@@ -56,7 +56,7 @@ void ep93xx_gpio_update_int_params(unsigned port)
 		EP93XX_GPIO_REG(int_en_register_offset[port]));
 }
 
-void ep93xx_gpio_int_mask(unsigned line)
+static inline void ep93xx_gpio_int_mask(unsigned line)
 {
 	gpio_int_unmasked[line >> 3] &= ~(1 << (line & 7));
 }
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
