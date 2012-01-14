From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 13 Jan 2012 20:18:34 -0800
Subject: [PATCH v4 3/6] clk: introduce the common clock framework
In-Reply-To: <20111217110433.GC14547@n2100.arm.linux.org.uk>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
 <1323834838-2206-4-git-send-email-mturquette@linaro.org>
 <alpine.LFD.2.02.1112141007550.3020@ionos>
 <CAJOA=zO=gM2r4pCVo+orLqE9Q1SSw4h5nXsAHo-e_SHZAfvKDA@mail.gmail.com>
 <20111217110433.GC14547@n2100.arm.linux.org.uk>
Message-ID: <4F11021A.8070407@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2011 03:04 AM, Russell King - ARM Linux wrote:
> On Fri, Dec 16, 2011 at 04:45:48PM -0800, Turquette, Mike wrote:
>> On Wed, Dec 14, 2011 at 5:18 AM, Thomas Gleixner<tglx@linutronix.de>  wrote:
>>> On Tue, 13 Dec 2011, Mike Turquette wrote:
>>>> +void __clk_unprepare(struct clk *clk)
>>>> +{
>>>> +     if (!clk)
>>>> +             return;
>>>> +
>>>> +     if (WARN_ON(clk->prepare_count == 0))
>>>> +             return;
>>>> +
>>>> +     if (--clk->prepare_count>  0)
>>>> +             return;
>>>> +
>>>> +     WARN_ON(clk->enable_count>  0);
>>>
>>> So this leaves the clock enable count set. I'm a bit wary about
>>> that. Shouldn't it either return (including bumping the prepare_count
>>> again) or call clk_disable() ?
>
> No it should not.
>
>> I've hit this in my port of OMAP.  It comes from this simple situation:
>>
>> driver 1 (adapted for clk_prepare/clk_unprepare):
>> clk_prepare(clk);
>> clk_enable(clk);
>>
>> ...
>>
>> driver2 (not adapted for clk_prepare/clk_unprepare):
>> clk_enable(clk);
>
> So this is basically buggy.  Look, it's quite simple.  Convert _all_
> your drivers to clk_prepare/clk_unprepare _before_ you start switching
> your platform to use these new functions.  You can do that _today_
> without exception.
>
> We must refuse to merge _any_ user which does this the old way - and
> we should have been doing this since my commit was merged into mainline
> to allow drivers to be converted.
>
> And stop trying to think of ways around this inside clk_prepare/
> clk_unprepare/clk_enable/clk_disable.  You can't do it.  Just fix _all_
> the drivers.  Now.  Before you start implementing clk_prepare/clk_unprepare.

I agree with Russell's suggestion. This is what I'm trying to do with 
the MSM platform. Not sure if I'm too optimistic, but as of today, I'm 
still optimistic I can push the MSM driver devs to get this done before 
we enable real prepare/unprepare support.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
