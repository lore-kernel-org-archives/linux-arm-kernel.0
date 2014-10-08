From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 8 Oct 2014 17:49:02 +0530
Subject: [PATCH v2 2/2] Documentation: dmaengine: Add a documentation
 for the dma controller API
In-Reply-To: <2491176.7TIClHxUkE@avalon>
References: <1411746035-15882-1-git-send-email-maxime.ripard@free-electrons.com>
 <5433D9AF.8020508@atmel.com> <20141007145226.GA17925@lukather>
 <2491176.7TIClHxUkE@avalon>
Message-ID: <20141008121902.GU1638@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 06:05:15PM +0300, Laurent Pinchart wrote:
> > > 
> > > Beware, it can be confusing when mixing "descriptors" and "hardware
> > > descriptors". The ones used by the DMA controller itself to describe the
> > > chunks of data (hardware descriptors) and the ones that would represent
> > > them in the driver (tx descriptors). However, it's true that both must
> > > be prepared by this set of functions.
> > 
> > There's a few "hardware" missing indeed, but we can't really avoid the
> > confusion here, since it does rely also on a dma_async_tx_descriptor.
> 
> How about always specifying whether we refer to a "hardware descriptor" or a 
> "transaction descriptor" ?
> 
> > > >> +     - You'll also need to set two fields in this structure:
> > > >> +       + flags:
> > > >> +		TODO: Can it be modified by the driver itself, or
> > > >> +		should it be always the flags passed in the arguments
> > > >> +
> > > >> +       + tx_submit:	A pointer to a function you have to implement,
> > > >> +			that is supposed to push the current descriptor
> > > >> +			to a pending queue, waiting for issue_pending to
> > > >> +			be called.
> > > 
> > > The question remains: why wait when all the information is already
> > > prepared and available for the DMA controller to start the job?
> > > Actually, we don't wait in at_hdmac, just to be more efficient, but I
> > > known that we kind of break this "requirement"... But sorry, it is
> > > another discussion which should be lead elsewhere.
> 
> From my recollection of a discussion I've had with Russell King, I believe the 
> main reason to separate transaction submission (queueing) issue (start) is to 
> let DMA engine drivers issuing several queued requests in one go when hardware 
> supports chaining requests only when none of them are running. It's thus just 
> an optimization. Russell, could you confirm (or infirm) that ?
There are few reasons
- Allow the dmaengine driver to collect and issue all pending txns in shot
(which is not happening today with drivers)
- Allow clients to prepare the txns ahead of time and send them when ready

-- 
~Vinod


> 
> > It's just a guess, but maybe you might not be able to schedule the
> > transfer right away? Think about a very dumb 1-channel (or a more
> > realistic more-DRQ-than-channel) device. You might have all the
> > channels busy doing some other transfers, and it's not really part of
> > the client driver job to address that kind of contention: it just
> > wants to queue some work for a later transfer.
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
