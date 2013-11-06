From: luis.henriques@canonical.com (Luis Henriques)
Date: Wed,  6 Nov 2013 10:40:26 +0000
Subject: [3.5.y.z extended stable] Patch "clockevents: Sanitize ticks to nsec
 conversion" has been added to staging queue
Message-ID: <1383734426-15289-1-git-send-email-luis.henriques@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a note to let you know that I have just added a patch titled

    clockevents: Sanitize ticks to nsec conversion

to the linux-3.5.y-queue branch of the 3.5.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.5.y-queue

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.5.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

>From 5fddbd46b32cad5afa6c2c4ccf96f73f3458ce50 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 24 Sep 2013 21:50:23 +0200
Subject: clockevents: Sanitize ticks to nsec conversion
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 97b9410643475d6557d2517c2aff9fd2221141a9 upstream.

Marc Kleine-Budde pointed out, that commit 77cc982 "clocksource: use
clockevents_config_and_register() where possible" caused a regression
for some of the converted subarchs.

The reason is, that the clockevents core code converts the minimal
hardware tick delta to a nanosecond value for core internal
usage. This conversion is affected by integer math rounding loss, so
the backwards conversion to hardware ticks will likely result in a
value which is less than the configured hardware limitation. The
affected subarchs used their own workaround (SIGH!) which got lost in
the conversion.

The solution for the issue at hand is simple: adding evt->mult - 1 to
the shifted value before the integer divison in the core conversion
function takes care of it. But this only works for the case where for
the scaled math mult/shift pair "mult <= 1 << shift" is true. For the
case where "mult > 1 << shift" we can apply the rounding add only for
the minimum delta value to make sure that the backward conversion is
not less than the given hardware limit. For the upper bound we need to
omit the rounding add, because the backwards conversion is always
larger than the original latch value. That would violate the upper
bound of the hardware device.

Though looking closer@the details of that function reveals another
bogosity: The upper bounds check is broken as well. Checking for a
resulting "clc" value greater than KTIME_MAX after the conversion is
pointless. The conversion does:

      u64 clc = (latch << evt->shift) / evt->mult;

So there is no sanity check for (latch << evt->shift) exceeding the
64bit boundary. The latch argument is "unsigned long", so on a 64bit
arch the handed in argument could easily lead to an unnoticed shift
overflow. With the above rounding fix applied the calculation before
the divison is:

       u64 clc = (latch << evt->shift) + evt->mult - 1;

So we need to make sure, that neither the shift nor the rounding add
is overflowing the u64 boundary.

[ukl: move assignment to rnd after eventually changing mult, fix build
 issue and correct comment with the right math]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: nicolas.ferre at atmel.com
Cc: Marc Pignat <marc.pignat@hevs.ch>
Cc: john.stultz at linaro.org
Cc: kernel at pengutronix.de
Cc: Ronald Wahl <ronald.wahl@raritan.com>
Cc: LAK <linux-arm-kernel@lists.infradead.org>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
Link: http://lkml.kernel.org/r/1380052223-24139-1-git-send-email-u.kleine-koenig at pengutronix.de
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 kernel/time/clockevents.c | 65 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 7e1ce01..9b7a7fb 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -30,29 +30,64 @@ static RAW_NOTIFIER_HEAD(clockevents_chain);
 /* Protection for the above */
 static DEFINE_RAW_SPINLOCK(clockevents_lock);

-/**
- * clockevents_delta2ns - Convert a latch value (device ticks) to nanoseconds
- * @latch:	value to convert
- * @evt:	pointer to clock event device descriptor
- *
- * Math helper, returns latch value converted to nanoseconds (bound checked)
- */
-u64 clockevent_delta2ns(unsigned long latch, struct clock_event_device *evt)
+static u64 cev_delta2ns(unsigned long latch, struct clock_event_device *evt,
+			bool ismax)
 {
 	u64 clc = (u64) latch << evt->shift;
+	u64 rnd;

 	if (unlikely(!evt->mult)) {
 		evt->mult = 1;
 		WARN_ON(1);
 	}
+	rnd = (u64) evt->mult - 1;
+
+	/*
+	 * Upper bound sanity check. If the backwards conversion is
+	 * not equal latch, we know that the above shift overflowed.
+	 */
+	if ((clc >> evt->shift) != (u64)latch)
+		clc = ~0ULL;
+
+	/*
+	 * Scaled math oddities:
+	 *
+	 * For mult <= (1 << shift) we can safely add mult - 1 to
+	 * prevent integer rounding loss. So the backwards conversion
+	 * from nsec to device ticks will be correct.
+	 *
+	 * For mult > (1 << shift), i.e. device frequency is > 1GHz we
+	 * need to be careful. Adding mult - 1 will result in a value
+	 * which when converted back to device ticks can be larger
+	 * than latch by up to (mult - 1) >> shift. For the min_delta
+	 * calculation we still want to apply this in order to stay
+	 * above the minimum device ticks limit. For the upper limit
+	 * we would end up with a latch value larger than the upper
+	 * limit of the device, so we omit the add to stay below the
+	 * device upper boundary.
+	 *
+	 * Also omit the add if it would overflow the u64 boundary.
+	 */
+	if ((~0ULL - clc > rnd) &&
+	    (!ismax || evt->mult <= (1U << evt->shift)))
+		clc += rnd;

 	do_div(clc, evt->mult);
-	if (clc < 1000)
-		clc = 1000;
-	if (clc > KTIME_MAX)
-		clc = KTIME_MAX;

-	return clc;
+	/* Deltas less than 1usec are pointless noise */
+	return clc > 1000 ? clc : 1000;
+}
+
+/**
+ * clockevents_delta2ns - Convert a latch value (device ticks) to nanoseconds
+ * @latch:	value to convert
+ * @evt:	pointer to clock event device descriptor
+ *
+ * Math helper, returns latch value converted to nanoseconds (bound checked)
+ */
+u64 clockevent_delta2ns(unsigned long latch, struct clock_event_device *evt)
+{
+	return cev_delta2ns(latch, evt, false);
 }
 EXPORT_SYMBOL_GPL(clockevent_delta2ns);

@@ -317,8 +352,8 @@ void clockevents_config(struct clock_event_device *dev, u32 freq)
 		sec = 600;

 	clockevents_calc_mult_shift(dev, freq, sec);
-	dev->min_delta_ns = clockevent_delta2ns(dev->min_delta_ticks, dev);
-	dev->max_delta_ns = clockevent_delta2ns(dev->max_delta_ticks, dev);
+	dev->min_delta_ns = cev_delta2ns(dev->min_delta_ticks, dev, false);
+	dev->max_delta_ns = cev_delta2ns(dev->max_delta_ticks, dev, true);
 }

 /**
--
1.8.3.2
