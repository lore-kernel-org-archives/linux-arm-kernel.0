From: marex@denx.de (Marek Vasut)
Date: Mon, 9 Jul 2012 09:10:54 +0200
Subject: [PATCH 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <1341814496-17487-4-git-send-email-shawn.guo@linaro.org>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <201207090910.55032.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> From: Marek Vasut <marex@denx.de>
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx28.dtsi |   21 ++++
>  arch/arm/boot/dts/m28evk.dts |  241
> ++++++++++++++++++++++++++++++++++++++++++ arch/arm/mach-mxs/mach-mxs.c | 
>  30 +++++
>  3 files changed, 292 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/m28evk.dts
[...]

> +static void __init m28evk_init(void)
> +{
> +	update_fec_mac_prop(OUI_DENX);

You need to start the FEC clock here too, otherwise ethernet won't work. Same 
thing as on mx28evk. And I noticed that on other platforms too, so maybe that 
should be somehow the other way around -- turn on the ethernet clock by default.

The rest seems OK. I'll update the .dts file once we get the rest of the stuff 
in (SPI and i2c).

btw. is someone converting the mxs-lcd ?

> +	mxsfb_pdata.mode_list = m28evk_video_modes;
> +	mxsfb_pdata.mode_count = ARRAY_SIZE(m28evk_video_modes);
> +	mxsfb_pdata.default_bpp = 16;
> +	mxsfb_pdata.ld_intf_width = STMLCDIF_18BIT;
> +}
> +
>  static void __init mxs_machine_init(void)
>  {
>  	if (of_machine_is_compatible("fsl,imx28-evk"))
>  		imx28_evk_init();
>  	else if (of_machine_is_compatible("fsl,imx23-evk"))
>  		imx23_evk_init();
> +	else if (of_machine_is_compatible("denx,m28evk"))
> +		m28evk_init();
> 
>  	of_platform_populate(NULL, of_default_bus_match_table,
>  			     mxs_auxdata_lookup, NULL);
> @@ -223,6 +252,7 @@ static const char *imx23_dt_compat[] __initdata = {
> 
>  static const char *imx28_dt_compat[] __initdata = {
>  	"crystalfontz,cfa10036",
> +	"denx,m28evk",
>  	"fsl,imx28-evk",
>  	"fsl,imx28",
>  	NULL,
