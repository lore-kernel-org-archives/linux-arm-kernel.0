From: appanad@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 8 Jan 2018 10:52:01 +0000
Subject: [PATCH v2 1/4] dmaengine: xilinx_dma: populate dma caps properly
In-Reply-To: <20180108103845.GE18649@localhost>
References: <1514961731-1916-1-git-send-email-appanad@xilinx.com>
 <1514961731-1916-2-git-send-email-appanad@xilinx.com>
 <20180108103845.GE18649@localhost>
Message-ID: <CY1PR02MB1692EB7A4E66BA30A8E0DB45DC130@CY1PR02MB1692.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

	Thanks for the review.... 
<Snip>
>> @@ -2398,6 +2398,7 @@ static int xilinx_dma_chan_probe(struct
>xilinx_dma_device *xdev,
>>  		chan->direction = DMA_MEM_TO_DEV;
>>  		chan->id = chan_id;
>>  		chan->tdest = chan_id;
>> +		xdev->common.directions = BIT(DMA_MEM_TO_DEV);
>>
>>  		chan->ctrl_offset = XILINX_DMA_MM2S_CTRL_OFFSET;
>>  		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) { @@ -
>2415,6
>> +2416,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>>  		chan->direction = DMA_DEV_TO_MEM;
>>  		chan->id = chan_id;
>>  		chan->tdest = chan_id - xdev->nr_channels;
>> +		xdev->common.directions |= BIT(DMA_DEV_TO_MEM);
>>
>>  		chan->ctrl_offset = XILINX_DMA_S2MM_CTRL_OFFSET;
>>  		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) { @@ -
>2629,6
>> +2631,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>>  		dma_cap_set(DMA_PRIVATE, xdev->common.cap_mask);
>>  	}
>>
>> +	xdev->common.dst_addr_widths = BIT(addr_width / 8);
>> +	xdev->common.src_addr_widths = BIT(addr_width / 8);
>
>Do you not support trf of 1byte, 2 bytes, or 4 bytes wide transfers? What is value
>of addr_width here typically? Usually controllers can support different widths and
>this is a surprise that you support only one value

Controller supports address width of 32 and 64.
addr_width typical values are 32-bit or 64-bit .
Here addr_width is device-tree parameter...
my understanding of src_addr_widths/dst_addr_widths is, it is a bit mask of the 
address with in bytes that DMA supports, please correct if my understanding is wrong.

Regards,
Kedar.

>
>--
>~Vinod
