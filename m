From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 04 Apr 2013 13:06:51 +0200
Subject: [PATCH v2 12/13] ARM: move sp804 and integrator timers to
 drivers/clocksource
In-Reply-To: <CACRpkdb0B1iZrTYuD=3d86_ipSfa23msm-sjanDWQarotHEqZA@mail.gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
 <1364854883-5961-13-git-send-email-robherring2@gmail.com>
 <515A179A.8020800@linaro.org> <515B3637.8090603@gmail.com>
 <CACRpkdb0B1iZrTYuD=3d86_ipSfa23msm-sjanDWQarotHEqZA@mail.gmail.com>
Message-ID: <515D5ECB.5070509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 06:52 PM, Linus Walleij wrote:
> On Tue, Apr 2, 2013 at 9:49 PM, Rob Herring <robherring2@gmail.com> wrote:
>> On 04/01/2013 06:26 PM, John Stultz wrote:
> 
>>> So, most of the code here is really clockevent code and not clocksource
>>> code. I realize they were combined in the mach directory you're copying
>>> them from, but if we're going to move all this code out of the arch
>>> directory and into drivers/, I'd like to propose we not dump it all into
>>> drivers/clocksource.
>>
>> Arguably, half the h/w is used for clocksource and half for clockevent
>> so it is equal. :) The sp804 and integrator are somewhat separated that
>> carving them up may be possible, but there are examples like i.MX timers
>> where the implementations are tied more closely together (the clockevent
>> compare value is the clocksource counter + delta).
>>
>> Where do I put the init functions which need to know about both?
>>
>> What about all the other timers that are already in drivers/clocksource?
> 
> The other day I thought about this because I remembered discussing
> it with John, and thinking about how some drivers (like ours) combine
> clock source, clock event, sched_clock() hook and delay timers. The
> same hardware is incidentally used for all four.
> 
> Driver writers really like to think about a driver pertaining to a certain
> memory segment in the hardware, and that's causing some strain
> here and there in the kernel.
> 
> Anyway, I was thinking that the four classes of drivers were somehow
> related but not the same thing.
> 
> So what about renaming
> drivers/clocksource -> drivers/timer
> 
> Then create a subdirectory drivers/timer/clocksource
> for the pure clocksource code and any drivers falling into that
> category.
> 
> Thus drivers/timer/clockevent, drivers/timer/schedclock
> and drivers/timer/delay can be created to handle specialized
> hardware blocks.
> 
> But the best thing with that scheme would be that combined
> drivers doing several things at once could live directly in
> drivers/timer/* and not pollute drivers/clocksource.

That looks reasonable.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
