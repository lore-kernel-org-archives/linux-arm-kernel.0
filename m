From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 3 Jan 2015 17:22:42 +0100
Subject: [PATCH] ti-soc-thermal: implement eocz bit to make driver useful
 on omap3
In-Reply-To: <20150103122634.GB22356@developer>
References: <20150103114632.GA21883@amd>
 <20150103122634.GB22356@developer>
Message-ID: <20150103162241.GA26680@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > When periodic mode is not enabled, it is neccessary to force reads.
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > 

> > --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> > +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> > @@ -43,6 +43,8 @@
> >  
> >  #include "ti-bandgap.h"
> >  
> > +static int ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id);
> > +
> >  /***   Helper functions to access registers and their bitfields   ***/
> >  
> >  /**
> > @@ -852,14 +831,20 @@ int ti_bandgap_read_temperature(struct ti_bandgap *bgp, int id,
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (!TI_BANDGAP_HAS(bgp, MODE_CONFIG)) {
> > +		ret = ti_bandgap_force_single_read(bgp, id);
> 
> not sure MODE_CONFIG is sufficient condition for single read on all OMAP
> versions.

Ok, what do you suggest? AFAICT, without MODE_CONFIG, continuous ADC
mode is not available, so we have to force it periodically, so this
should be correct.

> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	spin_lock(&bgp->lock);
> >  	temp = ti_bandgap_read_temp(bgp, id);
> >  	spin_unlock(&bgp->lock);
> >  
> > -	ret |= ti_bandgap_adc_to_mcelsius(bgp, temp, &temp);
> > +	ret = ti_bandgap_adc_to_mcelsius(bgp, temp, &temp);
> 
> this one should be part of your clean up patch

Ok, can you apply the cleanup patch and I'll prepare one on the top of
it?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
