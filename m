From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 14 Jun 2011 11:42:10 +0530
Subject: [PATCH] ARM: smp_twd: Reconfigure clockevents after cpufreq change
In-Reply-To: <BANLkTik8sz+JQE1nTcEvZLo5PynwK0+zZA@mail.gmail.com>
References: <1306919711-30965-1-git-send-email-linus.walleij@stericsson.com>	<BANLkTikEx0+SpwiWHqLNcs0oaLoN4LccHQ@mail.gmail.com>
	<BANLkTik8sz+JQE1nTcEvZLo5PynwK0+zZA@mail.gmail.com>
Message-ID: <4DF6FBBA.7010309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/14/2011 11:30 AM, Colin Cross wrote:
> On Mon, Jun 13, 2011 at 10:50 PM, Linus Walleij
> <linus.ml.walleij@gmail.com>  wrote:
>> Colin, Per Fransson noted this:
>>
>>> From: Colin Cross<ccross@android.com>
>>
>>> +/*
>>> + * Updates clockevent frequency when the cpu frequency changes.
>>> + * Called on the cpu that is changing frequency with interrupts disabled.
>>> + */
>>> +static void twd_update_frequency(void *data)
>>> +{
>>> +       twd_timer_rate = clk_get_rate(twd_clk);
>>> +
>>> +       clockevents_update_freq(__get_cpu_var(twd_ce), twd_timer_rate);
>>> +}
>>
>> Will only update the clockevent on the CPU where the cpufreq notifier
>> gets called will it not? It's not called on each CPU AFAICT.
>>
>> So this function has to traverse all CPUs in twd_ce.
>
> OMAP and Tegra both iterate through all the affected cpus in the
> cpufreq driver and call cpufreq_notify_transtion once for each,
> setting freqs.cpu to the target cpu.  The listener in the smp_twd
> driver then bounces through smp_call_function_single to make sure it
> is running on the affected cpu.  I believe that is the correct way to
> handle multiple affected cpus.
>
I agree with Collin. That should be taken care by
"smp_call_function_single(freqs->cpu, )" with notifier
being called with all the available CPU's in the mask.

Linus,
Did you see any issue with this patch on your platform ?

Regards
Santosh
