From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 24 Feb 2016 18:13:08 +0100
Subject: [PATCH v2] clocksource: atmel-pit: register as a sched_clock
In-Reply-To: <CAGkQfmPpyhU025nt+tcnsjWK3V+K3_7oiXxeqa7mPuHT08sLig@mail.gmail.com>
References: <1456329882-20709-1-git-send-email-romain.izard.pro@gmail.com>
 <20160224162046.GA28743@finsecur.com>
 <CAGkQfmPpyhU025nt+tcnsjWK3V+K3_7oiXxeqa7mPuHT08sLig@mail.gmail.com>
Message-ID: <56CDE4A4.7080508@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 24/02/2016 17:44, Romain Izard a ?crit :
> 2016-02-24 17:20 GMT+01:00 Sylvain Rochet <sylvain.rochet@finsecur.com>:
>> Hi,
>>
>> On Wed, Feb 24, 2016 at 05:04:42PM +0100, Romain Izard wrote:
>>> Register the counter of the Periodic Interval Timer as a possible
>>> source for sched_clock. Keep the timer running even if the related
>>> clockevent is disabled.
>>>
>>> This provides a better precision than the jiffies-based default. The
>>> TCB clocksource does not work, as it is registered too late in the
>>> initialization sequence.
>>
>> I have mixed feelings about that, but this is probably just a
>> misunderstanding from my part.
>>
> My goal is to get a better precision on my printk and trace logs,
> because the precision of jiffies is really very bad compared to
> everything else I have encountered until now. But it looks like reading
> a timer is quite complicated on AT91...
> 
>> The PIT timer should not be used for systems with PM_SUSPEND enabled
>> and used because it takes ages to synchronize on resume, how does this
>> patch affect that ?
>>
>> Ref: commit ac34ad27fc ("clockevents: Do not suspend/resume if
>> unused")
> 
> So your advice would be to stay clear of the PIT, because it is
> (globally) useless.
> 
> I'll keep it in mind.

I tend to think like this as well.

I would like to simplify our timer handling on AT91 and stick with TC
for this purpose.
It has de disadvantage of being obliged to use a TC(block) for
clockevent/clocksource and loose it if we want to do something else with
it but I do think that it's worth it.

If you want a modified TC driver that registers sched_clock, we can
provide you one as a workaround before that we rework the TC driver
completely. It has it's own flaws (like re-using a compatible string or
preventing the use of the "tclib") but is certainly handy.

Bye,
-- 
Nicolas Ferre
