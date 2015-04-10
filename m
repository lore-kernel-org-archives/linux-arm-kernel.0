From: slash.tmp@free.fr (Mason)
Date: Fri, 10 Apr 2015 17:30:24 +0200
Subject: Guarantee udelay(N) spins at least N microseconds
In-Reply-To: <20150410150607.GG12732@n2100.arm.linux.org.uk>
References: <5527B331.5000205@free.fr>
 <20150410114415.GC12732@n2100.arm.linux.org.uk> <5527C501.2040808@free.fr>
 <20150410150607.GG12732@n2100.arm.linux.org.uk>
Message-ID: <5527EC90.9050900@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

I appreciate (very much so) that you spend time replying to me,
but I also sense a lot of animosity, and I don't know what I've
done wrong to deserve it :-(

On 10/04/2015 17:06, Russell King - ARM Linux wrote:
> On Fri, Apr 10, 2015 at 02:41:37PM +0200, Mason wrote:
>> On 10/04/2015 13:44, Russell King - ARM Linux wrote:
>>> On Fri, Apr 10, 2015 at 01:25:37PM +0200, Mason wrote:
>>>> If I understand correctly, most drivers expect udelay(N) to spin for
>>>> at least N ?s. Is that correct? In that use case, spinning less might
>>>> introduce subtle heisenbugs.
>>>
>>> We've never guaranteed this.
>>>
>>> The fact is that udelay() can delay for _approximately_ the time you
>>> ask for - it might be slightly shorter, or it could be much longer
>>> than you expect.
>>
>> OK, but asking for 10 ?s and spinning 0 is a problem, right?
>
> Potentially.
>
>>> On most UP implementations using the software loop
>>> it will typically be around 1% slower than requested.
>>
>> Please correct any misconception, it seems to me that typical
>> driver writers, reading "operation X takes 10 ?s to complete"
>> will write udelay(10); (if they want to spin-wait)
>
> Arguments do not matter here, sorry.  What I said above is the way it
> behaves, period.  It's not for discussion.
>
> It may interest you that I discussed this issue with Linus, and Linus
> also said that it _isn't_ a problem and it _isn't_ something we care
> to fix.
>
> So, like it or not, we're stuck with udelay(10) being possible to
> delay by 9.99us instead of 10us.
>
> Where the inaccuracy comes from is entirely down to the way we calculate
> loops_per_jiffy - this is the number of loop cycles between two timer
> interrupts - but this does _not_ take account of the time to execute a
> timer interrupt.
>
> So, loops_per_jiffy is the number of loop cycles between two timer
> interrupts minus the time taken to service the timer interrupt.
>
> And what this means is that udelay(n) where 'n' is less than the
> period between two timer interrupts /will/ be, and is /expected to
> be/ potentially shorter than the requested period.

You've made it clear how loop-based delays are implemented; and also
that loop-based delays are typically 1% shorter than requested.
(Thanks for the overview, by the way.) Please note that I haven't
touched to the loop-based code, I'm only discussing the timer-based
code.

> There's no getting away from that, we can't estimate how long the timer
> interrupt takes to handle without the use of an external timer, and if
> we've got an external timer, we might as well use it for all delays.

Exactly! And my patch only changes __timer_const_udelay() so again I'm
not touching loop-based code.

>> Do you think they should take the inherent imprecision of loop-based
>> delays into account, and add a small cushion to be safe?
>
> No.  See above.  Not doing that.  Live with it.

See, I don't understand your "Not doing that" statement.
I didn't suggest changing the implementation, I asked your opinion
(and the opinion of others on the list) whether driver _writers_
should take into account _in their code_ the 1% error you mentioned.

Specifically, should a driver writer use

   udelay(101);

when his spec says to spin 100 ?s?

(Anyway, this is just a tangential question, as I digest the ins
and outs of kernel and driver development.)

> Fix the rounding errors if you wish, but do _not_ try to fix the
> "udelay() may return slightly earlier than requested" problem.  I
> will not apply a patch to fix _that_ problem.

Can I submit as-is the one-line patch I proposed earlier?

Regards.
