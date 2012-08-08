From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 8 Aug 2012 11:54:36 +0100
Subject: kernel entry for thumb2-only cpus
In-Reply-To: <alpine.LFD.2.02.1208060026460.5231@xanadu.home>
References: <20120803090452.GE2626@pengutronix.de>
 <20120803114532.GB26925@mudshark.cambridge.arm.com>
 <20120805095528.GO2626@pengutronix.de>
 <alpine.LFD.2.02.1208060026460.5231@xanadu.home>
Message-ID: <20120808105436.GA2134@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 12:32:14AM -0400, Nicolas Pitre wrote:
> On Sun, 5 Aug 2012, Uwe Kleine-K?nig wrote:
> 
> > On Fri, Aug 03, 2012 at 12:45:32PM +0100, Will Deacon wrote:
> > > On Fri, Aug 03, 2012 at 10:04:52AM +0100, Uwe Kleine-K?nig wrote:
> > > > Hello,
> > > 
> > > Hi Uwe,
> > > 
> > > > in both arch/arm/kernel/head.S and arch/arm/kernel/head-nommu.S we have
> > > > 
> > > > 	.arm
> > > >  THUMB( adr     r9, BSYM(1f)    )       @ Kernel is always entered in ARM.
> > > >  THUMB( bx      r9              )       @ If this is a Thumb-2 kernel,
> > > >  THUMB( .thumb                  )       @ switch to Thumb now.
> > > >  THUMB(1:                       )
> > > > 
> > > > as first instructions at the entry point. This is a problem for
> > > > thumb2-only cpus (e.g. Cortex-M3).
> > > 
> > > Yup, Documentation/arm/Booting mentions this too.
> > > 
> > > > Up to now I commented out the first three lines for the Cortex-M3 port.
> > > > What should we do about that. There are two possibilities I see:
> > > > 
> > > >  a) introduce a kconfig symbol for thumb2-only builds and #ifdef the
> > > >     first three lines out if it is given.
> > > >  b) expect the bootloader to directly jump to the label 1.
> > > > 
> > > > The downside of a) is that a boot loader on a cpu that is capable to
> > > > execute the tradtional instructions would need to detect if the switch
> > > > to thumb is there or not and react accordingly. (In fact it needs to
> > > > distringuish three cases:
> > > > 
> > > >  - traditional kernel
> > > >  - thumb2 kernel with ARM entry
> > > >  - thumb2 kernel without ARM entry
> > > > 
> > > > .) So I think b) is the more sensible option in the long run.
> > > > 
> > > > What do you think?
> > > 
> > > How about something like:
> > > 
> > > 
> > > diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> > > index 835898e..9f07be2 100644
> > > --- a/arch/arm/kernel/head.S
> > > +++ b/arch/arm/kernel/head.S
> > > @@ -86,6 +86,7 @@
> > >         __HEAD
> > >  ENTRY(stext)
> > >  
> > > + THUMB(        .inst   0xe200e004      )       @ ARM: and lr, r0, #4 T2: b 1f
> > >   THUMB(        adr     r9, BSYM(1f)    )       @ Kernel is always entered in ARM.
> > >   THUMB(        bx      r9              )       @ If this is a Thumb-2 kernel,
> > >   THUMB(        .thumb                  )       @ switch to Thumb now.
> > Great idea, but it doesn't work as suggested. My compiler already barfs
> > on the .arm above:
> 
> Let's stop splitting hairs.
> 
> A Cortex-M kernel simply won't run on anything else.  It certainly won't 
> run on ARM mode capable processors.  So in this case just make the 
> kernel entry point Thumb mode only by #ifdef'ing out the .arm part.

This was exactly my view when originally adding that code.

Previously, there was no well-defined way for a bootloader to know
whether the target kernel was ARM or Thumb and this had to be separately
configured.  This just caused a compatibility mess.

To fix this, we now have a fixed boot protocol: on a CPU supporting ARM
state, you must enter the kernel in ARM state, period.  This means there
is nothing for the bootloader to get wrong.  If a single bootloader
image is required across CPUs with and without ARM state, the bootloader
must detect the CPU and enter the kernel in the appropriate way.

The unconditionalness of the veneer sequence was an omission caused by
the fact that there was no real upstream support for ARM-less v7 CPUs
at the time.

For ARM-less CPUs, I would go for the #ifdef approach.


The only potential problem comes from the fact that the boot protocol
groups CPUs into two mutually exclusive sets: those with ARM state and
those without.  I single image cannot therefore run on both:

 a) building a single image that is bootable on ARM-less (M class)
    and AR class.  Those architecture families are just too different
    for this to seem realistic.

 b) building a single image that is bootable on current -AR CPUs
    (with ARM state) and hypothetical future -AR CPUs without ARM
    state.

Both of these seem pretty speculative.

Unless we have a need for these right now I would much rather that a
bootloader which does not follow arm/Booting fails instead of silently
working.

Cheers
---Dave
