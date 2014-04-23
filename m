From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Apr 2014 15:17:20 +0200
Subject: [PATCH v6 3/8] ARM: sunxi: Move the clock protection to machine
 hooks
In-Reply-To: <201404231439.02913.arnd@arndb.de>
References: <1397724379-15398-1-git-send-email-maxime.ripard@free-electrons.com>
 <1397724379-15398-4-git-send-email-maxime.ripard@free-electrons.com>
 <201404231439.02913.arnd@arndb.de>
Message-ID: <20140423131720.GS24905@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 02:39:02PM +0200, Arnd Bergmann wrote:
> On Thursday 17 April 2014, Maxime Ripard wrote:
> > Since we start to have a lot of clocks to protect, some of them in a few boards
> > only, it becomes difficult to handle the clock protection without having to add
> > per machine exceptions.
> > 
> > Move these where they belong, in the machine definition code.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> I don't like the fact that these are required to be hardcoded
> anywhere in source code.

I agree, but that would also mean having a driver for everything that
would need a clock: a CPU, the RAM. I'm not sure we want that either.

> > +#include <linux/clk.h>
> >  #include <linux/init.h>
> >  #include <linux/of_platform.h>
> >  
> > @@ -19,9 +20,17 @@
> >  
> >  static void __init sun4i_dt_init(void)
> >  {
> > +       struct clk *clk;
> > +
> >         sunxi_setup_restart();
> >  
> >         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > +
> > +       /* Make sure the clocks we absolutely need are enabled */
> > +       /* DDR clock */
> > +       clk = clk_get(NULL, "pll5_ddr");
> > +       if (!IS_ERR(clk))
> > +               clk_prepare_enable(clk);
> >  }
> 
> Isn't there already DT syntax to do the same? If not, should there be?

I don't think there is, and I gave some thought about it too. But
something a la regulator-always-on wouldn't work with clocks with
multiple outputs (like pll5), because you might need to leave only one
of the output enabled, but not the others, and I couldn't think of a
nice way to do so.

If you have one, I'd be happy to implement it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140423/683b2315/attachment-0001.sig>
