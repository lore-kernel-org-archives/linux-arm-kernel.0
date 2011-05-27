From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 27 May 2011 08:24:24 +0300
Subject: [PATCH 1/3] OMAP: change get_context_loss_count ret value to int
In-Reply-To: <alpine.DEB.2.00.1105261234130.27782@utopia.booyaka.com>
References: <1306428307-1360-1-git-send-email-tomi.valkeinen@ti.com>
	<1306428307-1360-2-git-send-email-tomi.valkeinen@ti.com>
	<alpine.DEB.2.00.1105261234130.27782@utopia.booyaka.com>
Message-ID: <1306473864.1905.2.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-26 at 12:37 -0600, Paul Walmsley wrote:
> Hello Tomi, Kevin,
> 
> On Thu, 26 May 2011, Tomi Valkeinen wrote:
> 
> > get_context_loss_count functions return context loss count as u32, and
> > zero means an error. However, zero is also returned when context has
> > never been lost and could also be returned when the context loss count
> > has wrapped and goes to zero.
> > 
> > Change the functions to return an int, with negative value meaning an
> > error.
> > 
> > OMAP HSMMC code uses omap_pm_get_dev_context_loss_count(), but as the
> > hsmmc code handles the returned value as an int, with negative value
> > meaning an error, this patch actually fixes hsmmc code also.
> 
> Thanks, I agree this makes more sense than the previous arrangement.
> 
> One minor comment:

<snip>

> > @@ -953,7 +953,13 @@ u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
> >  	for (i = 0; i < pwrdm->banks; i++)
> >  		count += pwrdm->ret_mem_off_counter[i];
> >  
> > -	pr_debug("powerdomain: %s: context loss count = %u\n",
> > +	/*
> > +	 * Context loss count has to be a non-negative value. Clear the sign
> > +	 * bit to get a value range from 0 to INT_MAX.
> > +	 */
> > +	count &= ~(1 << 31);
> 
> Could you use INT_MAX here?  It seems best not to have the implicit 
> dependency on 32-bit ints, if it is not too inconvenient.

Heh, Kevin made the same comment.

I didn't want to use INT_MAX because I feel INT_MAX is just a number,
not a mask. But as that's just a gut feeling, I'm fine with changing it
to INT_MAX.

 Tomi
