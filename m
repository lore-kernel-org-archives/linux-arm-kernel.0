From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Mon, 8 Oct 2018 09:33:12 +0200
Subject: [PATCH v2 5/6] mfd: axp20x: add support AXP803 AC and battery
 power supplies
In-Reply-To: <20181006211836.28253-6-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
 <20181006211836.28253-6-oskari@lemmela.net>
Message-ID: <20181008073312.otdz25ttvew6fzk2@qschulz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oskari,

On Sun, Oct 07, 2018 at 12:18:35AM +0300, Oskari Lemmela wrote:
> AXP803 is compatible with AXP813.
> Adding needed cells for AC and battery power supplies.
> 
> AXP813 AC power supply cell added.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  drivers/mfd/axp20x.c       | 22 +++++++++++++++++++++-
>  include/linux/mfd/axp20x.h |  1 +
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 0be511dd93d0..215f0b009728 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -731,8 +731,23 @@ static const struct mfd_cell axp803_cells[] = {
>  		.name			= "axp221-pek",
>  		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
>  		.resources		= axp803_pek_resources,
> +	}, {
> +		.name			= "axp20x-regulator"
> +	}, {
> +		.name			= "axp20x-gpio",
> +		.of_compatible		= "x-powers,axp813-gpio",
> +	}, {
> +		.name			= "axp813-adc",
> +		.of_compatible		= "x-powers,axp813-adc",
> +	}, {
> +		.name		= "axp20x-battery-power-supply",
> +		.of_compatible	= "x-powers,axp813-battery-power-supply",
> +	}, {
> +		.name           = "axp20x-ac-power-supply",
> +		.of_compatible  = "x-powers,axp813-ac-power-supply",
> +		.num_resources  = ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +		.resources      = axp20x_ac_power_supply_resources,
>  	},
> -	{	.name			= "axp20x-regulator" },
>  };
>  
>  static const struct mfd_cell axp806_self_working_cells[] = {
> @@ -778,6 +793,11 @@ static const struct mfd_cell axp813_cells[] = {
>  	}, {
>  		.name		= "axp20x-battery-power-supply",
>  		.of_compatible	= "x-powers,axp813-battery-power-supply",
> +	}, {
> +		.name           = "axp20x-ac-power-supply",
> +		.of_compatible  = "x-powers,axp813-ac-power-supply",
> +		.num_resources  = ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +		.resources      = axp20x_ac_power_supply_resources,

I'll let Maxime or Chen-Yu tell you what they want but I think we could
have two different commits, one for AXP803 and one for AXP813. I don't
think we care about having one commit per added resource for the axp803
though.

>  	},
>  };
>  
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 517e60eecbcb..2302b620d238 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -266,6 +266,7 @@ enum axp20x_variants {
>  #define AXP288_RT_BATT_V_H		0xa0
>  #define AXP288_RT_BATT_V_L		0xa1
>  
> +#define AXP813_ACIN_PATH_CTRL		0x3a

You're not using it in this patch, please keep this change in the commit
where its use is introduced.

Thanks,
Quentin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181008/40abd802/attachment.sig>
