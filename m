From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 05 Oct 2016 23:56:11 +0100
Subject: [PATCH] ARM: fix delays
Message-ID: <E1brv6h-0003j7-7J@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 215e362dafed ("ARM: 8306/1: loop_udelay: remove bogomips value
limitation") tried to increase the bogomips limitation, but in doing
so messed up udelay such that it always gives about a 5% error in the
delay, even if we use a timer.

The calculation is:

	loops = UDELAY_MULT * us_delay * ticks_per_jiffy >> UDELAY_SHIFT

Originally, UDELAY_MULT was ((UL(2199023) * HZ) >> 11) and UDELAY_SHIFT
30.  Assuming HZ=100, us_delay of 1000 and ticks_per_jiffy of 1660000
(eg, 166MHz timer, 1ms delay) this would calculate:

	((UL(2199023) * HZ) >> 11) * 1000 * 1660000 >> 30
		=> 165999

With the new values of 2047 * HZ + 483648 * HZ / 1000000 and 31, we get:

	(2047 * HZ + 483648 * HZ / 1000000) * 1000 * 1660000 >> 31
		=> 158269

which is incorrect.  This is due to a typo - correcting it gives:

	(2147 * HZ + 483648 * HZ / 1000000) * 1000 * 1660000 >> 31
		=> 165999

i.o.w, the original value.

Fixes: 215e362dafed ("ARM: 8306/1: loop_udelay: remove bogomips value limitation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/delay.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
index b7a428154355..b1ce037e4380 100644
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -10,7 +10,7 @@
 #include <asm/param.h>	/* HZ */
 
 #define MAX_UDELAY_MS	2
-#define UDELAY_MULT	UL(2047 * HZ + 483648 * HZ / 1000000)
+#define UDELAY_MULT	UL(2147 * HZ + 483648 * HZ / 1000000)
 #define UDELAY_SHIFT	31
 
 #ifndef __ASSEMBLY__
-- 
2.1.0
