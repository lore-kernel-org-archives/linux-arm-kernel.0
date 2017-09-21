From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Thu, 21 Sep 2017 14:47:59 +0200
Subject: [PATCH v4 2/4] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <a88a83ba-9477-36ae-87ba-a35f477a5ca1@ti.com>
References: <1504785168-26572-1-git-send-email-pierre-yves.mordret@st.com>
 <1504785168-26572-3-git-send-email-pierre-yves.mordret@st.com>
 <a88a83ba-9477-36ae-87ba-a35f477a5ca1@ti.com>
Message-ID: <ab012ccc-21e4-e487-4ef1-056c36a65cd0@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/21/2017 01:25 PM, Peter Ujfalusi wrote:
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> 
> Great that you got it working w/o a custom API!
> I have one comment, which actually valid for the ti-dma-crossbar driver
> as well...

Yes. That cleans up a little bit the sw architecture. But still this custom API
allowed both DMAMUX and DMA at the same time since using the same channel ID
allocator.
Ok this is another story to be addressed out of this thread ;)

> 
>> +static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>> +					 struct of_dma *ofdma)
>> +
>> +	spin_lock_irqsave(&dmamux->lock, flags);
>> +	mux->chan_id = find_first_zero_bit(dmamux->dma_inuse,
>> +					   dmamux->dma_requests);
> 
> you pick the first available chan_id here under the lock.
> 
>> +	spin_unlock_irqrestore(&dmamux->lock, flags);
>> +	if (mux->chan_id == dmamux->dma_requests) {
>> ...
>> +	/* Set dma request */
>> +	spin_lock_irqsave(&dmamux->lock, flags);
>> +	if (!IS_ERR(dmamux->clk)) {
>> ...
>> +	spin_unlock_irqrestore(&dmamux->lock, flags);
>> +
>> +	set_bit(mux->chan_id, dmamux->dma_inuse);
> 
> But nothing stops other parallel threads to pick the same chan_id since
> you have released the lock (released, got the lock to protect the set
> dma request and released it again). imho the find_first_zero_bit() and
> the set_bit() should be done within the same lock to avoid race conditions.
> 
> - P?ter
> 

Yep good catch : That's correct. Even if probability to happen is rather low, it
may happen.
Will solve that.

Py
