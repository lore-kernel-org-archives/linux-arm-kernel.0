From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Oct 2013 09:42:31 -0400
Subject: [PATCH 2/8] ARM: imx: add clocking support code for the IMX50 SoC
In-Reply-To: <5267C4A6.7020805@uclinux.org>
References: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
 <1382076260-6422-3-git-send-email-gerg@uclinux.org>
 <20131023091941.GE24520@titan.lakedaemon.net>
 <5267C4A6.7020805@uclinux.org>
Message-ID: <20131023134231.GJ24520@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 10:44:22PM +1000, Greg Ungerer wrote:
> Hi Jason,
> 
> On 23/10/13 19:19, Jason Cooper wrote:
> >Greg,
> >
> >On Fri, Oct 18, 2013 at 04:04:14PM +1000, gerg at uclinux.org wrote:
> >>From: Greg Ungerer <gerg@uclinux.org>
> >>
> >>Add code to support the specific clock tree of the Freescale IMX50 SoC.
> >>It can use much of the common IMX51/IMX53 clocking code.
> >>
> >>Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> >>---
> >>  arch/arm/mach-imx/clk-imx51-imx53.c | 79 +++++++++++++++++++++++++++++++++++++
> >>  arch/arm/mach-imx/common.h          |  3 ++
> >>  2 files changed, 82 insertions(+)
> >>
> >>diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> >>index 7c0dc45..ea4523a 100644
> >>--- a/arch/arm/mach-imx/clk-imx51-imx53.c
> >>+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> >>@@ -363,6 +363,80 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
> >>  	clk_prepare_enable(clk[tmax3]); /* esdhc1, esdhc4 */
> >>  }
> >>
> >>+int __init mx50_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
> >>+			unsigned long rate_ckih1, unsigned long rate_ckih2)
> >>+{
> >>+	int i;
> >>+	unsigned long r;
> >>+	struct device_node *np;
> >>+
> >>+	clk[pll1_sw] = imx_clk_pllv2("pll1_sw", "osc", MX53_DPLL1_BASE);
> >>+	clk[pll2_sw] = imx_clk_pllv2("pll2_sw", "osc", MX53_DPLL2_BASE);
> >>+	clk[pll3_sw] = imx_clk_pllv2("pll3_sw", "osc", MX53_DPLL3_BASE);
> >
> >What about the apll and it's derivatives?
> 
> The IMX50RM.pdf seems light on details on the apll. Is it any different
> to the imx51 and imx53 families?

yes, see 5.3.1.4:

"""
There is a fixed 480 MHz PLL that feeds eight independent Phase
Fractional Dividers (PFDs). The PFDs allow multiple fractional clocks to
be generated from one PLL without the trouble of relocking the PLL each
time.
"""

Now, after discussing this with MikeT and a few others at the ARM
mini-summit, I've learned that my naive assumption of a completely
described clock tree is wrong.  We basically just describe what we need to
get the job done. ie, the leaves and the core.

So I'm sure this is fine as is if you are successfully booting it on
your board.  My question was more focused on learning what advantage the
apll and the pfds may provide that would make it worth describing the
full tree.

thx,

Jason.
