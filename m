From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 03 Jul 2015 10:59:36 +0200
Subject: [PATCH 41/41] clocksource: zevio: Migrate to new 'set-state'
 interface
In-Reply-To: <20150703085619.GD23297@linux>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <2492473d6bb8f057af389d6db24af77462af2468.1434622147.git.viresh.kumar@linaro.org>
 <55959B0F.5000306@linaro.org> <20150703085619.GD23297@linux>
Message-ID: <55964EF8.10308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2015 10:56 AM, Viresh Kumar wrote:
> On 02-07-15, 22:11, Daniel Lezcano wrote:
>> On 06/18/2015 12:54 PM, Viresh Kumar wrote:
>>> Migrate zevio driver to the new 'set-state' interface provided by
>>> clockevents core, the earlier 'set-mode' interface is marked obsolete
>>> now.
>>>
>>> This also enables us to implement callbacks for new states of clockevent
>>> devices, for example: ONESHOT_STOPPED.
>>>
>>> Cc: Daniel Tang <dt.tangr@gmail.com>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>
>> [ ... ]
>>
>>>   static irqreturn_t zevio_timer_interrupt(int irq, void *dev_id)
>>> @@ -162,7 +158,9 @@ static int __init zevio_timer_add(struct device_node *node)
>>>   	if (timer->interrupt_regs && irqnr) {
>>>   		timer->clkevt.name		= timer->clockevent_name;
>>>   		timer->clkevt.set_next_event	= zevio_timer_set_event;
>>> -		timer->clkevt.set_mode		= zevio_timer_set_mode;
>>> +		timer->clkevt.set_state_shutdown = zevio_timer_shutdown;
>>> +		timer->clkevt.set_state_oneshot = zevio_timer_set_oneshot;
>>> +		timer->clkevt.tick_resume	= zevio_timer_set_oneshot;
>>
>> Why is tick_resume added here ?
>
> I am assuming you are lost because of reviewing too many similar
> patches, but anyway below was part of the diff and so resume was
> required :)

Ah, yeah. I missed the RESUME. Thanks.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
