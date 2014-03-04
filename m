From: r.sh.open@gmail.com (Rahul Sharma)
Date: Tue, 4 Mar 2014 09:44:38 +0530
Subject: [PATCH v3 5/5] clk/exynos5260: add clock file for exynos5260
In-Reply-To: <53095A9A.4080606@gmail.com>
References: <1392724570-27977-1-git-send-email-rahul.sharma@samsung.com>
 <1392724570-27977-6-git-send-email-rahul.sharma@samsung.com>
 <53095A9A.4080606@gmail.com>
Message-ID: <CAPdUM4PL9p-fNaim_YFFMV_bA4higxQa6ppSNUGg5nmMc7a6Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Tomasz,

I have almost reworked this file as per your comments. Please find my
inline comments.

On 23 February 2014 07:49, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Rahul,
>
> On 18.02.2014 12:56, Rahul Sharma wrote:
>
> [snip]
>
>
>> diff --git a/drivers/clk/samsung/clk-exynos5260.c
>> b/drivers/clk/samsung/clk-exynos5260.c
>> new file mode 100644
>> index 0000000..bcb633e
>> --- /dev/null
>> +++ b/drivers/clk/samsung/clk-exynos5260.c
>> @@ -0,0 +1,2235 @@
>> +/*
>> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
>
>
> Most likely it should be 2013-2014 now.
Done.
>
>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * Common Clock Framework support for Exynos5260 SoC.
>> +*/
>
>
> [snip]
>
>
>> +#ifdef CONFIG_PM_SLEEP
>> +
>> +/*
>> + * list of controller registers to be saved and restored during a
>> + * suspend/resume cycle.
>> +*/
>
>
> nit: Unaligned star. + The same for a lot of comments in this file.
>
Done.
>
>> +
>> +static unsigned long exynos5260_aud_clk_regs[] __initdata = {
>
>
> nit: There is no need to prefix every static variable in this file with
> exynos5260_. Shorter (but still completely readable) names will let the code
> using them have shorter lines.
>
Removed.
>
>> + *Registers for CMU_AUD
>> +*/
>> +       MUX_SEL_AUD,
>> +       DIV_AUD0,
>> +       DIV_AUD1,
>
>
> [snip]
>
>
>> +static void exynos5260_clk_sleep_init(void __iomem *reg_base,
>> +                       unsigned long *rdump,
>> +                       unsigned long nr_rdump)
>> +{
>> +       struct exynos5260_clock_reg_cache *reg_cache;
>> +
>> +       reg_cache = kzalloc(sizeof(struct exynos5260_clock_reg_cache),
>> +                       GFP_KERNEL);
>> +       if (!reg_cache)
>> +               panic("could not allocate register cache.\n");
>> +
>> +       reg_cache->rdump = samsung_clk_alloc_reg_dump(rdump, nr_rdump);
>> +
>> +       if (!reg_cache->rdump)
>> +               panic("could not allocate register dump storage.\n");
>> +
>> +       reg_cache->rd_num = nr_rdump;
>> +       reg_cache->reg_base = reg_base;
>> +       list_add_tail(&reg_cache->node, &clock_reg_cache_list);
>> +
>> +       if (!syscore_ops_registered) {
>
>
> To eliminate the need for having a separate variable, you can simply move
> this if clause before list_add_tail() and check for list_empty().
>
Done. Removed this var.
>
>> +               register_syscore_ops(&exynos5260_clk_syscore_ops);
>> +               syscore_ops_registered = true;
>> +       }
>> +
>> +       exynos5260_clk_suspend();
>
>
> What is the reason to call this here and save register values of all
> registered CMus every time a new CMU is instantiated?
>
It is not required. Cleaned.

>
>> +}
>> +
>> +#else
>> +static void exynos5260_clk_sleep_init(void) {}
>> +#endif
>> +
>> +/*
>> + * List of parent clocks for muses in CMU_AUD
>> +*/
>> +PNAME(mout_aud_pll_user_p) = {"fin_pll", "fout_aud_pll"};
>> +PNAME(mout_sclk_aud_i2s_p) = {"mout_aud_pll_user",
>> "ioclk_audcdclk0_user"};
>> +PNAME(mout_sclk_aud_pcm_p) = {"mout_aud_pll_user",
>> "ioclk_audcdclk0_user"};
>> +
>> +/*
>> + * List of parent clocks for muses in CMU_DISP
>> +*/
>> +PNAME(mout_phyclk_dptx_phy_ch3_txd_clk_user_p) = {"fin_pll",
>> +                       "phyclk_dptx_phy_ch3_txd_clk"};
>> +PNAME(mout_phyclk_dptx_phy_ch2_txd_clk_user_p) = {"fin_pll",
>> +                       "phyclk_dptx_phy_ch2_txd_clk"};
>> +PNAME(mout_phyclk_dptx_phy_ch1_txd_clk_user_p) = {"fin_pll",
>> +                       "phyclk_dptx_phy_ch1_txd_clk"};
>> +PNAME(mout_phyclk_dptx_phy_ch0_txd_clk_user_p) = {"fin_pll",
>> +                       "phyclk_dptx_phy_ch0_txd_clk"};
>
>
> Whoa, these clock names are incredibly long. Are they real names from SoC
> User's Manual?
>
Yea, these are same in manual. I kept the name similar, otherwise not easy to
search them in UM.

>
>> +
>> +PNAME(mout_aclk_disp_222_user_p) = {"fin_pll", "dout_aclk_disp_222"};
>> +PNAME(mout_sclk_disp_pixel_user_p) = {"fin_pll", "dout_sclk_disp_pixel"};
>
>
> [snip]
>
>
>> +/* fixed rate clocks generated outside the soc */
>
>
> Huh? If they are generated outside the SoC, they shouldn't be registered by
> this driver, but rather by respective fixed rate clock nodes in DT.

I tried but system doesn't boot if fin_plll is registered from DT as
"fixed-clock".
of_fixed_clk_setup hits after the registration of other CMUs. System asserts
in many places due to div by zero error. It is exactly same for Exynos5420.
So I took 5420 as example and defined fin_pll as osc clock of compatible type
"samsung,exynos5260-oscclk". Rest of the ext clocks are registered as
"fixed-clock". What you say on this ?

>
>
>> +struct samsung_fixed_rate_clock exynos5260_fixed_rate_ext_clks[]
>> __initdata = {
>> +       FRATE(FIN_PLL, "fin_pll", NULL, CLK_IS_ROOT, 24000000),
>> +       FRATE(ID_NONE, "xrtcxti", NULL, CLK_IS_ROOT, 32768),
>> +
>> +       FRATE(ID_NONE, "ioclk_audcdclk0_user", NULL, CLK_IS_ROOT, 0),
>> +
>> +       FRATE(ID_NONE, "ioclk_pcm_extclk", NULL, CLK_IS_ROOT, 2048000),
>> +       FRATE(ID_NONE, "ioclk_aud_i2s_bclk", NULL, CLK_IS_ROOT, 2048000),
>> +       FRATE(ID_NONE, "ioclk_spdif_extclk", NULL, CLK_IS_ROOT, 49152000),
>> +       FRATE(ID_NONE, "ioclk_i2s_cdclk", NULL, CLK_IS_ROOT, 0),
>> +       FRATE(ID_NONE, "ioclk_spdif_extlk", NULL, CLK_IS_ROOT, 0),
>> +
>> +       FRATE(ID_NONE, "ioclk_i2s_sclk", NULL, CLK_IS_ROOT, 0),
>> +       FRATE(ID_NONE, "ioclk_spi0_clkin", NULL, CLK_IS_ROOT, 0),
>> +       FRATE(ID_NONE, "ioclk_spi1_clkin", NULL, CLK_IS_ROOT, 0),
>> +       FRATE(ID_NONE, "ioclk_spi2_clkin", NULL, CLK_IS_ROOT, 0),
>> +
>> +       FRATE(ID_NONE, "ioclk_mmc0_sdrdqs_in", NULL, CLK_IS_ROOT,
>> 200000000),
>> +
>> +       FRATE(ID_NONE, "ioclk_spi0_isp_spi_clk_in", NULL,
>> +                       CLK_IS_ROOT, 50000000),
>> +       FRATE(ID_NONE, "ioclk_spi1_isp_spi_clk_in", NULL,
>> +                       CLK_IS_ROOT, 50000000),
>> +       FRATE(ID_NONE, "ioclk_spi0_isp_spi_clk_out", NULL,
>> +                       CLK_IS_ROOT, 50000000),
>> +       FRATE(ID_NONE, "ioclk_spi1_isp_spi_clk_out", NULL,
>> +                       CLK_IS_ROOT, 50000000),
>> +};
>> +
>> +/* fixed rate clocks generated inside the soc */
>> +struct samsung_fixed_rate_clock exynos5260_fixed_rate_clks[] __initdata =
>> {
>> +       FRATE(ID_NONE, "phyclk_dptx_phy_ch3_txd_clk", NULL,
>> +                       CLK_IS_ROOT, 270000000),
>
>
> Please define IDs for all clocks defined in this driver. This is necessary
> to allow rate and parent configuration using DT in future.
>
> However, if there is a reason to not export some clock, please use 0
> directly, without defining a special macro like ID_NONE.
>

replaced.

>
>> +       FRATE(ID_NONE, "phyclk_dptx_phy_ch2_txd_clk", NULL,
>> +                       CLK_IS_ROOT, 270000000),
>> +       FRATE(ID_NONE, "phyclk_dptx_phy_ch1_txd_clk", NULL,
>> +                       CLK_IS_ROOT, 270000000),
>> +       FRATE(ID_NONE, "phyclk_dptx_phy_ch0_txd_clk", NULL,
>> +                       CLK_IS_ROOT, 270000000),
>> +       FRATE(ID_NONE, "phyclk_hdmi_phy_tmds_clko", NULL,
>> +                       CLK_IS_ROOT, 250000000),
>> +       FRATE(TOP_SCLK_HDMIPHY, "phyclk_hdmi_phy_pixel_clko", NULL,
>> +                       CLK_IS_ROOT, 1660000000),
>
>
> Hmm, so is this clock top_sclk_hdmiphy or phyclk_hdmi_phy_pixel_clko?
> Shouldn't the macro and the name be using the same pattern?
>

I changed these macros as per clock name.

>
>> +       FRATE(ID_NONE, "phyclk_hdmi_link_o_tmds_clkhi", NULL,
>> +                       CLK_IS_ROOT, 125000000),
>> +       FRATE(ID_NONE, "phyclk_mipi_dphy_4l_m_txbyteclkhs", NULL,
>> +                       CLK_IS_ROOT, 187500000),
>> +       FRATE(ID_NONE, "phyclk_dptx_phy_o_ref_clk_24m", NULL,
>> +                       CLK_IS_ROOT, 24000000),
>> +       FRATE(ID_NONE, "phyclk_dptx_phy_clk_div2", NULL,
>> +                       CLK_IS_ROOT, 135000000),
>> +       FRATE(ID_NONE, "phyclk_mipi_dphy_4l_m_rxclkesc0", NULL,
>> +                       CLK_IS_ROOT, 20000000),
>> +       FRATE(ID_NONE, "phyclk_usbhost20_phy_phyclock", NULL,
>> +                       CLK_IS_ROOT, 60000000),
>> +       FRATE(ID_NONE, "phyclk_usbhost20_phy_freeclk", NULL,
>> +                       CLK_IS_ROOT, 60000000),
>> +       FRATE(ID_NONE, "phyclk_usbhost20_phy_clk48mohci", NULL,
>> +                       CLK_IS_ROOT, 48000000),
>> +       FRATE(ID_NONE, "phyclk_usbdrd30_udrd30_pipe_pclk", NULL,
>> +                       CLK_IS_ROOT, 125000000),
>> +       FRATE(ID_NONE, "phyclk_usbdrd30_udrd30_phyclock", NULL,
>> +                       CLK_IS_ROOT, 60000000),
>
>
> Are these really fixed rate clocks? It looks strange, because it's a bit
> unlike previous Samsung SoCs, which used to have up 5 fixed rate clocks in
> average.
>

These are outputs of various phys. If these are removed we will be left with
many orphan clocks.

>
>> +};
>> +
>> +struct samsung_fixed_factor_clock exynos5260_fixed_factor_clks[]
>> __initdata = {
>> +};
>
>
> If empty, why define this array?
>
Removed.

>
>> +
>> +/* MULITPLEXER CLOCKS */
>
>
> [snip]
>
>
>> +
>> +/* GATE CLOCKS */
>> +
>> +/*
>> + * List of Gate clocks for CMU_AUD
>> +*/
>> +struct samsung_gate_clock exynos5260_aud_gate_clks[] __initdata = {
>> +       GATE(AUD_CLK_AUD_UART, "clk_aud_uart", "dout_aclk_aud_131",
>> +                       EN_IP_AUD, 4, 0, 0),
>> +       GATE(AUD_CLK_PCM, "clk_pcm", "dout_aclk_aud_131", EN_IP_AUD, 3, 0,
>> 0),
>> +       GATE(AUD_CLK_I2S, "clk_i2s", "dout_aclk_aud_131", EN_IP_AUD, 2, 0,
>> 0),
>> +       GATE(AUD_CLK_DMAC, "clk_dmac", "dout_aclk_aud_131",
>> +                       EN_IP_AUD, 1, 0, 0),
>> +       GATE(ID_NONE, "clk_sramc", "dout_aclk_aud_131", EN_IP_AUD, 0, 0,
>> 0),
>> +
>> +       GATE(AUD_SCLK_AUD_UART, "sclk_aud_uart", "dout_sclk_aud_uart",
>> +                       EN_SCLK_AUD, 2, 0, 0),
>> +       GATE(AUD_SCLK_PCM, "sclk_aud_pcm", "dout_sclk_aud_pcm",
>> +                       EN_SCLK_AUD, 1, 0, 0),
>> +       GATE(AUD_SCLK_I2S, "sclk_aud_i2s", "dout_sclk_aud_i2s",
>> +                       EN_SCLK_AUD, 0, 0, 0),
>
>
> Shouldn't all the sclk's above have CLK_SET_RATE_PARENT flags to let
> consumer drivers change divisors of parent dividers? The same comment for
> remaining SCLK gates further in the file.
>

Added to all sclks.

>
>> +};
>> +
>> +/*
>> + * List of Gate clocks for CMU_DISP
>> +*/
>> +struct samsung_gate_clock exynos5260_disp_gate_clks[] __initdata = {
>> +       GATE(DISP_CLK_SMMU_TV, "clk_smmu3_tv", "mout_aclk_disp_222_user",
>> +                       EN_IP_DISP, 25, 0, 0),
>> +       GATE(DISP_CLK_SMMU_FIMD1M1, "clk_smmu3_fimd1m1",
>> +                       "mout_aclk_disp_222_user",
>> +                       EN_IP_DISP, 23, 0, 0),
>> +       GATE(DISP_CLK_SMMU_FIMD1M0, "clk_smmu3_fimd1m0",
>> +                       "mout_aclk_disp_222_user",
>> +                       EN_IP_DISP, 22, 0, 0),
>> +       GATE(ID_NONE, "clk_pixel_mixer", "mout_aclk_disp_222_user",
>> +                       EN_IP_DISP, 13, CLK_IGNORE_UNUSED, 0),
>> +       GATE(ID_NONE, "clk_pixel_disp", "mout_aclk_disp_222_user",
>> +                       EN_IP_DISP, 12, CLK_IGNORE_UNUSED, 0),
>
>
> Why CLK_IGNORE_UNUSED?

these clocks are required for correct representation of clock tree but they are
not enabled by the drivers. like sclk_uart clock is only used for set rate and
never enable by the driver. Second category is clock like lpddr which will be
used by mif dvfs for lpddr only. These needs to left ingnored for Non lpddr
boards. I treid to kept them to minimum.

>
>
>> +       GATE(DISP_CLK_MIXER, "clk_mixer", "mout_aclk_disp_222_user",
>> +                       EN_IP_DISP, 11, 0, 0),
>> +       GATE(DISP_CLK_MIPIPHY, "clk_mipi_dphy", "mout_aclk_disp_222_user",
>> +                       EN_IP_DISP, 10, 0, 0),
>> +       GATE(DISP_CLK_HDMIPHY, "clk_hdmiphy", "mout_aclk_disp_222_user",
>> +                       EN_IP_DISP, 9, 0, 0),
>> +       GATE(DISP_CLK_HDMI, "clk_hdmi", "mout_aclk_disp_222_user",
>> +                       EN_IP_DISP, 8, 0, 0),
>> +       GATE(DISP_CLK_FIMD1, "clk_fimd1", "mout_aclk_disp_222_user",
>> +                       EN_IP_DISP, 7, 0, 0),
>> +       GATE(DISP_CLK_DSIM1, "clk_dsim1", "mout_aclk_disp_222_user",
>> +                       EN_IP_DISP, 6, 0, 0),
>> +       GATE(DISP_CLK_DPPHY, "clk_dptx_phy", "mout_aclk_disp_222_user",
>> +                       EN_IP_DISP, 5, 0, 0),
>> +       GATE(DISP_CLK_DP, "clk_dptx_link", "mout_aclk_disp_222_user",
>> +                       EN_IP_DISP, 4, 0, 0),
>> +
>> +       GATE(DISP_SCLK_PIXEL, "sclk_hdmi_phy_pixel_clki",
>> +                       "dout_sclk_hdmi_phy_pixel_clki",
>> +                       EN_SCLK_DISP0, 29, 0, 0),
>> +       GATE(DISP_SCLK_HDMI, "sclk_hdmi_link_i_pixel",
>> +                       "mout_phyclk_hdmi_phy_pixel_clko_user",
>> +                       EN_SCLK_DISP0, 26, 0, 0),
>> +};
>> +
>> +/*
>> + * List of Gate clocks for CMU_EGL
>> +*/
>> +struct samsung_gate_clock exynos5260_egl_gate_clks[] __initdata = {
>> +};
>
>
> Empty array.
>
removed.

>
>> +
>> +/*
>> + * List of Gate clocks for CMU_FSYS
>
>
> [snip]
>
>
>> +
>> +/*
>> +* Applicable for all 2550 Type PLLS for Exynos5260, listed below
>> +* DISP_PLL, EGL_PLL, KFC_PLL, MEM_PLL,
>> +* BUS_PLL, MEDIA_PLL, G3D_PLL.
>> +*/
>> +static const struct samsung_pll_rate_table exynos5260_pll2550_24mhz_tbl[]
>> = {
>> +       PLL_35XX_RATE(1700000000, 425, 6, 0),
>> +       PLL_35XX_RATE(1600000000, 200, 3, 0),
>> +       PLL_35XX_RATE(1500000000, 250, 4, 0),
>> +       PLL_35XX_RATE(1400000000, 175, 3, 0),
>> +       PLL_35XX_RATE(1300000000, 325, 6, 0),
>> +       PLL_35XX_RATE(1200000000, 400, 4, 1),
>> +       PLL_35XX_RATE(1100000000, 275, 3, 1),
>> +       PLL_35XX_RATE(1000000000, 250, 3, 1),
>> +       PLL_35XX_RATE(933000000, 311, 4, 1),
>> +       PLL_35XX_RATE(900000000, 300, 4, 1),
>> +       PLL_35XX_RATE(800000000, 200, 3, 1),
>> +       PLL_35XX_RATE(733000000, 733, 12, 1),
>> +       PLL_35XX_RATE(700000000, 175, 3, 1),
>> +       PLL_35XX_RATE(667000000, 667, 12, 1),
>> +       PLL_35XX_RATE(633000000, 211, 4, 1),
>> +       PLL_35XX_RATE(620000000, 310, 3, 2),
>> +       PLL_35XX_RATE(600000000, 400, 4, 2),
>> +       PLL_35XX_RATE(543000000, 362, 4, 2),
>> +       PLL_35XX_RATE(533000000, 533, 6, 2),
>> +       PLL_35XX_RATE(500000000, 250, 3, 2),
>> +       PLL_35XX_RATE(450000000, 300, 4, 2),
>> +       PLL_35XX_RATE(400000000, 200, 3, 2),
>> +       PLL_35XX_RATE(350000000, 175, 3, 2),
>> +       PLL_35XX_RATE(300000000, 400, 4, 3),
>> +       PLL_35XX_RATE(266000000, 266, 3, 3),
>> +       PLL_35XX_RATE(200000000, 200, 3, 3),
>> +       PLL_35XX_RATE(160000000, 160, 3, 3),
>
>
> Are all of those exact values, without any (incorrect) rounding? This is
> imporant for the rate setting code to work correctly.
>

I verfied; all of them are correct other than this:
PLL_36XX_RATE(394216000, 459, 7, 2, 49282),

Its computed values is coming to be 394073128. I will replace
394216000 with 394073128 in the above entry.

>
>> +};
>> +
>> +/*
>> +* Applicable for 2650 Type PLL for AUD_PLL.
>> +*/
>> +static const struct samsung_pll_rate_table exynos5260_pll2650_24mhz_tbl[]
>> = {
>> +       PLL_36XX_RATE(1600000000, 200, 3, 0, 0),
>> +       PLL_36XX_RATE(1200000000, 100, 2, 0, 0),
>> +       PLL_36XX_RATE(1000000000, 250, 3, 1, 0),
>> +       PLL_36XX_RATE(800000000, 200, 3, 1, 0),
>> +       PLL_36XX_RATE(600000000, 100, 2, 1, 0),
>> +       PLL_36XX_RATE(532000000, 266, 3, 2, 0),
>> +       PLL_36XX_RATE(480000000, 160, 2, 2, 0),
>> +       PLL_36XX_RATE(432000000, 144, 2, 2, 0),
>> +       PLL_36XX_RATE(400000000, 200, 3, 2, 0),
>> +       PLL_36XX_RATE(394216000, 459, 7, 2, 49282),
>> +       PLL_36XX_RATE(333000000, 111, 2, 2, 0),
>> +       PLL_36XX_RATE(300000000, 100, 2, 2, 0),
>> +       PLL_36XX_RATE(266000000, 266, 3, 3, 0),
>> +       PLL_36XX_RATE(200000000, 200, 3, 3, 0),
>> +       PLL_36XX_RATE(166000000, 166, 3, 3, 0),
>> +       PLL_36XX_RATE(133000000, 266, 3, 4, 0),
>> +       PLL_36XX_RATE(100000000, 200, 3, 4, 0),
>> +       PLL_36XX_RATE(66000000, 176, 2, 5, 0),
>
>
> Ditto.
>
>> +};
>> +
>
>
> [snip]
>
>
>> +void __init exynos5260_clk_aud_init(struct device_node *np)
>
>
> static void
>
>
>> +{
>> +       void __iomem *reg_base;
>> +       static unsigned long *rdump;
>
>
> Static?
>
done.
>
>> +       struct samsung_clk_provider *ctx;
>> +       unsigned long nr_rdump;
>> +
>> +       if (!np)
>> +               panic("%s: unable to determine cmu\n", __func__);
>
>
> Can't happen. This function will be only called if a matching node is found
> in DT.
>

Removed.

>
>> +
>> +       reg_base = of_iomap(np, 0);
>> +       if (!reg_base)
>> +               panic("%s: failed to map registers\n", __func__);
>> +
>> +       rdump = exynos5260_aud_clk_regs;
>> +       nr_rdump = ARRAY_SIZE(exynos5260_aud_clk_regs);
>
>
> You can use those two directly, without creating variables for them.
>
>
>> +
>> +       ctx = samsung_clk_init(np, reg_base, AUD_NR_CLK);
>> +       if (!ctx)
>> +               panic("%s: unable to alllocate ctx\n", __func__);
>> +
>> +       samsung_clk_register_mux(ctx, exynos5260_aud_mux_clks,
>> +               ARRAY_SIZE(exynos5260_aud_mux_clks));
>> +       samsung_clk_register_div(ctx, exynos5260_aud_div_clks,
>> +               ARRAY_SIZE(exynos5260_aud_div_clks));
>> +       samsung_clk_register_gate(ctx, exynos5260_aud_gate_clks,
>> +               ARRAY_SIZE(exynos5260_aud_gate_clks));
>> +
>> +       exynos5260_clk_sleep_init(reg_base, rdump, nr_rdump);
>> +}
>> +
>> +void __init exynos5260_clk_disp_init(struct device_node *np)
>> +{
>> +       void __iomem *reg_base;
>> +       static unsigned long *rdump;
>> +       struct samsung_clk_provider *ctx;
>> +       unsigned long nr_rdump;
>> +
>> +       if (!np)
>> +               panic("%s: unable to determine cmu\n", __func__);
>> +
>> +       reg_base = of_iomap(np, 0);
>> +       if (!reg_base)
>> +               panic("%s: failed to map registers\n", __func__);
>> +
>> +       rdump = exynos5260_disp_clk_regs;
>> +       nr_rdump = ARRAY_SIZE(exynos5260_disp_clk_regs);
>> +
>> +       ctx = samsung_clk_init(np, reg_base, DISP_NR_CLK);
>> +       if (!ctx)
>> +               panic("%s: unable to alllocate ctx\n", __func__);
>> +
>> +       samsung_clk_register_mux(ctx, exynos5260_disp_mux_clks,
>> +               ARRAY_SIZE(exynos5260_disp_mux_clks));
>> +       samsung_clk_register_div(ctx, exynos5260_disp_div_clks,
>> +               ARRAY_SIZE(exynos5260_disp_div_clks));
>> +       samsung_clk_register_gate(ctx, exynos5260_disp_gate_clks,
>> +               ARRAY_SIZE(exynos5260_disp_gate_clks));
>> +
>> +       exynos5260_clk_sleep_init(reg_base, rdump, nr_rdump);
>> +}
>
>
> Hmm, instead of repeating almost exactly the same function for each CMU,
> wouldn't it be better to simply write a single parametrized one?
>
> What about creating a struct like this:
>
> struct exynos5260_cmu_type {
>         unsigned long *rdump;
>         unsigned long nr_rdump;
>
>         unsigned int nr_clks;
>
>         struct samsung_mux_clock *mux_clks;
>         unsigned int nr_mux_clks;
>         /* Same for remaining clock types. */
> };
>
> and then defining instances for all the needed CMUs and passing a pointer to
> such struct to a generic registering function?
>

Changed.

>
>> +
>> +void __init exynos5260_clk_egl_init(struct device_node *np)
>> +{
>> +       void __iomem *reg_base;
>
>
> [snip]
>
>
>> +struct of_device_id __clk_of_table_exynos5260[]
>> +               __used __section(__clk_of_table) = {
>
>
> I don't think this is a good idea. This construct should not be used
> directly. This is what CLK_OF_DECLARE() macro is for.
>
> If you define a struct as mentioned above for every CMU, then you should end
> up with following code:
>
> static const struct exynos5260_cmu_type cmu_xxx = {
>         // ...
> };
>
> static void __init cmu_xxx_init(struct device_node *np)
> {
>         exynos5260_cmu_register_one(np, &cmu_xxx);
> }
> CLK_OF_DECLARE(cmu_xxx, "samsung,exynos5260-clock-xxx", cmu_xxx_init);
>

I will be filling cmu_xxx struct in cmu_xxx_init. I hope that is fine.

> for every CMU type, which still needs some duplication, but should be much
> less than in current form.
>
> Also it would be nice to group definitions for particular CMUs together,
> e.g.
>
> /* CMU XXX */
> // regs
> // fixed rate
> // muxes
> // dividers
> // gates
> // plls
> // struct exynos5260_cmu_type
> // cmu_xxx_init()
>
> /* CMU YYY */
> ...
>
> This should improve readability of the driver, as definitions for different
> IP blocks would not be intermingled.
>
ok.

> [snip]
>
>
>> diff --git a/drivers/clk/samsung/clk-exynos5260.h
>> b/drivers/clk/samsung/clk-exynos5260.h
>> new file mode 100644
>> index 0000000..392c152
>> --- /dev/null
>> +++ b/drivers/clk/samsung/clk-exynos5260.h
>> @@ -0,0 +1,480 @@
>> +#ifndef __CLK_EXYNOS5260_H
>> +#define __CLK_EXYNOS5260_H
>> +
>> +/*
>> +*Base address for different CMUs
>> +*TODO: All Bases should be removed at earliest.
>
>
> True, very true. Please remove them in next version ;).
>

ok :).
>
>> +*/
>> +#define CMU_AUD_BASE   0x128C0000
>> +#define CMU_DISP_BASE  0x14550000
>> +#define CMU_EGL_BASE   0x10600000
>> +#define CMU_FSYS_BASE  0x122E0000
>> +#define CMU_G2D_BASE   0x10A00000
>> +#define CMU_G3D_BASE   0x11830000
>> +#define CMU_GSCL_BASE  0x13F00000
>> +#define CMU_ISP_BASE   0x133C0000
>> +#define CMU_KFC_BASE   0x10700000
>> +#define CMU_MFC_BASE   0x11090000
>> +#define CMU_MIF_BASE   0x10CE0000
>> +#define CMU_PERI_BASE  0x10200000
>> +#define CMU_TOP_BASE   0x10010000
>> +
>> +#define AUD_REG(x)             (x)
>> +#define DISP_REG(x)            (x)
>> +#define EGL_REG(x)             (x)
>> +#define FSYS_REG(x)            (x)
>> +#define G2D_REG(x)             (x)
>> +#define G3D_REG(x)             (x)
>> +#define GSCL_REG(x)            (x)
>> +#define ISP_REG(x)             (x)
>> +#define KFC_REG(x)             (x)
>> +#define MFC_REG(x)             (x)
>> +#define MIF_REG(x)             (x)
>> +#define PERI_REG(x)            (x)
>> +#define TOP_REG(x)             (x)
>> +
>> +/*
>> +*Registers for CMU_AUD
>> +*/
>> +#define MUX_SEL_AUD            AUD_REG(0x0200)
>> +#define MUX_ENABLE_AUD         AUD_REG(0x0300)
>> +#define MUX_STAT_AUD           AUD_REG(0x0400)
>> +#define MUX_IGNORE_AUD         AUD_REG(0x0500)
>> +#define DIV_AUD0               AUD_REG(0x0600)
>> +#define DIV_AUD1               AUD_REG(0x0604)
>> +#define DIV_STAT_AUD0          AUD_REG(0x0700)
>> +#define DIV_STAT_AUD1          AUD_REG(0x0704)
>> +#define EN_ACLK_AUD            AUD_REG(0x0800)
>> +#define EN_PCLK_AUD            AUD_REG(0x0900)
>> +#define EN_SCLK_AUD            AUD_REG(0x0a00)
>> +#define EN_IP_AUD              AUD_REG(0x0b00)
>
>
> No need to use XXX_REG() macros, simple offsets are enough. Also I don't
> think there is a need to have a separate header for these definitions used
> just by one source file. They can be safely moved there.
>

Fine. I will changes this.

Regards,
Rahul Sharma


> Best regards,
> Tomasz
