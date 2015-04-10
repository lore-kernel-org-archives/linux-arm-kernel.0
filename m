From: slash.tmp@free.fr (Mason)
Date: Fri, 10 Apr 2015 22:01:35 +0200
Subject: Guarantee udelay(N) spins at least N microseconds
In-Reply-To: <20150410160817.GH12732@n2100.arm.linux.org.uk>
References: <5527B331.5000205@free.fr>
 <20150410114415.GC12732@n2100.arm.linux.org.uk> <5527C501.2040808@free.fr>
 <20150410150607.GG12732@n2100.arm.linux.org.uk> <5527EC90.9050900@free.fr>
 <20150410160817.GH12732@n2100.arm.linux.org.uk>
Message-ID: <55282C1F.3000600@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2015 18:08, Russell King - ARM Linux wrote:
> On Fri, Apr 10, 2015 at 05:30:24PM +0200, Mason wrote:
>> I appreciate (very much so) that you spend time replying to me,
>> but I also sense a lot of animosity, and I don't know what I've
>> done wrong to deserve it :-(
> 
> I'm putting the point across strongly because I really don't think
> there is an issue to be solved here.
> 
>> On 10/04/2015 17:06, Russell King - ARM Linux wrote:
>>> And what this means is that udelay(n) where 'n' is less than the
>>> period between two timer interrupts /will/ be, and is /expected to
>>> be/ potentially shorter than the requested period.
>>
>> You've made it clear how loop-based delays are implemented; and also
>> that loop-based delays are typically 1% shorter than requested.
>> (Thanks for the overview, by the way.) Please note that I haven't
>> touched to the loop-based code, I'm only discussing the timer-based
>> code.
> 
> 1% is a figure I pulled out of the air.  It really depends on the CPU
> instructions per cycle, and how much work is being done in the timer
> interrupt handler.
> 
>>> There's no getting away from that, we can't estimate how long the timer
>>> interrupt takes to handle without the use of an external timer, and if
>>> we've got an external timer, we might as well use it for all delays.
>>
>> Exactly! And my patch only changes __timer_const_udelay() so again I'm
>> not touching loop-based code.
> 
> What I'm trying to get through to you is that udelay() as a _whole_ does
> not provide a guarantee that it will wait for _at least_ the time you
> asked for.  All that it does is provide an _approximate_ delay.

I've taken time to digest the information you provided.

Let's forget the subject of my message, i.e. trying to
guarantee udelay(N) spins at least N microseconds.

There is, however, an important difference between loop-based
delays and timer-based delays; CPU frequencies typically fall
in the 50-5000 MHz range, while timer frequencies typically
span tens of kHz up to hundreds of MHz. For example, 90 kHz
is sometimes provided in multimedia systems (MPEG TS).

And rounding down the cycle count becomes a real problem
with coarse timers. Consider the aforementioned 90 kHz
timer, i.e. T = 11.1 ?s

If a driver wants to spin for 5 ?s, and the author was
careful enough to double the number, for a safe cushion,
he'll request 10 ?s. But since 10 < 11.1, the request
gets rounded down to 0.

Therefore, I think timer-based loops should round up.

If you NAK the patch, that's OK. I'll drop the issue,
and only apply it locally.

Regards.

Patch provided for easier reference:

diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 312d43e..3cfbd07 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -66,7 +66,7 @@ static void __timer_const_udelay(unsigned long xloops)
  {
         unsigned long long loops = xloops;
         loops *= arm_delay_ops.ticks_per_jiffy;
-       __timer_delay(loops >> UDELAY_SHIFT);
+       __timer_delay((loops >> UDELAY_SHIFT) + 1);
  }
