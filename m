From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 14 May 2012 14:36:34 -0700
Subject: moving Tegra30 to the common clock framework
In-Reply-To: <4FADD1EA.8090606@codeaurora.org>
References: <20120503161311.GG20304@tbergstrom-lnx.Nvidia.com>
 <20120507000329.GB14559@gmail.com> <4FA7ECAA.1040104@wwwdotorg.org>
 <CAJOA=zNKDFPOQ9-0EuEy=dtq=g-CKFBq94enTuoB7wVPskbkMg@mail.gmail.com>
 <CAAXpJNsJiT7s87p6jS5bdi-83n4bwSaagdSK0w3SbrVz+k+O0g@mail.gmail.com>
 <CAJOA=zP4iEZ+CFfCjT1rgU6shOt_PUf2BRB76NEQCoUPZJ9hVg@mail.gmail.com>
 <4FA9BD41.2090701@codeaurora.org>
 <20120509103606.GY20304@tbergstrom-lnx.Nvidia.com>
 <4FADD1EA.8090606@codeaurora.org>
Message-ID: <20120514213634.GA3075@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 7:58 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> Mike,
>
> I was looking at the code to make the changes and I noticed this snippet
> (reformatted for email) in clk_change_rate():
>
> ? ? ? if (clk->ops->set_rate)
> ? ? ? ? ? ? ? ?clk->ops->set_rate(clk->hw, clk->new_rate,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?clk->parent->rate);
>
>
> ? ? ? ?if (clk->ops->recalc_rate)
> ? ? ? ? ? ? ? ?clk->rate = clk->ops->recalc_rate(clk->hw,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?clk->parent->rate);
> ? ? ? ?else
> ? ? ? ? ? ? ? ?clk->rate = clk->parent->rate;
>
> I'm a bit confused. I thought recalc_rates was optional. But if I don't
> implement it, the clocks rate will get set to parent's rate? Or is that a
> bug in the code?
>

It is not a bug.  The handsome ascii art in Documentation/clk.txt covers
this requirement.  I have copy/pasted the relevant bits below for
convenience:

                           clock hardware characteristics
	     -----------------------------------------------------------
             | gate | change rate | single parent | multiplexer | root |
             |------|-------------|---------------|-------------|------|
	     				...
             |      |             |               |             |      |
.recalc_rate |      | y           |               |             |      |
.round_rate  |      | y           |               |             |      |
.set_rate    |      | y           |               |             |      |
					...
             |      |             |               |             |      |
	     -----------------------------------------------------------

The take-away is that a clock that can adjust its rate (eg: implements a
.set_rate callback) must also implement .recalc_rate and .round_rate
callbacks.

> Also, if the clock's rate was just set with set_rate, why do we need to
> recalc the rate by reading hardware? I'm a bit confused. Can you please
> clarify what's going on here?
>

This is simply being very cautious.  For platforms adjusting dividers
with direct register writes this might feel unnecessary.  However this
strict checking is in anticipation of clock hardware that might not
actually output the precise rate passed into .set_rate.  In principal
this isn't different from how CPUfreq and devfreq drivers inspect rates
after requesting them.

> Would you mind adding more comments inside clk_calc_new_rates() and
> clk_change_rate() trying to explain what cases you are trying to account
> for?
>

Someday I'll have a comment/kerneldoc cleanup session.  Things in the
clock core are likely to change in the next couple of release cycles
which will deprecate some of the kerneldoc making a big cleanup
unavoidable.

In the mean time are there any other specific question you have for
clk_change_rate?

> Also, in clk_calc_new_rates(),
>
> ? ? ? ?if (!clk->ops->round_rate) {
> ? ? ? ? ? ? ? ?top = clk_calc_new_rates(clk->parent, rate);
> ? ? ? ? ? ? ? ?new_rate = clk->parent->new_rate;
>
> ? ? ? ? ? ? ? ?goto out;
> ? ? ? ?}
>
> Is the code assuming that if there is no round rate ops that that clock node
> is only a gating clock (as in, can't change frequency the input freq)? Just
> trying to understand the assumptions made in the code.
>

This is also covered by the ascii art above.  There is no assumption
about gating, per se.  However if a clock can adjust it's rate (more
specifically, if the input rate for a clock differs from the output
rate) then a .round_rate callback must exist.

The code above reads like it does because in the absence of a
.round_rate callback it is implied that the clock cannot set it's own
rate and should thus rely on its parent's rate.

Regards,
Mike

>
> Thanks,
> Saravana
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
