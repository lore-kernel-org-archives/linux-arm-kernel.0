From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 13 May 2016 20:19:55 +0800
Subject: [PATCH 1/2] net: mv643xx_eth: use {readl|writel}_relaxed
 instead of readl/writel
In-Reply-To: <3966837.tFk2PD8QFb@wuerfel>
References: <1463140760-7128-1-git-send-email-jszhang@marvell.com>
 <1463140760-7128-2-git-send-email-jszhang@marvell.com>
 <3966837.tFk2PD8QFb@wuerfel>
Message-ID: <20160513201955.256e5169@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd,

On Fri, 13 May 2016 14:09:43 +0200 Arnd Bergmann wrote:

> On Friday 13 May 2016 19:59:19 Jisheng Zhang wrote:
> >  /* port register accessors **************************************************/
> >  static inline u32 rdl(struct mv643xx_eth_private *mp, int offset)
> >  {
> > -	return readl(mp->shared->base + offset);
> > +	return readl_relaxed(mp->shared->base + offset);
> >  }
> >  
> >  static inline u32 rdlp(struct mv643xx_eth_private *mp, int offset)
> >  {
> > -	return readl(mp->base + offset);
> > +	return readl_relaxed(mp->base + offset);
> >  }  
> 
> I'd recommend not changing these in general, but introducing new 'rdl_relaxed()'
> and 'rdlp_relaxed()' etc variants that you use in the code that actually
> is performance sensitive, but use the normal non-relaxed versions by
> default.
> 
> Then add a comment to each use of the relaxed accessors on how you know
> that it's safe for that caller. This usually is just needed for the xmit()
> function and for the interrupt handler.

Got your points and I do think it makes sense. But could we always use the
relaxed version to save some LoCs, although I have no mv643xx_eth platform
but I can confirm similar relaxed version changes in pxa168_eth is safe and
this is what we do in product's kernel.

Above is just my humble opinion, comments are welcome.

Thanks,
Jisheng

>   
> > @@ -2642,10 +2642,10 @@ mv643xx_eth_conf_mbus_windows(struct mv643xx_eth_shared_private *msp,
> >  	int i;
> >  
> >  	for (i = 0; i < 6; i++) {
> > -		writel(0, base + WINDOW_BASE(i));
> > -		writel(0, base + WINDOW_SIZE(i));
> > +		writel_relaxed(0, base + WINDOW_BASE(i));
> > +		writel_relaxed(0, base + WINDOW_SIZE(i));
> >  		if (i < 4)
> > -			writel(0, base + WINDOW_REMAP_HIGH(i));
> > +			writel_relaxed(0, base + WINDOW_REMAP_HIGH(i));
> >  	}
> >  
> >  	win_enable = 0x3f;  
> 
> Configuring the mbus for instance is clearly not an operation in which
> performance matters at all, so better not touch that.
> 
> > @@ -2674,8 +2675,8 @@ static void infer_hw_params(struct mv643xx_eth_shared_private *msp)
> >  	 * [21:8], or a 16-bit coal limit in bits [25,21:7] of the
> >  	 * SDMA config register.
> >  	 */
> > -	writel(0x02000000, msp->base + 0x0400 + SDMA_CONFIG);
> > -	if (readl(msp->base + 0x0400 + SDMA_CONFIG) & 0x02000000)
> > +	writel_relaxed(0x02000000, msp->base + 0x0400 + SDMA_CONFIG);
> > +	if (readl_relaxed(msp->base + 0x0400 + SDMA_CONFIG) & 0x02000000)
> >  		msp->extended_rx_coal_limit = 1;
> >  	else
> >  		msp->extended_rx_coal_limit = 0;  
> 
> 
> This also seems to be configuration, rather than in the packet rx/tx hotpath.
> 
> 	Arnd
