From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Jun 2013 22:49:08 +0200
Subject: [PATCH] pinctrl-sunxi: fix pin attribute handling.
In-Reply-To: <1371748373-10519-1-git-send-email-ithamar@upgrade-android.com>
References: <1371748373-10519-1-git-send-email-ithamar@upgrade-android.com>
Message-ID: <20130620204908.GG2987@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ithamar,

You should probably put in the recipients Linus Walleij that will
probably be the one that will merge this patch anyway.

On Thu, Jun 20, 2013 at 07:12:53PM +0200, Ithamar R. Adema wrote:
> From: "Ithamar R. Adema" <ithamar@upgrade-android.com>
> 
> The configuration of pull up/down on pins does not allow disabling
> of the pins. PIN_CONFIG_BIAS_PULL_UP and PIN_CONFIG_BIAS_PULL_DOWN
> take an argument of 1 or 0 to specify enabling or disabling of the
> pull up/down, but the code does not take this into account.
> 
> Also, default the pullup/downs to disabled if not specified, so no old
> state from e.g. the bootloader is still active after reconfiguration
> by the kernel.
> 
> Signed-off-by: Ithamar R. Adema <ithamar@upgrade-android.com>
> ---
>  drivers/pinctrl/pinctrl-sunxi.c |   39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
> index b7d8c89..a652061 100644
> --- a/drivers/pinctrl/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/pinctrl-sunxi.c
> @@ -1466,7 +1466,7 @@ static int sunxi_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
>  	of_property_for_each_string(node, "allwinner,pins", prop, group) {
>  		struct sunxi_pinctrl_group *grp =
>  			sunxi_pinctrl_find_group_by_name(pctl, group);
> -		int j = 0, configlen = 0;
> +		u16 strength;
>  
>  		if (!grp) {
>  			dev_err(pctl->dev, "unknown pin %s", group);
> @@ -1490,31 +1490,23 @@ static int sunxi_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
>  		(*map)[i].type = PIN_MAP_TYPE_CONFIGS_GROUP;
>  		(*map)[i].data.configs.group_or_pin = group;
>  
> -		if (of_find_property(node, "allwinner,drive", NULL))
> -			configlen++;
> -		if (of_find_property(node, "allwinner,pull", NULL))
> -			configlen++;
> -
> -		pinconfig = kzalloc(configlen * sizeof(*pinconfig), GFP_KERNEL);
> +		pinconfig = kzalloc(3 * sizeof(*pinconfig), GFP_KERNEL);
>  
> +		strength = 0;
>  		if (!of_property_read_u32(node, "allwinner,drive", &val)) {
> -			u16 strength = (val + 1) * 10;
> -			pinconfig[j++] =
> -				pinconf_to_config_packed(PIN_CONFIG_DRIVE_STRENGTH,
> -							 strength);
> +			strength = (val + 1) * 10;
>  		}
> +		pinconfig[0] =
> +			pinconf_to_config_packed(PIN_CONFIG_DRIVE_STRENGTH,
> +						 strength);

Why are you making the configuration of the strength in any cases? It's
an optional property, it should be treated as such.

> -		if (!of_property_read_u32(node, "allwinner,pull", &val)) {
> -			enum pin_config_param pull = PIN_CONFIG_END;
> -			if (val == 1)
> -				pull = PIN_CONFIG_BIAS_PULL_UP;
> -			else if (val == 2)
> -				pull = PIN_CONFIG_BIAS_PULL_DOWN;
> -			pinconfig[j++] = pinconf_to_config_packed(pull, 0);
> -		}
> +		val = 0;
> +		of_property_read_u32(node, "allwinner,pull", &val);
> +		pinconfig[1] = pinconf_to_config_packed(PIN_CONFIG_BIAS_PULL_UP, val == 1);
> +		pinconfig[2] = pinconf_to_config_packed(PIN_CONFIG_BIAS_PULL_DOWN, val == 2);
 
I'm not sure this is actually right. The pins are either configured to
have a pull-up, a pull-down, or none of it, in the same register, in the
same bitfield, so why adding it in any cases? we only care about at most
one of the two, and those two options are mutually exclusive.

>  		(*map)[i].data.configs.configs = pinconfig;
> -		(*map)[i].data.configs.num_configs = configlen;
> +		(*map)[i].data.configs.num_configs = 3;
>  
>  		i++;
>  	}
> @@ -1563,6 +1555,7 @@ static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
>  {
>  	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
>  	struct sunxi_pinctrl_group *g = &pctl->groups[group];
> +	u32 arg = pinconf_to_config_argument(config);
>  	u32 val, mask;
>  	u16 strength;
>  	u8 dlevel;
> @@ -1586,15 +1579,17 @@ static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
>  			pctl->membase + sunxi_dlevel_reg(g->pin));
>  		break;
>  	case PIN_CONFIG_BIAS_PULL_UP:
> +		arg = !!arg;

Ouch, nope.

Put this next to the call to pinconf_to_config_argument

>  		val = readl(pctl->membase + sunxi_pull_reg(g->pin));
>  		mask = PULL_PINS_MASK << sunxi_pull_offset(g->pin);
> -		writel((val & ~mask) | 1 << sunxi_pull_offset(g->pin),
> +		writel((val & ~mask) | arg << sunxi_pull_offset(g->pin),

I'd rather see an obvious assignment of 1 here. It's the value that is
documented in the datasheet, it pops to the mind. You can always put
this inside an if(arg) statement if you want to.

>  			pctl->membase + sunxi_pull_reg(g->pin));
>  		break;
>  	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		arg = !!arg;
>  		val = readl(pctl->membase + sunxi_pull_reg(g->pin));
>  		mask = PULL_PINS_MASK << sunxi_pull_offset(g->pin);
> -		writel((val & ~mask) | 2 << sunxi_pull_offset(g->pin),
> +		writel((val & ~mask) | (arg << 1) << sunxi_pull_offset(g->pin),

Ditto.

>  			pctl->membase + sunxi_pull_reg(g->pin));
>  		break;
>  	default:

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
