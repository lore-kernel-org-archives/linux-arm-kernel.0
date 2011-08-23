From: Ian.Jackson@eu.citrix.com (Ian Jackson)
Date: Tue, 23 Aug 2011 17:50:10 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20110823151421.GK19622@n2100.arm.linux.org.uk>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<20110823151421.GK19622@n2100.arm.linux.org.uk>
Message-ID: <20051.55874.736418.528404@mariner.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes ("Re: ARM processor mode, kernel startup, Hyp / secure state"):
> We already have kernels which boot in both secure and non-secure mode
> CPUs.  There's very little difference between the two from the core
> ARM support code - except that we have expectations that appropriate
> hardware work-arounds will have already been initialized by the
> secure monitor (as there is no way for the kernel to be able to call
> out to the secure monitor in a platform independent way.)

Right.

> So, basically, which side of the secure division the kernel runs on
> depends highly on the platform itself - and as the secure monitor APIs
> are highly platform specific, there's no getting away from that.

It seems to me that from the PoV of Linux there are two kind of
platform: ones where the kernel is expected to own the secure state,
and ones where it is expected to run only in non-secure state.

But just because Linux owns the secure state doesn't mean that it
should run in that state most of the time.  The question is really
whether Linux would like to use the secure/non-secure division to
provide a more secure facility which other parts of the system can
use, or to use it to provide a more constrained/contained environment
in which to run less-trusted code.

In the latter case Linux would want to run in secure state all of the
time.  In the former it would want to run mostly in non-secure state.
But it is difficult to choose between these later than boot time
because switching a running system from the secure to non-secure state
is so complex.

> If the kernel does not contain the appropriate platform specific secure
> monitor API then it can't run in non-secure mode (or it can but the
> functionality will be severely limited - no power management, and
> in some cases buggy L2 cache.)  So you wouldn't _want_ to run such a
> kernel if you value your data.

So is the secure state used for the same kind of things as SMM is on
Intel, then ?  Perhaps I haven't understood the usual setups well
enough.

> Given all that, there's not much point to publishing whether a kernel is
> built for secure side or not.  It's tied extremely closely to the platform
> itself, which is where most of the secure API calls already live.

The point of my proposed ELF flag isn't to advertise that a kernel is
capable of running in the secure state.  As you say, where this is
possible, we don't need to advertise it.

The point of my ELF flag is to advertise that the kernel would like to
_know_ that it has control of the secure state; the kernel is told
this by the fact that it enters in _monitor mode_ rather than kernel
mode.  Obviously you shouldn't enter an unconsenting kernel in monitor
mode.

If the kernel is to have control of the secure state it needs to know
this, and to have a way of making use of it.  It looked to me like the
easiest way of doing this was entering it in monitor mode.  (Since a
kernel entered in kernel mode can't tell easily whether it's in secure
or non-secure state.)

Likewise, if the kernel is to have control of the hyp mode, it needs
to know that and have a way to use it.  So entering the kernel in hyp
mode seemed to me the easiest way.

I think I know what the hyp mode is for and how people will use it
:-).  But I don't really know what the secure state is for.

Thanks,
Ian.
