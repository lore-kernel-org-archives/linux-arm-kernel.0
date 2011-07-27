From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 27 Jul 2011 13:01:20 +0530
Subject: [RFC PATCH] DMA: PL330: Update PL330 DMAC to support runtime PM
In-Reply-To: <4E2FACC3.2010109@samsung.com>
References: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
	<1311744697-10264-2-git-send-email-boojin.kim@samsung.com>
	<4E2FACC3.2010109@samsung.com>
Message-ID: <CABb+yY1wnOaSRwv1ZV=5o4v1wCWq_2FZadus5kP=bwb4-8C2Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2011 at 11:44 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch update runtime PM for PL330 DMAC to reduce power consumption.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> The following patch support runtime PM for PL330 DMAC, but the clock
> of PL330 is always on. If the clock of PL330 is always on, additional power
> (10mA) is consumed.

Yes, we need to do this, but please do it in drivers/dma/pl330.c so that
every platform benefits.

> diff --git a/include/linux/amba/pl330.h b/include/linux/amba/pl330.h
> index 17b0ada..d9a63fd 100644
> --- a/include/linux/amba/pl330.h
> +++ b/include/linux/amba/pl330.h
> @@ -12,6 +12,9 @@
> ?#ifndef ? ? ? ?__AMBA_PL330_H_
> ?#define ? ? ? ?__AMBA_PL330_H_
>
> +#include <linux/dmaengine.h>
> +#include <linux/interrupt.h>
> +
> ?#include <asm/hardware/pl330.h>
>
> ?struct dma_pl330_peri {
> @@ -42,4 +45,55 @@ struct dma_pl330_platdata {
> ? ? ? ?unsigned mcbuf_sz;
> ?};
>
> +struct dma_pl330_chan {
> + ? ? ? /* Schedule desc completion */
> + ? ? ? struct tasklet_struct task;
> +
> + ? ? ? /* DMA-Engine Channel */
> + ? ? ? struct dma_chan chan;
> +
> + ? ? ? /* Last completed cookie */
> + ? ? ? dma_cookie_t completed;
> +
> + ? ? ? /* List of to be xfered descriptors */
> + ? ? ? struct list_head work_list;
> +
> + ? ? ? /* Pointer to the DMAC that manages this channel,
> + ? ? ? ?* NULL if the channel is available to be acquired.
> + ? ? ? ?* As the parent, this DMAC also provides descriptors
> + ? ? ? ?* to the channel.
> + ? ? ? ?*/
> + ? ? ? struct dma_pl330_dmac *dmac;
> +
> + ? ? ? /* To protect channel manipulation */
> + ? ? ? spinlock_t lock;
> +
> + ? ? ? /* Token of a hardware channel thread of PL330 DMAC
> + ? ? ? ?* NULL if the channel is available to be acquired.
> + ? ? ? ?*/
> + ? ? ? void *pl330_chid;
> +
> + ? ? ? /* taks for cyclic capability */
> + ? ? ? struct tasklet_struct *cyclic_task;
> +
> + ? ? ? bool cyclic;
> +};
> +
> +struct dma_pl330_dmac {
> + ? ? ? struct pl330_info pif;
> +
> + ? ? ? /* DMA-Engine Device */
> + ? ? ? struct dma_device ddma;
> +
> + ? ? ? /* Pool of descriptors available for the DMAC's channels */
> + ? ? ? struct list_head desc_pool;
> + ? ? ? /* To protect desc_pool manipulation */
> + ? ? ? spinlock_t pool_lock;
> +
> + ? ? ? /* Peripheral channels connected to this DMAC */
> + ? ? ? struct dma_pl330_chan peripherals[0]; /* keep at end */
> +
> + ? ? ? struct clk *clk;
> +};
> +
> ?#endif /* __AMBA_PL330_H_ */

struct dma_pl330_dmac and struct dma_pl330_chan are internal to the
pl330 dmac driver. Nobody from outside should ever need them.

Thanks,
Jassi
