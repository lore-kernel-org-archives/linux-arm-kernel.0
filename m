From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 24 Oct 2011 22:09:33 +0200
Subject: [RFC 3/4] lib: devres: add convenience function to remap a
	resource
In-Reply-To: <20111024154307.GB24914@google.com>
References: <1319445729-14841-1-git-send-email-w.sang@pengutronix.de>
	<1319445729-14841-4-git-send-email-w.sang@pengutronix.de>
	<20111024154307.GB24914@google.com>
Message-ID: <20111024200933.GB6326@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Mon, Oct 24, 2011 at 10:42:08AM +0200, Wolfram Sang wrote:
> > * the new function is not named 'devm_ioremap_resource' because it does more than
> >   just ioremap, namely request_mem_region. I didn't want to create implicit
> >   knowledge here.
> 
> Maybe devm_request_and_ioremap_resource()?  Maybe it's a bit long but
> A_to_B names are usually used for trivial conversions.

I had this name in mind, too. Yet, it implies that the function requests a
resource but in fact it requests a mem_region. Requesting a resource (e.g.
platform_get_resource) is THE thing the function does not do. So I scrapped
this name. But will do some more brainstorming for a better name in V2.

> 
> > +int __must_check devm_resource_to_mapped_ptr(struct device *dev,
> > +			struct resource *res, void __iomem **dest)
> 
> If we're already printing out dev_err(), I think we can live with
> %NULL return on error.

Yes, already fixed this way.

> > +{
> > +	resource_size_t size;
> > +	const char *name;
> > +
> > +	BUG_ON(!dev || !dest);
> > +
> > +	*dest = NULL;
> > +
> > +	if (!res || resource_type(res) != IORESOURCE_MEM) {
> > +		dev_err(dev, "invalid resource\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	size = resource_size(res);
> > +	name = res->name ?: dev_name(dev);
> > +
> > +	if (!devm_request_mem_region(dev, res->start, size, name)) {
> > +		dev_err(dev, "can't request region for resource %pR\n", res);
> > +		return -EBUSY;
> > +	}
> > +
> > +	if (res->flags & IORESOURCE_CACHEABLE)
> > +		*dest = devm_ioremap(dev, res->start, size);
> > +	else
> > +		*dest = devm_ioremap_nocache(dev, res->start, size);
> > +
> > +	if (!*dest) {
> > +		dev_err(dev, "ioremap failed for resource %pR\n", res);
> > +		return -ENOMEM;
> > +	}
> 
> So, for library functions, it's nice if the function doesn't hold any
> extra resource on error return.  devres has grouping to support this.
> You just need to wrap allocations inside a group and remove it on
> success and release on error.  ie.
> 
> 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> 		return NULL;
> 	if (alloc_resource(0) < 0)
> 		goto fail;
> 	if (alloc_resource(1) < 0)
> 		goto fail;
> 	devres_remove_group(dev, NULL);
> 	return 0;
> fail:
> 	devres_release_group(dev, NULL);
> 	return 0;

I am not sure I got what you mean here, but wouldn't it be easier to simply
call devm_release_mem_region() when devm_ioremap comes back with a NULL
pointer?

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111024/01ff8aba/attachment-0001.sig>
