From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 6 May 2015 14:22:03 +0300
Subject: EDMA oftree entry for AM335x
In-Reply-To: <20150505145828.GB21061@atomide.com>
References: <20150504064323.GU15254@pengutronix.de>
 <20150504141103.GD24469@atomide.com> <5548CB54.1040302@ti.com>
 <20150505145828.GB21061@atomide.com>
Message-ID: <5549F95B.8090905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2015 05:58 PM, Tony Lindgren wrote:
>> It is not that simple ;)
>> eDMA consists of Channel Controller(s) and Transfer Controllers. In AM335x we
>> have 1 CC and 3 TC. TC is mostly a box for us, we do not need to configure
>> anything within so the eDMA driver stack just does that: do not touch anything
>> TC related in TC address space, we only deal with the CC.
>> But in order to be able to move data around we need both CC and the TCs
>> enabled and this is why we have the multiple hwmod. with pm_runtime we manage
>> both CC and TCs at the same time.
>> But from the SW point of view the TC does not really exists. As I said we only
>> touch CC registers, paRAM entries.
> 
> There's probably a real reason for each TC to have their own clkctrl
> register. Do you have any info on how they are split?

In different SoC we can have different number of CCs (OMAP-L138 has two) and
each CC can have different number of TCs associated with. In AM335x we have
one CC with 3 TC, in OMAP-L138 we have two CC, CC0 has 2 TC, CC1 has 1 TC. The
TCs are used to set priorities, you can assign the priorities to the TCs and
you can choose to assign the transfer (channel) to a give TC.

>> And yes, both TC and CCs can generate interrupts.
> 
> Do the TCs have a shared interrupt that could be handled by
> each TC instance?

Separate IRQ lines to the ARM core, but we do not handle them right now.

>> So it is not straight forward to separate the TC from the CC driver (edma3).
> 
> It seems pm runtime for these four separate modules needs to be
> done at the CC driver level if it can't be done separately for
> each instance.

The current eDMA stack is not really flexible on this IMHO.
I think the way forward would be something like this in DT:

edma_cc: edma_cc at 49000000 {
	compatible = "ti,edma3-cc";
	ti,hwmods = "tpcc"
	reg =	<0x49000000 0x10000>,
		<0x44e10f90 0x40>;
	interrupts = <12 13 14>;
	#dma-cells = <1>;

	edma3_tc0: edma3_tc0 at 49800000 {
		compatible = "ti,edma3-tc";
		ti,hwmods = "tptc0"
	};

	edma3_tc1: edma3_tc1 at 49900000 {
		compatible = "ti,edma3-tc";
		ti,hwmods = "tptc1"
	};

	edma3_tc2: edma3_tc2 at 49a00000 {
		compatible = "ti,edma3-tc";
		ti,hwmods = "tptc2"
	};
};

The driver for ti,edma3-tc would be pretty minimal, doing only pm_runtime only
and from the CC driver we could just set the runtime status for the the TC
which we are about to submit work and decrement the runtime when the work is
done. If not work is needed for the TC it can be shot down.

But this would need significant amount of work which can be done when we get
rid of the legacy (arch/arm/common/edma.c) and move to dmaengine only mode.

-- 
P?ter
