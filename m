From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 7 Feb 2018 09:51:46 +0100
Subject: [PATCH v2 1/6] pinctrl: sunxi: support pin controllers with
 holes among IRQ banks
In-Reply-To: <20180203154942.63566-2-icenowy@aosc.io>
References: <20180203154942.63566-1-icenowy@aosc.io>
 <20180203154942.63566-2-icenowy@aosc.io>
Message-ID: <20180207085146.dvgwkdjq7ybhohwh@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 03, 2018 at 11:49:37PM +0800, Icenowy Zheng wrote:
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> index 11b128f54ed2..fae732c8c548 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> @@ -110,7 +110,7 @@ struct sunxi_pinctrl_desc {
>  	int				npins;
>  	unsigned			pin_base;
>  	unsigned			irq_banks;
> -	unsigned			irq_bank_base;
> +	const unsigned int		*irq_bank_map;
>  	bool				irq_read_needs_mux;
>  	bool				disable_strict_mode;
>  };
> @@ -263,12 +263,21 @@ static inline u32 sunxi_pull_offset(u16 pin)
>  	return pin_num * PULL_PINS_BITS;
>  }
>  
> -static inline u32 sunxi_irq_cfg_reg(u16 irq, unsigned bank_base)
> +static inline u32 sunxi_irq_hw_bank_num(u8 bank, const unsigned int *bank_map)
> +{
> +	if (!bank_map)
> +		return bank;
> +	else
> +		return bank_map[bank];
> +}

>From a function API PoV, I guess it would make more sense and be
cleaner to simply pass the sunxi_pinctrl_desc structure (as the first
argument) and have the function there read that structure and act upon
it.

Giving it just a blank pointer, without any size indication, and
either dereferencing it without any boundary check, or changing the
behaviour based on whether it's null or not seems pretty fragile.

I guess you could do it in two patches. One to change the function
prototypes to call the sunxi_irq_cfg_reg function (and all its caller)
to have the prototype (struct sunxi_pinctrl_desc *desc, u16 irq).

And then in a later patch change the behaviour to introduce the map.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180207/56686890/attachment.sig>
