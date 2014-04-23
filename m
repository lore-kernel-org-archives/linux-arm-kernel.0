From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Apr 2014 15:31:06 +0200
Subject: [PATCH v6 3/8] ARM: sunxi: Move the clock protection to machine
 hooks
In-Reply-To: <20140423131720.GS24905@lukather>
References: <1397724379-15398-1-git-send-email-maxime.ripard@free-electrons.com>
 <201404231439.02913.arnd@arndb.de> <20140423131720.GS24905@lukather>
Message-ID: <4987444.Zp0Prbn0Y8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 April 2014 15:17:20 Maxime Ripard wrote:
> > > +#include <linux/clk.h>
> > >  #include <linux/init.h>
> > >  #include <linux/of_platform.h>
> > >  
> > > @@ -19,9 +20,17 @@
> > >  
> > >  static void __init sun4i_dt_init(void)
> > >  {
> > > +       struct clk *clk;
> > > +
> > >         sunxi_setup_restart();
> > >  
> > >         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > > +
> > > +       /* Make sure the clocks we absolutely need are enabled */
> > > +       /* DDR clock */
> > > +       clk = clk_get(NULL, "pll5_ddr");
> > > +       if (!IS_ERR(clk))
> > > +               clk_prepare_enable(clk);
> > >  }
> > 
> > Isn't there already DT syntax to do the same? If not, should there be?
> 
> I don't think there is, and I gave some thought about it too. But
> something a la regulator-always-on wouldn't work with clocks with
> multiple outputs (like pll5), because you might need to leave only one
> of the output enabled, but not the others, and I couldn't think of a
> nice way to do so.
> 
> If you have one, I'd be happy to implement it.

We had a discussion a while ago about encoding default settings for clock
providers in the clock provider nodes. I don't remember the details
unfortunately.

Mike, can you explain how this should be done?

	Arnd
