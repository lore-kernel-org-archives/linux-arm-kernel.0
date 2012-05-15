From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 14 May 2012 21:20:34 -0700
Subject: moving Tegra30 to the common clock framework
In-Reply-To: <20120515020033.GD3075@gmail.com>
References: <20120507000329.GB14559@gmail.com> <4FA7ECAA.1040104@wwwdotorg.org>
 <CAJOA=zNKDFPOQ9-0EuEy=dtq=g-CKFBq94enTuoB7wVPskbkMg@mail.gmail.com>
 <CAAXpJNsJiT7s87p6jS5bdi-83n4bwSaagdSK0w3SbrVz+k+O0g@mail.gmail.com>
 <CAJOA=zP4iEZ+CFfCjT1rgU6shOt_PUf2BRB76NEQCoUPZJ9hVg@mail.gmail.com>
 <4FA9BD41.2090701@codeaurora.org>
 <20120509103606.GY20304@tbergstrom-lnx.Nvidia.com>
 <4FADD1EA.8090606@codeaurora.org> <20120514213634.GA3075@gmail.com>
 <4FB199B5.5010607@codeaurora.org> <20120515020033.GD3075@gmail.com>
Message-ID: <4FB1D992.9050102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2012 07:00 PM, Mike Turquette wrote:
> On 20120514-16:48, Saravana Kannan wrote:
>> On 05/14/2012 02:36 PM, Turquette, Mike wrote:
>>> On Fri, May 11, 2012 at 7:58 PM, Saravana Kannan<skannan@codeaurora.org>   wrote:
>>>> Mike,
>>>>

<snip>

>>> The take-away is that a clock that can adjust its rate (eg: implements a
>>> .set_rate callback) must also implement .recalc_rate and .round_rate
>>> callbacks.
>>
>> I get the round_rate ops part. But I don't see a need to force a
>> recalc_rate ops. Can we just check for the existence of .set_rate()
>> to figure out if the clock will take up the rate of the parent or
>> will output a different rate?
>>
>
> I think you are forgetting the case where a clock can adjust its output
> rate but doesn't always have its .set_rate callback called.  The trivial
> example of this is an adjustable divider that is downstream from some
> parent clock whose rate is being changed.  In any such case it is quite
> necessary to have a .recalc_rate callback on the downstream clock.
 >
> The sanity checks in __clk_init (and the documenation) make it clear
> that .recalc_rate callbacks must exist due to this exact scenario.  I
> guess we could leave it up to the implementor to "get it right" and only
> provide .recalc_rate callbacks for clocks whose parents' rates might
> change, but why take that risk?

My comment about forcing recalc rates is limited to "a clock that can 
adjust its rate (eg: implements a .set_rate callback) must also 
implement .recalc_rate.". As you mention, this is really a function of 
whether the parent rate can change or not.

I stand corrected on my orthogonal point that "if .set_rate is not 
implemented, we can assume the rate matches the parent".

>>>> Also, if the clock's rate was just set with set_rate, why do we need to
>>>> recalc the rate by reading hardware? I'm a bit confused. Can you please
>>>> clarify what's going on here?
>>>>
>>>
>>> This is simply being very cautious.  For platforms adjusting dividers
>>> with direct register writes this might feel unnecessary.  However this
>>> strict checking is in anticipation of clock hardware that might not
>>> actually output the precise rate passed into .set_rate.  In principal
>>> this isn't different from how CPUfreq and devfreq drivers inspect rates
>>> after requesting them.
>>
>> Sorry, this still doesn't make much sense to me. This essentially
>> means we can't trust the HW to do what we are asking it to do?
>>
>
> My bit about being "cautious" above is not the driving force behind the
> requirement for implementing .recalc_rate.  I thought that you were
> specifically complaining about calling .recalc_rate AFTER we called
> .set_rate, in which case my point above stands from the perspective of
> being future-proof.

I agree the with the need for recalc_rates you mentioned above (parent 
changes rate and it will affect children). But I still don't get why you 
have to recalc the rate of the clock that you just set. Can you please 
give an example?

> Your hardware even has a feature to sample it's own frequency at
> run-time... does that mean your hardware doesn't trust itself?

No. This is for debugging the software.

<snip>

> but you also feel that we
> should not have a requirement to implement .recalc_rate on clocks that
> can adjust their rate again.

I never questioned the need for recalc rates. I also didn't make the 
above blanket statement -- in fact, I was saying the opposite.

My point was whether we needed to check for .recalc_rates or if we can 
just look for .set_rate to figure out if the clock will take the 
parent's rate. Your fixed factor div-2 example corrected me on that point.

> I'm willing to discuss removing the (sometimes) redundant .recalc_rate
> calls immediately following .set_rate

Yes, please. This was one of the main points of my previous email.

> (since we basically perform a
> preemptive .recalc_rate in clk_calc_subtree, called by clk_calc_rates).

Do you do a recalc on the clock that the clk_set_rate() is called on? 
You only seem to make the preemptive calls on the children. Which makes 
sense (But I have one concern. I will get to it at the end).

> But to assert that we can entirely remove the requirement to implement
> .recalc_rates on clocks that support .set_rate sounds insane to me.
>
> Please let me know if I've misunderstood what you meant by the
> statement, "I don't see a need to force a recalc_rate ops".

Yeah, I think you mistook my comment that was specific to clocks that 
implement set rate as applying to all clocks.

<snip>

> I hope that after
> reading this email you agree that anyone implementing .set_rate must
> also implement .recalc_rate.

This is the original point I raised. To be clear, I'm not denying the 
need for .recalc_rate. I'm just saying that it's not related to 
.set_rate(). As you mentioned in your response above, this is not really 
a function of whether a clock can set it's rate or not. It's a function 
of whether a parent's rate can change. So, I don't see why we should 
arbitrarily tie it to .set_rate.

For example, there are several PLLs in MSM that get their input from a 
fixed crystal oscillator. There's no point in implementing recalc_rate 
for them (except for figuring out the rate during init).

Which brings me to another point:
I think we should split out the "figure out the clock's rate during 
boot/init" to a separate op. That operation by definition has to go 
through many registers, and if it's a rate settable clock, go through 
all the possible frequencies to figure out the rate. That seems too 
expensive for something that's done often like .recalc_rate. In pretty 
much every other call to .recalc_rate, it doesn't really need to check 
the hardware. It just needs to recompute the rate based on the software 
model of that clock. If we do add this new op (say, .sync), the expense 
of calling .recalc_rate after calling .set_rate would be much much lower 
and I won't really complain much about it (would still be nice to not do 
it).

Regards,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
