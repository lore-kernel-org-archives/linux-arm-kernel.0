From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 23 Aug 2015 19:38:23 +0530
Subject: [PATCH v4 2/2] dma: Add Xilinx zynqmp dma engine driver support
In-Reply-To: <CAGnW=BaU__+B2uAK=qpV3QP60SqSUxx-kgJVs0t42K0fqTxL0g@mail.gmail.com>
References: <1438831173-8761-1-git-send-email-punnaia@xilinx.com>
 <1438831173-8761-2-git-send-email-punnaia@xilinx.com>
 <20150820061312.GA13546@localhost>
 <CAGnW=BaU__+B2uAK=qpV3QP60SqSUxx-kgJVs0t42K0fqTxL0g@mail.gmail.com>
Message-ID: <20150823140823.GA13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 12:01:27PM +0530, punnaiah choudary kalluri wrote:
> On Thu, Aug 20, 2015 at 11:43 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Thu, Aug 06, 2015 at 08:49:33AM +0530, Punnaiah Choudary Kalluri wrote:
> >
> >> +     list_for_each_entry_safe(desc, next, &chan->done_list, node) {
> >> +             dma_async_tx_callback callback;
> >> +             void *callback_param;
> >> +
> >> +             list_del(&desc->node);
> >> +
> >> +             callback = desc->async_tx.callback;
> >> +             callback_param = desc->async_tx.callback_param;
> >> +             if (callback) {
> >> +                     if (in_interrupt())
> >> +                             spin_unlock_bh(&chan->lock);
> >> +                     else
> >> +                             spin_unlock(&chan->lock);
> >
> > This looks bad!
> > Why would callback be called from different context. It should only be
> > invoked from your tasklet
> 
> During the terminate call, driver need to clean up the existing BDs so that time
> this function will be called from the thread or process context in
> addition to the
> tasklet context.
> 
> DO you have any suggestion here ?

Yes you need to terminate but you don't need to invoke user for terminate
flow. It is not expected.
Terminate flow expect youu to clean the channels

-- 
~Vinod
