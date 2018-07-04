From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Jul 2018 08:33:11 +0100
Subject: [PATCH 2/5] mfd: axp20x: Add self-working mode support for AXP806
In-Reply-To: <20180620051540.25617-3-wens@csie.org>
References: <20180620051540.25617-1-wens@csie.org>
 <20180620051540.25617-3-wens@csie.org>
Message-ID: <20180704073311.GH20176@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Jun 2018, Chen-Yu Tsai wrote:

> The AXP806 can operate in a standalone "self-working" mode, in which it
> is also responsible for power control of the overall system. This mode
> is similar to the master mode, but the EN/PWRON pin functions as a power
> button, instead of a level-triggered enable switch.
> 
> This patch adds code checking for the new "x-powers,self-working-mode"
> property, and a separate mfd_cell list that includes the power button
> (PEK) sub-device.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 9a2ef3d9b8f8..1988881529a9 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -221,6 +221,11 @@ static const struct resource axp803_pek_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
>  };
>  
> +static const struct resource axp806_pek_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(AXP806_IRQ_POK_RISE, "PEK_DBR"),
> +	DEFINE_RES_IRQ_NAMED(AXP806_IRQ_POK_FALL, "PEK_DBF"),
> +};
> +
>  static const struct resource axp809_pek_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP809_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
>  	DEFINE_RES_IRQ_NAMED(AXP809_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
> @@ -730,6 +735,17 @@ static const struct mfd_cell axp803_cells[] = {
>  	{	.name			= "axp20x-regulator" },
>  };
>  
> +static const struct mfd_cell axp806_self_working_cells[] = {
> +	{
> +		.name			= "axp221-pek",
> +		.num_resources		= ARRAY_SIZE(axp806_pek_resources),
> +		.resources		= axp806_pek_resources,
> +	},
> +	{
> +		.name			= "axp20x-regulator",
> +	},
> +};

Nit: Please place single line entries on a single line.  Like this:

	{   	  .name			= "axp20x-regulator", },

After you have made that change, please add my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
