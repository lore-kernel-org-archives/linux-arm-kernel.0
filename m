From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 5 Dec 2014 20:33:02 +0530
Subject: [PATCH] dma: pl330: revert commit 04abf5daf7d
In-Reply-To: <5481B573.8090902@metafoo.de>
References: <1417785296-4435-1-git-send-email-jaswinder.singh@linaro.org>
 <5481B573.8090902@metafoo.de>
Message-ID: <20141205150302.GJ3411@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 02:38:59PM +0100, Lars-Peter Clausen wrote:
> On 12/05/2014 02:14 PM, Jassi Brar wrote:
> > From Documentation/crypto/async-tx-api.txt
> >   "... Once a driver-specific threshold is met the driver
> >automatically issues pending operations.  An application can force
> >this event by calling async_tx_issue_pending_all() ..."
> >  That is, the DMA controller drivers may buffer transfer requests
> >for optimization. However it is perfectly legal to start dma as soon
> >as the user calls .tx_submit() on the descriptor, as the documentation
> >specifies in include/linux/dmaengine.h
Noooo, submit does not mean that as all

> 
> It's not according to what is in the DMAengine documentation
> (Documentation/dmaengine.txt) and what we have been telling people
> for the last couple of years.
> 
> There are supposed to be two different queues one for pending
> descriptors and one for active descriptors. submit() adds a
> descriptor to the pending list and issue_pending() moves all
> descriptors from the pending list to the active list. Especially the
> driver must not automatically start transferring a descriptor after
> it has been submitted but before issue_pending() has been called.
right

to quote the Documentation:

       + tx_submit:	A pointer to a function you have to implement,
			that is supposed to push the current
			transaction descriptor to a pending queue, waiting
			for issue_pending to be called.
   * device_issue_pending
     - Takes the first transaction descriptor in the pending queue,
       and starts the transfer. Whenever that transfer is done, it
       should move to the next transaction in the list.
     - This function can be called in an interrupt context

Pls see Documentation/dmaengine/provider.txt in dmaengine-next

-- 
~Vinod
