From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Jun 2013 22:15:57 +0100
Subject: [PATCH] ARM: dma: imx: Fix deadlock bug
In-Reply-To: <1370724988-16426-1-git-send-email-shc_work@mail.ru>
References: <1370724988-16426-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130608211557.GK18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 09, 2013 at 12:56:28AM +0400, Alexander Shiyan wrote:
> @@ -625,8 +613,9 @@ static void imxdma_tasklet(unsigned long data)
>  	struct imxdma_channel *imxdmac = (void *)data;
>  	struct imxdma_engine *imxdma = imxdmac->imxdma;
>  	struct imxdma_desc *desc;
> +	unsigned long flags;
>  
> -	spin_lock(&imxdma->lock);
> +	spin_lock_irqsave(&imxdma->lock, flags);
>  
>  	if (list_empty(&imxdmac->ld_active)) {
>  		/* Someone might have called terminate all */
> @@ -663,7 +652,7 @@ static void imxdma_tasklet(unsigned long data)
>  				 __func__, imxdmac->channel);
>  	}
>  out:
> -	spin_unlock(&imxdma->lock);
> +	spin_unlock_irqrestore(&imxdma->lock, flags);

So, I just peeked at this driver.  Who is reviewing DMA engine drivers
and why aren't they reviewing stuff properly.

static void imxdma_tasklet(unsigned long data)
{
...
        spin_lock(&imxdma->lock);
...
        if (desc->desc.callback)
                desc->desc.callback(desc->desc.callback_param);
...
out:
        spin_unlock(&imxdma->lock);
}

This stuff is well known and even documented:

        For slave DMA, the subsequent transaction may not be available
        for submission prior to callback function being invoked, so
        slave DMA callbacks are permitted to prepare and submit a new
        transaction.

        For cyclic DMA, a callback function may wish to terminate the
        DMA via dmaengine_terminate_all().

        Therefore, it is important that DMA engine drivers drop any
        locks before calling the callback function which may cause a
        deadlock.

        Note that callbacks will always be invoked from the DMA
        engines tasklet, never from interrupt context.

Note the 3rd paragraph - and note that the IMX driver violates this
by holding that spinlock.  Changing that spinlock to be an irq-saving
type just makes the problem worse.

What's more is it takes this same lock in the submit and issue_pending
functions - so this is potential deadlock territory by the mere fact
that a callback function _can_ invoke these two functions.

It also makes use of __memzero.  Don't.  Use memset().

Doesn't check the return value of clk_prepare_enable().

Mixes up accessors and direct accesses:
                imxdmac->sg_list[i].dma_address = dma_addr;
                sg_dma_len(&imxdmac->sg_list[i]) = period_len;
The first should be accessed via sg_dma_address().

Reimplements much of virt-dma.c/.h - maybe it should use this support
instead?  As an added benefit you'll be able to start the next queued
request without the tasklet and get better throughput as a result -
and process all completed transfers upon tasklet invocation.
