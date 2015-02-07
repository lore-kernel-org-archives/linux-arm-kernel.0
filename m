From: arnd@arndb.de (arnd at arndb.de)
Date: Sat, 7 Feb 2015 22:24:35 +0100 (CET)
Subject: [PATCH] kvmtool: don't use PCI config space IRQ line field
In-Reply-To: <20150206190719.GG24099@arm.com>
References: <4324891.mqG6Yyfi6J@wuerfel>
 <1423064390-15269-1-git-send-email-andre.przywara@arm.com>
 <20150206185527.GC24099@arm.com>
 <CAFEAcA_zKisc6YOm_4vqpOWCkG5aeyfha1u_-8=DeT6CCRJUwQ@mail.gmail.com>
 <20150206190719.GG24099@arm.com>
Message-ID: <375964521.209613.1423344275182.JavaMail.open-xchange@oxbaltgw04.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Will Deacon <will.deacon@arm.com> hat am 6. Februar 2015 um 20:07 geschrieben:
> On Fri, Feb 06, 2015 at 07:02:25PM +0000, Peter Maydell wrote:
> > On 6 February 2015 at 18:55, Will Deacon <will.deacon@arm.com> wrote:
> > > On Wed, Feb 04, 2015 at 03:39:50PM +0000, Andre Przywara wrote:
> > >> In PCI config space there is an interrupt line field (offset 0x3f),
> > >> which is used to initially communicate the IRQ line number from
> > >> firmware to the OS. _Hardware_ should never use this information,
> > >> as the OS is free to write any information in there.
> > >
> > > Is this true even with probe-only? I appreciate that this isn't a BAR,
> > > but it still feels odd for Linux to write this in that case.
> >
> > The hardware (model) shouldn't be doing anything with the value
> > in this register anyway, so I think this change to kvmtool is
> > correct regardless of Linux's behaviour.
>
> Well, kvmtool is also pretending to be firmware in this case, which is why
> it passes things like probe-only and PSCI nodes.

And this means that we should expect kvmtool to initialize these fields to
a meaningful value, but not care if the OS writes something else to them.

An interesting question is what value kvmtool should write in there. IIRC,
SBSA says that the each interrupt line on the PCI should be an SPI of the
primary GIC, so I suppose we could write the SPI number, although that would
be different of the traditional Linux interrupt number user for that SPI,
which has an offset added to it.

Of course for any hardware that is not SBSA compliant in this regard and
connects the interrupt line to a secondary irqchip (e.g. gpio), there is
no good 8-bit number we can write in here. Also, Linux does not care,
because it gets the number from DT rather than the PCI config space.

     Arnd
