From: marc@cpdesign.com.au (Marc Reilly)
Date: Tue, 31 Jan 2012 08:40:55 +1100
Subject: [PATCH 2/6] mfd: mc13xxx-core: ADC conv: wait_for_completion
 returns a long
In-Reply-To: <20120130072453.GG6305@pengutronix.de>
References: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
 <1327876408-22528-3-git-send-email-marc@cpdesign.com.au>
 <20120130072453.GG6305@pengutronix.de>
Message-ID: <201201310840.55707.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Thanks for reviewing.

On Monday, January 30, 2012 06:24:53 PM Uwe Kleine-K?nig wrote:
> On Mon, Jan 30, 2012 at 09:33:24AM +1100, Marc Reilly wrote:
> > Use the correct return type for wait_for_completion, as long may be
> > larger than int.
> 
> That's a theoretical problem only because the return value should be in
> the range -ESOMETHING ... HZ which fits into an int.

It _should_ be ok, but I propose that it is generally better practice to match 
up the types. 


> > @@ -566,20 +567,23 @@ int mc13xxx_adc_do_conversion(struct mc13xxx
> > *mc13xxx, unsigned int mode,
> > 
> >  			mc13xxx_handler_adcdone, __func__, &adcdone_data);
> >  	
> >  	mc13xxx_reg_write(mc13xxx, MC13XXX_ADC0, adc0);
> > 
> > -	mc13xxx_reg_write(mc13xxx, MC13XXX_ADC1, adc1);
> > +	ret = mc13xxx_reg_write(mc13xxx, MC13XXX_ADC1, adc1);
> 
> Is this change intended? I guess without it you get a warning that ret
> is used uninitialized, 

This was intended, ret is then either 0 after a successful write to start the 
conversion off, or negative from a write error (or non-completion below).


> but if mc13xxx_reg_write fails you should IMHO
> return at once.

I guess there should be a lot more checking for failure in other places too. 
You are right about returning at once.


> 
> >  	mc13xxx_unlock(mc13xxx);
> > 
> > -	ret = wait_for_completion_interruptible_timeout(&adcdone_data.done,
> > HZ); +	timeout =
> > wait_for_completion_interruptible_timeout(&adcdone_data.done, HZ);
> > 
> > -	if (!ret)
> > +	if (timeout <= 0) {
> > +		dev_warn(mc13xxx->dev,
> > +				"timed out waiting for ADC completion\n");
> > 
> >  		ret = -ETIMEDOUT;
> > 
> > +	}
> 
> I think this is wrong. wait_for_completion_interruptible_timeout returns
> -ERESTARTSYS if it was interrupted. That's not a timeout and
> -ERESTARTSYS should be propagated then. !ret is the correct test for
> timeout.

It took me a little while to get your point here, and I guess I missed that in 
my original understanding of the code, (which may be more of a reflection on 
me :) )
 
I still think the way it was before is subtle, and would prefer something more 
explicit, perhaps:

if (timeout == 0)
	ret = -ETIMEDOUT;
else if (timeout < 0)
	ret = timeout;


> 
> >  	mc13xxx_lock(mc13xxx);
> >  	
> >  	mc13xxx_irq_free(mc13xxx, MC13XXX_IRQ_ADCDONE, &adcdone_data);
> > 
> > -	if (ret > 0)
> > +	if (!ret)
> 
> This is wrong, too, isn't it?

This is right I think. ret is return code from the mc13xxx_* call, so 0 is 
success.


Cheers,
Marc
