From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 30 Jan 2016 14:48:15 +0100
Subject: [PATCH v4 1/2] pinctrl: rockchip: add support for the rk3399
In-Reply-To: <1454156413-56148-2-git-send-email-david.wu@rock-chips.com>
References: <1454156413-56148-1-git-send-email-david.wu@rock-chips.com>
 <1454156413-56148-2-git-send-email-david.wu@rock-chips.com>
Message-ID: <2864405.Bm4XacGINh@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Am Samstag, 30. Januar 2016, 20:20:12 schrieb David Wu:
> The pinctrl of rk3399 is much different from other's,
> especially the 3bits of drive strength.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
> Change in v4: None

you're to fast for me ;-)

[...]

> @@ -729,8 +924,67 @@ static int rockchip_set_drive_perpin(struct
> rockchip_pin_bank *bank,
> 
>  	spin_lock_irqsave(&bank->slock, flags);
> 
> +	switch (drv_type) {
> +	case DRV_TYPE_IO_1V8_3V0_AUTO:
> +	case DRV_TYPE_IO_3V3_ONLY:
> +		rmask_bits = RK3399_DRV_3BITS_PER_PIN;
> +		switch (bit) {
> +		case 0 ... 12:
> +			/* regular case, nothing to do */
> +			break;
> +		case 15:
> +			/*
> +			 * the bit data[15] contains bit 0 of the value
> +			 * while temp[1:0] contains bits 2 and 1
> +			 */

I'd think the introductory comment should mode here, so like:
			/*
			 * drive-strength offset is special, as it is
			 * spread over 2 registers, the bit data[15] contains bit 0
			 * of the value while temp[1:0] contains bits 2 and 1
			 */


> +			data = (ret & 0x1) << 15;
> +			temp = (ret >> 0x1) & 0x3;
> +
> +			rmask = BIT(15) | BIT(31);
> +			data |= BIT(31);
> +			ret = regmap_update_bits(regmap, reg, rmask, data);
> +			if (ret) {
> +				spin_unlock_irqrestore(&bank->slock, flags);
> +				return ret;
> +			}
> +
> +			/*
> +			 * drive-strength offset is special, as it is
> +			 * spread over 2 registers
> +			 */

as I wrote, this should probably move a bit higher


> +			rmask = 0x3 | (0x3 << 16);
> +			temp |= (0x3 << 16);
> +			reg += 0x4;
> +			ret = regmap_update_bits(regmap, reg, rmask, temp);
> +
> +			spin_unlock_irqrestore(&bank->slock, flags);
> +			return ret;
> +		case 18 ... 21:
> +			/* setting fully enclosed in the second register */
> +			reg += 4;
> +			bit -= 16;
> +			break;
> +		default:
> +			spin_unlock_irqrestore(&bank->slock, flags);
> +			dev_err(info->dev, "unsupported bit: %d for pinctrl drive type: 
%d\n",
> +				bit, drv_type);
> +			return -EINVAL;
> +		}
> +		break;
> +	case DRV_TYPE_IO_DEFAULT:
> +	case DRV_TYPE_IO_1V8_OR_3V0:
> +	case DRV_TYPE_IO_1V8_ONLY:
> +		rmask_bits = RK3288_DRV_BITS_PER_PIN;
> +		break;
> +	default:
> +		spin_unlock_irqrestore(&bank->slock, flags);
> +		dev_err(info->dev, "unsupported pinctrl drive type: %d\n",
> +			drv_type);
> +		return -EINVAL;
> +	}
> +
>  	/* enable the write to the equivalent lower bits */
> -	data = ((1 << RK3288_DRV_BITS_PER_PIN) - 1) << (bit + 16);
> +	data = ((1 << rmask_bits) - 1) << (bit + 16);
>  	rmask = data | (data >> 16);
>  	data |= (ret << bit);
> 

Otherwise this looks nice to me, so with the comment fixed
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Thanks
Heiko
