From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Sep 2013 21:26:02 +0800
Subject: device tree binding documentation outdated
In-Reply-To: <20130927121357.GY12758@n2100.arm.linux.org.uk>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <20130926205906.GT12758@n2100.arm.linux.org.uk>
 <CAOMZO5Dj7o3qBH2hzPFWjepgpt5XR5qKmQorKS6jH_7=gnY5cg@mail.gmail.com>
 <20130927121357.GY12758@n2100.arm.linux.org.uk>
Message-ID: <20130927132601.GL25146@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 01:13:57PM +0100, Russell King - ARM Linux wrote:
> There's also this which follows the above:
> 
> +       /* Set enet clock to 50MHz RMII */
> +       enet = clk_get_sys("enet.0", NULL);
> +       if (IS_ERR(enet))
> +               pr_err("Unable to get enet.0 clock\n");

I can not find clock lookup for "enet.0" in FSL 3.0.35 BSP 4.1.0, so
I'm not sure how this works at all.  Can you confirm that by running
Rabeeh's kernel to see if you get that error message?

> +       else {
> +               clk_prepare(enet);
> +               clk_set_rate(enet, 50000000);
> +               clk_enable(enet);
> +       }
> 
> I'm not sure at the moment which clock that refers to, or whether that's
> necessary only for the AR8030 (which is used in RMII mode).  The enable
> bit seems to be CCM_CCGR1 CG5_OFFSET.

There are two clocks ENET related, 'enet' (117) and 'enet_ref' (190).
The enet is fec internal working clock, and enet_ref is provided by
imx6q CCM (Clock Controller Module) on pad ENET_REF_CLK which can
generally be used to clock the external PHY.

The CCM_CCGR1_CG5 is clock 'enet', while I think the clock in above
code should be 'enet_ref'.  It seems you need to set up
MX6QDL_PAD_GPIO_16__ENET_REF_CLK to use the clock though.

> Even when I work out how that
> relates to the mass of clock initialisations in
> arch/arm/mach-imx/clk-imx6q.c, it's virtually impossible to translate
> that into a DT <&clks N> representation because of this:
> 
> enum mx6q_clks {
>         dummy, ckil, ckih, osc, pll2_pfd0_352m, pll2_pfd1_594m, pll2_pfd2_396m,
>         pll3_pfd0_720m, pll3_pfd1_540m, pll3_pfd2_508m, pll3_pfd3_454m,
>         pll2_198m, pll3_120m, pll3_80m, pll3_60m, twd, step, pll1_sw,
>         periph_pre, periph2_pre, periph_clk2_sel, periph2_clk2_sel, axi_sel,

The imx6q clock was created before DTC macro support is available, so we
have to cross check Documentation/devicetree/bindings/clock/imx6q-clock.txt
to interpret the clocks.  The imx6sl clock driver below is an example to
see how DTC macro helps there.

  arch/arm/mach-imx/clk-imx6sl.c
  include/dt-bindings/clock/imx6sl-clock.h

Shawn
