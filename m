From: marex@denx.de (Marek Vasut)
Date: Sat, 22 Jun 2013 04:31:50 +0200
Subject: [PATCH 2/2] ARM: dts: mx28: Fix sgtl5000 codec probe
In-Reply-To: <1371849720-14506-2-git-send-email-festevam@gmail.com>
References: <1371849720-14506-1-git-send-email-festevam@gmail.com>
 <1371849720-14506-2-git-send-email-festevam@gmail.com>
Message-ID: <201306220431.50879.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit 9e13f345887 (ASoC: sgtl5000: Let the codec acquire its
> clock)it is necessary to pass a codec clock to the sgtl5000 driver.
> 
> On some boards the sgtl5000 codec is driven via SAIF MCLK signal, so enable
> it early in machine code to allow the I2C codec access to succeed.
> 
> Since the saif mclk cannot be passed as a real clock within the clock
> framework, let's pass a dummy one to the codec driver.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Tested on a mx28evk board running linux-next 20130621
> 
>  arch/arm/boot/dts/imx28-apx4devkit.dts |  2 +-
>  arch/arm/boot/dts/imx28-evk.dts        |  2 +-
>  arch/arm/boot/dts/imx28-m28evk.dts     |  2 +-
>  arch/arm/mach-mxs/mach-mxs.c           | 41
> ++++++++++++++++++++++++++++++++++ 4 files changed, 44 insertions(+), 3
> deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts
> b/arch/arm/boot/dts/imx28-apx4devkit.dts index 43bf3c7..f26bf2f 100644
> --- a/arch/arm/boot/dts/imx28-apx4devkit.dts
> +++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
> @@ -147,7 +147,7 @@
>  					reg = <0x0a>;
>  					VDDA-supply = <&reg_3p3v>;
>  					VDDIO-supply = <&reg_3p3v>;
> -
> +					clocks = <&clks 65>;
>  				};
> 
>  				pcf8563: rtc at 51 {
> diff --git a/arch/arm/boot/dts/imx28-evk.dts
> b/arch/arm/boot/dts/imx28-evk.dts index 3637bf3..28f20b6 100644
> --- a/arch/arm/boot/dts/imx28-evk.dts
> +++ b/arch/arm/boot/dts/imx28-evk.dts
> @@ -193,7 +193,7 @@
>  					reg = <0x0a>;
>  					VDDA-supply = <&reg_3p3v>;
>  					VDDIO-supply = <&reg_3p3v>;
> -
> +					clocks = <&clks 65>;
>  				};
> 
>  				at24 at 51 {
> diff --git a/arch/arm/boot/dts/imx28-m28evk.dts
> b/arch/arm/boot/dts/imx28-m28evk.dts index 880df2f..a09c5bf 100644
> --- a/arch/arm/boot/dts/imx28-m28evk.dts
> +++ b/arch/arm/boot/dts/imx28-m28evk.dts
> @@ -184,7 +184,7 @@
>  					reg = <0x0a>;
>  					VDDA-supply = <&reg_3p3v>;
>  					VDDIO-supply = <&reg_3p3v>;
> -
> +					clocks = <&clks 65>;
>  				};
> 
>  				eeprom: eeprom at 51 {
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 6298adb..57ab042 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -27,6 +27,7 @@
>  #include <linux/phy.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/sys_soc.h>
> +#include <linux/stmp_device.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/time.h>
> @@ -59,6 +60,8 @@
>  #define MXS_CLR_ADDR		0x8
>  #define MXS_TOG_ADDR		0xc
> 
> +#define SAIF0			0x100
> +
>  static u32 chipid;
>  static u32 socid;
> 
> @@ -264,11 +267,46 @@ static inline void enable_clk_enet_out(void)
>  		clk_prepare_enable(clk);
>  }
> 
> +static void __init mxs_enable_mclk(void)
> +{
> +	struct device_node *np;
> +	void __iomem *clkctrl_base, *saif_base;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,clkctrl");
> +	clkctrl_base = of_iomap(np, 0);
> +
> +	if (!clkctrl_base)
> +		return;
> +
> +	/*
> +	 * DIV_FRAC_EN, MCLK frequency = 44.1KHz * 512 =  22.5792MHz
> +	 * This initial MCLK frequency is just to allow I2C access to the
> +	 * SGLT5000 codec to work
> +	 */
> +	writel(0x10c0b, clkctrl_base + SAIF0);
> +
> +	iounmap(clkctrl_base);
> +	of_node_put(np);
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx28-saif");
> +	saif_base = of_iomap(np, 0);
> +
> +	if (!saif_base)
> +		return;
> +
> +	stmp_reset_block(saif_base);
> +	writel(1, saif_base + STMP_OFFSET_REG_SET);
> +
> +	iounmap(saif_base);
> +	of_node_put(np);


Should the SAIF block reset not happen in the driver?

> +}
> +
>  static void __init imx28_evk_init(void)
>  {
>  	update_fec_mac_prop(OUI_FSL);
> 
>  	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
> +	mxs_enable_mclk();
>  }
> 
>  static void __init imx28_evk_post_init(void)
> @@ -293,6 +331,7 @@ static void __init apx4devkit_init(void)
>  	if (IS_BUILTIN(CONFIG_PHYLIB))
>  		phy_register_fixup_for_uid(PHY_ID_KSZ8051, MICREL_PHY_ID_MASK,
>  					   apx4devkit_phy_fixup);
> +	mxs_enable_mclk();
>  }
> 
>  #define ENET0_MDC__GPIO_4_0	MXS_GPIO_NR(4, 0)
> @@ -483,6 +522,8 @@ static void __init mxs_machine_init(void)
>  		 of_machine_is_compatible("crystalfontz,cfa10055") ||
>  		 of_machine_is_compatible("crystalfontz,cfa10057"))
>  		crystalfontz_init();
> +	else if (of_machine_is_compatible("denx,m28evk"))
> +		mxs_enable_mclk();
> 
>  	of_platform_populate(NULL, of_default_bus_match_table,
>  			     mxs_auxdata_lookup, parent);

Best regards,
Marek Vasut
