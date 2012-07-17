From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 17 Jul 2012 12:41:04 -0400
Subject: [RFC PATCH 2/4] ARM: arch_timers: register a time/cycle counter
In-Reply-To: <1341566422-20368-3-git-send-email-marc.zyngier@arm.com>
References: <1341566422-20368-1-git-send-email-marc.zyngier@arm.com>
 <1341566422-20368-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <500595A0.8020302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 07/06/2012 05:20 AM, Marc Zyngier wrote:
> Some subsystems (KVM for example) need access to a cycle counter.
> In the KVM case, this is used to measure the time delta between
> host and guest in order to accurately generate timer events for
> the guest.

[...]

> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
> index 54599e9..2b5da66 100644
> --- a/arch/arm/kernel/arch_timer.c
> +++ b/arch/arm/kernel/arch_timer.c
> @@ -318,6 +318,15 @@ static cycle_t arch_counter_read(struct clocksource *cs)
>  	return arch_counter_get_cntpct();
>  }
>  
> +static cycle_t arch_counter_read_cc(const struct cyclecounter *cc)
> +{
> +	/*
> +	 * Always use the physical counter for the clocksource.
> +	 * CNTHCTL.PL1PCTEN must be set to 1.
> +	 */
> +	return arch_counter_get_cntpct();
> +}

Why not just provide a wrapper around arch_timer_counter_read()? Will a
guest OS never need or want to use the cyclecounter (and clocksource for
that matter) interface?

> +
>  static struct clocksource clocksource_counter = {
>  	.name	= "arch_sys_counter",
>  	.rating	= 400,
> @@ -326,6 +335,18 @@ static struct clocksource clocksource_counter = {
>  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
>  };
>  
> +static struct cyclecounter cyclecounter = {
> +	.read	= arch_counter_read_cc,
> +	.mask	= CLOCKSOURCE_MASK(56),
> +};
> +
> +static struct timecounter timecounter;
> +
> +struct timecounter *arch_timer_get_timecounter(void)
> +{
> +	return &timecounter;
> +}
> +
>  static void __cpuinit arch_timer_stop(struct clock_event_device *clk)
>  {
>  	int i;

[...]

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
