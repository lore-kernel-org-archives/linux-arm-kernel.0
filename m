From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 28 Nov 2015 11:18:47 +0100
Subject: [PATCH] pinctrl: mvebu: complain about missing group after
 checking variant
In-Reply-To: <1448705645-13881-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1448705645-13881-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <56597F87.9020400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.11.2015 11:14, Sebastian Hesselbarth wrote:
> Common MVEBU pinctrl driver core gets an array of controls to modify
> a specific set of registers and an array of modes for each pingroup
> from each of the different SoC families of MVEBU.
> 
> Some SoC families comprise different variants that differ in available
> pingroups and also controls, but to ease driver development, we can
> pass a variant mask to disable specific pingroups for some variants.
> However, controls are limited to the true number of pinctrl groups
> available on a variant.
> 
> Now, when pinctrl core driver parses over above arrays, it tries to
> match modes with available controls and complains about missing
> controls for modes that are passed to the core but actually are not
> available on a variant with:
> 
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 36
> 
> This warning is a false-positive and annoying, so move the warning
> after we checked the variant mask for each mode setting. Also, if
> there is no supported setting for this variant, do not complain at
> all.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Simon Guinot <simon.guinot@sequanux.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/pinctrl/mvebu/pinctrl-mvebu.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> index 77d2221d379d..dbc95369317a 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> @@ -663,16 +663,9 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
>  	/* assign mpp modes to groups */
>  	for (n = 0; n < soc->nmodes; n++) {
>  		struct mvebu_mpp_mode *mode = &soc->modes[n];
> -		struct mvebu_pinctrl_group *grp =
> -			mvebu_pinctrl_find_group_by_pid(pctl, mode->pid);
> +		struct mvebu_pinctrl_group *grp;
>  		unsigned num_settings;
>  
> -		if (!grp) {
> -			dev_warn(&pdev->dev, "unknown pinctrl group %d\n",
> -				mode->pid);
> -			continue;
> -		}
> -
>  		for (num_settings = 0; ;) {
>  			struct mvebu_mpp_ctrl_setting *set =
>  				&mode->settings[num_settings];
> @@ -695,6 +688,17 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
>  				set->flags = MVEBU_SETTING_GPI;
>  		}
>  
> +		/* skip modes with no settings for this variant */

Erm, dammit. This does not work as expected.
The loop right over this does increment num_settings unconditionally.

I'll have to find a better solution...

Sebastian

> +		if (!num_settings)
> +			continue;
> +
> +		grp = mvebu_pinctrl_find_group_by_pid(pctl, mode->pid);
> +		if (!grp) {
> +			dev_warn(&pdev->dev, "unknown pinctrl group %d\n",
> +				mode->pid);
> +			continue;
> +		}
> +
>  		grp->settings = mode->settings;
>  		grp->num_settings = num_settings;
>  	}
> 
