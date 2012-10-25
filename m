From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 25 Oct 2012 07:33:37 -0500
Subject: [PATCH V3 1/5] ARM: dts: OMAP: Add timer nodes
In-Reply-To: <50892E27.7070102@ti.com>
References: <1350496873-21337-1-git-send-email-jon-hunter@ti.com>
 <1350496873-21337-2-git-send-email-jon-hunter@ti.com>
 <79CD15C6BA57404B839C016229A409A83EB49C1B@DBDE01.ent.ti.com>
 <50887315.2000509@ti.com>
 <79CD15C6BA57404B839C016229A409A83EB4A768@DBDE01.ent.ti.com>
 <50892E27.7070102@ti.com>
Message-ID: <508931A1.50608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/25/2012 07:18 AM, Jon Hunter wrote:

...

>> @@ -113,6 +114,9 @@ static int omap_timer_interrupt_test(struct omap_dm_timer *gptimer)
>>
>>         irq_data.gptimer = gptimer;
>>         init_completion(&irq_data.complete);
>> +
>> +       omap_dm_timer_enable(gptimer);
>> +
>>         omap_dm_timer_set_int_enable(gptimer, OMAP_TIMER_INT_OVERFLOW);
>>         omap_dm_timer_set_load_start(gptimer, 0, 0xffffff00);
>>
>> @@ -128,6 +132,8 @@ static int omap_timer_interrupt_test(struct omap_dm_timer *gptimer)
>>
>>         omap_dm_timer_stop(gptimer);
>>         omap_dm_timer_set_int_enable(gptimer, 0);
>> +       omap_dm_timer_disable(gptimer);
>> +
> 
> Hmmm ... I am wondering if there is another bug lingering in the dmtimer
> driver. Ideally, the context should be preserved by the driver.

Looking at omap_dm_timer_set_load_start() we have the following code to
restore context ...

if (!(timer->capability & OMAP_TIMER_ALWON)) {
	if (omap_pm_get_dev_context_loss_count(&timer->pdev->dev) !=
			timer->ctx_loss_count)		
		omap_timer_restore_context(timer);
}

Can you see if this is getting called for AM33xx for the failing timers?
If not then it would suggest that we are not detecting context loss
correctly and not restoring the context. With the above context restore
code we should not need those extra omap_dm_timer_enable/disable calls.

Cheers
Jon
