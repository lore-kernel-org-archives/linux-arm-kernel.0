From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 07 Feb 2013 09:49:51 -0700
Subject: [PATCHv3 4/4] arm: Add generic timer broadcast support
In-Reply-To: <20130207100403.GD16987@e106331-lin.cambridge.arm.com>
References: <1358183124-28461-1-git-send-email-mark.rutland@arm.com>
 <1358183124-28461-5-git-send-email-mark.rutland@arm.com>
 <5112C25F.6000508@wwwdotorg.org>
 <20130207100403.GD16987@e106331-lin.cambridge.arm.com>
Message-ID: <5113DB2F.9090606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2013 03:04 AM, Mark Rutland wrote:
> Hi Stephen,
> 
> Sorry about this; I'm to blame for the bug.
> 
> On Wed, Feb 06, 2013 at 08:51:43PM +0000, Stephen Warren wrote:
>> On 01/14/2013 10:05 AM, Mark Rutland wrote:
>>> Implement timer_broadcast for the arm architecture, allowing for the use
>>> of clock_event_device_drivers decoupled from the timer tick broadcast
>>> mechanism.
>>
>> Mark, this patch is now in next-20130206 and causes a crash during boot
>> on Tegra. The reason appears to be because of:
>>
>>> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
>>
>>> @@ -524,7 +524,6 @@ static void __cpuinit percpu_timer_setup(void)
>>>  	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
>>>  
>>>  	evt->cpumask = cpumask_of(cpu);
>>> -	evt->broadcast = smp_timer_broadcast;
>>
>> After that change, evt->broadcast is never assigned, and hence is NULL.
>> Yet elsewhere in kernel/time/tick-broadcast.c it's used unconditionally:
>>
>> static void tick_do_broadcast(struct cpumask *mask)
>> ...
>> 	if (!cpumask_empty(mask)) {
>> ...
>> 		td = &per_cpu(tick_cpu_device, cpumask_first(mask));
>> 		td->evtdev->broadcast(mask);
>>
>> Now perhaps the Tegra timer driver simply isn't being set up correctly,
>> so the bug is there... But the only other place I can find where
>> ->broadcast is assigned is in tick_device_uses_broadcast() which only
>> does it for "non-functional" timers, which doesn't apply to Tegra's timer.
>>
> 
> The intent of 12ad100046: "clockevents: Add generic timer broadcast function"
> was to setup the broadcast function both for non-functional/dummy timers and
> those that stop in low-power states (CLOCK_EVT_FEAT_C3STOP). I missed the
> CLOCK_EVT_FEAT_C3STOP case.
> 
> I believe the patch below will fix this for Tegra and any other platforms where
> broadcast is required in low power states.
> 
> Stephen, could you test this for Tegra?

Tested-by: Stephen Warren <swarren@nvidia.com>

Thanks.
