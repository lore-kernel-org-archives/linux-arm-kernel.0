From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 23 Mar 2012 16:04:07 -0700
Subject: [PATCH v7 2/3] clk: introduce the common clock framework
In-Reply-To: <CAJOA=zOnR1NwZ1Cmkfb+b7f7=N_vg+txAUqKXF2Nf2nVYFMjjg@mail.gmail.com>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <1331878280-2758-3-git-send-email-mturquette@linaro.org>
 <20120320140220.GE32469@S2101-09.ap.freescale.net>
 <efca11f1b68186dbf1771c09fe3a2f0a.squirrel@www.codeaurora.org>
 <CAJOA=zNmgSQfYAUZ-vqqTk0w3s3eKz3tjVOpyDgO35Q_Ogkz0g@mail.gmail.com>
 <4F6946AA.4070201@codeaurora.org> <4F6CEC0C.4060704@codeaurora.org>
 <CAJOA=zNDKesFtuRgv+6brmBvmbQQecKEOJ89EiG-+YzXVTosWw@mail.gmail.com>
 <4F6CF555.4080109@codeaurora.org>
 <CAJOA=zOnR1NwZ1Cmkfb+b7f7=N_vg+txAUqKXF2Nf2nVYFMjjg@mail.gmail.com>
Message-ID: <4F6D0167.3040704@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2012 03:32 PM, Turquette, Mike wrote:
> On Fri, Mar 23, 2012 at 3:12 PM, Saravana Kannan<skannan@codeaurora.org>  wrote:
>> On 03/23/2012 02:39 PM, Turquette, Mike wrote:
>>> __clk_recalc_rates is called by __clk_reparent which is called by
>>> clk_set_parent.  __clk_recalc_rates is also called by clk_set_rate.
>>>
>>> Does this not handle the old cached clk->rate for you?
>>
>> For the set_parent case, ops->recalc_rate() is called twice. Once for
>> PRE_CHANGE and once for POST_CHANGE. For this clock, I can only really
>> recalc the rate during the POST_CHANGE call. So, how should I differentiate
>> the two cases?
>
> .recalc_rate serves two purposes: first it recalculates the rate after
> the rate has changed and you pass in a new parent_rate argument.  The
> second purpose is to "speculate" a rate change.  You can pass in any
> rate for the parent_rate parameter when you call .recalc_rates.  This
> is what __speculate_rates does before the rate changes.  For
> clk_set_parent we call,
>
> __clk_speculate_rates(clk, parent->rate);
>
> Where parent above is the *new* parent.  So this will let us propagate
> pre-rate change notifiers with the new rate.
>
> Your .recalc_rate callback doesn't need to differentiate between the
> two calls to .recalc_rate.  It should just take in the parent_rate
> value and do the calculation required of it.

Yeah, this is generally true. But, in this specific case, the clock is a 
mux that can literally measure the real rate. I would like the rate of 
this mux clock to be the real measured rate and not just the parent rate.

I could actually measure the current rate and return that for 
recalc_rate(), but then the reported rate change during the pre-change 
notification would be wrong. Having the "msg" will let us at least fake 
the rate correctly for pre change notifiers.

>> I think it's quite useful for recalc_rate to be called pre/post change (some
>> steps have to be done pre/post change depending on whether the parent rate
>> is increasing or decreasing). But I don't see the "msg" being passed along.
>
> What kind of steps?  Does your .recalc_rate perform these steps?  I
> need more details to understand your requirements.

Nevermind, my brain isn't working today. I can just do that different 
ordering in ops->set_parent(). But the measure clocks case is still true 
though.

But this did bring up another point in my head. Hopefully this one isn't 
my brain playing tricks again today.

How does a child (or grand child) clock (not a driver using the clock) 
reject a rate change if it know it can't handle that freq from the 
parent? I won't claim to know this part of the code thoroughly, but I 
can't find an easy way to do this.

Reason for rejection could be things like the counter (for division, 
etc) has an upper limit on how fast it can run.

>> Also, I noticed that clk_set_parent() is treating a NULL as an invalid
>> clock. Should that be fixed? set_parent(NULL) could be treated as a
>> grounding the clock. Should we let the ops->set_parent determine if NULL is
>> valid option?
>
> We must be looking at different code.  clk_set_parent doesn't return
> any error if parent == NULL.  Bringing this to my attention does show
> that we do deref the parent pointer without a check though...
>
> Do you have a real use case for this?  Due to the way that we match
> the parent pointer with the cached clk->parents member it would be
> painful to support NULL parents as valid.

I don't have a real use case for MSM. We just have a ground_clock.

> It is also worth considering whether clk_set_parent is really the
> correct operation for grounding a clock.  clk_unprepare might be a
> better candidate.

Yeah, not a real use case for MSM.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
