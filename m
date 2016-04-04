From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 4 Apr 2016 17:30:29 +0200
Subject: [PATCH v5 34/46] clk: pwm: switch to the atomic API
In-Reply-To: <20160331085735.3574970b@bbrezillon>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-35-git-send-email-boris.brezillon@free-electrons.com>
 <20160330220149.GU18567@codeaurora.org>
 <20160331085735.3574970b@bbrezillon>
Message-ID: <20160404153029.GC17856@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 08:57:35AM +0200, Boris Brezillon wrote:
> Hi Stephen,
> 
> On Wed, 30 Mar 2016 15:01:49 -0700
> Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > On 03/30, Boris Brezillon wrote:
> > > diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> > > index ebcd738..49ec5b1 100644
> > > --- a/drivers/clk/clk-pwm.c
> > > +++ b/drivers/clk/clk-pwm.c
> > > @@ -28,15 +28,29 @@ static inline struct clk_pwm *to_clk_pwm(struct clk_hw *hw)
> > >  static int clk_pwm_prepare(struct clk_hw *hw)
> > >  {
> > >  	struct clk_pwm *clk_pwm = to_clk_pwm(hw);
> > > +	struct pwm_state pstate;
> > >  
> > > -	return pwm_enable(clk_pwm->pwm);
> > > +	pwm_get_state(clk_pwm->pwm, &pstate);
> > > +	if (pstate.enabled)
> > > +		return 0;
> > > +
> > > +	pstate.enabled = true;
> > > +
> > > +	return pwm_apply_state(clk_pwm->pwm, &pstate);
> > 
> > This doesn't seem atomic anymore if we're checking the state and
> > then not calling apply_state if it's already enabled. But I
> > assume this doesn't matter because we "own" the pwm here?
> 
> Yep. Actually it's not atomic in term of concurrency (maybe the
> 'atomic' word is not appropriate here). Atomicity is here referring to
> the fact that we're now providing all the PWM parameters in the same
> request instead of splitting it in pwm_config() + pwm_enable/disable()
> calls.

It's usually not possible to do really atomic updates with PWM hardware.
The idea is merely that we should be able to submit one request and the
framework (and drivers) will be responsible for making sure it is
applied as a whole or not at all. With the legacy API it is possible for
users to set the duty cycle and period, but then fail to enable/disable
the PWM.

pwm_apply_state() reporting success should indicate that the hardware
state is now what software wanted it to be. That kind of implies that
the application is serialized.

This doesn't imply that hardware state won't change between a call to
pwm_get_state() and pwm_apply_state(), though technically this is what
will usually happen because PWM devices are exclusively used by a single
user. Users are responsible for synchronizing accesses within their own
code.

> Concurrent accesses still have to be controlled by the PWM user (which
> is already the case for this driver, thanks to the locking
> infrastructure in the CCF).
> 
> > Otherwise I would think this would be unconditional apply state
> > and duplicates would be ignored in the pwm framework.
> > 
> 
> Yep, I'll remove the if (pstate.enabled) branch.

Yes, it should be the PWM framework's job to check for changes in state
and discard no-ops.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160404/5ebc1791/attachment-0001.sig>
