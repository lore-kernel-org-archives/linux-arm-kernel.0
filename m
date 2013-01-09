From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Jan 2013 23:40:49 -0700
Subject: [v2 5/9] clocksource: tegra: Enable ARM arch_timer with TSC
In-Reply-To: <20130109.080031.1063344100374199123.hdoyu@nvidia.com>
References: <1357649263-1098-6-git-send-email-hdoyu@nvidia.com><50EC444B.5060206@arm.com><50ECA0A6.4090307@wwwdotorg.org>
 <20130109.080031.1063344100374199123.hdoyu@nvidia.com>
Message-ID: <50ED10F1.30001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2013 11:00 PM, Hiroshi Doyu wrote:
> Stephen Warren <swarren@wwwdotorg.org> wrote @ Tue, 8 Jan 2013 23:41:42 +0100:
>> On 01/08/2013 09:07 AM, Marc Zyngier wrote:
>>> On 08/01/13 12:47, Hiroshi Doyu wrote:
>>>> Add platform enabler for ARM arch_timer(TSC). TSC is more fine grained
>>>> timer than TMR0. If it's available, it will be used for clock source
>>>> and sched_clock. Otherwise, TMR0 is used. In any case TMR0 is
>>>> necessary for clock event.
>>
>>>> diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
>>
>>>> +/* FIXME: only secure mode is supported. */
>>>
>>> And this is a bug, as far as I'm concerned.
>>>
>>>> +static int tegra_arch_timer_init(void)
>>
>>>> +	clk = clk_get_sys("clk_m", NULL);
>>>> +	if (IS_ERR(clk)) {
>>>> +		freq = 12000000;
>>>> +		pr_warn("Unable to get timer clock. Assuming 12Mhz input clock.\n");
>>>> +	} else {
>>>> +		freq = clk_get_rate(clk);
>>>> +		clk_put(clk);
>>>> +	}
>>>> +	writel_relaxed(freq, tsc_base + TSC_CNTFID0);
>>>> +
>>>> +	/* CNTFRQ */
>>>> +	asm("mcr p15, 0, %0, c14, c0, 0\n" : : "r" (freq));
>>>> +	asm("mrc p15, 0, %0, c14, c0, 0\n" : "=r" (val));
>>>> +	BUG_ON(val != freq);
>>>
>>> No, not again! Like I said last year, this won't fly. So instead of
>>> trying to work around a broken firmware, let's do the right thing.
>>
>> OK, so I understand you want to firmware/bootloader/... to write the
>> value into that register instead, so this all works in non-secure mode
>> (which sounds like a fine objection), but ...
> 
> If possible, I want to run kernel without bootloader initializing TSC
> . IOW, I want to allow legacy bootloaders to boot kernel with ARM arch
> timer.

Is it really hard to just fix the bootloader? Tegra114 is new enough,
and upstream support new enough, it should be fine to require a fixed
bootloader in order to run the upstream kernel even if we don't yet do
this right in the downstream kernels.
