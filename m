From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 24 Sep 2015 21:48:11 +0200
Subject: [PATCH 1/3] dmaengine: virt-dma: don't always free descriptor
 upon completion
In-Reply-To: <20150924172621.GD2381@localhost> (Vinod Koul's message of "Thu,
 24 Sep 2015 22:56:21 +0530")
References: <1441539654-19055-1-git-send-email-robert.jarzmik@free.fr>
 <20150924172621.GD2381@localhost>
Message-ID: <87io6zppj8.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Sun, Sep 06, 2015 at 01:40:52PM +0200, Robert Jarzmik wrote:
>> @@ -29,7 +29,7 @@ dma_cookie_t vchan_tx_submit(struct dma_async_tx_descriptor *tx)
>>  	spin_lock_irqsave(&vc->lock, flags);
>>  	cookie = dma_cookie_assign(tx);
>>  
>> -	list_add_tail(&vd->node, &vc->desc_submitted);
>> +	list_move_tail(&vd->node, &vc->desc_submitted);
>
> I am not sure I follow this, why move ?
Because it is already on the allocated list (see vchan_tx_prep()).

>> +int vchan_tx_desc_free(struct dma_async_tx_descriptor *tx)
>> +{
>> +	struct virt_dma_chan *vc = to_virt_chan(tx->chan);
>> +	struct virt_dma_desc *vd = to_virt_desc(tx);
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&vc->lock, flags);
>> +	list_del(&vd->node);
>> +	spin_unlock_irqrestore(&vc->lock, flags);
>> +
>> +	dev_dbg(vc->chan.device->dev, "vchan %p: txd %p[%x]: freeing\n",
>> +		vc, vd, vd->tx.cookie);
>> +	vc->desc_free(vd);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(vchan_tx_desc_free);
> this one seems okay, can you add comments here and also update documentation
> for this
Ah yes, very good point, doxygen like documentation, got it.

>> @@ -96,9 +115,13 @@ void vchan_dma_desc_free_list(struct virt_dma_chan *vc, struct list_head *head)
>>  	while (!list_empty(head)) {
>>  		struct virt_dma_desc *vd = list_first_entry(head,
>>  			struct virt_dma_desc, node);
>> -		list_del(&vd->node);
>> -		dev_dbg(vc->chan.device->dev, "txd %p: freeing\n", vd);
>> -		vc->desc_free(vd);
>> +		if (dmaengine_desc_test_reuse(&vd->tx)) {
>> +			list_move_tail(&vd->node, &vc->desc_allocated);
>
> should we check this if the list is to be freed? Why would anyone call free
> except when cleaning up ?
Yes, there is a corner case : a driver does a dmaengine_terminate_all(), to stop
the dma transfers (a missed video frame for example). Then upon the sync signal,
it resubmits the reusable transfers it had.

Or said differently, reusable transfers should continue to be reusable through a
dmaengine_terminate_all(), hence this test. And there is a link with your
comment below.

>>  static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
>>  {
>> +	struct virt_dma_desc *vd;
>>  	unsigned long flags;
>>  	LIST_HEAD(head);
>>  
>>  	spin_lock_irqsave(&vc->lock, flags);
>>  	vchan_get_all_descriptors(vc, &head);
>> +	list_for_each_entry(vd, &head, node)
>> +		dmaengine_desc_clear_reuse(&vd->tx);
>
> why do we want to do this, if we are freeing them
Because if we don't clear reuse flag, vchan_dma_desc_free_list() won't really
free the descriptor, but move it to allocated list.

Cheers.

-- 
Robert
