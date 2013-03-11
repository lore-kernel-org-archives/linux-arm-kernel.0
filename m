From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 11 Mar 2013 11:25:26 +0200
Subject: [PATCH v6 09/10] clk: tegra: Implement clocks for Tegra114
In-Reply-To: <643E69AA4436674C8F39DCC2C05F7638629CA50CB4@HQMAIL03.nvidia.com>
References: <1360580700-10245-1-git-send-email-pdeschrijver@nvidia.com>
 <1360580700-10245-10-git-send-email-pdeschrijver@nvidia.com>
 <643E69AA4436674C8F39DCC2C05F7638629CA50CB4@HQMAIL03.nvidia.com>
Message-ID: <20130311092526.GX27241@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 12:51:16AM +0100, Andrew Chew wrote:
> > From: linux-tegra-owner at vger.kernel.org [mailto:linux-tegra-
> > owner at vger.kernel.org] On Behalf Of Peter De Schrijver
> > Sent: Monday, February 11, 2013 3:05 AM
> > To: Peter De Schrijver
> > Cc: linux-arm-kernel at lists.infradead.org; linux-tegra at vger.kernel.org
> > Subject: [PATCH v6 09/10] clk: tegra: Implement clocks for Tegra114
> >
> > Implement clocks for Tegra114.
> >
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> >  drivers/clk/tegra/Makefile       |    1 +
> >  drivers/clk/tegra/clk-tegra114.c | 2036
> > ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 2037 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/clk/tegra/clk-tegra114.c
> >
> > diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> > index 2b41b0f..f49fac2 100644
> > --- a/drivers/clk/tegra/Makefile
> > +++ b/drivers/clk/tegra/Makefile
> > @@ -9,3 +9,4 @@ obj-y                                 += clk-
> > super.o
> >
> >  obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
> >  obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
> > +obj-$(CONFIG_ARCH_TEGRA_114_SOC)     += clk-tegra114.o
> > diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
> > new file mode 100644
> > index 0000000..cd50c18
> > --- /dev/null
> > +++ b/drivers/clk/tegra/clk-tegra114.c
> 
> *snip for brevity*
> 
> > +static __initdata struct tegra_periph_init_data tegra_periph_clk_list[] = {
> 
> I don't think this should be marked as __initdata.  The stuff in this list
> contain clock instances that are referenced after init.
> 

This is true indeed. Interesting that the build checks didn't catch this...

...

> > +     TEGRA_INIT_DATA_MUX("sdmmc4", NULL, "sdhci-tegra.3",
> > mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC4, 15, &periph_l_regs, 0,
> > sdmmc4),
> > +     TEGRA_INIT_DATA_INT("vde", NULL, "vde",
> > mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_VDE, 61, &periph_h_regs, 0,
> > vde),
> > +     TEGRA_INIT_DATA_MUX("csite", NULL, "csite",
> > mux_pllp_pllc_pllm_clkm, CLK_SOURCE_CSITE, 73, &periph_u_regs,
> > TEGRA_PERIPH_ON_APB, csite),
> 
> The csite clock needs to be marked CLK_IGNORE_UNUSED, otherwise
> drivers/clk/clk.c's clk_disable_unused() will disable it after init, and JTAG
> won't work after that point.
> 

Ok.

> > +     TEGRA_INIT_DATA_MUX("la", NULL, "la", mux_pllp_pllc_pllm_clkm,
> > CLK_SOURCE_LA, 76, &periph_u_regs, TEGRA_PERIPH_ON_APB, la),
> > +     TEGRA_INIT_DATA_MUX("trace", NULL, "trace",

...

> > CLK_SOURCE_DAM1, 109, &periph_v_regs, TEGRA_PERIPH_ON_APB,
> > dam1),
> > +     TEGRA_INIT_DATA_AUDIO("dam2", NULL, "tegra30-dam.2",
> > CLK_SOURCE_DAM2, 110, &periph_v_regs, TEGRA_PERIPH_ON_APB,
> > dam2),
> > +};
> > +
> > +static __initdata struct tegra_periph_init_data
> > tegra_periph_nodiv_clk_list[] = {
> 
> I don't think this should be marked as __initdata.  The stuff in this list
> contain clock instances that are referenced after init.
> 

This is probably the same as tegra_periph_clk_listp[] then.

> > +     TEGRA_INIT_DATA_NODIV("disp1", NULL, "tegradc.0",
> > mux_pllp_pllm_plld_plla_pllc_plld2_clkm, CLK_SOURCE_DISP1, 29, 3, 27,
> > &periph_l_regs, 0, disp1),
> > +     TEGRA_INIT_DATA_NODIV("disp2", NULL, "tegradc.1",
> > mux_pllp_pllm_plld_plla_pllc_plld2_clkm, CLK_SOURCE_DISP2, 29, 3, 26,
> > &periph_l_regs, 0, disp2),
> 
> For disp1 and disp2, the mux mask should be 7, not 3.
> 

Ok. Makes sene...

> > +};
> > +
> > +static __init void tegra114_periph_clk_init(void __iomem *clk_base)
> > +{
> > +     struct tegra_periph_init_data *data;
> > +     struct clk *clk;
> > +     int i;
> > +     u32 val;
> > +

...

> > +
> > +     for (i = 0; i < ARRAY_SIZE(tegra_periph_nodiv_clk_list); i++) {
> > +             data = &tegra_periph_nodiv_clk_list[i];
> > +             clk = tegra_clk_register_periph_nodiv(data->name,
> > +                             data->parent_names, data->num_parents,
> > +                             &data->periph, clk_base, data->offset);
> > +             clks[data->clk_id] = clk;
> > +     }
> > +}
> 
> Shouldn't we call clk_register_clkdev for each of these clocks?
> 

No. We switched to DT bindings for all our clocks now. So drivers should use
of_clk_get().

Cheers,

Peter.
