From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 17 May 2016 13:11:47 +0200
Subject: [PATCH] pwm: Fill pwm->args before calling pwm_request_from_chip()
In-Reply-To: <20160517110438.GB26166@ulmo.ba.sec>
References: <1463481333-23438-1-git-send-email-boris.brezillon@free-electrons.com>
 <1463481333-23438-2-git-send-email-boris.brezillon@free-electrons.com>
 <20160517110438.GB26166@ulmo.ba.sec>
Message-ID: <20160517131147.7f505f2b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 May 2016 13:04:38 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Tue, May 17, 2016 at 12:35:33PM +0200, Boris Brezillon wrote:
> [...]
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 427142d..3d2eeaa 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -143,10 +143,6 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
> >  	if (args->args[0] >= pc->npwm)
> >  		return ERR_PTR(-EINVAL);
> >  
> > -	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
> > -	if (IS_ERR(pwm))
> > -		return pwm;
> > -
> >  	pwm->args.period = args->args[1];
> >  
> >  	if (args->args[2] & PWM_POLARITY_INVERTED)
> > @@ -154,6 +150,10 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
> >  	else
> >  		pwm->args.polarity = PWM_POLARITY_NORMAL;
> >  
> > +	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
> > +	if (IS_ERR(pwm))
> > +		return pwm;
> > +  
> 
> Can't do that, because now you're dereferencing an uninitialized
> pointer.

Yes, forget this patch, it's not needed anyway since all PWM users are
now directly calling pwm_apply_args() after requesting the PWM. The bad
news is I broke bisectibilty :-(.

Still does not explain the bug reported by Mika.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
