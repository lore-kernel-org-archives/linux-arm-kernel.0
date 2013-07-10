From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 10 Jul 2013 10:09:17 -0600
Subject: CPU hotplug issue w/ 0647065 clocksource: Add generic dummy timer
 driver
In-Reply-To: <20130709230528.GE830@codeaurora.org>
References: <51DAF895.1020700@wwwdotorg.org>
 <20130709005837.GC830@codeaurora.org> <51DC34AD.30009@wwwdotorg.org>
 <20130709163518.GD830@codeaurora.org> <51DC3FD2.9070308@wwwdotorg.org>
 <20130709230528.GE830@codeaurora.org>
Message-ID: <51DD872D.7020101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2013 05:05 PM, Stephen Boyd wrote:
> On 07/09, Stephen Warren wrote:
>> On 07/09/2013 10:35 AM, Stephen Boyd wrote:
>>> On 07/09, Stephen Warren wrote:
>>>> On 07/08/2013 06:58 PM, Stephen Boyd wrote:
>>>>> On 07/08, Stephen Warren wrote:
>>>>>> CPU hotplug (replug) on Tegra HW seems to be occasionally broken due to
>>>>>> commit 0647065 "clocksource: Add generic dummy timer driver" in
>>>>>> linux-next. Reverting that commit solves the issue.
...
> Can you try this patch?

That seems to work great, thanks! I successfully unpugged/replugged CPU1
about 200 times, whereas without the patch I'd usually see the problem
about 10% of replug attempts.

Tested-by: Stephen Warren <swarren@nvidia.com>

> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> index 6d3f916..218bcb5 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -157,7 +157,10 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
>  		dev->event_handler = tick_handle_periodic;
>  		tick_device_setup_broadcast_func(dev);
>  		cpumask_set_cpu(cpu, tick_broadcast_mask);
> -		tick_broadcast_start_periodic(bc);
> +		if (tick_broadcast_device.mode == TICKDEV_MODE_PERIODIC)
> +			tick_broadcast_start_periodic(bc);
> +		else
> +			tick_broadcast_setup_oneshot(bc);
>  		ret = 1;
>  	} else {
>  		/*
> 
