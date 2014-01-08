From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 8 Jan 2014 16:58:57 +0100
Subject: [PATCH] driver-core: platform: Resolve DT interrupt references
 late
In-Reply-To: <6734073.GzLvMSsKrR@wuerfel>
References: <20140108011957.GK5074@atomide.com> <4589157.TquA4Q59fC@wuerfel>
 <20140108145525.GB21974@ulmo.nvidia.com>
 <6734073.GzLvMSsKrR@wuerfel>
Message-ID: <20140108155855.GA22984@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 04:11:08PM +0100, Arnd Bergmann wrote:
> On Wednesday 08 January 2014 15:55:27 Thierry Reding wrote:
> > On Wed, Jan 08, 2014 at 02:41:19PM +0100, Arnd Bergmann wrote:
> > > On Wednesday 08 January 2014 13:51:17 Thierry Reding wrote:
[...]
> > Actually I posted a round of patches quite a while back that did exactly
> > this for interrupts. The changes were somewhat involved because it means
> > propagating an error code from fairly deep down in the OF code back to
> > the various higher-level helpers. If you're interested, the last version
> > of that is here:
> > 
> > 	https://lkml.org/lkml/2013/9/18/216
> > 
> > Grant in particular seemed to be uncomfortable about how invasive the
> > patch series is.
> 
> Interesting. It seems like a worthwhile thing to do, but I can understand
> Grant's reluctance.

To be fair, Grant didn't say outright no. Given how easily this could
turn into a regression nightmare I do understand the reluctance as well.
Merging things piece by piece would make it somewhat less risky but at
the same time makes it hard to keep at it.

> > It stands to reason that if they push back on the IOMMU variant of what
> > is essentially the same thing, they will push back on the IRQ variant as
> > well. One alternative I proposed was to, just as you suggested earlier,
> > move the code into platform_drv_probe() or rather a function called from
> > it. That proposal never got any replies, though.
> > 
> > 	https://lkml.org/lkml/2013/12/14/39
> 
> I guess putting it into the platform_drv_probe function seems reasonable,
> I would be more scared of the implications of a notifier based method.

I fully agree. Of course if we decide against moving things into the
core and in favour of a more generic API that drivers should use, then
this issue goes away silently at least for resources that the driver
needs to use explicitly (memory-mapped regions, interrupts, ...).

The issue remains for IOMMU which is meant to be used transparently
through the DMA API. Perhaps a good compromise would be to have some
sort of generic helper that can be called to initialize IOMMU support
for a particular device and support probe deferral on error. Something
like this perhaps:

	int iommu_attach(struct device *dev);
	int iommu_detach(struct device *dev);

I still don't like very much how that needs to be done in each driver
explicitly, but if we can't do it in the core, then the only other clean
way to handle it would be to treat it like any other sort of resource
and handle it explicitly. Perhaps handing out some sort of cookie would
be preferable to just an error code?

> > > We could then skip adding the resources at device creation time.
> > > Is this something you already plan to do later, or is there a reason
> > > it wouldn't work?
> > 
> > The current thread here suggests that it would be preferable not to have
> > any static allocations at all, but rather introduce a new API to resolve
> > things at probe time if necessary. I think the idea was to have a set of
> > functions like:
> > 
> > 	int device_get_irq(struct device *dev, unsigned int num);
> > 	struct resource *device_get_mem_region(struct device *dev,
> > 					       unsigned int num);
> > 
> > Or even possible the more generic:
> > 
> > 	struct resource *device_get_resource(struct device *dev,
> > 					     unsigned int type,
> > 					     unsigned int num);
> > 
> > If every driver used these functions, all resources could trivially be
> > resolved at probe time. That solution is also the most invasive one of
> > course, because it requires all existing drivers to be converted. At
> > least the API would be all new and therefore the conversion could happen
> > piecemeal.
> 
> Right, that does sound nice, and has the added benefit of saving
> some memory allocations. I'd prefer the less generic variant here,
> but I haven't given it much thought.

I do prefer the less generic ones as well. They seem to be more
convenient to use.

> > One downside of that approach is that, while it maps well to platform
> > devices or generic devices that have some sort of firmware interface
> > such as OF or ACPI, I don't see how it can be made to work with an I2C
> > client that's registered from board setup code for example. Well, I
> > suppose that problem could be solved by throwing another lookup table at
> > it, just like we do for clocks, regulators, PWMs and GPIOs.
> 
> Wouldn't you still be able to attach resources in the traditional
> way for those, but use the same new interface to get at them?

I wouldn't know how. For instance platform devices store the IRQ number
within a struct resource of type IORESOURCE_IRQ, whereas I2C clients
store them in the struct i2c_client's .irq field.

So without actually introspecting the struct device (possibly using the
.bus field for example) and upcasting you won't know how to get at the
resources. One possibility to remedy that would be to try and unify the
resources within struct device. But that doesn't feel right.

One other thing I had considered at one point was to extend the bus_type
structure and give it a way to obtain resources in a bus-specific way,
but that feel even more wrong.

Perhaps I'm missing something obvious, though, and this is actually much
more trivial to solve.

> > The good thing about it would be more consistency between the various
> > types of resources. Eventually I could imagine that we could even get
> > rid of struct resource (or at least only use it for a single type of
> > resource). But as I said, it'll take quite a bit of work to convert
> > everything to that.
> 
> struct resource is a structure with a long and complex history.
> I'd certainly like to put some of it behind us and do something
> that fits better into the 'struct device' concept which it
> predates. I agree it would be a big effort though.

I concur.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/e1f786ae/attachment.sig>
