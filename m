From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 23 Aug 2013 09:58:29 +0200
Subject: [PATCH 1/4] pwm: add freescale ftm pwm driver support
In-Reply-To: <20130821095049.GQ31036@pengutronix.de>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
 <1377054462-6283-2-git-send-email-Li.Xiubo@freescale.com>
 <20130821073659.GN31036@pengutronix.de>
 <1DD289F6464F0949A2FCA5AA6DC23F827D1C51@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130821095049.GQ31036@pengutronix.de>
Message-ID: <20130823075828.GD3535@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 11:50:49AM +0200, Sascha Hauer wrote:
> On Wed, Aug 21, 2013 at 09:24:56AM +0000, Xiubo Li-B47053 wrote:
> > TO Sascha,
> > 
> > > > +
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
> > This is because in Vybrid VF610 TOWER board, there are 4 leds, and each led's one point(diode's positive pole) is connected to 3.3V,
> > and the other point is connected to pwm's one channel. When the 4 pinctrls are configured as enable at the same time, 
> > the 4 pinctrls is low valtage, and the 4 leds will be lighted up as default, then when you enable/disable one led will effects others.
> > 
> 
> I think the inactive state of a PWM is pretty much undefined by the PWM
> framework and left to the drivers.
> 
> I stumbled upon this aswell. It would be good to think about the
> inactive state and how the PWM framework could help us here getting
> things right.

I'm not sure if imposing what the inactive state should be is a good
thing to do. For one, it might not be possible to set that particular
state in all of the PWM drivers. Similarly some drivers may know of a
more optimal state to put the pin into.

> There are several things to consider. For a noninverted PWM the inactive
> state should probably logic 0. For an inverted PWM it should probably be
> logic 1. I guess several PWM devices have an undefined inactive state,
> most of the PWM devices probably can control the inactive state by
> setting the duty cycle to 100% / 0% without actually disabling the PWM.

That sounds like a reasonable set of rules. The above should also be
equivalent to the "no power" state. I think we could possibly write down
those rules (even though I think they are obvious enough), but enforcing
one specific state doesn't sound right to me.

> Using the pinctrl is one way to control the inactive state and probaby
> the only one before initialization. It might be good to wire this up in
> the core instead of the individual PWM drivers.

I don't really see how the PWM core can make an educated decision about
this. The proper inactive state for a PWM can only be known by it's
corresponding driver. Each driver's .disable() operation should take
care of putting the PWM into the inactive state. That is, if it can be
done without too much effort. If putting the PWM into the inactive state
involves pinmuxing and such, it's probably better to defer that to the
.free() operation.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/987325fc/attachment.sig>
