From: B47053@freescale.com (Xiubo Li-B47053)
Date: Wed, 21 Aug 2013 10:46:39 +0000
Subject: [PATCH 1/4] pwm: add freescale ftm pwm driver support
In-Reply-To: <20130821095049.GQ31036@pengutronix.de>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
 <1377054462-6283-2-git-send-email-Li.Xiubo@freescale.com>
 <20130821073659.GN31036@pengutronix.de>
 <1DD289F6464F0949A2FCA5AA6DC23F827D1C51@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130821095049.GQ31036@pengutronix.de>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F827D1D4D@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TO Sascha,

Thanks very much for your quick reply.



> > > > +	fpc = to_fsl_chip(chip);
> > > > +
> > > > +	if (WARN_ON(!test_bit(PWMF_REQUESTED, &pwm->flags)))
> > > > +		return -ESHUTDOWN;
> > > > +
> > > > +	statename = kasprintf(GFP_KERNEL, "en%d", pwm->hwpwm);
> > > > +	pins_state = pinctrl_lookup_state(fpc->pinctrl,
> > > > +			statename);
> > > > +	/* enable pins to be muxed in and configured */
> > > > +	if (!IS_ERR(pins_state)) {
> > > > +		ret = pinctrl_select_state(fpc->pinctrl, pins_state);
> > > > +		if (ret)
> > > > +			dev_warn(&fpc->pdev->dev,
> > > > +					"could not set default pins\n");
> > >
> > > Why do you need to manipulate the pinctrl to en/disable a channel?
> > >
> >
> > This is because in Vybrid VF610 TOWER board, there are 4 leds, and
> > each led's one point(diode's positive pole) is connected to 3.3V, and
> > the other point is connected to pwm's one channel. When the 4 pinctrls
> are configured as enable at the same time, the 4 pinctrls is low valtage,
> and the 4 leds will be lighted up as default, then when you
> enable/disable one led will effects others.
> >
> 
> I think the inactive state of a PWM is pretty much undefined by the PWM
> framework and left to the drivers.
> 
> I stumbled upon this aswell. It would be good to think about the inactive
> state and how the PWM framework could help us here getting things right.
> 
> There are several things to consider. For a noninverted PWM the inactive
> state should probably logic 0. For an inverted PWM it should probably be
> logic 1. I guess several PWM devices have an undefined inactive state,
> most of the PWM devices probably can control the inactive state by
> setting the duty cycle to 100% / 0% without actually disabling the PWM.
> 
> Using the pinctrl is one way to control the inactive state and probaby
> the only one before initialization. It might be good to wire this up in
> the core instead of the individual PWM drivers.
> 
> These are just the thoughts which first came to my mind.
> 

That's a very good idea, and I have also thought about it before.
But from the power dissipation:
If so, upon my board is up, the pwm core should be alive even I won't use it.

I think the pwm core should be in idle mode when not using it,
when any of it's channels is requested and enabled, the pwm core will keep alive.

What do you think about it ?

> Thierry, any more input about this?
> 
> 
> > > > +	fpc = dev_get_drvdata(dev);
> > > > +
> > > > +	ret = kstrtouint(buf, 0, &val);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	mutex_lock(&fpc->lock);
> > > > +	if (!!(val) != !!(fpc->cpwm)) {
> > > > +		fpc->cpwm = !!val;
> > > > +		fsl_updata_config(fpc, NULL);
> > > > +	}
> > > > +	mutex_unlock(&fpc->lock);
> > > > +
> > > > +	return count;
> > > > +}
> > >
> > > What is this cpwm thingy?
> >
> > Up-down counting mode:
> > CNTIN(a register) defines the starting value of the count and MOD(a
> > register) defines the final value of the count. The value of CNTIN is
> > loaded into the FTM counter, and the counter increments until the
> > value of MOD is reached, at which point the counter is decremented
> until it returns to the value of CNTIN and the up-down counting restarts.
> 
> The current PWM framework only cares about period times and duty cycles.
> Why would I want to care about this?

I will think it over, If this hasn't any help here, I'll drop it in v2.



Thanks very much.

--
Best Regards,
Xiubo Li
