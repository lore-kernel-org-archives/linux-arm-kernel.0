From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 26 Jun 2012 19:07:35 -0700
Subject: [PATCH 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <20120626104944.GE27996@mudshark.cambridge.arm.com>
References: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
 <1340377774-17173-3-git-send-email-will.deacon@arm.com>
 <4FE8DA7E.5040105@codeaurora.org>
 <20120626104944.GE27996@mudshark.cambridge.arm.com>
Message-ID: <4FEA6AE7.4050000@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/12 03:49, Will Deacon wrote:
> On Mon, Jun 25, 2012 at 10:39:10PM +0100, Stephen Boyd wrote:
>> On 06/22/12 08:09, Will Deacon wrote:
>>> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
>>> index dbbeec4..675cee0 100644
>>> --- a/arch/arm/kernel/arch_timer.c
>>> +++ b/arch/arm/kernel/arch_timer.c
>>> @@ -32,6 +32,8 @@ static int arch_timer_ppi2;
>>>  
>>>  static struct clock_event_device __percpu **arch_timer_evt;
>>>  
>>> +extern void init_current_timer_delay(unsigned long freq);
>> Can we find a home for this in some header file?
> I wondered about that...
>
> The reason I didn't add it to a header file is that we really don't want it
> to be called willy-nilly across the kernel. In fact, it must be called
> exactly once by the clocksource backing read_current_timer when it knows
> that the timer is live and ticking.
>
> I suppose I could allow the function to fail if it's called after we've
> calibrated. What do you reckon?
>

Fair enough. Would anything actually go wrong if you called it twice? I
would think everything would be assigned to what it already is but I
haven't thought deeply about it. I don't really care to make the
function more complicated for a case that should never happen.

> It's actually a 32-bit multiply with a 64-bit result, so it's just a umull:
>
> 00000050 <__timer_const_udelay>:
>   50:	e3003000	movw	r3, #0
>   54:	e3403000	movt	r3, #0
>   58:	e5932000	ldr	r2, [r3]
>   5c:	e0832290	umull	r2, r3, r0, r2
>   60:	e1a00f22	lsr	r0, r2, #30
>   64:	e1800103	orr	r0, r0, r3, lsl #2
>   68:	eaffffe4	b	0 <__timer_delay>

Ok. Maybe Russell can comment further. Or maybe it doesn't matter to
save some cycles after Linus said that udelay() doesn't need to be that
accurate.

>> It's unfortunate that we have to duplicate the same code and constants
>> in both C and assembly. With my approach we convert delay.S into C and
>> avoid the duplication.
> It's probably easy enough to have a #define for the multiplier, I can do
> that for v2.

I look forward to seeing how v2 works out.

>
>>> +
>>> +void __init init_current_timer_delay(unsigned long freq)
>>> +{
>>> +	pr_info("Switching to timer-based delay loop\n");
>> Might be worth printing the frequency here too.
> Could do, but the timer itself probably prints that information already (at
> least it does the arch timer).

Sure. Thinking more about it I don't like my suggestion.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
