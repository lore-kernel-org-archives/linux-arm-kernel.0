From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 13 Nov 2015 18:57:44 +0200
Subject: [PATCH] clocksource: arm_global_timer: fix suspend resume
In-Reply-To: <87a8qhq284.fsf@saruman.tx.rr.com>
References: <1447431951-23713-1-git-send-email-grygorii.strashko@ti.com>
 <87a8qhq284.fsf@saruman.tx.rr.com>
Message-ID: <56461688.1090809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2015 06:43 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>> Now the System stall is observed on TI AM437x based board
>> (am437x-gp-evm) during resuming from System suspend when ARM Global
>> timer is selected as clocksource device - SysRq are working, but
>> nothing else. The reason of stall is that ARM Global timer loses its
>> contexts.
>>
>> The reason of stall is that ARM Global timer loses its contexts during
>> System suspend:
>>     GT_CONTROL.TIMER_ENABLE = 0 (unbanked)
>>     GT_COUNTERx = 0
>>
>> Hence, update ARM Global timer driver to reflect above behaviour
>> - save GT_CONTROL.TIMER_ENABLE during suspend and restore on resume;
>> - ensure clocksource and clockevent devices have coresponding flags
>>    (CLOCK_SOURCE_SUSPEND_NONSTOP and CLOCK_EVT_FEAT_C3STOP) set
>>    depending on presence of "always-on" DT property.
>>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/clocksource/arm_global_timer.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
>> index a2cb6fa..1bbaf64 100644
>> --- a/drivers/clocksource/arm_global_timer.c
>> +++ b/drivers/clocksource/arm_global_timer.c
>> @@ -51,6 +51,8 @@ static void __iomem *gt_base;
>>   static unsigned long gt_clk_rate;
>>   static int gt_ppi;
>>   static struct clock_event_device __percpu *gt_evt;
>> +static bool gt_always_on;
>> +static u32 gt_control;
>>   
>>   /*
>>    * To get the value from the Global Timer Counter register proceed as follows:
>> @@ -168,6 +170,9 @@ static int gt_clockevents_init(struct clock_event_device *clk)
>>   {
>>   	int cpu = smp_processor_id();
>>   
>> +	if (!gt_always_on)
>> +		clk->features |= CLOCK_EVT_FEAT_C3STOP;
>> +
>>   	clk->name = "arm_global_timer";
>>   	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
>>   		CLOCK_EVT_FEAT_PERCPU;
>> @@ -195,12 +200,25 @@ static cycle_t gt_clocksource_read(struct clocksource *cs)
>>   	return gt_counter_read();
>>   }
>>   
>> +static void gt_suspend(struct clocksource *cs)
>> +{
>> +	gt_control = readl(gt_base + GT_CONTROL);
>> +}
>> +
>> +static void gt_resume(struct clocksource *cs)
>> +{
>> +	/* enables timer on all the cores */
>> +	writel(gt_control & GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
> 
> do you really need to save context if all you restore is TIMER_ENABLE
> bit ? seems like you could skip gt_suspend altogether. Is there really a
> situation where this driver is running and GT isn't enabled ?

Now It's not. It's always enabled. I did it because .suspend() is called for
all registered clock sources regardless of their usage. So, potentially
in the future, at the moment when .suspend() is called it might be disabled
(for example, .enable/disable() callbacks can be added and, if ARM Global timer
will not be registered as sched_clock, it will be possible to keep it disabled 
if not used now).

But It's not essentially now - I can update it and drop save restore. 
Pls, confirm.

-- 
regards,
-grygorii
