From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Sep 2015 11:41:53 +0100
Subject: [PATCH 4/6] PCI: generic: Correct, and avoid overflow, in
 bus_max calculation.
In-Reply-To: <55F86764.4060502@caviumnetworks.com>
References: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
 <1442013719-5001-5-git-send-email-ddaney.cavm@gmail.com>
 <20150915174934.GL31157@arm.com>
 <55F85D4E.9020604@caviumnetworks.com>
 <20150915183500.GR31157@arm.com>
 <55F86764.4060502@caviumnetworks.com>
Message-ID: <20150916104152.GC28771@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 07:45:56PM +0100, David Daney wrote:
> On 09/15/2015 11:35 AM, Will Deacon wrote:
> > On Tue, Sep 15, 2015 at 07:02:54PM +0100, David Daney wrote:
> >> On 09/15/2015 10:49 AM, Will Deacon wrote:
> >>> On Sat, Sep 12, 2015 at 12:21:57AM +0100, David Daney wrote:
> >>>>    	/* Limit the bus-range to fit within reg */
> >>>> -	bus_max = pci->cfg.bus_range->start +
> >>>> -		  (resource_size(&pci->cfg.res) >> pci->cfg.ops.bus_shift) - 1;
> >>>> +	bus_max = (resource_size(&pci->cfg.res) >> pci->cfg.ops.bus_shift) - 1;
> >>>> +	if (bus_max > 255)
> >>>> +		bus_max = 255;
> >>>>    	pci->cfg.bus_range->end = min_t(resource_size_t,
> >>>>    					pci->cfg.bus_range->end, bus_max);
> >>>
> >>> Hmm, this is changing the meaning of the bus-range property in the
> >>> device-tree, which really needs to match what IEEE Std 1275-1994 requires.
> >>
> >> I doesn't change the bus-range.
> >
> > Not directly, but pci->cfg.bus_range is a resource populated from the
> > "bus-range" property in the device-tree, so it's changing how the driver
> > uses that property.
> >
> >>> My understanding was that the bus-range could be used to offset the config
> >>> space, which is why it's subtracted from the bus number in
> >>> gen_pci_map_cfg_bus_[e]cam.
> >>
> >> There is an inconsistency in the current code.  The calculation of the
> >> cfg.win[?] pointers is done such that the beginning of the config space
> >> specified in the "reg" property corresponds to bus 0.
> >
> > I don't follow you here. The mapping functions explicitly subtract the
> > start of the bus range when calculating the window offset:
> >
> >    resource_size_t idx = bus->number - pci->cfg.bus_range->start;
> >
> > so if I have bus-range = <128 255>; then bus 128 lives at the start of
> > the configuration space described by the reg property, not bus 0.
> >
> > Sorry if I'm being thick; I just can't see the inconsistency.
> >
> 
> Here is the current code:
> 
> >> 	bus_range = pci->cfg.bus_range;
> >> 	for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
> >> 		u32 idx = busn - bus_range->start;
> 
> The index is offset by the bus range start...
> 
> >> 		u32 sz = 1 << pci->cfg.ops.bus_shift;
> >>
> >> 		pci->cfg.win[idx] = devm_ioremap(dev,
> >> 						 pci->cfg.res.start + busn * sz,
> >> 						 sz);
> 
> But, the offset into the "reg" property is the raw bus number.
> 
> 
> >> 		if (!pci->cfg.win[idx])
> >> 			return -ENOMEM;
> >> 	}
> 
> 
> I hope that makes it more clear.

Got it. So we should be using idx instead of busn in the devm_ioremap
call above.

Will
