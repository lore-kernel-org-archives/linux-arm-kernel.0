From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 05 Nov 2014 15:56:29 +0200
Subject: [PATCH 2/7] pinctrl: pinconf-generic: Infer map type from DT
 property
In-Reply-To: <1415041531-15520-3-git-send-email-soren.brinkmann@xilinx.com>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-3-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <21124316.ibhe1N9UZS@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,

Thank you for the patch.

On Monday 03 November 2014 11:05:26 Soren Brinkmann wrote:
> With the new 'groups' property, the DT parser can infer the map type
> from the fact whether 'pins' or 'groups' is used to specify the pin
> group to work on.
> To maintain backwards compatibitliy with current usage of the DT
> binding, this is only done when an invalid map type is passed to the
> parsing function.

The Renesas PFC implements similar bindings with using the vendor-specific 
properties "renesas,pins" and "renesas,groups" (bindings and implementation 
available at Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt 
and drivers/pinctrl/sh-pfc/pinctrl.c respectively).

The Renesas implementation is a bit more generic in that it allows both pins 
and groups to be specified in a single subnode. Do you think that feature 
would make sense for pinconf-generic as well ?

> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> Changes since RFC v2:
>  - none
> ---
>  drivers/pinctrl/pinconf-generic.c       | 17 ++++++++++++++---
>  include/linux/pinctrl/pinconf-generic.h |  7 +++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinconf-generic.c
> b/drivers/pinctrl/pinconf-generic.c index f78b416d7984..1e782a0d6e48 100644
> --- a/drivers/pinctrl/pinconf-generic.c
> +++ b/drivers/pinctrl/pinconf-generic.c
> @@ -264,6 +264,7 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev
> *pctldev, unsigned reserve;
>  	struct property *prop;
>  	const char *group;
> +	const char *dt_pin_specifier = "pins";
> 
>  	ret = of_property_read_string(np, "function", &function);
>  	if (ret < 0) {
> @@ -284,10 +285,20 @@ int pinconf_generic_dt_subnode_to_map(struct
> pinctrl_dev *pctldev, reserve++;
>  	if (num_configs)
>  		reserve++;
> +
>  	ret = of_property_count_strings(np, "pins");
>  	if (ret < 0) {
> -		dev_err(dev, "could not parse property pins\n");
> -		goto exit;
> +		ret = of_property_count_strings(np, "groups");
> +		if (ret < 0) {
> +			dev_err(dev, "could not parse property pins/groups\n");
> +			goto exit;
> +		}
> +		if (type == PIN_MAP_TYPE_INVALID)
> +			type = PIN_MAP_TYPE_CONFIGS_GROUP;
> +		dt_pin_specifier = "groups";
> +	} else {
> +		if (type == PIN_MAP_TYPE_INVALID)
> +			type = PIN_MAP_TYPE_CONFIGS_PIN;
>  	}
>  	reserve *= ret;
> 
> @@ -296,7 +307,7 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev
> *pctldev, if (ret < 0)
>  		goto exit;
> 
> -	of_property_for_each_string(np, "pins", prop, group) {
> +	of_property_for_each_string(np, dt_pin_specifier, prop, group) {
>  		if (function) {
>  			ret = pinctrl_utils_add_map_mux(pctldev, map,
>  					reserved_maps, num_maps, group,
> diff --git a/include/linux/pinctrl/pinconf-generic.h
> b/include/linux/pinctrl/pinconf-generic.h index d578a60eff23..b6dedfbfce69
> 100644
> --- a/include/linux/pinctrl/pinconf-generic.h
> +++ b/include/linux/pinctrl/pinconf-generic.h
> @@ -174,6 +174,13 @@ static inline int pinconf_generic_dt_node_to_map_pin(
>  			PIN_MAP_TYPE_CONFIGS_PIN);
>  }
> 
> +static inline int pinconf_generic_dt_node_to_map_all(
> +		struct pinctrl_dev *pctldev, struct device_node *np_config,
> +		struct pinctrl_map **map, unsigned *num_maps)
> +{
> +	return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
> +			PIN_MAP_TYPE_INVALID);
> +}
>  #endif
> 
>  #endif /* CONFIG_GENERIC_PINCONF */

-- 
Regards,

Laurent Pinchart
