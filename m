From: Ian.Jackson@eu.citrix.com (Ian Jackson)
Date: Tue, 23 Aug 2011 18:51:51 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20110823173651.GH3895@n2100.arm.linux.org.uk>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<20110823151421.GK19622@n2100.arm.linux.org.uk>
	<20051.55874.736418.528404@mariner.uk.xensource.com>
	<20110823173651.GH3895@n2100.arm.linux.org.uk>
Message-ID: <20051.59575.166937.250550@mariner.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes ("Re: ARM processor mode, kernel startup, Hyp / secure state"):
> A secure side kernel contains no calls to the secure monitor.  Calls
> to the secure monitor are required to reprogram critical registers such
> as L2 cache configuration registers and the like.  For example, on
> OMAP, it is impossible to reliably invalidate the contents of the L2
> cache without making secure mode calls to reprogram various control
> registers.
> 
> Not having that register reprogrammed means you're running against
> data corrupting errata bugs.
> 
> So, basically, a kernel built for non-secure will only run on the
> non-secure side.  A kernel built for secure will only run reliably
> on the secure side.

It's not clear to me from reading the ARM ARM that a kernel written
for the non-secure side couldn't make the same monitor calls, but I
haven't seen any of the OMAP manuals and I haven't read any of the
errata (which you obviously have).

If there are kernels intended to run on the secure side, a difficulty
arises: if KVM wants to use Hyp mode and the associated features, how
is that to be done ?

> > But just because Linux owns the secure state doesn't mean that it
> > should run in that state most of the time.  The question is really
> > whether Linux would like to use the secure/non-secure division to
> > provide a more secure facility which other parts of the system can
> > use, or to use it to provide a more constrained/contained environment
> > in which to run less-trusted code.
> 
> What you're talking about is using Linux as the secure monitor, and
> effectively matching the dividing line between Linux and userspace
> with the secure/non-secure division.

Well, yes, that would be one way of looking at it.  I'm not sure why
you would want to do that, but it was just one of the two options if
Linux is trying to own the secure/non-secure distinction.

On the other hand if Linux wants to own that boundary and to use it to
provide a /more/ privileged facility, that would involve some Linux
kernel module hoisting a pile of its code (or, more likely, code
provided from userspace) into secure state, which code then pulled the
ladder up after itself.  The resulting thing wouldn't look much like a
user process and wouldn't (afterwards) be subject to unwanted
interference.  But I don't think anyone is doing anything like this ?

> > So is the secure state used for the same kind of things as SMM is on
> > Intel, then ?  Perhaps I haven't understood the usual setups well
> > enough.
> 
> You're assuming I have deep knowledge of x86.  I don't, sorry.

Fair enough.  (My own x86 knowledge is pretty shallow too TBH.)

> Secure state is used to run the secure monitor, which is a chunk of code
> provided by the SoC manufacturer and normally programmed into ROM on real
> SoCs.

If this is always (or generally) the case then Linux needs to run on
only one side of the secure/non-secure barrier.  Since Linux might
want to run kvm, which requires Hyp mode, which is only on the
non-secure side, that means it needs to run on the non-secure side.

What have I missed ?

Ian.
