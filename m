From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 21 Nov 2011 14:18:17 +0000
Subject: [PATCH 2/2] ARM: amba: Auto-generate AMBA driver module aliases
 during modpost
In-Reply-To: <20111121131022.GE30612@pengutronix.de>
References: <1321872510-2562-1-git-send-email-dave.martin@linaro.org>
 <1321872510-2562-3-git-send-email-dave.martin@linaro.org>
 <20111121131022.GE30612@pengutronix.de>
Message-ID: <20111121141817.GB14679@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 02:10:22PM +0100, Uwe Kleine-K?nig wrote:
> Hello Dave,
> 
> On Mon, Nov 21, 2011 at 10:48:30AM +0000, Dave Martin wrote:
> > --- a/drivers/amba/bus.c
> > +++ b/drivers/amba/bus.c
> > @@ -52,7 +52,14 @@ static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
> >  	int retval = 0;
> >  
> >  	retval = add_uevent_var(env, "AMBA_ID=%08x", pcdev->periphid);
> > -	return retval;
> > +	if (retval)
> > +		return retval;
> > +
> > +	retval = add_uevent_var(env, "MODALIAS=amba:d%08X", pcdev->periphid);
> > +	if (retval)
> > +		return retval;
> > +
> > +	return 0;
> Just return retval here?

Hmmm, yes -- I'm not sure why I did things that way.
I'll get rid of the final if () and do as you suggest.

Cheers
---Dave
