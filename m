From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 17 Apr 2013 17:34:45 -0700
Subject: [PATCH] ARM: sched_clock: Add more notrace to prevent recursion
In-Reply-To: <5151DC75.7030606@codeaurora.org>
References: <1363306086-23501-1-git-send-email-sboyd@codeaurora.org>
 <514B483F.7000304@codeaurora.org> <5151DC75.7030606@codeaurora.org>
Message-ID: <516F3FA5.8070307@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/13 10:35, Stephen Boyd wrote:
> On 03/21/13 10:49, Stephen Boyd wrote:
>> On 03/14/13 17:08, Stephen Boyd wrote:
>>> cyc_to_sched_clock() is called by sched_clock() and cyc_to_ns()
>>> is called by cyc_to_sched_clock(). I suspect that some compilers
>>> inline both of these functions into sched_clock() and so we've
>>> been getting away without having a notrace marking. It seems that
>>> my compiler isn't inlining cyc_to_sched_clock() though, so I'm
>>> hitting a recursion bug when I enable the function graph tracer,
>>> causing my system to crash. Marking these functions notrace fixes
>>> it. Technically cyc_to_ns() doesn't need the notrace because it's
>>> already marked inline, but let's just add it so that if we ever
>>> remove inline from that function it doesn't blow up.
>> Anyone else seeing this problem?
> Russell, should I put this into the patch tracker?

I'll throw this into the patch tracker tomorrow if nobody complains.

>>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>>> ---
>>>  arch/arm/kernel/sched_clock.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
>>> index bd6f56b..59d2adb 100644
>>> --- a/arch/arm/kernel/sched_clock.c
>>> +++ b/arch/arm/kernel/sched_clock.c
>>> @@ -45,12 +45,12 @@ static u32 notrace jiffy_sched_clock_read(void)
>>>  
>>>  static u32 __read_mostly (*read_sched_clock)(void) = jiffy_sched_clock_read;
>>>  
>>> -static inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
>>> +static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
>>>  {
>>>  	return (cyc * mult) >> shift;
>>>  }
>>>  
>>> -static unsigned long long cyc_to_sched_clock(u32 cyc, u32 mask)
>>> +static unsigned long long notrace cyc_to_sched_clock(u32 cyc, u32 mask)
>>>  {
>>>  	u64 epoch_ns;
>>>  	u32 epoch_cyc;
>


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
