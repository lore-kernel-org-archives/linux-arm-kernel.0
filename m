From: j-keerthy@ti.com (Keerthy)
Date: Fri, 18 May 2018 11:27:50 +0530
Subject: [PATCH 2/4] omap2: clockdomain: Inroduce cpu_pm notifiers for
 context save/restore
In-Reply-To: <20180517214347.GR98604@atomide.com>
References: <1526483821-25585-1-git-send-email-j-keerthy@ti.com>
 <1526483821-25585-3-git-send-email-j-keerthy@ti.com>
 <20180517214347.GR98604@atomide.com>
Message-ID: <18c013bb-4f3b-81af-f565-825513e2b501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 18 May 2018 03:13 AM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [180516 15:21]:
>> Inroduce cpu_pm notifiers for context save/restore. This will be
>> needed for am43xx family in case of rtc only mode with ddr in
>> self-refresh.
> ...
>> +static int cpu_notifier(struct notifier_block *nb, unsigned long cmd, void *v)
>> +{
>> +	switch (cmd) {
>> +	case CPU_CLUSTER_PM_ENTER:
>> +		if (enable_off_mode)
>> +			clkdm_save_context();
>> +		break;
>> +	case CPU_CLUSTER_PM_EXIT:
>> +		if (enable_off_mode)
>> +			clkdm_restore_context();
>> +		break;
>> +	}
>> +
>> +	return NOTIFY_OK;
>> +}
> 
> Can you do this too only on suspend instead of the cpu notifier?
> If you need to call this eventually from cpuidle also then yeah
> the notifier makes sense.

Clockdomain under omap2 does not have suspend/resume calls as its still
not a driver. The initial version of this patch had save/restore calls
directly from pm33xx-core during suspend/resume platform ops are called.

Are you suggesting that?

> 
> Regards,
> 
> Tony
> 
