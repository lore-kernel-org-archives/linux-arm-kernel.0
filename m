From: venki@google.com (Venkatesh Pallipadi)
Date: Thu, 9 Dec 2010 10:11:33 -0800
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <1291917330.6803.7.camel@twins>
References: <20101208142814.GE9777@n2100.arm.linux.org.uk>
	<1291851079-27061-1-git-send-email-venki@google.com>
	<1291899120.29292.7.camel@twins>
	<AANLkTikd3X4pLs5De-LO6=XD+JqUz3-Ku7YM8+0-oK8t@mail.gmail.com>
	<1291917330.6803.7.camel@twins>
Message-ID: <AANLkTin+eO_jPceSOHL4e7vqd+tf0ZCMHJ-USoz8aZL1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 9, 2010 at 9:55 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, 2010-12-09 at 09:43 -0800, Venkatesh Pallipadi wrote:
>>
>> The same problem will be there with below code, with irq_delta >
>> delta, clock_task can go backwards which is not good.
>> + ? ? ? delta -= irq_delta;
>> + ? ? ? rq->clock_task += delta;
>>
>> The reason for this is rq->clock and irqtime updates kind of happen
>> independently and specifically, if a rq->clock update happens while we
>> are in a softirq, we may have this case of going backwards on the next
>> update.
>
> But how can irq_delta > delta?, we measure it using the same clock.
>

This would be mostly a corner case like:
- softirq start time t1
- rq->clock updated at t2 and rq->clock_task updated at t2 without
accounting for current softirq
- softirq end time t3
- cpu spends most time here in softirq or hardirq
- next rq->clock update at t4 and rq->clock_task update, with delta =
t4-t2 and irq_delta ~= t4 - t1
