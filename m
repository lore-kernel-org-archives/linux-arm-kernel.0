From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Aug 2011 12:42:54 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20054.8276.47930.430789@mariner.uk.xensource.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CAHkRjk6N+OeeHZzS9hOnWKEg+aFUJVwT5Vf_PqO0cHv=2_9CnA@mail.gmail.com>
	<20051.57876.785018.498967@mariner.uk.xensource.com>
	<20110824135109.GP32688@e102144-lin.cambridge.arm.com>
	<20053.7340.865511.561798@mariner.uk.xensource.com>
	<20110824160039.GR32688@e102144-lin.cambridge.arm.com>
	<20053.8733.266040.189343@mariner.uk.xensource.com>
	<20110824161355.GS32688@e102144-lin.cambridge.arm.com>
	<20054.8276.47930.430789@mariner.uk.xensource.com>
Message-ID: <20110825114254.GC27143@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 11:13:40AM +0100, Ian Jackson wrote:
> Will Deacon writes ("Re: ARM processor mode, kernel startup, Hyp / secure state"):
> > On Wed, Aug 24, 2011 at 05:09:01PM +0100, Ian Jackson wrote:
> > > I think the trampoline needs to have one hypercall: "set HVBAR".
> > > (And, implicitly, it needs to be specified that the resulting vectors
> > > will run without physical-to-virtual page translation, etc.)  That is
> > > sufficient to bootstrap all the rest of the way up - and that other
> > > bootstrapping code would have to exist anyway.
> > 
> > I also thought you might want a hypercall that gives you a version number
> > (i.e. a way to identify the hypervisor trampoline in case it changes)
> 
> Since the hypervisor trampoline was installed by the very same kernel
> which is running, there is no need for any defined interface or
> version numbers.

Sure, but when we are confronted with a hypervisor that we didn't write
ourselves it might be nice if it looks the same as our Linux trampoline. If
we don't define this interface, that can never happen. So at the very least,
let's define the HVC number that we want to use for our single hypercall.

> > and we might also want something for doing a system reset (for
> > example, if a kernel that hasn't installed a hypervisor wants to
> > kexec another kernel image).
> 
> No, if a kernel has installed a hypervisor and wishes to kexec then it
> must start the new kernel in Hyp mode - since that is what we are
> proposing to specify as the cpu mode to use when booting the kernel.

Agreed.

> So the outgoing kernel simply switches to Hyp mode, tears down Hyp
> mode's paging (and probably the rest of the paging too), and then
> enters the new kernel in Hyp mode with paging off.  The new kernel
> then installs its own hypervisor trampoline.
> 
> If the outgoing kernel hasn't installed a hypervisor it's even easier:
> simply do the usual teardown, and then switch to Hyp mode using its
> existing trampoline and then enter the new kernel.

Thanks for the explanation. I was concerned about losing state across the
HVC but if it just returns back to you in the higher privilege level then
that's not a problem.

Will
