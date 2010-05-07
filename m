From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 7 May 2010 10:59:26 +0200
Subject: [PATCH 2/2] DMA: PL330: Add async dma api driver
In-Reply-To: <1273215671-3090-1-git-send-email-jassisinghbrar@gmail.com>
References: <1273215671-3090-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <i2r63386a3d1005070159tf0879839u24c1c1f11466970d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/7 Jassi Brar <jassisinghbrar@gmail.com>:

> Add ASYNC DMA Engine API driver for the PL330 DMAC.
> This driver is supposed to be reusable by various
> platforms that have one or more PL330 DMACs.
> Atm, DMA_SLAVE and DMA_MEMCPY capabilities have been
> implemented.
>
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

This needs some updating to apply and compile on Dan Williams tree,
please clone async_tx from git.kernel.org and generate the patch on that
tree instead. (It's my updates for generic channel status etc that
collide.)

You'll also find these changes in Rothwell's -next tree.

> (...)

> +static void pl330_terminate_all(struct dma_chan *chan)

This needs to be converted to the new prototype and will look
something like this:

static int
pl330_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd)

> +static enum dma_status
> +pl330_is_tx_complete(struct dma_chan *chan, dma_cookie_t cookie,
> + ? ? ? ? ? ? ? dma_cookie_t *done, dma_cookie_t *used)

This needs to be converted to the new prototype and will look
something like this:

static enum dma_status
pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
                 struct dma_tx_state *txstate)

See the other drivers for examples, e.g. coh901318.c
coh901318_control() and coh901318_tx_status()

(...)
> + ? ? ? pd->device_is_tx_complete = pl330_is_tx_complete;
> + ? ? ? pd->device_prep_slave_sg = pl330_prep_slave_sg;
> + ? ? ? pd->device_terminate_all = pl330_terminate_all;
> + ? ? ? pd->device_issue_pending = pl330_issue_pending;

Consequential updates here.

Sorry for the mess, moving target as usual...

If you fix this and test it on async_tx it's:
Reviewed-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
