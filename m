From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 01:23:21 +0100
Subject: [PATCH 5/7] S3C64XX DMA: TC-IRQ implemented.
In-Reply-To: <1253008883-7624-1-git-send-email-jassi.brar@samsung.com>
References: <1253008883-7624-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090916002321.GM13508@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:01:23PM +0900, Jassi wrote:
> The available irq handler simply doesn't work. The Dma state-machine
> is broken. This patch fixes it.

A better explanation would have been nice, so I could actually evaluate
what is going on here.

> Also, chan->curr,next,end pointer manipulation is protected.

Should have been a seperate patch, I would have been able to apply that
reasonably easily.
 
> Signed-Off-by: Jassi <jassi.brar@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/dma.c |   61 +++++++++++++++++++++++++++---------------
>  1 files changed, 39 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
> index 02bc82b..e68469d 100644
> --- a/arch/arm/plat-s3c64xx/dma.c
> +++ b/arch/arm/plat-s3c64xx/dma.c
> @@ -339,6 +339,7 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
>  	struct s3c64xx_dma_buff *next;
>  	struct s3c64xx_dma_buff *buff;
>  	struct pl080s_lli *lli;
> +	unsigned long flags;
>  	int ret;
>  
>  	WARN_ON(!chan);
> @@ -366,6 +367,8 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
>  
>  	s3c64xx_dma_fill_lli(chan, lli, data, size);
>  
> +	local_irq_save(flags);
> +
>  	if ((next = chan->next) != NULL) {
>  		struct s3c64xx_dma_buff *end = chan->end;
>  		struct pl080s_lli *endlli = end->lli;
> @@ -399,6 +402,8 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
>  		s3c64xx_lli_to_regs(chan, lli);
>  	}
>  
> +	local_irq_restore(flags);
> +
>  	show_lli(lli);
>  
>  	dbg_showchan(chan);
> @@ -562,27 +567,13 @@ int s3c2410_dma_free(unsigned int channel, struct s3c2410_dma_client *client)
>  
>  EXPORT_SYMBOL(s3c2410_dma_free);
>  
> -
> -static void s3c64xx_dma_tcirq(struct s3c64xx_dmac *dmac, int offs)
> -{
> -	struct s3c2410_dma_chan *chan = dmac->channels + offs;
> -
> -	/* note, we currently do not bother to work out which buffer
> -	 * or buffers have been completed since the last tc-irq. */
> -
> -	if (chan->callback_fn)
> -		(chan->callback_fn)(chan, chan->curr->pw, 0, S3C2410_RES_OK);
> -}

I belive a callback is necessary for the audio code to update the
current dma position of the stream. I also thought this worked?

> -static void s3c64xx_dma_errirq(struct s3c64xx_dmac *dmac, int offs)
> -{
> -	printk(KERN_DEBUG "%s: offs %d\n", __func__, offs);
> -}
> -
>  static irqreturn_t s3c64xx_dma_irq(int irq, void *pw)
>  {
> +	struct s3c64xx_dma_buff *buff;
>  	struct s3c64xx_dmac *dmac = pw;
> -	u32 tcstat, errstat;
> +	struct s3c2410_dma_chan *chan;
> +	enum s3c2410_dma_buffresult res;
> +	u32 tcstat, errstat, val;
>  	u32 bit;
>  	int offs;
>  
> @@ -590,15 +581,41 @@ static irqreturn_t s3c64xx_dma_irq(int irq, void *pw)
>  	errstat = readl(dmac->regs + PL080_ERR_STATUS);
>  
>  	for (offs = 0, bit = 1; offs < 8; offs++, bit <<= 1) {
> +
> +		if (!(errstat & bit) && !(tcstat & bit))
> +			continue;
> +
> +		res = S3C2410_RES_ERR;
> +
> +		if (errstat & bit)
> +			writel(bit, dmac->regs + PL080_ERR_CLEAR);
> +
>  		if (tcstat & bit) {
>  			writel(bit, dmac->regs + PL080_TC_CLEAR);
> -			s3c64xx_dma_tcirq(dmac, offs);
> +			res = S3C2410_RES_OK;
>  		}
>  
> -		if (errstat & bit) {
> -			s3c64xx_dma_errirq(dmac, offs);
> -			writel(bit, dmac->regs + PL080_ERR_CLEAR);
> +		chan = dmac->channels + offs;
> +		if(chan->curr == NULL)
> +			continue;
> +
> +		buff = chan->curr;
> +		if (chan->curr != chan->end) {
> +			BUG_ON(chan->curr->next == NULL);
> +			chan->curr = chan->curr->next;
> +
> +			val = readl(chan->regs + PL080S_CH_CONFIG);
> +			if (!(val & PL080_CONFIG_ACTIVE)) {
> +				s3c64xx_lli_to_regs(chan, chan->curr->lli);
> +				val |= PL080_CONFIG_ENABLE;
> +				writel(val, chan->regs + PL080S_CH_CONFIG);
> +			}
> +		} else {
> +			chan->curr = chan->next = chan->end = NULL;
>  		}
> +
> +		s3c64xx_dma_bufffdone(chan, buff, res);
> +		s3c64xx_dma_freebuff(buff);
>  	}

Hmm, this looks like a train wreck. Please do not move code around
like this.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
