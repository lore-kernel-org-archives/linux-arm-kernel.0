From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  7 Feb 2014 14:28:58 -0800
Subject: [PATCH v2] sched_clock: Prevent callers from seeing half-updated data
In-Reply-To: <1391806139-20116-1-git-send-email-sboyd@codeaurora.org>
References: <1391806139-20116-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1391812138-15492-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If two sched_clock sources are registered we may end up in a
situation where a call to sched_clock() may be accessing the
epoch cycle count for the old counter and the cycle count for the
new counter. This can lead to confusing results where
sched_clock() values jump and then are reset to 0 (due to the way
the registration function forces the epoch_ns to be 0). Fix this
by reorganizing the registration function to hold the seqlock for
as short a time as possible while we update the clock_data
structure for a new counter. We also put any accumulated time
into epoch_ns instead of resetting the time to 0 so that the clock
doesn't reset after each successful registration.

Reported-by: Will Deacon <will.deacon@arm.com>
Cc: Josh Cartwright <joshc@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes since v1:
 * Put elapsed time into epoch_ns 

 kernel/time/sched_clock.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 0abb36464281..4d23dc4d8139 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -116,20 +116,42 @@ static enum hrtimer_restart sched_clock_poll(struct hrtimer *hrt)
 void __init sched_clock_register(u64 (*read)(void), int bits,
 				 unsigned long rate)
 {
+	u64 res, wrap, new_mask, new_epoch, cyc, ns;
+	u32 new_mult, new_shift;
+	ktime_t new_wrap_kt;
 	unsigned long r;
-	u64 res, wrap;
 	char r_unit;
 
 	if (cd.rate > rate)
 		return;
 
 	WARN_ON(!irqs_disabled());
-	read_sched_clock = read;
-	sched_clock_mask = CLOCKSOURCE_MASK(bits);
-	cd.rate = rate;
 
 	/* calculate the mult/shift to convert counter ticks to ns. */
-	clocks_calc_mult_shift(&cd.mult, &cd.shift, rate, NSEC_PER_SEC, 3600);
+	clocks_calc_mult_shift(&new_mult, &new_shift, rate, NSEC_PER_SEC, 3600);
+
+	new_mask = CLOCKSOURCE_MASK(bits);
+
+	/* calculate how many ns until we wrap */
+	wrap = clocks_calc_max_nsecs(new_mult, new_shift, 0, new_mask);
+	new_wrap_kt = ns_to_ktime(wrap - (wrap >> 3));
+
+	/* update epoch for new counter and update epoch_ns from old counter*/
+	new_epoch = read();
+	cyc = read_sched_clock();
+	ns = cd.epoch_ns + cyc_to_ns((cyc - cd.epoch_cyc) & sched_clock_mask,
+			  cd.mult, cd.shift);
+
+	raw_write_seqcount_begin(&cd.seq);
+	read_sched_clock = read;
+	sched_clock_mask = new_mask;
+	cd.rate = rate;
+	cd.wrap_kt = new_wrap_kt;
+	cd.mult = new_mult;
+	cd.shift = new_shift;
+	cd.epoch_cyc = new_epoch;
+	cd.epoch_ns = ns;
+	raw_write_seqcount_end(&cd.seq);
 
 	r = rate;
 	if (r >= 4000000) {
@@ -141,22 +163,12 @@ void __init sched_clock_register(u64 (*read)(void), int bits,
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
