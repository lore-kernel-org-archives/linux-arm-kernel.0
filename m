From: csd@broadcom.com (Christian Daudt)
Date: Wed, 05 Dec 2012 01:02:38 -0800
Subject: [PATCH] ARM: bcm281xx: Add timer driver
In-Reply-To: <50BEB77F.10303@wwwdotorg.org>
References: <1354593324-21300-1-git-send-email-csd@broadcom.com>
 <50BEB77F.10303@wwwdotorg.org>
Message-ID: <50BF0DAE.6000202@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-12-04 06:54 PM, Stephen Warren wrote:
> On 12/03/2012 08:55 PM, Christian Daudt wrote:
>> This adds support for the Broadcom timer, used in the following SoCs:
>> BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
>>
>> This patch needs the arm-soc/soc/next branch
> I assume this is being applied for 3.9, so it'll want to be rebased on
> the struct sys_timer removal, which I hope to get into linux-next very
> early after 3.8-rc1.
Not sure at this point - from my point of view earlier is always better 
so if it makes it to 3.8 that's fine by me. But ultimately whatever 
makes sense is fine by me so if 3.8 is not appropriate then 3.9 it is.

>
>> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
>> +	timer at 35006000 {
>> +		compatible = "bcm,kona-timer";
> Is there DT binding documentation for this?
I'll add one
> I'm slightly worried about "kona". Is it a well-known name outside
> Broadcom for this HW block? If it really is the name though, it's fine I
> guess, since it's within the "bcm," name-space here.
Some of these konas slip by :) This is an internal name, but I don't 
need to use it here. I'll change this to "bcm,bcm-timer"

>> diff --git a/drivers/clocksource/bcm_timer.c b/drivers/clocksource/bcm_timer.c
> Is this timer HW used in every Broadcom chip? I wonder if the file
> shouldn't be named bcm_kona_timer.c to allow co-existence with any others.
I'm sure it is not used in every Broadcom chip, but it is used in the 
ones I'm upstreaming at this point. I can always rename it if it turns 
out that this is no longer the only one, can't I ? I have been 
struggling a bit with when to use just "bcm" for name, and when to use 
something else. Internally we've used kona (and a number of other 
internal only names) but I've been trying to scrub these out of the code 
going to upstream, as the internal names are meaningless. But then I end 
up with no name in some cases, and I don't know that that is more 
helpful than the meaningless name...

>> +struct bcm_timers {
>> +	int tmr_irq;
>> +	void __iomem *tmr_regs;
>> +};
>> +
>> +struct bcm_timers timers;
> Should that be static?
changed.
>
>> +/* We use the peripheral timers for system tick, the cpu global timer for
>> + * profile tick
>> + */
> I think it's usual to leave the /* line empty, so that would be:
>
>> +/*
>> + * We use the peripheral timers for system tick, the cpu global timer for
>> + * profile tick
>> + */
changed.
>> +static void timer_disable_and_clear(void __iomem *base)
>> +	reg = 0;
>> +
>> +	/* Clear compare (0) interrupt */
>> +	reg |= 1 << KONA_GPTIMER_STCS_TIMER_MATCH_SHIFT;
>> +	/* disable compare */
>> +	reg &= ~(1 << KONA_GPTIMER_STCS_COMPARE_ENABLE_SHIFT);
> That bit isn't set anywhere; is there a need to clear it; should "reg =
> 0" above be a readl() of the register?
yes, that is missing. I'll add it.
>> +static void
>> +timer_get_counter(void *timer_base, uint32_t *msw, uint32_t *lsw)
>> +	while (1) {
>> +		*msw = readl(base + KONA_GPTIMER_STCHI_OFFSET);
>> +		*lsw = readl(base + KONA_GPTIMER_STCLO_OFFSET);
>> +		if (*msw == readl(base + KONA_GPTIMER_STCHI_OFFSET))
>> +			break;
>> +	}
> I guess it's very unlikely, but should there be a limit to the loop
> count here, or a diagnostic if it runs too long?
I'll add a pr_err if it runs too many times. That should never happen.
>> +static void __init timer_clockevents_init(void)
> Can this function use clockevents_config_and_register() to avoid a bunch
> of the manual calculations and assignments?
I'll take a look whether it can or not.
>
>> diff --git a/drivers/clocksource/bcm_timer.h b/drivers/clocksource/bcm_timer.h
> You may as well move these definitions into the .c file since they don't
> need to be public?
agreed.


  Thanks,
    csd
