From: b32955@freescale.com (Huang Shijie)
Date: Mon, 26 May 2014 14:03:51 +0800
Subject: [PATCH 1/2] ARM: clk: imx: add a new helper which can
 re-parent the clock
In-Reply-To: <1401087292.925679327@f35.i.mail.ru>
References: <1401081633-12190-1-git-send-email-b32955@freescale.com>
 <1401087292.925679327@f35.i.mail.ru>
Message-ID: <20140526060349.GA11074@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 10:54:52AM +0400, Alexander Shiyan wrote:
> Mon, 26 May 2014 13:20:32 +0800 ?? Huang Shijie <b32955@freescale.com>:
> > The clocks for Quadspi controller may be different when different
> > NOR flashes are connected to the board.
> > 
> > This patch adds a new helper to register the clock which needs the
> > re-parent capability.
> > 
> > Signed-off-by: Huang Shijie <b32955@freescale.com>
> > ---
> >  arch/arm/mach-imx/clk.h |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
> > index e29f6eb..2e3c4fe 100644
> > --- a/arch/arm/mach-imx/clk.h
> > +++ b/arch/arm/mach-imx/clk.h
> > @@ -112,6 +112,16 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
> >  			&imx_ccm_lock);
> >  }
> >  
> > +/* we can use this helper to register the clock which needs the re-parent. */
> > +static inline struct clk *imx_clk_mux_flags_reparent(const char *name,
> > +		void __iomem *reg, u8 shift, u8 width, const char **parents,
> > +		int num_parents, unsigned long flags)
> > +{
> > +	return clk_register_mux(NULL, name, parents, num_parents,
> > +			flags, reg, shift, width, 0,
> > +			&imx_ccm_lock);
> > +}
> 
> So you can use CLK_SET_RATE_PARENT for flags here and completely remove
> flags parameter for this call. Is not it?
Do you mean make the code like this :

----------------------------------------------------------------
	return clk_register_mux(NULL, name, parents, num_parents,
			CLK_SET_RATE_PARENT, reg, shift, width, 0,
			&imx_ccm_lock);
----------------------------------------------------------------

Without the "flags" argument, the helper is too specific.

But if Shawn also agree to use the fixed CLK_SET_RATE_PARENT, i am okay too.

thanks
Huang Shijie
