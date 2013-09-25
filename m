From: horms@verge.net.au (Simon Horman)
Date: Thu, 26 Sep 2013 08:40:24 +0900
Subject: [PATCH/RFC] ARM: shmobile: Add r8a7791 thermal sensor DT device
In-Reply-To: <20130925231801.16487.26821.sendpatchset@w520>
References: <20130925231801.16487.26821.sendpatchset@w520>
Message-ID: <20130925234023.GD20882@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 08:18:01AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Hook up the single channel thermal sensor via DT
> on r8a7791. The information comes from the device
> data sheet.
> 
> Unfortunately it seems that r8a7791 uses a different
> register offset compared to r8a7790, so passing
> the singel channel offset results in the following
> error:
> 
> rcar_thermal e61f0000.thermal: can't request region for resource [mem 0xe61f0000-0xe61f0037]                                                                    
> rcar_thermal: probe of e61f0000.thermal failed with error -16                   
> 
> Before this can be merged the thermal driver may beed
> to be extended to support the different register layouts
> for the thermal sensor in r8a7779, r8a7790 and r8a7791.
> 
> Not-Yet-Signed-off-by: Magnus Damm <damm@opensource.se>

Hi Magnus,

when you repost this patch please split it into two.
An SoC patch that updates clock-r8a7791.c.
And a DT patch which updates r8a7791.dtsi.

Thanks

> ---
> 
>  Written against renesas-devel-20130925
> 
>  arch/arm/boot/dts/r8a7791.dtsi         |    7 +++++++
>  arch/arm/mach-shmobile/clock-r8a7791.c |    3 +++
>  2 files changed, 10 insertions(+)
> 
> --- 0001/arch/arm/boot/dts/r8a7791.dtsi
> +++ work/arch/arm/boot/dts/r8a7791.dtsi	2013-09-26 07:34:01.000000000 +0900
> @@ -38,4 +38,11 @@
>  			<0 0xf1006000 0 0x2000>;
>  		interrupts = <1 9 0xf04>;
>  	};
> +
> +	thermal at e61f0000 {
> +		compatible = "renesas,rcar-thermal";
> +		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0000 0 0x38>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 69 4>;
> +	};
>  };
> --- 0001/arch/arm/mach-shmobile/clock-r8a7791.c
> +++ work/arch/arm/mach-shmobile/clock-r8a7791.c	2013-09-26 07:32:34.000000000 +0900
> @@ -122,6 +122,7 @@ static struct clk *main_clks[] = {
>  enum {
>  	MSTP721, MSTP720,
>  	MSTP719, MSTP718, MSTP715, MSTP714,
> +	MSTP522,
>  	MSTP216, MSTP207, MSTP206,
>  	MSTP204, MSTP203, MSTP202, MSTP1105, MSTP1106, MSTP1107,
>  	MSTP124,
> @@ -135,6 +136,7 @@ static struct clk mstp_clks[MSTP_NR] = {
>  	[MSTP718] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 18, 0), /* SCIF3 */
>  	[MSTP715] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 15, 0), /* SCIF4 */
>  	[MSTP714] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 14, 0), /* SCIF5 */
> +	[MSTP522] = SH_CLK_MSTP32(&extal_clk, SMSTPCR5, 22, 0), /* Thermal */
>  	[MSTP216] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 16, 0), /* SCIFB2 */
>  	[MSTP207] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 7, 0), /* SCIFB1 */
>  	[MSTP206] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 6, 0), /* SCIFB0 */
> @@ -179,6 +181,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh-sci.12", &mstp_clks[MSTP1105]), /* SCIFA3 */
>  	CLKDEV_DEV_ID("sh-sci.13", &mstp_clks[MSTP1106]), /* SCIFA4 */
>  	CLKDEV_DEV_ID("sh-sci.14", &mstp_clks[MSTP1107]), /* SCIFA5 */
> +	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
>  	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
>  };
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
