From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2011 18:36:51 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20051.55874.736418.528404@mariner.uk.xensource.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<20110823151421.GK19622@n2100.arm.linux.org.uk>
	<20051.55874.736418.528404@mariner.uk.xensource.com>
Message-ID: <20110823173651.GH3895@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 05:50:10PM +0100, Ian Jackson wrote:
> Russell King - ARM Linux writes ("Re: ARM processor mode, kernel startup, Hyp / secure state"):
> > We already have kernels which boot in both secure and non-secure mode
> > CPUs.  There's very little difference between the two from the core
> > ARM support code - except that we have expectations that appropriate
> > hardware work-arounds will have already been initialized by the
> > secure monitor (as there is no way for the kernel to be able to call
> > out to the secure monitor in a platform independent way.)
> 
> Right.
> 
> > So, basically, which side of the secure division the kernel runs on
> > depends highly on the platform itself - and as the secure monitor APIs
> > are highly platform specific, there's no getting away from that.
> 
> It seems to me that from the PoV of Linux there are two kind of
> platform: ones where the kernel is expected to own the secure state,
> and ones where it is expected to run only in non-secure state.

The distinction is a highly technical one, and it comes from the lack
of any kind of secure monitor API, and the fact that the non-secure
world is prevented from accessing various registers.

A secure side kernel contains no calls to the secure monitor.  Calls
to the secure monitor are required to reprogram critical registers such
as L2 cache configuration registers and the like.  For example, on
OMAP, it is impossible to reliably invalidate the contents of the L2
cache without making secure mode calls to reprogram various control
registers.

Not having that register reprogrammed means you're running against
data corrupting errata bugs.

So, basically, a kernel built for non-secure will only run on the
non-secure side.  A kernel built for secure will only run reliably
on the secure side.

> But just because Linux owns the secure state doesn't mean that it
> should run in that state most of the time.  The question is really
> whether Linux would like to use the secure/non-secure division to
> provide a more secure facility which other parts of the system can
> use, or to use it to provide a more constrained/contained environment
> in which to run less-trusted code.

What you're talking about is using Linux as the secure monitor, and
effectively matching the dividing line between Linux and userspace
with the secure/non-secure division.

Remember that Linux is not a micro-kernel, so any other partitioning
doesn't make sense.  (To place the partition elsewhere implies that
you have to carve the kernel data structures up and contain them
within each world - with separate memory allocators etc.)

> > If the kernel does not contain the appropriate platform specific secure
> > monitor API then it can't run in non-secure mode (or it can but the
> > functionality will be severely limited - no power management, and
> > in some cases buggy L2 cache.)  So you wouldn't _want_ to run such a
> > kernel if you value your data.
> 
> So is the secure state used for the same kind of things as SMM is on
> Intel, then ?  Perhaps I haven't understood the usual setups well
> enough.

You're assuming I have deep knowledge of x86.  I don't, sorry.

> I think I know what the hyp mode is for and how people will use it
> :-).  But I don't really know what the secure state is for.

Secure state is used to run the secure monitor, which is a chunk of code
provided by the SoC manufacturer and normally programmed into ROM on real
SoCs.

What is does is up to the SoC manufacturer.  What services it provides is
up to the SoC manufacturer.

The implication is that once the secure monitor has set things up, it
will start execution of things like boot loaders, etc in non-secure
mode.  Moreover, there's usually no way to get back into secure mode
to run your own code (otherwise it wouldn't be secure...)

A SoC manufacturer may provide a secure monitor to deal with storing
secret keys, and providing some kind of encryption services.  Or it
may provide nothing more than a way to access system registers which
are only accessible from secure mode.
