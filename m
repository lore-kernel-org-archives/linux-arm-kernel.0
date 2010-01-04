From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 4 Jan 2010 19:34:00 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v2)
In-Reply-To: <F74D5D79E8EA1244A97ECCA56C4D01DB771E2EDD86@BUNGLE.Emea.Arm.com>
References: <20091218182007.GF5527@n2100.arm.linux.org.uk>
	<1261243122.4637.9.camel@pc1117.cambridge.arm.com>
	<20091219172833.GA6187@n2100.arm.linux.org.uk>
	<F74D5D79E8EA1244A97ECCA56C4D01DB771E2EDD86@BUNGLE.Emea.Arm.com>
Message-ID: <20100104193400.GB13537@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leif Lindholm wrote:
> > From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> > Sent: 19 December 2009 17:29
> 
> > > I wonder if there could be an exploit with Leif's current
> > > implementation. The LDREX/STREX pair to uncached or device memory may
> > > never complete. This way a user SWP to something like the frame
> > > buffer would lock the kernel.
> >
> > That means we shouldn't consider applying it until that has been
> > investigated.
> 
> What if I modify the patch such that a failed STREX causes the emulation to
> return success without readjusting the PC? This would result in the SWP
> instruction being executed again upon returning to the application - removing
> the potential kernel lockup.

There is no need to return to userspace, as you know that userspace
will immediately retry the instruction, or respond to a signal.

So you can loop, as long as you:

   1. Allow other tasks to run by calling cond_resched().
   2. Break out of the loop if signal_pending().

I think that's sufficient but I hope someone will double check because
I'm a little rusty.

If someone executes SWP on uncached or device memory and it's not an
intentional DOS (e.g. worked with older ARMs), they won't expect the
instruction to loop at that point.  Faulting would be better.
Is it feasible to detect when this has happened and send a SIGBUS
signal instead of looping?

-- Jamie
