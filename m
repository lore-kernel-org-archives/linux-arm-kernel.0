From: dinguyen@altera.com (Dinh Nguyen)
Date: Tue, 19 Mar 2013 13:45:50 -0500
Subject: [PATCHv2 2/2] ARM: socfpga: Add clock entries into device tree
In-Reply-To: <20130319164638.8663.89508@quantum>
References: <1363707936-17769-1-git-send-email-dinguyen@altera.com>
 <1363707936-17769-2-git-send-email-dinguyen@altera.com>
 <20130319164638.8663.89508@quantum>
Message-ID: <1363718750.17844.5.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Tue, 2013-03-19 at 09:46 -0700, Mike Turquette wrote:
> Quoting dinguyen at altera.com (2013-03-19 08:45:36)
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Adds the main PLL clock groups for SOCFPGA into device tree file
> > so that the clock framework to query the clock and clock rates
> > appropriately.
> > 
> > $cat /sys/kernel/debug/clk/clk_summary
> >    clock                        enable_cnt  prepare_cnt  rate
> > ---------------------------------------------------------------------
> >  osc1                           2           2            25000000
> >     sdram_pll                   0           0            400000000
> >        s2f_usr2_clk             0           0            66666666
> >        ddr_dq_clk               0           0            200000000
> >        ddr_2x_dqs_clk           0           0            400000000
> >        ddr_dqs_clk              0           0            200000000
> >     periph_pll                  2           2            500000000
> >        s2f_usr1_clk             0           0            50000000
> >        per_base_clk             4           4            100000000
> >        per_nand_mmc_clk         0           0            25000000
> >        per_qsi_clk              0           0            250000000
> >        emac1_clk                1           1            125000000
> >        emac0_clk                0           0            125000000
> >     main_pll                    1           1            1600000000
> >        cfg_s2f_usr0_clk         0           0            100000000
> >        main_nand_sdmmc_clk      0           0            100000000
> >        main_qspi_clk            0           0            400000000
> >        dbg_base_clk             0           0            400000000
> >        mainclk                  0           0            400000000
> >        mpuclk                   1           1            800000000
> >           smp_twd               1           1            200000000
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> 
> There is a lot going on in this one patch.  I would prefer to see the
> clock driver broken out separately.

Not sure what you mean by breaking out the clock driver separately. The
patch is only touching the clocks for mach-socfpga.

The patch is
7 files changed, 366 insertions(+), 21 deletions(-)

while the patch to enable clk-highbank was:
8 files changed, 463 insertions(+), 64 deletions(-)

> <snip>
> 
> > diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
> > index 2c855a6..da6b461 100644
> > --- a/drivers/clk/socfpga/clk.c
> > +++ b/drivers/clk/socfpga/clk.c
> <snip>
> > +static int clk_pll_enable(struct clk_hw *hwclk)
> > +{
> > +       struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
> > +       u32 reg;
> > +
> > +       reg = readl(socfpgaclk->reg);
> > +       reg |= SOCFPGA_PLL_EXT_ENA;
> > +       writel(reg, socfpgaclk->reg);
> > +
> > +       return 0;
> > +}
> > +
> > +static void clk_pll_disable(struct clk_hw *hwclk)
> >  {
> > +       struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
> > +       u32 reg;
> > +
> > +       reg = readl(socfpgaclk->reg);
> > +       reg &= ~SOCFPGA_PLL_EXT_ENA;
> > +       writel(reg, socfpgaclk->reg);
> > +}
> > +
> 
> For a simple enable which just sets a bit, you might want to re-use the
> basic gate clock type.  This can be done similar to the composite clock
> patches (currently on the list) by stuffing a clk_gate structure into
> your custom socfpga_clk type.

I'll take a look at the list about this.

Thanks for the review.

Dinh
> 
> Regards,
> Mike
> 
