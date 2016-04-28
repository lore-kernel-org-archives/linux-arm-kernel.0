From: eric@anholt.net (Eric Anholt)
Date: Thu, 28 Apr 2016 13:22:22 -0700
Subject: [PATCH V3] clk: bcm2835: mark enabled clocks with
 CLK_ENABLE_HAND_OFF
In-Reply-To: <1461770664-29384-1-git-send-email-kernel@martin.sperl.org>
References: <1461770664-29384-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <87d1p9v5z5.fsf@eliezer.anholt.net>
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
> So during probing we check if the clock is enabled
> and if it is then mark that clock with CLK_ENABLE_HAND_OFF.
> As a consequence this will also enable the corresponding
> parent plls and pll-divs.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>
> --

> ---
>  drivers/clk/bcm/clk-bcm2835.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 35f8de7..65d62c2 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -1251,7 +1251,14 @@ static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
>  		init.flags |= CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
>  	}
>
> +	/* if the clock is running then enable HAND_OFF */
> +	if (cprman_read(cprman, data->ctl_reg) & CM_ENABLE) {
> +		dev_info(cprman->dev,
> +			 "found enabled clock %s - enabling hand off\n",
> +			 data->name);
> +		init.flags |= CLK_ENABLE_HAND_OFF;
> +	}
> +

The debug shouldn't be at dev_info() level, but other than that this
seems like a good plan once CLK_ENABLE_HAND_OFF lands.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160428/1def9988/attachment-0001.sig>
