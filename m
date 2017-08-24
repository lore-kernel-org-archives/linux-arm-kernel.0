From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Thu, 24 Aug 2017 10:36:27 +0200
Subject: [PATCH v3 2/4] dmaengine: Add STM32 MDMA driver
In-Reply-To: <20170823160044.GE3053@localhost>
References: <1501062502-18778-1-git-send-email-pierre-yves.mordret@st.com>
 <1501062502-18778-3-git-send-email-pierre-yves.mordret@st.com>
 <20170816164709.GR3053@localhost>
 <40c24f87-6ea2-4c3a-1e86-9d30d30481c2@st.com>
 <20170823160044.GE3053@localhost>
Message-ID: <14b7ce2f-4828-2138-3547-209eb519c482@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/23/2017 06:00 PM, Vinod Koul wrote:
> On Tue, Aug 22, 2017 at 05:59:26PM +0200, Pierre Yves MORDRET wrote:
>>
>>
>>>
>>> #define STM32_MDMA_SHIFT(n)		(ffs(n) - 1))
>>> #define STM32_MDMA_SET(n, mask)		((n) << STM32_MDMA_SHIFT(mask))
>>> #define STM32_MDMA_GET(n, mask)		(((n) && mask) >> STM32_MDMA_SHIFT(mask))
>>>
>>> Basically, u extract the shift using the mask value and ffs helping out, so
>>> no need to define these and reduce chances of coding errors...
>>>
>>
>> OK.
>> but I would prefer if you don't mind
> 
> hmmm, I don't have a very strong opinion, so okay. But from programming PoV
> it reduces human errors..
> 
>> #define STM32_MDMA_SET(n, mask)		(((n) << STM32_MDMA_SHIFT(mask)) & mask)
>>

I agree with your proposal :) I just said I prefer for the setter
#define STM32_MDMA_SET(n, mask)		(((n) << STM32_MDMA_SHIFT(mask)) & mask)
instead of
#define STM32_MDMA_SET(n, mask)		((n) << STM32_MDMA_SHIFT(mask))

>>>> +static int stm32_mdma_get_width(struct stm32_mdma_chan *chan,
>>>> +				enum dma_slave_buswidth width)
>>>> +{
>>>> +	switch (width) {
>>>> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
>>>> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
>>>> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
>>>> +	case DMA_SLAVE_BUSWIDTH_8_BYTES:
>>>> +		return ffs(width) - 1;
>>>> +	default:
>>>> +		dev_err(chan2dev(chan), "Dma bus width not supported\n");
>>>
>>> please log the width here, helps in debug...
>>>
>>
>> Hum.. just a dev_dbg to log the actual width or within the dev_err ?
> 
> latter pls
> 

OK

>>>> +static struct dma_async_tx_descriptor *
>>>> +stm32_mdma_prep_dma_cyclic(struct dma_chan *c, dma_addr_t buf_addr,
>>>> +			   size_t buf_len, size_t period_len,
>>>> +			   enum dma_transfer_direction direction,
>>>> +			   unsigned long flags)
>>>> +{
>>>> +	struct stm32_mdma_chan *chan = to_stm32_mdma_chan(c);
>>>> +	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
>>>> +	struct dma_slave_config *dma_config = &chan->dma_config;
>>>> +	struct stm32_mdma_desc *desc;
>>>> +	dma_addr_t src_addr, dst_addr;
>>>> +	u32 ccr, ctcr, ctbr, count;
>>>> +	int i, ret;
>>>> +
>>>> +	if (!buf_len || !period_len || period_len > STM32_MDMA_MAX_BLOCK_LEN) {
>>>> +		dev_err(chan2dev(chan), "Invalid buffer/period len\n");
>>>> +		return NULL;
>>>> +	}
>>>> +
>>>> +	if (buf_len % period_len) {
>>>> +		dev_err(chan2dev(chan), "buf_len not multiple of period_len\n");
>>>> +		return NULL;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * We allow to take more number of requests till DMA is
>>>> +	 * not started. The driver will loop over all requests.
>>>> +	 * Once DMA is started then new requests can be queued only after
>>>> +	 * terminating the DMA.
>>>> +	 */
>>>> +	if (chan->busy) {
>>>> +		dev_err(chan2dev(chan), "Request not allowed when dma busy\n");
>>>> +		return NULL;
>>>> +	}
>>>
>>> is that a HW restriction? Once a txn is completed can't we submit
>>> subsequent txn..? Can you explain this part please.
>>>
>>
>> Driver can prepare any request Slave SG, Memcpy or Cyclic. But if the channel is
>> busy to complete a DMA transfer, the request will be put in pending list. This
>> is only when the DMA transfer is going to be completed the next descriptor is
>> going to be processed and started.
>> However for cyclic this is different since when cyclic is ignited the channel
>> will be busy until its termination. This is why we forbid any DMA preparation
>> for this channel.
>> Nonetheless I believe we have a flaw here since we have to forbid
>> Slave/Memcpy/Cyclic whether a cyclic request is on-going.
> 
> But you are not submitting a txn to HW. The prepare_xxx operation prepares a
> descriptor which is pushed to pending queue on submit and further pushed to
> hw on queue move or issue_pending()
> 
> So here we should ideally accept the request.
> 
> After you finish memcpy you can submit a memcpy right...?
> 

Correct TXn is not submitted to HW only descriptors are prepared. They are going
to be pushed to HW on issue_pending if not channel not running. Otherwise the
next pending request is pushed to HW on DMA completion.
So yes I can queue a memcpy can be submitted during a memcpy (or Slave SG). The
mempy will be pushed to HW after the completion of the preceding.

The only drawback is cyclic. If a cyclic DMA operation is running, no other
requests (cyclic or SG or memcpy) can be granted or queued.

>>
>>
>>>> +	ret = device_property_read_u32(&pdev->dev, "dma-requests",
>>>> +				       &nr_requests);
>>>> +	if (ret) {
>>>> +		nr_requests = STM32_MDMA_MAX_REQUESTS;
>>>> +		dev_warn(&pdev->dev, "MDMA defaulting on %i request lines\n",
>>>> +			 nr_requests);
>>>> +	}
>>>> +
>>>> +	count = of_property_count_u32_elems(of_node, "st,ahb-addr-masks");
>>>
>>> We dont have device_property_xxx for this?
>>
>> Sorry no. Well didn't figure out one though.
> 
> we do :) the array property with NULL argument returns the size of array..
> 
> int device_property_read_u32_array(struct device *dev, const char *propname,
> 				   u32 *val, size_t nval)
> 
> Documentation says:
>  Return: number of values if @val was %NULL,
> 

Dho. ok :)

>>
>>>
>>>> +	if (count < 0)
>>>> +		count = 0;
>>>> +
>>>> +	dmadev = devm_kzalloc(&pdev->dev, sizeof(*dmadev) + sizeof(u32) * count,
>>>> +			      GFP_KERNEL);
>>>> +	if (!dmadev)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	dmadev->nr_channels = nr_channels;
>>>> +	dmadev->nr_requests = nr_requests;
>>>> +	of_property_read_u32_array(of_node, "st,ahb-addr-masks",
>>>> +				   dmadev->ahb_addr_masks,
>>>> +				   count);
>>>
>>> i know we have an device api for array reads :)
>>> and I think that helps in former case..
>>>
>>
>> Correct :) device_property_read_u32_array
> 
> yes..
> 

Thanks
Py
