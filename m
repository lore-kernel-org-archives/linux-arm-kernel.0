From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Thu, 05 Apr 2012 13:44:07 +0200
Subject: [PATCH] arm: ep93xx: Don't try to release not acquired GPIO lines
Message-ID: <4F7D8587.5020205@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fail path of ep93xx_keypad_acquire_gpio() tries to release
GPIO lines not acquired successfully before. Fix this.

Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>

---
Patch applies to v3.4rc1.

 arch/arm/mach-ep93xx/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/arm/mach-ep93xx/core.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-ep93xx/core.c
+++ linux-2.6/arch/arm/mach-ep93xx/core.c
@@ -734,7 +734,7 @@ int ep93xx_keypad_acquire_gpio(struct pl
 fail_gpio_d:
 	gpio_free(EP93XX_GPIO_LINE_C(i));
 fail_gpio_c:
-	for ( ; i >= 0; --i) {
+	for (--i; i >= 0; --i) {
 		gpio_free(EP93XX_GPIO_LINE_C(i));
 		gpio_free(EP93XX_GPIO_LINE_D(i));
 	}
