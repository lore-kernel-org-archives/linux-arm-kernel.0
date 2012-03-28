From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 28 Mar 2012 15:25:46 -0700
Subject: [PATCH v7 2/3] clk: introduce the common clock framework
In-Reply-To: <CAJOA=zM0_czNzdqXfJDn8vzfpVLywBvYTg3SxKs6BHUOsRNd9w@mail.gmail.com>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <1331878280-2758-3-git-send-email-mturquette@linaro.org>
 <20120320140220.GE32469@S2101-09.ap.freescale.net>
 <efca11f1b68186dbf1771c09fe3a2f0a.squirrel@www.codeaurora.org>
 <CAJOA=zNmgSQfYAUZ-vqqTk0w3s3eKz3tjVOpyDgO35Q_Ogkz0g@mail.gmail.com>
 <4F6946AA.4070201@codeaurora.org> <4F6CEC0C.4060704@codeaurora.org>
 <CAJOA=zNDKesFtuRgv+6brmBvmbQQecKEOJ89EiG-+YzXVTosWw@mail.gmail.com>
 <4F6CF555.4080109@codeaurora.org>
 <CAJOA=zOnR1NwZ1Cmkfb+b7f7=N_vg+txAUqKXF2Nf2nVYFMjjg@mail.gmail.com>
 <4F6D0167.3040704@codeaurora.org>
 <CAJOA=zM47mB8tY2hV1QDVm1GZRqQrjrktkbLQ-Vp7hBjA8H5xg@mail.gmail.com>
 <4F728050.9030904@codeaurora.org>
 <CAJOA=zM0_czNzdqXfJDn8vzfpVLywBvYTg3SxKs6BHUOsRNd9w@mail.gmail.com>
Message-ID: <4F738FEA.9020109@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2012 10:08 AM, Turquette, Mike wrote:
> On Tue, Mar 27, 2012 at 8:06 PM, Saravana Kannan<skannan@codeaurora.org>  wrote:

snip

>> I think there is still a problem with not being able to differentiate
>> between pre-change recalc and post-change recalc. This applies for any set
>> parent and set rate on a clock that has children.
>>
>> Consider this simple example:
>> * Divider clock B is fed from clock A.
>> * Clock B can never output>  120 MHz due to downstream
>>   HW/clock limitations.
>> * Clock A is running at 200 MHz
>> * Clock B divider is set to 2.
>>
>> Now, say the rate of clock A is changing from 200 MHz to 300 MHz (due to set
>> rate or set parent). In this case, the clock B divider should be set to 3
>> pre-rate change to guarantee that the output of clock B is never>  120 MHz.
>> So the rate of clock B will go from 100 MHz (200/2) to 66 MHz (200/3) to 100
>> MHz (300/3) and everything is good.
>>
>> Assume we somehow managed to do the above. So, now clock A is at 300 MHz,
>> clock B divider is at 3 and the clock B output is 100 MHz.
>>
>> Now, say the rate of clock A changes from 300 MHz to 100 MHz. In this case
>> the clock B divider should only be changed post rate change. If we do it pre
>> rate change, then the output will go from 100 MHz (300/3) to 150 MHz (300/1)
>> to 100 MHz (100/1). We went past the 120 MHz limit of clock B's output rate.
>>
>> If we do this post rate change, we can do this without exceeding the max
>> output limit of clock B. It will go from 100 MHz (300/3) to 33 MHz (100/3)
>> to 100 MHz (100/1). We never went past the 120 MHz limit.
>>
>> So, at least for this reason above, I think we need to pass a pre/post
>> parameter to the recalc ops.

Sorry if I wasn't clear. But the case above is a separate issue from 
what I mention below. What are your thoughts on handling this? Pass 
"msg" to recalc_rates?

>> While we are at it, we should probably just add a failure option for recalc
>> to make it easy to reject unacceptable rate changes. To keep the clock
>> framework code simpler, you could decide to allow errors only for the
>> pre-change recalc calls. That way, the error case roll back code won't be
>> crazy.
>
> recalc is too late to catch this.  I think you mean round_rate.  We
> want to determine which rate changes are out-of-spec during
> clk_calc_new_rates (for clk_set_rate) which involves round_rate being
> a bit smarter about what it can and cannot do.

The case I'm referring to is set_parent(). set_rate() and set_parent() 
have a lot of common implications and it doesn't look like the clock 
framework is handling the common cases the same way for both 
set_parent() and set_rate().

It almost feels like set_parent() and set_rate() should just be wrappers 
around some common function that handles most of the work. After all, 
set_parent() is just a slimmed down version of set_rate(). Set rate is 
just a combination of set parent and set divider.

>
> Anyways I'm looking at ways to do this in my clk-dependencies branch.
>

Are you also looking into the pre/post rate change divider handling case 
I mentioned above?

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
