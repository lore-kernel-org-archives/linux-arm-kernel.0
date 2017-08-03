From: andy.tang@nxp.com (Andy Tang)
Date: Thu, 3 Aug 2017 08:39:16 +0000
Subject: [PATCH 2/2] arm64: dts: ls2088a: add cpu idle support
In-Reply-To: <20170803014007.GC31819@dragon>
References: <1501053893-20897-1-git-send-email-andy.tang@nxp.com>
 <1501053893-20897-2-git-send-email-andy.tang@nxp.com>
 <20170803014007.GC31819@dragon>
Message-ID: <AM5PR0402MB2818861202D11C4255689532F3B10@AM5PR0402MB2818.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Please see my explanation inline.

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Thursday, August 03, 2017 9:40 AM
> To: Andy Tang <andy.tang@nxp.com>
> Cc: mark.rutland at arm.com; devicetree at vger.kernel.org;
> catalin.marinas at arm.com; will.deacon at arm.com; linux-
> kernel at vger.kernel.org; robh+dt at kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 2/2] arm64: dts: ls2088a: add cpu idle support
> 
> On Wed, Jul 26, 2017 at 03:24:53PM +0800, andy.tang at nxp.com wrote:
> > From: Yuantian Tang <andy.tang@nxp.com>
> >
> > ls2088a supports another cpu idle state which is pw20 which saves more
> > power when cpu is idle.
> > It was implemented through psci firmware.
> >
> > Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> 
> Can you explain a bit in the commit log why psci node is being added in fsl-
> ls208xa.dtsi while you are only adding idle state for ls2088a?  Does that mean
> ls2088a and ls2080a gets different idle implementation?
> 
IDLE implementation is same on both ls2080a and ls2088a.  it is just there is no 
Requirement for ls2080a though. Still it is better to update both.

I will resend the patch adding ls2080a supports.

Regards,
Andy

> Shawn
> 
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi | 17 +++++++++++++++++
> > arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi |  5 +++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> > index 5c695c6..6aa319d 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> > @@ -53,6 +53,7 @@
> >  		compatible = "arm,cortex-a72";
> >  		reg = <0x0>;
> >  		clocks = <&clockgen 1 0>;
> > +		cpu-idle-states = <&CPU_PW20>;
> >  		next-level-cache = <&cluster0_l2>;
> >  		#cooling-cells = <2>;
> >  	};
> > @@ -62,6 +63,7 @@
> >  		compatible = "arm,cortex-a72";
> >  		reg = <0x1>;
> >  		clocks = <&clockgen 1 0>;
> > +		cpu-idle-states = <&CPU_PW20>;
> >  		next-level-cache = <&cluster0_l2>;
> >  	};
> >
> > @@ -70,6 +72,7 @@
> >  		compatible = "arm,cortex-a72";
> >  		reg = <0x100>;
> >  		clocks = <&clockgen 1 1>;
> > +		cpu-idle-states = <&CPU_PW20>;
> >  		next-level-cache = <&cluster1_l2>;
> >  		#cooling-cells = <2>;
> >  	};
> > @@ -79,6 +82,7 @@
> >  		compatible = "arm,cortex-a72";
> >  		reg = <0x101>;
> >  		clocks = <&clockgen 1 1>;
> > +		cpu-idle-states = <&CPU_PW20>;
> >  		next-level-cache = <&cluster1_l2>;
> >  	};
> >
> > @@ -88,6 +92,7 @@
> >  		reg = <0x200>;
> >  		clocks = <&clockgen 1 2>;
> >  		next-level-cache = <&cluster2_l2>;
> > +		cpu-idle-states = <&CPU_PW20>;
> >  		#cooling-cells = <2>;
> >  	};
> >
> > @@ -96,6 +101,7 @@
> >  		compatible = "arm,cortex-a72";
> >  		reg = <0x201>;
> >  		clocks = <&clockgen 1 2>;
> > +		cpu-idle-states = <&CPU_PW20>;
> >  		next-level-cache = <&cluster2_l2>;
> >  	};
> >
> > @@ -104,6 +110,7 @@
> >  		compatible = "arm,cortex-a72";
> >  		reg = <0x300>;
> >  		clocks = <&clockgen 1 3>;
> > +		cpu-idle-states = <&CPU_PW20>;
> >  		next-level-cache = <&cluster3_l2>;
> >  		#cooling-cells = <2>;
> >  	};
> > @@ -113,6 +120,7 @@
> >  		compatible = "arm,cortex-a72";
> >  		reg = <0x301>;
> >  		clocks = <&clockgen 1 3>;
> > +		cpu-idle-states = <&CPU_PW20>;
> >  		next-level-cache = <&cluster3_l2>;
> >  	};
> >
> > @@ -131,6 +139,15 @@
> >  	cluster3_l2: l2-cache3 {
> >  		compatible = "cache";
> >  	};
> > +
> > +	CPU_PW20: cpu-pw20 {
> > +		compatible = "arm,idle-state";
> > +		idle-state-name = "PW20";
> > +		arm,psci-suspend-param = <0x00010000>;
> > +		entry-latency-us = <2000>;
> > +		exit-latency-us = <2000>;
> > +		min-residency-us = <6000>;
> > +	};
> >  };
> >
> >  &pcie1 {
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> > index 94cdd30..205b7f7 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> > @@ -118,6 +118,11 @@
> >  		interrupts = <1 7 0x8>; /* PMU PPI, Level low type */
> >  	};
> >
> > +	psci {
> > +		compatible = "arm,psci-0.2";
> > +		method = "smc";
> > +	};
> > +
> >  	soc {
> >  		compatible = "simple-bus";
> >  		#address-cells = <2>;
> > --
> > 2.1.0.27.g96db324
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
