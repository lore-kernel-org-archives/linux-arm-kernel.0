From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Tue, 9 Oct 2018 10:40:30 +0200
Subject: [PATCH v3 4/7] dmaengine: stm32-dma: Add DMA/MDMA chaining support
In-Reply-To: <20181007160030.GB2372@vkoul-mobl>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
 <1538139715-24406-5-git-send-email-pierre-yves.mordret@st.com>
 <20181007160030.GB2372@vkoul-mobl>
Message-ID: <e9cedfdd-ad90-9123-03bb-34a2e84059c5@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/07/2018 06:00 PM, Vinod wrote:
> On 28-09-18, 15:01, Pierre-Yves MORDRET wrote:
>> This patch adds support of DMA/MDMA chaining support.
>> It introduces an intermediate transfer between peripherals and STM32 DMA.
>> This intermediate transfer is triggered by SW for single M2D transfer and
>> by STM32 DMA IP for all other modes (sg, cyclic) and direction (D2M).
>>
>> A generic SRAM allocator is used for this intermediate buffer
>> Each DMA channel will be able to define its SRAM needs to achieve chaining
>> feature : (2 ^ order) * PAGE_SIZE.
>> For cyclic, SRAM buffer is derived from period length (rounded on
>> PAGE_SIZE).
> 
> So IIUC, you chain two dma txns together and transfer data via an SRAM?

Correct. one DMA is DMAv2 (stm32-dma) and the other is MDMA(stm32-mdma).
Intermediate transfer is between device and memory.
This intermediate transfer is using SDRAM.

> 
>>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>> ---
>>   Version history:
>>     v3:
>>        * Solve KBuild warning
>>     v2:
>>     v1:
>>        * Initial
>> ---
>> ---
>>  drivers/dma/stm32-dma.c | 879 ++++++++++++++++++++++++++++++++++++++++++------
> 
> that is a lot of change for a driver, consider splitting it up
> logically in smaller changes...
> 

This feature is rather monolithic. Difficult to split up.
All the code is required at once.

>>  1 file changed, 772 insertions(+), 107 deletions(-)
>>
>> diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
>> index 379e8d5..85e81c4 100644
>> --- a/drivers/dma/stm32-dma.c
>> +++ b/drivers/dma/stm32-dma.c
>> @@ -15,11 +15,14 @@
>>  #include <linux/dmaengine.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/err.h>
>> +#include <linux/genalloc.h>
>>  #include <linux/init.h>
>> +#include <linux/iopoll.h>
>>  #include <linux/jiffies.h>
>>  #include <linux/list.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>> +#include <linux/of_address.h>
>>  #include <linux/of_device.h>
>>  #include <linux/of_dma.h>
>>  #include <linux/platform_device.h>
>> @@ -118,6 +121,7 @@
>>  #define STM32_DMA_FIFO_THRESHOLD_FULL			0x03
>>  
>>  #define STM32_DMA_MAX_DATA_ITEMS	0xffff
>> +#define STM32_DMA_SRAM_GRANULARITY	PAGE_SIZE
>>  /*
>>   * Valid transfer starts from @0 to @0xFFFE leading to unaligned scatter
>>   * gather at boundary. Thus it's safer to round down this value on FIFO
>> @@ -135,6 +139,12 @@
>>  /* DMA Features */
>>  #define STM32_DMA_THRESHOLD_FTR_MASK	GENMASK(1, 0)
>>  #define STM32_DMA_THRESHOLD_FTR_GET(n)	((n) & STM32_DMA_THRESHOLD_FTR_MASK)
>> +#define STM32_DMA_MDMA_CHAIN_FTR_MASK	BIT(2)
>> +#define STM32_DMA_MDMA_CHAIN_FTR_GET(n)	(((n) & STM32_DMA_MDMA_CHAIN_FTR_MASK) \
>> +					 >> 2)
>> +#define STM32_DMA_MDMA_SRAM_SIZE_MASK	GENMASK(4, 3)
>> +#define STM32_DMA_MDMA_SRAM_SIZE_GET(n)	(((n) & STM32_DMA_MDMA_SRAM_SIZE_MASK) \
>> +					 >> 3)
>>  
>>  enum stm32_dma_width {
>>  	STM32_DMA_BYTE,
>> @@ -176,15 +186,31 @@ struct stm32_dma_chan_reg {
>>  	u32 dma_sfcr;
>>  };
>>  
>> +struct stm32_dma_mdma_desc {
>> +	struct sg_table sgt;
>> +	struct dma_async_tx_descriptor *desc;
>> +};
>> +
>> +struct stm32_dma_mdma {
>> +	struct dma_chan *chan;
>> +	enum dma_transfer_direction dir;
>> +	dma_addr_t sram_buf;
>> +	u32 sram_period;
>> +	u32 num_sgs;
>> +};
>> +
>>  struct stm32_dma_sg_req {
>> -	u32 len;
>> +	struct scatterlist stm32_sgl_req;
>>  	struct stm32_dma_chan_reg chan_reg;
>> +	struct stm32_dma_mdma_desc m_desc;
>>  };
>>  
>>  struct stm32_dma_desc {
>>  	struct virt_dma_desc vdesc;
>>  	bool cyclic;
>>  	u32 num_sgs;
>> +	dma_addr_t dma_buf;
>> +	void *dma_buf_cpu;
>>  	struct stm32_dma_sg_req sg_req[];
>>  };
>>  
>> @@ -201,6 +227,10 @@ struct stm32_dma_chan {
>>  	u32 threshold;
>>  	u32 mem_burst;
>>  	u32 mem_width;
>> +	struct stm32_dma_mdma mchan;
>> +	u32 use_mdma;
>> +	u32 sram_size;
>> +	u32 residue_after_drain;
>>  };
>>  
>>  struct stm32_dma_device {
>> @@ -210,6 +240,7 @@ struct stm32_dma_device {
>>  	struct reset_control *rst;
>>  	bool mem2mem;
>>  	struct stm32_dma_chan chan[STM32_DMA_MAX_CHANNELS];
>> +	struct gen_pool *sram_pool;
>>  };
>>  
>>  static struct stm32_dma_device *stm32_dma_get_dev(struct stm32_dma_chan *chan)
>> @@ -497,11 +528,15 @@ static void stm32_dma_stop(struct stm32_dma_chan *chan)
>>  static int stm32_dma_terminate_all(struct dma_chan *c)
>>  {
>>  	struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
>> +	struct stm32_dma_mdma *mchan = &chan->mchan;
>>  	unsigned long flags;
>>  	LIST_HEAD(head);
>>  
>>  	spin_lock_irqsave(&chan->vchan.lock, flags);
>>  
>> +	if (chan->use_mdma)
>> +		dmaengine_terminate_async(mchan->chan);
>> +
>>  	if (chan->busy) {
>>  		stm32_dma_stop(chan);
>>  		chan->desc = NULL;
>> @@ -514,9 +549,96 @@ static int stm32_dma_terminate_all(struct dma_chan *c)
>>  	return 0;
>>  }
>>  
>> +static u32 stm32_dma_get_remaining_bytes(struct stm32_dma_chan *chan)
>> +{
>> +	u32 dma_scr, width, ndtr;
>> +	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
>> +
>> +	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
>> +	width = STM32_DMA_SCR_PSIZE_GET(dma_scr);
>> +	ndtr = stm32_dma_read(dmadev, STM32_DMA_SNDTR(chan->id));
>> +
>> +	return ndtr << width;
>> +}
>> +
>> +static int stm32_dma_mdma_drain(struct stm32_dma_chan *chan)
>> +{
>> +	struct stm32_dma_mdma *mchan = &chan->mchan;
>> +	struct stm32_dma_sg_req *sg_req;
>> +	struct dma_device *ddev = mchan->chan->device;
>> +	struct dma_async_tx_descriptor *desc = NULL;
>> +	enum dma_status status;
>> +	dma_addr_t src_buf, dst_buf;
>> +	u32 mdma_residue, mdma_wrote, dma_to_write, len;
>> +	struct dma_tx_state state;
>> +	int ret;
>> +
>> +	/* DMA/MDMA chain: drain remaining data in SRAM */
>> +
>> +	/* Get the residue on MDMA side */
>> +	status = dmaengine_tx_status(mchan->chan, mchan->chan->cookie, &state);
>> +	if (status == DMA_COMPLETE)
>> +		return status;
>> +
>> +	mdma_residue = state.residue;
>> +	sg_req = &chan->desc->sg_req[chan->next_sg - 1];
>> +	len = sg_dma_len(&sg_req->stm32_sgl_req);
>> +
>> +	/*
>> +	 * Total = mdma blocks * sram_period + rest (< sram_period)
>> +	 * so mdma blocks * sram_period = len - mdma residue - rest
>> +	 */
>> +	mdma_wrote = len - mdma_residue - (len % mchan->sram_period);
>> +
>> +	/* Remaining data stuck in SRAM */
>> +	dma_to_write = mchan->sram_period - stm32_dma_get_remaining_bytes(chan);
>> +	if (dma_to_write > 0) {
>> +		/* Stop DMA current operation */
>> +		stm32_dma_disable_chan(chan);
>> +
>> +		/* Terminate current MDMA to initiate a new one */
>> +		dmaengine_terminate_all(mchan->chan);
>> +
>> +		/* Double buffer management */
>> +		src_buf = mchan->sram_buf +
>> +			  ((mdma_wrote / mchan->sram_period) & 0x1) *
>> +			  mchan->sram_period;
>> +		dst_buf = sg_dma_address(&sg_req->stm32_sgl_req) + mdma_wrote;
>> +
>> +		desc = ddev->device_prep_dma_memcpy(mchan->chan,
>> +						    dst_buf, src_buf,
>> +						    dma_to_write,
>> +						    DMA_PREP_INTERRUPT);
> 
> why would you do that?
> 
> If at all you need to create anothe txn, I think it would be good to
> prepare a new descriptor and chain it, not call the dmaengine APIs..
> 

In this UC, DMAv2 is configured in cyclic mode because this DMA doesn't work
with hw LLI only sw. This is really for performances reason we use this cyclic mode.
This very last txn is to flush remaining bytes stick in SDRAM.
I don't believe I can chain cyclic and this last txn.
