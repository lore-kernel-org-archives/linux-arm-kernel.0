From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 7 Dec 2015 15:37:42 +0800
Subject: [PATCH v10 01/17] drm: bridge: analogix/dp: split exynos dp
 driver to bridge directory
In-Reply-To: <1449470312-30880-1-git-send-email-ykk@rock-chips.com>
References: <1449470239-30667-1-git-send-email-ykk@rock-chips.com>
 <1449470312-30880-1-git-send-email-ykk@rock-chips.com>
Message-ID: <56653746.5040306@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/07/2015 02:38 PM, Yakir Yang wrote:
> Split the dp core driver from exynos directory to bridge directory,
> and rename the core driver to analogix_dp_*, rename the platform
> code to exynos_dp.
>
> Beside the new analogix_dp driver would export six hooks.
> "analogix_dp_bind()" and "analogix_dp_unbind()"
> "analogix_dp_suspned()" and "analogix_dp_resume()"
> "analogix_dp_detect()" and "analogix_dp_get_modes()"
>
> The bind/unbind symbols is used for analogix platform driver to connect
> with analogix_dp core driver. And the detect/get_modes is used for analogix
> platform driver to init the connector.
>
> They reason why connector need register in helper driver is rockchip drm
> haven't implement the atomic API, but Exynos drm have implement it, so
> there would need two different connector helper functions, that's why we
> leave the connector register in helper driver.
>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>
> diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> similarity index 50%
> rename from drivers/gpu/drm/exynos/exynos_dp_core.c
> rename to drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index aee3262..cd86413 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>   
> -static int exynos_dp_remove(struct platform_device *pdev)
> +void analogix_dp_unbind(struct device *dev, struct device *master,
> +			void *data)
>   {
> -	pm_runtime_disable(&pdev->dev);
> -	component_del(&pdev->dev, &exynos_dp_ops);
> +	struct analogix_dp_device *dp = dev_get_drvdata(dev);
>   
> -	return 0;
> +	analogix_dp_bridge_disable(dp->bridge);
> +	pm_runtime_disable(&pdev->dev);
>   }
> +EXPORT_SYMBOL_GPL(analogix_dp_unbind);
>   

Sorry to introduce an compiled error, my test 4.4-rc3 kernel have some
different with linux-next kernel, so i used to write the patches on next 
kernel,
and back the changes to my 4.4 kernel to test.

I already found this error when I'm testing, but forget to reserver this 
changes
to linux-next kernel, I would send a new version to fix this.

- Yakir
