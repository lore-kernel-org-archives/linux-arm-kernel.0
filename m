From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Aug 2016 16:38:35 +0100
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <cff588a1-d85f-3d2c-ef61-1674d0d3ca92@codeaurora.org>
References: <1468465076-27324-1-git-send-email-okaya@codeaurora.org>
 <ccffcabf-1448-57a1-d18b-715cfd46e906@codeaurora.org>
 <20160724062425.GW9681@localhost>
 <971733d9-fd18-2a1b-07c0-349b47747d49@codeaurora.org>
 <20160804125525.GF9681@localhost>
 <71a15611-645f-7523-1c26-14b420aff667@codeaurora.org>
 <20160804144003.GV1041@n2100.armlinux.org.uk>
 <cff588a1-d85f-3d2c-ef61-1674d0d3ca92@codeaurora.org>
Message-ID: <20160804153835.GY1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 11:27:46AM -0400, Sinan Kaya wrote:
> On 8/4/2016 10:40 AM, Russell King - ARM Linux wrote:
> > On Thu, Aug 04, 2016 at 10:17:24AM -0400, Sinan Kaya wrote:
> >> Thanks for describing this. I was confused about DMA_SUCCESS and DMA_COMPLETE.
> >> I now understand that tx_success API just returns information that the request
> >> was executed whether the result is error or not. This makes sense now.
> >>
> >> However, if the txn is failure; then we should never call the client callback
> >> since DMA engine cannot provide such feedback to the client without Dave's patch.
> >> You are saying that the calling the callback is optional.
> >>
> >> Then, the callback cannot be optional in the error case for old behavior.
> >>
> >> How does the client know if memcpy executed or not? The client got its callback
> >> and tx_status is also DMA_COMPLETE.
> > 
> > If an error occurred, then dma_async_is_tx_complete() is supposed to
> > return DMA_ERROR.  It's up to the DMA engine driver to ensure that
> > this happens if it has error detection abilities.
> > 
> 
> Well, that's not what I'm getting from Vinod and also from the current usage
> in most of the drivers that I looked.
> 
> The current drivers implement tx_status as follows.
> 
> static enum dma_status xyz_tx_status(struct dma_chan *chan,
> 	dma_cookie_t cookie, struct dma_tx_state *state) 
> {
> ...
> 	ret = dma_cookie_status(&c->vc.chan, cookie, state);
> 	if (ret == DMA_COMPLETE)
> 		return ret; 
> ...
> }

And... how many of those drivers detect an error occuring in the DMA?
If they don't detect an error during DMA, I'm curious what would you
expect the above to look like.

> I also made the argument that the driver should not call dma_cookie_complete
> for failure cases and somehow return an error for transactions that failed. 

You can't omit individual dma_cookie_complete() calls like that (I think
you have little understanding how the cookie system works.)

The cookies consist of continuous pool of numbers.  Each transaction
gets allocated a cookie which is incremented from the previous
transaction.  Any transaction can be identified as complete or pending
depending on whether the cookie value that it has is earlier or later
than the current completion cookie value.

What this means is if you try to do this:

- transaction 1 completes successfully, call dma_cookie_complete()
- transaction 2 completes with an error, omit dma_cookie_complete()
- transaction 3 completes successfully, call dma_cookie_complete()

The effect at the end of that sequence will be as if transaction 2 had
called dma_cookie_complete() - because the completed cookie value will
now be ahead of transaction 2's cookie.

So, playing bakes with dma_cookie_complete() really won't work.  Please
forget this idea.  dma_cookie_complete() merely indicates whether the
transaction completed or is still in progress.  It's got nothing to do
with error status.

What you instead need to do is to find some way to record in your
driver that transaction 2 failed, and when dma_cookie_status() says
that a transaction has DMA_COMPLETE status, you need to look up to
see whether it failed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
