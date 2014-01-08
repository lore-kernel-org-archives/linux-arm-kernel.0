From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 8 Jan 2014 20:59:10 +0100
Subject: [PATCH] driver-core: platform: Resolve DT interrupt references
 late
In-Reply-To: <201401081725.17876.arnd@arndb.de>
References: <20140108011957.GK5074@atomide.com> <6734073.GzLvMSsKrR@wuerfel>
 <20140108155855.GA22984@ulmo.nvidia.com>
 <201401081725.17876.arnd@arndb.de>
Message-ID: <20140108195909.GB1298@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 05:25:17PM +0100, Arnd Bergmann wrote:
> On Wednesday 08 January 2014, Thierry Reding wrote:
> > On Wed, Jan 08, 2014 at 04:11:08PM +0100, Arnd Bergmann wrote:
> > > On Wednesday 08 January 2014 15:55:27 Thierry Reding wrote:
> > > > It stands to reason that if they push back on the IOMMU variant of what
> > > > is essentially the same thing, they will push back on the IRQ variant as
> > > > well. One alternative I proposed was to, just as you suggested earlier,
> > > > move the code into platform_drv_probe() or rather a function called from
> > > > it. That proposal never got any replies, though.
> > > > 
> > > > 	https://lkml.org/lkml/2013/12/14/39
> > > 
> > > I guess putting it into the platform_drv_probe function seems reasonable,
> > > I would be more scared of the implications of a notifier based method.
> > 
> > I fully agree. Of course if we decide against moving things into the
> > core and in favour of a more generic API that drivers should use, then
> > this issue goes away silently at least for resources that the driver
> > needs to use explicitly (memory-mapped regions, interrupts, ...).
> > 
> > The issue remains for IOMMU which is meant to be used transparently
> > through the DMA API. Perhaps a good compromise would be to have some
> > sort of generic helper that can be called to initialize IOMMU support
> > for a particular device and support probe deferral on error. Something
> > like this perhaps:
> > 
> > 	int iommu_attach(struct device *dev);
> > 	int iommu_detach(struct device *dev);
> > 
> > I still don't like very much how that needs to be done in each driver
> > explicitly, but if we can't do it in the core, then the only other clean
> > way to handle it would be to treat it like any other sort of resource
> > and handle it explicitly. Perhaps handing out some sort of cookie would
> > be preferable to just an error code?
> 
> The more I think about the iommu case, the more I am convinced that it
> does belong into the core, in whatever form we can find. As far as I
> can tell from the little reliable information I have on the topic, I
> would assume that we can keep it in the DT probing code, as there won't
> be a need for multiple arbitrary IOMMUs with ACPI or with board files.

I think part of the problem is that we don't have any DT probing code
yet. of_platform_probe() would have been that code. Perhaps if you weigh
in Grant and Greg will reconsider.

> > > > One downside of that approach is that, while it maps well to platform
> > > > devices or generic devices that have some sort of firmware interface
> > > > such as OF or ACPI, I don't see how it can be made to work with an I2C
> > > > client that's registered from board setup code for example. Well, I
> > > > suppose that problem could be solved by throwing another lookup table at
> > > > it, just like we do for clocks, regulators, PWMs and GPIOs.
> > > 
> > > Wouldn't you still be able to attach resources in the traditional
> > > way for those, but use the same new interface to get at them?
> > 
> > I wouldn't know how. For instance platform devices store the IRQ number
> > within a struct resource of type IORESOURCE_IRQ, whereas I2C clients
> > store them in the struct i2c_client's .irq field.
> 
> Good point, I forgot about the special case for i2c_client->irq.
> I looked now and noticed that very few i2c devices actually use this
> field, but larger number uses platform_data, which has a similar
> problem.

Yeah. It's kind of messy. The more I think about it, the more I begin to
like the lookup table option. One big advantage of that is that we could
actually unify much of the lookup code, much like we do for other types
of resources. It's a pattern that has worked fairly well in a number of
cases, so it seems natural to use it for interrupts as well.

An even more extreme option would be to go all the way and introduce
struct irq, along the same lines of the new struct gpiod. That would
allow nice things such as storing trigger types and such within the IRQ
handle and propagate them automatically.

> > So without actually introspecting the struct device (possibly using the
> > .bus field for example) and upcasting you won't know how to get at the
> > resources. One possibility to remedy that would be to try and unify the
> > resources within struct device. But that doesn't feel right.
> > 
> > One other thing I had considered at one point was to extend the bus_type
> > structure and give it a way to obtain resources in a bus-specific way,
> > but that feel even more wrong.
> > 
> > Perhaps I'm missing something obvious, though, and this is actually much
> > more trivial to solve.
> 
> No trivial solution that I can see. I think we can deal with the case
> where platform code uses platform_device->resources, and everything else
> comes down to having multiple code branches in the driver, as we already
> have to deal with platform_data and DT properties describing stuff that
> doesn't fit in the resources.

That would be another argument in favour of the lookup table. It would
provide a unified mechanism to define static interrupts if no firmware
interface is available *independent* of the device type. You could have
something like:

	static const struct irq_lookup board_irq_lookup[] = {
		IRQ_LOOKUP("gpio", 0, "0-0040", NULL), /* I2C client via GPIO expander */
		IRQ_LOOKUP("intc", 0, "ehci.1", NULL), /* platform device via INTC */
	};

Along with:

	struct irq *irq_get(struct device *dev, const char *con_id);

To look it up via DT, ACPI, lookup table. That obviously means a more or
less complete change in how interrupts are handled in the kernel, and it
may not be worth it in the end.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/a53c0093/attachment-0001.sig>
