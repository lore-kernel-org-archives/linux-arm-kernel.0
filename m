From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 15 Jun 2016 15:06:29 -0700
Subject: [PATCH 4/5] remoteproc: core: Supply framework to request,
 declare and fetch shared memory
In-Reply-To: <1462454983-13168-5-git-send-email-lee.jones@linaro.org>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
 <1462454983-13168-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20160615220629.GW1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 05 May 06:29 PDT 2016, Lee Jones wrote:

> Normally used for management of; carveout, devmem and trace memory.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 174 +++++++++++++++++++++++++++++++++--
>  1 file changed, 167 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
[..]
> @@ -222,7 +223,8 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
[..]
> -	va = dma_alloc_coherent(dev->parent, size, &dma, GFP_KERNEL);
> +	dma_dev = rproc_subdev_lookup(rproc, "vring");
> +	va = dma_alloc_coherent(dma_dev, size, &dma, GFP_KERNEL);
[..]
> @@ -594,7 +599,8 @@ static int rproc_handle_carveout(struct rproc *rproc,
[..]
> -	va = dma_alloc_coherent(dev->parent, rsc->len, &dma, GFP_KERNEL);
> +	dma_dev = rproc_subdev_lookup(rproc, "carveout");
> +	va = dma_alloc_coherent(dma_dev, rsc->len, &dma, GFP_KERNEL);
[..]
> +static int rproc_subdev_match(struct device *dev, void *data)
> +{
> +	char *sub_name;
> +
> +	if (!dev_name(dev))
> +		return 0;
> +
> +	sub_name = strpbrk(dev_name(dev), "#");
> +	if (!sub_name)
> +		return 0;
> +
> +	return !strcmp(++sub_name, (char *)data);
> +}
> +
[..]
> +struct rproc_subdev *rproc_subdev_add(struct rproc *rproc, struct resource *res)
> +{
[..]
> +	dev_set_name(&sub->dev, "%s#%s", dev_name(sub->dev.parent), res->name);
> +	dev_set_drvdata(&sub->dev, sub);
> +
> +	ret = device_register(&sub->dev);
[..]
> +}
> +EXPORT_SYMBOL(rproc_subdev_add);

I worked up a prototype that allows remoteproc drivers to
programmatically specify carveout resources, which then are matched and
merged with entires from the resource table. I've given these
programmatically allocated carveouts a device so that the associated
allocation comes out of the specified region - or the rproc region if no
match is found.


This solves my use case of carving out memory from two disjoint memory
regions for one of my remoteprocs, but differs from your approach in
that you specify one large carveout (and vrings) region and any
carveouts (or vrings) will chip away from this.

Would this approach work for you, or do you depend on having 1:N
relationship between your memory region and your resources?

Regards,
Bjorn
