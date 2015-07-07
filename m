From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 7 Jul 2015 08:01:28 +0100
Subject: [PATCH v3 3/4] mfd: axp20x: Add a cell for the usb power_supply
 part of the axp20x PMICs
In-Reply-To: <1435316357-26606-3-git-send-email-hdegoede@redhat.com>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
 <1435316357-26606-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20150707070128.GI3182@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Jun 2015, Hans de Goede wrote:

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
> Note this commit also makes some whitespace changes to the intialization
> of existing cells in axp20x_cells, these are pure whitespace changes,
> functionally nothing changes.
> 
> Cc: Bruno Pr?mont <bonbons@linux-vserver.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Bruno Pr?mont <bonbons@linux-vserver.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Use DEFINE_RES_IRQ_NAMED
> -Change indentation of axp20x_cells initializers to avoid line wrapping
> Changes in v3:
> -Improve commit message
> -Add Bruno's S-o-b
> ---
>  drivers/mfd/axp20x.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)

For my own reference:
  Acked-by: Lee Jones <lee.jones@linaro.org>

Are these two patches tied to any other in the set, or can I apply
them separately?

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index f9a3c2d..ca4a604 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -113,6 +113,13 @@ static struct resource axp20x_pek_resources[] = {
>  	},
>  };
>  
> +static struct resource axp20x_usb_power_supply_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_VALID, "VBUS_VALID"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID"),
> +};
> +
>  static struct resource axp22x_pek_resources[] = {
>  	{
>  		.name   = "PEK_DBR",
> @@ -363,11 +370,16 @@ static const struct regmap_irq_chip axp288_regmap_irq_chip = {
>  
>  static struct mfd_cell axp20x_cells[] = {
>  	{
> -		.name			= "axp20x-pek",
> -		.num_resources		= ARRAY_SIZE(axp20x_pek_resources),
> -		.resources		= axp20x_pek_resources,
> +		.name		= "axp20x-pek",
> +		.num_resources	= ARRAY_SIZE(axp20x_pek_resources),
> +		.resources	= axp20x_pek_resources,
>  	}, {
> -		.name			= "axp20x-regulator",
> +		.name		= "axp20x-regulator",
> +	}, {
> +		.name		= "axp20x-usb-power-supply",
> +		.of_compatible	= "x-powers,axp202-usb-power-supply",
> +		.num_resources	= ARRAY_SIZE(axp20x_usb_power_supply_resources),
> +		.resources	= axp20x_usb_power_supply_resources,
>  	},
>  };
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
