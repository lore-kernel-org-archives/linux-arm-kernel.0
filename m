From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 16 Jan 2014 10:49:04 +0530
Subject: [PATCH] arch_timer: Move delay timer to drivers clocksource
In-Reply-To: <20140115154526.GC3571@mudshark.cambridge.arm.com>
References: <1389791227-24097-1-git-send-email-pgaikwad@nvidia.com>
 <20140115154526.GC3571@mudshark.cambridge.arm.com>
Message-ID: <52D76BC8.6080405@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 January 2014 09:15 PM, Will Deacon wrote:
> Hello,
>
> On Wed, Jan 15, 2014 at 01:07:07PM +0000, Prashant Gaikwad wrote:
>> Now arch timer is registerd using generic sched timer, delay
>> timer registration is the only part remaining in arch ports.
>> Move this part to drivers clocksource and remove arch timer
>> from arch ports.
> What's the advantage in doing this? I'd have thought consolidation, but...

Primary objective of doing this to use other timers on SoC instead of 
arch timers. It is observed that on ARM implementations of ARMv8 
architecture context of per CPU logic of arch timer is not preserved 
when CPU is powered down and reset is held during powerdown.

This makes arch timers unusable as wake events for some CPU idle states 
where CPU core is powered down.

So we have two options:
1. Use system timers as broadcast timers and save/restore arch timers 
context actross these CPU idle states.
2. Disable arch timer and use system timers.

This patch will help to implement 2nd option.

>> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
>> ---
>>   arch/arm/include/asm/arch_timer.h    |    1 -
>>   arch/arm/kernel/Makefile             |    1 -
>>   arch/arm/kernel/arch_timer.c         |   44 ----------------------------------
>>   arch/arm64/include/asm/arch_timer.h  |    5 ----
>>   arch/arm64/include/asm/delay.h       |   32 ++++++++++++++++++++++++
>>   arch/arm64/include/asm/timex.h       |    5 +--
>>   arch/arm64/kernel/time.c             |    9 -------
>>   arch/arm64/lib/delay.c               |   26 ++++++++++++++++++++
>>   drivers/clocksource/arm_arch_timer.c |   12 ++++++++-
>>   9 files changed, 71 insertions(+), 64 deletions(-)
> ... that's a positive diffstat! I also think that delaying the delay loop
> initialisation for arm64 could be problematic, since we don't have anything
> to fall back on (like the busy-loop on ARM) in case of early *delay calls.
>
> What happens if I call udelay on arm64 before the counter has registered?

I will fix this in next patch. Do you have plan to add busy-loop for 
arm64? Or I will have to initialize read counter function early.

> Will
