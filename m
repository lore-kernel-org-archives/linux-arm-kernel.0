From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Nov 2013 09:45:52 +0100
Subject: ACPI vs DT at runtime
In-Reply-To: <CAOesGMiYyOcvr3Aqs-p8zc=XDwJM9NZtNxtxrTZssc6F=siZCw@mail.gmail.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <3371903.8j54vrCjEN@wuerfel>
 <CAOesGMiYyOcvr3Aqs-p8zc=XDwJM9NZtNxtxrTZssc6F=siZCw@mail.gmail.com>
Message-ID: <201311180945.52764.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 17 November 2013, Olof Johansson wrote:
> On Sun, Nov 17, 2013 at 10:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sunday 17 November 2013 17:18:03 Stefano Stabellini wrote:
> >
> > My point was not that everything would be good if we change the kernel
> > this way, it clearly wouldn't. I think the problem is more the parts
> > for which neither an automated translation nor a unified driver level
> > interface would work well.
> 
> Do you have predictions for what those areas would be? Chances are
> that at least the initial ones can be handled with the methods we
> already have today such as quirks and the like.

I think all DT references that take the form of <&phandle arg1 ...>
are problematic because in ACPI the same things tend to expressed
by a single number (irq, dma, gpio, ...) or just a reference with
no arguments (don't have an example here).

Another difference is things that are numbered on one side but
named on the other. In DT we  have an inconsistent mix of the two,
e.g. DMA requests must be named (per device) while IRQs must be
numbered (per device) and may additionally be named. 

Finally, anything that needs run-time interpretation of AML is
fundamentally hard because the AML would refer to objects that
don't exist when you don't boot from ACPI. This gets worse if you
need to pass ACPI identifiers into EL3 firmware. Because of this,
anything related to runtime PM scares me at the moment, because
there are two conflicting ways to do it: As we discussed before,
the correct way to do this in ACPI is to hide it all from the OS
in AML bytecode and EL2/EL3 firmware calls, but this may not be
possible on all systems and it prevents us from translating into
a format that the drivers can use to call our
regulator/clk/pmdomain interfaces.
Intel's embedded systems will likely get around this by defining
ACPI representations of our existing DT bindings for these
subsystems, which would be possible to translate automatically,
but it seems very silly to use those on servers.

> Once we've seen enough of them, we'll have more knowledge of what a
> new solution really needs to cover. Speculating prematurely will
> likely give us the wrong abstractions (and/or at too high a level,
> causing extra work and churn for everybody). I think we agree that
> holding off is the right answer, just maybe not (yet) what the actual
> solution might be when we start to need it. :)

Yes. Especially for the runtime-pm stuff, someone should probably try
both methods on a couple of systems and then decide which one of them
everybody should use. Unfortunately that alone is going to bind
reviewer resources and take a significant amount of time.

> >> Simply using DT would help avoiding the awkward situation where a driver
> >> of a device only works with one of the two description formats and not
> >> the other.
> >
> > Yes, but remember that Intel still have the problem on their embedded
> > systems, and will want to solve them.
> >
> > For ARM Linux I agree that we're better off not having to change all
> > the drivers again for this, but we will have a growing number of
> > drivers that are shared with ACPI based x86 SoCs. At least there are
> > only one or two vendors of those chips ;-)
> 
> Well, you menion DT-in-ACPI above. If they're really exploring that
> path then a lot will sort itself out from there. Making a decision to
> hold off with ACPI for ARM will help get everybody on the same page if
> they're already considering a solution along those lines.

Possibly, but x86 extending into deeply embedded may also have different
requirements to ARM extending into servers, even if both want to use
ACPI to get there. Some parts will overlap, others won't, and I suspect
that there is more in the second category than people are hoping for.

> >> > > I think we can still treat ACPI on ARM64 as a beginner's mistake and
> >> > > provide hand-written DT blobs for the few systems that start shipping
> >> > > with that.
> >> >
> >> > I think we can do better -- we can ask those vendors to not ship ACPI
> >> > at all, and ship DT themselves (together with us for review, etc).
> 
> Yep, and together for review is a critical part. I'm not saying that
> the ideal solution is a flashed DTB, but it's better than ACPI. A
> flashed DTB that's _easy to update_ as part of an OS install would
> probably be one of the best solutions we could ask for though.

Right: the assumption on the DT boot interfaces is that board designers
make mistakes and are working on moving targets, so we need ways to update
the DTB. By contrast, the assumption on ACPI is that server firmware
authors know what they are doing and you shouldn't let anyone else mess
with the ACPI bits because doing so might damage your hardware. We're
in trouble if the second assumption turns out wrong.

> > The bigger problem is system vendors
> > we don't talk to. They are going to to do any number of crazy things
> > in their private kernels:
> >
> > * Board files
> > * Hardcoded platform devices with no multiplatform support
> > * Custom hypervisor (EL2 or EL3) interfaces for probing
> > * FEX
> > * ACPI
> > * Some other firmware ported over from their MIPS products
> > * Incompatible Open Firmware
> > * Incompatible DT extensions
> > * ...
> 
> Given that we have a documented boot protocol today, it shouldn't
> matter much if someone ports over some MIPS firmware (we did add OF
> client interface to CFE at PA Semi, and that worked well for us :-).
> Most of the others listed above can hopefully be avoided by us having
> appropriate solutions in-kernel today that they can reuse. I.e. FEX
> happened because DT didn't exist at the time.
> 
> ACPI is a big problem here in that sense: Vendors have been told to
> use it, but there's no infrastructure, and even if it would be there
> it would be immature and we don't really know what we want from it.
> 
> Board files and hardcoded devices are things we've dealt with already
> and know what to do with, so I'm less worried about that. And finally,
> custom firmware interfaces should hopefully be rare given the
> reference PSCI implementation from ARM, but we can deal with it if we
> have to.

Yes, the only real worry is if someone does their own firmware interfaces
the way that Sony did on the PS3, which definitely requires custom
APIs in the kernel. All others can be handled in some way by ignoring
the provided interfaces and replacing them with DT. We might need some
boot wrapper for cases where someone ignored the documented boot
interfaces, but that would only be likely for systems designed for
another OS.
 
	Arnd
