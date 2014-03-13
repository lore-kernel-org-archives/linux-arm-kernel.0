From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 09:03:05 +0900
Subject: [PATCH v3 15/20] ARM: shmobile: marzen-reference: Instantiate
 clkdevs for SCIF and TMU
In-Reply-To: <1792922.9Bi30kDKcG@avalon>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-16-git-send-email-horms+renesas@verge.net.au>
 <1792922.9Bi30kDKcG@avalon>
Message-ID: <20140313000304.GG25813@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 02:24:01PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> Thank you for the patch.
> 
> On Wednesday 26 February 2014 16:33:31 Simon Horman wrote:
> > Now that the common clock framework is supported, the clock lookup
> > entries in clock-r8a7779.c are not registered anymore. Devices must
> > instead reference their clocks in the device tree. However, SCIF and CMT
> > devices are still instantiated through platform code, and thus need a
> > clock lookup entry.
> > 
> > Retrieve the SCIF and CMT clock entries by name and register clkdevs for
> > the corresponding devices. This will be removed when the SCIF and CMT
> > devices will be instantiated from the device tree.
> > 
> > Based on work for the Koelsch board by Laurent Pinchart.
> > 
> > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > ---
> > v3
> > * Initialise TMU clocks instead of CMT clocks
> >   - It is TMU that Marzen uses as a clocksource
> > * Refactor clock initialisation hack as per more recent mainline
> >   code for Koelsch
> > * Use IS_ERR to check the return value of clk_get()
> > ---
> >  arch/arm/mach-shmobile/board-marzen-reference.c | 31 +++++++++++++++++++++-
> > 1 file changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c
> > b/arch/arm/mach-shmobile/board-marzen-reference.c index e261431..a5974d2
> > 100644
> > --- a/arch/arm/mach-shmobile/board-marzen-reference.c
> > +++ b/arch/arm/mach-shmobile/board-marzen-reference.c
> > @@ -19,7 +19,9 @@
> >   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 
> > USA */
> > 
> > +#include <linux/clk.h>
> >  #include <linux/clk/shmobile.h>
> > +#include <linux/clkdev.h>
> >  #include <linux/clocksource.h>
> >  #include <linux/of_platform.h>
> >  #include <mach/r8a7779.h>
> > @@ -38,7 +40,34 @@ static void __init marzen_init_timer(void)
> > 
> >  static void __init marzen_init(void)
> >  {
> > -#ifndef CONFIG_COMMON_CLK
> > +#ifdef CONFIG_COMMON_CLK
> > +	static const struct clk_name {
> > +		const char *clk;
> > +		const char *con_id;
> > +		const char *dev_id;
> > +	} clk_names[] = {
> > +		{ "scif0", NULL, "sh-sci.0" },
> > +		{ "scif1", NULL, "sh-sci.1" },
> > +		{ "scif2", NULL, "sh-sci.2" },
> > +		{ "scif3", NULL, "sh-sci.3" },
> > +		{ "scif4", NULL, "sh-sci.4" },
> > +		{ "scif5", NULL, "sh-sci.5" },
> 
> Any chance to switch the board the DT-based SCIF instead ? ;-)

As is typical for me, I'd like to handle that as a follow-up
rather than a pre-requisite.

> 
> > +		{ "tmu00", NULL, "sh_tmu.0" },
> > +		{ "tmu01", NULL, "sh_tmu.1" },
> > +		{ "tmu02", NULL, "sh_tmu.2" },
> 
> Those clocks should be tmu0, tmu1 and tmu2.

Thanks, I have fixed that.

> 
> > +	};
> > +	struct clk *clk;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(clk_names); ++i) {
> > +		clk = clk_get(NULL, clk_names[i].clk);
> > +		if (!IS_ERR(clk)) {
> > +			clk_register_clkdev(clk, clk_names[i].con_id,
> > +					    clk_names[i].dev_id);
> > +			clk_put(clk);
> > +		}
> > +	}
> > +#else
> >  	r8a7779_clock_init();
> >  #endif
> >  	r8a7779_add_standard_devices_dt();
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
