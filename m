From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 7 Jun 2016 10:54:05 +0530
Subject: [PATCH] dmaengine: bcm2835: Fix polling for completion of DMA
 with interrupts masked.
In-Reply-To: <87a8iy6x41.fsf@eliezer.anholt.net>
References: <1465007351-5559-1-git-send-email-eric@anholt.net>
 <20160606042635.GU16910@localhost>
 <87a8iy6x41.fsf@eliezer.anholt.net>
Message-ID: <20160607052405.GC16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 10:33:18AM -0700, Eric Anholt wrote:
> Vinod Koul <vinod.koul@intel.com> writes:
> 
> > On Fri, Jun 03, 2016 at 07:29:11PM -0700, Eric Anholt wrote:
> >> The tx_status hook is supposed to be safe to call from interrupt
> >> context, but it wouldn't ever return completion for the last transfer,
> >> meaning you couldn't poll for DMA completion with interrupts masked.
> >
> > and why is that?
> 
> Maybe this was poorly worded.  How about:
> 
> The tx_status hook is supposed to be safe to call from interrupt
> context.  However, the current transfer currently only gets marked
> complete by the IRQ handler, so if interrupts were masked then polling
> for completion would never finish.

Sound better :)

> 
> >> This fixes IRQ handling for bcm2835's DSI1, which requires using the
> >> DMA engine to write its registers due to a bug in the AXI bridge.
> >> 
> >> Signed-off-by: Eric Anholt <eric@anholt.net>
> >> ---
> >>  drivers/dma/bcm2835-dma.c | 24 +++++++++++++++++++-----
> >>  1 file changed, 19 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> >> index 6149b27c33ad..320461c578e3 100644
> >> --- a/drivers/dma/bcm2835-dma.c
> >> +++ b/drivers/dma/bcm2835-dma.c
> >> @@ -570,16 +570,16 @@ static enum dma_status bcm2835_dma_tx_status(struct dma_chan *chan,
> >>  	struct virt_dma_desc *vd;
> >>  	enum dma_status ret;
> >>  	unsigned long flags;
> >> +	u32 residue;
> >>  
> >>  	ret = dma_cookie_status(chan, cookie, txstate);
> >> -	if (ret == DMA_COMPLETE || !txstate)
> >> +	if (ret == DMA_COMPLETE)
> >
> > Why do you change this? txstate can be NULL, so no point calculating reside
> > for those cases
> 
> The point was to go into the "Calculate where we're at in our current
> DMA (if the current DMA is the one we're asking about status for)" path,
> so that we could note when the DMA is complete even when there's no
> txstate passed in.

Can you explain what you mean by current DMA!

The claulation is always done for 'descriptor' represnted by the cookie. So
it doesnt not matter...!

Thanks
-- 
~Vinod
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/a6b87432/attachment.sig>
