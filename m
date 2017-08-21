From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 21 Aug 2017 17:46:31 +0530
Subject: [PATCH] dmaengine: qcom-bam: Process multiple pending descriptors
In-Reply-To: <20170617133716.GG19154@localhost>
References: <1496838547-15092-1-git-send-email-sricharan@codeaurora.org>
 <20170615041011.GN13020@localhost>
 <004fa3c7-afb9-f56c-8a57-abc0117638eb@codeaurora.org>
 <20170617133716.GG19154@localhost>
Message-ID: <b7aaeb1b-cd86-1b5d-d1f6-f1333f8cd940@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

<snip>

>>>>  	async_desc->num_desc = num_alloc;
>>>>  	async_desc->curr_desc = async_desc->desc;
>>>> @@ -680,13 +684,18 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>>>>  static int bam_dma_terminate_all(struct dma_chan *chan)
>>>>  {
>>>>  	struct bam_chan *bchan = to_bam_chan(chan);
>>>> +	struct bam_async_desc *async_desc;
>>>>  	unsigned long flag;
>>>>  	LIST_HEAD(head);
>>>>  
>>>>  	/* remove all transactions, including active transaction */
>>>>  	spin_lock_irqsave(&bchan->vc.lock, flag);
>>>>  	if (bchan->curr_txd) {
>>>> -		list_add(&bchan->curr_txd->vd.node, &bchan->vc.desc_issued);
>>>> +		list_for_each_entry(async_desc, &bchan->desc_list, desc_node) {
>>>> +			bchan->curr_txd = async_desc;
>>>> +			list_add(&bchan->curr_txd->vd.node,
>>>> +				 &bchan->vc.desc_issued);
>>>
>>> that is wrong, terminated should not add to issued list
>>
>>  hmm, since it was already done like that, i added the same for list of descriptors now.
> 
> Sounds like you should fix existing behaviour too :)
> 

 Just to clarify, the code below this, does a vchan_dma_desc_free_list, which
 removes the descriptors from issued list as well. So this is to pull and remove even all
 those descriptors submitted to the hardware as well. That said, posted a V3 and it
 would cause a conflict with https://patchwork.kernel.org/patch/9874691/ based on which goes
 in first.
 
Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
