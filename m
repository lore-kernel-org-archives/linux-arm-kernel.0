From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 31 Jan 2012 09:07:59 +0100
Subject: [PATCH 2/6] mfd: mc13xxx-core: ADC conv: wait_for_completion
 returns a long
In-Reply-To: <201201310840.55707.marc@cpdesign.com.au>
References: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
 <1327876408-22528-3-git-send-email-marc@cpdesign.com.au>
 <20120130072453.GG6305@pengutronix.de>
 <201201310840.55707.marc@cpdesign.com.au>
Message-ID: <20120131080759.GN6305@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marc,

On Tue, Jan 31, 2012 at 08:40:55AM +1100, Marc Reilly wrote:
> On Monday, January 30, 2012 06:24:53 PM Uwe Kleine-K?nig wrote:
> > On Mon, Jan 30, 2012 at 09:33:24AM +1100, Marc Reilly wrote:
> > > Use the correct return type for wait_for_completion, as long may be
> > > larger than int.
> > 
> > That's a theoretical problem only because the return value should be in
> > the range -ESOMETHING ... HZ which fits into an int.
> 
> It _should_ be ok, but I propose that it is generally better practice to match 
> up the types. 
Agreed, but then only change the type and don't touch the logic in the
same commit. (Or at least mention it in the change log.)
 
> > 
> > >  	mc13xxx_unlock(mc13xxx);
> > > 
> > > -	ret = wait_for_completion_interruptible_timeout(&adcdone_data.done, HZ);
> > > +	timeout = wait_for_completion_interruptible_timeout(&adcdone_data.done, HZ);
> > > 
> > > -	if (!ret)
> > > +	if (timeout <= 0) {
> > > +		dev_warn(mc13xxx->dev,
> > > +				"timed out waiting for ADC completion\n");
> > > 
> > >  		ret = -ETIMEDOUT;
> > > 
> > > +	}
> > 
> > I think this is wrong. wait_for_completion_interruptible_timeout returns
> > -ERESTARTSYS if it was interrupted. That's not a timeout and
> > -ERESTARTSYS should be propagated then. !ret is the correct test for
> > timeout.
> 
> It took me a little while to get your point here, and I guess I missed that in 
> my original understanding of the code, (which may be more of a reflection on 
> me :) )
>  
> I still think the way it was before is subtle, and would prefer something more 
> explicit, perhaps:
> 
> if (timeout == 0)
> 	ret = -ETIMEDOUT;
> else if (timeout < 0)
> 	ret = timeout;
Yeah, that's better than the original as it propagates an eventual
-ERESTARTSYS from wait_for_completion_interruptible_timeout. Don't know
if/how the upper layer handle that though.
 
> > 
> > >  	mc13xxx_lock(mc13xxx);
> > >  	
> > >  	mc13xxx_irq_free(mc13xxx, MC13XXX_IRQ_ADCDONE, &adcdone_data);
> > > 
> > > -	if (ret > 0)
> > > +	if (!ret)
> > 
> > This is wrong, too, isn't it?
> 
> This is right I think. ret is return code from the mc13xxx_* call, so 0 is 
> success.
Ah, I thought ret still holds the return value of
wait_for_completion_interruptible_timeout. You're right.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
