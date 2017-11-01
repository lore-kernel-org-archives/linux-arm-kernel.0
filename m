From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 1 Nov 2017 20:28:18 +0100
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <20171101092618.GN9463@n2100.armlinux.org.uk>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <CA+55aFzy9=RtFRuJhFbF+PL_PCrkZsKtAKrq6WJo1z9eW9gLSA@mail.gmail.com>
 <20171031165629.GF9463@n2100.armlinux.org.uk>
 <CA+55aFwDquBXt_EYT3JFoWkeFsZTym5qUXig-DePXXzm07uABw@mail.gmail.com>
 <CAD=FV=V3n0gjzpL860V6cgf8JVh5pmoL+i0t63Oot19T2afTPw@mail.gmail.com>
 <20171101092618.GN9463@n2100.armlinux.org.uk>
Message-ID: <475b9543-cc97-41b3-2924-0724fddee392@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2017 10:26, Russell King - ARM Linux wrote:

> On Tue, Oct 31, 2017 at 05:23:19PM -0700, Doug Anderson wrote:
>
>> On Tue, Oct 31, 2017 at 10:45 AM, Linus Torvalds wrote:
>>
>>> So I'm very much open to udelay improvements, and if somebody sends
>>> patches for particular platforms to do particularly well on that
>>> platform, I think we should merge them. But ...
>>
>> If I'm reading this all correctly, this sounds like you'd be willing
>> to merge <https://patchwork.kernel.org/patch/9429841/>.  This makes
>> udelay() guaranteed not to underrun on arm32 platforms.
> 
> That's a mis-representation again.  It stops a timer-based udelay()
> possibly underrunning by one tick if we are close to the start of
> a count increment.  However, it does nothing for the loops_per_jiffy
> udelay(), which can still underrun.

It is correct that improving the clock-based implementation does strictly
nothing for the loop-based implementation.

Is it possible to derive a higher bound on the amount of under-run when
using the loop-based delay on arm32?

> My argument against merging that patch is that with it merged, we get
> (as you say) a udelay() that doesn't underrun _when using a timer_
> but when we end up using the loops_per_jiffy udelay(), we're back to
> the old problem.
> 
> My opinion is that's bad, because it encourages people to write drivers
> that rely on udelay() having "good" behaviour, which it is not guaranteed
> to have.  So, they'll specify a delay period of exactly what they want,
> and their drivers will then fail when running on systems that aren't
> using a timer-based udelay().
> 
> If we want udelay() to have this behaviour, it needs to _always_ have
> this behaviour irrespective of the implementation.  So that means
> the loops_per_jiffy version also needs to be fixed in the same way,
> which IMHO is impossible.

Let's say some piece of HW absolutely, positively, unequivocally,
uncompromisingly, requires a strict minimum of 10 microseconds
elapsing between operations A and B.

You say a driver writer must not write udelay(10);
They have to take into account the possibility of under-delay.
How much additional delay should they add?
10%? 20%? 50%? A percentage + a fixed quantity?

If there is an actual rule, then it could be incorporated in the
loop-based implementation?

If it is impossible to say (as Linus hinted for some platforms)
then this means there is no way to guarantee a minimal delay?

Regards.
