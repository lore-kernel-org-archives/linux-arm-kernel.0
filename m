From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 29 Jul 2014 10:10:44 +0100
Subject: Kexec on arm64
In-Reply-To: <1406592548.28348.49.camel@smoke>
References: <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
 <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke>
 <20140724093603.GC4079@leverpostej>
 <1406247468.4062.59.camel@smoke>
 <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
 <1406333901.4062.69.camel@smoke>
 <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
 <20140728153812.GA2576@leverpostej>
 <1406592548.28348.49.camel@smoke>
Message-ID: <20140729091044.GH2576@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 01:09:08AM +0100, Geoff Levand wrote:
> Hi,

Hi,

> On Mon, 2014-07-28 at 16:38 +0100, Mark Rutland wrote:
> > On Mon, Jul 28, 2014 at 04:00:18PM +0100, Arun Chandran wrote:
> > > I have these changes to the code.
> > >         flush_icache_range((unsigned long)reboot_code_buffer,
> > > -               relocate_new_kernel_size);
> > > +               (unsigned long)(reboot_code_buffer + relocate_new_kernel_size));
> 
> Thanks, I introduced this in my last version in an attempt to clean up
> the code, but on studying setup_restart(), I wonder if we even need to
> do this icache flush here (see below).
> 
> > >         /*
> > >          * Flush any data used by relocate_new_kernel in preparation for
> > > #########
> > > Passing of second variable to flush_icache_range() is wrong
> > > it expects an address not length.
> > 
> > A simpler option would be to nuke the entire icache before branching to
> > the new image.
> 
> flush_cache_all(), which is called by setup_restart(), does a 'ic
> ialluis'.  The ARM says that this will invalidate all instruction caches
> for the inner shareable domain.  Do we need something more?

If we have that before branching to the new image then that should be
ok. The current image should already be visible at the PoC per the boot
protocol.

> > > 2)
> > > 
> > > #######
> > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > index 9ed7327..e3fc8d6 100644
> > > --- a/arch/arm64/kernel/process.c
> > > +++ b/arch/arm64/kernel/process.c
> > > 
> > > @@ -84,12 +91,17 @@ void soft_restart(unsigned long addr)
> > >  {
> > >         typedef void (*phys_reset_t)(unsigned long);
> > >         phys_reset_t phys_reset;
> > > +       unsigned long jump_addr = addr;
> > > +
> > > +       phys_reset = (phys_reset_t)virt_to_phys(cpu_reset);
> > > +
> > > +       __flush_dcache_area(&jump_addr, 8);
> > > +       __flush_dcache_area(&phys_reset, 8);
> > 
> > Are these values really not getting stashed in registers?
> 
> Looking at the disassembled code of soft_restart() from my compiler,
> addr is being saved on the stack over the call to setup_restart(), which
> I would expect it to do.
 
> > If the compiler is spilling, then we have absolutely no guarantee about
> > any part of the stack. If that's the case, then we can't use the stack
> > at all. These need to be rewritten in asm if the compiler is spilling.
> 
> I think we just need to put the restart addr in a variable and flush
> that to the PoC.

I don't believe that flushing the restart addr variable on the stack out
to the PoC is the correct fix here; it only guarantees that said
variable is visible, not anything else the compiler may have placed on
the stack. I wonder how setup_restart interacts with
CONFIG_CC_STACKPROTECTOR for example.

As far as I can see, the only way to provide the guarantee we require
here is to not use the stack. Anything short of that is not going to be
much more robust than the current code.

Thanks,
Mark.
