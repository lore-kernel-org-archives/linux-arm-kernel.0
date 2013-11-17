From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Nov 2013 19:10:51 +0100
Subject: ACPI vs DT at runtime
In-Reply-To: <alpine.DEB.2.02.1311171705130.4714@kaball.uk.xensource.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <CAOesGMhkCn2zeJj_ZZAZu_wJya-4evWEqNHpVJEpjxzWHVWY3A@mail.gmail.com>
 <alpine.DEB.2.02.1311171705130.4714@kaball.uk.xensource.com>
Message-ID: <3371903.8j54vrCjEN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 17 November 2013 17:18:03 Stefano Stabellini wrote:
> On Fri, 15 Nov 2013, Olof Johansson wrote:
> > On Fri, Nov 15, 2013 at 12:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Friday 15 November 2013, Olof Johansson wrote:
> > >> So, I'm strongly urging that whatever the server guys try to do, it
> > >> will in the end result in the ACPI data being translated into DT
> > >> equivalents, such that the kernel only needs to handle data via DT.
> > >
> > > I don't think that a translation layer is the answer, I see the problem
> > > more in things that cannot be translated automatically. The parts that
> > > are similar enough to allow translation could also just be handled by
> > > a thin abstraction layer in the kernel, which I think we will see
> > > on embedded x86 with DT-in-ACPI-syntax.
> > 
> > I'm not so sure that converting everything yet again to another
> > abstraction layer is a good solution. We've got one level of
> > abstraction today -- DT. And we've got the un-abstracted layer of
> > platform devices. Churning all drivers yet again seems like the wrong
> > way to do this. For things that we can pre-populate instead of adding
> > runtime abstraction, we should.

My point was not that everything would be good if we change the kernel
this way, it clearly wouldn't. I think the problem is more the parts
for which neither an automated translation nor a unified driver level
interface would work well.

> Simply using DT would help avoiding the awkward situation where a driver
> of a device only works with one of the two description formats and not
> the other.

Yes, but remember that Intel still have the problem on their embedded
systems, and will want to solve them.

For ARM Linux I agree that we're better off not having to change all
the drivers again for this, but we will have a growing number of
drivers that are shared with ACPI based x86 SoCs. At least there are
only one or two vendors of those chips ;-)

> > > I think we can still treat ACPI on ARM64 as a beginner's mistake and
> > > provide hand-written DT blobs for the few systems that start shipping
> > > with that.
> > 
> > I think we can do better -- we can ask those vendors to not ship ACPI
> > at all, and ship DT themselves (together with us for review, etc).
> 
> They can ship with ACPI if they want to, what is important is that they
> ship with device tree too.
> Encouraging them to do that is definitely the right thing to do today,
> regardless of the medium to long term ACPI strategy for the Linux
> kernel.

I'm skeptical about getting people to ship both, except if they
want to support multiple operating systems. For those vendors
we are talking to, we are possibly able to convince them to drop
ACPI for Linux based servers. The bigger problem is system vendors
we don't talk to. They are going to to do any number of crazy things
in their private kernels:

* Board files
* Hardcoded platform devices with no multiplatform support
* Custom hypervisor (EL2 or EL3) interfaces for probing
* FEX
* ACPI
* Some other firmware ported over from their MIPS products
* Incompatible Open Firmware
* Incompatible DT extensions
* ...

The only thing we really have a handle on is stuff that gets submitted
for inclusion into Linux. One would hope that this would include
any server platform, but I think the people trying get into that
market are still learning about how to do these things.

> > Especially since doing a broken ACPI implementation today _just for
> > us_ will just distract them. If they need one for RT, fine. As I
> > mentioned elsewhere, shipping a flashed DTB is no different from
> > shipping ACPI from a future-proof point of view; we'll end up
> > overriding either at some point once we figure out things better.
> 
> Well said.

+1

	Arnd
