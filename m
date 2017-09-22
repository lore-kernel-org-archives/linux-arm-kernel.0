From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Sep 2017 18:20:22 +0100
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170922164850.GA13235@obsidianresearch.com>
References: <20170920162208.GB536@obsidianresearch.com>
 <20170920165141.GP20805@n2100.armlinux.org.uk>
 <20170920224522.GB20974@obsidianresearch.com>
 <20170921075907.GR20805@n2100.armlinux.org.uk>
 <20170921093218.GS20805@n2100.armlinux.org.uk>
 <20170921220510.GA11395@obsidianresearch.com>
 <20170921224541.GC20805@n2100.armlinux.org.uk>
 <20170921232040.GA15130@obsidianresearch.com>
 <20170922095713.GD20805@n2100.armlinux.org.uk>
 <20170922164850.GA13235@obsidianresearch.com>
Message-ID: <20170922172022.GJ20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 22, 2017 at 10:48:50AM -0600, Jason Gunthorpe wrote:
> On Fri, Sep 22, 2017 at 10:57:13AM +0100, Russell King - ARM Linux wrote:
> 
> > > Okay.. but I guessed a negative number is probably not what most RTCs would
> > > want, eg a positive number would compensate for delays executing an
> > > I2C command, assuming the RTC zeros its divider when it sets the time.
> > 
> > Okay, I thought I'd investigate a few other systems:
> > 
> > With the mainline code, which sets the RTC to tv_sec + 1 when tv_nsec
> > >= 500ms or tv_sec when tv_nsec < 500ms,@about tv_nsec = 500ms:
> 
> The more I think about this, the more I think the above rounding is a bug
> in rtc_set_ntp_time. It does not make any sense to target 0.5 for the
> update and then, essentially, randomly add one second depending on
> where the time tick happens.
> 
> Based on your other study of the WQ behavior I would anticipate the
> time tick is consistently > .5s, so historically the rtc_set_ntp_time
> always adds +1s.
> 
> Unfortunately, the classic pre-rtclib mechanism in somthing like x86
> mach_set_rtc_mmss just truncates, not rounds. Both cannot be right
> when talking about the same RTC chip.
> 
> So, my guess, is that the ntp stuff was written and tested against the
> old x86 code, eg the round down behavior.
> 
> This suggests the CMOS mechanism expects to set time 1.0 seconds at
> instant 1.5 s. ie when the RTC executes the time set it sets the seconds
> scaler to 0.5, not zero. With the v2 patch this would be a -0.5s
> set_offset_nsec value.

See the comment in arch/x86/kernel/rtc.c:

/*
 * In order to set the CMOS clock precisely, set_rtc_mmss has to be
 * called 500 ms after the second nowtime has started, because when
 * nowtime is written into the registers of the CMOS clock, it will
 * jump to the next second precisely 500 ms later. Check the Motorola
 * MC146818A or Dallas DS12887 data sheet for details.
 */

> > > My bad to not notice that.. But I'm not sure what the revision should
> > > be.. I think this is using tick_nsec similarly to TIME_SET_NSEC_FUZZ,
> > > but I'm not sure where tick_nsec comes from or if we should push it
> > > down in to TIME_SET_NSEC_FUZZ, or something else.
> > 
> > I think tick_nsec is the length of one tick in nanoseconds, adjusted
> > by NTP (see ntp_update_frequency() where it's calculated.)
> 
> Yes, having some time to look at it now, tick_ns*5 is about 5
> jiffies, your system is using 4ms jiffies, so the existing code has a
> TIME_SET_NSEC_FUZZ of +-20ms from the target time. Guessing someone
> already figured out the WQ is very inaccurate and delt with it by
> using tick_ns*5. I copied that into patch v3 below

It's much worse than that - I'm seeing the 10s timer delayed by between
1 and 63 jiffies, which is 4 to 252ms - over a quarter of a second.  The
further the timer is in the future, the more inaccurate it is.

This, I think, is why the code reschedules the timer in the failure case
using as small a delay as possible, not 10s.

> Perhaps this should ultimately be moved to a hrtimer or something.
> 
> > The only places it's used is by the NTP code, and also by a few
> > architectures to that still have gettimeoffset() functionality (pre-
> > clocksource) as it can be used to derive the scaling factor to convert
> > timer count ticks to wall time.
> 
> This may also be a source of some of the WQ error, my patches have
> done this:
> 
> 	getnstimeofday64(&now);
> 	delta = timespec64_sub(next, now);
>         timespec64_to_jiffies(&delta));
> 
> 'delta' is wall clock ns, not jiffies ns. Depending on how the
> timekeeping works, it may need a scale factor when converting to
> jiffies? Particularly when talking about the 11 min sleep
> 
> However the original code does not seem to have anything like that..
> 
> > Maybe the solution here is to split two forms of ntp RTC synchronisation
> > so:
> > - If you enable CONFIG_GENERIC_CMOS_UPDATE, then you get the
> >   update_persistent_clock*() methods called.
> > - If you enable CONFIG_RTC_SYSTOHC, rtc_set_ntp_time() gets called.
> > - If you enable both, then both get called at their appropriate times.
> > 
> > This would certainly simplify sync_cmos_clock().
> 
> Yes, splitting makes sense to me, but calling both rtc_set_ntp_time
> and update_persistent_clock doesn't seem like a good idea. At least
> x86 looks like it will provide both mechanism?, We don't want to
> set the RTC twice..
> 
> Patch v3 reworks that code to be clearer as you suggested, but keeps
> the semantic that if cmos is supported rtc does not run.
> 
> Still untested, sorry about that..
> 
> v3:
> - Revise TIME_SET_NSEC_FUZZ to be 5 jiffies, like sync_cmos_clock had
> - Split sync_cmos_clock into CMOS and RTC code paths, retain the two
>   different kinds of rounding being used.
> - Go back to a 1 s update interval
> 
> Jason
> 
> >From 2ff270d4984daf100112c33689db428bebb73d6f Mon Sep 17 00:00:00 2001
> From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Date: Fri, 22 Sep 2017 10:43:11 -0600
> Subject: [PATCH v3] rtc: Allow rtc drivers to specify the tv_nsec value for ntp
> 
> ntp is currently hardwired to try and call the rtc set when wall clock
> tv_nsec is 0.5 seconds. This historical behaviour works well with certain
> PC RTCs, but is not universal to all rtc hardware.
> 
> Change how this works by introducing the driver specific concept of
> a required delay between current wall clock time and the target time
> to set (with a 0 tv_nsecs). When this delay is set to 0.5 seconds then
> the behaviour will be the same as today, at wall clock time 0.5 sec the
> RTC set will be called to set 1.0 sec.
> 
> Each RTC driver should set the set_offset_nsec according to its needs.
> 
> The calculation of the sleep time and 'fuzz' for ntp is also revised
> to use modern helper functions, and to more directly and safely
> compute a relative jiffies delay that will result in the correct
> tv_nsec. If for some reason the timer does not meet the requirement
> then it does a shorter sleep and tries again.
> 
> Since cmos and RTC now have very different handling they are split
> into two dedicated code paths, sharing the support code.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/rtc/class.c   |   6 ++
>  drivers/rtc/systohc.c |  53 +++++++++++-----
>  include/linux/rtc.h   |  43 ++++++++++++-
>  kernel/time/ntp.c     | 171 +++++++++++++++++++++++++++++++++-----------------
>  4 files changed, 201 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
> index 2ed970d61da140..eef4123a573504 100644
> --- a/drivers/rtc/class.c
> +++ b/drivers/rtc/class.c
> @@ -161,6 +161,12 @@ static struct rtc_device *rtc_allocate_device(void)
>  
>  	device_initialize(&rtc->dev);
>  
> +	/* Drivers can revise this default after allocating the device. It
> +	 * should be the value of wallclock tv_nsec that the driver needs in
> +	 * order to synchronize the second tick over during set.
> +	 */
> +	rtc->set_offset_nsec =  NSEC_PER_SEC / 2;
> +
>  	rtc->irq_freq = 1;
>  	rtc->max_user_freq = 64;
>  	rtc->dev.class = rtc_class;
> diff --git a/drivers/rtc/systohc.c b/drivers/rtc/systohc.c
> index b4a68ffcd06bb8..5e50c9db57344a 100644
> --- a/drivers/rtc/systohc.c
> +++ b/drivers/rtc/systohc.c
> @@ -10,6 +10,7 @@
>  /**
>   * rtc_set_ntp_time - Save NTP synchronized time to the RTC
>   * @now: Current time of day
> + * @target_nsec: pointer for desired now->tv_nsec value
>   *
>   * Replacement for the NTP platform function update_persistent_clock64
>   * that stores time for later retrieval by rtc_hctosys.
> @@ -18,30 +19,52 @@
>   * possible at all, and various other -errno for specific temporary failure
>   * cases.
>   *
> + * -EPROTO is returned if now.tv_nsec is not close enough to *target_nsec.
> + (
>   * If temporary failure is indicated the caller should try again 'soon'
>   */
> -int rtc_set_ntp_time(struct timespec64 now)
> +int rtc_set_ntp_time(struct timespec64 now, unsigned long *target_nsec)
>  {
>  	struct rtc_device *rtc;
>  	struct rtc_time tm;
> +	struct timespec64 to_set;
>  	int err = -ENODEV;
> -
> -	if (now.tv_nsec < (NSEC_PER_SEC >> 1))
> -		rtc_time64_to_tm(now.tv_sec, &tm);
> -	else
> -		rtc_time64_to_tm(now.tv_sec + 1, &tm);
> +	bool ok;
>  
>  	rtc = rtc_class_open(CONFIG_RTC_SYSTOHC_DEVICE);
> -	if (rtc) {
> -		/* rtc_hctosys exclusively uses UTC, so we call set_time here,
> -		 * not set_mmss. */
> -		if (rtc->ops &&
> -		    (rtc->ops->set_time ||
> -		     rtc->ops->set_mmss64 ||
> -		     rtc->ops->set_mmss))
> -			err = rtc_set_time(rtc, &tm);
> -		rtc_class_close(rtc);
> +	if (!rtc)
> +		goto out_err;
> +
> +	if (!rtc->ops || (!rtc->ops->set_time && !rtc->ops->set_mmss64 &&
> +			  !rtc->ops->set_mmss))
> +		goto out_close;
> +
> +	/* Compute the value of tv_nsec we require the caller to supply in
> +	 * now.tv_nsec.  This is the value such that (now +
> +	 * set_offset_nsec).tv_nsec == 0.
> +	 */
> +	set_normalized_timespec64(&to_set, 0, -rtc->set_offset_nsec);
> +	*target_nsec = to_set.tv_nsec;
> +
> +	/* The ntp code must call this with the correct value in tv_nsec, if
> +	 * it does not we update target_nsec and return EPROTO to make the ntp
> +	 * code try again later.
> +	 */
> +	ok = rtc_tv_nsec_ok(rtc, &to_set, &now);

This doesn't match the prototype.

> +	if (!ok) {
> +		err = -EPROTO;
> +		goto out_close;
>  	}
>  
> +	rtc_time64_to_tm(to_set.tv_sec, &tm);
> +
> +	/* rtc_hctosys exclusively uses UTC, so we call set_time here, not
> +	 * set_mmss.
> +	 */
> +	err = rtc_set_time(rtc, &tm);
> +
> +out_close:
> +	rtc_class_close(rtc);
> +out_err:
>  	return err;
>  }
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index 0a0f0d14a5fba5..eb767f0bfc13fa 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -137,6 +137,14 @@ struct rtc_device {
>  	/* Some hardware can't support UIE mode */
>  	int uie_unsupported;
>  
> +	/* Number of nsec it takes to set the RTC clock. This influences when
> +	 * the set ops are called. An offset:
> +	 *   - of 0.5 s will call RTC set for wall clock time 10.0 s at 9.5 s
> +	 *   - of 1.5 s will call RTC set for wall clock time 10.0 s at 8.5 s
> +	 *   - of -0.5 s will call RTC set for wall clock time 10.0 s at 10.5 s
> +	 */
> +	long set_offset_nsec;
> +
>  	bool registered;
>  
>  	struct nvmem_config *nvmem_config;
> @@ -174,7 +182,7 @@ extern void devm_rtc_device_unregister(struct device *dev,
>  
>  extern int rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm);
>  extern int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm);
> -extern int rtc_set_ntp_time(struct timespec64 now);
> +extern int rtc_set_ntp_time(struct timespec64 now, unsigned long *target_nsec);
>  int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm);
>  extern int rtc_read_alarm(struct rtc_device *rtc,
>  			struct rtc_wkalrm *alrm);
> @@ -223,6 +231,39 @@ static inline bool is_leap_year(unsigned int year)
>  	return (!(year % 4) && (year % 100)) || !(year % 400);
>  }
>  
> +/* Determine if we can call to driver to set the time. Drivers can only be
> + * called to set a second aligned time value, and the field set_offset_nsec
> + * specifies how far away from the second aligned time to call the driver.
> + *
> + * This also computes 'to_set' which is the time we are trying to set, and has
> + * a zero in tv_nsecs, such that:
> + *    to_set - set_delay_nsec == now +/- FUZZ
> + *
> + */
> +static inline bool rtc_tv_nsec_ok(s64 set_offset_nsec,
> +				  struct timespec64 *to_set,
> +				  const struct timespec64 *now)
> +{
> +	/* Allowed error in tv_nsec, arbitarily set to 5 jiffies in ns. */
> +	const unsigned long TIME_SET_NSEC_FUZZ = TICK_NSEC * 5;
> +	struct timespec64 delay = {.tv_sec = 0,
> +				   .tv_nsec = set_offset_nsec};
> +
> +	*to_set = timespec64_add(*now, delay);
> +
> +	if (to_set->tv_nsec < TIME_SET_NSEC_FUZZ) {
> +		to_set->tv_nsec = 0;
> +		return true;
> +	}
> +
> +	if (to_set->tv_nsec > NSEC_PER_SEC - TIME_SET_NSEC_FUZZ) {
> +		to_set->tv_sec++;
> +		to_set->tv_nsec = 0;
> +		return true;
> +	}
> +	return false;
> +}
> +
>  #define rtc_register_device(device) \
>  	__rtc_register_device(THIS_MODULE, device)
>  
> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> index edf19cc5314043..90c348781995b5 100644
> --- a/kernel/time/ntp.c
> +++ b/kernel/time/ntp.c
> @@ -492,12 +492,77 @@ int second_overflow(time64_t secs)
>  	return leap;
>  }
>  
> -#ifdef CONFIG_GENERIC_CMOS_UPDATE
> -int __weak update_persistent_clock(struct timespec now)
> +static void sync_hw_clock(struct work_struct *work);
> +static DECLARE_DELAYED_WORK(sync_work, sync_hw_clock);
> +
> +static void sched_sync_hw_clock(struct timespec64 now,
> +				unsigned long target_nsec, bool fail)
>  {
> -	return -ENODEV;
> +	struct timespec64 next, delta;
> +
> +	do {
> +		/*
> +		 * Compute the next wall clock time to try and set the
> +		 * clock
> +		 */
> +		next = now;
> +		if (!fail)
> +			timespec64_add_ns(&next, 659ULL * NSEC_PER_SEC);
> +		else
> +			/* Update failed, try again in about 10 seconds */
> +			timespec64_add_ns(&next, 10ULL * NSEC_PER_SEC);
> +
> +		/*
> +		 * The next call to sync_cmos_clock needs to have have a wall
> +		 * clock tv_nsec value equal to target_nsec.
> +		 */
> +		if (next.tv_nsec > target_nsec)
> +			next.tv_sec++;
> +		next.tv_nsec = target_nsec;
> +
> +		/*
> +		 * Convert to a relative delay. If time set took a really long
> +		 * time, or the wall clock was changed, this might become
> +		 * negative, so try again.
> +		 */
> +		getnstimeofday64(&now);
> +		delta = timespec64_sub(next, now);
> +	} while (delta.tv_sec <= 0);

If we re-read "now"@the start, do we need the complexity of this loop?
it isn't critical that this gets run exactly 11 minutes after the previous
attempt, so we ought to keep this code simple.  At that point, we might
as well keep the whole thing simple - we don't need all the complexity
that the timespec64 math helpers above bring with it.

	getnstimeofday64(&next);
	if (!fail)
		next.tv_sec = 659;
	else
		next.tv_sec = 0;

	/* 0 < target_nsec < NSEC_PER_SEC */
	next.tv_nsec = target_nsec - next.tv_nsec;
	if (next.tv_nsec <= 0)
		next.tv_nsec += NSEC_PER_SEC;
	if (next.tv_nsec >= NSEC_PER_SEC) {
		next.tv_sec++;
		next.tv_nsec -= NSEC_PER_SEC;
	}

This is basically what the current mainline code is doing, and there's
not much need to move away from it, because target_nsec needs to still
satisfy the constraint mentioned in the comment above.

The weirdness with the <= 0 and >= NSEC_PER_SEC also caters for the
tv_sec = tv_nsec = 0 case, bumping into the next second for a zero
timeout.

> +
> +	queue_delayed_work(system_power_efficient_wq, &sync_work,
> +			   timespec64_to_jiffies(&delta));
>  }
>  
> +#if defined(CONFIG_RTC_SYSTOHC)
> +static void sync_rtc_clock(void)
> +{
> +	unsigned long target_nsec;
> +	struct timespec64 adjust, now;
> +	int rc;
> +
> +	getnstimeofday64(&now);
> +
> +	now = adjust;
> +	if (persistent_clock_is_local)
> +		adjust.tv_sec -= (sys_tz.tz_minuteswest * 60);
> +
> +	/*
> +	 * The current RTC in use will provide the target_nsec it wants to be
> +	 * called at, and does rtc_tv_nsec_ok internally.
> +	 */
> +	rc = rtc_set_ntp_time(adjust, &target_nsec);
> +
> +	sched_sync_hw_clock(now, target_nsec, rc && rc != -ENODEV);
> +}
> +#else
> +static void sync_rtc_clock(void)
> +{
> +}
> +#endif
> +
> +#if defined(CONFIG_GENERIC_CMOS_UPDATE)
> +int __weak update_persistent_clock(struct timespec now) { return -ENODEV; }
> +
>  int __weak update_persistent_clock64(struct timespec64 now64)
>  {
>  	struct timespec now;
> @@ -505,78 +570,72 @@ int __weak update_persistent_clock64(struct timespec64 now64)
>  	now = timespec64_to_timespec(now64);
>  	return update_persistent_clock(now);
>  }
> -#endif
> -
> -#if defined(CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC)
> -static void sync_cmos_clock(struct work_struct *work);
> -
> -static DECLARE_DELAYED_WORK(sync_cmos_work, sync_cmos_clock);
>  
> -static void sync_cmos_clock(struct work_struct *work)
> +static bool sync_cmos_clock(void)
>  {
> +	static bool no_cmos;
>  	struct timespec64 now;
> -	struct timespec64 next;
> -	int fail = 1;
> +	struct timespec64 adjust;
> +	int rc = -EPROTO;
> +	long target_nsec = NSEC_PER_SEC / 2;
> +
> +	if (no_cmos)
> +		return false;
>  
>  	/*
> -	 * If we have an externally synchronized Linux clock, then update
> -	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
> -	 * called as close as possible to 500 ms before the new second starts.
> -	 * This code is run on a timer.  If the clock is set, that timer
> -	 * may not expire at the correct time.  Thus, we adjust...
> -	 * We want the clock to be within a couple of ticks from the target.
> +	 * Historically update_persistent_clock64() has to be called as close
> +	 * as possible to 500 ms (target_nsec) before the new second starts.
> +	 * The CMOS code 'rounds down' from this value, so we use a negative
> +	 * input to rtc_tv_nsec_ok to compute adjust.
> +	 *
> +	 * Architectures are strongly encouraged to use rtclib and not
> +	 * implement this legacy API.
>  	 */
> -	if (!ntp_synced()) {
> -		/*
> -		 * Not synced, exit, do not restart a timer (if one is
> -		 * running, let it run out).
> -		 */
> -		return;
> -	}
> -
>  	getnstimeofday64(&now);
> -	if (abs(now.tv_nsec - (NSEC_PER_SEC / 2)) <= tick_nsec * 5) {
> -		struct timespec64 adjust = now;
> -
> -		fail = -ENODEV;
> +	if (rtc_tv_nsec_ok(-1 * target_nsec, &adjust, &now)) {
>  		if (persistent_clock_is_local)
>  			adjust.tv_sec -= (sys_tz.tz_minuteswest * 60);
> -#ifdef CONFIG_GENERIC_CMOS_UPDATE
> -		fail = update_persistent_clock64(adjust);
> -#endif
> +		rc = update_persistent_clock64(adjust);
> +		/*
> +		 * The machine does not support update_persistent_clock64 even
> +		 * though it defines it.
> +		 */
> +		if (rc == -ENODEV) {
> +			no_cmos = true;
> +			return false;
> +		}
> +	}
>  
> -#ifdef CONFIG_RTC_SYSTOHC
> -		if (fail == -ENODEV)
> -			fail = rtc_set_ntp_time(adjust);
> +	sched_sync_hw_clock(now, target_nsec, rc);
> +	return true;
> +}
> +#else
> +static bool sync_cmos_clock(void)
> +{
> +	return false;
> +}
>  #endif
> -	}
>  
> -	next.tv_nsec = (NSEC_PER_SEC / 2) - now.tv_nsec - (TICK_NSEC / 2);
> -	if (next.tv_nsec <= 0)
> -		next.tv_nsec += NSEC_PER_SEC;
> +static void sync_hw_clock(struct work_struct *work)
> +{
> +	if (!ntp_synced())
> +		return;
>  
> -	if (!fail || fail == -ENODEV)
> -		next.tv_sec = 659;
> -	else
> -		next.tv_sec = 0;
> +	if (sync_cmos_clock())
> +		return;
>  
> -	if (next.tv_nsec >= NSEC_PER_SEC) {
> -		next.tv_sec++;
> -		next.tv_nsec -= NSEC_PER_SEC;
> -	}
> -	queue_delayed_work(system_power_efficient_wq,
> -			   &sync_cmos_work, timespec64_to_jiffies(&next));
> +	sync_rtc_clock();
>  }
>  
>  void ntp_notify_cmos_timer(void)
>  {
> -	queue_delayed_work(system_power_efficient_wq, &sync_cmos_work, 0);
> -}
> -
> -#else
> -void ntp_notify_cmos_timer(void) { }
> -#endif
> +	if (!ntp_synced())
> +		return;
>  
> +	if (IS_ENABLED(CONFIG_GENERIC_CMOS_UPDATE) ||
> +	    IS_ENABLED(CONFIG_RTC_SYSTOHC))
> +		queue_delayed_work(system_power_efficient_wq, &sync_work, 0);
> +}
>  
>  /*
>   * Propagate a new txc->status value into the NTP state:
> -- 
> 2.7.4
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
