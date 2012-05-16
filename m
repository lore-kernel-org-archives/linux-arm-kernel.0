From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 15 May 2012 22:36:20 -0700
Subject: moving Tegra30 to the common clock framework
In-Reply-To: <4FB1D992.9050102@codeaurora.org>
References: <20120507000329.GB14559@gmail.com> <4FA7ECAA.1040104@wwwdotorg.org>
 <CAJOA=zNKDFPOQ9-0EuEy=dtq=g-CKFBq94enTuoB7wVPskbkMg@mail.gmail.com>
 <CAAXpJNsJiT7s87p6jS5bdi-83n4bwSaagdSK0w3SbrVz+k+O0g@mail.gmail.com>
 <CAJOA=zP4iEZ+CFfCjT1rgU6shOt_PUf2BRB76NEQCoUPZJ9hVg@mail.gmail.com>
 <4FA9BD41.2090701@codeaurora.org>
 <20120509103606.GY20304@tbergstrom-lnx.Nvidia.com>
 <4FADD1EA.8090606@codeaurora.org> <20120514213634.GA3075@gmail.com>
 <4FB199B5.5010607@codeaurora.org> <20120515020033.GD3075@gmail.com>
 <4FB1D992.9050102@codeaurora.org>
Message-ID: <CAJOA=zNtxhSudvpVpba7vfZ2PWNHf3nqWyRy7xgS5muXFq6Niw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 9:20 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 05/14/2012 07:00 PM, Mike Turquette wrote:
> I agree the with the need for recalc_rates you mentioned above (parent
> changes rate and it will affect children). But I still don't get why you
> have to recalc the rate of the clock that you just set. Can you please give
> an example?

I don't have a clock that needs "immediate recalculation after setting
it's rate".  However the code is not incorrect as-is, just suboptimal.
 I'm not currently looking into improving this since I have bigger
problems to solve.  Patches are welcome, otherwise I'll toss it on the
back-burner and fix it up some day (not for initial 3.5 merge window).

>> I'm willing to discuss removing the (sometimes) redundant .recalc_rate
>> calls immediately following .set_rate
>
> Yes, please. This was one of the main points of my previous email.

Same as above.

>> (since we basically perform a
>> preemptive .recalc_rate in clk_calc_subtree, called by clk_calc_rates).
>
>
> Do you do a recalc on the clock that the clk_set_rate() is called on? You
> only seem to make the preemptive calls on the children. Which makes sense
> (But I have one concern. I will get to it at the end).

Preemptive calls happen once only, in a cascade starting from the
"top" clock (which may or may not be the original clock in the
clk_set_rate call due to upwards parent propagation).

However we do recalc the rate for each clock (even after calling its
.set_rate callback) in clk_change_rate.  This could be improved, but
I'm not looking at it right now.

...
> For example, there are several PLLs in MSM that get their input from a fixed
> crystal oscillator. There's no point in implementing recalc_rate for them
> (except for figuring out the rate during init).

I still feel that, fundamentally, any clock which can output a
different rate than is fed into must implement .recalc_rates.  The set
of clocks which can output a different rate than their input often
exceeds the set of clocks that implement .set_rate (as evidenced by my
fixed-divide-by-2 example).  But forcing a check for .recalc_rate on
clocks that implement .set_rate at least helps us catch some which
should implement and do not.

For your PLLs which are fed from a fixed input clock, we can optimize
the code to not _call_ .recalc_rates unnecessarily.  But some day when
your chip changes and you have multiple inputs to your PLLs or an
adjustable rate parent you'll be glad you had .recalc_rates
implemented and ready to go.  It's simply a matter of correctness.

> Which brings me to another point:
> I think we should split out the "figure out the clock's rate during
> boot/init" to a separate op. That operation by definition has to go through
> many registers, and if it's a rate settable clock, go through all the
> possible frequencies to figure out the rate. That seems too expensive for
> something that's done often like .recalc_rate. In pretty much every other
> call to .recalc_rate, it doesn't really need to check the hardware. It just
> needs to recompute the rate based on the software model of that clock. If we
> do add this new op (say, .sync), the expense of calling .recalc_rate after
> calling .set_rate would be much much lower and I won't really complain much
> about it (would still be nice to not do it).

This is also worth thinking about, but it changes the existing
interfaces for clock code to implement and it's yet another
optimization.  So patches are welcome, otherwise I'll toss it onto the
stack somewhere.

Regards,
Mike
