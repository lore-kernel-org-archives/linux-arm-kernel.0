From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Jan 2013 15:41:42 -0700
Subject: [v2 5/9] clocksource: tegra: Enable ARM arch_timer with TSC
In-Reply-To: <50EC444B.5060206@arm.com>
References: <1357649263-1098-1-git-send-email-hdoyu@nvidia.com>
 <1357649263-1098-6-git-send-email-hdoyu@nvidia.com>
 <50EC444B.5060206@arm.com>
Message-ID: <50ECA0A6.4090307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2013 09:07 AM, Marc Zyngier wrote:
> On 08/01/13 12:47, Hiroshi Doyu wrote:
>> Add platform enabler for ARM arch_timer(TSC). TSC is more fine grained
>> timer than TMR0. If it's available, it will be used for clock source
>> and sched_clock. Otherwise, TMR0 is used. In any case TMR0 is
>> necessary for clock event.

>> diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c

>> +/* FIXME: only secure mode is supported. */
> 
> And this is a bug, as far as I'm concerned.
> 
>> +static int tegra_arch_timer_init(void)

>> +	clk = clk_get_sys("clk_m", NULL);
>> +	if (IS_ERR(clk)) {
>> +		freq = 12000000;
>> +		pr_warn("Unable to get timer clock. Assuming 12Mhz input clock.\n");
>> +	} else {
>> +		freq = clk_get_rate(clk);
>> +		clk_put(clk);
>> +	}
>> +	writel_relaxed(freq, tsc_base + TSC_CNTFID0);
>> +
>> +	/* CNTFRQ */
>> +	asm("mcr p15, 0, %0, c14, c0, 0\n" : : "r" (freq));
>> +	asm("mrc p15, 0, %0, c14, c0, 0\n" : "=r" (val));
>> +	BUG_ON(val != freq);
> 
> No, not again! Like I said last year, this won't fly. So instead of
> trying to work around a broken firmware, let's do the right thing.

OK, so I understand you want to firmware/bootloader/... to write the
value into that register instead, so this all works in non-secure mode
(which sounds like a fine objection), but ...

>> +
>> +	val = readl_relaxed(tsc_base + TSC_CNTCR);
>> +	val |= TSC_CNTCR_ENABLE | TSC_CNTCR_HDBG;
>> +	writel_relaxed(val, tsc_base + TSC_CNTCR);
>> +
>> +	err = arch_timer_of_register();
> 
> What about adding an optional property to the binding, pointing to the
> required clock? That would solve the above problem in a sensible way,
> and your kernel wouldn't go bust.

... I'm not sure how the comment about adding a clock to the DT binding
is related to that. Sorry for not following the plot!
