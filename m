From: appanad@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 3 Jan 2018 05:09:08 +0000
Subject: [LINUX PATCH 1/4] dmaengine: xilinx_dma: Fix dma_get_slave_caps()
 API failures
In-Reply-To: <20180103035735.GF18649@localhost>
References: <1513851098-15787-1-git-send-email-appanad@xilinx.com>
 <1513851098-15787-2-git-send-email-appanad@xilinx.com>
 <20180103035735.GF18649@localhost>
Message-ID: <CY1PR02MB1692824C9EAC3F3D86A6645BDC1E0@CY1PR02MB1692.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

	Thanks for the review... 
>
>On Thu, Dec 21, 2017 at 03:41:35PM +0530, Kedareswara rao Appana wrote:
>
>Patch title should say what is does, not the cause/effect

Sure will fix in v2... 

>
>An apt title might be "populate dma caps properly"
>
>> When client driver uses dma_get_slave_caps() api, it checks for
>> certain fields of dma_device struct currently driver is not settings
>> few fields resulting
>> dma_get_slave_caps() returning failure.
>
>It would help to mention the fields you are setting here

Sure will fix in v2... 

Regards,
Kedar.

>
>>
>> This patch fixes this issue by populating proper values to the struct
>> dma_device fields.
>>
>> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
>> ---
>>  drivers/dma/xilinx/xilinx_dma.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c
>> b/drivers/dma/xilinx/xilinx_dma.c index 88d317d..21ac954 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
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
>>  	xdev->common.device_alloc_chan_resources =
>>  				xilinx_dma_alloc_chan_resources;
>>  	xdev->common.device_free_chan_resources =
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe dmaengine"
>> in the body of a message to majordomo at vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
>--
>~Vinod
