From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 14 Sep 2012 15:08:08 +0530
Subject: [PATCH v2 03/15] dmaengine: Add no_wakeup parameter to
 dmaengine_prep_dma_cyclic()
In-Reply-To: <5052F8BC.4020102@ti.com>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-4-git-send-email-peter.ujfalusi@ti.com>
 <5051FB4D.3000009@metafoo.de> <1347593217.1943.26.camel@vkoul-udesk3>
 <5052E72A.8040207@metafoo.de> <1347612630.1943.29.camel@vkoul-udesk3>
 <5052F8BC.4020102@ti.com>
Message-ID: <1347615488.1943.47.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-14 at 12:28 +0300, Peter Ujfalusi wrote:
> Hi,
> 
> On 09/14/2012 11:50 AM, Vinod Koul wrote:
> >> Well, the idea was that the driver would disable interrupts if there is no
> >> callback to call, since there would be nothing to do in the interrupt
> >> handler anyway. But I guess the flags approach should work fine as well.
> > Yes we _could_ do that, but this relies on dmaengine driver to have this
> > implicit understanding. Anyone using dmaengine library in ASoC may or
> > may not be aware of this, so i would consider it hackish.
> > 
> > Using this flag explicitly makes everyone aware what the intended
> > behaviour is.
> 
> I'm not sure about which flags should ASoC set for the two case we are going
> to have. I think it should be something like this:
> 
> unsigned long flags = DMA_CTRL_ACK;
usage of ACK flag is mostly async_tx thingy, we can skip it for slave.
> 
> if (!substream->runtime->no_period_wakeup)
> 	flags |= DMA_PREP_INTERRUPT;
> I'm not 100% sure of the role of DMA_CTRL_ACK in this case. Or should we only
> handle the DMA_PREP_INTERRUPT flag, like this:
> 
> unsigned long flags = 0;
> 
> if (!substream->runtime->no_period_wakeup)
> 	flags |= DMA_PREP_INTERRUPT;
> 
> 
> What do you think?
Looks fine.

-- 
~Vinod
