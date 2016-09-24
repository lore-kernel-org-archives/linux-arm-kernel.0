From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 24 Sep 2016 22:25:02 +0200
Subject: [PATCH 1/2] pwm: sunxi: allow the pwm to finish its pulse before
 disable
In-Reply-To: <1473411668.731.75.camel@schinagl.nl>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
 <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
 <20160826221900.GG3165@lukather>
 <1473145976.731.20.camel@schinagl.nl>
 <20160906195149.GJ9040@lukather>
 <1473411668.731.75.camel@schinagl.nl>
Message-ID: <20160924202502.GF16901@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oliver,

Sorry for the slow answer.

On Fri, Sep 09, 2016 at 11:01:08AM +0200, Olliver Schinagl wrote:
> > > > > *chip, struct pwm_device *pwm)
> > > > > ?	spin_lock(&sun4i_pwm->ctrl_lock);
> > > > > ?	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > > > > ?	val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
> > > > > +	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> > > > > +	spin_unlock(&sun4i_pwm->ctrl_lock);
> > > > > +
> > > > > +	/* Allow for the PWM hardware to finish its last
> > > > > toggle.
> > > > > The pulse
> > > > > +	?* may have just started and thus we should wait a
> > > > > full
> > > > > period.
> > > > > +	?*/
> > > > > +	ndelay(pwm_get_period(pwm));
> > > > 
> > > > Can't that use the ready bit as well?
> > > It depends whatever is cheaper. If we disable the pwm, we have to
> > > commit that request to hardware first. Then we have to read back
> > > the
> > > has ready and in the strange situation it is not, wait for it to
> > > become
> > > ready?
> > 
> > If it works like you were suggesting, yes.
> > 
> > > 
> > > Also, that would mean we would loop in a spin lock, or keep
> > > setting/clearing an additional spinlock to read the ready bit.
> > 
> > You're using a spin_lock, so it's not that bad, but I was just
> > suggesting replacing the ndelay.
>
> If you say the spin_lock + wait for the ready is just as expensive as
> the ndelay, or the ndelay is less preferred, then I gladly make the
> change;

For the spin_lock part, I was just comparing it to a
spin_lock_irqsave, which is pretty expensive since it masks all the
interrupts in the system, introducing latencies.

> but I think we need the ndelay for the else where we do not
> have the ready flag (A10 or A13 iirc?)

Hmmmm, good point. But that would also apply to your second patch
then, wouldn't it?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160924/cb63cb8f/attachment.sig>
