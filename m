From: slash.tmp@free.fr (Mason)
Date: Thu, 02 Apr 2015 11:31:29 +0200
Subject: __timer_udelay(1) may return immediately
Message-ID: <551D0C71.8050707@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

I'm using timer-based delays from arch/arm/lib/delay.c

Consider the following configuration:
HZ=100
timer->freq = 1000000

Thus
UDELAY_MULT = 107374
ticks_per_jiffy = 10000

Thus __timer_udelay(1) =>
__timer_const_udelay(107374) =>
__timer_delay(0) => calls get_cycles() twice then returns prematurely

The issue comes from a tiny rounding error as
107374 * ticks_per_jiffy >> UDELAY_SHIFT = 0,9999983
which is rounded down to 0.

The root of the issue is that mathematically,
UDELAY_MULT = 2199023 * HZ / 2048 = 107374,169921875
which is rounded down to 107374.

It seems to me that a simple solution would be to round
UDELAY_MULT up instead of down.

Thus UDELAY_MULT = 107375
107375 * ticks_per_jiffy >> UDELAY_SHIFT = 1,0000076

We might end up sleeping one cycle more than necessary, but I don't
think spinning a bit longer would be a problem?

Patch provided for illustration purposes.

What do you think?

Regards.


diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
index dff714d..873a43e 100644
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -10,7 +10,7 @@
  #include <asm/param.h> /* HZ */
  
  #define MAX_UDELAY_MS  2
-#define UDELAY_MULT    ((UL(2199023) * HZ) >> 11)
+#define UDELAY_MULT    (((UL(2199023) * HZ) >> 11) + 1)
  #define UDELAY_SHIFT   30
  
  #ifndef __ASSEMBLY__


-- 
(Note to self: tangentially relevant discussion)
http://thread.gmane.org/gmane.linux.kernel/1858260
