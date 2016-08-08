From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 8 Aug 2016 10:45:24 -0400
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <20160808090203.GY9681@localhost>
References: <1468465076-27324-1-git-send-email-okaya@codeaurora.org>
 <ccffcabf-1448-57a1-d18b-715cfd46e906@codeaurora.org>
 <20160724062425.GW9681@localhost>
 <971733d9-fd18-2a1b-07c0-349b47747d49@codeaurora.org>
 <20160804125525.GF9681@localhost>
 <71a15611-645f-7523-1c26-14b420aff667@codeaurora.org>
 <20160804144003.GV1041@n2100.armlinux.org.uk>
 <cff588a1-d85f-3d2c-ef61-1674d0d3ca92@codeaurora.org>
 <20160808090203.GY9681@localhost>
Message-ID: <21475c6e-a5f8-5125-3998-f3995ce67c4d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/8/2016 5:02 AM, Vinod Koul wrote:
>> What Vinod is telling me that I need to set the cookie to complete 
>> > whether the transaction is successful or not if the request was accepted
>> > by HW. xyz_tx_status is just an indication that the transaction was accepted
>> > by HW. An error can happen as a result of transaction execution.
> Nope, if the txn is completed you mark it complete. If you can detect error
> (can you??) then you can report DMA_ERROR.
> 

Yes, the HW reports if a transaction failed or not. I have this information
available in hidma_ll_status function for a limited amount of time until the
descriptor gets reused.

> In that latter case do not use dma_async_is_complete() to check. You would
> need to store and report that cookie 'x' failed which you report status in
> .tx_statis()
> 

I really don't like the idea of telling 'hey client I finished your work and I
guarantee you it is complete. A month from now, by the way I actually didn't do
the work that day and I did not tell you'

That's why, I preferred not to call the callback when I observe an error which I
think it makes more sense. 

Where is the reliability in this? Some random bugs showing at random times. 
I'd rather not call the callback and be safe. Especially, if you are talking about
servers; this is plain unacceptable.

As Lars-Peter and I indicated in my last email, I think we need to kill this 
tx_status API and replace all the clients to use Dave's interface. It is practically
impossible to implement a reliable tx_status function.

Once this transition happens, I can implement Dave's interface not before.

Again, it will be a different patch than this one. I think v2 of this patch
needs to go in as it is.

https://lkml.org/lkml/2016/7/31/64

>> > 
>> > If I call dma_cookie_complete for all transactions regardless of transaction
>> > success or not, then the xyz_tx_status returns DMA_COMPLETE. 
> Again that is based on your implementation.
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
