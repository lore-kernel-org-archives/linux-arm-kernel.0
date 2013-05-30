From: john.stultz@linaro.org (John Stultz)
Date: Thu, 30 May 2013 09:11:17 -0700
Subject: [RFC PATCH 2/2] clocksource: dw_apb: allow build for architectures
 other than arm
In-Reply-To: <20130530053233.GL25186@sapphire.tkos.co.il>
References: <1369570367-994-2-git-send-email-baruch@tkos.co.il>
 <51A51271.2070506@linaro.org> <20130530053233.GL25186@sapphire.tkos.co.il>
Message-ID: <51A77A25.8080306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2013 10:32 PM, Baruch Siach wrote:
> Hi John,
>
> On Tue, May 28, 2013 at 01:24:17PM -0700, John Stultz wrote:
>> On 05/26/2013 05:12 AM, Baruch Siach wrote:
>>>   static const struct of_device_id osctimer_ids[] __initconst = {
>>> @@ -124,3 +135,10 @@ void __init dw_apb_timer_init(void)
>>>   	init_sched_clock();
>>>   }
>>> +
>>> +#ifndef CONFIG_HAVE_SETUP_SCHED_CLOCK
>>> +unsigned long long notrace sched_clock()
>>> +{
>>> +	return read_sched_clock() * sched_clock_mult;
>>> +}
>>> +#endif
>> Also, can you try to condense the number of #ifndef
>> CONFIG_HAVE_SETUP_SCHED_CLOCK checks to one, and consolidate the
>> needed functions all in that one conditional?
> Thanks for your comments. I'll rework the patch and resubmit.
>
> I've just noticed that I have a bigger problem. read_sched_clock() returns
> u32, not u64. This means that in a rate of, say, 100MHz it will wrap around
> after a little more than 40 seconds. Would it make sense to put ARM's 32 bin
> sched_clock extension code (arch/arm/kernel/sched_clock.c) is a common place
> (maybe drivers/clocksource), and use that? There seems to be nothing ARM
> specific in this code, after all.

Yea, working out an actual generic sched_clock implementation is 
something I'd like to see done.

Though I'd really rather we not toss yet another chunk of infrastructure 
in the drivers/clocksource directory. Instead we should probably have a 
kernel/time/sched_clock.c.

Then its just the issue of tying that and the clocksource code together 
so you just register existing capable clocksources with a SCHED_CLOCK 
flag or via a different registration hook.

I don't think it will be an easy job, but if you want to give it a shot, 
I'd be quite interested in reviewing the patches!

thanks
-john
