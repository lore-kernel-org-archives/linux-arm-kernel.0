From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 8 Aug 2016 14:21:55 +0530
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <71a15611-645f-7523-1c26-14b420aff667@codeaurora.org>
References: <1468465076-27324-1-git-send-email-okaya@codeaurora.org>
 <ccffcabf-1448-57a1-d18b-715cfd46e906@codeaurora.org>
 <20160724062425.GW9681@localhost>
 <971733d9-fd18-2a1b-07c0-349b47747d49@codeaurora.org>
 <20160804125525.GF9681@localhost>
 <71a15611-645f-7523-1c26-14b420aff667@codeaurora.org>
Message-ID: <20160808085155.GX9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 10:17:24AM -0400, Sinan Kaya wrote:
> On 8/4/2016 8:55 AM, Vinod Koul wrote:
> > Dmaengine tells transaction is complete. It does not say if the txn is
> > success or failure. It can transfer data and not say if data was
> > correct. A successful transaction implies data integrity as well, which
> > dmaengine can't provide.
> 
> Thanks for describing this. I was confused about DMA_SUCCESS and DMA_COMPLETE.
> I now understand that tx_success API just returns information that the request
> was executed whether the result is error or not. This makes sense now.
> 
> However, if the txn is failure; then we should never call the client callback
> since DMA engine cannot provide such feedback to the client without Dave's patch.
> You are saying that the calling the callback is optional.

Yes callback is optional, *BUT* not for driver. If a user has set a
callback, you _have_ to invoke it. That is the expectation from user and
you cannot selectively choose!

When I say callback is optional, it means only from caller PoV, not from
dmanegine driver. Caller may not have set it!

> Then, the callback cannot be optional in the error case for old behavior.
> 
> How does the client know if memcpy executed or not? The client got its callback
> and tx_status is also DMA_COMPLETE.

So cookie status should be checked after callback. We can also report
DMA_ERROR if you can detect one. Some hardware can do that (not very
common though), but even if you report DMA_COMPLETE, that never implies
success for transaction.

> Is the client supposed to do a memcmp ? (BTW, it doesn't make sense).

If someone really want to check data, then yes. But I don't really see
the point in that. Users would anyone complain the bad data and you fix
the bug :)

> 
> 
> >> In my opinion, the new behavior is correct. Calling dma_cookie_complete(desc) all the time
> >> > is not. Do you agree?
> >> > 
> >> > If yes, I can divide this patch into two. One to correct the ordering. Another one
> >> > for behavioral change.
> > See above..
> > 
> > A callback or tx_status will only tell you the txn is completed. That is
> > why we have DMA_COMPLETE and not DMA_SUCCESS.
> > 
> 
> Still calling the callback and returning DMA_COMPLETE isn't right. There is no indication
> of an actual DMA error. The transaction is complete but data integrity failed.

Yes that is the idea..

You are telling client, a transaction has been completed from controller
side. Is the data transfer and integrity is guaranteed, we cannot know..

Data integrity is a function of many other factors, some of which are
not in control of dmaengine. So it cannot guarantee success.

Even the controllers which can report errors, can do that only from
dmaengine PoV, not really from system PoV.


> 
> > So current order seems fine to me!
> 
> I posted v2 of this patch without introducing the behavior change leaving the behavior discussion
> out for another patch. The current code will not call the callback if error was observed.

That's not right, as explained above.

> This patch is needed to fix a race condition as the commit message describes.
> The callback is called before returning the descriptor back to free pool. 
> 
> If the client calls free resources, the descriptor that was not returned to free pool gets lost due
> to race condition.

Hmmm, if you have txn's pending and client wants to free up, shouldn't
the pending txn's be cleaned up? Sound like a different bug to me..

So if I submit 5 txn's and now want to freeup, will you still leak
descriptors? Doesn't sound as right behaviour to me.

> I'll refactor the code after Dave's change for passing the error code while calling the
> callback. That will be a different patch anyhow.

Yes the error reporting is different

-- 
~Vinod
