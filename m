From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 10:22:24 +0100
Subject: [PATCHv6 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F828DD76C@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
 <1384220218-12716-2-git-send-email-Li.Xiubo@freescale.com>
 <20131128212510.GC14689@mithrandir>
 <1DD289F6464F0949A2FCA5AA6DC23F828DD76C@039-SN2MPN1-011.039d.mgd.msft.net>
Message-ID: <20131129092224.GB22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 06:42:06AM +0000, Li Xiubo wrote:
> > > +#define FTM_CNTIN_VAL       0x00
> > 
> > Do we really need this?
> > 
> 
> Maybe not, I think that the initial value maybe modified in the future.
> And this can be more easy to ajust it. 

Why would it need to be modified?

> > > +	writel(period_cycles + cntin - 1, fpc->base + FTM_MOD);
> > > +	writel(duty_cycles + cntin, fpc->base + FTM_CV(pwm->hwpwm));
> > 
> > And these:
> > 
> > 	writel(period - 1, fpc->base + FTM_MOD);
> > 	writel(duty, fpc->base + FTM_CV(pwm->hwpwm));
> > 
> > Although now that I think about it, this seems broken. The period is set
> > in a global register, so I assume it is valid for all channels. What if
> > you want to use different periods for individual channels? The way I
> > read this the last one to be configured will win and change the period
> > to whatever it wants. Other channels won't even notice.
> > 
> 
> That's right. And all the 8 channels share the same period settings.
> 
> > Is there a way to set the period per channel?
> > 
> 
> Not yet. Only could we do is to set the duty value individually for each
> channel. So here is a limitation for the cusumers that all the 8 channels'
> period values should be the same.

That will need to be handled some way. Perhaps the easiest would be to
check whether or not another channel is already running and check that
indeed the period as requested by the new channel matches that of any
running channels. If it doesn't match, then pwm_config() should fail.

When you do that you can also optimize this a bit by only setting the
frequency once. Whenever a new channel is configured it will have the
same period and therefore the register doesn't need to be reprogrammed.

> > > +static void fsl_pwm_disable(struct pwm_chip *chip, struct pwm_device
> > *pwm)
> > > +{
> > > +	struct fsl_pwm_chip *fpc;
> > > +
> > > +	fpc = to_fsl_chip(chip);
> > > +
> > > +	fsl_counter_clock_disable(fpc);
> > > +}
> > 
> > Same here. Since you can't propagate the error, perhaps an error message
> > would be appropriate here?
> > 
> 
> Well, in fsl_counter_clock_disable(fpc); only '0' could be returned, maybe
> let it a void type value to return is better.
> Just like:
> static void fsl_counter_clock_disable(struct fsl_pwm_chip *fpc) {}

Yes, that sounds good.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/fe887954/attachment.sig>
