From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Thu, 31 Jul 2014 08:09:49 +0200
Subject: [PATCH] ARM: exynos_defconfig: Enable PL330 DMA
In-Reply-To: <1406785359-21669-1-git-send-email-tushar.b@samsung.com>
References: <1406785359-21669-1-git-send-email-tushar.b@samsung.com>
Message-ID: <53D9DDAD.7040602@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tushar,

Am 31.07.2014 07:42, schrieb Tushar Behera:
> We are getting a system hang on Arndale-Octa board if PL330_DMA is not
> enabled. The issue is related to [1].
> 
> AUDSS block provides the clock for audio DMA controller. Any operation
> on this clock requires that the clock to AUDSS block be enabled. In
> current configuration, the clock is gated during late boot process when
> all unused clocks are disabled.
> 
> When PL330_DMA is enabled, the 'apb_pclk' is enabled/disabled during
> amba_probe(). Otherwise, this clock is also disabled during late boot.
> If the AUDSS block clock is disabled by then, we get a system hang.
> 
> [1] https://lkml.org/lkml/2014/6/11/32
> 
> Signed-off-by: Tushar Behera <tushar.b@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index e07a227..c5888e8 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -109,6 +109,8 @@ CONFIG_MMC_DW_IDMAC=y
>  CONFIG_MMC_DW_EXYNOS=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_S3C=y
> +CONFIG_DMADEVICES=y
> +CONFIG_PL330_DMA=y
>  CONFIG_COMMON_CLK_MAX77686=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Turns out I had those enabled in my local config when testing the memory
patches on Arndale Octa.

multi_v7_defconfig has them already.

However, shouldn't Kconfig grow a dependency to enable those options
automatically for whatever driver or SoC needs them?

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
