From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 Sep 2016 22:16:28 +0200
Subject: [PATCH 1/2] pwm: sunxi: allow the pwm to finish its pulse before
 disable
In-Reply-To: <1474879585.6096.33.camel@schinagl.nl>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
 <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
 <20160826221900.GG3165@lukather>
 <1473145976.731.20.camel@schinagl.nl>
 <20160906195149.GJ9040@lukather>
 <1473411668.731.75.camel@schinagl.nl>
 <20160924202502.GF16901@lukather>
 <1474879585.6096.33.camel@schinagl.nl>
Message-ID: <20160927201628.GB9084@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 26, 2016 at 10:46:25AM +0200, Olliver Schinagl wrote:
> > For the spin_lock part, I was just comparing it to a
> > spin_lock_irqsave, which is pretty expensive since it masks all the
> > interrupts in the system, introducing latencies.
>
> so spin_lock is very expensive and we should avoid if we can?

spin_lock_irqsave, if possible, yes.

> > > but I think we need the ndelay for the else where we do not
> > > have the ready flag (A10 or A13 iirc?)
> > 
> > Hmmmm, good point. But that would also apply to your second patch
> > then, wouldn't it?
> yeah, you would have an if/else for the case of !hasready.
> 
> this is what i've been dabbling in the train last week, but haven't
> thought it through yet, let alone tested it:
> 
> 
> +???????if (!(sun4i_pwm->data->has_rdy))
> +???????????????ndelay(pwm_get_period(pwm));
> +???????else
> +???????????????do {
> +???????????????????????spin_lock(&sun4i_pwm->ctrl_lock);
> +???????????????????????val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> +???????????????????????spin_unlock(&sun4i_pwm->ctrl_lock);
> +???????????????} while (!(val & PWM_RDY(pwm->hwpwm)))
> 
> Here I assumed the spin_lock is cheap to make, expensive to hold for
> long, e.g. reducing the length the spin-lock is active for. the
> alternative was to remove the spin_lock here, and remove unlock-lock
> before-after this block where you basically get a very long lasting
> spin_lock, the alternative.

If you're only reading, why do you need to take the lock?

You probbaly want to have a timeout too.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160927/72cc3f3f/attachment.sig>
