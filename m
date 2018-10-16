From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 16 Oct 2018 14:18:31 -0700
Subject: [PATCH V4 05/11] clk: imx: scu: add scu clock gate
In-Reply-To: <AM0PR04MB42111FD6D3542E12250E556880FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-6-git-send-email-aisheng.dong@nxp.com>
 <20181015073207.66npcgegibl2rybb@pengutronix.de>
 <AM0PR04MB4211129386C9088C6AFEDAF580FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181015095342.kjokajxyugugbtcw@pengutronix.de>
 <AM0PR04MB42111FD6D3542E12250E556880FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <153972471150.5275.14761857440358508106@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-10-15 08:30:45)
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > Sent: Monday, October 15, 2018 5:54 PM
> > To: A.s. Dong <aisheng.dong@nxp.com>
> > Cc: linux-clk at vger.kernel.org; sboyd at kernel.org; mturquette at baylibre.com;
> > dl-linux-imx <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> > <fabio.estevam@nxp.com>; shawnguo at kernel.org;
> > linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH V4 05/11] clk: imx: scu: add scu clock gate
> > 
> > On Mon, Oct 15, 2018 at 09:17:14AM +0000, A.s. Dong wrote:
> > > > -----Original Message-----
> > > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > > > Sent: Monday, October 15, 2018 3:32 PM
> > > > To: A.s. Dong <aisheng.dong@nxp.com>
> > > > Cc: linux-clk at vger.kernel.org; sboyd at kernel.org;
> > > > mturquette at baylibre.com; dl-linux-imx <linux-imx@nxp.com>;
> > > > kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > > > shawnguo at kernel.org; linux-arm-kernel at lists.infradead.org
> > > > Subject: Re: [PATCH V4 05/11] clk: imx: scu: add scu clock gate
> > > >
> > > > On Sun, Oct 14, 2018 at 08:07:56AM +0000, A.s. Dong wrote:
> > > > > +/* Write to the LPCG bits. */
> > > > > +static int clk_gate_scu_enable(struct clk_hw *hw) {
> > > > > +       struct clk_gate_scu *gate = to_clk_gate_scu(hw);
> > > > > +       u32 reg;
> > > > > +
> > > > > +       if (gate->reg) {
> > > > > +               reg = readl(gate->reg);
> > > > > +               reg &= ~(CLK_GATE_SCU_LPCG_MASK << gate->bit_idx);
> > > > > +               if (gate->hw_gate)
> > > > > +                       reg |= (CLK_GATE_SCU_LPCG_HW_SEL |
> > > > > +                               CLK_GATE_SCU_LPCG_SW_SEL) << gate->bit_idx;
> > > > > +               else
> > > > > +                       reg |= (CLK_GATE_SCU_LPCG_SW_SEL << gate->bit_idx);
> > > > > +               writel(reg, gate->reg);
> > > > > +       }
> > > >
> > > > These register manipulations look like they need locking.
> > > >
> > >
> > > Unlike the legacy MX6&7 SoCs, each clock has a separate LPCG register.
> > > Do we still need locking?
> > 
> > Let's take PWM_0_LPCG as an example:
> > 
> > +       clks[IMX8QXP_LSIO_PWM0_IPG_S_CLK]       =
> > imx_clk_gate_scu("pwm_0_ipg_s_clk", "pwm_0_div", IMX_SC_R_PWM_0,
> > IMX_SC_PM_CLK_PER, (void __iomem *)(PWM_0_LPCG), 0x10, 0);
> > +       clks[IMX8QXP_LSIO_PWM0_IPG_SLV_CLK]     =
> > imx_clk_gate_scu("pwm_0_ipg_slv_clk", "pwm_0_ipg_s_clk",
> > IMX_SC_R_PWM_0, IMX_SC_PM_CLK_PER, (void __iomem *)(PWM_0_LPCG),
> > 0x14, 0);
> > +       clks[IMX8QXP_LSIO_PWM0_IPG_MSTR_CLK]    =
> > imx_clk_gate2_scu("pwm_0_ipg_mstr_clk", "lsio_bus_clk_root", (void
> > __iomem *)(PWM_0_LPCG), 0x18, 0);
> > +       clks[IMX8QXP_LSIO_PWM0_HF_CLK]          =
> > imx_clk_gate_scu("pwm_0_hf_clk", "pwm_0_ipg_slv_clk", IMX_SC_R_PWM_0,
> > IMX_SC_PM_CLK_PER, (void __iomem *)(PWM_0_LPCG), 4, 0);
> > +       clks[IMX8QXP_LSIO_PWM0_CLK]             =
> > imx_clk_gate_scu("pwm_0_clk", "pwm_0_ipg_slv_clk", IMX_SC_R_PWM_0,
> > IMX_SC_PM_CLK_PER, (void __iomem *)(PWM_0_LPCG), 0, 0);
> > 
> > This register is used in five different clocks.
> > 
> 
> Good catch.
> BTW, it seems for the same clk group, we may still not need lock
> as the clock framework already defined the global enable/disable lock
> for the same group.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/driver-api/clk.rst
> " Drivers don't need to manually protect resources shared between the operations
> of one group, regardless of whether those resources are shared by multiple
> clocks or not. However, access to resources that are shared between operations
> of the two groups needs to be protected by the drivers."
> 
> Do you think it's okay to drop it?
> 

No it's not OK. We prefer that clk drivers don't assume the global locks
in the clk framework are going to protect them from concurrent access to
the same resource between different clks. Drivers can assume that a clk
op won't be called in parallel for the same clk, but they shouldn't
assume that everything is protected otherwise. If they did, we would
have to go find all the drivers that make this assumption and then fix
them when we eventually split the lock into smaller pieces.

Long story short, if you have something shared (i.e. a register) and you
plan to write to it and read from it for multiple clks, add a lock
around it.
