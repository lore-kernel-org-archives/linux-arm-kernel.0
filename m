From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 11 Jan 2013 13:07:31 -0500
Subject: [kvmarm] [PATCH v2 2/2] ARM: KVM: Power State Coordination
 Interface implementation
In-Reply-To: <20130111175714.GK23505@n2100.arm.linux.org.uk>
References: <1357834005-23843-1-git-send-email-marc.zyngier@arm.com>
 <1357834005-23843-3-git-send-email-marc.zyngier@arm.com>
 <20130111171232.GH23505@n2100.arm.linux.org.uk>
 <50F04AD5.6020703@arm.com>
 <CANM98qJ2ZSwxMWFRWiunTQtoV7iFb3fn3Cf6VWvOndBcU=+Tmg@mail.gmail.com>
 <50F04F2F.80306@arm.com>
 <CANM98qLRsdFGxU6S5q2EqtCAmK8fOnbGWi8qXBktyuRkSaPAJg@mail.gmail.com>
 <20130111175714.GK23505@n2100.arm.linux.org.uk>
Message-ID: <CANM98q+mUcEs+ggxa1rgRqCgWUOnnL=BXQprxgd2548Y+dDjAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 12:57 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 11, 2013 at 12:48:45PM -0500, Christoffer Dall wrote:
>> again, that's why I suggest returning a bool instead. You just said
>> it: it's a basic handled/not-handled state. Why do you want to return
>> -EINVAL if that's not propogated anywhere?
>
> We have a well established principle throughout the kernel interfaces that
> functions will return positive values for success and an appropriate -ve
> errno for failure.
>
> We *certainly* hate functions which return 0 for failure and non-zero
> for success - it makes review a real pain because you start seeing code
> doing this:
>
>         if (!function()) {
>                 deal_with_failure();
>         }
>

and you'd certainly not find that in any of the KVM/ARM - that would
be despicable.

> and you have to then start looking at the function to properly understand
> what it's return semantics are.
>
> We have more than enough proof already that this doesn't work: people
> don't care to understand what the return values from functions mean.
> You only have to do an audit of a few of the IS_ERR_OR_NULL() uses to
> find that out, and you quickly realise that people just use what they
> _think_ is the right test and which happens to pass their very simple
> testing at the time.
>
> We've avoided major problems so far in the kernel by having most of the
> integer-returning functions following the established principle, and
> that's good.  I really really think that there must be a _very_ good
> reason, and overwhelming reason to deviate from the established
> principle in any large project.

The _very_ good reason here, is that we have two success cases: return
to guest and return to user space. As I said, we can save this state
in another bit somewhere and change all the KVM/ARM code to do so, but
the KVM guys back then would like to use the same convention as other
KVM archs.

I would prefer not having to change all that KVM/ARM code at this
point, but of course, if you insists, I will have to do that.

BUT, returning -EINVAL should indicate an actual error. This is not
the case for the concrete psci example, the case is simply that the
number in r0 does not fall within the psci range, and therefore could
potentially be handled by something else, and using -EINVAL as a
fall-through to the next value is equally weird and misleading.

An alternative is to do something like foo(..., &handled), but I think
using a bool as the function type is perfect here: what is the problem
with that again? Certainly it wouldn't be the only boolean function in
the kernel.

-Christoffer
