From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Thu, 17 Jul 2014 18:45:00 -0300
Subject: [PATCH v2 1/8] dma: sun4i: Add support for the DMA engine on
 sun[457]i SoCs
In-Reply-To: <20140717205639.GH20328@lukather>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
 <1404619518-7592-2-git-send-email-emilio@elopez.com.ar>
 <20140717205639.GH20328@lukather>
Message-ID: <53C843DC.8090808@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 17/07/14 17:56, Maxime Ripard escribi?:
> On Sun, Jul 06, 2014 at 01:05:08AM -0300, Emilio L?pez wrote:
>> This patch adds support for the DMA engine present on Allwinner A10,
>> A13, A10S and A20 SoCs. This engine has two kinds of channels: normal
>> and dedicated. The main difference is in the mode of operation;
>> while a single normal channel may be operating at any given time,
>> dedicated channels may operate simultaneously provided there is no
>> overlap of source or destination.
>>
>> Hardware documentation can be found on A10 User Manual (section 12), A13
>> User Manual (section 14) and A20 User Manual (section 1.12)
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>> ---
>>(...)
>>
>> +config SUN4I_DMA
>> +	tristate "Allwinner A10/A10S/A13/A20 DMA support"
>
> I'm not that fond of having an exhaustive list here. If some other SoC
> we didn't thought of or get a new SoC that uses this controller, this
> list won't be exhaustive anymore, which is even worse.
>
> Just mention the A10.

Ok

>> +	depends on (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || (COMPILE_TEST && OF && ARM))
>
> This pretty much defeats the purpose of COMPILE_TEST

QCOM_BAM_DMA does it that way; it's better to get some coverage than 
none I guess?

>
>> +	select DMA_ENGINE
>> +	select DMA_OF
>> +	select DMA_VIRTUAL_CHANNELS
>
> I guess you could default to y for the SoCs where it's relevant.

Sounds good.

>
>> +	help
>> +	  Enable support for the DMA controller present in the sun4i,
>> +	  sun5i and sun7i Allwinner ARM SoCs.
>> +
(...)
>> +
>> +/** Normal DMA register values **/
>> +
>> +/* Normal DMA source/destination data request type values */
>> +#define NDMA_DRQ_TYPE_SDRAM			0x16
>> +#define NDMA_DRQ_TYPE_LIMIT			(0x1F + 1)
>
> Hmmm, I'm unsure what this is about... What is it supposed to do, and
> how is it different from BIT(5) ?

if (val < NDMA_DRQ_TYPE_LIMIT)
	/* valid value */
else
	/* invalid value */

0x1F is the last valid value

(...)
>> +
>> +static void set_pchan_interrupt(struct sun4i_dma_dev *priv,
>> +				struct sun4i_dma_pchan *pchan,
>> +				int half, int end)
>> +{
>> +	u32 reg = readl_relaxed(priv->base + DMA_IRQ_ENABLE_REG);
>> +	int pchan_number = pchan - priv->pchans;
>> +
>> +	if (half)
>> +		reg |= BIT(pchan_number * 2);
>> +	else
>> +		reg &= ~BIT(pchan_number * 2);
>> +
>> +	if (end)
>> +		reg |= BIT(pchan_number * 2 + 1);
>> +	else
>> +		reg &= ~BIT(pchan_number * 2 + 1);
>> +
>> +	writel_relaxed(reg, priv->base + DMA_IRQ_ENABLE_REG);
>
> I don't see any interrupts here.

Hm?

> Is this suppose to be called with a
> lock taken? If so, it should be mentionned in some comment.

Good point, this should probably take a lock, I'll get it fixed.

(...)
>> +{
>> +	struct sun4i_dma_contract *contract = to_sun4i_dma_contract(vd);
>> +	struct sun4i_dma_promise *promise;
>> +
>> +	/* Free all the demands and completed demands */
>> +	list_for_each_entry(promise, &contract->demands, list) {
>> +		kfree(promise);
>> +	}
>> +
>> +	list_for_each_entry(promise, &contract->completed_demands, list) {
>> +		kfree(promise);
>> +	}
>>
>
> Those brackets are useless.

Indeed, dropped.

>> +	for_each_sg(sgl, sg, sg_len, i) {
>> +		/* Figure out addresses */
>> +		if (dir == DMA_MEM_TO_DEV) {
>> +			srcaddr = sg_dma_address(sg);
>> +			dstaddr = sconfig->dst_addr;
>> +		} else {
>> +			srcaddr = sconfig->src_addr;
>> +			dstaddr = sg_dma_address(sg);
>> +		}
>> +
>> +		/* TODO: should this be configurable? */
>> +		para = DDMA_MAGIC_SPI_PARAMETERS;
>
> What is it? Is it supposed to change from one client device to
> another?

These are the magic DMA engine timings that keep SPI going. I haven't 
seen any interface on DMAEngine to configure timings, and so far they 
seem to work for everything we support, so I've kept them here. I don't 
know if other devices need different timings because, as usual, we only 
have the "para" bitfield meanings, but no comment on what the values 
should be when doing a certain operation :|

>> +
>> +		/* And make a suitable promise */
>> +		if (vchan->is_dedicated)
>> +			promise = generate_ddma_promise(chan, srcaddr, dstaddr,
>> +							sg_dma_len(sg), sconfig);
>> +		else
>> +			promise = generate_ndma_promise(chan, srcaddr, dstaddr,
>> +							sg_dma_len(sg), sconfig);
>> +
>> +		if (!promise)
>> +			return NULL; /* TODO */
>
> TODO what?

/* TODO: properly kfree the promises generated in the loop */

(...)
>> +static enum dma_status sun4i_dma_tx_status(struct dma_chan *chan,
>> +					   dma_cookie_t cookie,
>> +					   struct dma_tx_state *state)
>> +{
>> +	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
>> +	struct sun4i_dma_pchan *pchan = vchan->pchan;
>> +	struct sun4i_dma_contract *contract;
>> +	struct sun4i_dma_promise *promise;
>> +	struct virt_dma_desc *vd;
>> +	unsigned long flags;
>> +	enum dma_status ret;
>> +	size_t bytes = 0;
>> +
>> +	ret = dma_cookie_status(chan, cookie, state);
>> +	if (ret == DMA_COMPLETE)
>> +		return ret;
>> +
>> +	spin_lock_irqsave(&vchan->vc.lock, flags);
>> +	vd = vchan_find_desc(&vchan->vc, cookie);
>> +	if (!vd) /* TODO */
>
> TODO what?
>

/* TODO: remove the TODO */

>> +		goto exit;
>> +	contract = to_sun4i_dma_contract(vd);
>> +
>> +	list_for_each_entry(promise, &contract->demands, list) {
>> +		bytes += promise->len;
>> +	}
>
> Useless brackets

Dropped

Thanks for taking the time to review this!

Cheers,

Emilio
