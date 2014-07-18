From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 18 Jul 2014 15:38:36 -0700
Subject: [PATCH] sched_clock: Avoid corrupting hrtimer tree during suspend
In-Reply-To: <53C99EC5.2060602@linaro.org>
References: <1405721392-30795-1-git-send-email-sboyd@codeaurora.org>
 <53C99EC5.2060602@linaro.org>
Message-ID: <53C9A1EC.8060905@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/14 15:25, John Stultz wrote:
> On 07/18/2014 03:09 PM, Stephen Boyd wrote:
>> During suspend we call sched_clock_poll() to update the epoch and
>> accumulated time and reprogram the sched_clock_timer to fire
>> before the next wrap-around time. Unfortunately,
>> sched_clock_poll() doesn't restart the timer, instead it relies
>> on the hrtimer layer to do that and during suspend we aren't
>> calling that function from the hrtimer layer. Instead, we're
>> reprogramming the expires time while the hrtimer is enqueued,
>> which can cause the hrtimer tree to be corrupted. Fix this
>> problem by updating the state via update_sched_clock() and
>> properly restarting the timer via hrtimer_start().
>>
>> Fixes: a08ca5d1089d "sched_clock: Use an hrtimer instead of timer"
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>
>> I also wonder if we should be restarting the timer during resume
>> instead of suspend given that the resume path modifies the epoch.
>> At that point timers can't run because interrupts are disabled and
>> we don't really care if the timer fires earlier than it's supposed
>> to anyway because it's just there to avoid rollover events, but
>> does it seem better to do it that way? I didn't send that version
>> because this patch is to fix the code intention, but I'm curious
>> if anyone else feels like it should be changed.
> Yea, starting the timer on suspend seems unintuitive to me.
>
> Is this something you were hoping to get in for 3.17 or is this a urgent
> 3.16 item?

Ok I'll send a follow up patch to cancel during suspend and start during
resume, unless you want that to be part of this fix? It's a regression
back to v3.13 so I would think it's urgent, although I haven't seen any
reports on the mailing list, just reports on some of our android kernels.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
