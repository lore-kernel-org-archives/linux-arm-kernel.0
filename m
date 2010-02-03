From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 3 Feb 2010 13:59:14 +0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100203132824.GA27048@n2100.arm.linux.org.uk>
References: <20100203005038.GA16356@caradoc.them.org>
	<1265197942.1970.34.camel@pc1117.cambridge.arm.com>
	<20100203132824.GA27048@n2100.arm.linux.org.uk>
Message-ID: <20100203135914.GF4277@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 01:28:24PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 03, 2010 at 11:52:22AM +0000, Catalin Marinas wrote:
> > On Wed, 2010-02-03 at 00:50 +0000, Daniel Jacobowitz wrote:
> > > On Tue, Feb 02, 2010 at 10:43:22PM +0000, Russell King - ARM Linux
> > > wrote:
> > > > Umm, today there were patches posted using hardware support for
> > > > breakpoints / watchpoints.  I've not read through those patches
> > > > yet, but in light of hardware support, do we really need this patch
> > > > anymore?
> > > 
> > > Yes, it's unrelated.  Hardware breakpoints are a constrained resource,
> > > but we can insert unlimited software breakpoints (and often need to
> > > exceed the hardware breakpoint limit).
> > 
> > I agree, we still need support for software breakpoints.
> > 
> > The main benefit of hardware debugging support is for watchpoints.
> 
> Software breakpoints are a pain in the backside if you have threaded
> programs, because when you insert a breakpoint into one thread, it's
> active in all threads - you can't insert a breakpoint into only one
> thread.
> 
> If we have the ability to set hardware breakpoints, I'd like to see
> that used in preference to software breakpoints, and only resort to
> software breakpoints if there's no other alternative.
> 
> However, I don't believe the current hardware breakpoint/watchpoint
> support is anywhere near up to scratch at present - there seems to be
> nothing there which deals with tagging these points with a process ID,
> nor does it seem to enable/disable them on any thread switching.  So,
> (eg) if you install a watchpoint on a virtual address that is used by
> the thread being debugged _and_ the debugger (even though they may be
> different physical pages), you're going to have the debugger also
> trapping.
Well it looks like the hardware breakpoint layer is on top of the perf_events
subsystem and the breakpoint becomes a perf event. In this case the breakpoint
should be scheduled in and out by perf on context switches if targetting a
specific PID or could be left in the whole time if desired.

Jamie
