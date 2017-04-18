From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 18 Apr 2017 10:04:22 +0200
Subject: [PATCH 2/7] crypto: inside-secure: add SafeXcel EIP197 crypto
 engine driver
In-Reply-To: <5a016e1e-1443-158a-5ced-58dcb4ad63cc@arm.com>
References: <20170329124432.27457-1-antoine.tenart@free-electrons.com>
 <20170329124432.27457-3-antoine.tenart@free-electrons.com>
 <5a016e1e-1443-158a-5ced-58dcb4ad63cc@arm.com>
Message-ID: <20170418080422.55k63czpmnuqn7ku@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Wed, Apr 12, 2017 at 02:54:13PM +0100, Robin Murphy wrote:
> 
> Bit of a drive-by, but since I have it in my head that crypto drivers
> are a hotspot for dodgy DMA usage (in part due to the hardware often
> being a bit esoteric with embedded RAMs and such), this caught my eye
> and I thought I'd give this a quick once-over to check for anything
> smelly. Unfortunately, I was not disappointed... ;)

:-)

> On 29/03/17 13:44, Antoine Tenart wrote:
> [...]
> > diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
> > new file mode 100644
> > index 000000000000..00f3f2c85d05
> > --- /dev/null
> > +++ b/drivers/crypto/inside-secure/safexcel.c
> [...]
> > +int safexcel_invalidate_cache(struct crypto_async_request *async,
> > +			      struct safexcel_context *ctx,
> > +			      struct safexcel_crypto_priv *priv,
> > +			      dma_addr_t ctxr_dma, int ring,
> > +			      struct safexcel_request *request)
> > +{
> > +	struct safexcel_command_desc *cdesc;
> > +	struct safexcel_result_desc *rdesc;
> > +	phys_addr_t ctxr_phys;
> > +	int ret = 0;
> > +
> > +	ctxr_phys = dma_to_phys(priv->dev, ctxr_dma);
> 
> No no no. This is a SWIOTLB-specific (or otherwise arch-private,
> depending on implementation) helper, not a DMA API function, and should
> not be called directly by drivers. There is no guarantee it will give
> the result you expect, or even compile, in all cases (if the kbuild
> robot hasn't already revealed via the COMPILE_TEST dependency).
> 
> That said, AFAICS ctxr_phys ends up in a descriptor which is given to
> the device, so trying to use a physical address is wrong and it should
> still be the DMA address anyway.

I see. The cryptographic engine should always use dma addresses. I'll
update the descriptors structure members from "phys" to "dma" as well.

> [...]
> > +static int safexcel_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct resource *res;
> > +	struct safexcel_crypto_priv *priv;
> > +	int i, ret;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(struct safexcel_crypto_priv),
> > +			    GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->dev = dev;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	priv->base = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(priv->base)) {
> > +		dev_err(dev, "failed to get resource\n");
> > +		return PTR_ERR(priv->base);
> > +	}
> > +
> > +	priv->clk = of_clk_get(dev->of_node, 0);
> > +	if (!IS_ERR(priv->clk)) {
> > +		ret = clk_prepare_enable(priv->clk);
> > +		if (ret) {
> > +			dev_err(dev, "unable to enable clk (%d)\n", ret);
> > +			return ret;
> > +		}
> > +	} else {
> > +		/* The clock isn't mandatory */
> > +		if (PTR_ERR(priv->clk) == -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> > +	}
> 
> You should call dma_set_mask_and_coherent() before any DMA API calls,
> both to confirm DMA really is going to work all, and also (since this IP
> apparently supports >32-bit addresses) to describe the full inherent
> addressing capability, not least to avoid wasting time/space with
> unnecessary bounce buffering otherwise.

OK, I'll add a call to this helper before using DMA API calls.

> > +
> > +err_pool:
> > +	dma_pool_destroy(priv->context_pool);
> 
> You used dmam_pool_create(), so not only is an explicit destroy
> unnecessary, but doing so with the non-managed version is actively
> harmful, since devres would end up double-freeing the pool after you return.

I saw this and fixed it in my local version.

> > +struct safexcel_token {
> > +	u32 packet_length:17;
> > +	u8 stat:2;
> > +	u16 instructions:9;
> > +	u8 opcode:4;
> > +} __packed;
> 
> Using bitfields in hardware descriptors seems pretty risky, since you've
> no real guarantee two compilers will lay them out the same way (or that
> either would be correct WRT what the hardware expects). I'd be more
> inclined to construct all these fields with explicit masking and shifting.

Hmm, I'm not sure to follow you here. If I use bitfields in a __packed
structure, we should be safe. Why would the compiler have a different
behaviour?

> > +static int safexcel_aes_send(struct crypto_async_request *async,
> > +			     int ring, struct safexcel_request *request,
> > +			     int *commands, int *results)
> > +{
> > +	struct ablkcipher_request *req = ablkcipher_request_cast(async);
> > +	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
> > +	struct safexcel_crypto_priv *priv = ctx->priv;
> > +	struct safexcel_command_desc *cdesc;
> > +	struct safexcel_result_desc *rdesc;
> > +	struct scatterlist *sg;
> > +	phys_addr_t ctxr_phys;
> > +	int nr_src, nr_dst, n_cdesc = 0, n_rdesc = 0, queued = req->nbytes;
> > +	int i, ret = 0;
> > +
> > +	request->req = &req->base;
> > +
> > +	if (req->src == req->dst) {
> > +		nr_src = sg_nents_for_len(req->src, req->nbytes);
> > +		nr_dst = nr_src;
> > +
> > +		if (dma_map_sg(priv->dev, req->src, nr_src, DMA_BIDIRECTIONAL) <= 0)
> 
> Nit: you only need to check for zero/nonzero to determine failure
> (similarly below) - dma_map_sg() cannot return negative values.

OK.

> Bigger complaint: you should not ignore the successful return value and
> rely on it being equal to nr_src - please see the description of
> dma_map_sg() in Documenatation/DMA-API.txt

OK, I'll have a look at it and fix this.

> > +	/* command descriptors */
> > +	for_each_sg(req->src, sg, nr_src, i) {
> > +		phys_addr_t sg_phys = dma_to_phys(priv->dev, sg_dma_address(sg));
> > +		int len = sg_dma_len(sg);
> 
> If dma_map_sg() coalesced any entries into the same mapping such that
> count < nents, these could well give bogus values toward the end of the
> list once i >= count(if you're lucky, at least len might be 0).

OK, I'll fix this.

> > +	/* Add a command descriptor for the cached data, if any */
> > +	if (cache_len) {
> > +		ctx->base.cache_dma = dma_map_single(priv->dev, req->cache,
> 
> This is pretty dodgy, since req->cache is inside a live data structure,
> adjoining parts of which are updated whilst still mapped (the update of
> req->processed below). You just about get away without data corruption
> since we *probably* don't invalidate anything when unmapping
> DMA_TO_DEVICE, and the coherency hardware *probably* doesn't do anything
> crazy, but you've no real guarantee of that - any DMA buffer should
> really be separately kmalloced. "That's a nice dirty cache line you've
> got there, it'd be a shame if anything were to happen to it..."

OK, good to know.

> > +	rdr->base = dmam_alloc_coherent(priv->dev,
> > +					rdr->offset * EIP197_DEFAULT_RING_SIZE,
> > +					&rdr->base_dma, GFP_KERNEL);
> > +	if (!rdr->base) {
> > +		dmam_free_coherent(priv->dev,
> > +				   cdr->offset * EIP197_DEFAULT_RING_SIZE,
> > +				   cdr->base, cdr->base_dma);
> 
> Returning an error here will abort your probe routine, so devres will
> clean these up there and then - there's no need to do free anything
> explicitly. That's rather the point of using devm_*() to begin with.

Sure.

> > +	dmam_free_coherent(priv->dev,
> > +			   cdr->offset * EIP197_DEFAULT_RING_SIZE,
> > +			   cdr->base, cdr->base_dma);
> > +	dmam_free_coherent(priv->dev,
> > +			   rdr->offset * EIP197_DEFAULT_RING_SIZE,
> > +			   rdr->base, rdr->base_dma);
> > +}
> 
> Again, this is only called at device teardown, so the whole function is
> redundant.

OK, I'll remove these.

Thanks for the review!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170418/2a1b30cf/attachment-0001.sig>
