From: matt@genesi-usa.com (Matt Sealey)
Date: Sat, 6 Apr 2013 14:24:36 -0500
Subject: [RFC PATCH] CLK: Allow parent clock and rate to be configured in
 DT.
In-Reply-To: <CALBypN4mHwWZNiAQqErh1bL1sPHNuRbO5-yxzY+R1enQqEJOSQ@mail.gmail.com>
References: <20130319170933.28337.50448.stgit@localhost>
 <CAOMZO5ASkvquyzPCEGObvB5Xh9bDPTJ2zx26eOUJT_Vb36Bn3Q@mail.gmail.com>
 <CAKGA1bkWLrOs15ni=8D__BvuG6kvqkeeLZGOLrVZY9g0q0z4Bg@mail.gmail.com>
 <6581638.FPkNsv6peb@flatron>
 <CALBypN4mHwWZNiAQqErh1bL1sPHNuRbO5-yxzY+R1enQqEJOSQ@mail.gmail.com>
Message-ID: <CAKGA1b=Z4M6t4BVFyfqxq=iZ6MHGbgHf5WodGbTCSaC7E_b7FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 6, 2013 at 12:51 PM, Martin Fuzzey <mfuzzey@gmail.com> wrote:
> On Sat, Apr 6, 2013 at 3:21 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> Hi,
>>
>> [RANT]
>>
>> I tend to disagree about this whole hype about device tree usage for other
>> things than pure hardware description. I don't think device tree should be
>> a way to force some kind of new world order, but rather a more convenient
>> and more maintainable (than board files) way of support hardware platforms
>> in Linux kernel.
>>
> Totally agree
>
>> On Friday 05 of April 2013 20:07:09 Matt Sealey wrote:
>>>
>>> The device tree concept is NOT a place to dump configuration items for
>>> your board as hardcoded values to try and force something you could
>>> have done elsewhere. On i.MX53 you cannot boot a kernel verbatim - you
>>> at least have to run through the Boot ROM and supply a DCD table or
>>> plugins first. This is where you figure things like this out.
>>
>
> You're suggesting setting the frequencies, parents etc in the DCD table??

It's one option.. you should also be doing IOMUX somewhere very early
too for *everything* you can, as changing pad settings on the fly can
be electrically problematic. You wouldn't change an input to an output
8 seconds into the board's boot process if you could do it 8ns into
it. Our HW designers constantly freak out over doing pinctrl stuff so
late in the process..

> Why?

Because the earlier you do it, the better.

> IMHO that's horribly unreadable.

So is most of the low level init code for anything; fact of life. Have
you ever looked at the lib/ and kernel/ directories in the kernel
tree? The code that deals with low-level debug and earlyprintk?

The device tree isn't meant to make that part easier it's to describe
what you did there (and potentially verify it ;)

>> Why not to make the kernel independent from the bootloader at all? Then
>> the bootloader could just do some minimal initialization needed to load a
>> kernel image from flash memory and launch it (+ some code to allow
>> flashing of new images).
>
> Yes that's my opinion too.
>
> I think the bootloader should really do as little as possible since:
> * It's generally harder and/or riskier to update the bootloader than
> the kernel (althugh somewhat less true these days with boot from SD)

Although you cannot guarantee your system can even boot from SD (or
even has an SD slot to do so). It could be SPI NOR or MLC NAND on some
bus, or something more esoteric. Updating a bootloader is not really
that risky anymore - I would agree outright that it is undesirable to
do too often, but there are ways around this that don't involve adding
to the device tree in such a way that you are basically explaining all
the items the bootloader forgot (or was so badly written, it did not
do). If you want USB networking, you need to bring up USB. If you want
to store the environment, you need to set up some environment storage.
You're configuring the memory controller, memory clock, regulators and
getting to the point you have a serial console that will effectively
load a kernel from your chosen place to memory and execute it - at
this point I don't understand why setting CLKO's parent and it's
divider (two.. register.. writes...) is somehow so difficult and
requires a device tree binding.

Once it's set up, as I said there are bindings for fixed
always-running clocks, fixed toggled clocks, and dynamic clocks, which
covers all cases.

> * There are multiple bootloaders (u-boot, barebox, ...) but only one kernel

No, I can think of multiple operating systems that could possibly run
here.. VxWorks, Integrity, QNX, L4 (Fiasco, Pistachio), NetBSD,
FreeBSD,  and in Sascha's example, OpenBSD.. Darwin/XNU? We're walkng
further into territory of "it will never happen anyway" but I know the
first 7 boot on a ton of i.MX processors and they could all use device
tree at some point.

All of which need to do the same setup anyway - Linux requires one
hell of a lot of low level initialization of the CPU on ARM and x86
platforms; if we're moving errata fixes out to the bootloader to deal
with TrustZone on ARM, then there is already a lot of "unreadable"
assembly code in there. To boot Linux from SD card on i.MX you need to
set up the SD card IOMUX (Boot ROM does this for the one you for the
one you chose, but if you did not choose it, it isn't set up).

The fragmentation of bootloaders (U-Boot, barebox, moboot..) is not a
technology issue but a political one. The stuff we're talking about
here is usually cut & pastable and if the vendor of the hardware
releases an opensource bootloader - eminently so. If it's a closed
bootloader, well... you're SOL. That is a problem, but that is not a
problem the device tree is meant to solve. The correct way to deal
with that is refuse Linux support until they do things right, or have
things broken until they do things right. Eventually they will figure
it out.. but the idea would be to not have a lot of platform setup
code living in the kernel and moving around between DIFFERENT kernels.
The device tree is one solution - describe an interface between
unknown bootloader "foo" and operating system kernel "bar" - but that
doesn't mean it replaces the concept that it needs

> * It makes it easier to do product families where you have a common
> bootloader and kernel image with different DTBs per variant. You can
> then put all the DTBs in the boot partition and use a bootloader
> variable to chose the right one.

That doesn't mean you can't have the bootloader know which
device/board it is running on. How does that variable get set? If that
variable is set at runtime, surely then it can perform all this setup
before it sets the variable?

>>> I am totally against this (sorry Sascha..). Let's put some effort into
>>> fixing the bootloaders rather than trying to use the device tree to
>>> enforce the ridiculous assumption that "Linux kernel does not trust
>>> the bootloader".
>
> Why is this "rediculous" IMHO the kernel shouldn't trust the
> bootloader, beyond having setting up the hardware sufficiently to
> reliably and safely execute code.

Here we are merely differing on the definition of "sufficiently to
reliably and safely execute code".

We're in an age of SoCs, I remember in the desktop PowerPC days and
older x86 days of northbridges, southbridges and peripherals you only
had responsibility to bring up the CPU, but again you had to configure
a PCI host controller, USB, IDE drives, display, mouse and keyboard of
some kind... and setting up one clock that's not used right now but
will be by the OS is NOT a lot of code on top of all that. Now most of
that is basically, practically required.. on most of the boards we're
looking at supporting in the Linux ARM DT kernel support right now,
it's pretty much all esoteric development boards with more pin headers
than actual features, and Android development kits that are just
tablets without cases - they are designed to have you mess with the
bootloader.

If we don't support those boards properly by properly implementing
bootloader support and setup, it means consumer devices based on them
do not follow the best practises of doing this stuff in the bootloader
before the OS - which is a more lean, easier to test environment
anyway. We're talking here about one device where we want a clock
output for a codec from the SoC, did anyone even sit down, put a scope
on a test pad and be sure that the clock is stable, not full of
jitter, and has the right logic levels? The best place to do that is
after you set it up, no-autoboot U-Boot in most of these cases and for
more proprietary systems, since most hardware designers end up doing
this anyway, usually the code is around somewhere.

>>> Once the bindings and trees are out of the kernel
>>> source, you're going to HAVE to trust what the bootloader passes, be
>>> it pregenerated compiled blob (which needs to be written to match the
>>> hardware state the bootloader finishes up at) or dynamically generated
>>> at runtime during the boot process (which can describe to the bit what
>>> the hardware is doing).
>
> You have to trust the DTB yes but that is not the same as trusting the
> bootloader to have setup the hardware.
>
> I fail to see what difference it makes if the DTS is inside or outside
> the kernel source. Even today you can compile a DTB from out of tree
> DTS and pass it to a mainline kernel.

Indeed, but you can guarantee in the time it took you to do that
someone changed a binding because the source code for the DTS, and the
documentation for the binding, is still part of Linux and it means
Linux "hack it in and we'll do it properly later" design methodology
comes into play.

If you have a fixed clock which cannot change, and the bare minimum
functionality implemented is gating, you need to set this up in the
bootloader and - at option, depending on if it's needed to boot - gate
it. Then tell Linux there's a fixed rate clock and it can turn it on
and off via the device tree.. that's the solution here, it's already
written and has bindings, we don't need new ones to cover the case
whereby someone forgot to do so.

I am going to stand by my little proposal; we modify the clock
initialization so effectively check whether the parent in the DTB is
the same as the one in hardware, and if not then report this fact (and
optionally set that clock's parent to the one in the DTB). This is a
sly back-door approach in one sense, but in the future when people
build a board, put initial revision of bootloader code on the board,
boot a kernel with a device tree that is not describing the hardware,
they will see warnings; "Your clock "fooclk" isn't the same as your DT
says it is. Fix the bootloader, please."

And they will. This means the bootloader gets easier to trust for
every new board.

As for giving devices some configuration so they can "force" a clock
frequency, I don't like that idea. In the event it is derived from a
clock somewhere, in the audio codec case and in many others it is
better to do this on the basis of power management or configuration
"selection" - you describe all the possible ways it can be configured
for certain features (for instance, 27MHz clock frequency allows audio
rates of 8000, 16000, 32000, 44100, 48000Hz and 24MHz allows 8000,
16000, 32000, 44100, 48000, 88200, 96000Hz) and the driver can make an
assessment of what clock it has - clk_get_rate tells it which clock it
has (lets assume the board booted with a 27MHz clock). If it can set
the clock to one that supports more rates, it can do so - in this
case, it would decide it wants 96KHz support, so it clk_set_rate it to
24MHz. The frequency support (and bit format support too) should be in
the device tree so that given a supplied clock phandle it can find out
the current rate, derive supported modes, and then set a better rate
if that's functional. "Setting the clock rate based on configuration
items in some clock-configuration tree" is too much of a specific fix,
for in this case one particular device. But most devices can support a
list of potential configurations FOR THAT DEVICE (the same way a clock
can have many parents already, but only one can be set) and the DT is
exactly there to describe these, and the best practise code in the
driver would basically - by the back door - fix the clock for us.

I still say the desired clock, implemented by the HW designer, should
be done in the bootloader though (that way no clock changes happen
inside Linux) and we can figure a much, MUCH more consistent way of
allowing drivers to actually "set the clock it wants" without it being
a clock-subsystem thing. It is the device that has the requirement for
the clock frequency after all, not the clock subsystem.

-- 
Matt Sealey <matt@genesi-usa.com>
