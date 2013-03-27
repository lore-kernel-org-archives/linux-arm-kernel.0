From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 14:17:05 +0900
Subject: [PATCH] ARM: shmobile: r8a73a4: add thermal driver support
In-Reply-To: <87li9ait0c.wl%kuninori.morimoto.gx@renesas.com>
References: <20130326013414.11796.9937.sendpatchset@w520>
 <87mwtqit29.wl%kuninori.morimoto.gx@renesas.com>
 <87li9ait0c.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130327051703.GJ25431@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 11:18:15PM -0700, Kuninori Morimoto wrote:
> You can get current thermal by
> > cat /sys/class/thermal/thermal_zone?/temp
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks Morimoto-san.

Magnus, if you are ok with this change could you either:

* Let me know that your r8a73a4 is ready to be queued-up or;
* Include this patch in the next post of your r8a73a4 series with the
  following at the top of the body of the email.

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> ---
>  arch/arm/boot/dts/r8a73a4.dtsi         |    7 +++++++
>  arch/arm/mach-shmobile/clock-r8a73a4.c |   13 ++++++++++++-
>  arch/arm/mach-shmobile/setup-r8a73a4.c |   15 +++++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
> index 4c68ba1..7db5b50 100644
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> @@ -84,4 +84,11 @@
>  				<0 56 4>, <0 57 4>;
>  	};
>  
> +	thermal at e61f0000 {
> +		compatible = "renesas,rcar-thermal";
> +		reg = <0xe61f0000 0x14>, <0xe61f0100 0x38>,
> +			 <0xe61f0200 0x38>, <0xe61f0300 0x38>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 69 4>;
> +	};
>  };
> diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
> index 037713b..e710c00 100644
> --- a/arch/arm/mach-shmobile/clock-r8a73a4.c
> +++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
> @@ -29,6 +29,7 @@
>  
>  #define MPCKCR 0xe6150080
>  #define SMSTPCR2 0xe6150138
> +#define SMSTPCR5 0xe6150144
>  
>  static struct clk_mapping cpg_mapping = {
>  	.phys   = CPG_BASE,
> @@ -56,7 +57,12 @@ static struct clk *main_clks[] = {
>  	&extal2_clk,
>  };
>  
> -enum { MSTP217, MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP_NR };
> +enum {
> +	MSTP217, MSTP216, MSTP207, MSTP206, MSTP204, MSTP203,
> +	MSTP522,
> +	MSTP_NR
> +};
> +
>  static struct clk mstp_clks[MSTP_NR] = {
>  	[MSTP204] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 4, 0), /* SCIFA0 */
>  	[MSTP203] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 3, 0), /* SCIFA1 */
> @@ -64,6 +70,7 @@ static struct clk mstp_clks[MSTP_NR] = {
>  	[MSTP207] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 7, 0), /* SCIFB1 */
>  	[MSTP216] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 16, 0), /* SCIFB2 */
>  	[MSTP217] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 17, 0), /* SCIFB3 */
> +	[MSTP522] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR5, 22, 0), /* Thermal */
>  };
>  
>  static struct clk_lookup lookups[] = {
> @@ -73,6 +80,10 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP207]),
>  	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP216]),
>  	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP217]),
> +	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
> +
> +	/* for DT */
> +	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
>  };
>  
>  void __init r8a73a4_clock_init(void)
> diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
> index c2d86f3..c5a75a7 100644
> --- a/arch/arm/mach-shmobile/setup-r8a73a4.c
> +++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
> @@ -155,6 +155,20 @@ static const struct resource irqc1_resources[] = {
>  					  &irqc##idx##_data,		\
>  					  sizeof(struct renesas_irqc_config))
>  
> +/* Thermal0 -> Thermal2 */
> +static const struct resource thermal0_resources[] = {
> +	DEFINE_RES_MEM(0xe61f0000, 0x14),
> +	DEFINE_RES_MEM(0xe61f0100, 0x38),
> +	DEFINE_RES_MEM(0xe61f0200, 0x38),
> +	DEFINE_RES_MEM(0xe61f0300, 0x38),
> +	DEFINE_RES_IRQ(gic_spi(69)),
> +};
> +
> +#define r8a73a4_register_thermal()					\
> +	platform_device_register_simple("rcar_thermal", -1,		\
> +					thermal0_resources,		\
> +					ARRAY_SIZE(thermal0_resources))
> +
>  void __init r8a73a4_add_standard_devices(void)
>  {
>  	r8a73a4_register_scif(SCIFA0);
> @@ -165,6 +179,7 @@ void __init r8a73a4_add_standard_devices(void)
>  	r8a73a4_register_scif(SCIFB3);
>  	r8a73a4_register_irqc(0);
>  	r8a73a4_register_irqc(1);
> +	r8a73a4_register_thermal();
>  }
>  
>  #ifdef CONFIG_USE_OF
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
