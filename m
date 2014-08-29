From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Fri, 29 Aug 2014 18:07:40 +0000
Subject: [PATCH V2 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <20140829174757.GD18555@leverpostej>
References: <1409219706-14843-1-git-send-email-bhupesh.sharma@freescale.com>
 <1409219706-14843-5-git-send-email-bhupesh.sharma@freescale.com>
 <20140828145635.GL14650@leverpostej>
 <18f8ee091e8847c0bcfba1ef04907a71@BN1PR03MB220.namprd03.prod.outlook.com>
 <20140829174757.GD18555@leverpostej>
Message-ID: <78eaae039fd04eb58e1dac715968dd72@BN1PR03MB220.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Friday, August 29, 2014 11:18 PM
> To: Sharma Bhupesh-B45370
> Cc: Catalin Marinas; Will Deacon; arnd at arndb.de;
> grant.likely at secretlab.ca; Marc Zyngier; rob.herring at linaro.org; linux-
> arm-kernel at lists.infradead.org; Yoder Stuart-B08248; Basu Arnab-B45036
> Subject: Re: [PATCH V2 4/6] arm64: Add DTS support for FSL's LS2085A SoC
> 
> Hi Bhupesh,
> 

[snip..]

> > > > +	timer {
> > > > +		compatible = "arm,armv8-timer";
> > > > +		interrupts = <1 13 0x1>, /* Physical Secure PPI, edge
> > > triggered */
> > > > +			     <1 14 0x1>, /* Physical Non-Secure PPI, edge
> > > triggered */
> > > > +			     <1 11 0x1>, /* Virtual PPI, edge triggered
> */
> > > > +			     <1 10 0x1>; /* Hypervisor PPI, edge
> triggered */
> > > > +	};
> > >
> > > In this SoC, are there low-power states the CPUs can be placed into
> > > where the architected timers can lose state?
> >
> > Yes the SoC has low-power states, however we are yet to work on the
> > power management s/w layers. Probably a patch later down the lane would
> add this capability.
> 
> That's fine. I just want to make sure we're not in for some pain with
> timers at the moment.

Sure. I have added the same to my To-do.

> >
> > >
> > > If so, do you any auxiliary timers that aren't cpu-local?
> >
> > Yes, the SoC has 4 flextimer IP instances, but I am yet to test them
> > and hence support for them is still to be added. Probably a patch later
> down the lane would add this capability.
> 
> Ok. You'll need at least one global timer if you want to place all CPUs
> into low power states. For now things should work regardless.
> 
> [...]

[snip]

> 
> > > > +	memory at 80000000 {
> > > > +		device_type = "memory";
> > > > +		reg = <0x00000000 0x80000000 0 0x80000000>;
> > > > +		      /* DRAM space 1 - 2 GB DRAM */
> > > > +	};
> > >
> > > Does that mean:
> > >
> > >  - This is "DRAM space 1", populated with 2GB?
> > >
> > > Or:
> > >
> > >  - The DRAM space can be populated with 1 to 2 GB?
> > >
> > > If the former, s/ - /: / for clarity.
> > >
> > > If the latter, it might make sense to move that into board-specific
> > > dts files. If this can be dynamically populated ideally the
> > > firmware/loader would fix this up (assuming it can probe the memory).
> >
> > If the former. I will fix it up in v3.
> 
> Ok. Out of curiosity, are there other DRAM spaces that might be
> populated?

Yes there is another DRAM space. The 1st one is accessible within 32 bits and
the 2nd one is accessible from 40-bit and above. However, I was waiting
for the 4-level ARM64 page table patches (from Catalin) to get absorbed, as w/o the
same we can access only a 39-bit PA and hence can have only 3-level page table limited
to the 1st DRAM region (which is accessible via first 32 bits).

Any idea, about the latest state of Catalin's patch ([1])? Has it made to linux-next?

[1] http://lwn.net/Articles/606082/

[snip]

Regards,
Bhupesh
