From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 27 Apr 2016 16:31:05 +0300
Subject: [PATCH v1] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
In-Reply-To: <20160427104110.GU5783@n2100.arm.linux.org.uk>
References: <1461684532-16848-1-git-send-email-grygorii.strashko@ti.com>
 <20160426160245.GI28464@e106497-lin.cambridge.arm.com>
 <571FC2EC.9090605@ti.com> <20160427104110.GU5783@n2100.arm.linux.org.uk>
Message-ID: <5720BF19.6040600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 04/27/2016 01:41 PM, Russell King - ARM Linux wrote:
> On Tue, Apr 26, 2016 at 10:35:08PM +0300, Grygorii Strashko wrote:
>> On 04/26/2016 07:02 PM, Liviu Dudau wrote:
>>> Well, SoC-B has the GT *and* the DT node, so what is the problem with
>>> enabling it for SoC-B? If there are reasons not to use the Global Timer
>>> on SoC-B, surely a better option would be to mark it in DT with status = "disabled";
>>
>> This was rejected [2]. DT describes HW and if it is functional the status = "disabled"
>> is not good choice.
>> ARM GT can't be used as clocksource/sched_clock/clockevent when CPUFreq or
>> CPUIdle are enabled :(, and this is Linux specific functionality and
>> not HW description.
> 
> Sorry, but we don't want to have to disable drivers in the kernel just
> because one platform has a problem (consider the single zImage case
> where it may be required that the global timer is enabled for some
> platform to boot - it becomes mandatory in single zImage at that point.)

Sorry, but this patch doesn't disable anything. It provides possibility
to do a custom build with disabled ARM GT driver without Kernel code modification -
in my case RT-kernel and non-RT Kernel should run on same HW and 
RT kernel should use ARM GT as clocksource/sched_clock, but 
non-RT Kernel shouldn't.

I think RT can't be part of single zImage - it make no sense.

> 
> Maybe a linux-specific property is needed here - "linux,low-power-unstable"
> or something like that?
> 

I've tried smth. like this [1]

And it is not "unstable", it's will just stop in C3 (CPUIdle) and there no possibility 
(at least I've not found how to do this) to adjust Freq in case of CPUFreq.
[above is about clocksource/sched_clock]

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386858.html

Oh :(. And it's really hard (I even would say - crazy task) to select
proper clocksource/clockevent/sched_clock and timer_delay (opt, arm) 
when SoC provides few choices.

Last discussion:
https://lkml.org/lkml/2016/3/17/38

Prev discussions:
http://www.spinics.net/lists/arm-kernel/msg459803.html
http://www.spinics.net/lists/linux-omap/msg123658.html

-- 
regards,
-grygorii
