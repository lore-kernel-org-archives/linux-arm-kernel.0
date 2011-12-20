From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 Dec 2011 22:09:12 +0800
Subject: [PATCH 01/12] clk: add helper functions clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <201112201448.10577.marek.vasut@gmail.com>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
 <1324382443-4439-2-git-send-email-shawn.guo@linaro.org>
 <201112201448.10577.marek.vasut@gmail.com>
Message-ID: <20111220140911.GD5129@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 02:48:10PM +0100, Marek Vasut wrote:
> > From: Richard Zhao <richard.zhao@linaro.org>
> > 
> > It's for migrating to generic clk framework API.
> > 
> > The helper functions  help cases clk_enable/clk_disable is used
> > in non-atomic context.
> > For example, Call clk_enable in probe and clk_disable in remove.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > ---
> >  include/linux/clk.h |   22 ++++++++++++++++++++++
> >  1 files changed, 22 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/linux/clk.h b/include/linux/clk.h
> > index 7213b52..b9d46fa 100644
> > --- a/include/linux/clk.h
> > +++ b/include/linux/clk.h
> > @@ -107,6 +107,28 @@ static inline void clk_unprepare(struct clk *clk)
> >  }
> >  #endif
> > 
> > +/* clk_prepare_enable helps cases using clk_enable in non-atomic context.
> > */ +static inline int clk_prepare_enable(struct clk *clk)
> > +{
> > +	int ret;
> > +
> > +	ret = clk_prepare(clk);
> > +	if (ret)
> > +		return ret;
> > +	ret = clk_enable(clk);
> > +	if (ret)
> > +		clk_unprepare(clk);
> > +
> > +	return ret;
> > +}
> > +
> > +/* clk_disable_unprepare helps cases using clk_disable in non-atomic
> > context. */ +static inline void clk_disable_unprepare(struct clk *clk)
> > +{
> > +	clk_disable(clk);
> > +	clk_unprepare(clk);
> > +}
> > +
> >  /**
> >   * clk_get_rate - obtain the current clock rate (in Hz) for a clock
> > source. *		  This is only valid once the clock source has been 
> enabled.
> 
> Just be sure clk_prepare() is always available (which I suspect is checked in 
> the implementation, so ok). Other than that, 
> 
If HAVE_CLK_PREPARE is selected for given clock api implementation,
that implementation needs to provide clk_prepare().  Otherwise,
there is a dummy one provided by include/linux/clk.h.

-- 
Regards,
Shawn
