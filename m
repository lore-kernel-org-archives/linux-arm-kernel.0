From: mturquette@ti.com (Mike Turquette)
Date: Mon, 14 May 2012 19:00:33 -0700
Subject: moving Tegra30 to the common clock framework
In-Reply-To: <4FB199B5.5010607@codeaurora.org>
References: <20120507000329.GB14559@gmail.com> <4FA7ECAA.1040104@wwwdotorg.org>
 <CAJOA=zNKDFPOQ9-0EuEy=dtq=g-CKFBq94enTuoB7wVPskbkMg@mail.gmail.com>
 <CAAXpJNsJiT7s87p6jS5bdi-83n4bwSaagdSK0w3SbrVz+k+O0g@mail.gmail.com>
 <CAJOA=zP4iEZ+CFfCjT1rgU6shOt_PUf2BRB76NEQCoUPZJ9hVg@mail.gmail.com>
 <4FA9BD41.2090701@codeaurora.org>
 <20120509103606.GY20304@tbergstrom-lnx.Nvidia.com>
 <4FADD1EA.8090606@codeaurora.org> <20120514213634.GA3075@gmail.com>
 <4FB199B5.5010607@codeaurora.org>
Message-ID: <20120515020033.GD3075@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120514-16:48, Saravana Kannan wrote:
> On 05/14/2012 02:36 PM, Turquette, Mike wrote:
> >On Fri, May 11, 2012 at 7:58 PM, Saravana Kannan<skannan@codeaurora.org>  wrote:
> >>Mike,
> >>
> >>I was looking at the code to make the changes and I noticed this snippet
> >>(reformatted for email) in clk_change_rate():
> >>
> >>       if (clk->ops->set_rate)
> >>                clk->ops->set_rate(clk->hw, clk->new_rate,
> >>                                        clk->parent->rate);
> >>
> >>
> >>        if (clk->ops->recalc_rate)
> >>                clk->rate = clk->ops->recalc_rate(clk->hw,
> >>                                clk->parent->rate);
> >>        else
> >>                clk->rate = clk->parent->rate;
> >>
> >>I'm a bit confused. I thought recalc_rates was optional. But if I don't
> >>implement it, the clocks rate will get set to parent's rate? Or is that a
> >>bug in the code?
> >>
> >
> >It is not a bug.  The handsome ascii art in Documentation/clk.txt covers
> >this requirement.  I have copy/pasted the relevant bits below for
> >convenience:
> >
> >                            clock hardware characteristics
> >	     -----------------------------------------------------------
> >              | gate | change rate | single parent | multiplexer | root |
> >              |------|-------------|---------------|-------------|------|
> >	     				...
> >              |      |             |               |             |      |
> >.recalc_rate |      | y           |               |             |      |
> >.round_rate  |      | y           |               |             |      |
> >.set_rate    |      | y           |               |             |      |
> >					...
> >              |      |             |               |             |      |
> >	     -----------------------------------------------------------
> >
> >The take-away is that a clock that can adjust its rate (eg: implements a
> >.set_rate callback) must also implement .recalc_rate and .round_rate
> >callbacks.
> 
> I get the round_rate ops part. But I don't see a need to force a
> recalc_rate ops. Can we just check for the existence of .set_rate()
> to figure out if the clock will take up the rate of the parent or
> will output a different rate?
> 

I think you are forgetting the case where a clock can adjust its output
rate but doesn't always have its .set_rate callback called.  The trivial
example of this is an adjustable divider that is downstream from some
parent clock whose rate is being changed.  In any such case it is quite
necessary to have a .recalc_rate callback on the downstream clock.

The sanity checks in __clk_init (and the documenation) make it clear
that .recalc_rate callbacks must exist due to this exact scenario.  I
guess we could leave it up to the implementor to "get it right" and only
provide .recalc_rate callbacks for clocks whose parents' rates might
change, but why take that risk?

> >
> >>Also, if the clock's rate was just set with set_rate, why do we need to
> >>recalc the rate by reading hardware? I'm a bit confused. Can you please
> >>clarify what's going on here?
> >>
> >
> >This is simply being very cautious.  For platforms adjusting dividers
> >with direct register writes this might feel unnecessary.  However this
> >strict checking is in anticipation of clock hardware that might not
> >actually output the precise rate passed into .set_rate.  In principal
> >this isn't different from how CPUfreq and devfreq drivers inspect rates
> >after requesting them.
> 
> Sorry, this still doesn't make much sense to me. This essentially
> means we can't trust the HW to do what we are asking it to do?
> 

My bit about being "cautious" above is not the driving force behind the
requirement for implementing .recalc_rate.  I thought that you were
specifically complaining about calling .recalc_rate AFTER we called
.set_rate, in which case my point above stands from the perspective of
being future-proof.

Your hardware even has a feature to sample it's own frequency at
run-time... does that mean your hardware doesn't trust itself?

Let's move past the "I don't trust the hardware" bit for a second.  It
is clear to me in your latest email that you not only think that we
should not call .recalc_rate immediately following a call to .set_rate
(which is an interesting point to discuss) but you also feel that we
should not have a requirement to implement .recalc_rate on clocks that
can adjust their rate again.

I'll only repeat what I said at the top of this email: for the scenario
where an adjustable-rate clock can have a parents' rate change it is
absolutely necessary to implement .recalc_rate to correctly determine
the chain of rates as we propagate down the tree.  That we force this at
the framework level is simply good design.

I'm willing to discuss removing the (sometimes) redundant .recalc_rate
calls immediately following .set_rate (since we basically perform a
preemptive .recalc_rate in clk_calc_subtree, called by clk_calc_rates).
But to assert that we can entirely remove the requirement to implement
.recalc_rates on clocks that support .set_rate sounds insane to me.

Please let me know if I've misunderstood what you meant by the
statement, "I don't see a need to force a recalc_rate ops".

> Can we do something like this in clk_change_rate()?
> 
> if (ops->set_rate) {
> 	ops->set_rate(clk->new_rate,...);
> 	clk->rate = clk->new_rate;
> } else {
> 	clk->rate = clk->parent->rate;
> }
> 
> if (ops->recalc_rate()) {
> 	clk->rate = ops->recalc_rate(...);
> }
> 
> This code also makes the assumptions more intuitive and easy to understand.
> 

What does this code buy us?

There is absolutely no difference in this code and it is misleading.
For the case where we do not implement .set_rate but we do implement
.recalc_rate (consider a fixed divide-by-2) this code would assign
clk->rate twice.

Furthermore we must still implement .recalc_rate in an adjustable-rate
clock for the case where a parent rate can change.  Thus every
adjustable-rate clock that implements .set_rate will also implement
.recalc_rate and both will get called in the code above, so we've gained
nothing here.

Your code above is functionally equivalent to the current
clk_change_rate but assigns clk->rate in three different places and is
more confusing.

> >>Would you mind adding more comments inside clk_calc_new_rates() and
> >>clk_change_rate() trying to explain what cases you are trying to account
> >>for?
> >>
> >
> >Someday I'll have a comment/kerneldoc cleanup session.  Things in the
> >clock core are likely to change in the next couple of release cycles
> >which will deprecate some of the kerneldoc making a big cleanup
> >unavoidable.
> >
> >In the mean time are there any other specific question you have for
> >clk_change_rate?
> >
> >>Also, in clk_calc_new_rates(),
> >>
> >>        if (!clk->ops->round_rate) {
> >>                top = clk_calc_new_rates(clk->parent, rate);
> >>                new_rate = clk->parent->new_rate;
> >>
> >>                goto out;
> >>        }
> >>
> >>Is the code assuming that if there is no round rate ops that that clock node
> >>is only a gating clock (as in, can't change frequency the input freq)? Just
> >>trying to understand the assumptions made in the code.
> >>
> >
> >This is also covered by the ascii art above.  There is no assumption
> >about gating, per se.  However if a clock can adjust it's rate (more
> >specifically, if the input rate for a clock differs from the output
> >rate) then a .round_rate callback must exist.
> >
> >The code above reads like it does because in the absence of a
> >.round_rate callback it is implied that the clock cannot set it's own
> >rate and should thus rely on its parent's rate.
> 
> I agree that anyone implementing .set_rate should also provide
> .round_rate. May be we should enforce that in clk_init/clk_register?
> 

It is enforced already.  Please review __clk_init.  I hope that after
reading this email you agree that anyone implementing .set_rate must
also implement .recalc_rate.

> But can we please the above "if" check more explicit? "Your rate has
> to be same as the parent rate since you don't implement set rate" is
> clearer than "Your rate has to be the same as the parent rate since
> you don't implement round rate".
> 
> 	if (!clk->ops->set_rate) {
> 		top = clk_calc_new_rates(clk->parent, rate);
> 		new_rate = clk->parent->new_rate;
> 
> 		goto out;
> 	}

I like that we check the function pointer before calling it.  That is
sane.

Anyone that has read Documentation/clk.txt or reviewed the sanity checks
in __clk_init should realize the relationship between .set_rate,
.round_rate and .recalc_rate.  I see no reason to make the change above.

Regards,
Mike
