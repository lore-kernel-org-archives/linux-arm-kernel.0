From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Fri, 21 Jul 2017 10:32:49 +0000
Subject: [PATCH v2 2/4] dmaengine: Add STM32 MDMA driver
In-Reply-To: <20170721095411.GR3053@localhost>
References: <1499343941-6375-1-git-send-email-pierre-yves.mordret@st.com>
 <1499343941-6375-3-git-send-email-pierre-yves.mordret@st.com>
 <20170721075547.GO3053@localhost>
 <ee278ecf-02a3-7799-888a-9590d1105bb3@st.com>
 <20170721095411.GR3053@localhost>
Message-ID: <3c04c9bf-572d-98a6-ff62-83498bbc7fdf@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/21/2017 11:54 AM, Vinod Koul wrote:
> On Fri, Jul 21, 2017 at 09:30:00AM +0000, Pierre Yves MORDRET wrote:
>>>> +static enum dma_slave_buswidth stm32_mdma_get_max_width(u32 buf_len, u32 tlen)
>>>> +{
>>>> +	enum dma_slave_buswidth max_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
>>>> +
>>>> +	while (((buf_len % max_width) || (tlen < max_width)) &&
>>>> +	       (max_width > DMA_SLAVE_BUSWIDTH_1_BYTE))
>>>> +		max_width = max_width >> 1;
>>>
>>> ok, this is a bit hard to read...
>>
>> This code snippet has already been reworked and optimized. Would you mind to
>> provide me a example with your expectation ? Thanks
> 
> Code is optimized yes, but readable no
> 
> I would like readability to be improved upon...
> 

gotcha

>>
>>>
>>>> +static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
>>>> +				     enum dma_transfer_direction direction,
>>>> +				     u32 *mdma_ccr, u32 *mdma_ctcr,
>>>> +				     u32 *mdma_ctbr, u32 buf_len)
>>>> +{
>>>> +	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
>>>> +	struct stm32_mdma_chan_config *chan_config = &chan->chan_config;
>>>> +	enum dma_slave_buswidth src_addr_width, dst_addr_width;
>>>> +	phys_addr_t src_addr, dst_addr;
>>>> +	int src_bus_width, dst_bus_width;
>>>> +	u32 src_maxburst, dst_maxburst, src_best_burst, dst_best_burst;
>>>> +	u32 ccr, ctcr, ctbr, tlen;
>>>> +
>>>> +	src_addr_width = chan->dma_config.src_addr_width;
>>>> +	dst_addr_width = chan->dma_config.dst_addr_width;
>>>> +	src_maxburst = chan->dma_config.src_maxburst;
>>>> +	dst_maxburst = chan->dma_config.dst_maxburst;
>>>> +	src_addr = chan->dma_config.src_addr;
>>>> +	dst_addr = chan->dma_config.dst_addr;
>>>
>>> this doesn't seem right to me, only the periphral address would come from
>>> slave_config, the memory address is passed as an arg to transfer..
>>>
>>> ...
>>>
>>
>> Correct. But these locals are managed in the case statement below. if direction
>> is Mem2Dev only dst_addr(Peripheral) is considered. In the other way around with
>> Dev2Mem direction only src_addr(Peripheral) is considered.
>> However to disambiguate I can move src_addr & dst_addr affectation in the
>> corresponding case statement if you'd like.
> 
> But below you are over writing both, so in effect this is wasted cycles..
> anyway latter one is more clear, so lets remove from here.
> 

Sorry I don't follow ... or miss something
For instance if direction is Mem2Dev ..._xfer_param is going to configure 
Destination Bus width and Addr given by slave_config. ..._setup_xfer in its turn 
will configure source given as parameter.
Don't the see the over-writing

>>
>>>> +static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
>>>> +				 struct stm32_mdma_desc *desc,
>>>> +				 struct scatterlist *sgl, u32 sg_len,
>>>> +				 enum dma_transfer_direction direction)
>>>> +{
>>>> +	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
>>>> +	struct dma_slave_config *dma_config = &chan->dma_config;
>>>> +	struct scatterlist *sg;
>>>> +	dma_addr_t src_addr, dst_addr;
>>>> +	u32 ccr, ctcr, ctbr;
>>>> +	int i, ret = 0;
>>>> +
>>>> +	for_each_sg(sgl, sg, sg_len, i) {
>>>> +		if (sg_dma_len(sg) > STM32_MDMA_MAX_BLOCK_LEN) {
>>>> +			dev_err(chan2dev(chan), "Invalid block len\n");
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>> +		ret = stm32_mdma_set_xfer_param(chan, direction, &ccr, &ctcr,
>>>> +						&ctbr, sg_dma_len(sg));
>>>> +		if (ret < 0)
>>>> +			return ret;
>>>> +
>>>> +		if (direction == DMA_MEM_TO_DEV) {
>>>> +			src_addr = sg_dma_address(sg);
>>>> +			dst_addr = dma_config->dst_addr;
>>>
>>> and this seems correct, but then why are we doing it in
>>> stm32_mdma_set_xfer_param()
>>>
>>
>> See comment above.
>>
>>>> +static struct dma_async_tx_descriptor *stm32_mdma_prep_slave_sg(
>>>> +	struct dma_chan *c, struct scatterlist *sgl,
>>>> +	u32 sg_len, enum dma_transfer_direction direction,
>>>> +	unsigned long flags, void *context)
>>>
>>> right justfied these please, it makes a terrible read
>>>
>>
>> Given the amount of parameters difficult to right align.
>> Agree with this formatting ?
>>
>> static struct dma_async_tx_descriptor
>> *stm32_mdma_prep_slave_sg(struct dma_chan *c, struct scatterlist *sgl,
>> 			  u32 sg_len, enum dma_transfer_direction direction,
>> 			  unsigned long flags, void *context)
> 
> Yes looks much better :)
> 

Good :)

>>>> +static int stm32_mdma_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct stm32_mdma_chan *chan;
>>>> +	struct stm32_mdma_device *dmadev;
>>>> +	struct dma_device *dd;
>>>> +	struct device_node *of_node;
>>>> +	struct resource *res;
>>>> +	u32 nr_channels, nr_requests;
>>>> +	int i, count, ret;
>>>> +
>>>> +	of_node = pdev->dev.of_node;
>>>> +	if (!of_node)
>>>> +		return -ENODEV;
>>>> +
>>>> +	ret = of_property_read_u32(of_node, "dma-channels", &nr_channels);
>>>> +	if (ret)
>>>> +		nr_channels = STM32_MDMA_MAX_CHANNELS;
>>>> +
>>>> +	ret = of_property_read_u32(of_node, "dma-requests", &nr_requests);
>>>> +	if (ret)
>>>> +		nr_requests = STM32_MDMA_MAX_REQUESTS;
>>>
>>> wouldn't it make sense to print error about these properties not being
>>> present and continuing w/ defaults..?
>>
>> Those are optional parameters as stated by bindings. I can print out a warning
>> or info if you'd like but not error.
> 
> Are these mandatory properties or optional. In case of latter warn should
> suffice.
> 

optional. Let pick out warn then.

Thanks
