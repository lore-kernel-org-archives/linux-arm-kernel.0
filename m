From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 05 Feb 2013 17:22:23 -0700
Subject: [PATCH v3 1/3] drm/exynos: Get HDMI version from device tree
In-Reply-To: <1360107777-17490-2-git-send-email-seanpaul@chromium.org>
References: <1360107777-17490-1-git-send-email-seanpaul@chromium.org>
 <1360107777-17490-2-git-send-email-seanpaul@chromium.org>
Message-ID: <5111A23F.50300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

n 02/05/2013 04:42 PM, Sean Paul wrote:
> Use the compatible string in the device tree to determine which
> registers/functions to use in the HDMI driver. Also changes the
> references from v13 to 4210 and v14 to 4212 to reflect the IP
> block version instead of the HDMI version.

> diff --git a/Documentation/devicetree/bindings/drm/exynos/hdmi.txt b/Documentation/devicetree/bindings/drm/exynos/hdmi.txt

Binding looks sane to me.

> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c

>  #ifdef CONFIG_OF
>  static struct of_device_id hdmi_match_types[] = {
>  	{
> -		.compatible = "samsung,exynos5-hdmi",
> -		.data	= (void	*)HDMI_TYPE14,
> +		.compatible = "samsung,exynos4-hdmi",
>  	}, {
>  		/* end node */
>  	}

Why not fill in all the "base" compatible values there (I think you need
this anyway so that DTs don't all have to be compatible with
samsung,exynos4-hdmi), with .data containing the HDMI_VER_EXYNOS*
values, then ...

> @@ -2218,17 +2217,18 @@ static int hdmi_probe(struct platform_device *pdev)

> +
> +	if (of_device_is_compatible(dev->of_node, "samsung,exynos4210-hdmi"))
> +		hdata->version |= HDMI_VER_EXYNOS4210;
> +	if (of_device_is_compatible(dev->of_node, "samsung,exynos4212-hdmi"))
> +		hdata->version |= HDMI_VER_EXYNOS4212;
> +	if (of_device_is_compatible(dev->of_node, "samsung,exynos5250-hdmi"))
> +		hdata->version |= HDMI_VER_EXYNOS5250;

Instead of that, do roughly:

    match = of_match_device(hdmi_match_types, &pdev->dev);
    if (match)
        hdata->version |= (int)match->data;

That way, it's all table-based. Any future additions to
hdmi_match_types[] won't require another if statement to be added to
probe().
