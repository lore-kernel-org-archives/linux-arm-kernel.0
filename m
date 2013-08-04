From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 4 Aug 2013 23:50:48 +0800
Subject: [PATCH] clk: clk-divider: Export clk_register_divider()
In-Reply-To: <20987.58025.296592.412693@ipc1.ka-ro>
References: <1375460047-27160-1-git-send-email-festevam@gmail.com>
 <20987.58025.296592.412693@ipc1.ka-ro>
Message-ID: <20130804155047.GJ18119@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 06:47:37PM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Fabio Estevam writes:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > clk_register_divider() needs to be exported so that it could be used
> > in a module driver, otherwise we get the following error:
> > 
> > ERROR: "clk_register_divider" [sound/soc/mxs/snd-soc-mxs.ko] undefined!
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> >  drivers/clk/clk-divider.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index 6d55eb2..98ee97f 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -317,6 +317,7 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
> >  	return _register_divider(dev, name, parent_name, flags, reg, shift,
> >  			width, clk_divider_flags, NULL, lock);
> >  }
> > +EXPORT_SYMBOL_GPL(clk_register_divider);
> >  
> >  /**
> >   * clk_register_divider_table - register a table based divider clock with
> > -- 
> Did you try unloading and reloading the module with this patch?
> 
> The registered clock divider will not be deregistered, but will be
> reused upon reload, still using the old (now unmapped) address to
> access the clk registers. Thus the whole approach used in snd-soc-mxs
> is broken by design (at least for modules).

It's just an immediate stop-gap fix to the failure of devm_clk_get()
in sgtl5000 driver.  The register access will only happen when
clk_*_rate() is called on the clock, since it's a divider clock.
Yeah, I have to admit it's dirty, but it shouldn't cause any problem
for now, because sgtl5000 driver does not do any clk_*_rate() calls
so far.

> 
> You would need to keep the mapping of the base registers established
> upon the first module load to let the clock divider registered from
> the first module load stay operational across module unload/load.
> 
> I already considered creating a patch for this, but the whole approach
> seemed me too crappy to submit it to mainline.

I agree with Sylwester.  Clock framework should support deregistration.

Shawn
