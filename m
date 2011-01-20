From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 20 Jan 2011 12:35:22 +0800
Subject: [PATCH] arm: fix oops in sched_clock_poll
In-Reply-To: <20110119165602.GA6335@n2100.arm.linux.org.uk>
References: <1295455641-4791-1-git-send-email-tom.leiming@gmail.com>
	<20110119165602.GA6335@n2100.arm.linux.org.uk>
Message-ID: <AANLkTik-cxbwZZ_PfuC8DKqyHSnUM+R56PNXJdrPqSCb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2011/1/20 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Jan 20, 2011 at 12:47:21AM +0800, tom.leiming at gmail.com wrote:
>> From: Ming Lei <tom.leiming@gmail.com>
>>
>> The patch fixes one oops in sched_clock_poll, tested on
>> beagle xm, follows the oops message:
>
>> diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
>> index 9a46370..782dd08 100644
>> --- a/arch/arm/kernel/sched_clock.c
>> +++ b/arch/arm/kernel/sched_clock.c
>> @@ -21,7 +21,9 @@ static void (*sched_clock_update_fn)(void);
>> ?static void sched_clock_poll(unsigned long wrap_ticks)
>> ?{
>> ? ? ? mod_timer(&sched_clock_timer, round_jiffies(jiffies + wrap_ticks));
>> - ? ? sched_clock_update_fn();
>> +
>> + ? ? if (sched_clock_update_fn)
>> + ? ? ? ? ? ? sched_clock_update_fn();
>
> It's called here because it's supposed to be initialized by the time this
> function is called. ?Please ensure that is the case.

On omap2,  sched_clock_update_fn is initialized in omap_init_clocksource_32k,
and certainly is after calling sched_clock_poll, so the oops is triggered.


thanks,
-- 
Lei Ming
