From: torfl6749@gmail.com (Torsten Fleischer)
Date: Fri, 19 Jun 2015 10:04:44 +0200
Subject: [PATCH linux-next 1/1] dmaengine: at_hdmac: fix residue
 computation
In-Reply-To: <2899583.NPB62C1E0l@linux-1fbo.site>
References: <cover.1434380729.git.cyrille.pitchen@atmel.com>
 <381ecf2427a6aae4b7109d930121df9f36aef81e.1434380729.git.cyrille.pitchen@atmel.com>
 <2899583.NPB62C1E0l@linux-1fbo.site>
Message-ID: <1922467.ZSxkKTyNbQ@linux-1fbo.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 June 2015 at 18:11:56 Torsten Fleischer wrote:
> On Monday 15 June 2015 at 17:17:51 Cyrille Pitchen wrote:
[...]
> > @@ -365,16 +371,13 @@ static int atc_get_bytes_left(struct dma_chan *chan,
> > dma_cookie_t cookie) }
> > 
> >  		/*
> > 
> > -		 * For the last descriptor in the chain we can calculate
> > +		 * For the current descriptor in the chain we can calculate
> > 
> >  		 * the remaining bytes using the channel's register.
> > 
> > -		 * Note that the transfer width of the first and last
> > -		 * descriptor may differ.
> > 
> >  		 */
> > 
> > -		if (!desc->lli.dscr)
> > -			ret = atc_calc_bytes_left_from_reg(ret, atchan, desc);
> > +		ret = atc_calc_bytes_left_from_reg(ret, atchan);
> 
> I see two issues here.
> 
> First this always returns the number if remaining bytes of the current child
> transfer and not of the entire hardware linked list transfer.
> 
Oops, I was wrong with the first issue. Please ignore this.
Sorry for that.

> Finally, for the calculation of the remaining bytes of a hardware linked
> list the value of DSCR is used to get the current child transfer.
> But regarding to a running DMA transfer, reading DSCR and CTRLA is not
> atomic. If you read CTRLA after DSCR then the value may not refer to the
> child transfer as read from DSCR, but to a subsequent one.
> Its only safe for the first transfer where CTRLA is read before DSCR and for
> the last transfer where CTRLA is read after DSCR.
> 
> >  	} else {
> >  	
> >  		/* single transfer */
> > 
> > -		ret = atc_calc_bytes_left_from_reg(ret, atchan, desc_first);
> > +		ret = atc_calc_bytes_left_from_reg(ret, atchan);
> > 
> >  	}
> >  	
> >  	return ret;
> > 
[...]

Regards,

Torsten
