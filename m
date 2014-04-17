From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 17 Apr 2014 16:06:16 -0400 (EDT)
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <CAL_Jsq+aYXTQCzCtxPnS=zhBCba6-mEz+kT-mHTDW602E0vbDw@mail.gmail.com>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <CAL_Jsq+aYXTQCzCtxPnS=zhBCba6-mEz+kT-mHTDW602E0vbDw@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1404171549480.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Apr 2014, Rob Herring wrote:

> On Wed, Apr 16, 2014 at 2:14 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Wed, 16 Apr 2014, Christopher Covington wrote:
> >
> >> On 04/15/2014 06:44 AM, Daniel Thompson wrote:
> >> > Hi Folks
> 
> [snip]
> 
> >> Or could we patch up the linker script to set zero-based ELF load
> >> memory addresses (LMAs) [4] so that the physical addresses are almost right,
> >> you just might have to add a system-specific RAM offset, perhaps pulled out of
> >> the device tree? If that won't work, we could generate some kind of
> >> vmlinux-phys with physical addresses. The latter two options might also
> >> simplify external debugging before __turn_mmu_on(). I like the sound of the
> >> LMA approach best, assuming it doesn't break existing stuff (I notice a few AT
> >> directives in vmlinux.lds.S). Some of this might transfer to arm64 as well.
> >> What do you all think?
> >
> > If you really really want to get at the TEXT_OFFSET value in the
> > uncompressed image, the simplest way would be:
> >
> > diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> > index f8c08839ed..de84d0635a 100644
> > --- a/arch/arm/kernel/head.S
> > +++ b/arch/arm/kernel/head.S
> > @@ -78,6 +78,11 @@
> >
> >         __HEAD
> >  ENTRY(stext)
> > +
> > +       b       1f
> > +       .word   TEXT_OFFSET             @ located at a 4-byte offset in Image
> > +1:
> > +
> >   ARM_BE8(setend        be )                    @ ensure we are in BE8 mode
> >
> >   THUMB(        adr     r9, BSYM(1f)    )       @ Kernel is always entered in ARM.
> >
> > This way the first word for Image would always be 0xea000000 and the
> > second one would be TEXT_OFFSET.  No other kernel Image binaries ever
> > had 0xea000000 as their first word so that also let you validate whether
> > or not the TEXT_OFFSET value is there.
> 
> Better yet, we should adopt the arm64 Image header which has this and
> other fields for arm Image files. We're going to have to deal with raw
> Image (and Image.gz) in bootloaders for arm64, so we might as well
> align things.

We could use the same header as ARM64 if we want to add more information 
to the uncompressed kernel image.

However I really don't want to encourage the proliferation of yet 
another kernel image formats on ARM32.  We've had zImage for the last 20 
years and that's what ARM32 bootloaders should support.  The 
introduction of the uImage format caused enough pain already.

Booting uncompressed kernel image on ARM32 may be useful for some 
debugging setups.  I don't see other cases where it would be legitimate 
to break existing practices.


Nicolas
