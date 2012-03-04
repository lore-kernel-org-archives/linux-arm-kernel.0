From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 4 Mar 2012 20:00:31 +0100
Subject: [PATCH 04/20] ARM: imx: convert audmux to a platform driver
In-Reply-To: <1330788001-10158-5-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120304190031.GT3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2012 at 11:19:45PM +0800, Shawn Guo wrote:
> From: Richard Zhao <richard.zhao@linaro.org>
> 
> It coverts audmux to a platform driver, so that it can be moved into
> sound/soc/imx and adopt device tree support later.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-imx/eukrea_mbimx27-baseboard.c   |    7 ++
>  arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |    7 ++
>  arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c |    7 ++
>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c    |    7 ++
>  arch/arm/mach-imx/mach-mx31ads.c               |    6 +
>  arch/arm/mach-imx/mach-pca100.c                |    7 ++
>  arch/arm/mach-imx/mach-pcm043.c                |    7 ++
>  arch/arm/plat-mxc/audmux.c                     |  127 +++++++++++++++++-------
>  8 files changed, 140 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> index 5f2f91d..11cd0a0 100644
> --- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> +++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> @@ -294,6 +294,10 @@ struct imx_ssi_platform_data eukrea_mbimx27_ssi_pdata __initconst = {
>  	.flags = IMX_SSI_DMA | IMX_SSI_USE_I2S_SLAVE,
>  };
>  
> +static const struct resource audmux_res[] __initconst = {
> +	DEFINE_RES_MEM(MX27_AUDMUX_BASE_ADDR, SZ_4K),
> +};
> +
>  /*
>   * system init for baseboard usage. Will be called by cpuimx27 init.
>   *
> @@ -317,6 +321,9 @@ void __init eukrea_mbimx27_baseboard_init(void)
>  	i2c_register_board_info(0, eukrea_mbimx27_i2c_devices,
>  				ARRAY_SIZE(eukrea_mbimx27_i2c_devices));
>  
> +	/* imx27 has the imx21 version audmux */
> +	imx_add_platform_device("imx21-audmux", 0, audmux_res,
> +				ARRAY_SIZE(audmux_res), NULL, 0);

The audmux is a device completely internal to the i.MX and is registered
without platform_data. I think we should do the device registration
somewhere in the SoC specific code and not do it in each board.
Also we now have platform_device_register_simple, we shouldn't use the
imx_ variant in new code.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
