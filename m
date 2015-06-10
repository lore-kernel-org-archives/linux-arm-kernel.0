From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Jun 2015 08:35:14 +0100
Subject: [PATCH 2/8] mfd: axp20x: Add a cell for the usb power_supply
 part of the axp20x PMICs
In-Reply-To: <1433885881-19809-3-git-send-email-hdegoede@redhat.com>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
 <1433885881-19809-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20150610073514.GW2982@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 09 Jun 2015, Hans de Goede wrote:

> Add a cell for the usb power_supply part of the axp20x PMICs.
> 
> Note that this cell is only for the usb power_supply part and not the
> ac-power / battery-charger / rtc-backup-bat-charger bits.
> 
> Depending on the board each of those must be enabled / disabled separately
> in devicetree as most boards do not use all 4. So in dt each one needs its
> own child-node of the axp20x node. Another reason for using separate child
> nodes for each is so that other devicetree nodes can have a power-supply
> property with a phandle referencing a node representing a single
> power-supply.
> 
> The decision to use a separate devicetree node for each is reflected on
> the kernel side by each getting its own mfd-cell / platform_device and
> platform-driver.
> 
> Cc: Bruno Pr?mont <bonbons@linux-vserver.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/axp20x.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 6ffbc11..47ce233 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -113,6 +113,30 @@ static struct resource axp20x_pek_resources[] = {
>  	},
>  };
>  
> +static struct resource axp20x_usb_power_supply_resources[] = {
> +	{
> +		.name	= "VBUS_PLUGIN",
> +		.start	= AXP20X_IRQ_VBUS_PLUGIN,
> +		.end	= AXP20X_IRQ_VBUS_PLUGIN,
> +		.flags	= IORESOURCE_IRQ,
> +	}, {
> +		.name	= "VBUS_REMOVAL",
> +		.start	= AXP20X_IRQ_VBUS_REMOVAL,
> +		.end	= AXP20X_IRQ_VBUS_REMOVAL,
> +		.flags	= IORESOURCE_IRQ,
> +	}, {
> +		.name	= "VBUS_VALID",
> +		.start	= AXP20X_IRQ_VBUS_VALID,
> +		.end	= AXP20X_IRQ_VBUS_VALID,
> +		.flags	= IORESOURCE_IRQ,
> +	}, {
> +		.name	= "VBUS_NOT_VALID",
> +		.start	= AXP20X_IRQ_VBUS_NOT_VALID,
> +		.end	= AXP20X_IRQ_VBUS_NOT_VALID,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};

Can you take a look at the DEFINE_RES_* macros in
include/linux/ioport.h please?

>  static struct resource axp22x_pek_resources[] = {
>  	{
>  		.name   = "PEK_DBR",
> @@ -165,7 +189,7 @@ static const struct regmap_config axp20x_regmap_config = {
>  	.val_bits	= 8,
>  	.wr_table	= &axp20x_writeable_table,
>  	.volatile_table	= &axp20x_volatile_table,
> -	.max_register	= AXP20X_FG_RES,
> +	.max_register	= AXP20X_OCV(15),
>  	.cache_type	= REGCACHE_RBTREE,
>  };
>  
> @@ -368,6 +392,12 @@ static struct mfd_cell axp20x_cells[] = {
>  		.resources		= axp20x_pek_resources,
>  	}, {
>  		.name			= "axp20x-regulator",
> +	}, {
> +		.name			= "axp20x-usb-power-supply",
> +		.of_compatible		= "x-powers,axp202-usb-power-supply",
> +		.num_resources		=
> +				ARRAY_SIZE(axp20x_usb_power_supply_resources),

This wrap is only necessary due to the extreme tabbing used to line up
the '='.  Please do something about that instead.

> +		.resources		= axp20x_usb_power_supply_resources,
>  	},
>  };
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
