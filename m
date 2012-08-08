From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 8 Aug 2012 13:54:50 -0500
Subject: Kernels on Bad Firmware (was Re: kernel entry for thumb2-only
 cpus)
In-Reply-To: <5022A6F9.2000206@wwwdotorg.org>
References: <CAKGA1b=8gZdgpSJ28Hff+1199J0GarLxZU-NAv7JJDuk+La0ew@mail.gmail.com>
 <5022A6F9.2000206@wwwdotorg.org>
Message-ID: <CAKGA1bmST6HropaLmQzPrVpcXirRwUx1jbHkr3WB8PG8qXMLJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2012 at 12:50 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/08/2012 11:36 AM, Matt Sealey wrote:
> ...
>> The fact we could update it with a script was the awesome thing about
>> using OpenFirmware -
>> but U-Boot can do this too, since libfdt is there and it's one option
>> to enable it to allow script
>> based modification of the blob. If the DT is hardcoded into the firmware somehow
>> (CONFIG_OF_CONTROL I think) then platforms can load "boot.scr" from
>> the root filesystem ...
>
> Just a comment on CONFIG_OF_CONTROL...
>
> In U-Boot, CONFIG_OF_CONTROL determines whether U-Boot uses a device
> tree to configure itself. This is completely orthogonal to whether a
> device tree is passed to the kernel, and where the kernel DT comes from,
> which is still controlled by the bootm/bootz command parameters.
>
> The DT used to configure U-Boot isn't the same one passed to the kernel
> typically. The one for U-Boot is typically appended to the U-Boot image,
> whereas the one passed to the kernel is likely loaded from a file in
> /boot alongside the uImage/zImage of the kernel. I suppose the U-Boot
> script /could/ be written to encode the location of the appended DTB
> used by U-Boot and so pass the same one to the kernel, I don't believe
> anyone has done that. Besides, U-Boot's copy of the .dts files has
> diverged a little from the kernel's...:-(

... excuse me while I find a quiet room to scream in.

The ideal solution is as follows, though (taken from experience writing
OpenFirmware and Forth..)

* Bootloader straps from the processor and initializes the CPU. It may
(SHOULD) contain a basic device tree at this point specialized for the
CPU which defines the basic elements (memory start/size where it is
fixed, cpus, basic stuff as in dtsi skeletons)

* Board init code then uses a set of macros or internal functions to add
entries to the device tree as it brings up devices. Every device on the
system needs to be initialized as used. Anything that is not running
by default needs a "driver" to do this which does the minimal amount
required to give an environment for the OS (for instance, setting a
reasonable default for a clock or doing a mux setting). Adding a device
to the tree instantly makes it available to the rest of the bootloader,
such that devicetree_add_node("/foo/bar/mmc", ...) adds an MMC
device to the block devices list internally and can do generic boot stuff
from it.

* If Linux advances way beyond the driver bindings, the bootloader needs a
"runtime" way of externally specifying the hardware configuration such
that it can be scripted or otherwise automated (even if it's copious use
of mw.l and fdt_add or so in U-Boot hush shell scripting).

As such, actual device trees would go away from the kernel and be
a function of the bootloader's built-in specification, bootloader device
drivers, and pre-kernel execution of automated fixup.

What would be perfect is someone gets a clue about SoC design and
implements the bare minimum boot code inside the SoC. i.MX does this
about halfway - it has a common set of possibilities for iomux settings,
where it probes for SD/MMC, SPI, I2C, PATA, SATA, USB boot sources
and then provides a mask rom function to be able to stream *more* data
(using DMA, interrupts and with L2 cache enabled which is something
you cannot say about 99.99% of running U-Boots today) from the first
valid found source (overridden by fuses and boot config pins). Since it
can read from all these devices anyway it should be capable of selecting
a new boot device and streaming data to memory from these so the
bootloader no longer needs particular drivers for these boot sources.

Less advanced designs would just need a specific driver for it, as today,
with the added extra caveat that they would require adding their DT
bindings at the driver init time, as above.

I've been looking into the tinykernel/moboot solutions to create something
very similar to this but my urge to actually do it is quenched by the fact
we really should be using UEFI. The complexity of, for example, TianoCore
and the horrible HOB/PEI/PEIM legacy from x86 makes me want to cry,
though.

Has nobody really thought of the benefits of actually fixing the UEFI spec
on ARM such that you can grab something, write some bare platform code
that initializes it without the complicated chaining of pre-EFI, sort-of-EFI,
EFI-but-pre-kernel, EFI-booting-but-not-quite blocks? After all what the
kernel needs is valid tables in memory and a working call interface. How
you initialize the platform when standardized is nice, but it's overcomplex
and I think is lowering adoption on ARM... what's going on with device
trees or ACPI DSDT (and how is that going to make you guys cry)?

We had an internal architecture planning document here that basically
reworked UEFI ignoring some of the platform restrictions we had from
OpenFirmware or RTAS call interface (disable mmu, interrupts, caches
and then jump) - we did have a proof of concept (which we still call
Aura, although the actual "Aura" product has advanced to something
almost completely different) which allowed Linux to jump into a
pre-emptive code environment installed by firmware and perform any
driver code you needed at the firmware level. We used it to knock
down some performance problems on the PCI side and provide an
interface to several things which otherwise get done a lot (RTC handling,
PCI configuration space and domain handling) but you don't want to
basically kick Linux in the kidneys while you do it. After all, since
when did you want to disable interrupts, ditch the virtual
memory map, turn off the cache just to set or read the time?)

UEFI provides a lot of the core functionality Linux needs to boot in
a totally SoC-independent way, and even functionality Linux needs
to run, but it fails in that it requires that same disable-everything,
jump, re-enable everything architecture to persist for every call. We
were going to define a new system table that allowed for a new kind of
device tree (with the same kind of functionality as the current one,
but more flexible in that it allowed cross-referencing phandles to
actual UEFI-AURA runtime services). Where PPC and SPARC
platforms pull all the DT code out via calls to OF, ARM UEFI-AURA
would do this the same way. It may parse everything into a flattened
tree and use common functions after that, but the idea would be the
UEFI-AURA runtime would be able to dynamically update the tree
depending on things happening like hotplug events that could be
hidden from the OS somehow, DMA scripting, IPMI or other remote
management) or even encapsulate things like OpenGLES API calls
or media decoding (which is the ultimate expression of the requirements
of all these binary blob people) along with the ability to do funky things
like use the FPU in the firmware (would require the OS to understand
that this happens though) or NEON or so.

What it ends up being though is a mostly functional OS (which UEFI
basically is anyway if you add a GUI, which does exist) with Linux as
the shiny real-world interface to the top, tells the firmware it's done
with this functionality and has a real driver, tells the firmware it wants
to do this and that, passes userspace calls and data by virtual
addresses and references, reducing memory copies etc..

What we're talking about there though is 100 engineers, a couple years
and millions of dollars of funding to make the world a better place. I guess
we could always sign up for Kickstarter and put a few ads for new positions
on Stackoverflow.. :) so, just so you know, I'm not proposing we change
the world. We tried it, it's too big a job and there are too many people saying
"U-Boot is free and libfdt works".

I think the bare minimum "define the board properly and allow scripting changes"
would not be too big a job though, and as long as it can be done on UEFI
too.. that's fine. The work for the current device tree model would not go to
waste as it would be broadly compatible or at least immediately portable?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
