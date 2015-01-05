From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon, 5 Jan 2015 17:35:59 -0400
Subject: [PATCH] ti-soc-thermal: implement eocz bit to make driver useful
 on omap3
In-Reply-To: <20150103162241.GA26680@amd>
References: <20150103114632.GA21883@amd> <20150103122634.GB22356@developer>
 <20150103162241.GA26680@amd>
Message-ID: <20150105213557.GD31536@developer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 03, 2015 at 05:22:42PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > When periodic mode is not enabled, it is neccessary to force reads.
> > > 
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > 
> 
> > > --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> > > +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> > > @@ -43,6 +43,8 @@
> > >  
> > >  #include "ti-bandgap.h"
> > >  
> > > +static int ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id);
> > > +
> > >  /***   Helper functions to access registers and their bitfields   ***/
> > >  
> > >  /**
> > > @@ -852,14 +831,20 @@ int ti_bandgap_read_temperature(struct ti_bandgap *bgp, int id,
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	if (!TI_BANDGAP_HAS(bgp, MODE_CONFIG)) {
> > > +		ret = ti_bandgap_force_single_read(bgp, id);
> > 
> > not sure MODE_CONFIG is sufficient condition for single read on all OMAP
> > versions.
> 
> Ok, what do you suggest? AFAICT, without MODE_CONFIG, continuous ADC
> mode is not available, so we have to force it periodically, so this
> should be correct.

I will have a better look and let you know. for now, adding a single
read should not hurt ( but I will double check)

> 
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > >  	spin_lock(&bgp->lock);
> > >  	temp = ti_bandgap_read_temp(bgp, id);
> > >  	spin_unlock(&bgp->lock);
> > >  
> > > -	ret |= ti_bandgap_adc_to_mcelsius(bgp, temp, &temp);
> > > +	ret = ti_bandgap_adc_to_mcelsius(bgp, temp, &temp);
> > 
> > this one should be part of your clean up patch
> 
> Ok, can you apply the cleanup patch and I'll prepare one on the top of
> it?

I mean, you should resend the cleanup patch including the above '|=' removal, as you are already doing in the cleanup patch.

> 
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150105/f90e6bc1/attachment.sig>
