From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 28 Jul 2017 19:58:18 -0400 (EDT)
Subject: [PATCH] [RFC] ARM: move __bug_table into .data for XIP_KERNEL
In-Reply-To: <27F512E2-F027-4BD1-9D40-ECCC55952DC3@linaro.org>
References: <20170728141108.1283320-1-arnd@arndb.de>
 <alpine.LFD.2.20.1707281119450.5981@knanqh.ubzr>
 <27F512E2-F027-4BD1-9D40-ECCC55952DC3@linaro.org>
Message-ID: <alpine.LFD.2.20.1707281942270.5981@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 29 Jul 2017, Ard Biesheuvel wrote:

> 
> 
> > On 28 Jul 2017, at 16:27, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > 
> >> On Fri, 28 Jul 2017, Arnd Bergmann wrote:
> >> 
> >> Matt Hart reports that vf610m4_defconfig kernels grew to 2GB
> >> xipImage size after the __bug_table change.
> >> 
> >> I tried out a few things and found that moving the bug table
> >> into the .data section avoids this problem. However, the
> >> linker script magic is beyond my capabilities here, so this
> >> is almost certainly not correct.
> > 
> > Well, before your patch the BUG_TABLE location as well as its runtime 
> > functionality were completely wrong and broken.
> > 
> >> I've added a few people to Cc that understand this better
> >> than I do, hopefully someone can turn my bogus patch into
> >> a proper one.
> > 
> > Your patch isn't as bad as you make it, but maybe the following will 
> > avoid open recoding BUG_TABLE locally:
> > 
> > diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> > index 8265b11621..21b4b29c2f 100644
> > --- a/arch/arm/kernel/vmlinux-xip.lds.S
> > +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> > @@ -237,13 +237,13 @@ SECTIONS
> >         */
> >        DATA_DATA
> >        CONSTRUCTORS
> > -
> > -        _edata = .;
> >    }
> > -    _edata_loc = __data_loc + SIZEOF(.data);
> > 
> >    BUG_TABLE
> > 
> 
> The .data section is deliberately emitted with LMA != VMA so that the 
> code refers to the correct offset in RAM while the initial contents 
> are in ROM and are copied into RAM by the startup code.

You're right of course.  And I have no excuse as the relevant part of 
the startup code is actually mine.

> This applies to the bug table as well (now that it needs to be 
> writable) so the only correct way to do this is to move it into .data 
> like Arnd's patch does.

I got distracted by trying to reuse the macro as is and therefore I 
didn't fix anything.

> I guess we could split the macro so we can emit bug table into an 
> existing section, but in itself, the code is correct, and i don't see 
> a better way of doing it.

Agreed.


Nicolas
