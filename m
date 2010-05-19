From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 19 May 2010 13:52:32 -0400 (EDT)
Subject: Boot interface for device trees on ARM
In-Reply-To: <AANLkTilJl9_NHiT1LITG7UbA9S7OYsnGMcDAsFEEx5Ob@mail.gmail.com>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
	<AANLkTilJl9_NHiT1LITG7UbA9S7OYsnGMcDAsFEEx5Ob@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1005191055180.12758@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Complete boot description and proposal added at the end
  for those interested. ]

On Wed, 19 May 2010, Grant Likely wrote:

> On Mon, May 17, 2010 at 10:34 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Tue, 18 May 2010, Jeremy Kerr wrote:
> >> Some notes about this scheme:
> >>
> >> ?- This would break compatibility with the existing boot interface:
> >> bootloaders that expect a DT kernel will not be able to boot a non-DT kernel.
> >> However, does this matter? Once the machine support (ie, bootloader and
> >> kernel) is done, we don't expect to have to enable both methods.
> >
> > I think that, for the moment, it is best if the bootloader on already
> > existing subarchitectures where DT is introduced still preserve the
> > already existing ability to boot using ATAGs. ?This allows for the
> > testing and validation of the DT concept against the legacy ATAG method
> > more easily.
> 
> I think we've got an agreement!  :-)

Good.

> > On new subarchitectures, it might make sense to go with DT from the
> > start instead of creating setup code for every single machine. ?In that
> > case the bootloader for those machines would only need to care about DT
> > and forget about ATAGs.
> >
> >> ?+ A simpler boot interface, so less to do (and get wrong) in the bootloader
> >>
> >> ?+ We don't have two potential sources of boot information
> >
> > Those last two are IMHO the biggest reasons for not having both ATAGs
> > and DT at the same time. ?Otherwise the confusion about which one is
> > authoritative, which one has precedence over the other, and/or whether
> > the information should be obtained from one structure if it is missing
> > from the other will simply bite us eventually for sure, as bootloader
> > writers will get sloppy/lazy and have it wrong. ?I strongly suggest that
> > we should specify that the kernel must consider either ATAGs _or_ a
> > device tree, and that the bootloader must pass only one of them.
> 
> I still disagree on this point.  I think it will cause less confusion
> to only have a single method for passing the dtb, but that is a debate
> that we don't need to solve immediately since we've got a way forward
> on passing the dtb now.

I don't understand you here.  We still are not in agreement on the 
method to pass the DTB yet, but I for sure don't want more than one 
method to pass it to the kernel.

There is a proposal to use the ATAG facility to encapsulate a pointer to 
the DT data.  I think this is unnecessary.

I'd much prefer if r2 contained either a pointer to the ATAG list, or a 
pointer to the DTB.  That's much cleaner and simpler.  As Jeremy pointed 
out, both structures include a magic number allowing to distinguish one 
from the other, so there is no backward compatibility issues.

> >> This proposal still does not require ATAG_DEVTREE?
> >
> > No.
>
> Hmmm...  I misunderstood then.  I don't agree that this is the best
> way forward
>
> Doing it this way means a non-compatible break in the interface.  It
> means that the bootloader needs to know what interface the kernel is
> expecting for boot; information that is not readily available from the
> image type.

I don't follow your point here.

It is not up to the bootloader to "adjust" to the kernel.  But rather 
for the kernel to cope with the bootloader's provided information.  If 
the bootloader passes a specific machine ID with the ATAG list then the 
kernel will use that, and if the bootloader passes a DT machine ID with 
a DT blob then the kernel will use that.  You just have to configure 
your kernel with both "machine types" at the same time.

> The user then needs to tell the boot loader which
> interface to use rather than a backwards compatible addition of a blob
> of data.

This is certainly not a show stopper, right?  If you planned for your 
bootloader to _already_ support both the ATAGs and the DT at the same 
time, it is not a big deal to have a config option that the user can 
change to select between "legacy" and "DT" boot methods.  Since we still 
want to preserve the ability to have a DT enabled kernel to boot using 
the legacy method, you will need a way to tell the bootloader which 
machine ID to use in that case anyway.

> You mention below "shifting the World Order on ARM" and it creating
> resistance for merging DT support.  Isn't this much the same thing as
> it creates a non backwards compatible change in the way bootloaders
> pass data to the kernel.  The cutover in powerpc from the old
> interface to the new caused no end of confusion and people who could
> no longer get their systems to boot.  On PowerPC is was necessary
> because the old method was completely broken, but ATAGs are clean,
> simple and well implemented.

I don't dispute the ATAG implementation.  I don't believe it is a good 
thing to carry the ATAG and DT as a combined boot requirement going 
forward.

On one hand, some people are claiming that the machine ID should be 
stuffed in the device tree and whatever is passed into r1 should be 
ignored.  On the other hand, you are saying that ATAGs should be kept 
forever as legacy cruft just to provide a reference to the DT data.  To 
me those are incompatible design objectives.

> It also means teaching every boot loader two separate methods for
> booting and exposing those differences to the user.

That's overstating the problem.  First, any bootloader wanting to use DT 
_will_ have to implement such a method.  With your proposal, all those 
bootloaders will _also_ have to know about ATAGs anyway.  So I don't see 
what your point is.

Let me start it all over again.

Here's how I think this should be handled on ARM.  Sorry PPC folks, but 
there is 15 years of ARM legacy to consider here, and what has been done 
on PPC might or might not be practical here -- please keep that in mind.  
I'm also going to use the present tense so to make this proposal as 
unambiguous as possible.

Booting Linux on ARM
====================

Two methods for passing boot information to the Linux kernel on ARM are 
possible:

1) the legacy method

2) the DT (device tree) method

The legacy method
-----------------

The legacy method for booting Linux on ARM requires that a unique 
machine ID be registered with RMK's machine ID database.  It can be 
viewed online at http://www.arm.linux.org.uk/developer/machines/.  
Before branching into the kernel image, the CPU register r1 must be 
initialized by the bootloader with the appropriate machine ID value for 
the exact hardware the kernel is booted on.  That is a hard requirement.

The kernel must also contain code specific to that machine ID in order 
to perform early setup of appropriate resources, create mappings for 
basic peripherals such as hardware timers, register relevant platform 
devices, etc.  That code can be found in those files containing the 
MACHINE_START and MACHINE_END macros, typically in arch/arm/mach-*/*.c.  
This is also a hard requirement.

Optionally (but strongly recommended), a tagged list (aka ATAGs) may be 
created in memory to pass extra information such as the size and 
location for RAM banks, size and location for a ramdisk, the kernel 
cmdline string, etc.  When not provided, the kernel will rely on default 
values which may or may not be sufficient to boot the kernel, or fall 
back to the information provided by a built-in kernel cmdline string 
determined by CONFIG_CMDLINE.

The location of the ATAG list is somewhat problematic.  Traditionally it 
has been stored at an offset of 0x100 from start of memory.  But some 
proposals were pushed forward to use r2 to indicate the location of the 
ATAG list.  Because it is impossible to determine with certainty whether 
or not the bootloader does actually initialize r2 with that information, 
this requirement was never enforced, which would otherwise cause 
backward compatibility issues.  The ATAG location is therefore stored 
into the machine record structure and therefore hardcoded at compile 
time.

When the kernel boots, it looks up into a table of all the machine 
records that have been compiled into the kernel for the one that 
corresponds with the machine ID passed into r1.  This lookup is 
performed in the very early boot stage from assembly code (with no stack 
available) to set up basic MMU stuff that is necessary for the kernel to 
be debuggable until the full fledged MMU support code takes over later 
during the boot.  Later on, the machine record is used to call init 
functions to initialize IO mappings, IRQs, timers, and so on as 
described above.  While the init_machine field in the machine record is 
obviously machine specific, all the other fields in the machine record 
end up being pretty much the same across all machines within the same 
SOC family.

The DT method
-------------

The DT method requires that a unique ID be registered for each SOC 
family for the DT purpose within the same ID space.  But instead of 
having one ID for each possible machine, only one ID per SOC family is 
required.  So the bootloader simply has to pass into r1 the ID 
corresponding to DT instead of the specific machine ID.  This is a hard 
requirement.

With this, the kernel can remain largely backward compatible with the 
legacy boot method, requiring _no_ change to the existing code, as the 
ID is sufficient to distinguish between both boot types.  The machine 
record remains largely relevant even for a DT boot as the majority of 
its content is SOC specific anyway, and given a per SOC ID for DT usage 
means that the early boot facilities are still usable as is even in the 
DT context.  And then the init_machine method in the machine record is 
naturally used to parse the device tree and do its work on multiple 
machines' behalf instead of relying on compiled-in static data for a 
specific machine.

The bootloader must also store in memory the DT data and pass its 
location via r2.  The r2 initialization therefore becomes a hard 
requirement when a DT is used. The boot_params field in the DT machine 
record could be set to -1 to disable ATAG parsing when a DT machine ID 
is used, and look into the DT data instead.

Backward Compatibility Considerations
-------------------------------------

Now let's have a look at what happens when we mix this with bootloaders.

If a kernel is too old, or was not configured with the "machine support" 
for DT, then only one thing may happen when a bootloader passes a DT 
machine ID to the kernel.  The early boot code will fail to find the 
machine record for the provided ID and refuse to boot.  If you have 
CONFIG_DEBUG_LL and are attempting to boot on the right SOC, then you'll 
probably get the error message on a serial port, along with a list of 
the actual machines and their IDs supported by that kernel.  In other 
words, this is not a new failure mode. Two solutions: either reconfigure 
your kernel to add DT support for your SOC, or configure your bootloader 
to use the legacy boot method.  And having a bootloader that can do DT 
only for a machine that has only legacy support in the kernel is 
senseless, so that case needs no be considered any longer.

The opposite is the kernel being configured for DT _only_, and the 
bootloader being too old, or misconfigured, so it passes a non-DT 
machine ID to the kernel.  In this case the same failure mode as above 
will be observed: kernel failing to find the matching machine record and 
halting (after attempting to display the error and the available machine 
supported). Solution: reconfigure your kernel with legacy support for 
that machine.

If the goal is to experiment with DT support in the kernel, and the 
bootloader does not support DT, then some shim can be prepended to the 
kernel image to fix things up.  Most bootloaders already have the 
ability to load arbitrary binary data in memory, and branch to arbitrary 
location too.  So it should be pretty easy to tftp the kernel, then tftp 
the DT data, to finally branch into the kernel with appropriate values 
in r1 and r2.

Conclusion
----------

I hope I've illustrated clearly why 1) keeping the requirement for 
passing a machine ID into r1, even for DT, is useful, and 2) why 
dropping ATAGs when using DT is simpler, cleaner, and has no relevant 
backward compatibility issues.  With #1 the ability to seamlessly use 
the existing early debugging code is preserved, and the introduction of 
DT fits perfectly well in the existing machine support model on ARM. Yet 
the new boot requirements introduced with DT are only for "machine" IDS 
that are still not in use, meaning there is no backward compatibilities 
introduced at all.  With #2 it will be possible to simplify bootloader 
support for new platforms being DT enabled without any legacy needs, and 
when the kernel is configured only for DT support then it will be 
possible to configure out the ATAG support code entirely.


Nicolas
