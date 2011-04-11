From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 11 Apr 2011 16:09:38 +0530
Subject: dmaengine: Can we schedule new transfer from dma
	callback	routine??
In-Reply-To: <20110411085603.GA13041@n2100.arm.linux.org.uk>
References: <4DA2B3D8.6060707@st.com>
	<20110411085603.GA13041@n2100.arm.linux.org.uk>
Message-ID: <4DA2DA6A.6000202@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2011 02:26 PM, Russell King - ARM Linux wrote:
> On Mon, Apr 11, 2011 at 01:25:04PM +0530, viresh kumar wrote:
>>
>> Hello,
>>
>> In dw_dmac.c driver, dwc_descriptor_complete() routine, following is
>> mentioned before calling callback:
>>
>> 	/*
>> 	 * The API requires that no submissions are done from a
>> 	 * callback, so we don't need to drop the lock here
>> 	 */
>> 	if (callback)
>> 		callback(param);
>>
>> Does this hold true for dmaengine??
> 
> Not for slave devices - see Dan's reply:
> 
> http://lists.arm.linux.org.uk/lurker/message/20101223.005313.a38d7bf0.en.html
> 
> As the slave API hasn't been well documented, there's a lot of
> inconsistency of behaviour between DMA engine slave implementations.
> I'd suggest at least fixing slave DMA engine drivers to ensure that:
> 
> (a) the callback is always called in tasklet context
> (b) the callback can submit new slave transactions (iow, the spinlock
>     which prep_slave_sg takes must not be held during the callback.)
> 
> The way that others solve this is to move the completed txd structures
> to a local 'completed' list, and then walk this list after the spinlocks
> have been dropped.
> 
> IOW, something like this:
> 
> my_tasklet()
> {
> 	INIT_LIST_HEAD(completed);
> 
> 	spin_lock_irqsave(my_chan->lock);
> 	for_each_txd(my_txd, my_chan) {
> 		if (has_completed(my_txd))
> 			list_add_tail(my_txd->node, &completed);
> 	}
> 	spin_unlock_irqrestore(my_chan->lock);
> 
> 	list_for_each_entry_safe(my_txd, next, &completed, node) {
> 		void *callback_param = my_txd->txd.callback_param;
> 		void (*fn)(void *) = my_txd->txd.callback;
> 
> 		my_txd_free(my_chan, my_txd);
> 
> 		fn(callback_param);
> 	}	
> }

Got it. Thanx.

-- 
viresh
