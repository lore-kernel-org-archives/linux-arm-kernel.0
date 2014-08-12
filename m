From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 12 Aug 2014 16:19:39 +0200
Subject: [PATCH] ARM: dts: Only build dtb if associated Arch and/or SoC
 is enabled
In-Reply-To: <1407852078-31309-1-git-send-email-pbrobinson@gmail.com>
References: <1407852078-31309-1-git-send-email-pbrobinson@gmail.com>
Message-ID: <1407853179.4724.4.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 12.08.2014, 15:01 +0100 schrieb Peter Robinson:
> A number of arches (EXYNOS/IMX/TEGRA) are separated out into finer
> grained definitions whether it be sub ARCH or SOC definitions. The
> device tree blobs should only be built if the specific option is
> enabled that supports that device or it might be that there's an
> expectation that the device is supported when in actual fact it's
> not. This ensures only the relevant bits are built.
> 
> This also helps to avoid trivial merge conflicts when adding support
> for new boards.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

a small nitpick below, otherwise:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm/boot/dts/Makefile | 50 +++++++++++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b8c5cd3..e95808e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -64,7 +64,7 @@ dtb-$(CONFIG_ARCH_BRCMSTB) += \
>  dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
>  	da850-evm.dtb
>  dtb-$(CONFIG_ARCH_EFM32) += efm32gg-dk3750.dtb
> -dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
> +dtb-$(CONFIG_ARCH_EXYNOS4) += exynos4210-origen.dtb \
>  	exynos4210-smdkv310.dtb \
>  	exynos4210-trats.dtb \
>  	exynos4210-universal_c210.dtb \
> @@ -74,8 +74,8 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \

I would argue that things look a little more consistent with the
linebreak directly behind the "+=", as with the IMX entries. Maybe if
other platform maintainers agree we could change this while touching
things anyway. But this is only a small nitpick, so feel free to ignore.

>  	exynos4412-origen.dtb \
>  	exynos4412-smdk4412.dtb \
>  	exynos4412-tiny4412.dtb \
> -	exynos4412-trats2.dtb \
> -	exynos5250-arndale.dtb \
> +	exynos4412-trats2.dtb
> +dtb-$(CONFIG_ARCH_EXYNOS5) += exynos5250-arndale.dtb \
>  	exynos5250-smdk5250.dtb \
>  	exynos5250-snow.dtb \
>  	exynos5260-xyref5260.dtb \
> @@ -160,28 +160,34 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += kirkwood-b3.dtb \
>  dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
>  dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
>  dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
> -dtb-$(CONFIG_ARCH_MXC) += \
> +dtb-$(CONFIG_SOC_IMX25) += \
>  	imx25-eukrea-mbimxsd25-baseboard.dtb \
>  	imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb \
>  	imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb \
>  	imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb \
>  	imx25-karo-tx25.dtb \
> -	imx25-pdk.dtb \
> +	imx25-pdk.dtb
> +dtb-$(CONFIG_SOC_IMX27) += \
>  	imx27-apf27.dtb \
>  	imx27-apf27dev.dtb \
>  	imx27-eukrea-mbimxsd27-baseboard.dtb \
>  	imx27-pdk.dtb \
>  	imx27-phytec-phycore-rdk.dtb \
> -	imx27-phytec-phycard-s-rdk.dtb \
> -	imx31-bug.dtb \
> +	imx27-phytec-phycard-s-rdk.dtb
> +dtb-$(CONFIG_SOC_IMX31) += \
> +	imx31-bug.dtb
> +dtb-$(CONFIG_SOC_IMX35) += \
>  	imx35-eukrea-mbimxsd35-baseboard.dtb \
> -	imx35-pdk.dtb \
> -	imx50-evk.dtb \
> +	imx35-pdk.dtb
> +dtb-$(CONFIG_SOC_IMX50) += \
> +	imx50-evk.dtb
> +dtb-$(CONFIG_SOC_IMX51) += \
>  	imx51-apf51.dtb \
>  	imx51-apf51dev.dtb \
>  	imx51-babbage.dtb \
>  	imx51-digi-connectcore-jsk.dtb \
> -	imx51-eukrea-mbimxsd51-baseboard.dtb \
> +	imx51-eukrea-mbimxsd51-baseboard.dtb
> +dtb-$(CONFIG_SOC_IMX53) += \
>  	imx53-ard.dtb \
>  	imx53-m53evk.dtb \
>  	imx53-mba53.dtb \
> @@ -190,7 +196,8 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx53-smd.dtb \
>  	imx53-tx53-x03x.dtb \
>  	imx53-tx53-x13x.dtb \
> -	imx53-voipac-bsb.dtb \
> +	imx53-voipac-bsb.dtb
> +dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6dl-aristainetos_4.dtb \
>  	imx6dl-aristainetos_7.dtb \
>  	imx6dl-cubox-i.dtb \
> @@ -237,9 +244,12 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx6q-tx6q-1010-comtft.dtb \
>  	imx6q-tx6q-1020.dtb \
>  	imx6q-tx6q-1020-comtft.dtb \
> -	imx6q-tx6q-1110.dtb \
> +	imx6q-tx6q-1110.dtb
> +dtb-$(CONFIG_SOC_IMX6SL) += \
>  	imx6sl-evk.dtb \
> -	imx6sx-sdb.dtb \
> +dtb-$(CONFIG_SOC_IMX6SX) += \
> +	imx6sx-sdb.dtb
> +dtb-$(CONFIG_SOC_VF610) += \
>  	vf610-colibri.dtb \
>  	vf610-cosmic.dtb \
>  	vf610-twr.dtb
> @@ -421,7 +431,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-pcduino3.dtb
>  dtb-$(CONFIG_MACH_SUN8I) += \
>  	sun8i-a23-ippo-q8h-v5.dtb
> -dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
> +dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra20-harmony.dtb \
>  	tegra20-iris-512.dtb \
>  	tegra20-medcom-wide.dtb \
>  	tegra20-paz00.dtb \
> @@ -430,16 +440,16 @@ dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
>  	tegra20-tec.dtb \
>  	tegra20-trimslice.dtb \
>  	tegra20-ventana.dtb \
> -	tegra20-whistler.dtb \
> -	tegra30-apalis-eval.dtb \
> +	tegra20-whistler.dtb
> +dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-apalis-eval.dtb \
>  	tegra30-beaver.dtb \
>  	tegra30-cardhu-a02.dtb \
>  	tegra30-cardhu-a04.dtb \
> -	tegra30-colibri-eval-v3.dtb \
> -	tegra114-dalmore.dtb \
> +	tegra30-colibri-eval-v3.dtb
> +dtb-$(CONFIG_ARCH_TEGRA_114_SOC) += tegra114-dalmore.dtb \
>  	tegra114-roth.dtb \
> -	tegra114-tn7.dtb \
> -	tegra124-jetson-tk1.dtb \
> +	tegra114-tn7.dtb
> +dtb-$(CONFIG_ARCH_TEGRA_124_SOC) += tegra124-jetson-tk1.dtb \
>  	tegra124-venice2.dtb
>  dtb-$(CONFIG_ARCH_U300) += ste-u300.dtb
>  dtb-$(CONFIG_ARCH_U8500) += ste-snowball.dtb \

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
