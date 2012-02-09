From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 9 Feb 2012 11:40:59 +0100
Subject: [PATCH 2/6] mfd: mc13xxx-core: ADC conv: wait_for_completion
 returns a long
In-Reply-To: <20120131080759.GN6305@pengutronix.de>
References: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
 <1327876408-22528-3-git-send-email-marc@cpdesign.com.au>
 <20120130072453.GG6305@pengutronix.de>
 <201201310840.55707.marc@cpdesign.com.au>
 <20120131080759.GN6305@pengutronix.de>
Message-ID: <20120209104059.GN8621@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

On Tue, Jan 31, 2012 at 09:07:59AM +0100, Uwe Kleine-K?nig wrote:
> > > > -	if (!ret)
> > > > +	if (timeout <= 0) {
> > > > +		dev_warn(mc13xxx->dev,
> > > > +				"timed out waiting for ADC completion\n");
> > > > 
> > > >  		ret = -ETIMEDOUT;
> > > > 
> > > > +	}
> > > 
> > > I think this is wrong. wait_for_completion_interruptible_timeout returns
> > > -ERESTARTSYS if it was interrupted. That's not a timeout and
> > > -ERESTARTSYS should be propagated then. !ret is the correct test for
> > > timeout.
> > 
> > It took me a little while to get your point here, and I guess I missed that in 
> > my original understanding of the code, (which may be more of a reflection on 
> > me :) )
> >  
> > I still think the way it was before is subtle, and would prefer something more 
> > explicit, perhaps:
> > 
> > if (timeout == 0)
> > 	ret = -ETIMEDOUT;
> > else if (timeout < 0)
> > 	ret = timeout;
> Yeah, that's better than the original as it propagates an eventual
> -ERESTARTSYS from wait_for_completion_interruptible_timeout. Don't know
> if/how the upper layer handle that though.
Just a small note, after starring again at the original code,
-ERESTARTSYS is propagated correctly. So it's only about style.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
