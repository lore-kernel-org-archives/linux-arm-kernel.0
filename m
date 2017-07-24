From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 24 Jul 2017 11:40:48 +0100
Subject: [PATCH 3/4] ACPI: Introduce DMA ranges parsing
In-Reply-To: <37547189.Yunjf1Ri5r@aspire.rjw.lan>
References: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
 <20170720144517.32529-4-lorenzo.pieralisi@arm.com>
 <37547189.Yunjf1Ri5r@aspire.rjw.lan>
Message-ID: <20170724104048.GD13145@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 22, 2017 at 12:15:42AM +0200, Rafael J. Wysocki wrote:

[...]

> > + * acpi_dma_get_range() - Get device DMA parameters.
> > + *
> > + * @dev: device to configure
> > + * @dma_addr: pointer device DMA address result
> > + * @offset: pointer to the DMA offset result
> > + * @size: pointer to DMA range size result
> > + *
> > + * Evaluate DMA regions and return respectively DMA region start, offset
> > + * and size in dma_addr, offset and size on parsing success; it does not
> > + * update the passed in values on failure.
> > + *
> > + * Return 0 on success, < 0 on failure.
> > + */
> > +int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
> > +		       u64 *size)
> > +{
> > +	struct acpi_device *adev;
> > +	LIST_HEAD(list);
> > +	struct resource_entry *rentry;
> > +	int ret;
> > +	struct device *dma_dev = dev;
> > +	struct acpi_buffer name_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> > +	u64 dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
> > +
> > +	/*
> > +	 * Walk the device tree chasing an ACPI companion with a _DMA
> > +	 * object while we go. Stop if we find a device with an ACPI
> > +	 * companion containing a _DMA method.
> > +	 */
> > +	do {
> > +		if (has_acpi_companion(dma_dev)) {
> > +			adev = ACPI_COMPANION(dma_dev);
> > +
> > +			if (acpi_has_method(adev->handle, METHOD_NAME__DMA))
> > +				break;
> 
> Why don't you do
> 
> 	adev = ACPI_COMPANION(dma_dev);
> 	if (adev && acpi_has_method(adev->handle, METHOD_NAME__DMA))
> 		break;
> 
> instead?

Yes, it is better.

> > +		}
> > +	} while ((dma_dev = dma_dev->parent));
> 
> We had a rule to avoid things like this once and it wasn't a bad one. :-)
> 
> Why don't you just do
> 
> 		dma_dev = dma_dev->parent;
> 	} while (dma_dev);
> 
> ?

Yes I should have done that in the first place, will update.

> > +
> > +	if (!dma_dev)
> > +		return -ENODEV;
> > +
> > +	if (!acpi_has_method(adev->handle, METHOD_NAME__CRS)) {
> > +		acpi_get_name(adev->handle, ACPI_FULL_PATHNAME, &name_buffer);
> > +		pr_warn(FW_BUG "%s: _DMA object only valid in object with valid _CRS\n",
> > +				(char *)name_buffer.pointer);
> > +		kfree(name_buffer.pointer);
> 
> We have acpi_handle_warn() and friends for stuff like that ...

I will update to it.

> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = acpi_dev_get_dma_resources(adev, &list);
> > +	if (ret > 0) {
> > +		list_for_each_entry(rentry, &list, node) {
> > +			if (dma_offset && rentry->offset != dma_offset) {
> > +				ret = -EINVAL;
> > +				pr_warn("Can't handle multiple windows with different offsets\n");
> > +				goto out;
> > +			}
> > +			dma_offset = rentry->offset;
> > +
> > +			/* Take lower and upper limits */
> > +			if (rentry->res->start < dma_start)
> > +				dma_start = rentry->res->start;
> > +			if (rentry->res->end > dma_end)
> > +				dma_end = rentry->res->end;
> > +		}
> > +
> > +		if (dma_start >= dma_end) {
> > +			ret = -EINVAL;
> > +			pr_warn("Invalid DMA regions configuration\n");
> 
> dev_warn()?
> 
> And why _warn() and not _info()?

Mmm..ok for the dev_ prefix - basically this would be a FW_BUG (I think
this specific error condition is overkill TBH, the ACPI resource
validation code should catch it before we even get here) not sure
about downgrading it to _info() though, I would leave it at this
loglevel - in particular in the offset check above:

	if (dma_offset && rentry->offset != dma_offset) {
		ret = -EINVAL;
		pr_warn("Can't handle multiple windows with different offsets\n");
		goto out;
	}

Thanks,
Lorenzo
