From: joshc@codeaurora.org (Josh Cartwright)
Date: Wed, 5 Feb 2014 15:47:02 -0600
Subject: Weird sched_clock behaviour during boot with -rc1
In-Reply-To: <20140204220045.GC20528@codeaurora.org>
References: <20140204183641.GA25127@mudshark.cambridge.arm.com>
 <52F1518B.9010109@linaro.org>
 <20140204220045.GC20528@codeaurora.org>
Message-ID: <20140205214702.GP20228@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 02:00:45PM -0800, Stephen Boyd wrote:
> On 02/04, John Stultz wrote:
> > On 02/04/2014 10:36 AM, Will Deacon wrote:
> > > Hi guys,
> > >
> > > Booting -rc1 on my TC2 gives the following strange entries in the dmesg:
> > >
> > >
> > >   Uncompressing Linux... done, booting the kernel.
> > >   [    0.000000] Booting Linux on physical CPU 0x0
> > >
> > >   [...]
> > >
> > >   [    0.000000]   HighMem zone: 329728 pages, LIFO batch:31
> > >   [    7.789662] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956969942ns
> > >   [    0.000129] PERCPU: Embedded 9 pages/cpu @ee7bd000 s12800 r8192 d15872 u36864
> > >
> > >   [...]
> > >
> > >   [    0.868297] NR_IRQS:16 nr_irqs:16 16
> > >   [    0.886350] Architected cp15 timer(s) running at 24.00MHz (phys).
> > >   [ 2915.164998] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 2863311519744ns
> > >   [    0.000002] Switching to timer-based delay loop
> > >   [    0.014249] Console: colour dummy device 80x30
> > >
> > >
> > > so it looks like something whacky goes on during sched_clock registration.
> > > Sure enough, we're doing a pr_info in-between updating cs.* and calling
> > > update_sched_clock(), so moving the print sorts things out (diff below).
> > 
> > Yea... we have to be particularly careful with sched_clock to avoid
> > locks since we don't want to deadlock, but in this case
> > sched_clock_register is a little too relaxed here.
> > 
> > Stephen: Would it make sense to set cd.suspended = true at the top of
> > the registration? That should block any sched_clock calls from getting
> > half-updated data, but still allow the sched_clock_update function to work.
> > 
> 
> That would work, but why can't we just hold the write seqlock
> during the registration? We would need to make a lockeless
> version of update_sched_clock() but that doesn't look too hard.
> It might actually turn out nicer because we call
> update_sched_clock() here just to set the epoch_cyc but we have
> to reset the epoch_ns back to 0 to start the count off right.
> 
> How about this? The only concern is calling read_sched_clock()
> inside the seqlock, but I don't think that's a concern and if it
> is we can call it outside the lock at the beginning of this
> function.

If we go down this route, it looks there is an opportunity to rearrange
the logic a bit to front load the clocksource calculations, minimizing
the amount of time the lock is held.

----8<----
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index e5387a0..9bad1f7 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -116,20 +116,40 @@ static enum hrtimer_restart sched_clock_poll(struct hrtimer *hrt)
 void __init sched_clock_register(u64 (*read)(void), int bits,
 				 unsigned long rate)
 {
+	u64 res, wrap, new_mask;
+	u32 new_mult, new_shift;
+	ktime_t new_wrap_kt;
 	unsigned long r;
-	u64 res, wrap;
 	char r_unit;
 
 	if (cd.rate > rate)
 		return;
 
 	WARN_ON(!irqs_disabled());
+
+	/* calculate the mult/shift to convert counter ticks to ns. */
+	clocks_calc_mult_shift(&new_mult, &new_shift, rate, NSEC_PER_SEC, 3600);
+
+	new_mask = CLOCKSOURCE_MASK(bits);
+
+	/* calculate how many ns until we wrap */
+	wrap = clocks_calc_max_nsecs(new_mult, new_shift, 0, new_mask);
+	new_wrap_kt = ns_to_ktime(wrap - (wrap >> 3));
+
+	raw_write_seqcount_begin(&cd.seq);
 	read_sched_clock = read;
-	sched_clock_mask = CLOCKSOURCE_MASK(bits);
+	sched_clock_mask = new_mask;
 	cd.rate = rate;
+	cd.wrap_kt = new_wrap_kt;
+	cd.mult = new_mult;
+	cd.shift = new_shift;
 
-	/* calculate the mult/shift to convert counter ticks to ns. */
-	clocks_calc_mult_shift(&cd.mult, &cd.shift, rate, NSEC_PER_SEC, 3600);
+	/*
+	 * Ensure that sched_clock() starts off at 0ns
+	 */
+	cd.epoch_ns = 0;
+	cd.epoch_cyc = read_sched_clock();
+	raw_write_seqcount_end(&cd.seq);
 
 	r = rate;
 	/*
@@ -145,22 +165,12 @@ void __init sched_clock_register(u64 (*read)(void), int bits,
 	} else
 		r_unit = ' ';
 
-	/* calculate how many ns until we wrap */
-	wrap = clocks_calc_max_nsecs(cd.mult, cd.shift, 0, sched_clock_mask);
-	cd.wrap_kt = ns_to_ktime(wrap - (wrap >> 3));
-
 	/* calculate the ns resolution of this counter */
-	res = cyc_to_ns(1ULL, cd.mult, cd.shift);
+	res = cyc_to_ns(1ULL, new_mult, new_shift);
+
 	pr_info("sched_clock: %u bits at %lu%cHz, resolution %lluns, wraps every %lluns\n",
 		bits, r, r_unit, res, wrap);
 
-	update_sched_clock();
-
-	/*
-	 * Ensure that sched_clock() starts off at 0ns
-	 */
-	cd.epoch_ns = 0;
-
 	/* Enable IRQ time accounting if we have a fast enough sched_clock */
 	if (irqtime > 0 || (irqtime == -1 && rate >= 1000000))
 		enable_sched_clock_irqtime();
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
