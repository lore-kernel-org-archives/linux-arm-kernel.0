From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 13 Nov 2009 12:17:27 -0700
Subject: [PATCH] Add COH 901 318 DMA block driver v4
In-Reply-To: <1257798973-11943-1-git-send-email-linus.walleij@stericsson.com>
References: <1257798973-11943-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <e9c3a7c20911131117i18754423k1313d0cfd3c85d30@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, Nov 9, 2009 at 1:36 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This patch adds support for the ST-Ericsson COH 901 318 DMA block,
> found in the U300 series platforms. It registers a DMA slave for
> device I/O and also a memcpy slave for memcpy.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> ChangeLog v3->v4
> - Removed the useless forward declaration of structs by arranging
> ?#includes correctly. (Alan Cox)
> - NULL check ordering, exit on failure etc (Alan Cox)
> - Fixed a possible overflow in if statement. (Alan Cox)
> - Tag IO areas as __iomem (Alan Cox)
> - Check for base adresss NULL before operating on pointer on
> ?several spots. (Alan Cox)
> - Removed dma_map() and dma_unmap() - clients shall do this.
> ?(Maciej)
> - Add spin_unlock() in error path for coh901318_lli_fill_sg.
> ?(Maciej)
> - Hope it is fine now!

Sorry I did not notice the below earlier...

[..]
> +static struct dma_async_tx_descriptor *
> +coh901318_prep_interrupt(struct dma_chan *chan,
> + ? ? ? ? ? ? ? ? ? ? ? ?unsigned long flags)
> +{
> + ? ? ? /* TODO implement */
> +
> + ? ? ? return NULL;
> +}
> +
> +static enum dma_status
> +coh901318_is_tx_complete(struct dma_chan *chan,
> + ? ? ? ? ? ? ? ? ? ? ? ?dma_cookie_t cookie, dma_cookie_t *last,
> + ? ? ? ? ? ? ? ? ? ? ? ?dma_cookie_t *used)
> +{
> + ? ? ? /* TODO implement */
> +
> + ? ? ? return DMA_SUCCESS;
> +}

You don't want to do it this way because it will seriously confuse the
memory-to-memory dma clients (async_tx and net_dma).  It looks like
you really only want this engine for slave_dma operations??  I expect
this driver will corrupt network traffic if CONFIG_NET_DMA=y and
raid5,6 operations if ASYNC_TX_DMA=y because any attempt by those apis
to poll for completion will result in success regardless of the
channel state.  At this point I would say just disable DMA_MEMCPY and
DMA_INTERRUPT in the channel capability bit masks, or add "depends on
!NET_DMA && !ASYNC_TX_DMA in the Kconfig entry.

> +struct coh901318_lli *
> +coh901318_lli_alloc(struct coh901318_pool *pool, unsigned int len)
> +{
> + ? ? ? int i;
> + ? ? ? struct coh901318_lli *head;
> + ? ? ? struct coh901318_lli *lli;
> + ? ? ? struct coh901318_lli *lli_prev;
> + ? ? ? dma_addr_t phy;
> +
> + ? ? ? if (len == 0)
> + ? ? ? ? ? ? ? goto err;
> +
> + ? ? ? spin_lock(&pool->lock);
> +
> + ? ? ? head = dma_pool_alloc(pool->dmapool, GFP_ATOMIC, &phy);
> +

My new mini-crusade [1] is to question GFP_ATOMIC usage versus
GFP_NOWAIT.  Especially for memory-to-memory dma offload where we can
fall back to a software routine, or poll for a descriptor, rather than
asking the allocator for an emergency allocation.  Maybe in your
slave_dma usage model it makes sense, but I'll leave it up to your
discretion.

--
Dan

[1]: http://marc.info/?l=linux-kernel&m=125807571113119&w=2

nit:
+++ b/arch/arm/mach-u300/include/mach/coh901318.h
@@ -0,0 +1,281 @@
+/*
+ *
+ * include/linux/coh901318.h

...should be arch/arm/mach-u300/include/mach/coh901318.h
