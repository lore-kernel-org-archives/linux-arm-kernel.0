From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 24 Mar 2015 21:58:16 +0530
Subject: [PATCH v5] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <BN1AFFO11FD0176A49A50DC8480B79E879A10D0@BN1AFFO11FD017.protection.gbl>
References: <6f3b34935c0f405199cacd5312e972ac@BN1BFFO11FD017.protection.gbl>
 <20150317110739.GE32683@intel.com>
 <BN1AFFO11FD0176A49A50DC8480B79E879A10D0@BN1AFFO11FD017.protection.gbl>
Message-ID: <20150324162815.GD32683@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 04:24:26PM +0000, Appana Durga Kedareswara Rao wrote:
> > > +static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
> > > +                                       dma_cookie_t cookie,
> > > +                                       struct dma_tx_state *txstate) {
> > > +   struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
> > > +   enum dma_status ret;
> > > +   unsigned long flags;
> > > +
> > > +   ret = dma_cookie_status(dchan, cookie, txstate);
> > > +   if (ret != DMA_COMPLETE) {
> > txstate can be null
> 
> Ok will modify.
> It will be something like below
> 
> ret = dma_cookie_status(dchan, cookie, txstate);
> if (ret == DMA_COMPLETE || !txstate)
>         return ret;
> Calculate residue.
> 
> Please correct me if I am wrong
Thats right

> > > +static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan
> > > +*chan) {
> > > +   struct xilinx_dma_tx_descriptor *desc;
> > > +   struct xilinx_dma_tx_segment *segment, *next;
> > > +   struct xilinx_dma_desc_hw *hw;
> > > +   unsigned long flags;
> > > +   u32 residue = 0;
> > > +
> > > +   spin_lock_irqsave(&chan->lock, flags);
> > > +
> > > +   desc = chan->active_desc;
> > > +   if (!desc) {
> > > +           dev_dbg(chan->dev, "no running descriptors\n");
> > > +           goto out_unlock;
> > > +   }
> > > +
> > > +   if (chan->has_sg) {
> > > +           list_for_each_entry_safe(segment, next, &desc->segments,
> > node) {
> > > +                   hw = &segment->hw;
> > > +                   residue += (hw->control - hw->status) &
> > > +                              XILINX_DMA_MAX_TRANS_LEN;
> > > +           }
> > why are we calculating residue here?
> 
> 
> This API is called from Interrupt handler when the BD(Buffer Descriptor) is
> Successfully transmitted.
> Thought of calculating residue here is more accurate than calculating the residue in the
> tx_status.
Nope, you need to report reside when asked not precompute!

> This is while preparing the descs, but I see your point.  I will fix
> it in my next version of the patch.
> 
> >
> > > +   async_tx_ack(&desc->async_tx);
> > why?
> 
> It is not required?
> As far as I know we should ack the descriptor for Slave dma case right?
> ( https://www.kernel.org/doc/Documentation/crypto/async-tx-api.txt )
No you dont, for slave you need to read Documentation/dmaengine/

> > > +static int xilinx_dma_remove(struct platform_device *pdev) {
> > > +   struct xilinx_dma_device *xdev = platform_get_drvdata(pdev);
> > > +   int i;
> > > +
> > > +   of_dma_controller_free(pdev->dev.of_node);
> > > +   dma_async_device_unregister(&xdev->common);
> > > +
> > > +   for (i = 0; i < XILINX_DMA_MAX_CHANS_PER_DEVICE; i++)
> > > +           if (xdev->chan[i])
> > > +                   xilinx_dma_chan_remove(xdev->chan[i]);
> > > +
> > at this point your irq is active and tasklet cna still be scheduled
> 
> We are freeing the IRQ and killing the tasklet in the chan_remove API why irq is still active at this point of time?
I missed this  bit, if you are freeing irq explcitly then it should be okay

> I didn't get you.
> Could you please explain a bit?

-- 
~Vinod
