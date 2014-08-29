From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Fri, 29 Aug 2014 15:51:19 +0000
Subject: [PATCH V2 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <20140828145635.GL14650@leverpostej>
References: <1409219706-14843-1-git-send-email-bhupesh.sharma@freescale.com>
 <1409219706-14843-5-git-send-email-bhupesh.sharma@freescale.com>
 <20140828145635.GL14650@leverpostej>
Message-ID: <18f8ee091e8847c0bcfba1ef04907a71@BN1PR03MB220.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for your review.
Please see my comments inline.


> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Thursday, August 28, 2014 8:27 PM
> To: Sharma Bhupesh-B45370
> Cc: Catalin Marinas; Will Deacon; arnd at arndb.de;
> grant.likely at secretlab.ca; Marc Zyngier; rob.herring at linaro.org; linux-
> arm-kernel at lists.infradead.org; Yoder Stuart-B08248; Basu Arnab-B45036
> Subject: Re: [PATCH V2 4/6] arm64: Add DTS support for FSL's LS2085A SoC
> 
> Hi Bhupesh,
> 
> This looks generally good, I just have a few questions and minor change
> suggestions below.
> 
> On Thu, Aug 28, 2014 at 10:55:04AM +0100, Bhupesh Sharma wrote:
> > This patch adds the device tree support for FSL LS2085A SoC based on
> > ARMv8 architecture.
> >
> > Following levels of DTSI/DTS files have been created for the LS2085A
> > SoC family:
> >
> > - fsl-ls2085a.dtsi:
> > DTS-Include file for FSL LS2085A SoC.
> >
> > - fsl-ls2085a-simu.dts:
> > DTS file for FSL LS2085a software simulator model.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > Signed-off-by: Arnab Basu <arnab.basu@freescale.com>
> > Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> > ---
> >  arch/arm64/boot/dts/fsl-ls2085a-simu.dts |   26 +++++++
> >  arch/arm64/boot/dts/fsl-ls2085a.dtsi     |  120
> ++++++++++++++++++++++++++++++
> >  2 files changed, 146 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/fsl-ls2085a-simu.dts
> >  create mode 100644 arch/arm64/boot/dts/fsl-ls2085a.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/fsl-ls2085a-simu.dts
> > b/arch/arm64/boot/dts/fsl-ls2085a-simu.dts
> > new file mode 100644
> > index 0000000..3c0f953
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/fsl-ls2085a-simu.dts
> > @@ -0,0 +1,26 @@
> > +/*
> > + * Device Tree file for Freescale LS2085a software Simulator model
> > + *
> > + * Copyright (C) 2014, Freescale Semiconductor
> > + *
> > + * Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +/include/ "fsl-ls2085a.dtsi"
> > +
> > +/ {
> > +	model = "Freescale Layerscape 2085a software Simulator model";
> > +	compatible = "fsl,ls2085a-simu", "fsl,ls2085a";
> > +
> > +	ethernet at 2210000 {
> > +		compatible = "smsc,lan91c111";
> > +		reg = <0x0 0x2210000 0x0 0x100>;
> > +		interrupts = <0 58 0x1>;
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/fsl-ls2085a.dtsi
> > b/arch/arm64/boot/dts/fsl-ls2085a.dtsi
> > new file mode 100644
> > index 0000000..a1692c2
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/fsl-ls2085a.dtsi
> > @@ -0,0 +1,120 @@
> > +/*
> > + * Device Tree Include file for Freescale Layerscape-2085A family SoC.
> > + *
> > + * Copyright (C) 2014, Freescale Semiconductor
> > + *
> > + * Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> > +
> > +/ {
> > +	compatible = "fsl,ls2085a";
> > +	interrupt-parent = <&gic>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	cpus {
> > +		#address-cells = <2>;
> > +		#size-cells = <0>;
> > +
> > +		/* We have 4 clusters having 2 Cortex-A57 cores each */
> > +		cpu at 0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a57";
> > +			reg = <0x0 0x0>;
> > +		};
> > +
> > +		cpu at 1 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a57";
> > +			reg = <0x0 0x1>;
> > +		};
> > +
> > +		cpu at 100 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a57";
> > +			reg = <0x0 0x100>;
> > +		};
> > +
> > +		cpu at 101 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a57";
> > +			reg = <0x0 0x101>;
> > +		};
> > +
> > +		cpu at 200 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a57";
> > +			reg = <0x0 0x200>;
> > +		};
> > +
> > +		cpu at 201 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a57";
> > +			reg = <0x0 0x201>;
> > +		};
> > +
> > +		cpu at 300 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a57";
> > +			reg = <0x0 0x300>;
> > +		};
> > +
> > +		cpu at 301 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a57";
> > +			reg = <0x0 0x301>;
> > +		};
> > +	};
> > +
> > +	gic: interrupt-controller at 6000000 {
> > +		compatible = "arm,gic-v3";
> > +		reg = <0x0 0x06000000 0 0x10000>, /* GIC Dist */
> > +		      <0x0 0x06100000 0 0x100000>; /* GICR (RD_base +
> SGI_base) */
> > +		#interrupt-cells = <3>;
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +		interrupt-controller;
> > +		interrupts = <1 9 0x4>;
> > +	};
> 
> The GIC node doesn't have any sub-nodes, so I think the #address-cells,
> #size-cells, and ranges properties can go for now.

Ok. V3 will address the change.

> 
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <1 13 0x1>, /* Physical Secure PPI, edge
> triggered */
> > +			     <1 14 0x1>, /* Physical Non-Secure PPI, edge
> triggered */
> > +			     <1 11 0x1>, /* Virtual PPI, edge triggered */
> > +			     <1 10 0x1>; /* Hypervisor PPI, edge triggered */
> > +	};
> 
> In this SoC, are there low-power states the CPUs can be placed into where
> the architected timers can lose state?

Yes the SoC has low-power states, however we are yet to work on the power management
s/w layers. Probably a patch later down the lane would add this capability.

> 
> If so, do you any auxiliary timers that aren't cpu-local?

Yes, the SoC has 4 flextimer IP instances, but I am yet to test them and hence support for them
is still to be added. Probably a patch later down the lane would add this capability.

> 
> > +
> > +	serial0: serial at 21c0500 {
> > +		device_type = "serial";
> > +		compatible = "fsl,ns16550", "ns16550a";
> > +		reg = <0x0 0x21c0500 0x0 0x100>;
> > +		clock-frequency = <0>;	/* Updated by bootloader */
> > +		interrupts = <0 32 0x1>; /* edge triggered */
> > +	};
> > +
> > +	serial1: serial at 21c0600 {
> > +		device_type = "serial";
> > +		compatible = "fsl,ns16550", "ns16550a";
> > +		reg = <0x0 0x21c0600 0x0 0x100>;
> > +		clock-frequency = <0>; 	/* Updated by bootloader */
> > +		interrupts = <0 32 0x1>; /* edge triggered */
> > +	};
> 
> Just to check: do the two UARTs share the same IRQ, or is that a copy-
> paste error?

The two UARTs do share the same IRQ.

> 
> > +
> > +	fsl_mc: fsl-mc at 80c000000 {
> > +		compatible = "fsl,qoriq-mc";
> > +		reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base
> */
> > +		      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
> > +		};
> 
> Nit: the '}' is indented a tab too far.

Oops. Ok.

> 
> > +
> > +	memory at 80000000 {
> > +		device_type = "memory";
> > +		reg = <0x00000000 0x80000000 0 0x80000000>;
> > +		      /* DRAM space 1 - 2 GB DRAM */
> > +	};
> 
> Does that mean:
> 
>  - This is "DRAM space 1", populated with 2GB?
> 
> Or:
> 
>  - The DRAM space can be populated with 1 to 2 GB?
> 
> If the former, s/ - /: / for clarity.
> 
> If the latter, it might make sense to move that into board-specific dts
> files. If this can be dynamically populated ideally the firmware/loader
> would fix this up (assuming it can probe the memory).

If the former. I will fix it up in v3.

> 
> Also, can we move the memory node up to just after /cpus? That would
> match the other dts files we have.

Sure. V3 will address this change.

Regards,
Bhupesh

> 
> Cheers,
> Mark.
