From: ashwinc@codeaurora.org (Ashwin Chaugule)
Date: Mon, 11 Apr 2011 16:46:27 -0400
Subject: [RFC] Extending ARM perf-events for multiple PMUs
In-Reply-To: <1302544807.24286.83.camel@e102144-lin.cambridge.arm.com>
References: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>	
	<4DA33A71.6010804@codeaurora.org>
	<1302544807.24286.83.camel@e102144-lin.cambridge.arm.com>
Message-ID: <4DA368A3.5080602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 4/11/2011 2:00 PM, Will Deacon wrote:
> 
> I don't think that's enough from a profiling perspective because the
> state of the device will be altered by other tasks. For example, the
> number of misses in the L2 cache for a given task is going to be
> affected by the other tasks running in the system, even if we only
> profile during the period in which the task is running.

I'm probably missing something. If another task affects the cache
contents, this will manifest as an increase in cache misses/hits for the
task that is being profiled during this interval. This will also happen
when interrupts trigger and wipe out cache lines anyway. IOW, a counter
thats counting events from CPU0, will not increment, if the event it is
counting gets affected by CPU1.


>>
>> For the Qcom L2CC, the PMU can be configured to filter events based on
>> specific masters. This fact would make it a CPU-aware PMU, although its
>> NOT per-core and triggers SPI's.
> 
> I have a similar issue with this; filtering based on the master *isn't*
> the same as having per-master samples, simply because the combined
> effect of the masters will influence all of the results. That doesn't
> mean that the filtering feature isn't useful, just that it should be
> described in the event encoding rather than by pretending to support
> per-CPU events.

I'll talk with the h/w guys who designed this, but from the spec it seems
like each event either has an Origin ID, or is Origin independent. If the
event has an OID, then the counter should *not* be counting the effect of
the other masters.

> I expect to see new struct pmus, I'd just like to try and identify
> common patterns before the code mounts up. I imagine that we'll have a
> struct pmu for L2 cache controllers, for example, from which people can
> hang their own specific accessors. Whether or not we can hang other
> system PMUs off such an implementation is unclear to me at the moment.

Agreed. Thanks for initiating the discussion on LKAML.

> 
>> So, I think we could add another category for such highly configurable
>> PMUs, which are not per-core, but have enough extra h/w to make them
>> cpu-aware. These need to be treated differently by arm perf, because they
>> can't really use the per-cpu data structures of the cpu-aware pmu's and as
>> such can't easily re-use of many of the functions.
>>
>> In fact, most of Qcomm PMU's (bus, fabric etc.) will fall under this new
>> category. At first glance, these would appear to fall under the System PMU
>> (counting) category, but they don't because of the extra h/w logic that
>> allows origin filtering of events.
> 
> I think they do; they just have some event encodings that monitor events
> specific to particular masters (but may not necessarily be attributable
> to them).

In our case, I think they are attributable, but I'll reconfirm by talking
to the h/w designers. Verifying these counter outputs is another challenge
I'm pursuing.

> 
>> Also, having all this origin filtering logic helps us track per-process
>> events on these PMU's, for which we need extra functions to decide how to
>> allocate and configure counters based on which context (task, cpu) the
>> event is enabled in.
> 
> I don't think we should go down the road of splitting up the counters on
> a given PMU so that they can be shared between different tasks on
> different CPUs. There will probably be a single control register, so
> keeping everything in sync will be impossible.

So, for the L2CC on the 8660 (AFAIK, even the bus/fabric monitors), each
counter has its own origin filter. So the various counters can count from
different masters at different profiling intervals.


Cheers,
Ashwin

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
