From: appanad@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 3 Jan 2018 05:10:35 +0000
Subject: [LINUX PATCH 2/4] dmaengine: xilinx_dma: Fix race condition in
 the driver for cdma
In-Reply-To: <20180103035845.GG18649@localhost>
References: <1513851098-15787-1-git-send-email-appanad@xilinx.com>
 <1513851098-15787-3-git-send-email-appanad@xilinx.com>
 <20180103035845.GG18649@localhost>
Message-ID: <CY1PR02MB169225B20C2719A5124EEC5ADC1E0@CY1PR02MB1692.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

	Thanks for the review... 

>
>On Thu, Dec 21, 2017 at 03:41:36PM +0530, Kedareswara rao Appana wrote:
>
>same issue for patch title here too

Ok will fix in v2... 

>
>> when hardware is idle we need to toggle the SG bit in the control
>> register, inorder to update new value to the current descriptor
>> register other wise undefined results will occur.
>
>can you try making it bit more clear..

Sure will fix in v2... 

Regards,
Kedar.

>
>>
>> This patch updates the same.
>>
>> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
>> ---
>>  drivers/dma/xilinx/xilinx_dma.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c
>> b/drivers/dma/xilinx/xilinx_dma.c index 21ac954..8467671 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
>> @@ -1204,6 +1204,12 @@ static void xilinx_cdma_start_transfer(struct
>xilinx_dma_chan *chan)
>>  	}
>>
>>  	if (chan->has_sg) {
>> +		dma_ctrl_clr(chan, XILINX_DMA_REG_DMACR,
>> +			     XILINX_CDMA_CR_SGMODE);
>> +
>> +		dma_ctrl_set(chan, XILINX_DMA_REG_DMACR,
>> +			     XILINX_CDMA_CR_SGMODE);
>> +
>>  		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
>>  			     head_desc->async_tx.phys);
>>
>> @@ -2052,6 +2058,10 @@ static int xilinx_dma_terminate_all(struct dma_chan
>*dchan)
>>  		chan->cyclic = false;
>>  	}
>>
>> +	if ((chan->xdev->dma_config->dmatype == XDMA_TYPE_CDMA) &&
>chan->has_sg)
>> +		dma_ctrl_clr(chan, XILINX_DMA_REG_DMACR,
>> +			     XILINX_CDMA_CR_SGMODE);
>> +
>>  	return 0;
>>  }
>>
>> --
>> 2.7.4
>>
>
>--
>~Vinod
