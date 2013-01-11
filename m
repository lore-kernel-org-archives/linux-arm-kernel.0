From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jan 2013 17:57:14 +0000
Subject: [kvmarm] [PATCH v2 2/2] ARM: KVM: Power State Coordination
 Interface implementation
In-Reply-To: <CANM98qLRsdFGxU6S5q2EqtCAmK8fOnbGWi8qXBktyuRkSaPAJg@mail.gmail.com>
References: <1357834005-23843-1-git-send-email-marc.zyngier@arm.com>
 <1357834005-23843-3-git-send-email-marc.zyngier@arm.com>
 <20130111171232.GH23505@n2100.arm.linux.org.uk> <50F04AD5.6020703@arm.com>
 <CANM98qJ2ZSwxMWFRWiunTQtoV7iFb3fn3Cf6VWvOndBcU=+Tmg@mail.gmail.com>
 <50F04F2F.80306@arm.com>
 <CANM98qLRsdFGxU6S5q2EqtCAmK8fOnbGWi8qXBktyuRkSaPAJg@mail.gmail.com>
Message-ID: <20130111175714.GK23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 12:48:45PM -0500, Christoffer Dall wrote:
> again, that's why I suggest returning a bool instead. You just said
> it: it's a basic handled/not-handled state. Why do you want to return
> -EINVAL if that's not propogated anywhere?

We have a well established principle throughout the kernel interfaces that
functions will return positive values for success and an appropriate -ve
errno for failure.

We *certainly* hate functions which return 0 for failure and non-zero
for success - it makes review a real pain because you start seeing code
doing this:

	if (!function()) {
		deal_with_failure();
	}

and you have to then start looking at the function to properly understand
what it's return semantics are.

We have more than enough proof already that this doesn't work: people
don't care to understand what the return values from functions mean.
You only have to do an audit of a few of the IS_ERR_OR_NULL() uses to
find that out, and you quickly realise that people just use what they
_think_ is the right test and which happens to pass their very simple
testing at the time.

We've avoided major problems so far in the kernel by having most of the
integer-returning functions following the established principle, and
that's good.  I really really think that there must be a _very_ good
reason, and overwhelming reason to deviate from the established
principle in any large project.
