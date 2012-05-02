From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 May 2012 11:02:25 +0100
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120502095816.GG20478@pengutronix.de>
References: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
 <20120502095816.GG20478@pengutronix.de>
Message-ID: <20120502100225.GB24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 11:58:16AM +0200, Sascha Hauer wrote:
> > diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> > index 6e58f11..8e97491 100644
> > --- a/drivers/clk/clk-mux.c
> > +++ b/drivers/clk/clk-mux.c
> > @@ -95,6 +95,7 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
> >  {
> >  	struct clk_mux *mux;
> >  	struct clk *clk;
> > +	struct clk_init_data init;
> >  
> >  	/* allocate the mux */
> >  	mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
> > @@ -103,6 +104,12 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
> >  		return ERR_PTR(-ENOMEM);
> >  	}
> >  
> > +	init.name = name;
> > +	init.ops = &clk_mux_ops;
> > +	init.flags = flags;
> > +	init.parent_names = parent_names;
> > +	init.num_parents = num_parents;
> > +
> >  	/* struct clk_mux assignments */
> >  	mux->reg = reg;
> >  	mux->shift = shift;
> > @@ -110,8 +117,7 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
> >  	mux->flags = clk_mux_flags;
> >  	mux->lock = lock;
> 
> There is a mux->hw.init = &init missing here.

What happens to mux->hw.init long term?  Because once this function
returns, that pointer will no longer be valid.  It would be a good
idea to NULL it out in clk_register() once its done with, to ensure
that no one comes up with the idea of using it later.
