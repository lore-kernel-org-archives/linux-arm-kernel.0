From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Aug 2016 15:40:04 +0100
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <71a15611-645f-7523-1c26-14b420aff667@codeaurora.org>
References: <1468465076-27324-1-git-send-email-okaya@codeaurora.org>
 <ccffcabf-1448-57a1-d18b-715cfd46e906@codeaurora.org>
 <20160724062425.GW9681@localhost>
 <971733d9-fd18-2a1b-07c0-349b47747d49@codeaurora.org>
 <20160804125525.GF9681@localhost>
 <71a15611-645f-7523-1c26-14b420aff667@codeaurora.org>
Message-ID: <20160804144003.GV1041@n2100.armlinux.org.uk>
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
> 
> Then, the callback cannot be optional in the error case for old behavior.
> 
> How does the client know if memcpy executed or not? The client got its callback
> and tx_status is also DMA_COMPLETE.

If an error occurred, then dma_async_is_tx_complete() is supposed to
return DMA_ERROR.  It's up to the DMA engine driver to ensure that
this happens if it has error detection abilities.

Most of the helpers in drivers/dma/dmaengine.h are there to _assist_
the driver writer - they can't do magic.  dma_cookie_status() will
return from the point of view of the generic DMA code what the status
of a particular cookie is, and the cookie state.  It doesn't take
care of whether a particular transaction associated with a cookie
failed or not - that's up to the driver.

So, if dma_cookie_status() says that a cookie has DMA_COMPLETED
status, and the DMA engine is able to detect errors on individual
transfers, then the driver needs to do further status lookup to
determine whether the particular transaction referred to by the
cookie did fail, and modify the returned status appropriately.

If dma_cookie_status() says that the cookie is DMA_IN_PROGRESS,
then the driver is expected to calculate and report the residue
(the remaining number of bytes) of the referred to transaction.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
