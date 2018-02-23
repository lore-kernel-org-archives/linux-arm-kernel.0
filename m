From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 23 Feb 2018 16:18:21 +0100
Subject: [PATCH v3 2/7] pinctrl: sunxi: support pin controllers with
 holes among IRQ banks
In-Reply-To: <20180223122552.58049-3-icenowy@aosc.io>
References: <20180223122552.58049-1-icenowy@aosc.io>
 <20180223122552.58049-3-icenowy@aosc.io>
Message-ID: <20180223151821.gqn66roldejpowzu@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 08:25:47PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC have its pin controllers with the first IRQ-capable
> GPIO bank at IRQ bank 1 and the second bank at IRQ bank 5. This
> situation cannot be processed with the current pinctrl IRQ code, as it
> only expects a offset to all IRQ banks.
> 
> Update the code to use a logical IRQ bank to hardware IRQ bank map, so
> the new situation in H6 main pin controller can be processed. The old
> special situation which uses a constant offset (on A33 and V3s, both
> with a offset of 1) can be also processed with the new code.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v3:
> - change for the refactor in the new PATCH 1.
> 
> No changes in v2.
> 
>  drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c |  4 +++-
>  drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c |  4 +++-
>  drivers/pinctrl/sunxi/pinctrl-sunxi.h     | 29 +++++++++++++++++------------
>  3 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
> index da387211a75e..f043afa1aac5 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
> @@ -481,11 +481,13 @@ static const struct sunxi_desc_pin sun8i_a33_pins[] = {
>  		  SUNXI_FUNCTION(0x3, "uart3")),	/* CTS */
>  };
>  
> +static const unsigned int sun8i_a33_pinctrl_irq_bank_map[] = { 1, 2 };
> +
>  static const struct sunxi_pinctrl_desc sun8i_a33_pinctrl_data = {
>  	.pins = sun8i_a33_pins,
>  	.npins = ARRAY_SIZE(sun8i_a33_pins),
>  	.irq_banks = 2,
> -	.irq_bank_base = 1,
> +	.irq_bank_map = sun8i_a33_pinctrl_irq_bank_map,
>  	.disable_strict_mode = true,
>  };
>  
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c
> index 496ba34e1f5f..6704ce8e5e3d 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c
> @@ -293,11 +293,13 @@ static const struct sunxi_desc_pin sun8i_v3s_pins[] = {
>  		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),	/* PG_EINT5 */
>  };
>  
> +static const unsigned int sun8i_v3s_pinctrl_irq_bank_map[] = { 1, 2 };
> +
>  static const struct sunxi_pinctrl_desc sun8i_v3s_pinctrl_data = {
>  	.pins = sun8i_v3s_pins,
>  	.npins = ARRAY_SIZE(sun8i_v3s_pins),
>  	.irq_banks = 2,
> -	.irq_bank_base = 1,
> +	.irq_bank_map = sun8i_v3s_pinctrl_irq_bank_map,
>  	.irq_read_needs_mux = true
>  };
>  
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> index 909ca1504b61..36502cbef6c2 100644
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
> @@ -263,14 +263,23 @@ static inline u32 sunxi_pull_offset(u16 pin)
>  	return pin_num * PULL_PINS_BITS;
>  }
>  
> +static inline u32 sunxi_irq_hw_bank_num(u8 bank,
> +					const struct sunxi_pinctrl_desc *desc)
> +{
> +	if (!desc->irq_bank_map)
> +		return bank;
> +	else
> +		return desc->irq_bank_map[bank];
> +}
> +

Same remark about the order of the argument, and I would have split
this patch in two, one to introduce the new function (but still using
the irq_bank_base), and then a second patch to introduce the
irq_bank_map.

Looks good otherwise, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180223/a4870086/attachment.sig>
