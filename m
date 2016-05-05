From: eric@anholt.net (Eric Anholt)
Date: Thu, 05 May 2016 12:17:51 -0700
Subject: [PATCH V5] clk: bcm2835: mark enabled clocks and pll with
 CLK_ENABLE_HAND_OFF
In-Reply-To: <1462348385-16167-1-git-send-email-kernel@martin.sperl.org>
References: <1462348385-16167-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <87oa8ks49s.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> The bcm2835 firmware enables several clocks and plls before
> booting the linux kernel.
>
> These plls should never get disabled as it may result in a
> stopped system clock and more.
>
> So during probing we check if the clock and plls are enabled
> and if it is then mark that clock/pll with CLK_ENABLE_HAND_OFF.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  drivers/clk/bcm/clk-bcm2835.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> Note: This requires the CLK_ENABLE_HAND_OFF patch to be applied.
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 0fc71cb..0663b6c 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -1211,6 +1211,15 @@ bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
>  	divider->cprman = cprman;
>  	divider->data = data;
>  
> +	/* if the pll-divider is running, then enable CLK_ENABLE_HAND_OFF */
> +	if ((cprman_read(cprman, data->a2w_reg) &
> +	     A2W_PLL_CHANNEL_DISABLE) == 0) {
> +		dev_dbg(cprman->dev,
> +			"found firmware enabled pll_div %s - enabling hand off\n",
> +			data->name);
> +		init.flags |= CLK_ENABLE_HAND_OFF;
> +	}

I don't think we want this on dividers.  There are very few cases where
a divider will be grabbed and prepare/enabled on its own, rather than as
a side effect of a downstream clock being needed.  So, I think the
dividers need to stay as being enabled/disabled automatically by the
downstream clocks, like in the v3 patch you had sent.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160505/063e7354/attachment.sig>
