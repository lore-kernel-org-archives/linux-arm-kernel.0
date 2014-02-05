From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 05 Feb 2014 11:51:41 +0100
Subject: [PATCH 1/2] clk: shmobile: rcar-gen2: Fix clock parent all
 non-PLL clocks
In-Reply-To: <52F213C9.2020501@codethink.co.uk>
References: <1389113273-10364-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1389113273-10364-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <52F213C9.2020501@codethink.co.uk>
Message-ID: <4232876.LkjsLLbJbc@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Wednesday 05 February 2014 10:34:49 Ben Dooks wrote:
> On 07/01/14 16:47, Laurent Pinchart wrote:
> > The lb, qspi, sdh, sd0 and sd1 clocks have the PLL1 (divided by 2) as
> > their parent, not the main clock. Fix it.
> 
> William Towle has already sent a patch to move this to device tree
> which I think is a better solution for this.

I actually disagree. The CPG is an IP core that generates a bunch of clocks 
from a single external parent. The fact that clocks are not flat but organized 
as a tree internally is an internal property of the CPG, and I prefer keeping 
it that way instead of exposing it in the device tree.

> Any chance of commenting on which to take please.
> 
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >   drivers/clk/shmobile/clk-rcar-gen2.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c
> > b/drivers/clk/shmobile/clk-rcar-gen2.c index a59ec21..8c7bcbd 100644
> > --- a/drivers/clk/shmobile/clk-rcar-gen2.c
> > +++ b/drivers/clk/shmobile/clk-rcar-gen2.c
> > @@ -186,7 +186,7 @@ rcar_gen2_cpg_register_clock(struct device_node *np,
> > struct rcar_gen2_cpg *cpg,> 
> >   			     const char *name)
> >   {
> >   	const struct clk_div_table *table = NULL;
> > -	const char *parent_name = "main";
> > +	const char *parent_name;
> >   	unsigned int shift;
> >   	unsigned int mult = 1;
> >   	unsigned int div = 1;
> > @@ -201,23 +201,31 @@ rcar_gen2_cpg_register_clock(struct device_node *np,
> > struct rcar_gen2_cpg *cpg,> 
> >   		 * the multiplier value.
> >   		 */
> >   		u32 value = clk_readl(cpg->reg + CPG_PLL0CR);
> > +		parent_name = "main";
> >   		mult = ((value >> 24) & ((1 << 7) - 1)) + 1;
> >   	} else if (!strcmp(name, "pll1")) {
> > +		parent_name = "main";
> >   		mult = config->pll1_mult / 2;
> >   	} else if (!strcmp(name, "pll3")) {
> > +		parent_name = "main";
> >   		mult = config->pll3_mult;
> >   	} else if (!strcmp(name, "lb")) {
> > +		parent_name = "pll1_div2";
> >   		div = cpg_mode & BIT(18) ? 36 : 24;
> >   	} else if (!strcmp(name, "qspi")) {
> > +		parent_name = "pll1_div2";
> >   		div = (cpg_mode & (BIT(3) | BIT(2) | BIT(1))) == BIT(2)
> >   		    ? 16 : 20;
> >   	} else if (!strcmp(name, "sdh")) {
> > +		parent_name = "pll1_div2";
> >   		table = cpg_sdh_div_table;
> >   		shift = 8;
> >   	} else if (!strcmp(name, "sd0")) {
> > +		parent_name = "pll1_div2";
> >   		table = cpg_sd01_div_table;
> >   		shift = 4;
> >   	} else if (!strcmp(name, "sd1")) {
> > +		parent_name = "pll1_div2";
> >   		table = cpg_sd01_div_table;
> >   		shift = 0;
> >   	} else if (!strcmp(name, "z")) {

-- 
Regards,

Laurent Pinchart
