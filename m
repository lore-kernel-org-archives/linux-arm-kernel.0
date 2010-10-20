From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 20 Oct 2010 06:51:51 +0200
Subject: [PATCH 4/5] ARM: unify the definition of CLOCK_TICK_RATE across all
	ARM platforms
Message-ID: <20101020045151.GA12979@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch breaks the asm/timex.h -> mach/timex.h include
dependency by defining CLOCK_TICK_RATE as a platform-independent
constant in asm/timex.h.

The only valid use of CLOCK_TICK_RATE outside of arch/ is in
include/linux/jiffies.h, where it is used to calculate the roundoff
error that results from dividing CLOCK_TICK_RATE by HZ, and that
roundoff error is then used to try and correct for the resulting
timer tick drift.

For example, if the timer tick interrupt generating timer's tick rate
is 32768 Hz, but HZ = 100, then we won't be able to interrupt exactly
100 times per second because 100 does not divide 32768 nicely, so
jiffies.h will then calculate that instead of every 327.68 timer
periods, we'll likely generate a timer interrupt every 328 (= LATCH)
timer periods, and that our timer tick will therefore end up closer
to 99.90 Hz than to 100 Hz, and then keep that in mind when updating
the time-of-day clock.

However, there are two issues with this:

- While a kHz timer may not be able to precisely generate your desired
  timer tick rate, many ARM SoCs in the tree have timers that tick at
  rates in the MHz range, and such timers do not suffer from this issue.

  E.g. when trying to do HZ = 99 on a 100 MHz clock, we'll generate a
  timer interrupt every 1010101 timer ticks, and the "real" HZ value
  will be 99.0000009900000099..., which is so close so 99 Hz that we
  won't be able to tell the difference, especially considering the
  limits of accuracy of the oscillator that the timer base clock is
  derived from.

- On ARM platforms that _do_ have low resolution timers (such as AT91,
  or OMAP when the 32768 Hz timer is used, or SH-Mobile systems that
  use the 32768 Hz RCLK), the Kconfig text for the per-platform HZ
  options (OMAP_32K_TIMER_HZ, AT91_TIMER_HZ, SHMOBILE_TIMER_HZ)
  explicitly says to make HZ a divisor of 32768 or risk timer drift.
  So whatever correction include/linux/jiffies.h is trying to do here
  is apparently not working very well.

Considering the above, stuffing any random value into CLOCK_TICK_RATE
should be fine, so we'll randomly use 100 * HZ, which divides HZ nicely,
to dissuade jiffies.h from applying any drift correction.

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/include/asm/timex.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/timex.h b/arch/arm/include/asm/timex.h
index 3be8de3..4e9f8aa 100644
--- a/arch/arm/include/asm/timex.h
+++ b/arch/arm/include/asm/timex.h
@@ -12,7 +12,7 @@
 #ifndef _ASMARM_TIMEX_H
 #define _ASMARM_TIMEX_H
 
-#include <mach/timex.h>
+#define CLOCK_TICK_RATE		(100 * HZ)
 
 typedef unsigned long cycles_t;
 
-- 
1.7.2.3
