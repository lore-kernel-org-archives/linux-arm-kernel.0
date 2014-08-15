From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Aug 2014 21:49:44 +0200
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <CAOesGMiOzRYmmYcBV=eFr8U-e_BJAUg9gpnT0DPwJuyxBz9-1g@mail.gmail.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <8599266.1aeEWcB8r7@wuerfel>
 <CAOesGMiOzRYmmYcBV=eFr8U-e_BJAUg9gpnT0DPwJuyxBz9-1g@mail.gmail.com>
Message-ID: <201408152149.44283.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 August 2014, Olof Johansson wrote:
> On Thu, Aug 14, 2014 at 1:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 14 August 2014 11:27:23 Catalin Marinas wrote:
> >
> > I would expect that Juno is a superset of what servers need. If this
> > ACPI patch set is sufficient to support every device present on Juno
> > with an ACPI firmware, what would be a strong indication that server
> > platforms work as well.
> >
> > OTOH, if ACPI on Juno only supports half the features that the hardware
> > has, that doesn't tell us much about the suitability of ACPI for any
> > real-world system, server or not.
> 
> Juno is lacking in several components compared to a server platform,
> it doesn't have PCIe, SATA, or real ethernet. So it's in many ways
> just a few cores with RAM and a few slow interfaces.

I see. I wouldn't really expect SATA in a server, but the lack of
PCIe of course also implies that there is no SAS/NVMe/FCoE storage
either.

Some of the slow interfaces may actually be more interesting,
since PCI and anything attached to it should (at least in theory)
be fully discoverable and not need much ACPI support at all.

The parts that I'm particularly interested in are the interaction
with the BMC and embedded controller, and how the power management
for nondiscoverable devices is implemented through AML.

> The scary parts from the ACPI 5.1 docs (the peripheral ones in
> particular) are around the modelling of clocks and other things that
> we thought ACPI was going to stay away from. Until we see how steep
> that slope is, we're better off taking it easy with merging the
> support. It could get quite messy very quickly, and we'd be stuck
> supporting whatever solutions are tried in the first ACPI generations
> forever if we do enable them now. That's the main reason for holding
> off and being conservative (and seeing several real platforms and how
> they end up modelling these things).

Agreed. I think we had already concluded previously when discussing this
patch that the clock management in APCI-5.1 should not be used on ARM64,
but I think there is a problem one level deeper: The 5.0 and 5.1 versions
apparently add a lot of new features that are meant for either ARM64
servers or embedded x86 machines. These two typically have conflicting
requirements, and it would be better for the specification itself to
provide clearer statements to which parts apply in what use case rather
than us (the Linux people) making claims about what parts of the spec
are acceptable or not.

There are already two specified classes of systems, the legacy x86
and itanium machines, and the "reduced hardware" profile, which
apparently covers both of the new types of machines mentioned above.

What would be the process to get a clarification into the next version
of ACPI that makes them more distinct?

	Arnd
