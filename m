From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Sep 2015 21:39:27 +0200
Subject: [PATCH v2 4/5] PCI: generic: Correct, and avoid overflow,
 in bus_max calculation.
In-Reply-To: <20150923193545.GZ7356@arm.com>
References: <1442527332-1174-1-git-send-email-ddaney.cavm@gmail.com>
 <3751968.n8LRgots8n@wuerfel> <20150923193545.GZ7356@arm.com>
Message-ID: <1707525.QvfFzUYq4E@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 September 2015 20:35:45 Will Deacon wrote:
> On Wed, Sep 23, 2015 at 08:27:41PM +0100, Arnd Bergmann wrote:
> > On Wednesday 23 September 2015 11:21:56 David Daney wrote:
> > > >>
> > > >>      /* Limit the bus-range to fit within reg */
> > > >> -    bus_max = pci->cfg.bus_range->start +
> > > >> -              (resource_size(&pci->cfg.res) >> pci->cfg.ops.bus_shift) - 1;
> > > >> +    bus_max = (resource_size(&pci->cfg.res) >> pci->cfg.ops.bus_shift) - 1;
> > > >> +    if (bus_max > 255)
> > > >> +            bus_max = 255;
> > > >
> > > > I still don't understand the need for this part. If the cfg space is bigger
> > > > than bus_max, isn't that simply an invalid resource? Given that the resource
> > > > could be broken in other ways too, this check feels more like a specific
> > > > workaround rather than generally useful code.
> > > 
> > > Imagine...
> > > 
> > >    bus-range [0x80 .. 0xff], this requires a cfg.res that will cover the 
> > > entire range of 0..0xff.
> > > 
> > >    according to the calculations above, (resource_size(&pci->cfg.res) >> 
> > > pci->cfg.ops.bus_shift) - 1 will have a value of 0xff, so...
> > 
> > Extending the computation to 32 bit seems fine, but I'd rather warn loudly
> > if the bus range does not fit within the registers.
> > 
> > Also note that the computation is already correct with my interpretation
> > of the reg property.
> 
> From what Lorenzo was saying, ACPI shares the interpretation that David is
> implementing here and, given that the DT version seems to be subjective,
> aligning this reg property with MMCFG seems to make sense.

We should then make it very clear in the binding that the driver
is not allowed to actually map the registers for the buses outside
of the bus-range, as that is highly unusual.

We would also need a special exception for this if we ever get to
implement the DT source checker that we have been talking about for
years, as the reg property might then overlap with a property from
another device.

	Arnd
