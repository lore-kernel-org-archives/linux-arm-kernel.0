From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 19 Jul 2012 17:32:09 -0400 (EDT)
Subject: Device tree.
In-Reply-To: <5007CE35.8060705@codethink.co.uk>
References: <500552C9.4090107@codethink.co.uk> <50056E22.5040308@gmail.com>
 <5b5e32ecde7b96d3af217054150eb43c@codethink.co.uk> <13863985.aH2icoQzEI@flexo>
 <50057CD2.2060001@codethink.co.uk>
 <alpine.LFD.2.02.1207171712070.9293@xanadu.home>
 <50066AE6.6000002@codethink.co.uk>
 <alpine.LFD.2.02.1207180929230.9293@xanadu.home>
 <5007CE35.8060705@codethink.co.uk>
Message-ID: <alpine.LFD.2.02.1207191648080.9293@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Jul 2012, Ian Molton wrote:

> On 18/07/12 14:42, Nicolas Pitre wrote
> 
> TL;DR: Summary
> 
> * make uImage is *broken* with CONFIG_ARM_APPENDED_DTB

Why do you say so?

In my own opinion, make uImage is broken, period.  But that is not the 
topic here.

> * Trimmed down single-configuration kernels have merit. forcing
>   .dtb to be passed from the bootloader
>   - Increases bootloader complexity
>     - and we know bootloaders suck and can be hard (if not impossible)
>       to replace.
>   - buys you nothing.

Hence CONFIG_ARM_APPENDED_DTB.

> * Three other architectures support
>   'make <image>.<embedded_dtb>'

If this is a generically useful feature, then something generic should 
be done about it instead. Duplicating the maintenance cost is silly.  
At least commit e339364514 moved things in the right direction for the 
uImage flavours.

> * Old bootloaders cant always be replaced (ROM) or chainload (lack
>   of flash) a newer one.

Hence CONFIG_ARM_APPENDED_DTB.  And don't tell me that you have u-Boot 
in ROM, in which case uImage shouldn't matter.

> * No way to pass a .dtb address on the kernel commandline (where
>   the bootloader cant pass it in a register, but can load arbitrary data
>   into RAM, which most u-boot versions can.)

That could be a nice compromize as an alternative to 
CONFIG_ARM_ATAG_DTB_COMPAT.

> Conclusion:
> 
> There are three 'real' solutions, IMO.
> 1) Copy the other arches, and have make <image>.<embedded_dtb>
>   - dtb could be properly embedded, linked into the kernel image.
>   - makes for a consistent way of building images across more archs.
>   - allows for simpler bootloaders.

If you want a consistent way, make that generic and not duplicated per 
architecture.

> 2) Display a warning when building a uImage with
> CONFIG_ARM_APPENDED_DTB, because that simply wont work the way
> things are now.
>   - Doesn't really fix anything, but at least it helps people see why
>     its not working...

Agreed.

> 3) Add an option to specify the address of a .dtb file in RAM via
> the kernel commandline.
>  - removes the need for appending .dtb files to the kernel
>  - still requires the bootloader to grok .dtb

See above.

> >> Yes, because this tactic has worked just great historically...
> >
> > It certainly did.  Look at the latest u-Boot which 1) has support
> > for device tree on ARM, and 2) has support to boot a zImage
> > directly. And some people were able to modify their old u-Boot as
> > well because of this policy.
> 
> I don't agree. u-boot has always been the weirdo that didnt just use a
> zImage. Its taken *years* for that to change, and its not like uImages
> were /ever/ easier to work with. I'd say the very presence of
> 'make uImage' slowed that change to a near halt.

Cheers!  

The uImage format also has other obnoxious limitations such as the 
absolute load address encoded into it.  This prevents a kernel built to 
run on multiple devices with different RAM offsets to be used on all of 
them.  This might have changed recently, but the old u-Boot installation 
base remains.

> >> Other than chainbooting /another/ bootloader, how do you propose
> >> people fix this issue? Not everyone has a co-operative vendor.
> >
> > Ask your vendor harder.  They would care even less if the kernel was
> > more accommodating.
> 
> They don't care anyway - vendors never have. They just ship some
> cruddy bootloader and let the clients fix it all up after its run. There are
> more than a few boards out there that boot a u-boot from another
> u-boot. Theres at least one that runs through *three* u-boots before
> getting to a kernel...

Hopefully the latest one could be updated to a recent one?

> >> And for those of us where this is not an option?
> >
> > This is always an option to you.  You have the patch already, it
> > doesn't necessarily have to live in mainline.
> 
> I mean't *changing u-boot* is often not an option. Sometimes, neither
> is chainbooting (limited flash).

Limited flash rules out u-Boot, right?

> >> Which is all lovely, but sometimes simply not appropriate.
> >
> > Please deal with it.  Going the other way isn't appropriate for
> > mainline either.
> 
> Being able to make one zImage for lots of devices is a Good Thing.
> 
> Being able to pair an image down for just one device is *also* a
> Good Thing.
> 
> **This isn't either/or**  In the 'one device' case, having the .dtb
> appended can be useful. Having it passed in seperately is actually
> fairly pointless, merely adding to the bootloader complexity.

It is not pointless if you think about Linux distributions.  They want a 
single kernel binary that can run anywhere and that they can update as 
often they want, while the DTB should be tied to each different device, 
ideally produced by the device vendor and shipped with the device.  
That could even allow yet to be produced devices to boot existing 
distributions, just like on x86.

That may not be applicable to you if your u-Boot only accommodates 
uImage which are already fixed to a particular memory address and 
therefore can't accept a universal zImage.  But short of not having a 
single 'make <image>.<embedded_dtb' command, you can still do

	make zImage
	cat your_board.dtb >> arch/arm/boot/zImage
	make uImage

or make the last 2 commands into the kernel _installation_ procedure for 
your board, running mkimage directly instead of using 'make uImage'.

Because 'make uImage' is really impairing progress here.  The kernel is 
already physical address agnostic i.e. it can be loaded anywhere and 
it'll figure out at run time what the actual physical memory location 
is.  We are trying to get rid of such knowledge as fixed physical 
addresses in the kernel and right now the only thing that prevents that 
is mkimage's _need_ for one.

> Also, completely missing, AFAICT, is the option to pass the address
> of a .dtb preloaded in RAM on the kernel commandline - which would
> at least mean that people with crap u-boots could copy a .dtb to RAM
>  and then point the kernel at it. (this was actually the first thing I tried,
> until I realised that there is no option (that I can find) for that.)

If only u-Boot would have let you set that address into the r2 register 
before booting the kernel this would have worked just fine.

[...]
> If zImage is the one true way, thats fine - and I actually would prefer
> that, I think uImages are stupid.
> 
> But - since its not the only way, it'd be sensible if the 'other way'
> actually worked, or was officially made an out of tree option (thus
> making it work again because you can concat. the .dtb file prior to
> making the uImage.)

Isn't that what I just showed above?


Nicolas
