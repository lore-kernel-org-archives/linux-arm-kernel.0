From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 2 Feb 2016 22:19:00 +0200
Subject: [PATCH v2] pinctrl: mvebu: fix num_settings in mpp group
 assignment
In-Reply-To: <1454366903-7038-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1453844952-28292-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1454366903-7038-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20160202201900.GA1620@darkstar.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 01, 2016 at 11:48:23PM +0100, Sebastian Hesselbarth wrote:
> When assigning mpp settings from static mpp modes to mpp groups,
> we do not want any groups that have no supported setting for a
> specific Kirkwood variant. However, when there is at least a
> single supported setting, we need to assign the number of all
> settings in this mode to grp->num_settings as we are reusing
> the static modes table.
> 
> Fixes: 0581b16b1840 ("pinctrl: mvebu: complain about missing group after checking variant")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> --
> Changelog:
> v1->v2:
> - Chose a less intrusive fix by adding supp_settings variable
>   instead of looping over the settings twice.
> 
> Aaro, Linus,
> 
> I prefer this less intrusive fix in favor of v1.
> 
> @Aaro: Can you please test again?

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> 
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/pinctrl/mvebu/pinctrl-mvebu.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> index e4d473811bb3..3ef798fac81b 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> @@ -666,16 +666,19 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
>  		struct mvebu_mpp_ctrl_setting *set = &mode->settings[0];
>  		struct mvebu_pinctrl_group *grp;
>  		unsigned num_settings;
> +		unsigned supp_settings;
>  
> -		for (num_settings = 0; ; set++) {
> +		for (num_settings = 0, supp_settings = 0; ; set++) {
>  			if (!set->name)
>  				break;
>  
> +			num_settings++;
> +
>  			/* skip unsupported settings for this variant */
>  			if (pctl->variant && !(pctl->variant & set->variant))
>  				continue;
>  
> -			num_settings++;
> +			supp_settings++;
>  
>  			/* find gpio/gpo/gpi settings */
>  			if (strcmp(set->name, "gpio") == 0)
> @@ -688,7 +691,7 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
>  		}
>  
>  		/* skip modes with no settings for this variant */
> -		if (!num_settings)
> +		if (!supp_settings)
>  			continue;
>  
>  		grp = mvebu_pinctrl_find_group_by_pid(pctl, mode->pid);
> -- 
> 2.1.4
> 
