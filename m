From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 29 Oct 2015 16:07:32 +0900
Subject: [PATCH v2] ARM: exynos: Bring back reboot on Exynos5410
In-Reply-To: <1446102105-8896-1-git-send-email-p.fedin@samsung.com>
References: <1446102105-8896-1-git-send-email-p.fedin@samsung.com>
Message-ID: <5631C5B4.4080101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.10.2015 16:01, Pavel Fedin wrote:
> Since 8cfc7fdd33080e30b86d21b1a8c9ad0686427ddc
> ("ARM: EXYNOS: move restart code into pmu driver") PMU support is required
> in order for the reboot to work. Unfortunately, there is currently no PMU
> support for 5410.
> 
> This patch adds exynos5410-pmu to the list of recognized devices. It is
> okay for the code to have empty struct exynos_pmu_data, in this case only
> minimal support is enabled. This is enough for SWRESET to work.
> 
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Fixes: 8cfc7fdd3308 ("ARM: EXYNOS: move restart code into pmu driver")


Eh, I pointed in my last reply what you need to do:

Cc: <stable@vger.kernel.org>

Just add this tag and resend. This is the way of backporting to stable.

Best regards,
Krzysztof

> ---
> v1 => v2:
> - Added 'const'
> ---
>  arch/arm/mach-exynos/pmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
> index de68938..ecbe980 100644
> --- a/arch/arm/mach-exynos/pmu.c
> +++ b/arch/arm/mach-exynos/pmu.c
> @@ -908,6 +908,10 @@ static const struct exynos_pmu_data exynos5250_pmu_data = {
>  	.powerdown_conf	= exynos5_powerdown_conf,
>  };
>  
> +static const struct exynos_pmu_data exynos5410_pmu_data = {
> +	/* Only SWRESET is currently supported on 5410 */
> +};
> +
>  static struct exynos_pmu_data exynos5420_pmu_data = {
>  	.pmu_config	= exynos5420_pmu_config,
>  	.pmu_init	= exynos5420_pmu_init,
> @@ -934,6 +938,9 @@ static const struct of_device_id exynos_pmu_of_device_ids[] = {
>  		.compatible = "samsung,exynos5250-pmu",
>  		.data = &exynos5250_pmu_data,
>  	}, {
> +		.compatible = "samsung,exynos5410-pmu",
> +		.data = &exynos5410_pmu_data,
> +	}, {
>  		.compatible = "samsung,exynos5420-pmu",
>  		.data = &exynos5420_pmu_data,
>  	},
> 
