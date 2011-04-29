From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 29 Apr 2011 15:48:42 +0530
Subject: [PATCH V3 2/7] dmaengine/dw_dmac: Replace spin_lock* with	irqsave
	variants
In-Reply-To: <20110428171020.GB17290@n2100.arm.linux.org.uk>
References: <cover.1303896566.git.viresh.kumar@st.com>
	<50dc2f47f2c9f94fce78583568830a66af49307d.1303896567.git.viresh.kumar@st.com>
	<20110428171020.GB17290@n2100.arm.linux.org.uk>
Message-ID: <4DBA9082.6040907@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2011 10:40 PM, Russell King - ARM Linux wrote:
> On Wed, Apr 27, 2011 at 03:06:44PM +0530, Viresh Kumar wrote:
>> @@ -407,6 +410,8 @@ EXPORT_SYMBOL(dw_dma_get_dst_addr);
>>  static void dwc_handle_cyclic(struct dw_dma *dw, struct dw_dma_chan *dwc,
>>  		u32 status_block, u32 status_err, u32 status_xfer)
>>  {
>> +	unsigned long flags;
>> +
>>  	if (status_block & dwc->mask) {
>>  		void (*callback)(void *param);
>>  		void *callback_param;
>> @@ -418,9 +423,9 @@ static void dwc_handle_cyclic(struct dw_dma *dw, struct dw_dma_chan *dwc,
>>  		callback = dwc->cdesc->period_callback;
>>  		callback_param = dwc->cdesc->period_callback_param;
>>  		if (callback) {
>> -			spin_unlock(&dwc->lock);
>> +			spin_unlock_irqrestore(&dwc->lock, flags);
>>  			callback(callback_param);
>> -			spin_lock(&dwc->lock);
>> +			spin_lock_irqsave(&dwc->lock, flags);
> 
> I'm really not convinced that this is anywhere near correct.  I'm
> surprised this doesn't spit out a compiler warning.
> 

Sorry, this is done by mistake.

-- 
viresh
