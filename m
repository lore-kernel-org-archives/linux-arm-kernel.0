From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 14 Nov 2013 16:51:45 +0100
Subject: [patch] pinctrl: rockchip: missing unlock on error in
 rockchip_set_pull()
In-Reply-To: <20131114082254.GE8150@elgon.mountain>
References: <20131114082254.GE8150@elgon.mountain>
Message-ID: <201311141651.45966.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 14. November 2013, 09:22:54 schrieb Dan Carpenter:
> We need to unlock here before returning -EINVAL.

I seem to say this a lot recently: thanks for the catch :-)


> Fixes: 6ca5274d1d12 ('pinctrl: rockchip: add rk3188 specifics')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>


> diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> b/drivers/pinctrl/pinctrl-rockchip.c index e939c28..bfd1824 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -504,6 +504,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank
> *bank, data |= (3 << bit);
>  			break;
>  		default:
> +			spin_unlock_irqrestore(&bank->slock, flags);
>  			dev_err(info->dev, "unsupported pull setting %d\n",
>  				pull);
>  			return -EINVAL;
