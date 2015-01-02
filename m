From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Jan 2015 10:46:35 +0100
Subject: [PATCH] arch: arm: mach-omap2: voltage.c: Remove some unused
 functions
In-Reply-To: <1420131994-31636-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1420131994-31636-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <3966855.LUXW4xbVYM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 January 2015 18:06:34 Rickard Strandqvist wrote:

> -void omap_change_voltscale_method(struct voltagedomain *voltdm,
> -				  int voltscale_method)
> -{
> -	if (!voltdm || IS_ERR(voltdm)) {
> -		pr_warn("%s: VDD specified does not exist!\n", __func__);
> -		return;
> -	}
> -
> -	switch (voltscale_method) {
> -	case VOLTSCALE_VPFORCEUPDATE:
> -		voltdm->scale = omap_vp_forceupdate_scale;
> -		return;
> -	case VOLTSCALE_VCBYPASS:
> -		voltdm->scale = omap_vc_bypass_scale;
> -		return;
> -	default:
> -		pr_warn("%s: Trying to change the method of voltage scaling to an unsupported one!\n",
> -			__func__);
> -	}
> -}

The VOLTSCALE_VPFORCEUPDATE/VOLTSCALE_VCBYPASS macros are now unused and should
be removed as well.

> @@ -321,10 +290,9 @@ static struct voltagedomain *_voltdm_lookup(const char *name)
>   * @voltdm: struct voltagedomain * to add the powerdomain to
>   * @pwrdm: struct powerdomain * to associate with a voltagedomain
>   *
> - * Associate the powerdomain @pwrdm with a voltagedomain @voltdm.  This
> - * enables the use of voltdm_for_each_pwrdm().  Returns -EINVAL if
> - * presented with invalid pointers; -ENOMEM if memory could not be allocated;
> - * or 0 upon success.
> + * Associate the powerdomain @pwrdm with a voltagedomain @voltdm.
> + * Returns -EINVAL if presented with invalid pointers;
> + * -ENOMEM if memory could not be allocated; or 0 upon success.
>   */
>  int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm)
>  {

You have correctly spotted the only place that references voltdm_for_each_pwrdm
and changed the comment, but you failed to notice that it no longer makes
sense to call voltdm_add_pwrdm or keep the voltdm->pwrdm_list pointer
at all, so this function, and the associated list heads can all be removed
as well.

	Arnd
