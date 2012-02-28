From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 28 Feb 2012 09:46:16 +0000
Subject: [PATCH-WIP 01/13] xen/arm: use r12 to pass the hypercall number
 to the hypervisor
In-Reply-To: <1330372125.10008.47.camel@dagon.hellion.org.uk>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
 <1330019314-20865-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20120227175327.GA2023@linaro.org>
 <1330372125.10008.47.camel@dagon.hellion.org.uk>
Message-ID: <20120228094616.GA2063@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 07:48:45PM +0000, Ian Campbell wrote:
> On Mon, 2012-02-27 at 17:53 +0000, Dave Martin wrote:
> > On Thu, Feb 23, 2012 at 05:48:22PM +0000, Stefano Stabellini wrote:
> > > We need a register to pass the hypercall number because we might not
> > > know it at compile time and HVC only takes an immediate argument.
> > > 
> > > Among the available registers r12 seems to be the best choice because it
> > > is defined as "intra-procedure call scratch register".
> > 
> > This would be massively simplified if you didn't try to inline the HVC.
> > Does it really need to be inline?
> >
> > > +#define __HYPERCALL ".word 0xe1400070 + " __HVC_IMM(XEN_HYPERCALL_TAG)
> > 
> > Please, do not do this.  It won't work in Thumb, where the encodings are
> > different.
> > 
> > It is reasonable to expect anyone building Xen to have reasonably new
> > tools, you you can justifiably use
> > 
> > AFLAGS_thisfile.o := -Wa,-march=armv7-a+virt
> > 
> > in the Makefile and just use the hvc instruction directly.
> 
> Our aim is for guest kernel binaries not to be specific to Xen -- i.e.
> they should be able to run on baremetal and other hypervisors as well.
> The differences should only be in the device-tree passed to the kernel.
> 
> > Of course, this is only practical if the HVC invocation is not inlined.
> 
> I suppose we could make the stub functions out of line, we just copied
> what Xen does on x86.
> 
> The only thing which springs to mind is that 5 argument hypercalls will
> end up pushing the fifth argument to the stack only to pop it back into
> r4 for the hypercall and IIRC it also needs to preserve r4 (callee saved
> reg) which is going to involve some small amount of code to move stuff
> around too.
> 
> So by inlining the functions we avoid some thunking because the compiler
> would know exactly what was happening at the hypercall site.

True ...

> 
> We don't currently have any 6 argument hypercalls but the same would
> extend there.
> 
> > If we can't avoid macro-ising HVC, we should do it globally, not locally
> > to the Xen code.  That way we at least keep all the horror in one place.
> 
> That sounds like a good idea to me.
> 
> Given that Stefano is proposing to make the ISS a (per-hypervisor)
> constant we could consider just defining the Thumb and non-Thumb
> constants instead of doing all the construction with the __HVC_IMM stuff
> -- that would remove a big bit of the macroization.

It's not quite as simple as that -- emitting instructions using data
directives is not endianness safe, and even in the cases where .long gives
the right result for ARM, it gives the wrong result for 32-bit Thumb
instructions if the opcode is given in human-readable order.

I was trying to solve the same problem for the kvm guys with some global
macros -- I'm aiming to get a patch posted soon, so I'll make sure
you're on CC.

Cheers
---Dave
