From: B47053@freescale.com (Xiubo Li-B47053)
Date: Tue, 27 Aug 2013 09:56:44 +0000
Subject: [PATCH 1/4] pwm: add freescale ftm pwm driver support
In-Reply-To: <20130827074057.GC8686@ulmo>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
 <1377054462-6283-2-git-send-email-Li.Xiubo@freescale.com>
 <20130823090523.GF3535@ulmo>
 <1DD289F6464F0949A2FCA5AA6DC23F827E42BD@039-SN2MPN1-012.039d.mgd.msft.net>
 <20130827074057.GC8686@ulmo>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F827E6994@039-SN2MPN1-012.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Actually it should even be:
> 
> 	#define FTM_CSC(channel) \
> 		(FTM_CSC_BASE + ((channel) * 8))
> 

Well, yes, It should be, as Sascha has comment about this before, I have 
already revise it.


> > Firstly, we should be clear that the fpc->clk is chip's work clock.
> > If so, after the .request() is called and before .enable() is called,
> > the custumer will call .config(), in which will read/write the pwm chip
> registers, if the module clock is still disabled, then the system will
> hang up.
> 
> Okay. In that case perhaps the better thing to do is call clk_prepare()
> during driver probe and only clk_enable() here.
> 

Yes, it is.

> > > Perhaps time_ns should be "unsigned long"?
> > >
> >
> > Shouldn't this be same with "int duty_ns" and "int period_ns", which
> > are defined by struct pwm_ops { ...
> > 	int (*config)(struct pwm_chip *chip,
> >                     struct pwm_device *pwm,
> >                     int duty_ns, int period_ns); ...
> > }  ?
> 
> Well, the plan is to eventually make duty_ns and period_ns unsigned int
> or unsigned long because negative values don't make any sense for them.
> With that in mind I think it makes sense to use the proper type here now.
> 

Okey, I will think it over again and revise it.

> > > > +static int fsl_pwm_config_channel(struct pwm_chip *chip,
> > >
> > > I think you can safely drop the _channel suffix from the PWM
> operations.
> > >
> >
> > By adding _channel suffix just for more comprehensave about the pwm's
> muti-channel operation.
> > If this is redundant here, I will drop it.
> 
> The operations are implicitly per-channel operations. So yes, the
> _channel suffix is redundant here.
> 

Agree, I will drop it.

> > > > +	fpc = to_fsl_chip(chip);
> > > > +
> > > > +	if (WARN_ON(!test_bit(PWMF_REQUESTED, &pwm->flags)))
> > > > +		return -ESHUTDOWN;
> > >
> > > Erm... how do you think this could ever happen? Users need to
> > > request a PWM to obtain a struct pwm_device, in which case
> > > PWMF_REQUESTED will always be set. There are a few other occurrences
> > > throughout the rest of the driver that I haven't pointed out
> explicitly.
> > >
> >
> > Does the following case is exist ?
> > The customer in one thread has .free(pwm_1), while in another thread,
> > which maybe had slept in for some reason, will
> call .config/.enable/.disable?
> >
> > If so, as I have explained before, if the pwm_1 has been freed, the
> > module clock maybe disabled too, so if the .config is call the system
> will hang up.
> 
> While the above could possibly happen, there's no way the core could
> prevent it. And your explicit test couldn't either. So what usually
> happens is that a driver requests a PWM device and then has exclusive
> access to it. Any other driver that wants to use the same PWM device
> can't because it will get an -EBUSY return.
> 
> So in your hypothetical case above, if one driver does stuff like that
> with a PWM device then that's a driver bug, not something the PWM core
> should be required to handle.
> 

Okey, I will drop this.

> > While I think the following is better in code.
> >
> >  		dev_err(fpc->chip.dev,
> >  			"failed to parse <fsl,pwm-clk-ps> property: %d\n",
> >  			ret);
> 
> Why? You're quoting which property failed to parse so you should use the
> correct character for quoting, which is either the apostrophe (') or the
> quotation mark (").
> 

For my first impression, I just thought that maybe a little better.
Okey, I will adopt this in the feature.



--
Xiubo
