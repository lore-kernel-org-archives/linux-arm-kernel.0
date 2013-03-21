From: vkoul@infradead.org (Vinod Koul)
Date: Thu, 21 Mar 2013 13:34:15 +0530
Subject: [PATCH 2/3] DMA: AT91: Get residual bytes in dma buffer
In-Reply-To: <1354871509-14690-1-git-send-email-elen.song@atmel.com>
References: <1354871509-14690-1-git-send-email-elen.song@atmel.com>
Message-ID: <1363853055.2348.11.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-12-07 at 17:11 +0800, Elen Song wrote:
> + * atc_get_bytes_left -
> + * Get the number of bytes residue in dma buffer,
> + * the channel should be paused when calling this
> + * @chan: the channel we want to start
> + */
> +static int atc_get_bytes_left(struct dma_chan *chan)
> +{
> +       struct at_dma_chan      *atchan = to_at_dma_chan(chan);
> +       struct at_desc *desc_first = atc_first_active(atchan);
> +       struct at_desc *desc_cur;
> +       int ret = 0, count = 0;
> +
> +       /*
> +        * Initialize necessary values in the first time.
> +        * remain_desc record remain desc length.
> +        */
> +       if (atchan->remain_desc == 0)
> +               /* First descriptor embedds the transaction length */
> +               atchan->remain_desc = desc_first->len;
> +
> +       /* Channel should be paused before get residue */
> +       if (!atc_chan_is_paused(atchan))
> +               atc_control(chan, DMA_PAUSE, 0); 
This one doesnt seem good, why should you pause if you want to read
residue.
Why cant you read the value while it running.

Also if the query is done for a paused channel then you would resume it,
which is wrong

-- 
Vinod Koul
Intel Corp.
