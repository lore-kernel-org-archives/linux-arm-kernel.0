From: jbrunet@baylibre.com (Jerome Brunet)
Date: Sun, 26 Mar 2017 19:51:47 +0200
Subject: [RFC PATCH] clk: meson: gxbb: remove the "cpu_clk"
In-Reply-To: <20170326110602.23379-1-martin.blumenstingl@googlemail.com>
References: <20170326110602.23379-1-martin.blumenstingl@googlemail.com>
Message-ID: <1490550707.29739.21.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-03-26 at 13:06 +0200, Martin Blumenstingl wrote:
> It seems that the "cpu_clk" was carried over from the meson8b clock
> controller driver. On Meson GX (GXBB/GXL/GXM) the registers which are
> used by the cpu_clk have a different purpose (in other words: they don't
> control the CPU clock anymore). HHI_SYS_CPU_CLK_CNTL1 bits 31:24 are
> reserved according to the public S905 datasheet, while bit 23 is the
> "A53_trace_clk_DIS" gate (which according to the datasheet should only
> be used in case a silicon bug is discovered) and bits 22:20 are a
> divider (A53_trace_clk). The meson clk-cpu code however expects that
> bits 28:20 are reserved for a divider (according to the public S805
> datasheet this "SCALE_DIV: This value represents an N+1 divider of the
> input clock.").
> 
> The CPU clock on Meson GX SoCs is provided by the SCPI DVFS clock
> driver instead. Two examples from a Meson GXL S905X SoC:
> - vcpu (SCPI DVFS clock 0) rate: 1000000000 / cpu_clk rate: 708000000
> - vcpu (SCPI DVFS clock 0) rate: 1512000000 / cpu_clk rate: 708000000
> 

Thanks for catching this Martin! Looking at the difference between the S805 and
S905 register description, it makes no sense that we used the same clock driver
for what's behind HHI_SYS_CPU_CLK_CNTL1. I agree, it should be removed from the
gxbb clock controller.

> Unfortunately the CLKID_CPUCLK was already exported (but is currently
> not used) to DT.
> 
> This is an RFC because I would like to hear other people's opinion on
> how to clean up the CLKID_CPUCLK (as it leaves a "hole" in
> gxbb_hw_onecell_data and changes the DT API (by removing a currently
> unused #define).
> 

In general the DT ABI should be stable but since no one is using this ID, and
what it refers to is clearly wrong, I don't think we would disrupt anything by
removing it.

For the "hole" in the ids, Neil and I had similar problem while working other
topics. We managed to dodge it but I think it was only a matter of time ...

In the end, it is not a big deal if there is holes in the onecell_data, as long
as we take care to avoid it when we register the clocks:

/*
 * register all clks
 */
for (clkid = 0; clkid < NR_CLKS; clkid++) {

+	if (!gxbb_hw_onecell_data.hws[clkid])
+			continue;

	ret = devm_clk_hw_register(dev, gxbb_hw_onecell_data.hws[clkid]);
	if (ret)
		goto iounmap;
}

Same thing is done for the meson8b.
Also, once ID #1 is free, nothing prevents us from recycling it ...

Overall, the patch looks good to me but make sure to add the change above if you
introduce holes in the onecell_data.

Cheers

> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> ?drivers/clk/meson/gxbb.c??????????????| 44 +++-------------------------------
> -
> ?drivers/clk/meson/gxbb.h??????????????|??2 +-
> ?include/dt-bindings/clock/gxbb-clkc.h |??1 -
> ?3 files changed, 4 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 1c1ec137a3cc..06586fe16ce3 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -496,21 +496,10 @@ static struct meson_clk_mpll gxbb_mpll2 = {
> ?};
> ?
> ?/*
> - * FIXME cpu clocks and the legacy composite clocks (e.g. clk81) are both PLL
> - * post-dividers and should be modeled with their respective PLLs via the
> - * forthcoming coordinated clock rates feature
> + * FIXME The legacy composite clocks (e.g. clk81) are both PLL post-dividers
> + * and should be modeled with their respective PLLs via the forthcoming
> + * coordinated clock rates feature
> ? */
> -static struct meson_clk_cpu gxbb_cpu_clk = {
> -	.reg_off = HHI_SYS_CPU_CLK_CNTL1,
> -	.div_table = cpu_div_table,
> -	.clk_nb.notifier_call = meson_clk_cpu_notifier_cb,
> -	.hw.init = &(struct clk_init_data){
> -		.name = "cpu_clk",
> -		.ops = &meson_clk_cpu_ops,
> -		.parent_names = (const char *[]){ "sys_pll" },
> -		.num_parents = 1,
> -	},
> -};
> ?
> ?static u32 mux_table_clk81[]	= { 6, 5, 7 };
> ?
> @@ -698,7 +687,6 @@ static MESON_GATE(gxbb_ao_i2c, HHI_GCLK_AO, 4);
> ?static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
> ?	.hws = {
> ?		[CLKID_SYS_PLL]		????= &gxbb_sys_pll.hw,
> -		[CLKID_CPUCLK]		????= &gxbb_cpu_clk.hw,
> ?		[CLKID_HDMI_PLL]	????= &gxbb_hdmi_pll.hw,
> ?		[CLKID_FIXED_PLL]	????= &gxbb_fixed_pll.hw,
> ?		[CLKID_FCLK_DIV2]	????= &gxbb_fclk_div2.hw,
> @@ -925,9 +913,6 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
> ?	for (i = 0; i < ARRAY_SIZE(gxbb_clk_mplls); i++)
> ?		gxbb_clk_mplls[i]->base = clk_base;
> ?
> -	/* Populate the base address for CPU clk */
> -	gxbb_cpu_clk.base = clk_base;
> -
> ?	/* Populate the base address for the MPEG clks */
> ?	gxbb_mpeg_clk_sel.reg = clk_base + (u64)gxbb_mpeg_clk_sel.reg;
> ?	gxbb_mpeg_clk_div.reg = clk_base + (u64)gxbb_mpeg_clk_div.reg;
> @@ -950,29 +935,6 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
> ?			goto iounmap;
> ?	}
> ?
> -	/*
> -	?* Register CPU clk notifier
> -	?*
> -	?* FIXME this is wrong for a lot of reasons. First, the muxes should
> be
> -	?* struct clk_hw objects. Second, we shouldn't program the muxes in
> -	?* notifier handlers. The tricky programming sequence will be handled
> -	?* by the forthcoming coordinated clock rates mechanism once that
> -	?* feature is released.
> -	?*
> -	?* Furthermore, looking up the parent this way is terrible. At some
> -	?* point we will stop allocating a default struct clk when
> registering
> -	?* a new clk_hw, and this hack will no longer work. Releasing the ccr
> -	?* feature before that time solves the problem :-)
> -	?*/
> -	parent_hw = clk_hw_get_parent(&gxbb_cpu_clk.hw);
> -	parent_clk = parent_hw->clk;
> -	ret = clk_notifier_register(parent_clk, &gxbb_cpu_clk.clk_nb);
> -	if (ret) {
> -		pr_err("%s: failed to register clock notifier for cpu_clk\n",
> -				__func__);
> -		goto iounmap;
> -	}
> -
> ?	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
> ?			&gxbb_hw_onecell_data);
> ?
> diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
> index cbd62e46bb5b..ca1285acb92d 100644
> --- a/drivers/clk/meson/gxbb.h
> +++ b/drivers/clk/meson/gxbb.h
> @@ -169,7 +169,7 @@
> ? * to be exposed to client nodes in DT: include/dt-bindings/clock/gxbb-clkc.h
> ? */
> ?#define CLKID_SYS_PLL		??0
> -/* CLKID_CPUCLK */
> +/* CLKID_CPUCLK - not used in the driver anymore */

I would completely remove the reference to CPUCLK and put a small comment here,
explaining why the id is free.

> ?/* CLKID_HDMI_PLL */
> ?#define CLKID_FIXED_PLL		??3
> ?/* CLKID_FCLK_DIV2 */
> diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-
> bindings/clock/gxbb-clkc.h
> index 63f4c2c44a1f..07311dfdba83 100644
> --- a/include/dt-bindings/clock/gxbb-clkc.h
> +++ b/include/dt-bindings/clock/gxbb-clkc.h
> @@ -5,7 +5,6 @@
> ?#ifndef __GXBB_CLKC_H
> ?#define __GXBB_CLKC_H
> ?
> -#define CLKID_CPUCLK		1
> ?#define CLKID_HDMI_PLL		2
> ?#define CLKID_FCLK_DIV2		4
> ?#define CLKID_FCLK_DIV3		5
