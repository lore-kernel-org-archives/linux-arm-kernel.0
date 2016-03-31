From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 31 Mar 2016 08:57:35 +0200
Subject: [PATCH v5 34/46] clk: pwm: switch to the atomic API
In-Reply-To: <20160330220149.GU18567@codeaurora.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-35-git-send-email-boris.brezillon@free-electrons.com>
 <20160330220149.GU18567@codeaurora.org>
Message-ID: <20160331085735.3574970b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, 30 Mar 2016 15:01:49 -0700
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 03/30, Boris Brezillon wrote:
> > diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> > index ebcd738..49ec5b1 100644
> > --- a/drivers/clk/clk-pwm.c
> > +++ b/drivers/clk/clk-pwm.c
> > @@ -28,15 +28,29 @@ static inline struct clk_pwm *to_clk_pwm(struct clk_hw *hw)
> >  static int clk_pwm_prepare(struct clk_hw *hw)
> >  {
> >  	struct clk_pwm *clk_pwm = to_clk_pwm(hw);
> > +	struct pwm_state pstate;
> >  
> > -	return pwm_enable(clk_pwm->pwm);
> > +	pwm_get_state(clk_pwm->pwm, &pstate);
> > +	if (pstate.enabled)
> > +		return 0;
> > +
> > +	pstate.enabled = true;
> > +
> > +	return pwm_apply_state(clk_pwm->pwm, &pstate);
> 
> This doesn't seem atomic anymore if we're checking the state and
> then not calling apply_state if it's already enabled. But I
> assume this doesn't matter because we "own" the pwm here?

Yep. Actually it's not atomic in term of concurrency (maybe the
'atomic' word is not appropriate here). Atomicity is here referring to
the fact that we're now providing all the PWM parameters in the same
request instead of splitting it in pwm_config() + pwm_enable/disable()
calls.

Concurrent accesses still have to be controlled by the PWM user (which
is already the case for this driver, thanks to the locking
infrastructure in the CCF).

> Otherwise I would think this would be unconditional apply state
> and duplicates would be ignored in the pwm framework.
> 

Yep, I'll remove the if (pstate.enabled) branch.

Thanks for your review.

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
