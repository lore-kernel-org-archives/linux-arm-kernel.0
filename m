From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 11 Jan 2013 18:40:41 -0800
Subject: [PATCH] clk: export __clk_get_name for re-use in imx-ipu-v3 and
 others
In-Reply-To: <20121217085952.GH26326@pengutronix.de>
References: <1355400745-7320-1-git-send-email-ndevos@redhat.com>
 <20121217085952.GH26326@pengutronix.de>
Message-ID: <20130112024041.4361.91427@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sascha Hauer (2012-12-17 00:59:52)
> On Thu, Dec 13, 2012 at 01:12:25PM +0100, Niels de Vos wrote:
> > This fixes the following error when building for arm-imx:
> > > ERROR: "__clk_get_name" [drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.ko] undefined!
> > > make[1]: *** [__modpost] Error 1
> > > make: *** [modules] Error 2
> > 
> > There are valid usecases to get the name of a clock, be it for debugging
> > purposes or to register a children of a clock like done in this IPU driver.
> > Therefore exporting __clk_get_name() and make it available for others makes
> > sense.
> 
> Gnerally I think the name of a clock shouldn't be a secret, so:
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> 

I've taken this into clk-next, but I'm not too pleased with it for any
purpose other than debugging.  For this reason I opted to keep the
double underscores (as opposed to EXPORTing a new clk_get_name which
calls __clk_get_name) to make all users of the API feel uneasy and
otherwise of low character.

Currently the clock framework relies on parent names for registering
clocks from defined in static data but this limitation isn't really true
for clocks defined as part of DT.  More to think about for the future.

Regards,
Mike

> > 
> > Reported-by: Peter Robinson <pbrobinson@gmail.com>
> > CC: Sascha Hauer <s.hauer@pengutronix.de>
> > CC: Mike Turquette <mturquette@linaro.org>
> > Signed-off-by: Niels de Vos <ndevos@redhat.com>
> > ---
> >  drivers/clk/clk.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 251e45d..fbe0f3a 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -259,10 +259,11 @@ late_initcall(clk_disable_unused);
> >  
> >  /***    helper functions   ***/
> >  
> > -inline const char *__clk_get_name(struct clk *clk)
> > +const char *__clk_get_name(struct clk *clk)
> >  {
> >       return !clk ? NULL : clk->name;
> >  }
> > +EXPORT_SYMBOL_GPL(__clk_get_name);
> >  
> >  inline struct clk_hw *__clk_get_hw(struct clk *clk)
> >  {
> > -- 
> > 1.7.11.7
> > 
> > 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
