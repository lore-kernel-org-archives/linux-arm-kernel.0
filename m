From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Jan 2010 20:46:47 +0000
Subject: [PATCH 20/40] arm,kgdb: Add hook to catch an oops with
	debugger
In-Reply-To: <4B4F7EC2.6030000@windriver.com>
References: <20100114174821.GB21385@n2100.arm.linux.org.uk>
	<4B4F7EC2.6030000@windriver.com>
Message-ID: <20100114204647.GE21385@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2010 at 02:29:54PM -0600, Jason Wessel wrote:
> Russell King - ARM Linux wrote:
> > 
> > I have a similar patch which implements the hook properly - but
> > with one caveat.  It needs a review to ensure that its safe to return
> > from die().  Until that's established, this patch can not be merged.
> 
> I completed the analysis on your patch and yes, it is safe to return
> from __die() and die() the way you currently structured it, but it
> doesn't work quite the same as on some other architectures.
> 
> After changing kgdb.c to register with the die notifier, I stepped
> through your code with an ICE, as well as running my regression tests
> which panic, oops, bad access etc...
> 
> While kernel execution does happen to continue to work, I don't know
> that you really want to continue execution.
> 
> 1) The kernel is marked tainted
> 2) bust_spinlocks() was toggled for a while
> 
> On x86 for example, the notifier is invoked prior to the
> bust_spinlocks() etc... and then it can pass the exception along to
> the rest of the system (which can result in something bad, but
> remember the human behind the kernel debugger controls did it for some
> reason or another).

On x86, it's called in multiple places - both before die(), and also
inside __die().

In __die(), notify_die() gets called with DIE_OOPS.  There's also a
pile of notify_die() calls in arch/x86/kernel/traps.c, which we don't
implement on ARM yet - it's unclear what's required here, and until
we have a user of notify_die()...

> I made the following addition to your patch, and then it behaved as
> the other archs do with respect to passing along the result of the
> exception.  Given this information, would you be willing to merge your
> patch and possibly fold in the change below, or further comment?

This changes the behaviour away from x86, so I'm not sure it's the
right thing to do.  For instance, it means that kexec won't get to
know about the oops on ARM if NOTIFY_STOP is returned, whereas on
x86 it will.

Maybe this hook wasn't meant for kgdb - what does kgdb use on x86?
