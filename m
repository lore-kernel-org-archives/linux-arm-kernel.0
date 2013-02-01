From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 Feb 2013 11:31:50 +0000
Subject: [PATCH 2/4] ARM: mach-shmobile: r8a7779: Allow initialisation
 of GIC by DT
In-Reply-To: <20130201043931.GA11947@verge.net.au>
References: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
 <1359597051-32700-3-git-send-email-horms+renesas@verge.net.au>
 <20130131123213.GB7235@e106331-lin.cambridge.arm.com>
 <20130201001119.GO10312@verge.net.au>
 <20130201003410.GA30007@verge.net.au>
 <20130201014706.GA14046@verge.net.au>
 <20130201043931.GA11947@verge.net.au>
Message-ID: <20130201113150.GA2094@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 04:39:31AM +0000, Simon Horman wrote:
> On Fri, Feb 01, 2013 at 10:47:06AM +0900, Simon Horman wrote:
> > On Fri, Feb 01, 2013 at 09:34:10AM +0900, Simon Horman wrote:
> > > On Fri, Feb 01, 2013 at 09:11:19AM +0900, Simon Horman wrote:
> > > > On Thu, Jan 31, 2013 at 12:32:13PM +0000, Mark Rutland wrote:
> > > > > Hi Simon,
> > > > > 
> > > > > On Thu, Jan 31, 2013 at 01:50:49AM +0000, Simon Horman wrote:
> > > > > > This allows the GIC interrupt controller of the  r8a7779 SoC to be
> > > > > > initialised using a flattened device tree blob.
> > > > > > 
> > > > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > > > ---
> > > > > >  arch/arm/boot/dts/r8a7779.dtsi               |   40 ++++++++++++++++++++++++++
> > > > > >  arch/arm/mach-shmobile/include/mach/common.h |    1 +
> > > > > >  arch/arm/mach-shmobile/intc-r8a7779.c        |   27 +++++++++++++----
> > > > > >  3 files changed, 62 insertions(+), 6 deletions(-)
> > > > > >  create mode 100644 arch/arm/boot/dts/r8a7779.dtsi
> > > > > > 
> > > > > > diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> > > > > > new file mode 100644
> > > > > > index 0000000..eadc12e
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm/boot/dts/r8a7779.dtsi
> > > > > > @@ -0,0 +1,40 @@
> > > > > > +/*
> > > > > > + * Device Tree Source for Renesas r8a7740
> > > > > > + *
> > > > > > + * Copyright (C) 2013 Renesas Solutions Corp.
> > > > > > + * Copyright (C) 2013 Simon Horman
> > > > > > + *
> > > > > > + * This file is licensed under the terms of the GNU General Public License
> > > > > > + * version 2.  This program is licensed "as is" without any warranty of any
> > > > > > + * kind, whether express or implied.
> > > > > > + */
> > > > > > +
> > > > > > +/include/ "skeleton.dtsi"
> > > > > > +
> > > > > > +/ {
> > > > > > +	compatible = "renesas,r8a7779";
> > > > > > +
> > > > > > +	cpus {
> > > > > > +		cpu at 0 {
> > > > > > +			compatible = "arm,cortex-a9";
> > > > > > +		};
> > > > > > +		cpu at 1 {
> > > > > > +			compatible = "arm,cortex-a9";
> > > > > > +		};
> > > > > > +		cpu at 2 {
> > > > > > +			compatible = "arm,cortex-a9";
> > > > > > +		};
> > > > > > +		cpu at 3 {
> > > > > > +			compatible = "arm,cortex-a9";
> > > > > > +		};
> > > > > > +	};
> > > > > 
> > > > > Sorry to sound like a broken record, but it'd be good to see reg and
> > > > > device_type set here.
> > > > 
> > > > Sure, will do.
> > > > 
> > > > > > +
> > > > > > +        gic: interrupt-controller at f0001000 {
> > > > > > +                compatible = "arm,cortex-a9-gic";
> > > > > > +                #interrupt-cells = <3>;
> > > > > > +                #address-cells = <1>;
> > > > > 
> > > > > Why is #address-cells needed here (and without #size-cells)? I see it's in the
> > > > > binding document example, but I can't figure out why.
> > > > 
> > > > Its here because I copied the example.
> > > > I will see about removing it from here.
> > > > 
> > > > > > +                interrupt-controller;
> > > > > > +                reg = <0xf0001000 0x1000>,
> > > > > > +                      <0xf0000100 0x100>;
> > > > > > +        };
> > > > > > +};
> > > 
> > > A revised patch is below. I should also remove "#address-cells = <1>" from
> > > gic in arch/arm/boot/dts/sh73a0.dtsi if it is indeed unnecessary.

I just poked Rob and Grant in another subthread. Hopefully they'll be able to
tell us if there's something we missed.

> 
> One more time:
> 
> From 6031d5177193431a57392dfd2f38be0676bdb535 Mon Sep 17 00:00:00 2001
> From: Simon Horman <horms+renesas@verge.net.au>
> Date: Tue, 29 Jan 2013 14:21:46 +0900
> Subject: [PATCH] ARM: mach-shmobile: r8a7779: Allow initialisation of GIC by
>  DT
> 
> This allows the GIC interrupt controller of the  r8a7779 SoC to be
> initialised using a flattened device tree blob.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> v3
> * Fix copy-paste error and use unique reg values for each CPU
> 
> v2
> As suggested by Mark Rutland
> * Add reg and device_type to cpus
> * Remove #address-cells from gic
> ---
>  arch/arm/boot/dts/r8a7779.dtsi               |   50 ++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/common.h |    1 +
>  arch/arm/mach-shmobile/intc-r8a7779.c        |   27 ++++++++++----
>  3 files changed, 72 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/boot/dts/r8a7779.dtsi
> 
> diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> new file mode 100644
> index 0000000..8c6d52c
> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7779.dtsi
> @@ -0,0 +1,50 @@
> +/*
> + * Device Tree Source for Renesas r8a7740
> + *
> + * Copyright (C) 2013 Renesas Solutions Corp.
> + * Copyright (C) 2013 Simon Horman
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	compatible = "renesas,r8a7779";
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <0>;
> +		};
> +		cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <1>;
> +		};
> +		cpu at 2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <2>;
> +		};
> +		cpu at 3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <3>;
> +		};
> +	};
> +
> +        gic: interrupt-controller at f0001000 {
> +                compatible = "arm,cortex-a9-gic";
> +                #interrupt-cells = <3>;
> +                interrupt-controller;
> +                reg = <0xf0001000 0x1000>,
> +                      <0xf0000100 0x100>;
> +        };
> +};

Thanks, this looks much better now! :)

For the dtsi: Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
