From: horms@verge.net.au (Simon Horman)
Date: Mon, 29 Jan 2018 15:24:02 +0100
Subject: [PATCH v4 2/6] clk: renesas: rcar-gen3: Add Z2 clock divider
 support
In-Reply-To: <CAMuHMdWk3ke6GriUdxHp_62r-REYV3P4qNiNGOcGRiCQWCyKAg@mail.gmail.com>
References: <20180103121840.29316-1-horms+renesas@verge.net.au>
 <20180103121840.29316-3-horms+renesas@verge.net.au>
 <CAMuHMdXcLhFD825Xi2Uk=6_OAgLd7BEp14rWpgb7pv6rOM2H2Q@mail.gmail.com>
 <20180105140401.7iitpzdrlyqtasvz@verge.net.au>
 <CAMuHMdWk3ke6GriUdxHp_62r-REYV3P4qNiNGOcGRiCQWCyKAg@mail.gmail.com>
Message-ID: <20180129142357.sw3d4f5d4hwmveua@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 05, 2018 at 03:35:13PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Jan 5, 2018 at 3:04 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Jan 03, 2018 at 01:47:08PM +0100, Geert Uytterhoeven wrote:
> >> On Wed, Jan 3, 2018 at 1:18 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> >> > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >> >
> >> > This patch adds Z2 clock divider support for R-Car Gen3 SoC.
> >> >
> >> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> >> As the CPG/MSSR driver now has suspend/resume support, do we need
> >> a notifier to restore the Z or Z2 registers? Or is that handled automatically
> >> by cpufreq during system resume, for both the primary and the secondary
> >> CPU cores?
> >
> > I am a bit unsure.
> >
> > When using the A57 cores, which is the default case, the Z clk is queried
> > by CPUFreq on resume. It appears that on my system its already set to the
> > correct value but I assume if it was not then it would be reset. However,
> > this does not cover Z2 clk. So perhaps to be safe we need to register
> > notifiers and make sure they they play nicely with CPUFreq?
> 
> Of course the CPU is special: unlike many other devices, it must be running
> when the kernel is reentered upon system resume.
> It may be running using a different frequency setting, though.
> However, following "opp-suspend", the system will always suspend with the
> Z clock running at 1.5GHz, which is the default?
> So Z is probably OK.
> 
> It's more interesting to check what happens when the little cores are
> enabled as well (unfortunately that requires different firmware).
> 1. Does cpufreq handle them correctly when they are onlined again during
>    system resume?

I tested this by updating the firmware on an H3 ES2.0 / Salvator-XS
using the instructions at
https://elinux.org/R-Car/Virtualization#Enabling_HYP_Support

I also fleshed out the opts table for the little CPUs using the following
from the 3.6.0 BSP:

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 1485e6a8e112..671c2d7ed6d0 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -219,7 +219,17 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-1200000000 {
+		opp at 800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;

And fixed the out-by-one bug you pointed out elsewhere in this thread:

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index a7d68cefda9c..0c8fe10d57fe 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -94,7 +94,7 @@ static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
 	u32 val;
 
 	val = clk_readl(zclk->reg) & zclk->mask;
-	mult = 32 - (val >> (__ffs(zclk->mask) - 1));
+	mult = 32 - (val >> __ffs(zclk->mask));
 
 	/* Factor of 2 is for fixed divider */
 	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult, 32 * 2);
@@ -129,7 +129,7 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 		return -EBUSY;
 
 	val = clk_readl(zclk->reg) & ~zclk->mask;
-	val |= ((32 - mult) << (__ffs(zclk->mask) - 1)) & zclk->mask;
+	val |= ((32 - mult) << __ffs(zclk->mask)) & zclk->mask;
 	clk_writel(val, zclk->reg);
 
 	/*

With these changes in place CPUFreq seems to work for both BIG and little
CPUS. And the frequencies seem to be correct after S2RAM.

# cd /sys/devices/system/cpu/
# grep . cpu*/cpufreq/scaling_available_frequencies
cpu0/cpufreq/scaling_available_frequencies:500000 1000000 1500000 
...
cpu4/cpufreq/scaling_available_frequencies:800000 1000000 1200000 
...
# grep grep -E -w "pll[01]|z|z2" /sys/kernel/debug/clk/clk_summary
grep: pll[01]|z|z2: No such file or directory
# grep -E -w "pll[01]|z|z2" /sys/kernel/debug/clk/clk_summary
          z2                              0            0  1198080000          0 0  
       .pll1                              1            1  3194880000          0 0  
       .pll0                              0            0  2995200000          0 0  
          z                               0            0  1497600000          0 0  
# echo 500000 > cpu0/cpufreq/scaling_max_freq
# echo 800000 > cpu4/cpufreq/scaling_max_freq
# grep . cpu*/cpufreq/*cur*
cpu0/cpufreq/cpuinfo_cur_freq:468000
cpu0/cpufreq/scaling_cur_freq:500000
...
cpu4/cpufreq/cpuinfo_cur_freq:786240
cpu4/cpufreq/scaling_cur_freq:786240
...
# grep -E -w "pll[01]|z|z2" /sys/kernel/debug/clk/clk_summary
          z2                              0            0   786240000          0 0  
       .pll1                              1            1  3194880000          0 0  
       .pll0                              0            0  2995200000          0 0  
          z                               0            0   468000000          0 0  
# i2cset -f -y 7 0x30 0x20 0x0F
# echo mem > /sys/power/state
...
[  203.289585] Restarting tasks ... done.
[  203.299250] PM: suspend exit
# grep . cpu*/cpufreq/*cur*
cpu0/cpufreq/cpuinfo_cur_freq:468000
cpu0/cpufreq/scaling_cur_freq:500000
...
cpu4/cpufreq/cpuinfo_cur_freq:786240
cpu4/cpufreq/scaling_cur_freq:800000
...
# grep -E -w "pll[01]|z|z2" /sys/kernel/debug/clk/clk_summary
          z2                              0            0   786240000          0 0  
       .pll1                              1            1  3194880000          0 0  
       .pll0                              0            0  2995200000          0 0  
          z                               0            0   468000000          0 0  

> 2. What happens if you offline all big cores, and enter system suspend
>    running with little cores only?
>    Perhaps that's prevented by the "opp-suspend" property as well?

I am unable to take CPU0 offline.
