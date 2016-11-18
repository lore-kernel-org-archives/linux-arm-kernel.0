From: slash.tmp@free.fr (Mason)
Date: Fri, 18 Nov 2016 15:18:58 +0100
Subject: [PATCH] arm: spin one more cycle in timer-based delays
In-Reply-To: <20161118125409.GK1041@n2100.armlinux.org.uk>
References: <582B0F61.6030903@free.fr> <20161118120630.GJ13470@arm.com>
 <20161118125409.GK1041@n2100.armlinux.org.uk>
Message-ID: <582F0DD2.3030805@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/11/2016 13:54, Russell King - ARM Linux wrote:
> On Fri, Nov 18, 2016 at 12:06:30PM +0000, Will Deacon wrote:
>> On Tue, Nov 15, 2016 at 02:36:33PM +0100, Mason wrote:
>>> When polling a tick counter in a busy loop, one might sample the
>>> counter just *before* it is updated, and then again just *after*
>>> it is updated. In that case, while mathematically v2-v1 equals 1,
>>> only epsilon has really passed.
>>>
>>> So, if a caller requests an N-cycle delay, we spin until v2-v1
>>> is strictly greater than N to avoid these random corner cases.
>>>
>>> Signed-off-by: Mason <slash.tmp@free.fr>
>>> ---
>>>  arch/arm/lib/delay.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
>>> index 69aad80a3af4..3f1cd15ca102 100644
>>> --- a/arch/arm/lib/delay.c
>>> +++ b/arch/arm/lib/delay.c
>>> @@ -60,7 +60,7 @@ static void __timer_delay(unsigned long cycles)
>>>  {
>>>  	cycles_t start = get_cycles();
>>>  
>>> -	while ((get_cycles() - start) < cycles)
>>> +	while ((get_cycles() - start) <= cycles)
>>>  		cpu_relax();
>>>  }
>>
>> I thought a bit about this last night. It is well known that the delay
>> routines are not guaranteed to be accurate, and I don't *think* that's
>> limited to over-spinning, so arguably this isn't a bug. However, taking
>> the approach that "drivers should figure it out" is also unhelpful,
>> because the frequency of the underlying counter isn't generally known
>> and so drivers can't simply adjust the delay parameter.
> 
> I don't think this change makes any sense whatsoever.  udelay() is
> inaccurate, period.  It _will_ give delays shorter than requested
> for many reasons, many of which can't be fixed.

If I understand correctly, udelay is, in fact, a wrapper around
several possible implementations. (Run-time decision on arch/arm)

1) The "historical" software loop-based method, which is calibrated
during init.

2) A hardware solution, based on an actual timer, ticking away
at a constant frequency.

3) others?

Solution 1 (which probably dates back to Linux 0.1) suffers from
the inaccuracies you point out, because of interrupt latency
during calibration, DVFS, etc.

On the other hand, it is simple enough to implement solution 2
in a way that guarantees that spin_for_n_cycles(n) spins
/at least/ for n cycles.

On platforms using timer-based delays, there can indeed exist
a function guaranteeing a minimal delay.


> Having a super-accurate version just encourages people to write broken
> drivers which assume (eg) that udelay(10) will give _at least_ a 10us
> delay.  However, there is no such guarantee.

You say that calling udelay(10) expecting at least 10 ?s is broken.
This fails the principle of least astonishment in a pretty big way.
(If it returns after 9.9 ?s, I suppose it could be OK. But for
shorter delays, the relative error grows.)

A lot of drivers implement a spec that says
"do this, wait 1 ?s, do that".

Driver writers would typically write
do_this(); udelay(1); do_that();

Do you suggest they should write udelay(2); ?
But then, it's not so easy to follow the spec because everything
has been translated to a different number.
Hide everything behind a macro?

Note that people have been using ndelay too.
(I count 182 in drivers, 288 overall.)

drivers/cpufreq/s3c2440-cpufreq.c:      ndelay(20);

I don't think the author expects this to return immediately.


> So, having udelay() for timers return slightly short is actually a good
> thing - it causes people not to make the mistake to be soo accurate
> with their delay specifications.

I disagree that having an implementation which introduces
hard-to-track-down random heisenbugs is a good thing.


> So, NAK on this change.  udelay is not super-accurate.

usleep_range() fixed this issue recently.
6c5e9059692567740a4ee51530dffe51a4b9584d
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=timers/core&id=6c5e9059692567740a4ee51530dffe51a4b9584d

Do you suggest driver writers should use usleep_range()
instead of udelay?
(When does usleep_range start making sense? Around 50/100 ?s
and above?)

> Reference (and this is the most important one):
> 
>   http://lists.openwall.net/linux-kernel/2011/01/12/372


Regards.
