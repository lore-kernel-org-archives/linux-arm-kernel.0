From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 18 May 2018 11:38:33 +0300
Subject: [PATCH 2/4] omap2: clockdomain: Inroduce cpu_pm notifiers for
 context save/restore
In-Reply-To: <18c013bb-4f3b-81af-f565-825513e2b501@ti.com>
References: <1526483821-25585-1-git-send-email-j-keerthy@ti.com>
 <1526483821-25585-3-git-send-email-j-keerthy@ti.com>
 <20180517214347.GR98604@atomide.com>
 <18c013bb-4f3b-81af-f565-825513e2b501@ti.com>
Message-ID: <14b0d567-f0cb-72bb-2efc-b21788d9993d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/18 08:57, Keerthy wrote:
> 
> 
> On Friday 18 May 2018 03:13 AM, Tony Lindgren wrote:
>> * Keerthy <j-keerthy@ti.com> [180516 15:21]:
>>> Inroduce cpu_pm notifiers for context save/restore. This will be
>>> needed for am43xx family in case of rtc only mode with ddr in
>>> self-refresh.
>> ...
>>> +static int cpu_notifier(struct notifier_block *nb, unsigned long cmd, void *v)
>>> +{
>>> +	switch (cmd) {
>>> +	case CPU_CLUSTER_PM_ENTER:
>>> +		if (enable_off_mode)
>>> +			clkdm_save_context();
>>> +		break;
>>> +	case CPU_CLUSTER_PM_EXIT:
>>> +		if (enable_off_mode)
>>> +			clkdm_restore_context();
>>> +		break;
>>> +	}
>>> +
>>> +	return NOTIFY_OK;
>>> +}
>>
>> Can you do this too only on suspend instead of the cpu notifier?
>> If you need to call this eventually from cpuidle also then yeah
>> the notifier makes sense.
> 
> Clockdomain under omap2 does not have suspend/resume calls as its still
> not a driver. The initial version of this patch had save/restore calls
> directly from pm33xx-core during suspend/resume platform ops are called.
> 
> Are you suggesting that?

I think using cpu notifiers would help in eventual transition of this 
under drivers also, as this doesn't need any custom interfaces to be 
exported around. And, as it seems now, this is only needed for AM43xx at 
the moment, no other SoCs need this for any purpose, even if device off 
would be implemented. Only exception would be if we want to implement 
RTC+DDR sort of functionality on any other SoC.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
