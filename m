From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Oct 2016 10:07:07 +0200
Subject: [PATCH 3/3] pinctrl: sunxi: Make sunxi_pconf_group_set use
 sunxi_pconf_reg helper
In-Reply-To: <20161004015112.20833-4-wens@csie.org>
References: <20161004015112.20833-1-wens@csie.org>
 <20161004015112.20833-4-wens@csie.org>
Message-ID: <20161004080707.GL5228@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 09:51:12AM +0800, Chen-Yu Tsai wrote:
> The sunxi_pconf_reg helper introduced in the last patch gives us the
> chance to rework sunxi_pconf_group_set to have it match the structure
> of sunxi_pconf_(group_)get and make it easier to understand.
> 
> For each config to set, it:
> 
>     1. checks if the parameter is supported.
>     2. checks if the argument is within limits.
>     3. converts argument to the register value.
>     4. writes to the register with spinlock held.
> 
> As a result the function now blocks unsupported config parameters,
> instead of silently ignoring them.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 65 +++++++++++++++++++----------------
>  drivers/pinctrl/sunxi/pinctrl-sunxi.h |  1 -
>  2 files changed, 35 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index 236272a2339d..1f02c4cd55c7 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -364,23 +364,27 @@ static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
>  {
>  	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
>  	struct sunxi_pinctrl_group *g = &pctl->groups[group];
> -	unsigned long flags;
>  	unsigned pin = g->pin - pctl->desc->pin_base;
> -	u32 val, mask;
> -	u16 strength;
> -	u8 dlevel;
>  	int i;
>  
> -	spin_lock_irqsave(&pctl->lock, flags);
> -
>  	for (i = 0; i < num_configs; i++) {
> -		switch (pinconf_to_config_param(configs[i])) {
> +		enum pin_config_param param;
> +		unsigned long flags;
> +		u32 offset, shift, mask, val;
> +		u16 arg;
> +		int ret;
> +
> +		param = pinconf_to_config_param(configs[i]);
> +		arg = pinconf_to_config_argument(configs[i]);
> +
> +		ret = sunxi_pconf_reg(pin, param, &offset, &shift, &mask);
> +		if (ret < 0)
> +			return ret;
> +
> +		switch (param) {
>  		case PIN_CONFIG_DRIVE_STRENGTH:
> -			strength = pinconf_to_config_argument(configs[i]);
> -			if (strength > 40) {
> -				spin_unlock_irqrestore(&pctl->lock, flags);
> +			if (arg < 10 || arg > 40)

This is a nitpick, but I'd really like to store the value in a
separate variable, to have a distinction between the value that was
given us as an argument, and what we're going to write.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161004/bed27c82/attachment.sig>
