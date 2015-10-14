From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 14 Oct 2015 19:44:33 +0530
Subject: [PATCH v2 2/4] dmaengine: Add STM32 DMA driver
In-Reply-To: <CAOAejn3QOzrd952MztVTah4UbpNs1OabwkxhEtp15Mqz0B7LXA@mail.gmail.com>
References: <1444745127-1105-1-git-send-email-cedric.madianga@gmail.com>
 <1444745127-1105-3-git-send-email-cedric.madianga@gmail.com>
 <20151014111615.GR27370@localhost>
 <CAOAejn3QOzrd952MztVTah4UbpNs1OabwkxhEtp15Mqz0B7LXA@mail.gmail.com>
Message-ID: <20151014141433.GT27370@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 03:07:16PM +0200, M'boumba Cedric Madianga wrote:
> >> +static inline uint32_t stm32_dma_read(struct stm32_dma_device *dmadev, u32 reg)
> >
> > this and few other could be made more readable
> 
> Ok, I could replace uint32_t by u32. Is it what you expect ?
> For others, I don't see how I could make it more readable.
> Could you please give me more details to help me ? Thanks in advance

Yes that is one and also aplitting this up so that it fits within 80chars
while not sacrficing readablity...

> >> +     } else if ((status & STM32_DMA_FEI) && (sfcr & STM32_DMA_SFCR_FEIE)) {
> >> +             dev_err(chan2dev(chan), "DMA error: received FEI event\n");
> >> +             stm32_dma_irq_clear(chan, STM32_DMA_FEI);
> >> +             chan->status = DMA_ERROR;
> >> +             spin_unlock(&chan->vchan.lock);
> >> +             return IRQ_HANDLED;
> >
> > this is repeat of above apart from err print!!
> 
> Not only for print as we also need that to define which bit to clear
> in the IRQ status.
> In that way we will be sure to handle each interrupt event.

You can print error type based on status, or print the whole status but
handle it same for all three cases

> >> +     enum dma_status status;
> >> +     unsigned long flags;
> >> +     unsigned int residue;
> >> +
> >> +     status = dma_cookie_status(c, cookie, state);
> >> +     if (status == DMA_COMPLETE)
> >> +             return status;
> >> +
> >> +     if (!state)
> >> +             return chan->status;
> > why channel status and not status from dma_cookie_status()?
> 
> If status is different than DMA_COMPLETE it seems better to use channel status.
> Indeed, in that way, we have the possibility to notify that there is a
> potential error in the bus via DMA_ERROR.
> But if I return status from dma_cookie_status(), I will always notify
> DMA_IN_PROGRESS.

No, you are supposed to return the descriptor status and not channel status!

-- 
~Vinod
