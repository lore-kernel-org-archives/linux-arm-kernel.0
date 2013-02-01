From: horms@verge.net.au (Simon Horman)
Date: Fri, 1 Feb 2013 09:11:19 +0900
Subject: [PATCH 2/4] ARM: mach-shmobile: r8a7779: Allow initialisation of
 GIC by DT
In-Reply-To: <20130131123213.GB7235@e106331-lin.cambridge.arm.com>
References: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
 <1359597051-32700-3-git-send-email-horms+renesas@verge.net.au>
 <20130131123213.GB7235@e106331-lin.cambridge.arm.com>
Message-ID: <20130201001119.GO10312@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 12:32:13PM +0000, Mark Rutland wrote:
> Hi Simon,
> 
> On Thu, Jan 31, 2013 at 01:50:49AM +0000, Simon Horman wrote:
> > This allows the GIC interrupt controller of the  r8a7779 SoC to be
> > initialised using a flattened device tree blob.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/boot/dts/r8a7779.dtsi               |   40 ++++++++++++++++++++++++++
> >  arch/arm/mach-shmobile/include/mach/common.h |    1 +
> >  arch/arm/mach-shmobile/intc-r8a7779.c        |   27 +++++++++++++----
> >  3 files changed, 62 insertions(+), 6 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/r8a7779.dtsi
> > 
> > diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> > new file mode 100644
> > index 0000000..eadc12e
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/r8a7779.dtsi
> > @@ -0,0 +1,40 @@
> > +/*
> > + * Device Tree Source for Renesas r8a7740
> > + *
> > + * Copyright (C) 2013 Renesas Solutions Corp.
> > + * Copyright (C) 2013 Simon Horman
> > + *
> > + * This file is licensed under the terms of the GNU General Public License
> > + * version 2.  This program is licensed "as is" without any warranty of any
> > + * kind, whether express or implied.
> > + */
> > +
> > +/include/ "skeleton.dtsi"
> > +
> > +/ {
> > +	compatible = "renesas,r8a7779";
> > +
> > +	cpus {
> > +		cpu at 0 {
> > +			compatible = "arm,cortex-a9";
> > +		};
> > +		cpu at 1 {
> > +			compatible = "arm,cortex-a9";
> > +		};
> > +		cpu at 2 {
> > +			compatible = "arm,cortex-a9";
> > +		};
> > +		cpu at 3 {
> > +			compatible = "arm,cortex-a9";
> > +		};
> > +	};
> 
> Sorry to sound like a broken record, but it'd be good to see reg and
> device_type set here.

Sure, will do.

> > +
> > +        gic: interrupt-controller at f0001000 {
> > +                compatible = "arm,cortex-a9-gic";
> > +                #interrupt-cells = <3>;
> > +                #address-cells = <1>;
> 
> Why is #address-cells needed here (and without #size-cells)? I see it's in the
> binding document example, but I can't figure out why.

Its here because I copied the example.
I will see about removing it from here.

> > +                interrupt-controller;
> > +                reg = <0xf0001000 0x1000>,
> > +                      <0xf0000100 0x100>;
> > +        };
> > +};
> 
> [...]
> 
> Thanks,
> Mark.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
