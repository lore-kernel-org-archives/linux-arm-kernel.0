From: julia@ni.com (Julia Cartwright)
Date: Thu, 23 Mar 2017 11:10:20 -0500
Subject: [PATCH v4 1/4] pinctrl: rockchip: remove unnecessary locking
In-Reply-To: <20170323105931.10455-2-john@metanate.com>
References: <20170323105931.10455-1-john@metanate.com>
 <20170323105931.10455-2-john@metanate.com>
Message-ID: <20170323161020.GM10423@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello John-

One quick question below.  Apologies if this has been covered, but just
want to be sure.

On Thu, Mar 23, 2017 at 10:59:28AM +0000, John Keeping wrote:
> regmap_update_bits does its own locking and everything else accessed
> here is a local variable so there is no need to lock around it.
> 
> Signed-off-by: John Keeping <john@metanate.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> v3: unchanged
> v2.1:
> - Remove RK2928 locking in rockchip_set_pull()
> v2:
> - Also remove locking in rockchip_set_schmitt()
> ---
>  drivers/pinctrl/pinctrl-rockchip.c | 33 ++-------------------------------
>  1 file changed, 2 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> index bd4b63f66220..6568c867bdcd 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
[..]
> @@ -1185,17 +1177,14 @@ static int rockchip_set_drive_perpin(struct rockchip_pin_bank *bank,
>  			rmask = BIT(15) | BIT(31);
>  			data |= BIT(31);
>  			ret = regmap_update_bits(regmap, reg, rmask, data);
> -			if (ret) {
> -				spin_unlock_irqrestore(&bank->slock, flags);
> +			if (ret)
>  				return ret;
> -			}
>  
>  			rmask = 0x3 | (0x3 << 16);
>  			temp |= (0x3 << 16);
>  			reg += 0x4;
>  			ret = regmap_update_bits(regmap, reg, rmask, temp);

Killing the lock here means the writes to to this pair of registers (reg
and reg + 4) can be observed non-atomically.  Have you convinced
yourself that this isn't a problem?

   Julia
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170323/fa72076b/attachment-0001.sig>
