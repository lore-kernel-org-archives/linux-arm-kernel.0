From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Wed, 27 Jan 2016 00:42:33 +0200
Subject: [PATCH] pinctrl: mvebu: fix num_settings in mpp group assignment
In-Reply-To: <1453844952-28292-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20160126182251.GF15550@darkstar.musicnaut.iki.fi>
 <1453844952-28292-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20160126224233.GI15550@darkstar.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 26, 2016 at 10:49:12PM +0100, Sebastian Hesselbarth wrote:
> When assigning mpp settings from static mpp modes to mpp groups,
> we do not want any groups that have no setting for a specific Kirkwood
> variant. However, when there is at least a single setting, we need to
> assign the number of all settings in this mode to grp->num_settings
> as we are reusing the static modes table.
> 
> Fixes: 0581b16b1840 ("pinctrl: mvebu: complain about missing group after checking variant")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Aaro,
> 
> thanks for reporting the issue. It really looks like we should rework
> the mpp mode/setting/group assignment one day. Please apply this fix
> and report back with a Tested-by if it works.

This fixes the SDIO on kirkwood-openrd-client.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks,

A.

> 
> Sebastian
> ---
>  drivers/pinctrl/mvebu/pinctrl-mvebu.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> index e4d473811bb3..4a3c7fe533b5 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> @@ -663,11 +663,11 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
>  	/* assign mpp modes to groups */
>  	for (n = 0; n < soc->nmodes; n++) {
>  		struct mvebu_mpp_mode *mode = &soc->modes[n];
> -		struct mvebu_mpp_ctrl_setting *set = &mode->settings[0];
> +		struct mvebu_mpp_ctrl_setting *set;
>  		struct mvebu_pinctrl_group *grp;
>  		unsigned num_settings;
>  
> -		for (num_settings = 0; ; set++) {
> +		for (num_settings = 0, set = &mode->settings[0]; ; set++) {
>  			if (!set->name)
>  				break;
>  
> @@ -676,6 +676,21 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
>  				continue;
>  
>  			num_settings++;
> +		}
> +
> +		/* skip modes with no settings for this variant */
> +		if (!num_settings)
> +			continue;
> +
> +		for (num_settings = 0, set = &mode->settings[0]; ; set++) {
> +			if (!set->name)
> +				break;
> +
> +			num_settings++;
> +
> +			/* skip unsupported settings for this variant */
> +			if (pctl->variant && !(pctl->variant & set->variant))
> +				continue;
>  
>  			/* find gpio/gpo/gpi settings */
>  			if (strcmp(set->name, "gpio") == 0)
> @@ -687,10 +702,6 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
>  				set->flags = MVEBU_SETTING_GPI;
>  		}
>  
> -		/* skip modes with no settings for this variant */
> -		if (!num_settings)
> -			continue;
> -
>  		grp = mvebu_pinctrl_find_group_by_pid(pctl, mode->pid);
>  		if (!grp) {
>  			dev_warn(&pdev->dev, "unknown pinctrl group %d\n",
> -- 
> 2.1.4
> 
