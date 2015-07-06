From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 6 Jul 2015 19:15:34 +0200
Subject: [PATCH v3] clk: change clk_ops' ->determine_rate() prototype
In-Reply-To: <20150603233728.GA490@codeaurora.org>
References: <1432138345-19044-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150603233728.GA490@codeaurora.org>
Message-ID: <20150706191534.3d0778e0@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 3 Jun 2015 16:37:28 -0700
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 05/20, Boris Brezillon wrote:
> > Clock rates are stored in an unsigned long field, but ->determine_rate()
> > (which returns a rounded rate from a requested one) returns a long
> > value (errors are reported using negative error codes), which can lead
> > to long overflow if the clock rate exceed 2Ghz.
> > 
> > Change ->determine_rate() prototype to return 0 or an error code, and pass
> > a pointer to a clk_rate_request structure containing the expected target
> > rate and the rate constraints imposed by clk users.
> > 
> > The clk_rate_request structure might be extended in the future to contain
> > other kind of constraints like the rounding policy, the maximum clock
> > inaccuracy or other things that are not yet supported by the CCF
> > (power consumption constraints ?).
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > 
> > CC: Jonathan Corbet <corbet@lwn.net>
> > CC: Tony Lindgren <tony@atomide.com>
> > CC: Ralf Baechle <ralf@linux-mips.org>
> > CC: "Emilio L?pez" <emilio@elopez.com.ar>
> > CC: Maxime Ripard <maxime.ripard@free-electrons.com>
> > CC: Tero Kristo <t-kristo@ti.com>
> > CC: linux-doc at vger.kernel.org
> > CC: linux-kernel at vger.kernel.org
> > CC: linux-arm-kernel at lists.infradead.org
> > CC: linux-omap at vger.kernel.org
> > CC: linux-mips at linux-mips.org
> > ---
> > 
> > Hi Stephen,
> > 
> > This patch is based on clk-next and contains the changes you suggested
> > in your previous review.
> > 
> > It was tested on sama5d4 and compile tested on several ARM platforms
> > (those enabled in multi_v7_defconfig).
> > 
> 
> Thanks. I think we should wait until the next -rc1 drops to apply the
> patch for the next merge window. That will make it least likely to conflict
> with other trees, and we can provide it on a stable branch should there
> be clock providers going through other trees somewhere. Please
> remind me if I forget.

Just sent a v4 fixing the bug you reported and rebasing my work on
4.2-rc1.

> 
> > @@ -1186,15 +1191,21 @@ EXPORT_SYMBOL_GPL(__clk_determine_rate);
> >   */
> >  unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
> >  {
> > -	unsigned long min_rate;
> > -	unsigned long max_rate;
> > +
> > +	struct clk_rate_request req;
> > +	int ret;
> >  
> >  	if (!clk)
> >  		return 0;
> >  
> > -	clk_core_get_boundaries(clk->core, &min_rate, &max_rate);
> > +	clk_core_get_boundaries(clk->core, &req.min_rate, &req.max_rate);
> > +	req.rate = rate;
> > +
> > +	ret = clk_core_round_rate_nolock(clk->core, &req);
> > +	if (ret)
> > +		return ret;
> 
> This returns a negative int for unsigned long. Is that intentional?
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
