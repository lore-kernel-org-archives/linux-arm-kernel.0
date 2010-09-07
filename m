From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 07 Sep 2010 14:44:47 +1200
Subject: [PATCH] pio: add arch specific gpio_is_valid() function
In-Reply-To: <280328.53116.qm@web180311.mail.gq1.yahoo.com>
References: <280328.53116.qm@web180311.mail.gq1.yahoo.com>
Message-ID: <4C85A71F.3010402@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2010 02:23 PM, David Brownell wrote:
> Still not liking or accepting this proposed
> change to the GPIO framework.
>
> For the AT91 case (where integers 0..N are
> IRQs, but N..max are GPIOs)
>
> A simpler solution is just to use a bit in
> the integer to indicate IRQ vs GPIO.  Like
> maybe the sign bit.. which is never set on
> valid GPIO numbers, but platforms could let
> be set on IRQs.
>   
How about this approach instead?

----
On some architectures gpio numbering does not start from zero. Allow for
correct behaviour of gpio_is_valid on values below the first gpio by
adding the architecture overrideable ARCH_FIRST_GPIO.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
----

diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index c7376bf..01aab1f 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -22,10 +22,15 @@
 #define ARCH_NR_GPIOS		256
 #endif
 
+#ifndef ARCH_FIRST_GPIO
+#define ARCH_FIRST_GPIO		0
+#endif
+
 static inline int gpio_is_valid(int number)
 {
 	/* only some non-negative numbers are valid */
-	return ((unsigned)number) < ARCH_NR_GPIOS;
+	return (number >= ARCH_FIRST_GPIO &&
+		(unsigned)number < ARCH_NR_GPIOS;
 }
 
 struct device;
