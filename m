From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 Aug 2012 14:43:07 -0600
Subject: [PATCH v2 1/9] pinctrl: mvebu: pinctrl driver core
In-Reply-To: <1345623750-10645-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1345623750-10645-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <5035445B.6000500@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2012 02:22 AM, Sebastian Hesselbarth wrote:
> This patch adds a pinctrl driver core for Marvell SoCs plus DT
> binding documentation. This core driver will be used by SoC family
> specific drivers, i.e. Armada XP, Armada 370, Dove, Kirkwood, aso.

> +++ b/Documentation/devicetree/bindings/pinctrl/marvell,mvebu-pinctrl.txt

This, and all the other binding documents in this series, all look sane
to me.

> +++ b/drivers/pinctrl/pinctrl-mvebu.c

> +static int mvebu_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,


> +	of_property_for_each_string(np, "marvell,pins", prop, group) {
> +		struct mvebu_pinctrl_group *grp =
> +			mvebu_pinctrl_find_group_by_name(pctl, group);
> +
> +		if (!grp) {
> +			dev_err(pctl->dev, "unknown pin %s", group);
> +			continue;
> +		}
> +
> +		if (!mvebu_pinctrl_find_setting_by_name(pctl, grp, function)) {
> +			dev_err(pctl->dev, "unsupported function %s on pin %s",
> +				function, group);
> +			continue;
> +		}

The error-checking here isn't strictly necessary; the pinctrl core will
error-check all the names if/when the map entries are used. So, you
could probably get away with just assigning the pin/function names
directly into (*map) and hence remove some code here. Still, it's not a
big deal either way.

> +static int __devinit mvebu_pinctrl_dt_parse_function(struct mvebu_pinctrl *pctl,

> +static int __devinit mvebu_pinctrl_dt_parse(struct platform_device *pdev,
> +					struct mvebu_pinctrl *pctl)

I don't understand what those two functions do, or a good chunk of
probe(). It seems like they're setting up the ability to get/set pin
configrations in addition to pin muxing, although if that's so, it seems
odd that none of the binding documents specify any way of controlling
pin configuration from device tree. Are you expecting drivers to call
APIs such as pin_config_set() directly, rather than controlling pin
config through DT?
