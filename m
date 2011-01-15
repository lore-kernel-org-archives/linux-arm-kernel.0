From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 16 Jan 2011 00:13:56 +0100
Subject: [PATCH] arm/ixp4xx: Rename FREQ macro to avoid collisions
In-Reply-To: <m38vylixqw.fsf@intrepid.localdomain> (Krzysztof Halasa's message
	of "Sat, 15 Jan 2011 23:54:31 +0100")
References: <m3lj2mi047.fsf@intrepid.localdomain>
	<20110115170619.GK15996@n2100.arm.linux.org.uk>
	<m38vylixqw.fsf@intrepid.localdomain>
Message-ID: <m3lj2lhia3.fsf_-_@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Author: Ben Hutchings <ben@decadent.org.uk>

arm/ixp4xx: Rename FREQ macro to avoid collisions

FREQ is a ridiculously short name for a platform-specific macro in a
generic header, and it now conflicts with an enumeration in the
gspca/ov519 driver.

Also delete conditional reference to ixp4xx_get_board_tick_rate()
which is not defined anywhere.

--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -432,7 +432,7 @@ static struct clocksource clocksource_ixp4xx = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-unsigned long ixp4xx_timer_freq = FREQ;
+unsigned long ixp4xx_timer_freq = IXP4XX_TIMER_FREQ;
 EXPORT_SYMBOL(ixp4xx_timer_freq);
 static void __init ixp4xx_clocksource_init(void)
 {
@@ -496,7 +496,7 @@ static struct clock_event_device clockevent_ixp4xx = {
 
 static void __init ixp4xx_clockevent_init(void)
 {
-	clockevent_ixp4xx.mult = div_sc(FREQ, NSEC_PER_SEC,
+	clockevent_ixp4xx.mult = div_sc(IXP4XX_TIMER_FREQ, NSEC_PER_SEC,
 					clockevent_ixp4xx.shift);
 	clockevent_ixp4xx.max_delta_ns =
 		clockevent_delta2ns(0xfffffffe, &clockevent_ixp4xx);
--- a/arch/arm/mach-ixp4xx/include/mach/timex.h
+++ b/arch/arm/mach-ixp4xx/include/mach/timex.h
@@ -10,6 +10,7 @@
  * 66.66... MHz. We do a convulted calculation of CLOCK_TICK_RATE b/c the
  * timer register ignores the bottom 2 bits of the LATCH value.
  */
-#define FREQ 66666000
-#define CLOCK_TICK_RATE (((FREQ / HZ & ~IXP4XX_OST_RELOAD_MASK) + 1) * HZ)
+#define IXP4XX_TIMER_FREQ 66666000
+#define CLOCK_TICK_RATE \
+	(((IXP4XX_TIMER_FREQ / HZ & ~IXP4XX_OST_RELOAD_MASK) + 1) * HZ)
 
--- a/drivers/input/misc/ixp4xx-beeper.c
+++ b/drivers/input/misc/ixp4xx-beeper.c
@@ -69,11 +69,7 @@ static int ixp4xx_spkr_event(struct input_dev *dev, unsigned int type, unsigned
 	}
 
 	if (value > 20 && value < 32767)
-#ifndef FREQ
-		count = (ixp4xx_get_board_tick_rate() / (value * 4)) - 1;
-#else
-		count = (FREQ / (value * 4)) - 1;
-#endif
+		count = (IXP4XX_TIMER_FREQ / (value * 4)) - 1;
 
 	ixp4xx_spkr_control(pin, count);
 

-- 
Krzysztof Halasa
