From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 30 Jul 2014 19:35:14 +0100
Subject: [PATCH 2/5] arm64, thunder: Add initial dts for Cavium Thunder SoC
In-Reply-To: <CAOesGMj9PnfddJO7PorZ7U2OoBFBe4LqONRnbJeMiEkQV1mmWw@mail.gmail.com>
References: <1406732794-20920-1-git-send-email-rric@kernel.org>
 <1406732794-20920-3-git-send-email-rric@kernel.org>
 <CAOesGMj9PnfddJO7PorZ7U2OoBFBe4LqONRnbJeMiEkQV1mmWw@mail.gmail.com>
Message-ID: <20140730183514.GH20162@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 07:12:17PM +0100, Olof Johansson wrote:
> On Wed, Jul 30, 2014 at 8:06 AM, Robert Richter <rric@kernel.org> wrote:
> > From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> >
> > Add initial device tree nodes for Cavium Thunder SoCs with support of
> > 48 cores and gicv3. The dts file requires further changes, esp. for
> > pci, gicv3-its and smmu. This changes will be added later together
> > with the device drivers.
> >
> > Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> > Signed-off-by: Robert Richter <rrichter@cavium.com>
> > ---
> >  arch/arm64/boot/dts/Makefile         |   1 +
> >  arch/arm64/boot/dts/thunder-88xx.dts | 387 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 388 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/thunder-88xx.dts
> >
> > diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> > index c52bdb051f66..f8001a62029c 100644
> > --- a/arch/arm64/boot/dts/Makefile
> > +++ b/arch/arm64/boot/dts/Makefile
> > @@ -1,3 +1,4 @@
> > +dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
> >  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
> >  dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
> >
> > diff --git a/arch/arm64/boot/dts/thunder-88xx.dts b/arch/arm64/boot/dts/thunder-88xx.dts
> > new file mode 100644
> > index 000000000000..4cf20ac9138b
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/thunder-88xx.dts
> > @@ -0,0 +1,387 @@
> > +/*
> > + * Cavium Thunder DTS file
> > + *
> > + * Copyright (C) 2013, Cavium Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + */
> > +/dts-v1/;
> > +
> > +/* Reserving first 12MB of DDR for firmware */
> > +/memreserve/ 0x00000000 0x00c00000;
> > +
> > +/ {
> > +       model = "Cavium ThunderX CN88XX Family";
> > +       compatible = "cavium,thunder-88xx";
> 
> Hmm. I take it this platform is compliant with some level of SBSA? We
> should probably have a compatible value for that so that platforms can
> communicate it.
> 
> Mark, are there already plans for this?

Not so far, but my monitor now has a sticky note telling me to look into
it. :)

Many of the useful properties provided by SBSA are already described
elsewhere (e.g. page and ASID size can be found in ID registers), and
hardware properties it mandates (e.g. PPI assignment for level 2
compliant systems) will be described elsewhere.

I'll have to read the spec in more detail to figure out what we can
derive from an SBSA compliance property. Regardless it probably makes
sense to have a compatible string or other property on the root node; at
worst it only costs us a few bytes.

Thanks,
Mark.
