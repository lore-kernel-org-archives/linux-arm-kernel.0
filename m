From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Jul 2018 16:14:54 +0100
Subject: [PATCH] Add cap_user_time aarch64
In-Reply-To: <20180713192451.49280-1-micpof@gmail.com>
References: <20180713192451.49280-1-micpof@gmail.com>
Message-ID: <20180724151452.GD25412@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

[adding Peter]

Thanks for the patch. I think the general idea is sound, but I have a few
questions about the implementation.

On Fri, Jul 13, 2018 at 12:24:51PM -0700, Michael O'Farrell wrote:
> It is useful to get the running time of a thread.  Doing so in an
> efficient manner can be important for performance of user applications.
> Avoiding system calls in `clock_gettime` when handling
> CLOCK_THREAD_CPUTIME_ID is important.  Other clocks are handled in the
> VDSO, but CLOCK_THREAD_CPUTIME_ID falls back on the system call.
> 
> CLOCK_THREAD_CPUTIME_ID is not handled in the VDSO since it would have
> costs associated with maintaining updated user space accessible time
> offsets.  These offsets have to be updated everytime the a thread is
> scheduled/descheduled.  However, for programs regularly checking the
> running time of a thread, this is a performance improvement.
> 
> This patch takes a middle ground, and adds support for cap_user_time an
> optional feature of the perf_event API.  This way costs are only
> incurred when the perf_event api is enabled.  This is done the same way
> as it is in x86.  This patch also enables the cap_user_time facility of
> perf_event since it comes free with the stable clock.
> 
> Ultimately this allows calculating the thread running time in userspace
> on aarch64 as follows (adapted from perf_event_open manpage):
> 
> u32 seq, time_mult, time_shift;
> u64 running, count, time_offset, quot, rem, delta;
> struct perf_event_mmap_page *pc;
> pc = buf;  // buf is the perf event mmaped page as documented in the API.
> 
> if (pc->cap_usr_time) {
>     do {
>         seq = pc->lock;
>         barrier();
>         running = pc->time_running;
> 
>         count = readCNTVCT_EL0();  // Read ARM hardware clock.
>         time_offset = pc->time_offset;
>         time_mult   = pc->time_mult;
>         time_shift  = pc->time_shift;
> 
>         barrier();
>     } while (pc->lock != seq);

Using only compiler barriers here raises my eyebrows a little, but as long
as this is all in the context of the reader thread, then it should be ok.
I think it means that the comment in events/core.c is bogus:

	/*
	 * Disable preemption so as to not let the corresponding user-space
	 * spin too long if we get preempted.
	 */
	preempt_disable();
	++userpg->lock;
	barrier();

because user-space won't get stuck spinning unless its running concurrently,
at which point it's hosed anyway. Hmmm.

> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 33147aacdafd..c63f31caf7ac 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -25,6 +25,7 @@
>  #include <asm/virt.h>
>  
>  #include <linux/acpi.h>
> +#include <linux/clocksource.h>
>  #include <linux/of.h>
>  #include <linux/perf/arm_pmu.h>
>  #include <linux/platform_device.h>
> @@ -1127,3 +1128,41 @@ static int __init armv8_pmu_driver_init(void)
>  		return arm_pmu_acpi_probe(armv8_pmuv3_init);
>  }
>  device_initcall(armv8_pmu_driver_init)
> +
> +#ifndef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK

We never select CONFIG_HAVE_UNSTABLE_SCHED_CLOCK, so you can remove the
guards.

> +void arch_perf_update_userpage(struct perf_event *event,
> +			       struct perf_event_mmap_page *userpg, u64 now)
> +{
> +	u32 freq;
> +	u32 shift;
> +
> +	/*
> +	 * Internal timekeeping for enabled/running/stopped times
> +	 * is always computed with the sched_clock.
> +	 */
> +	freq = arch_timer_get_rate();
> +	userpg->cap_user_time = 1;
> +
> +	clocks_calc_mult_shift(&userpg->time_mult, &shift, freq,
> +			NSEC_PER_SEC, 0);
> +	/*
> +	 * time_shift is not expected to be greater than 31 due to
> +	 * the original published conversion algorithm shifting a
> +	 * 32-bit value (now specifies a 64-bit value) - refer
> +	 * perf_event_mmap_page documentation in perf_event.h.
> +	 */
> +	if (shift == 32) {
> +		shift = 31;
> +		userpg->time_mult >>= 1;
> +	}

Can you explain this a bit more, please? Given that we've never enabled this
on arm64, why do we have a problem with a legacy algorithm?

> +	userpg->time_shift = (u16)shift;
> +	userpg->time_offset = -now;
> +
> +	/*
> +	 * We are always using the sched_clock as the base, so
> +	 * cap_user_time_zero makes sense.
> +	 */

How are you enforcing that we're always using sched_clock?

> +	userpg->cap_user_time_zero = 1;
> +	userpg->time_zero = 0;

I'm not sure we can rely on the architected timer being zero initialised --
our booting documentation just require it to be consistent between CPUs.

Will
