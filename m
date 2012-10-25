From: b32955@freescale.com (Huang Shijie)
Date: Thu, 25 Oct 2012 17:15:43 +0800
Subject: [PATCH v2 2/3] serial: mxs-auart: add the DMA support for mx28
In-Reply-To: <1351145272.7077.8.camel@vkoul-udesk3>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com>	
 <1351074456-25863-3-git-send-email-b32955@freescale.com>	
 <1351138689.5263.68.camel@vkoul-udesk3> <5088D336.7040206@freescale.com>
 <1351145272.7077.8.camel@vkoul-udesk3>
Message-ID: <5089033F.9040100@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?10?25? 14:07, Vinod Koul ??:
> On Thu, 2012-10-25 at 13:50 +0800, Huang Shijie wrote:
>> ? 2012?10?25? 12:18, Vinod Koul ??:
>>>> +
>>>> +static int mxs_auart_dma_tx(struct mxs_auart_port *s, int size)
>>>> +{
>>>> +	struct dma_async_tx_descriptor *desc;
>>>> +	struct scatterlist *sgl =&s->tx_sgl;
>>>> +	struct dma_chan *channel = s->tx_dma_chan;
>>>> +	u32 pio;
>>>> +
>>>> +	/* [1] : send PIO. Note, the first pio word is CTRL1. */
>>>> +	pio = AUART_CTRL1_XFER_COUNT(size);
>>>> +	desc = dmaengine_prep_slave_sg(channel, (struct scatterlist *)&pio,
>>>> +					1, DMA_TRANS_NONE, 0);
>>> this seems like a hack. API expects a scatterlist as argument.
>>> Same thing about direction, NONE doesnt mean anything for dma transfer.
>> It's not a hack. this DMA descriptor is used to set the registers.
>> Please see the code in drivers/dma/mxs-dma.c:mxs_dam_prep_slave_sg().
> yes it is, and also an abuse of the api.
> prep_slave_sg() expects a scatter list and you are passing something
> else and using DMA_TRANS_NONE to do that, which makes no sense!!!
>
> If you have to setup your registers you need to setup based on what APIs
> passed you and not by abusing.
>
yes. I have to setup the register. Could you told me which API is the 
right API?

It seems to the mxs-dma needs a patch again.

>>>> +	if (!desc) {
>>>> +		dev_err(s->dev, "step 1 error\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/* [2] : set DMA buffer. */
>>>> +	sg_init_one(sgl, s->tx_dma_buf, size);
>>>> +	dma_map_sg(s->dev, sgl, 1, DMA_TO_DEVICE);
>>>> +	desc = dmaengine_prep_slave_sg(channel, sgl,
>>>> +			1, DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>>>> +	if (!desc) {
>>>> +		dev_err(s->dev, "step 2 error\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/* [3] : submit the DMA */
>>>> +	desc->callback = dma_tx_callback;
>>>> +	desc->callback_param = s;
>>>> +	dmaengine_submit(desc);
>>>> +	dma_async_issue_pending(channel);
>>>> +	return 0;
>>>> +}
>>>> +
>>>>
>>>> +static bool mxs_auart_dma_filter(struct dma_chan *chan, void *param)
>>>> +{
>>>> +	struct mxs_auart_port *s = param;
>>>> +
>>>> +	if (!mxs_dma_is_apbx(chan))
>>>> +		return false;
>>>> +
>>>> +	if (s->dma_channel == chan->chan_id) {
>>>> +		chan->private =&s->dma_data;
>>> dont use chan->private. You need to dmaengine_slave_config API
>> please see the drivers/dma/mxs-dma.c:mxs_dam_alloc_chan_resoures().
>>
>> The mxs-dma driver uses ->private to store the channel interrupt number.
> And which it should not be doing. private is not supposed to be used for
> passing info. If it is generic add to slave config.
>
Could you give me an example which do not use the private?
The imx-sdma also uses the private to pass some info.

thanks
Huang Shijie
