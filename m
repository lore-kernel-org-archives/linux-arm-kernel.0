From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 25 Jul 2016 10:19:44 -0400
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <20160724062425.GW9681@localhost>
References: <1468465076-27324-1-git-send-email-okaya@codeaurora.org>
 <ccffcabf-1448-57a1-d18b-715cfd46e906@codeaurora.org>
 <20160724062425.GW9681@localhost>
Message-ID: <971733d9-fd18-2a1b-07c0-349b47747d49@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 7/24/2016 2:24 AM, Vinod Koul wrote:
> On Fri, Jul 15, 2016 at 09:00:52PM -0400, Sinan Kaya wrote:
>> Hi Vinod,
>>
>> On 7/13/2016 10:57 PM, Sinan Kaya wrote:
>>> There is a race condition between data transfer callback and descriptor
>>> free code. The callback routine may decide to clear the resources even
>>> though the descriptor has not yet been freed.
>>>
>>> Instead of calling the callback first and then releasing the memory,
>>> this code is changing the order to return the descriptor back to the
>>> free pool and then call the user provided callback.
>>>
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>> ---
>>>  drivers/dma/qcom/hidma.c | 26 +++++++++++++++-----------
>>>  1 file changed, 15 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
>>> index 41b5c6d..c41696e 100644
>>> --- a/drivers/dma/qcom/hidma.c
>>> +++ b/drivers/dma/qcom/hidma.c
>>> @@ -111,6 +111,7 @@ static void hidma_process_completed(struct hidma_chan *mchan)
>>>  	struct dma_async_tx_descriptor *desc;
>>>  	dma_cookie_t last_cookie;
>>>  	struct hidma_desc *mdesc;
>>> +	struct hidma_desc *next;
>>>  	unsigned long irqflags;
>>>  	struct list_head list;
>>>  
>>> @@ -122,28 +123,31 @@ static void hidma_process_completed(struct hidma_chan *mchan)
>>>  	spin_unlock_irqrestore(&mchan->lock, irqflags);
>>>  
>>>  	/* Execute callbacks and run dependencies */
>>> -	list_for_each_entry(mdesc, &list, node) {
>>> -		enum dma_status llstat;
>>> +	list_for_each_entry_safe(mdesc, next, &list, node) {
>>> +		dma_async_tx_callback callback;
>>> +		void *param;
>>>  
>>>  		desc = &mdesc->desc;
>>>  
>>>  		spin_lock_irqsave(&mchan->lock, irqflags);
>>> -		dma_cookie_complete(desc);
>>> +		if (hidma_ll_status(mdma->lldev, mdesc->tre_ch)
>>> +			== DMA_COMPLETE)
>>> +			dma_cookie_complete(desc);
>>
>> It looks like I introduced a behavioral change while refactoring the code.
>> The previous one would call the callback only if the transfer was successful
>> but it would always call dma_cookie_complete.
>>
>> The new behavior is to call dma_cookie_complete only if the transfer is successful
>> and it calls the callback even in the case of error cases. Then, the client has
>> to query if transfer was successful.
>>
>> Which one is the correct behavior?
> 
> Hi Sinan,
> 
> Cookie is always completed. That simply means trasactions was completed and
> has no indication if the transaction was successfull or not.
> 
> Uptill now we had no way of reporting error, Dave's series adds that up, so
> you can use it.
> 
> Callback is optional for users. Again we didnt convey success of
> transaction, but a callback for reporting that trasaction was completed. So
> invoking callback makes sense everytime.
> 
> HTH
> 

Let's put Dave's series aside for the moment and assume an error case where
something bad happened during the transfer. I can add the error code once Dave's
series get merged.

Here is the callback from dmatest.

static void dmatest_callback(void *arg)
{ 
	done->done = true;
}

Here is how the request is made.

dma_async_issue_pending(chan);

wait_event_freezable_timeout(done_wait, done.done,
			     msecs_to_jiffies(params->timeout));

status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
if (!done.done) {
	timeout
} else if (status != DMA_COMPLETE) { 
	error
}

success.

Based on what I see here, receiving callback all the time is OK. The client
checks if the callback is received or not first. 

Next, the client checks the status of the tx_status. 

In the error case mentioned, the callback will be executed. done.done will be true.

If I set dma_cookie_complete(desc) in error case, it would be wrong to tell the client
that the transfer is successful. 

In my opinion, the new behavior is correct. Calling dma_cookie_complete(desc) all the time
is not. Do you agree?

If yes, I can divide this patch into two. One to correct the ordering. Another one
for behavioral change.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
