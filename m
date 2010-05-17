From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 17 May 2010 02:55:28 -0700
Subject: [PATCH] DMA: PL330: Add dma api driver
In-Reply-To: <1273641798-26579-1-git-send-email-jassi.brar@samsung.com>
References: <1273641798-26579-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <AANLkTinAmHkVBii9nTZ5tNYU21whHy8awP55nGEc-8Tp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

Looks good, one comment:

On Tue, May 11, 2010 at 10:23 PM, Jassi Brar <jassi.brar@samsung.com> wrote:
> Add DMA Engine API driver for the PL330 DMAC.
> This driver is supposed to be reusable by various
> platforms that have one or more PL330 DMACs.
> Atm, DMA_SLAVE and DMA_MEMCPY capabilities have been
> implemented.
>
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
[..]
> +static void dma_pl330_rqcb(void *token, enum pl330_op_err err)
> +{
> + ? ? ? struct dma_pl330_desc *desc = token;
> + ? ? ? struct dma_pl330_chan *pch = desc->pchan;
> + ? ? ? unsigned long flags;
> +
> + ? ? ? /* If desc aborted */
> + ? ? ? if (!pch)
> + ? ? ? ? ? ? ? return;
> +
> + ? ? ? spin_lock_irqsave(&pch->lock, flags);
> +
> + ? ? ? desc->status = DONE;
> +
> + ? ? ? spin_unlock_irqrestore(&pch->lock, flags);

I don't think you need the lock here.  Assigning an integer is atomic,
and you reschedule the tasklet.

Since this patch depends on the generic bits in Russell's tree I need
to wait until after the ARM tree is pulled to take it through the dma
tree.  So, for now...

Acked-by: Dan Williams <dan.j.williams@intel.com>
