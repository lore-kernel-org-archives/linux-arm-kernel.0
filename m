From: neko@bakuhatsu.net (Matt Sealey)
Date: Wed, 27 Nov 2013 16:17:41 -0600
Subject: ACPI
In-Reply-To: <20131127141634.A45F3C404EC@trevor.secretlab.ca>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <CAHCPf3t-dKc-xwjLCEWrY6kmi4_dLHp4iMgOwdEJ43UGK9=khQ@mail.gmail.com>
 <20131127141634.A45F3C404EC@trevor.secretlab.ca>
Message-ID: <CAHCPf3ubLbeEGN-M-GW=ZByH48s=WxMTuWFhEs0mBhuXjUOAMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 8:16 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Tue, 26 Nov 2013 17:11:23 -0600, Matt Sealey <neko@bakuhatsu.net> wrote:
>> On Tue, Nov 26, 2013 at 12:33 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>> > On Tue, Nov 26, 2013 at 12:55:10PM +0000, Grant Likely wrote:
>> >> On Tue, Nov 26, 2013 at 12:43 PM, Linus Walleij
>> >> <linus.walleij@linaro.org> wrote:
>> >> > I have a feeling we should not recommend ARM implementers
>> >> > to go and do things like this.
>>
>> I have a real problem with the concept of putting device trees inside
>> ACPI, while still relying on this consensus that the preferred boot
>> method will also be UEFI.
>
> ACPI and UEFI are completely separate things.

Good lord, Grant. I have a working knowledge of both..

I got told to be concise, it turns out being concise just makes people
miss the point.

The easiest way to get hold of your ACPI tables on UEFI is from the
ACPI configuration table stored as one of the configurable tables off
the UEFI System Table which is supposed to be passed to the OS on
boot. Otherwise it has absolutely no access to Boot Services table or
Runtime Services Table or anything.

UEFI hands control to an entry point of a PE/COFF executable (the only
thing it's required to know how to load) passing the pointer to the
System Table as it's second argument, location defined by the UEFI
specification. This is completely subverted in LinuxLoader and the EFI
patches you mentioned, which I have seen before and I honestly don't
understand why it was done this way - except to assume that rampant
paranoia about something new and different took hold, and some
internal discussion ended up with "the mainline guys will never accept
this.... how do we work around that?"

Paranoia about another magic value (the kernel already looks for atags
and device tree magic) and doing some UEFI-specific process instead!

What LinuxLoader does is conform to the ARM Linux device tree booting
ABI - not the UEFI booting ABI. What the patches do is put the
responsibility of locating the System Table into the device tree,
which is fundamentally backwards from a firmware -> OS ABI point of
view... from the UEFI specification..

> There are changes that need to be made here such as storing the DT
> pointer in the UEFI system table so that firmware can directly provide a
> DT which either GRUB or the Linux UEFI stub can pick up, but that is a
> relatively uncontroversial detail.

As I said, I don't understand why this is so uncontroversial,
considering it by definition completely subverts the UEFI boot process
to try and make it conform to Linux's device tree or atags searching.

LinuxLoader is a workaround. BdsBootLinuxFdt doesn't do the 'right
thing' from a UEFI point of view. StartLinux just passes the FDT
pointer and machine ID just like a normal U-Boot DT boot, or a Redboot
boot, or any other firmware boot. Getting far enough down into Linux'
early boot process to unflatten a device tree, then finding the UEFI
pointers from the device tree, is just.. avoiding UEFI for no good
reason.

I know there is a historical distrust of firmware around here, but
this is ridiculous.

All the information being stuffed into device tree to support finding
EFI firmwares is all provided by UEFI to the Application (in UEFI
terminology) it boots.. no roundabout parsing of device trees
required, it's right there. As a side effect, the information stored
in device tree /memreserve/ blocks is hanging off the System Table
too.

It might even be nice for UEFI to eventually grow to provide a device
tree parsing service, if it's going to be kept around (fingers crossed
that this will be the case!)

> Again, runtime services works and has no bearing on ACPI.

How UEFI passes data to the OS means Runtime Services and ACPI are
essentially the same thing - stuff in the System Table. The System
Table is being hidden in some deep, dark recess past unflattening the
DT and that's not great.

> ACPI is obtained from UEFI by reading the UEFI system table. This is a
> memory mapped block of UUID/Pointer pairs available right at OS entry
> time.

Not as above.. implementation details.

> 3) Windows. They want one interface that works for both Windows and
> Linux.

There is also absolutely Z E R O reason why Microsoft wouldn't just
embed the relevant ACPI information or replacement tables in some
driver somewhere loaded by the kernel on boot, or OS vendors ship a
fancy wrapper of their own. If, in fact, a WindowsLoader wrapper could
put those tables there, and it could check if they're signed via
Secure Boot too, and this could all be controlled very tightly by
those vendors in this case.

If that's how it's gonna get done these days..

If they have a real need to update ACPI tables to add or fix
functionality, they patch the ACPI stuff at runtime just like Linux
does - to the point there are replacement DSDTs or workarounds for
glitchy AML functionality shipped with Windows. It's functionally no
different to go from half-working ACPI AML and tables to patched ACPI
AML and tables, than to go from zero ACPI to having something around
for the rest of the OS.

There are real, some even already existing, ways around this that
other manufacturers and OS vendors are going to have to feel out to
get the interface they need, and actually tell people what their
intent is rather than just keeping it a big secret. What exact parts
of ACPI do they really want, and why? Are they only concerned about
scripting things like fiddly GPIO management for lights and buzzers
and fans, and  abstract SoC-internal buses like SMBIOS that go as far
as giving access to the aforementioned?

Is it JUST the power management (slipping the CPU into some C-State
without the OS having to know precisely how) part they're really
concerned about?

At a certain level most of the features can be described by device
tree, and implemented in AML and the DT and ACPI tables can be used in
collaboration - describe the system the OS must control with it's own
drivers in DT, and reference those ACPI functionalities from the DT.
At the moment the ARM CPU bindings come with properties to enable PSCI
for moving the CPU between states - it could just as well be
enable-method = "acpi" in those nodes, and the method to go find that
ACPI functionality is extremely well-defined.

If we consider that the worst possible thing you can get on an ACPI
system is a screwy DSDT and some AML you have to patch for FFH
functionality which is kind of rotten or wrong, and device trees have
the same problem, it doesn't matter which gets used. There are going
to be systems booting wrong and fans running like jet engines, odd
crashes, CPU states that need to be disabled in *either* method.

> In FDT land the direction has been anything weird needs a device driver.
> We're not going to try and abstract hardware interfaces. That's why I've
> been resistant to adding any kind of bytecode language to FDT.

I am all for ACPI in theory; what's coming up now is the concept that
oh, we want to run bytecode, and we want a full and comprehensive
pre-boot environment too with some way of calling into it from the OS.
I hate to break it to everyone, but this existed in 1995.. we've gone
through OpenFirmware to FDT and stripping all the functionality, to
wanting it all back again in different ways. Since I loved the concept
of OpenFirmware in the first place, I can't say this is a crappy
idea.. in fact, I'm glad it came full circle.

Please can we get these secret cabal server vendors to start out by
implementing the core parts - UEFI (which will provide services at
boot time at least, and flexible and more importantly *reliable*
environments for server platforms) and the Linux boot process.. before
they start asking whether they can use ACPI *or* DT but not both? What
should come out is something a bit better (and more functional) than
LinuxLoader, and hopefully an uptake in people shipping UEFI. If I had
my way I'd make it a requirement for Linux on ARM, servers or not.

It doesn't matter if Linux supports ACPI or not, if Linux is treating
UEFI like a second class citizen to the device tree, and the way to
get to ACPI is through UEFI. From the bottom, the implementation is
already totally bass ackwards. Who knows what is going on top?

I just can't figure out exactly what is going to be in these ARM
processors that can't - and hasn't already in real life - been
implemented in another way, which is just as good. Windows on x86 is
absolutely not Windows on ARM. Windows on ARM already exists - and if
it's already doing ACPI things, then it's doing ACPI things, but this
is totally hidden inside Microsoft's implementation and the firmware
shipping with the Surface tablets right now, which are fundamentally
closed. If it's not doing ACPI things, then I fail to see why a server
needs ACPI but a tablet doesn't. There's REALLY no fundamental
difference here and REALLY no time saved

> At least with IPMI to a BMC it is on a
> separate processor, but encouraging PM to be stuffed into TrustZone is a
> bad precidence. It starts to look a lot like the bad old days of APM
> before ACPI.

Yes, because paranoia about this kind of stuff really helps, right?

I am not sure shipping buggy AML method and an ACPI package that does
the wrong thing and needs a workround, but being able to see it hosing
itself, is any better for being able to patch around it.

If you know the TrustZone solution doesn't work and the system
designers allow some kind of access to the privileged peripherals
(sharing address space etc.) then a Linux driver could always do it
itself. It was only very recently that the Linux on x86 guys realised
that using ACPI to do the power management was a better solution than
the hand-coded driver with no specs.. but when that doesn't work, what
you get is "it's broken".

There's no way around that, except to replace something at the heart
of the system.

What's the difference between flashing the firmware on the server
board to replace the secure firmware with a working version, vs.
flashing the firmware on the server board to replace the ACPI
functionality with a working version, and giving the system a reboot?

> Regardless, they *still* need to work with upstream to get their
> hardware supported.

If any of them were responsible for LinuxLoader, then they immediately
failed to work with upstream by deciding that they should implement
something completely backwards which - as an intended side effect, I
would assume - wouldn't have to touch a single line of kernel code. If
they're going to push a bunch of patches for ACPI on ARM support, then
fixing the booting situation by doing LinuxLoader the correct way to
start.

That is to say, not capitulating to non-existent device tree stalwarts
by refusing to touch their precious baby, but building them a
super-crib with toys and things for them to play with, a proper
wrapper that gets Linux the System Table without having to give it the
device tree first. It can get the DT, ACPI, and Services functionality
from there instead of going round in circles... once they proved that,
we might be less paranoid about their ability to get it right.

>> > Being consistent about our recommendations here would probably be
>> > helpful, but it seems like we don't have any kind of thought out story
>> > yet. That seems like a problem.
>>
>> +100.
>
> yup

Matt <neko@bakuhatsu.net>
