From: ian.molton@codethink.co.uk (Ian Molton)
Date: Thu, 19 Jul 2012 10:07:01 +0100
Subject: Device tree.
In-Reply-To: <alpine.LFD.2.02.1207180929230.9293@xanadu.home>
References: <500552C9.4090107@codethink.co.uk> <50056E22.5040308@gmail.com>
 <5b5e32ecde7b96d3af217054150eb43c@codethink.co.uk>
 <13863985.aH2icoQzEI@flexo> <50057CD2.2060001@codethink.co.uk>
 <alpine.LFD.2.02.1207171712070.9293@xanadu.home>
 <50066AE6.6000002@codethink.co.uk>
 <alpine.LFD.2.02.1207180929230.9293@xanadu.home>
Message-ID: <5007CE35.8060705@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/12 14:42, Nicolas Pitre wrote

TL;DR: Summary

* make uImage is *broken* with CONFIG_ARM_APPENDED_DTB
* Trimmed down single-configuration kernels have merit. forcing
   .dtb to be passed from the bootloader
   - Increases bootloader complexity
     - and we know bootloaders suck and can be hard (if not impossible)
       to replace.
   - buys you nothing.
* Three other architectures support
   'make <image>.<embedded_dtb>'
* Old bootloaders cant always be replaced (ROM) or chainload (lack
   of flash) a newer one.
* No way to pass a .dtb address on the kernel commandline (where
   the bootloader cant pass it in a register, but can load arbitrary data
   into RAM, which most u-boot versions can.)

Conclusion:

There are three 'real' solutions, IMO.
1) Copy the other arches, and have make <image>.<embedded_dtb>
   - dtb could be properly embedded, linked into the kernel image.
   - makes for a consistent way of building images across more archs.
   - allows for simpler bootloaders.

2) Display a warning when building a uImage with
CONFIG_ARM_APPENDED_DTB, because that simply wont work the way
things are now.
   - Doesn't really fix anything, but at least it helps people see why
     its not working...

3) Add an option to specify the address of a .dtb file in RAM via
the kernel commandline.
  - removes the need for appending .dtb files to the kernel
  - still requires the bootloader to grok .dtb

 >> Yes, because this tactic has worked just great historically...
 >
 > It certainly did.  Look at the latest u-Boot which 1) has support
 > for device tree on ARM, and 2) has support to boot a zImage
 > directly. And some people were able to modify their old u-Boot as
 > well because of this policy.

I don't agree. u-boot has always been the weirdo that didnt just use a
zImage. Its taken *years* for that to change, and its not like uImages
were /ever/ easier to work with. I'd say the very presence of
'make uImage' slowed that change to a near halt.

 >> Other than chainbooting /another/ bootloader, how do you propose
 >> people fix this issue? Not everyone has a co-operative vendor.
 >
 > Ask your vendor harder.  They would care even less if the kernel was
 > more accommodating.

They don't care anyway - vendors never have. They just ship some
cruddy bootloader and let the clients fix it all up after its run. There are
more than a few boards out there that boot a u-boot from another
u-boot. Theres at least one that runs through *three* u-boots before
getting to a kernel...

 >> And for those of us where this is not an option?
 >
 > This is always an option to you.  You have the patch already, it
 > doesn't necessarily have to live in mainline.

I mean't *changing u-boot* is often not an option. Sometimes, neither
is chainbooting (limited flash).

 >> Which is all lovely, but sometimes simply not appropriate.
 >
 > Please deal with it.  Going the other way isn't appropriate for
 > mainline either.

Being able to make one zImage for lots of devices is a Good Thing.

Being able to pair an image down for just one device is *also* a
Good Thing.

**This isn't either/or**  In the 'one device' case, having the .dtb
appended can be useful. Having it passed in seperately is actually
fairly pointless, merely adding to the bootloader complexity.

Also, completely missing, AFAICT, is the option to pass the address
of a .dtb preloaded in RAM on the kernel commandline - which would
at least mean that people with crap u-boots could copy a .dtb to RAM
  and then point the kernel at it. (this was actually the first thing I 
tried,
until I realised that there is no option (that I can find) for that.)

 > Absolutely.  But it is there now and that's the extent of what
 > mainline is providing in terms of accommodation.

I really don't see why. We're talking about a couple of lines of patch.
If you're going to allow appending at all, you might as well let people
specify the file to append...

The way it is now, building uImages with 'make uImage' is
*actually broken*, if you want an appended DT.

 >> Whats the point in make uImage if you cant use it?
 >
 > I advocated its removal for quite a long time now.  But it is still
 > there which is also a compromise.  This way, people with ancient
 > target which are not DT enabled aren't affected.

What about those of us with a DT target and a crap bootloader? Or
Those who want a one-device image?

DT wont magically make drivers available for some other device, no
matter how hard you describe them in the .dts file, so 'one device'
images are still going to be pretty useless in the case of someone
trying to boot some other board with them.

If zImage is the one true way, thats fine - and I actually would prefer
that, I think uImages are stupid.

But - since its not the only way, it'd be sensible if the 'other way'
actually worked, or was officially made an out of tree option (thus
making it work again because you can concat. the .dtb file prior to
making the uImage.)
