From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 05 Aug 2016 00:42:08 +0200
Subject: [PATCH v4 2/7] clk: rockchip: add new clock-type for the ddrclk
In-Reply-To: <2163567.7aYA2GN16A@diego>
References: <1469779021-10426-1-git-send-email-hl@rock-chips.com>
 <1469779021-10426-3-git-send-email-hl@rock-chips.com>
 <2163567.7aYA2GN16A@diego>
Message-ID: <9078133.mu38cJQ6PH@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 4. August 2016, 22:23:05 schrieb Heiko St?bner:
> Hi Lin,
> 
> Am Freitag, 29. Juli 2016, 15:56:56 schrieb Lin Huang:
> > On new rockchip platform(rk3399 etc), there have dcf controller to
> > do ddr frequency scaling, and this controller will implement in
> > arm-trust-firmware. We add a special clock-type to handle that.
> > 
> > Signed-off-by: Lin Huang <hl@rock-chips.com>
> 
> please also include the ARM people from last time in your list.
> The arm_smccc_smc calls look correct on first glance, but there is only
> one other example in the kernel [0] outside psci that is using it, so I'd
> like some confirmation that we're doing the right thing :-)
> 
> 
> [0]
> http://lxr.free-electrons.com/source/arch/arm/mach-artpec/board-artpec6.c
> #L55
> > diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> > index bac775d..2e3bccf 100644
> > --- a/drivers/clk/rockchip/clk.h
> > +++ b/drivers/clk/rockchip/clk.h
> > @@ -281,6 +281,13 @@ struct clk *rockchip_clk_register_mmc(const char
> > *name, const char *const *parent_names, u8 num_parents,
> > 
> >  				void __iomem *reg, int shift);
> > 
> > +struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
> > +			const char *const *parent_names, u8 num_parents,
> > +			int mux_offset, int mux_shift, int mux_width,
> > +			int mux_flag, int div_shift, int div_width,
> > +			int div_flag, void __iomem *reg_base,
> > +			spinlock_t *lock);
> > +
> > 
> >  #define ROCKCHIP_INVERTER_HIWORD_MASK	BIT(0)
> >  
> >  struct clk *rockchip_clk_register_inverter(const char *name,
> > 
> > @@ -299,6 +306,7 @@ enum rockchip_clk_branch_type {
> > 
> >  	branch_mmc,
> >  	branch_inverter,
> >  	branch_factor,
> > 
> > +	branch_ddrc,
> > 
> >  };
> >  
> >  struct rockchip_clk_branch {
> > 
> > @@ -488,6 +496,25 @@ struct rockchip_clk_branch {
> > 
> >  		.child		= ch,				\
> >  	
> >  	}
> > 
> > +#define COMPOSITE_DDRC(_id, cname, pnames, f, mo, ms, mw, mf,	\
> > +			 ds, dw, df)				\
> > +	{							\
> > +		.id		= _id,				\
> > +		.branch_type	= branch_ddrc,			\
> > +		.name		= cname,			\
> > +		.parent_names	= pnames,			\
> > +		.num_parents	= ARRAY_SIZE(pnames),		\
> > +		.flags		= f,				\
> > +		.muxdiv_offset	= mo,				\
> > +		.mux_shift	= ms,				\
> > +		.mux_width	= mw,				\
> > +		.mux_flags	= mf,				\
> > +		.div_shift	= ds,				\
> > +		.div_width	= dw,				\
> > +		.div_flags	= df,				\
> 
> you don't need (nor use) div and mux flags here, please use one flag
> param like the inverter type does and maybe directly add a flag like
> 	ROCKCHIP_DDRCLK_SIP
> for this type.
> 
> Background being, that the ddr clock mechanism is essentially the same
> on all socs and only the method to change the rate varies
> (sip on rk3399, scpi on rk3368, something sram-based on rk3288 and before)
> so in the future, this driver should hopefully be able to carry all those
> different methods.

and maybe name it COMPOSITE_DDRCLK(...)
