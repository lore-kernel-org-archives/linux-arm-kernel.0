From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2010 17:28:25 +0000
Subject: [PATCH] Consolidate clks_register() and similar
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909020898E7@mi8nycmail19.Mi8.com>
References: <20100110172825.GB8639@n2100.arm.linux.org.uk>
	<BD79186B4FD85F4B8E60E381CAEE1909020898E7@mi8nycmail19.Mi8.com>
Message-ID: <20100111172825.GA7925@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 12:26:12PM -0500, H Hartley Sweeten wrote:
> On Sunday, January 10, 2010 10:28 AM, Russell King wrote:
> > diff --git a/arch/arm/include/asm/clkdev.h b/arch/arm/include/asm/clkdev.h
> > index b6ec7c6..7a0690d 100644
> > --- a/arch/arm/include/asm/clkdev.h
> > +++ b/arch/arm/include/asm/clkdev.h
> > @@ -27,4 +27,7 @@ struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
> >  void clkdev_add(struct clk_lookup *cl);
> >  void clkdev_drop(struct clk_lookup *cl);
> >  
> > +void clkdev_add_table(struct clk_lookup *, size_t);
> > +int clk_add_alias(const char *, const char *, char *, struct device *);
> 
> clk_add_alias does not seem to be related to this patch.

True, but it might as well get cleaned up along with the rest of this.
For some reason, the prototype was never moved there.

> > @@ -474,8 +473,7 @@ static int __init ep93xx_clock_init(void)
> >  		clk_f.rate / 1000000, clk_h.rate / 1000000,
> >  		clk_p.rate / 1000000);
> >  
> > -	for (i = 0; i < ARRAY_SIZE(clocks); i++)
> > -		clkdev_add(&clocks[i]);
> > +	clkdev_add_table(clocks, ARRAY_SIZE(clocks));
> >  	return 0;
> >  }
> >  arch_initcall(ep93xx_clock_init);
> 
> For ep93xx.
> 
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks.
