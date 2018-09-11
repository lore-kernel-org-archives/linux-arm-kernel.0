From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 11 Sep 2018 17:17:16 +0200
Subject: [PATCH] dmaengine: zx-dma: replace spin_lock_irqsave with
 spin_lock in ISR
In-Reply-To: <20180911143158.52917-1-hangdianqj@163.com>
References: <20180911143158.52917-1-hangdianqj@163.com>
Message-ID: <1536679036.3362.58.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 11.09.2018, 07:31 -0700 schrieb jun qian:
> As you are already in ISR, it is unnecessary to call
> spin_lock_irqsave.

As the IRQ in this driver isn't marked with IRQF_NO_THREAD, this is
going to blow up if the kernel is booted with the "threadirqs" command
line argument.

Regards,
Lucas

> Signed-off-by: jun qian <hangdianqj@163.com>
> Cc: Barry song <21cnbao@gmail.com>
> ---
> ?drivers/dma/zx_dma.c | 5 ++---
> ?1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/zx_dma.c b/drivers/dma/zx_dma.c
> index 2571bc7693df..111ab2db83b1 100644
> --- a/drivers/dma/zx_dma.c
> +++ b/drivers/dma/zx_dma.c
> @@ -288,9 +288,8 @@ static irqreturn_t zx_dma_int_handler(int irq,
> void *dev_id)
> ?		p = &d->phy[i];
> ?		c = p->vchan;
> ?		if (c) {
> -			unsigned long flags;
> ?
> -			spin_lock_irqsave(&c->vc.lock, flags);
> +			spin_lock(&c->vc.lock);
> ?			if (c->cyclic) {
> ?				vchan_cyclic_callback(&p->ds_run-
> >vd);
> ?			} else {
> @@ -298,7 +297,7 @@ static irqreturn_t zx_dma_int_handler(int irq,
> void *dev_id)
> ?				p->ds_done = p->ds_run;
> ?				task = 1;
> ?			}
> -			spin_unlock_irqrestore(&c->vc.lock, flags);
> +			spin_unlock(&c->vc.lock);
> ?			irq_chan |= BIT(i);
> ?		}
> ?	}
