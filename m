From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 27 Jul 2016 11:57:51 +0200
Subject: at_xdmac: txd used outside spinlock after being released?
In-Reply-To: <CAP+RiCAXKmFAzWoow_g=LR=tML7kxAi_dG0w4Z6X9KrvSypD9w@mail.gmail.com>
References: <CAP+RiCAXKmFAzWoow_g=LR=tML7kxAi_dG0w4Z6X9KrvSypD9w@mail.gmail.com>
Message-ID: <20160727095751.GA3700@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brent,

On Tue, Jul 19, 2016 at 10:58:40PM -0500, Brent Taylor wrote:
> Hi Ludovic,
>    I'm learning about the dmaengine subsystem and I was using the
> at_xdmac as a reference.    I'm not real familiar with tasklets
> because I have used threaded interrupt handlers instead of them.
>    I noticed that the variable "txd" in the following block of code
> (from the function at_xdmac_tasklet) is used after releasing the
> atchan->lock and after the "desc" the txd is associated with is
> returned back to the free descriptor list.
> 
>       spin_lock_bh(&atchan->lock);
>       desc = list_first_entry(&atchan->xfers_list,
>                struct at_xdmac_desc,
>                xfer_node);
>      ...
>      txd = &desc->tx_dma_desc;
> 
>       at_xdmac_remove_xfer(atchan, desc);
>       spin_unlock_bh(&atchan->lock);
> 
>       if (!at_xdmac_chan_is_cyclic(atchan)) {
>          dma_cookie_complete(txd);
>          if (txd->callback && (txd->flags & DMA_PREP_INTERRUPT))
>             txd->callback(txd->callback_param);
>       }
> 
>       dma_run_dependencies(txd);
> 
> Is there any danger of another process (maybe running on another
> processor) changing desc->txd after it has been put back on the
> free_list?

To be honest, I have already thought about it and I have probably been
lucky!

> My first thought was to move the spin_unlock_bh(&atchan->lock) untill
> after dma_run_dependencies(txd), but a deadlock will be introduced
> because dma_run_dependencies could invoke at_xdmac_issue_pending which
> could eventually call spin_lock_irqsave(&atchan->lock).  A deadlock
> could also be created if the "callback" function invoked another
> "device_prep_*" function.
> 
> If I'm miss-understanding something, I apologize for the noise.

You're right. At the moment, I had no feedback about a bug related to
this. A customer tested hardly the current driver, much more than I. Since
locking issues are not trivial to debug and to trigger, I am not really
in favour to anticipate it but I keep in mind there is a weakness here.
It doesn't mean I am not open to all good suggestions of course!

One way (which is not too risky) to fix it would be to put descriptors
which are no longer used at the end of the free descriptors list instead
of putting them back at the beginning.

> 
> -- Brent Taylor

Regards

Ludovic
