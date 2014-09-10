From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Wed, 10 Sep 2014 07:43:41 +0000
Subject: [PATCH V2 3/3] ARM: imx: source gpt per clk from OSC for system
 timer
In-Reply-To: <20140910073333.GC22579@dragon>
References: <1409887606-22388-1-git-send-email-b20788@freescale.com>
 <1409887606-22388-4-git-send-email-b20788@freescale.com>
 <CAOMZO5CJLSXy3p-eAe9xOJw8p4gxoRuT91bXV8gswy5oMuU6XQ@mail.gmail.com>
 <5E619FDB-56BB-486E-B627-9D2A9D4F9F54@freescale.com>
 <20140910073333.GC22579@dragon>
Message-ID: <7fd82b8c08c54f4dadb6b7402231a086@BN1PR0301MB0628.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Shawn
	Please see below response:

Best regards!
Anson Huang


-----Original Message-----
From: Shawn Guo [mailto:shawn.guo at linaro.org] 
Sent: 2014-09-10 3:34 PM
To: Huang Yongcai-B20788
Cc: Fabio Estevam; Sascha Hauer; devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH V2 3/3] ARM: imx: source gpt per clk from OSC for system timer

On Fri, Sep 05, 2014 at 12:58:28PM +0000, Anson.Huang at freescale.com wrote:
> >> @@ -312,10 +318,26 @@ static void __init _mxc_timer_init(int irq,
> >>        __raw_writel(0, timer_base + MXC_TCTL);
> >>        __raw_writel(0, timer_base + MXC_TPRER); /* see datasheet 
> >> note */
> >> 
> >> -       if (timer_is_v2())
> >> -               tctl_val = V2_TCTL_CLK_PER | V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
> >> -       else
> >> +       if (timer_is_v2()) {
> >> +               if (((cpu_is_imx6q() && imx_get_soc_revision() >
> >> +                       IMX_CHIP_REVISION_1_0) || cpu_is_imx6dl() ||
> >> +                       cpu_is_imx6sx()) && (clk_get_rate(clk_per) ==
> >> +                       V2_TIMER_RATE_OSC_DIV8)) {
> >> +                       tctl_val = V2_TCTL_CLK_OSC_DIV8 | V2_TCTL_FRR |
> >> +                               V2_TCTL_WAITEN | MXC_TCTL_TEN;
> >> +                       if (cpu_is_imx6dl() || cpu_is_imx6sx()) {
> >> +                               /* 24 / 8 = 3 MHz */
> >> +                               tprer_val = 7 << V2_TPRER_PRE24M;
> >> +                               __raw_writel(tprer_val, timer_base + MXC_TPRER);
> >> +                               tctl_val |= V2_TCTL_24MEN;
> >> +                       }
> >> +               } else {
> >> +                       tctl_val = V2_TCTL_CLK_PER | V2_TCTL_FRR |
> >> +                               V2_TCTL_WAITEN | MXC_TCTL_TEN;
> >> +               }
> >> +       } else {
> >>                tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | 
> >> MXC_TCTL_TEN;
> >> +       }
> > 
> > Can this block be rearranged a bit so that it becomes easier to read?
> 
> I have to consider v1, v2, and on v2, MX6Q's implementation is different from MX6DL and MX6SX, MX6SL has its special implementation, and MX6Q has difference between TO1.0 and other TOs, also, we have to consider the old dtb case. So, there are more than 6 different cases we need to consider, I thought it was the best way I can figure out, could you advice if you have better idea?

[The lines should be wrapped around 70 columns]

I'm also a bit concerned by the readability of the code.  Can we reasonably assume it must be V2_TCTL_CLK_OSC_DIV8 case if
clk_get_rate(clk_per) returns 3000000?  In that case, the code can be simplified a bit, something like below.  Is it going to work?

Shawn

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c index 4ee6e77a0fdf..3f0401e27b38 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -245,6 +245,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
        clk[IMX6QDL_CLK_PLL3_80M]  = imx_clk_fixed_factor("pll3_80m",  "pll3_usb_otg",   1, 6);
        clk[IMX6QDL_CLK_PLL3_60M]  = imx_clk_fixed_factor("pll3_60m",  "pll3_usb_otg",   1, 8);
        clk[IMX6QDL_CLK_TWD]       = imx_clk_fixed_factor("twd",       "arm",            1, 2);
+       clk[IMX6QDL_CLK_GPT_3M]    = imx_clk_fixed_factor("gpt_3m",    "osc",            1, 8);
        if (cpu_is_imx6dl()) {
                clk[IMX6QDL_CLK_GPU2D_AXI] = imx_clk_fixed_factor("gpu2d_axi", "mmdc_ch0_axi_podf", 1, 1);
                clk[IMX6QDL_CLK_GPU3D_AXI] = imx_clk_fixed_factor("gpu3d_axi", "mmdc_ch0_axi_podf", 1, 1); @@ -469,6 +470,13 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)

        clk_register_clkdev(clk[IMX6QDL_CLK_ENET_REF], "enet_ref", NULL);

+       /*
+        * The gpt_3m clock is not available on i.MX6Q TO1.0.  Let's point it
+        * to clock gpt_ipg_per to ease the gpt driver code.
+        */
+       if (cpu_is_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_1_0)
+               clk[IMX6QDL_CLK_GPT_3M] = clk[IMX6QDL_CLK_GPT_IPG_PER];
+
        if ((imx_get_soc_revision() != IMX_CHIP_REVISION_1_0) ||
            cpu_is_imx6dl()) {
                clk_set_parent(clk[IMX6QDL_CLK_LDB_DI0_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c index bf92e5a351c0..c0ad839516b0 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -312,10 +317,21 @@ static void __init _mxc_timer_init(int irq,
        __raw_writel(0, timer_base + MXC_TCTL);
        __raw_writel(0, timer_base + MXC_TPRER); /* see datasheet note */

-       if (timer_is_v2())
-               tctl_val = V2_TCTL_CLK_PER | V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
-       else
+       if (timer_is_v2()) {
+               tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
+               if (clk_get_rate(clk_per) == V2_TIMER_RATE_OSC_DIV8) {
			/* Is the assumption corrrect ??? */
[Anson] I am afraid that i.MX6Q TO1.0 can NOT meet it, as there is no gpt_3m available for i.MX6Q TO1.0, but we have it in dtb and clk driver. 

+                       tctl_val |= V2_TCTL_CLK_OSC_DIV8;
+                       if (cpu_is_imx6dl() || cpu_is_imx6sx()) {
+                               /* 24 / 8 = 3 MHz */
+                               __raw_writel(7 << V2_TPRER_PRE24M, timer_base + MXC_TPRER);
+                               tctl_val |= V2_TCTL_24MEN;
+                       }
+               } else {
+                       tctl_val |= V2_TCTL_CLK_PER;
+               }
+       } else {
                tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
+       }

        __raw_writel(tctl_val, timer_base + MXC_TCTL);

@@ -349,9 +365,13 @@ static void __init mxc_timer_init_dt(struct device_node *np)
        WARN_ON(!timer_base);
        irq = irq_of_parse_and_map(np, 0);

-       clk_per = of_clk_get_by_name(np, "per");
        clk_ipg = of_clk_get_by_name(np, "ipg");

+       /* Try osc_per clock first, and fall back to per clock otherwise */
+       clk_per = of_clk_get_by_name(np, "osc_per");
+       if (!IS_ERR(clk_per))
+               clk_per = of_clk_get_by_name(np, "per");
+
[Anson] For i.MX6Q TO1.0, there is no GPT_3M clock for GPT, but in dtb, there is osc_per, so clk_per will be initialized by osc_per, and the clk rate read in _mxc_timer_init function will be 3000000 and go to the GPT_3M clk source path, which will NOT work for i.MX6Q TO1.0.

        _mxc_timer_init(irq, clk_per, clk_ipg);  }  CLOCKSOURCE_OF_DECLARE(mx1_timer, "fsl,imx1-gpt", mxc_timer_init_dt);
