From: ashwinc@codeaurora.org (Ashwin Chaugule)
Date: Wed, 13 Apr 2011 01:09:21 -0400
Subject: [RFC] Extending ARM perf-events for multiple PMUs
In-Reply-To: <1302631722.24286.113.camel@e102144-lin.cambridge.arm.com>
References: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>	
	<4DA33A71.6010804@codeaurora.org>	
	<1302544807.24286.83.camel@e102144-lin.cambridge.arm.com>	
	<4DA368A3.5080602@codeaurora.org>
	<1302631722.24286.113.camel@e102144-lin.cambridge.arm.com>
Message-ID: <4DA53001.60003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 4/12/2011 2:08 PM, Will Deacon wrote:
> Ok, some feedback from the hardware guys would be useful so we know what
> we're dealing with. However, we still have some other problems for these
> system PMUs if you want to allow the events to specify CPU affinity:
> 
I don't intend to allow *all* events to specify CPU affinity. Just those
that have OID's (and theres lots of these).

Also, I confirmed with the h/w guys about the filtering logic. A correctly
configured counter won't be affected by the other masters. This works
quite well for filtering by CPU's, ergo filtering by task/cpu works with
whats already there in perf for PMUs where each counter can be filtered by
origin. Just needs some extra handling than whats in arm-perf code today.

>  - What do you do if there are more masters than CPUs?
Sure. For non-cpu masters, like I agreed earlier, we still need to extend
perf to allow cpu = -1 and task = -1.

>  - How do you handle mixing events that can be filtered by origin with
> those that can't?
I haven't reached the point of handling events that can't be filtered by
origin. They're very few and super esoteric ;)


> 
> So another argument for avoiding CPU affinity is simply that it
> complicates the code. I think this complication is unnecessary if we can
> get perf working with CPU=1, pid=-1 (I fear there may be locking issues
> but I don't know yet). You can specify masters in the event encoding
> instead which has the benefit of forcing userspace to think more
> carefully about what they are doing (rather than erroneously attributing
> samples to CPUs) and also providing more flexibility (for example, if
> you have an event that counts interactions between two CPUs - which one
> do you attribute it to?).

Guess you mean cpu = -1 ? I've been dealing with CPU side events for these
PMU's since these seem to be in demand the most. The only real
complication I found was to use the per-cpu data structures from arm-perf
code for the cpu context counting. Makes it ugly in the (SPI) interrupt
handler. However, as an alternative simpler solution, I skipped the
arm_pmu fops, registered a new PMU TYPE, and handled it separately.

Looking ahead, encoding masters in the event code makes sense. We'll need
to make perf-core code aware of this too. Currently it only seems to look
at cpu and task affinity and stores the perf_event in the appropriate
context lists.

Primarily, perf needs to be changed to allow specifying context for each
event. Currently the "-a/-p/-t" option applies to all events specified.

When cpu = -1, task = -1 for an event, we could store it in the cpu
context list of the cpu that never goes down (CPU0?). Then let the counter
spin, perf should report back the output against the appropriate raw event
code. The user should be able to understand the output.

Time for some more experiments and more thinking. Arming the PMU counters
here is not so much a problem as reporting the results back.

There's also the case, where some PMU's start multiple counters for each
event. Thinking of leveraging event groups to report back the results as
non-cumulative output.

>>
>> So, for the L2CC on the 8660 (AFAIK, even the bus/fabric monitors), each
>> counter has its own origin filter. So the various counters can count from
>> different masters at different profiling intervals.
> 
> Ok, that tidies this problem up nicely in this case but for other PMUs
> we might not be as fortunate.
> 
>
Hence the suggestion to have another category in your initial email. ;)

Cheers,
Ashwin


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
