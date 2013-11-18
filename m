From: florian.meier@koalo.de (Florian Meier)
Date: Mon, 18 Nov 2013 13:16:26 +0100
Subject: [PATCHv7] dmaengine: Add support for BCM2835
In-Reply-To: <1384768816.14845.186.camel@smile>
References: <5288E327.8050809@koalo.de> <1384768816.14845.186.camel@smile>
Message-ID: <528A051A.7000703@koalo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you! Few comments below.

> []
>> +static enum dma_status bcm2835_dma_tx_status(struct dma_chan *chan,
>> +	dma_cookie_t cookie, struct dma_tx_state *txstate)
>> +{
> 
> []
> 
>> +	} else {
>> +		txstate->residue = 0;
> 
> Useless assignment since dmaengine will do this for you in
> dma_cookie_status.

I agree that it is useless, but I think otherwise it might be concealed
that there is a third case left that uses a residue of 0. Do you think a
comment is better? E.g.:

+	} else {
+		/* residue = 0 per default */

>> +	/* Bus width translates to the element size (ES) */
>> +	switch (dev_width) {
>> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
>> +		es = BCM2835_DMA_DATA_TYPE_S32;
>> +		break;
>> +	default:
>> +		return NULL;
>> +	}
> 
> So, you use switch-case on hope to extend it later, correct?

Yes, there is a S128 case left, but that is not implemented yet.

>> +static int bcm2835_dma_probe(struct platform_device *pdev)
>> +{
>> +	struct bcm2835_dmadev *od;
>> +	struct resource *res;
>> +	void __iomem *base;
>> +	int rc;
>> +	int i;
>> +	int irq;
>> +	uint32_t chans_available;
> 
> Why uint32_t?

Because it is a bit mask of fixed length that directly comes from the
firmware.

>> +		/* Request DMA channel mask from device tree */
>> +		if (of_property_read_u32(pdev->dev.of_node,
>> +				"brcm,dma-channel-mask",
>> +				&chans_available)) {
>> +			dev_err(&pdev->dev, "Failed to get channel mask\n");
>> +			bcm2835_dma_free(od);
>> +			return -EINVAL;
>> +		}
>> +	} else {
>> +		dev_err(&pdev->dev, "Failed to get channel mask. No device tree.\n");
>> +		bcm2835_dma_free(od);
>> +		return -EINVAL;
>> +	}
> 
>> +	dev_dbg(&pdev->dev, "Initialized %i DMA channels\n", i);
>> +
>> +	if (pdev->dev.of_node) {
> 
> Does it make sense?

There was already a discussion about that in PATCHv4. It should be
possible to add board file initialization later with few patching.
Although, maybe this will not be relevant anymore, because device tree
support of this platform is getting better more and more.
