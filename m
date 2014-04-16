From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 16 Apr 2014 19:21:12 -0400 (EDT)
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <534EF153.5050603@codeaurora.org>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <534EF153.5050603@codeaurora.org>
Message-ID: <alpine.LFD.2.11.1404161853530.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Apr 2014, Christopher Covington wrote:

> On 04/16/2014 03:14 PM, Nicolas Pitre wrote:
> > On Wed, 16 Apr 2014, Christopher Covington wrote:
> > 
> >> It seems to me that if external/uncompressed image loaders could query the
> >> text offset in a straightforward manner, variance between images could be
> >> easily dealt with. Would reading it out of ELF metadata be a reasonable
> >> mechanism? Could the ELF format vmlinux be a suitable general replacement for
> >> the raw Image?
> > 
> > The ELF image only has virtual addresses in it.  And the virtual address 
> > of the kernel may be changed independently of TEXT_OFFSET with 
> > CONFIG_VMSPLIT_*.
> 
> Do you know why this is the case? The ELF format is capable of storing
> physical addresses as mentioned below.

We don't know at build time what the physical address of the kernel will 
be.  Back when the kernel could boot on a single SOC family then the 
physical address was hardcoded in the kernel binary.  And with some 
special configs (running a XIP kernel is the most obvious example) it is 
still the case.  But in general we don't want to hardcode any physical 
address in order to boot the same kernel binary on as many different 
machines as possible.  Therefore the physical address is determined at 
run time in most cases and having it in the ELF file would be 
meaningless.

The virtual address for the kernel, including TEXT_OFFSET, is determined 
at build time.  And that's what the ELF file carries.

> What I meant to ask about was variance from one kernel version and build to
> the next, given a single platform. Platform-to-platform variation can probably
> be abstracted where needed by the scripts controlling the external load.

Right.  The platform script must know where physical RAM is and load the 
kernel accordingly.  In case of zImage you need to load it anywhere in 
the first 128MB of RAM.  In the uncompressed Image it is at TEXT_OFFSET 
from start of physical RAM.  

> In any case, CONFIG_VMSPLIT_* that you mentioned above would be an 
> example where it would vary in an inconvenient manner, so this 
> approach wouldn't be an improvement.

Well.  This config option changes the virtual address the kernel is 
going to set up for itself.  And that is going to be reflected in the 
ELF file as well.  That part is pretty machine independent and can be 
obtained easily with tools like debuggers.  you pretty much need the ELF 
file if you want to have symbolic debugging anyway.  So no issue there.

> >> Or could we patch up the linker script to set zero-based ELF load
> >> memory addresses (LMAs) [4] so that the physical addresses are almost right,
> >> you just might have to add a system-specific RAM offset, perhaps pulled out of
> 
> I don't think I made this very clear, but adding the offset would happen at
> load/run-time, controlled by JTAG scripts or simulator equivalent.

Sure.  To load and debug the code before the MMU is turned on, you need 
to know the physical address of RAM (the kernel binary doesn't carry it) 
and the value of TEXT_OFFSET (this is hardcoded in the kernel binary at 
build time).

> > If you really really want to get at the TEXT_OFFSET value in the 
> > uncompressed image, the simplest way would be:
> > 
> > diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> > index f8c08839ed..de84d0635a 100644
> > --- a/arch/arm/kernel/head.S
> > +++ b/arch/arm/kernel/head.S
> > @@ -78,6 +78,11 @@
> >  
> >  	__HEAD
> >  ENTRY(stext)
> > +
> > +	b	1f
> > +	.word	TEXT_OFFSET		@ located at a 4-byte offset in Image
> > +1:
> > +
> >   ARM_BE8(setend	be )			@ ensure we are in BE8 mode
> >  
> >   THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is always entered in ARM.
> > 
> > This way the first word for Image would always be 0xea000000 and the 
> > second one would be TEXT_OFFSET.  No other kernel Image binaries ever 
> > had 0xea000000 as their first word so that also let you validate whether 
> > or not the TEXT_OFFSET value is there.
> 
> Thank you for the suggestion. This approach also came to mind, but it would
> require new documentation and tooling in the JTAG scripts or simulator
> equivalent. That's another aspect of the ELF-based approaches that I
> like--hopefully existing documentation and tool support could be reused.

The above is useful for loading the raw uncompressed Image without 
carrying the full ELF baggage.  With the ELF file we could simply store 
a symbol which value would be TEXT_OFFSET.  But the physical start of 
RAM has to come from outside the kernel image.

But whatever you do, new documentation and tooling is required anyway if 
you want to automate this into your debugging script.


Nicolas
