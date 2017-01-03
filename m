From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 3 Jan 2017 17:44:53 +0100
Subject: [PATCH] pwm: sunxi: wait for the READY bit
In-Reply-To: <73f5fc87-717f-2238-b653-1b117359cbb8@schinagl.nl>
References: <20170103145732.2108-1-alexandre.belloni@free-electrons.com>
 <73f5fc87-717f-2238-b653-1b117359cbb8@schinagl.nl>
Message-ID: <20170103164453.wtdi4mxdxogbx4i5@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2017 at 16:56:16 +0100, Olliver Schinagl wrote :
> Hey Alexandre,
> 
> I've sent several patches regarding pwm a while ago, sadly you never
> responded [0]. So I guess this is a follow up from that?
> 

Well, we had the issue and I just had a bit of time to look at it. As I
remembered you kind of had the same issue, I chose to Cc you.

> I couldn't quickly find the resubmitted version however.
> 

Was there a new version?

> >  	clk_gate = val & BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> > -	if (clk_gate) {
> > -		val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> > +
> > +	if (sun4i_pwm->data->has_rdy && (val & PWM_RDY(pwm->hwpwm))) {
> > +		val |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> >  		sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> > +
> > +		err = readl_poll_timeout(sun4i_pwm->base + PWM_CTRL_REG, val,
> > +					 !(val & PWM_RDY(pwm->hwpwm)), 400,
> > +					 500000);
> > +		if (err)
> > +			goto finish;
> >  	}
> > 
> What happens on sun4i here? sun4i does not have the RDY flag, but it does
> need the PWM_CLK_GATING to be active.
> 

Does it actually need it? The datasheet doesn't say anything about it.
I'm actually wondering what happens if the period is written twice in a
row without waiting. If the latest period is used, maybe we don't
actually care.

> maybe only the readl_poll_timeout() should be guarded by the has_rdy, where
> you poll the register as you do now, and in the else just have a 'known safe
> delay' to emulate the has_rdy behavior? I'm guessing a few clock cycles of
> the PWM block. I don't think the documentation states how long this
> could/should be.
> 

My guess is that the IP is waiting for the current period to finish
before updating the period internally. That would be the sane way to do it but
maybe I'm an optimist.

> With my 'wait before disable' patch [1] I run into the same issue, I think.
> We do not know how long to wait before the hardware is ready.
> 

Up to 196.8s if I'm right...

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
