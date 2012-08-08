From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 8 Aug 2012 12:36:41 -0500
Subject: Kernels on Bad Firmware (was Re: kernel entry for thumb2-only cpus)
Message-ID: <CAKGA1b=8gZdgpSJ28Hff+1199J0GarLxZU-NAv7JJDuk+La0ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2012 at 10:33 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Aug 07, 2012 at 05:34:15PM -0500, Matt Sealey wrote:
>> Just because there is a ton of absolutely awful, broken firmware code out there
>> doesn't mean it can and will always be the case, and Linux policy should not
>> be dictated on an architecture basis on a few bad eggs, especially if it means
>> developers in the big wide world have to jump through hoops. Surely it is just
>> as good for Linux to loudly advocate the correct solutions in firmware and
>> implement the workarounds anyway, like a device quirk, rather than just out and
>> out say "firmwares suck, ignore what they did, do it again. We don't trust them
>> and never will."
>
> Sadly, firmware developers have taught us time and time and time and time
> again that they can not be trusted.  You may be the single one who can be
> trusted to validate their stuff properly, but you would be in a severe
> minority if that is true.
>
> Many firmware developers do the barest minimum that's required.  Once their
> job is done, that's the end of the development cycle and nothing further
> happens, not even for bugs.
>
> We've seen this time and time again.  We see it with corrupted ATAG lists,
> we see it with bad memory tags passed to the kernel that the kernel has to
> then screw around with to fix up the broken firmware developers crap.
> Let me show you the crappy workarounds that we have:

No need, we're guilty of that too; line 2600 onwards of
arch/powerpc/kernel/prom_init.c

However we do provide a Forth script that can run the kernel that does
all this, but nobody
would accept removing the fixups from the kernel (an old patch is
inside the zip archive..).

http://www.powerdeveloper.org/platforms/efika/devicetree

We definitely learned from our mistakes - nasty firmware shipped
before Linux had
properly implemented device trees for that SoC, and many many user problems that
just caused support and update hassle.. it costs money to support bad code. Far
more than just spending getting it right in the first place.

The fact we could update it with a script was the awesome thing about
using OpenFirmware -
but U-Boot can do this too, since libfdt is there and it's one option
to enable it to allow script
based modification of the blob. If the DT is hardcoded into the firmware somehow
(CONFIG_OF_CONTROL I think) then platforms can load "boot.scr" from
the root filesystem
(cram or jffs or ubifs if necessary) or similar and fix their device
trees in-place, and if they're
from filesystem and "known bad", fix them after loading them. Highly
embedded platforms
might make this clumsy, but it can ALL be done there.. one problem is,
this is also way, way
too late to do pin muxing :]

On UEFI updates to device tree or ACPI DSDT could be done via a small
EBC loader that
chained to the next boot device.. did anyone make any inroads into
what the real spec
for booting from UEFI should be, by the way, I noticed the Beagle
Tiano Core "only" supports
zImage which is infuriating as this flaunts the existing EFI/UEFI
standard. Wrapping the
kernel in a PECOFF image would not be all that hard and then what you
get is the ability
to write the exact nature of the entry point into the architecture id
field of the header (the
latest spec from 2010 or so includes ARMv7 Thumb2).

> Spot a pattern there?  The one which stands out to me is that boot loaders
> can not get the trivial task of passing the simple information about where
> the RAM is in the system to the kernel right.
>
> Many boot loaders for _years_ have not been able to get the very very
> trivially simple issue of passing the right machine ID value in r1 to the
> kernel either.

Also guilty although we inherited that problem from a large Taiwanese
manufacturer
who hacked U-Boot to load their machine ID from the filesystem
(type_id.bin) before
being able to boot. Otherwise it'd throw in a 0 and everything would
break. We still
have to ship that to update firmware on old machines. It never made
any sense since
you couldn't boot their boards from a common bootloader binary anyway where the
machine_id would be that dynamic..

> Have we tried to push the onus back on firmware people?  I've tried damned
> hard to the extent of preventing some of these work-arounds getting into
> mainline, but the sole result of that was that mainline would not work on
> those platforms;

> on the platforms.  It didn't magically cause the firmware to get fixed in
> any way.  We just ended up with a detrimental situation to everyone because
> mainline just didn't work on those platforms.

I'm fairly sure you're not above saying "tough shit" to these guys, though?

If their firmware is broken they don't get to boot mainline Linux. If
they have to
stick to BSPs, then, that is their problem. If BSPs get hard to maintain, maybe
someone writing those BSPs will finally get up and implement some change.

Worst case, they'd end up with a mainline tree in git somewhere with a couple
patches that never got accepted to enable booting your board.

This is one reason I'm fairly excited about the proposition of UEFI - it's very
well defined on x86 right now and there's a chance to lock down everything
absolutely necessary to perform boot on ARM and have it be there from the
first consumer board, 100%.

> order for that to change, they must change, and they must _earn_ our trust
> that they _can_ be trusted to do a good job.  Until then...

Until then I think what's missing is someone important kernel-side
being involved
in bootloader specifications. ePAPR was a nice try, since Grant Likely got to be
the one to push it through, and we got a nice base for device tree, although we
were on the technical committee for PAPR and ePAPR and founder members
of Power.org at the time, they basically ignored us because what we wanted out
of it was to change the status quo for something better - what they wanted to do
was re-ratify the spec from 10 years ago and put a new trademark stamp on it.

No offense intended to anyone on the list, but Linaro is kind of doing
the same thing
right now on a lot of things. It needs to be specified first then
implemented, but the
"Linux development model" is patch first, patch again, patch again,
patch again and
retrofit the binding to match. Right now it's possible there won't be
a line of common
code between the device tree I just pushed and the one required to
boot the board
in 2 years.. no wonder you can't trust the bootloader guys, they're on
a train going
east at 200kmh, Linux is on a train going west at 200kmh, and you're both trying
to shoot each other. Moving targets are very hard to implement on a consumer
device since you can't force Grandma to update her U-Boot every week and match
a kernel to it. The only reason it's acceptable right now is because
there are no
consumer devices in the mainline Linux ARM tree (except, arguably, ours and the
AlwaysInnovating Touchbook, but I would be happy to know there is
someone running
a phone or another tablet capable of booting a mainline Linux and a
device tree),
only reference designs and platform experiments.

-- 
Matt Sealey <matt@genesi-usa.com>
