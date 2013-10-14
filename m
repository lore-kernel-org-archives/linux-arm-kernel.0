From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 14 Oct 2013 13:14:06 -0700
Subject: [PATCH v4 05/17] arch_timer: Move to generic sched_clock framework
In-Reply-To: <525C3E2F.2030109@codeaurora.org> (Stephen Boyd's message of
 "Mon, 14 Oct 2013 11:55:43 -0700")
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
 <1374189690-10810-6-git-send-email-sboyd@codeaurora.org>
 <87k3hf7kvb.fsf@linaro.org> <525C3E2F.2030109@codeaurora.org>
Message-ID: <87ob6r625t.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 10/14/13 11:44, Kevin Hilman wrote:
>> Stephen Boyd <sboyd@codeaurora.org> writes:
>>
>>> Register with the generic sched_clock framework now that it
>>> supports 64 bits. This fixes two problems with the current
>>> sched_clock support for machines using the architected timers.
>>> First off, we don't subtract the start value from subsequent
>>> sched_clock calls so we can potentially start off with
>>> sched_clock returning gigantic numbers. Second, there is no
>>> support for suspend/resume handling so problems such as discussed
>>> in 6a4dae5 (ARM: 7565/1: sched: stop sched_clock() during
>>> suspend, 2012-10-23) can happen without this patch. Finally, it
>>> allows us to move the sched_clock setup into drivers clocksource
>>> out of the arch ports.
>>>
>>> Cc: Christopher Covington <cov@codeaurora.org>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> A boot failure on Exynos5/Arndale showed up in next-20131014[1], and a
>> subsequent bisect has fingered this patch as the culprit.  
>>
>> I haven't had a chance to debug this any further, but wanted to share in
>> case someone else can debug.  
>>
>> The console log is below, but don't think there is much useful there as
>> it shows nothing after the 'Starting kernel ...' from u-boot.
>
> debug_ll output would be nice. 

Yeah, I tried that, but it only added the uncompress output, but nothing
else useful.

> Anyway, that patch looks "weird". It is
> definitely not what I sent out. Most notably, this hunk jumps out
>
> @@ -471,6 +472,15 @@ static int __init arch_timer_register(void)
>                 goto out;
>         }
>  
> +       clocksource_register_hz(&clocksource_counter, arch_timer_rate);
> +       cyclecounter.mult = clocksource_counter.mult;
> +       cyclecounter.shift = clocksource_counter.shift;
> +       timecounter_init(&timecounter, &cyclecounter,
> +                        arch_counter_get_cntvct());
> +
> +       /* 56 bits minimum, so we assume worst case rollover */
> +       sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
> +
>         if (arch_timer_use_virtual) {
>                 ppi = arch_timer_ppi[VIRT_PPI];
>                 err = request_percpu_irq(ppi, arch_timer_handler_virt,
>
>
> Which is adding the clocksource_register_hz() and timecounter_init()
> call twice. It should only be adding the sched_clock_register() call and
> the sched_clock_register() call should be in arch_counter_register().
> Can you try this patch?

Yup, your patch gets it booting again.

John, how do you want to proceed on this?  The version of $SUBJECT patch
that made it to -next doesn't match the one in sent in this thread.

> ----8<----
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 5d52789..865ecd8 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -420,6 +420,9 @@ static void __init arch_counter_register(unsigned type)
>  	cyclecounter.mult = clocksource_counter.mult;
>  	cyclecounter.shift = clocksource_counter.shift;
>  	timecounter_init(&timecounter, &cyclecounter, start_count);
> +
> +	/* 56 bits minimum, so we assume worst case rollover */
> +	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);

In the original patch (at least in this thread) this bit is still in
arch_timer_register().  I only noticed because I reverted the patch in
-next and applied the one from this thread and got a slightly different
diff than yours.

Kevin


>  }
>  
>  static void arch_timer_stop(struct clock_event_device *clk)
> @@ -472,15 +475,6 @@ static int __init arch_timer_register(void)
>  		goto out;
>  	}
>  
> -	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
> -	cyclecounter.mult = clocksource_counter.mult;
> -	cyclecounter.shift = clocksource_counter.shift;
> -	timecounter_init(&timecounter, &cyclecounter,
> -			 arch_counter_get_cntvct());
> -
> -	/* 56 bits minimum, so we assume worst case rollover */
> -	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
> -
>  	if (arch_timer_use_virtual) {
>  		ppi = arch_timer_ppi[VIRT_PPI];
>  		err = request_percpu_irq(ppi, arch_timer_handler_virt,
