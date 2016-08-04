From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 4 Aug 2016 18:25:25 +0530
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <971733d9-fd18-2a1b-07c0-349b47747d49@codeaurora.org>
References: <1468465076-27324-1-git-send-email-okaya@codeaurora.org>
 <ccffcabf-1448-57a1-d18b-715cfd46e906@codeaurora.org>
 <20160724062425.GW9681@localhost>
 <971733d9-fd18-2a1b-07c0-349b47747d49@codeaurora.org>
Message-ID: <20160804125525.GF9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2016 at 10:19:44AM -0400, Sinan Kaya wrote:
> >>
> >> It looks like I introduced a behavioral change while refactoring the code.
> >> The previous one would call the callback only if the transfer was successful
> >> but it would always call dma_cookie_complete.
> >>
> >> The new behavior is to call dma_cookie_complete only if the transfer is successful
> >> and it calls the callback even in the case of error cases. Then, the client has
> >> to query if transfer was successful.
> >>
> >> Which one is the correct behavior?
> > 
> > Hi Sinan,
> > 
> > Cookie is always completed. That simply means trasactions was completed and
> > has no indication if the transaction was successfull or not.
> > 
> > Uptill now we had no way of reporting error, Dave's series adds that up, so
> > you can use it.
> > 
> > Callback is optional for users. Again we didnt convey success of
> > transaction, but a callback for reporting that trasaction was completed. So
> > invoking callback makes sense everytime.
> > 
> 
> Let's put Dave's series aside for the moment and assume an error case where
> something bad happened during the transfer. I can add the error code once Dave's
> series get merged.

Fair enough..

> Here is the callback from dmatest.
> 
> static void dmatest_callback(void *arg)
> { 
> 	done->done = true;
> }
> 
> Here is how the request is made.
> 
> dma_async_issue_pending(chan);
> 
> wait_event_freezable_timeout(done_wait, done.done,
> 			     msecs_to_jiffies(params->timeout));
> 
> status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
> if (!done.done) {
> 	timeout
> } else if (status != DMA_COMPLETE) { 
> 	error
> }
> 
> success.
> 
> Based on what I see here, receiving callback all the time is OK. The client
> checks if the callback is received or not first. 

Callback is optional from API PoV. Yes ppl do implement it :)

> Next, the client checks the status of the tx_status. 
> 
> In the error case mentioned, the callback will be executed. done.done will be true.
> 
> If I set dma_cookie_complete(desc) in error case, it would be wrong to tell the client
> that the transfer is successful. 

And here is the thing that you missed :)

Dmaengine tells transaction is complete. It does not say if the txn is
success or failure. It can transfer data and not say if data was
correct. A successful transaction implies data integrity as well, which
dmaengine can't provide.

> In my opinion, the new behavior is correct. Calling dma_cookie_complete(desc) all the time
> is not. Do you agree?
> 
> If yes, I can divide this patch into two. One to correct the ordering. Another one
> for behavioral change.

See above..

A callback or tx_status will only tell you the txn is completed. That is
why we have DMA_COMPLETE and not DMA_SUCCESS.

So current order seems fine to me!

-- 
~Vinod
