From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 15 Dec 2010 20:47:52 +0530
Subject: [PATCH 1/5] OMAP4: PM: Use the lowpwrstatechange feature on OMAP4
In-Reply-To: <87zks8rv3b.fsf@deeprootsystems.com>
References: <1292276969-29733-1-git-send-email-b-cousson@ti.com><1292276969-29733-2-git-send-email-b-cousson@ti.com>
	<87zks8rv3b.fsf@deeprootsystems.com>
Message-ID: <c454400af490d75c274f19a5d0a5a655@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

<snip>..

> >  	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
> > +		if ((pwrdm_read_pwrst(pwrdm) > state) &&
> > +			(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
> > +				ret = pwrdm_set_next_pwrst(pwrdm, state);
> > +				pwrdm_set_lowpwrstchange(pwrdm);
> > +				pwrdm_wait_transition(pwrdm);
> > +				pwrdm_state_switch(pwrdm);
> > +				return ret;
>
> Personally, I'd prefer if this function flowed through better instead of
> the early return in order to emphasize the common code.
>
> Rather than the return here, can you just set the low-power state change
> bit here (and put the clkdm_wakeup + sleep_switch = 1 into the else
> clause?
>
> Or, does the next state have to be set before the low-power state change
> bit?

Yes, that sequencing is needed.

>
> Basically, what I'm getting at is this should be a single function with
> common flow.  The conditional code based on low-power state change
> should be isolated instead of having a special path.

I get your point. See if the below approach looks better.
If it looks fine, I'll do some more testing (currently only tested
on OMAP4430sdp) and repost the 2 patches.
