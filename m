From: jassisinghbrar@gmail.com (jassi brar)
Date: Sat, 12 Sep 2009 00:48:07 +0900
Subject: [PATCH] S3C64XX DMA Debugged
In-Reply-To: <1252658258-1855-1-git-send-email-jassi.brar@samsung.com>
References: <1252658258-1855-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <1b68c6790909110848t630a8baah651776735bf47077@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I realized the chan->curr,next,end manipulation in s3c2410_dma_enqueue
needs to be protected.
Apart from that please give me feedback.

Thanks.

On Fri, Sep 11, 2009 at 5:37 PM,  <jassi.brar@samsung.com> wrote:
> From: Jassi <jassi.brar@samsung.com>
>
> Debugged broken state-machine of the S3C64XX DMA driver.
> Changed GFP_KERNEL to GFP_ATOMIC in mem allocations in
> dma_enqueue which is typically called from I2S dma-done
> callback in interrupt context.
> Also, for now, disabled the dysfunctional CIRCULAR flag for enqueued
> buffers.
> Implemented AUTOSTART flag to make 64xx more similar to 24xx dma API.
>
> Signed-Off-by: Jassi <jassi.brar@samsung.com>
> ---
> ?arch/arm/mach-s3c6400/include/mach/dma.h ? ? ?| ? ?1 +
> ?arch/arm/plat-s3c64xx/dma.c ? ? ? ? ? ? ? ? ? | ? 96 +++++++++++++++----------
> ?arch/arm/plat-s3c64xx/include/plat/dma-plat.h | ? ?2 +-
> ?3 files changed, 60 insertions(+), 39 deletions(-)
>
> diff --git a/arch/arm/mach-s3c6400/include/mach/dma.h b/arch/arm/mach-s3c6400/include/mach/dma.h
> index 1067619..b96e663 100644
> --- a/arch/arm/mach-s3c6400/include/mach/dma.h
> +++ b/arch/arm/mach-s3c6400/include/mach/dma.h
> @@ -67,6 +67,7 @@ static __inline__ int s3c_dma_has_circular(void)
> ?}
>
> ?#define S3C2410_DMAF_CIRCULAR ? ? ? ? ?(1 << 0)
> +#define S3C2410_DMAF_AUTOSTART ? ? ? ? (1 << 1)
>
> ?#include <plat/dma.h>
>
> diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
> index 67aa93d..65524b3 100644
> --- a/arch/arm/plat-s3c64xx/dma.c
> +++ b/arch/arm/plat-s3c64xx/dma.c
> @@ -71,20 +71,14 @@ static void show_lli(struct pl080s_lli *lli)
> ?static void dbg_showbuffs(struct s3c2410_dma_chan *chan)
> ?{
> ? ? ? ?struct s3c64xx_dma_buff *ptr;
> - ? ? ? struct s3c64xx_dma_buff *end;
>
> ? ? ? ?pr_debug("DMA%d: buffs next %p, curr %p, end %p\n",
> ? ? ? ? ? ? ? ? chan->number, chan->next, chan->curr, chan->end);
>
> - ? ? ? ptr = chan->next;
> - ? ? ? end = chan->end;
> -
> - ? ? ? if (debug_show_buffs) {
> - ? ? ? ? ? ? ? for (; ptr != NULL; ptr = ptr->next) {
> - ? ? ? ? ? ? ? ? ? ? ? pr_debug("DMA%d: %08x ",
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?chan->number, ptr->lli_dma);
> - ? ? ? ? ? ? ? ? ? ? ? show_lli(ptr->lli);
> - ? ? ? ? ? ? ? }
> + ? ? ? for (ptr = chan->curr; debug_show_buffs && ptr != NULL; ptr = ptr->next) {
> + ? ? ? ? ? ? ? pr_debug("DMA%d: %08x \n",
> + ? ? ? ? ? ? ? ? ? ? ? ?chan->number, ptr->lli_dma);
> + ? ? ? ? ? ? ? show_lli(ptr->lli);
> ? ? ? ?}
> ?}
>
> @@ -308,6 +302,7 @@ int s3c2410_dma_ctrl(unsigned int channel, enum s3c2410_chan_op op)
>
> ? ? ? ?switch (op) {
> ? ? ? ?case S3C2410_DMAOP_START:
> + ? ? ? ? ? ? ? s3c64xx_lli_to_regs(chan, chan->curr->lli);
> ? ? ? ? ? ? ? ?return s3c64xx_dma_start(chan);
>
> ? ? ? ?case S3C2410_DMAOP_STOP:
> @@ -345,13 +340,13 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
> ? ? ? ?if (!chan)
> ? ? ? ? ? ? ? ?return -EINVAL;
>
> - ? ? ? buff = kzalloc(sizeof(struct s3c64xx_dma_buff), GFP_KERNEL);
> + ? ? ? buff = kzalloc(sizeof(struct s3c64xx_dma_buff), GFP_ATOMIC);
> ? ? ? ?if (!buff) {
> ? ? ? ? ? ? ? ?printk(KERN_ERR "%s: no memory for buffer\n", __func__);
> ? ? ? ? ? ? ? ?return -ENOMEM;
> ? ? ? ?}
>
> - ? ? ? lli = dma_pool_alloc(dma_pool, GFP_KERNEL, &buff->lli_dma);
> + ? ? ? lli = dma_pool_alloc(dma_pool, GFP_ATOMIC, &buff->lli_dma);
> ? ? ? ?if (!lli) {
> ? ? ? ? ? ? ? ?printk(KERN_ERR "%s: no memory for lli\n", __func__);
> ? ? ? ? ? ? ? ?ret = -ENOMEM;
> @@ -366,7 +361,9 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
>
> ? ? ? ?s3c64xx_dma_fill_lli(chan, lli, data, size);
>
> - ? ? ? if ((next = chan->next) != NULL) {
> + ? ? ? next = chan->next;
> +
> + ? ? ? if (chan->curr) {
> ? ? ? ? ? ? ? ?struct s3c64xx_dma_buff *end = chan->end;
> ? ? ? ? ? ? ? ?struct pl080s_lli *endlli = end->lli;
>
> @@ -375,6 +372,7 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
> ? ? ? ? ? ? ? ?end->next = buff;
> ? ? ? ? ? ? ? ?endlli->next_lli = buff->lli_dma;
>
> +#if 0
> ? ? ? ? ? ? ? ?if (chan->flags & S3C2410_DMAF_CIRCULAR) {
> ? ? ? ? ? ? ? ? ? ? ? ?struct s3c64xx_dma_buff *curr = chan->curr;
> ? ? ? ? ? ? ? ? ? ? ? ?lli->next_lli = curr->lli_dma;
> @@ -384,7 +382,7 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
> ? ? ? ? ? ? ? ? ? ? ? ?writel(buff->lli_dma, chan->regs + PL080_CH_LLI);
> ? ? ? ? ? ? ? ? ? ? ? ?chan->next = buff;
> ? ? ? ? ? ? ? ?}
> -
> +#endif
> ? ? ? ? ? ? ? ?show_lli(endlli);
> ? ? ? ? ? ? ? ?chan->end = buff;
> ? ? ? ?} else {
> @@ -394,7 +392,8 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
> ? ? ? ? ? ? ? ?chan->next = buff;
> ? ? ? ? ? ? ? ?chan->end = buff;
>
> - ? ? ? ? ? ? ? s3c64xx_lli_to_regs(chan, lli);
> + ? ? ? ? ? ? ? if (chan->flags & S3C2410_DMAF_AUTOSTART)
> + ? ? ? ? ? ? ? ? ? ? ? return s3c2410_dma_ctrl(channel, S3C2410_DMAOP_START);
> ? ? ? ?}
>
> ? ? ? ?show_lli(lli);
> @@ -474,6 +473,11 @@ int s3c2410_dma_getposition(unsigned int channel,
> ? ? ? ?if (dst != NULL)
> ? ? ? ? ? ? ? ?*dst = readl(chan->regs + PL080_CH_DST_ADDR);
>
> + ? ? ? if (chan->source == S3C2410_DMASRC_MEM)
> + ? ? ? ? ? ? ? *src += (1 << chan->hw_width);
> + ? ? ? else
> + ? ? ? ? ? ? ? *dst += (1 << chan->hw_width);
> +
> ? ? ? ?return 0;
> ?}
> ?EXPORT_SYMBOL(s3c2410_dma_getposition);
> @@ -560,27 +564,13 @@ int s3c2410_dma_free(unsigned int channel, struct s3c2410_dma_client *client)
>
> ?EXPORT_SYMBOL(s3c2410_dma_free);
>
> -
> -static void s3c64xx_dma_tcirq(struct s3c64xx_dmac *dmac, int offs)
> -{
> - ? ? ? struct s3c2410_dma_chan *chan = dmac->channels + offs;
> -
> - ? ? ? /* note, we currently do not bother to work out which buffer
> - ? ? ? ?* or buffers have been completed since the last tc-irq. */
> -
> - ? ? ? if (chan->callback_fn)
> - ? ? ? ? ? ? ? (chan->callback_fn)(chan, chan->curr->pw, 0, S3C2410_RES_OK);
> -}
> -
> -static void s3c64xx_dma_errirq(struct s3c64xx_dmac *dmac, int offs)
> -{
> - ? ? ? printk(KERN_DEBUG "%s: offs %d\n", __func__, offs);
> -}
> -
> ?static irqreturn_t s3c64xx_dma_irq(int irq, void *pw)
> ?{
> + ? ? ? struct s3c64xx_dma_buff *buff;
> ? ? ? ?struct s3c64xx_dmac *dmac = pw;
> - ? ? ? u32 tcstat, errstat;
> + ? ? ? struct s3c2410_dma_chan *chan;
> + ? ? ? enum s3c2410_dma_buffresult res;
> + ? ? ? u32 tcstat, errstat, val;
> ? ? ? ?u32 bit;
> ? ? ? ?int offs;
>
> @@ -588,15 +578,44 @@ static irqreturn_t s3c64xx_dma_irq(int irq, void *pw)
> ? ? ? ?errstat = readl(dmac->regs + PL080_ERR_STATUS);
>
> ? ? ? ?for (offs = 0, bit = 1; offs < 8; offs++, bit <<= 1) {
> +
> + ? ? ? ? ? ? ? if (!(errstat & bit) && !(tcstat & bit))
> + ? ? ? ? ? ? ? ? ? ? ? continue;
> +
> + ? ? ? ? ? ? ? res = S3C2410_RES_ERR;
> +
> + ? ? ? ? ? ? ? if (errstat & bit)
> + ? ? ? ? ? ? ? ? ? ? ? writel(bit, dmac->regs + PL080_ERR_CLEAR);
> +
> ? ? ? ? ? ? ? ?if (tcstat & bit) {
> ? ? ? ? ? ? ? ? ? ? ? ?writel(bit, dmac->regs + PL080_TC_CLEAR);
> - ? ? ? ? ? ? ? ? ? ? ? s3c64xx_dma_tcirq(dmac, offs);
> + ? ? ? ? ? ? ? ? ? ? ? res = S3C2410_RES_OK;
> ? ? ? ? ? ? ? ?}
>
> - ? ? ? ? ? ? ? if (errstat & bit) {
> - ? ? ? ? ? ? ? ? ? ? ? s3c64xx_dma_errirq(dmac, offs);
> - ? ? ? ? ? ? ? ? ? ? ? writel(bit, dmac->regs + PL080_ERR_CLEAR);
> + ? ? ? ? ? ? ? chan = dmac->channels + offs;
> + ? ? ? ? ? ? ? if(chan->curr == NULL)
> + ? ? ? ? ? ? ? ? ? ? ? continue;
> +
> + ? ? ? ? ? ? ? buff = chan->curr;
> + ? ? ? ? ? ? ? if (chan->curr != chan->end) {
> + ? ? ? ? ? ? ? ? ? ? ? /* Only chan->end must point at buff with next==NULL*/
> + ? ? ? ? ? ? ? ? ? ? ? BUG_ON(chan->curr->next == NULL);
> + ? ? ? ? ? ? ? ? ? ? ? chan->curr = chan->curr->next;
> +
> + ? ? ? ? ? ? ? ? ? ? ? val = readl(chan->regs + PL080S_CH_CONFIG);
> + ? ? ? ? ? ? ? ? ? ? ? if (!(val & PL080_CONFIG_ACTIVE)) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? s3c64xx_lli_to_regs(chan, chan->curr->lli);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? val |= PL080_CONFIG_ENABLE;
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? writel(val, chan->regs + PL080S_CH_CONFIG);
> + ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? } else {
> + ? ? ? ? ? ? ? ? ? ? ? chan->curr = NULL;
> + ? ? ? ? ? ? ? ? ? ? ? chan->next = NULL;
> + ? ? ? ? ? ? ? ? ? ? ? chan->end = NULL;
> ? ? ? ? ? ? ? ?}
> +
> + ? ? ? ? ? ? ? s3c64xx_dma_bufffdone(chan, buff, res);
> + ? ? ? ? ? ? ? s3c64xx_dma_freebuff(buff);
> ? ? ? ?}
>
> ? ? ? ?return IRQ_HANDLED;
> @@ -669,6 +688,7 @@ static int s3c64xx_dma_init1(int chno, enum dma_ch chbase,
> ? ? ? ? ? ? ? ?chptr->number = chno;
> ? ? ? ? ? ? ? ?chptr->dmac = dmac;
> ? ? ? ? ? ? ? ?chptr->regs = regptr;
> + ? ? ? ? ? ? ? chptr->curr = chptr->next = chptr->end = NULL;
> ? ? ? ? ? ? ? ?regptr += PL008_Cx_STRIDE;
> ? ? ? ?}
>
> @@ -697,7 +717,7 @@ static int __init s3c64xx_dma_init(void)
>
> ? ? ? ?printk(KERN_INFO "%s: Registering DMA channels\n", __func__);
>
> - ? ? ? dma_pool = dma_pool_create("DMA-LLI", NULL, 32, 16, 0);
> + ? ? ? dma_pool = dma_pool_create("DMA-LLI", NULL, sizeof(struct pl080s_lli), 16, 0);
> ? ? ? ?if (!dma_pool) {
> ? ? ? ? ? ? ? ?printk(KERN_ERR "%s: failed to create pool\n", __func__);
> ? ? ? ? ? ? ? ?return -ENOMEM;
> diff --git a/arch/arm/plat-s3c64xx/include/plat/dma-plat.h b/arch/arm/plat-s3c64xx/include/plat/dma-plat.h
> index 0c30dd9..8f76a1e 100644
> --- a/arch/arm/plat-s3c64xx/include/plat/dma-plat.h
> +++ b/arch/arm/plat-s3c64xx/include/plat/dma-plat.h
> @@ -26,7 +26,7 @@ struct s3c64xx_dma_buff {
> ? ? ? ?struct s3c64xx_dma_buff *next;
>
> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?*pw;
> - ? ? ? struct pl080_lli ? ? ? ?*lli;
> + ? ? ? struct pl080s_lli ? ? ? *lli;
> ? ? ? ?dma_addr_t ? ? ? ? ? ? ? lli_dma;
> ?};
>
> --
> 1.6.2.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
