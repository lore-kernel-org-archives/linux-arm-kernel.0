From: tj@kernel.org (Tejun Heo)
Date: Mon, 24 Oct 2011 08:43:07 -0700
Subject: [RFC 3/4] lib: devres: add convenience function to remap a
	resource
In-Reply-To: <1319445729-14841-4-git-send-email-w.sang@pengutronix.de>
References: <1319445729-14841-1-git-send-email-w.sang@pengutronix.de>
	<1319445729-14841-4-git-send-email-w.sang@pengutronix.de>
Message-ID: <20111024154307.GB24914@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Oct 24, 2011 at 10:42:08AM +0200, Wolfram Sang wrote:
> * the new function is not named 'devm_ioremap_resource' because it does more than
>   just ioremap, namely request_mem_region. I didn't want to create implicit
>   knowledge here.

Maybe devm_request_and_ioremap_resource()?  Maybe it's a bit long but
A_to_B names are usually used for trivial conversions.

> +int __must_check devm_resource_to_mapped_ptr(struct device *dev,
> +			struct resource *res, void __iomem **dest)

If we're already printing out dev_err(), I think we can live with
%NULL return on error.

> +{
> +	resource_size_t size;
> +	const char *name;
> +
> +	BUG_ON(!dev || !dest);
> +
> +	*dest = NULL;
> +
> +	if (!res || resource_type(res) != IORESOURCE_MEM) {
> +		dev_err(dev, "invalid resource\n");
> +		return -ENOENT;
> +	}
> +
> +	size = resource_size(res);
> +	name = res->name ?: dev_name(dev);
> +
> +	if (!devm_request_mem_region(dev, res->start, size, name)) {
> +		dev_err(dev, "can't request region for resource %pR\n", res);
> +		return -EBUSY;
> +	}
> +
> +	if (res->flags & IORESOURCE_CACHEABLE)
> +		*dest = devm_ioremap(dev, res->start, size);
> +	else
> +		*dest = devm_ioremap_nocache(dev, res->start, size);
> +
> +	if (!*dest) {
> +		dev_err(dev, "ioremap failed for resource %pR\n", res);
> +		return -ENOMEM;
> +	}

So, for library functions, it's nice if the function doesn't hold any
extra resource on error return.  devres has grouping to support this.
You just need to wrap allocations inside a group and remove it on
success and release on error.  ie.

	if (!devres_open_group(dev, NULL, GFP_KERNEL))
		return NULL;
	if (alloc_resource(0) < 0)
		goto fail;
	if (alloc_resource(1) < 0)
		goto fail;
	devres_remove_group(dev, NULL);
	return 0;
fail:
	devres_release_group(dev, NULL);
	return 0;

Thanks.

-- 
tejun
