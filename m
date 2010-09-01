From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 00:17:52 +0100
Subject: [RFC] [PATCH] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <20100901111302.GE22790@game.jcrosoft.org>
References: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
	<20100901091233.GK8142@n2100.arm.linux.org.uk>
	<20100901111302.GE22790@game.jcrosoft.org>
Message-ID: <20100901231752.GA25860@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 01, 2010 at 01:13:02PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 10:12 Wed 01 Sep     , Russell King - ARM Linux wrote:
> > On Tue, Aug 31, 2010 at 01:16:42PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > factorise some generic infrastructure to assist looking up struct clks
> > > for the ARM & SH architecture.
> > > +/*
> > > + * Returns a clock. Note that we first try to use device id on the bus
> > > + * and clock name. If this fails, we try to use clock name only.
> > > + */
> > >  struct clk *clk_get(struct device *dev, const char *con_id)
> > >  {
> > >  	const char *dev_id = dev ? dev_name(dev) : NULL;
> > >  
> > >  	return clk_get_sys(dev_id, con_id);
> > >  }
> > > -EXPORT_SYMBOL(clk_get);
> > > +EXPORT_SYMBOL_GPL(clk_get);
> > >  
> > >  void clk_put(struct clk *clk)
> > >  {
> > >  	__clk_put(clk);
> > >  }
> > > -EXPORT_SYMBOL(clk_put);
> > > +EXPORT_SYMBOL_GPL(clk_put);
> > 
> > Please leave these as-is.
> ok but on SH it's GPL so it is ok with you Paul too?

If you want to get that pedantic... I created clkdev, and Sascha Hauer
extended it with some refactoring to create the clk_get_sys() interface.

If you look at the history, the sh version is a copy of the ARM version:

commit 51a5006afcd13176276f0935ee57c4cc6f210e83
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Mon Mar 8 21:45:19 2010 +0900

    sh: Merge clkdev API updates.

    This rolls in the remainder of the clkdev API bits from the ARM tree.
    This can more or less be used verbatim, so we just copy it over and nuke
    our local version.

    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

and

commit 441c2440aba2efd8d0f48a5e3357deec92283d62
Author: Magnus Damm <damm@opensource.se>
Date:   Tue May 11 09:37:12 2010 +0000

    sh: remove unused clock lookup

    Now when all clocks are registered using clkdev,
    get rid of the special SH-specific clock lookup.

    Also ditch the unused module ref counting code.
    This patch syncs the SH behaviour with ARM.

    Signed-off-by: Magnus Damm <damm@opensource.se>
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

so really it's a question for primerily me, and maybe Sascha.
