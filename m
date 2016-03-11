From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 11 Mar 2016 11:02:36 -0500
Subject: [PATCH V14 5/9] dma: qcom_hidma: implement lower level hardware
 interface
In-Reply-To: <20160311020650.GG11154@localhost>
References: <1454646882-24369-1-git-send-email-okaya@codeaurora.org>
 <1454646882-24369-6-git-send-email-okaya@codeaurora.org>
 <20160311020650.GG11154@localhost>
Message-ID: <56E2EC1C.6040107@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/10/2016 9:06 PM, Vinod Koul wrote:
> On Thu, Feb 04, 2016 at 11:34:36PM -0500, Sinan Kaya wrote:
> 
>> +
>> +#define EVRE_SIZE			16	/* each EVRE is 16 bytes */
>> +
>> +#define TRCA_CTRLSTS_OFFSET		0x000
>> +#define TRCA_RING_LOW_OFFSET		0x008
>> +#define TRCA_RING_HIGH_OFFSET		0x00C
>> +#define TRCA_RING_LEN_OFFSET		0x010
>> +#define TRCA_READ_PTR_OFFSET		0x018
>> +#define TRCA_WRITE_PTR_OFFSET		0x020
>> +#define TRCA_DOORBELL_OFFSET		0x400
>> +
>> +#define EVCA_CTRLSTS_OFFSET		0x000
>> +#define EVCA_INTCTRL_OFFSET		0x004
>> +#define EVCA_RING_LOW_OFFSET		0x008
>> +#define EVCA_RING_HIGH_OFFSET		0x00C
>> +#define EVCA_RING_LEN_OFFSET		0x010
>> +#define EVCA_READ_PTR_OFFSET		0x018
>> +#define EVCA_WRITE_PTR_OFFSET		0x020
>> +#define EVCA_DOORBELL_OFFSET		0x400
>> +
>> +#define EVCA_IRQ_STAT_OFFSET		0x100
>> +#define EVCA_IRQ_CLR_OFFSET		0x108
>> +#define EVCA_IRQ_EN_OFFSET		0x110
>> +
>> +#define EVRE_CFG_IDX			0
>> +#define EVRE_LEN_IDX			1
>> +#define EVRE_DEST_LOW_IDX		2
>> +#define EVRE_DEST_HI_IDX		3
>> +
>> +#define EVRE_ERRINFO_BIT_POS		24
>> +#define EVRE_CODE_BIT_POS		28
>> +
>> +#define EVRE_ERRINFO_MASK		GENMASK(3, 0)
>> +#define EVRE_CODE_MASK			GENMASK(3, 0)
> 
> These are rest here are not namespace properly...

If I understood it right, you want me to prefix them with as HIDMA_xyz.
Correct?

> 
>> +static int hidma_ll_enable(struct hidma_lldev *lldev)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	val = readl(lldev->evca + EVCA_CTRLSTS_OFFSET);
>> +	val &= ~(CH_CONTROL_MASK << 16);
>> +	val |= CH_ENABLE << 16;
>> +	writel(val, lldev->evca + EVCA_CTRLSTS_OFFSET);
>> +
>> +	ret = readl_poll_timeout(lldev->evca + EVCA_CTRLSTS_OFFSET, val,
>> +				 (HIDMA_CH_STATE(val) == CH_ENABLED) ||
>> +				 (HIDMA_CH_STATE(val) == CH_RUNNING), 1000,
>> +				 10000);
>> +	if (ret) {
>> +		dev_err(lldev->dev, "event channel did not get enabled\n");
>> +		return ret;
>> +	}
>> +
>> +	val = readl(lldev->trca + TRCA_CTRLSTS_OFFSET);
>> +	val &= ~(CH_CONTROL_MASK << 16);
>> +	val |= CH_ENABLE << 16;
>> +	writel(val, lldev->trca + TRCA_CTRLSTS_OFFSET);
>> +
>> +	ret = readl_poll_timeout(lldev->trca + TRCA_CTRLSTS_OFFSET, val,
>> +				 (HIDMA_CH_STATE(val) == CH_ENABLED) ||
>> +				 (HIDMA_CH_STATE(val) == CH_RUNNING), 1000,
>> +				 10000);
> 
> first arg for readl_poll_timeout is accessor fn to do read, which doesnt
> seem to be here... so what did i miss?
> 
> 
>> +void hidma_ll_queue_request(struct hidma_lldev *lldev, u32 tre_ch)
>> +{
>> +	struct hidma_tre *tre;
>> +	unsigned long flags;
>> +
>> +	tre = &lldev->trepool[tre_ch];
>> +
>> +	/* copy the TRE into its location in the TRE ring */
>> +	spin_lock_irqsave(&lldev->lock, flags);
>> +	tre->tre_index = lldev->tre_write_offset / TRE_SIZE;
>> +	lldev->pending_tre_list[tre->tre_index] = tre;
>> +	memcpy(lldev->tre_ring + lldev->tre_write_offset, &tre->tre_local[0],
>> +	       TRE_SIZE);
>> +	lldev->tx_status_list[tre->idx].err_code = 0;
>> +	lldev->tx_status_list[tre->idx].err_info = 0;
>> +	tre->queued = 1;
>> +	lldev->pending_tre_count++;

Is this the only one without alignment? I couldn't understand what you mean by 
above one?

>> +	lldev->tre_write_offset = (lldev->tre_write_offset + TRE_SIZE)
>> +	    % lldev->tre_ring_size;
> 
> These and above one should be right justfied per coding style
> 




-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
