From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 15 Sep 2014 22:48:05 +0800
Subject: [PATCH V1 1/3] ARM: clk-imx6sl: refine clock tree for SSI
In-Reply-To: <20140915115855.GC23877@audiosh1>
References: <cover.1410253534.git.shengjiu.wang@freescale.com>
 <7ed21195ebff8b3ccbecaeb492504edd28deea2d.1410253534.git.shengjiu.wang@freescale.com>
 <CAOMZO5A4FLbA_+u4oMTqgAY69DaF93V=oLiy+op=tEHbagF1pg@mail.gmail.com>
 <CAOMZO5DJZHKAV4Y9aUwMNWZqhoLrKrsZdYnKqPem2ZSy=-oAYw@mail.gmail.com>
 <20140915115855.GC23877@audiosh1>
Message-ID: <20140915144803.GL18566@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 07:58:56PM +0800, Shengjiu Wang wrote:
> I add IMX6QDL_CLK_SSIx in this patch, which use share count with 
> IMX6QDL_CLK_SSIx_IPG. The SSI driver sound/soc/fsl/fsl_ssi.c will enable
> IMX6QDL_CLK_SSIx_IPG clock in probe, but don't disable it. In the end of kernel
> boot up, some one(it is not ssi driver, maybe is the clock tree) will disable
> the IMX6QDL_CLK_SSIx clock, which is not enabled. IMX6QDL_CLK_SSIx_IPG share
> the enable/disable bit with IMX6QDL_CLK_SSIx, So IMX6QDL_CLK_SSIx_IPG is 
> disabled, the aplay will fail.
> 
> Is this the issue of imx_clk_gate2_shared()? When we want to disable IMX6QDL_CLK_SSIx,
> but IMX6QDL_CLK_SSIx_IPG is enabled, can IMX6QDL_CLK_SSIx be disabled?
> 
> 
> Shawn
> 
>    How do you think about this?

Shengjiu,

Your analysis is right.  I hope the following change will get the shared
gate clock code eventually does the right thing.

Shawn

diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
index 84acdfd1d715..89abdf738dc9 100644
--- a/arch/arm/mach-imx/clk-gate2.c
+++ b/arch/arm/mach-imx/clk-gate2.c
@@ -97,7 +97,7 @@ static int clk_gate2_is_enabled(struct clk_hw *hw)
        struct clk_gate2 *gate = to_clk_gate2(hw);

        if (gate->share_count)
-               return !!(*gate->share_count);
+               return !!__clk_get_enable_count(hw->clk);
        else
                return clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx);
 }
