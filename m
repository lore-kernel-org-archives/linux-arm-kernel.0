From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 6 Aug 2012 13:40:26 -0500
Subject: kernel entry for thumb2-only cpus
In-Reply-To: <alpine.LFD.2.02.1208060026460.5231@xanadu.home>
References: <20120803090452.GE2626@pengutronix.de>
 <20120803114532.GB26925@mudshark.cambridge.arm.com>
 <20120805095528.GO2626@pengutronix.de>
 <alpine.LFD.2.02.1208060026460.5231@xanadu.home>
Message-ID: <CAKGA1b=Pxif=4qSvK-Odmunbm_T6LjWP_CXid_v2VNmpuyHLDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 5, 2012 at 11:32 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sun, 5 Aug 2012, Uwe Kleine-K?nig wrote:
>
>> On Fri, Aug 03, 2012 at 12:45:32PM +0100, Will Deacon wrote:
>> > On Fri, Aug 03, 2012 at 10:04:52AM +0100, Uwe Kleine-K?nig wrote:
>> > > Hello,
>> >
>> > Hi Uwe,
>> >
>> > > in both arch/arm/kernel/head.S and arch/arm/kernel/head-nommu.S we have
>> > >
>> > >   .arm
>> > >  THUMB( adr     r9, BSYM(1f)    )       @ Kernel is always entered in ARM.
>> > >  THUMB( bx      r9              )       @ If this is a Thumb-2 kernel,
>> > >  THUMB( .thumb                  )       @ switch to Thumb now.
>> > >  THUMB(1:                       )
>> > >
>> > > as first instructions at the entry point. This is a problem for
>> > > thumb2-only cpus (e.g. Cortex-M3).
>> >
>> > Yup, Documentation/arm/Booting mentions this too.
>> >
>> > > Up to now I commented out the first three lines for the Cortex-M3 port.
>> > > What should we do about that. There are two possibilities I see:
>> > >
>> > >  a) introduce a kconfig symbol for thumb2-only builds and #ifdef the
>> > >     first three lines out if it is given.
>> > >  b) expect the bootloader to directly jump to the label 1.
>> > >
>> > > The downside of a) is that a boot loader on a cpu that is capable to
>> > > execute the tradtional instructions would need to detect if the switch
>> > > to thumb is there or not and react accordingly. (In fact it needs to
>> > > distringuish three cases:
>> > >
>> > >  - traditional kernel
>> > >  - thumb2 kernel with ARM entry
>> > >  - thumb2 kernel without ARM entry
>> > >
>> > > .) So I think b) is the more sensible option in the long run.
>> > >
>> > > What do you think?
>> >
>> > How about something like:
>> >
>> >
>> > diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
>> > index 835898e..9f07be2 100644
>> > --- a/arch/arm/kernel/head.S
>> > +++ b/arch/arm/kernel/head.S
>> > @@ -86,6 +86,7 @@
>> >         __HEAD
>> >  ENTRY(stext)
>> >
>> > + THUMB(        .inst   0xe200e004      )       @ ARM: and lr, r0, #4 T2: b 1f
>> >   THUMB(        adr     r9, BSYM(1f)    )       @ Kernel is always entered in ARM.
>> >   THUMB(        bx      r9              )       @ If this is a Thumb-2 kernel,
>> >   THUMB(        .thumb                  )       @ switch to Thumb now.
>> Great idea, but it doesn't work as suggested. My compiler already barfs
>> on the .arm above:
>
> Let's stop splitting hairs.
>
> A Cortex-M kernel simply won't run on anything else.  It certainly won't
> run on ARM mode capable processors.  So in this case just make the
> kernel entry point Thumb mode only by #ifdef'ing out the .arm part.
>
> This is good _only_ for CPUs without any ARM mode capability though.

Wouldn't it be nice to have a solution where you can build a Thumb2
bootloader (like U-Boot which can do this) for an ARM-with-Thumb2
processor and not needlessly enter/exit Thumb2 mode while entering the
kernel? It's not something that could be automated but it might make
for something a little more deterministic in terms of running "the
same code" on two only slightly different architectures (after all why
else would you want to run Linux on a Cortex-M? Most microcontroller
development shuns Linux :)

Could we have an option that basically is subordinate to
CONFIG_THUMB2_KERNEL such as CONFIG_THUMB2_ENTRYPOINT (depends on
CONFIG_THUMB2) with a huge warning in the enable that this won't boot
from U-Boot that's not compiled to support it (and there is a patch
for this somewhere that someone has to write to support it) and/or
your bootloader absolutely MUST be in Thumb2 mode before it jumps to
the entrypoint to avoid an exception?

Maybe we could implement a shiny new zImage magic value, I'm not sure
if 0x016f2818 might have some sentimental value, but there's nothing
to say that 0x016f2819 wouldn't also be valid and indicate that it's
an ARM zImage with a Thumb2 entrypoint?

What kind of images are we expecting to load on a Cortex-M anyway? I
would assume more common than a zImage would be some kind of special
compressed image somehow since flash would be at a premium... you
don't want to bulk your kernel up with 64kb of U-Boot SPL or so, or
even anything smaller than that. In this case, since surely Cortex-M
boots up in a more amenable state to loading kernels from flash (or
flexram or flexnvm or whatever the other manufacturers call it, and
all the docs say you can run pretty much C code from first instruction
instead of the assembler headers usually setting up exception vectors)
by just decompressing themselves automatically anyway. There, you
would not need the ARM code at all.

In the case where you'd rather run a bootloader and run a kernel from
removable storage or over USB or ethernet, you're stuck with an
external bootloader like U-Boot, and the compilation of both is going
to be controlled, one would hope; in this case, you'd configure your
loader for Thumb and your kernel for Thumb.

There's possibly some use in this, not a lot of use, but at least you
could guarantee your backtrace at early boot would be the same on M4
and A9 if it never swapped in and out of ARM mode just to execute
Thumb code exclusively from U-Boot through to Linux. Maybe that counts
for some people.. I personally like developing code on faster
processors before putting them on the slower ones, and the fact the
ISA is tantamount to identical is one of the great reasons to use the
M4..

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
