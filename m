From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 4 Feb 2013 16:07:55 +0200
Subject: [PATCH v5 09/10] clk: tegra: Implement clocks for Tegra114
In-Reply-To: <20130204104531.GQ2364@tbergstrom-lnx.Nvidia.com>
References: <1359713962-16822-1-git-send-email-pdeschrijver@nvidia.com>
 <1359713962-16822-10-git-send-email-pdeschrijver@nvidia.com>
 <510F5E87.90801@nvidia.com>
 <20130204104531.GQ2364@tbergstrom-lnx.Nvidia.com>
Message-ID: <20130204140755.GU2364@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 11:45:31AM +0100, Peter De Schrijver wrote:
> On Mon, Feb 04, 2013 at 08:08:55AM +0100, Prashant Gaikwad wrote:

...

> > > +
> > > +       /* dsia */
> > > +       clk = clk_register_mux(NULL, "dsia_mux", mux_plld_out0_plld2_out0,
> > > +                              ARRAY_SIZE(mux_plld_out0_plld2_out0), 0,
> > > +                              clk_base + PLLD_BASE, 25, 1, 0, &pll_d_lock);
> > > +       clks[dsia_mux] = clk;
> > > +       clk = tegra_clk_register_periph_gate("dsia", "dsia_mux", 0, clk_base,
> > > +                                   0, 48, &periph_h_regs,
> > > +                                   periph_clk_enb_refcnt);
> > > +       clk_register_clkdev(clk, "dsia", "tegradc.0");
> > > +       clks[dsia] = clk;
> > > +
> > > +       /* dsib */
> > > +       clk = clk_register_mux(NULL, "dsib_mux", mux_plld_out0_plld2_out0,
> > > +                              ARRAY_SIZE(mux_plld_out0_plld2_out0), 0,
> > > +                              clk_base + PLLD2_BASE, 25, 1, 0, &pll_d2_lock);
> > > +       clks[dsib_mux] = clk;
> > > +       clk = tegra_clk_register_periph_gate("dsib", "dsib_mux", 0, clk_base,
> > > +                                   0, 82, &periph_u_regs,
> > > +                                   periph_clk_enb_refcnt);
> > > +       clk_register_clkdev(clk, "dsib", "tegradc.1");
> > > +       clks[dsib] = clk;
> > > +
> > 
> > Can we use periph no div clock here for dsia and dsib?
> > 
> 
> Will check.
> 

Not as such. As you can see the muxes need a lock to protect access to the
PLLD_BASE and PLLD2_BASE registers respectively. The periph no div clock
doesn't provide for these locks though. Do you think it makes sense to add
the lock support for these 2 clocks?

Cheers,

Peter.
