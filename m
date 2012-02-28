From: khilman@ti.com (Kevin Hilman)
Date: Tue, 28 Feb 2012 14:40:38 -0800
Subject: [PATCH 04/14] ARM: OMAP3+: SmartReflex: Add a shutdown hook
In-Reply-To: <1328723039-15952-5-git-send-email-j-pihet@ti.com> (Jean Pihet's
 message of "Wed, 8 Feb 2012 18:43:49 +0100")
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
 <1328723039-15952-5-git-send-email-j-pihet@ti.com>
Message-ID: <87d38yk2e1.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> From: Nishanth Menon <nm@ti.com>
>
> SmartReflex fix for erratum ID i724.
>
> Since OMAP's VP and PRM modules do not get reset by warm reset,
> we should ensure that proper shutdown procedure is followed prior
> to allowing the kernel to reboot back up.

prior to reboot?  how?

This patch only ensures a proper shutdown if the kernel goes down
cleanly.

How is this handled on reboot?

Kevin

> Without this patch, Smartreflex module might be left active or
> system might be caught in an indeterminate sequence when reboot
> is triggered, leaving the next reboot behavior to be unpredictable.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index ec2b0e7..9c39484 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -1055,8 +1055,32 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void __devexit omap_sr_shutdown(struct platform_device *pdev)
> +{
> +	struct omap_sr_data *pdata = pdev->dev.platform_data;
> +	struct omap_sr *sr_info;
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
> +		return;
> +	}
> +
> +	sr_info = _sr_lookup(pdata->voltdm);
> +	if (IS_ERR(sr_info)) {
> +		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
> +			__func__);
> +		return;
> +	}
> +
> +	if (sr_info->autocomp_active)
> +		sr_stop_vddautocomp(sr_info);
> +
> +	return;
> +}
> +
>  static struct platform_driver smartreflex_driver = {
>  	.remove         = omap_sr_remove,
> +	.shutdown	= __devexit_p(omap_sr_shutdown),
>  	.driver		= {
>  		.name	= "smartreflex",
>  	},
