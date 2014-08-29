From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 29 Aug 2014 18:47:57 +0100
Subject: [PATCH V2 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <18f8ee091e8847c0bcfba1ef04907a71@BN1PR03MB220.namprd03.prod.outlook.com>
References: <1409219706-14843-1-git-send-email-bhupesh.sharma@freescale.com>
 <1409219706-14843-5-git-send-email-bhupesh.sharma@freescale.com>
 <20140828145635.GL14650@leverpostej>
 <18f8ee091e8847c0bcfba1ef04907a71@BN1PR03MB220.namprd03.prod.outlook.com>
Message-ID: <20140829174757.GD18555@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bhupesh,

> > > +	gic: interrupt-controller at 6000000 {
> > > +		compatible = "arm,gic-v3";
> > > +		reg = <0x0 0x06000000 0 0x10000>, /* GIC Dist */
> > > +		      <0x0 0x06100000 0 0x100000>; /* GICR (RD_base +
> > SGI_base) */
> > > +		#interrupt-cells = <3>;
> > > +		#address-cells = <2>;
> > > +		#size-cells = <2>;
> > > +		ranges;
> > > +		interrupt-controller;
> > > +		interrupts = <1 9 0x4>;
> > > +	};
> > 
> > The GIC node doesn't have any sub-nodes, so I think the #address-cells,
> > #size-cells, and ranges properties can go for now.
> 
> Ok. V3 will address the change.

Ok.

> 
> > 
> > > +
> > > +	timer {
> > > +		compatible = "arm,armv8-timer";
> > > +		interrupts = <1 13 0x1>, /* Physical Secure PPI, edge
> > triggered */
> > > +			     <1 14 0x1>, /* Physical Non-Secure PPI, edge
> > triggered */
> > > +			     <1 11 0x1>, /* Virtual PPI, edge triggered */
> > > +			     <1 10 0x1>; /* Hypervisor PPI, edge triggered */
> > > +	};
> > 
> > In this SoC, are there low-power states the CPUs can be placed into where
> > the architected timers can lose state?
> 
> Yes the SoC has low-power states, however we are yet to work on the power management
> s/w layers. Probably a patch later down the lane would add this capability.

That's fine. I just want to make sure we're not in for some pain with
timers at the moment.

> 
> > 
> > If so, do you any auxiliary timers that aren't cpu-local?
> 
> Yes, the SoC has 4 flextimer IP instances, but I am yet to test them and hence support for them
> is still to be added. Probably a patch later down the lane would add this capability.

Ok. You'll need at least one global timer if you want to place all CPUs
into low power states. For now things should work regardless.

[...]

> > > +	serial0: serial at 21c0500 {
> > > +		device_type = "serial";
> > > +		compatible = "fsl,ns16550", "ns16550a";
> > > +		reg = <0x0 0x21c0500 0x0 0x100>;
> > > +		clock-frequency = <0>;	/* Updated by bootloader */
> > > +		interrupts = <0 32 0x1>; /* edge triggered */
> > > +	};
> > > +
> > > +	serial1: serial at 21c0600 {
> > > +		device_type = "serial";
> > > +		compatible = "fsl,ns16550", "ns16550a";
> > > +		reg = <0x0 0x21c0600 0x0 0x100>;
> > > +		clock-frequency = <0>; 	/* Updated by bootloader */
> > > +		interrupts = <0 32 0x1>; /* edge triggered */
> > > +	};
> > 
> > Just to check: do the two UARTs share the same IRQ, or is that a copy-
> > paste error?
> 
> The two UARTs do share the same IRQ.

Ok.

[...]

> > > +	memory at 80000000 {
> > > +		device_type = "memory";
> > > +		reg = <0x00000000 0x80000000 0 0x80000000>;
> > > +		      /* DRAM space 1 - 2 GB DRAM */
> > > +	};
> > 
> > Does that mean:
> > 
> >  - This is "DRAM space 1", populated with 2GB?
> > 
> > Or:
> > 
> >  - The DRAM space can be populated with 1 to 2 GB?
> > 
> > If the former, s/ - /: / for clarity.
> > 
> > If the latter, it might make sense to move that into board-specific dts
> > files. If this can be dynamically populated ideally the firmware/loader
> > would fix this up (assuming it can probe the memory).
> 
> If the former. I will fix it up in v3.

Ok. Out of curiosity, are there other DRAM spaces that might be
populated?

> > Also, can we move the memory node up to just after /cpus? That would
> > match the other dts files we have.
> 
> Sure. V3 will address this change.

Cheers.

Mark.
