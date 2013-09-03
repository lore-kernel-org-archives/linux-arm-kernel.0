From: B47053@freescale.com (Xiubo Li-B47053)
Date: Tue, 3 Sep 2013 04:17:09 +0000
Subject: [PATCHv2 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <20130902085630.GS30088@pengutronix.de>
References: <1377856132-11290-1-git-send-email-Li.Xiubo@freescale.com>
 <1377856132-11290-2-git-send-email-Li.Xiubo@freescale.com>
 <20130830174909.GF30088@pengutronix.de>
 <1DD289F6464F0949A2FCA5AA6DC23F827F785F@039-SN2MPN1-011.039d.mgd.msft.net>
 <20130902085630.GS30088@pengutronix.de>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F827F7C59@039-SN2MPN1-011.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCHv2 1/4] pwm: Add Freescale FTM PWM driver support
> 
> On Mon, Sep 02, 2013 at 03:33:37AM +0000, Xiubo Li-B47053 wrote:
> >
> > > > +static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device
> > > > +*pwm) {
> > > > +	struct fsl_pwm_chip *fpc;
> > > > +	struct fsl_pwm_data *pwm_data;
> > > > +
> > > > +	fpc = to_fsl_chip(chip);
> > > > +
> > > > +	pwm_data = pwm_get_chip_data(pwm);
> > > > +	if (!pwm_data)
> > > > +		return;
> > >
> > > THis check seems unnecessary.
> > >
> >
> > But if do not check it here, I must check it in the following code.
> >
> > > > +
> > > > +	if (pwm_data->available != FSL_AVAILABLE)
> > > > +		return;
> > > > +
> >
> > So the ' struct fsl_pwm_data' may be removed in the future.
> >
> > >
> > > > +
> > > > +
> > > > +	pwm_data->period_cycles = period_cycles;
> > > > +	pwm_data->duty_cycles = duty_cycles;
> > >
> > > These fields are set but never read. Please drop them.
> > >
> > > If you drop the 'available' field also the you can drop chip_data
> > > completely.
> > >
> >
> > I think I may move the 'available' field to the PWM driver data struct.
> 
> You simply don't need the available field. You don't need to track
> whether they are available. If a user enables a pwm which is not routed
> out of the SoC (disabled in the iomux) simply nothing will happen except
> for a slightly increased power consumption.
> 
If the there is not need to explicitly specify the channels are available or not, so there is no doubt that the 'available' field will be dropt.
Why I added this here is because that the 4th and 5th channels' pinctrls are used as UART TX and RX as I have mentioned before, so here if you configure these two pinctrls, the UART TX and RX will be polluted, there maybe some other cases like this.
So, if there is no need to worry about this in PWM driver, the customer should be aware of it and be responsible for the potential risk.
I will think it over and optimize it then.



Thanks very much.
--
Best Regards.
Xiubo
