From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 10:23:48 +0900
Subject: [PATCH 02/03] ARM: shmobile: Use shmobile_clk_workaround() on
 Lager
In-Reply-To: <20140312235938.GF25813@verge.net.au>
References: <20140312233608.17009.65690.sendpatchset@w520>
 <20140312233626.17009.24749.sendpatchset@w520>
 <20140312235938.GF25813@verge.net.au>
Message-ID: <20140313012344.GJ25813@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 08:59:45AM +0900, Simon Horman wrote:
> On Thu, Mar 13, 2014 at 08:36:26AM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Convert the Lager DT reference code to use the newly introduced
> > function shmobile_clk_workaround().
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> > ---
> > 
> >  arch/arm/mach-shmobile/board-lager-reference.c |   65 +++++++++---------------
> >  1 file changed, 25 insertions(+), 40 deletions(-)
> > 
> > --- 0001/arch/arm/mach-shmobile/board-lager-reference.c
> > +++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-02-24 16:17:32.000000000 +0900
> > @@ -18,12 +18,11 @@
> >   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> >   */
> >  
> > -#include <linux/clk.h>
> > -#include <linux/clkdev.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/init.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_data/rcar-du.h>
> > +#include <mach/clock.h>
> >  #include <mach/common.h>
> >  #include <mach/irqs.h>
> >  #include <mach/rcar-gen2.h>
> > @@ -86,46 +85,32 @@ static void __init lager_add_du_device(v
> >  	platform_device_register_full(&info);
> >  }
> >  
> > +/*
> > + * This is a really crude hack to provide clkdev support to platform
> > + * devices until they get moved to DT.
> > + */
> > +static const struct clk_name clk_names[] = {
> 
> Should this be annotated as __initconst?
> Likewise for the Koelsch variant of this patch.

Btw, I'm happy to handle this as an incremental patch if you like.

> 
> > +	{ "cmt0", NULL, "sh_cmt.0" },
> > +	{ "scifa0", NULL, "sh-sci.0" },
> > +	{ "scifa1", NULL, "sh-sci.1" },
> > +	{ "scifb0", NULL, "sh-sci.2" },
> > +	{ "scifb1", NULL, "sh-sci.3" },
> > +	{ "scifb2", NULL, "sh-sci.4" },
> > +	{ "scifa2", NULL, "sh-sci.5" },
> > +	{ "scif0", NULL, "sh-sci.6" },
> > +	{ "scif1", NULL, "sh-sci.7" },
> > +	{ "hscif0", NULL, "sh-sci.8" },
> > +	{ "hscif1", NULL, "sh-sci.9" },
> > +	{ "du0", "du.0", "rcar-du-r8a7790" },
> > +	{ "du1", "du.1", "rcar-du-r8a7790" },
> > +	{ "du2", "du.2", "rcar-du-r8a7790" },
> > +	{ "lvds0", "lvds.0", "rcar-du-r8a7790" },
> > +	{ "lvds1", "lvds.1", "rcar-du-r8a7790" },
> > +};
> > +
> >  static void __init lager_add_standard_devices(void)
> >  {
> > -	/*
> > -	 * This is a really crude hack to provide clkdev support to platform
> > -	 * devices until they get moved to DT.
> > -	 */
> > -	static const struct clk_name {
> > -		const char *clk;
> > -		const char *con_id;
> > -		const char *dev_id;
> > -	} clk_names[] = {
> > -		{ "cmt0", NULL, "sh_cmt.0" },
> > -		{ "scifa0", NULL, "sh-sci.0" },
> > -		{ "scifa1", NULL, "sh-sci.1" },
> > -		{ "scifb0", NULL, "sh-sci.2" },
> > -		{ "scifb1", NULL, "sh-sci.3" },
> > -		{ "scifb2", NULL, "sh-sci.4" },
> > -		{ "scifa2", NULL, "sh-sci.5" },
> > -		{ "scif0", NULL, "sh-sci.6" },
> > -		{ "scif1", NULL, "sh-sci.7" },
> > -		{ "hscif0", NULL, "sh-sci.8" },
> > -		{ "hscif1", NULL, "sh-sci.9" },
> > -		{ "du0", "du.0", "rcar-du-r8a7790" },
> > -		{ "du1", "du.1", "rcar-du-r8a7790" },
> > -		{ "du2", "du.2", "rcar-du-r8a7790" },
> > -		{ "lvds0", "lvds.0", "rcar-du-r8a7790" },
> > -		{ "lvds1", "lvds.1", "rcar-du-r8a7790" },
> > -	};
> > -	struct clk *clk;
> > -	unsigned int i;
> > -
> > -	for (i = 0; i < ARRAY_SIZE(clk_names); ++i) {
> > -		clk = clk_get(NULL, clk_names[i].clk);
> > -		if (!IS_ERR(clk)) {
> > -			clk_register_clkdev(clk, clk_names[i].con_id,
> > -					    clk_names[i].dev_id);
> > -			clk_put(clk);
> > -		}
> > -	}
> > -
> > +	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
> >  	r8a7790_add_dt_devices();
> >  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> >  
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
