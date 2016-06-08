From: nleeder@codeaurora.org (Neil Leeder)
Date: Wed, 8 Jun 2016 15:29:13 -0400
Subject: [PATCH 0/2] qcom: add l2 cache perf events driver
In-Reply-To: <20160608161251.GC13355@leverpostej>
References: <1464987812-14360-1-git-send-email-nleeder@codeaurora.org>
 <20160606090416.GB6831@leverpostej>
 <f4fc5806-7cf0-28ea-08d5-9bb26dbd576a@codeaurora.org>
 <20160608161251.GC13355@leverpostej>
Message-ID: <27dca70e-e880-a659-9d57-5fbea0bea2fb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 6/8/2016 12:12 PM, Mark Rutland wrote:
> On Wed, Jun 08, 2016 at 11:21:16AM -0400, Neil Leeder wrote:
>>
>>
>> On 6/6/2016 05:04 AM, Mark Rutland wrote:
>>> On Fri, Jun 03, 2016 at 05:03:30PM -0400, Neil Leeder wrote:
>>>> This adds a new dynamic PMU to the Perf Events framework to program
>>>> and control the L2 cache PMUs in some Qualcomm Technologies SOCs.
>>>>
>>>> The driver exports formatting and event information to sysfs so it can
>>>> be used by the perf user space tools with the syntax:
>>>> perf stat -e l2cache/event=0x42/
>>>>
>>>> One point to note is that there are certain combinations of events
>>>> which are invalid, and which are detected in event_add().
>>>
>>> Which combinations of events are invalid?
>>>
>>> Please elaborate.
>>>
>>>> Simply having event_add() fail would result in event_sched_in() making
>>>> it Inactive, treating it as over-allocation of counters, leading to
>>>> repeated attempts to allocate the events and ending up with a
>>>> statistical count.  A solution for this situation is to turn the
>>>> conflicting event off in event_add(). This allows a single error
>>>> message to be generated, and no recurring attempts to re-add the
>>>> invalid event. In order for this to work, event_sched_in()
>>>> needs to detect that event_add() changed the state, and not override it
>>>> and force it to Inactive.
>>>
>>> For heterogeneous PMUs, we added the pmu::filter_match(event) callback
>>> for a similar purpose: preventing an event from being scheduled on a
>>> core which does not support that event, while allowing other events to
>>> be scheduled.
>>>
>>> So if you truly need to filter events, the infrastructure for doing so
>>> already exists.
>>>
>>> However, you will need to elaborate on "there are certain combinations
>>> of events which are invalid".
>>>
>>
>> Qualcomm PMUs have events arranged in a matrix of rows and columns.
>> Only one event can be enabled from each column at once. So this isn't a
>> heterogeneous CPU issue, and it doesn't seem to fit into filter_match()
>> because it is not an absolute restriction that this event can't be
>> enabled on this cpu, it's related to the other events which have 
>> already been enabled.
> 
> The above is useful context. Please add (something like) it to the cover
> and relevant patches in future postings!
> 
> Ok. So if I understand correctly, each counter can only count certain
> events (and therefore each event can only go into some counters), rather
> than all counters being identical?
> 
> So the issue is that there is no _suitable_ counter available for an
> event, but there are still counters available for events in general.
> 
> This case is somewhat different to the heterogeneous PMU case.
> 
> Unfortunately, trying to filter events in this manner can be very
> expensive, and allows a malicious user to DoS the system, as Peter
> pointed out when I tried to do similar things in this area. Take a look
> at [1] and associated replies.
> 
> If you can test the availability of a relevant counter very cheaply,
> then having a specific return code for the case of no relevant counter
> may be more palatable.
> 

Not quite. Any event can go into any counter, but once an event from a given
column has been assigned to a counter, no other events from the same column
can be placed in any other counter.

Here I detect this condition on the first call to pmu->add() for
the conflicting event, and turn that event's state to Off.
That should ensure there are no more attempts to schedule it, which should avoid
DoS concerns.

But I may see if filter_match() could be used here anyway. Instead of having a
static list of valid PMUs, look at the list of already enabled events for this PMU
and fail if the conflict is detected. I think this would remove the need for a
change in state if add() is never called for the event.

>>>> This patchset requires:
>>>> [PATCH] soc: qcom: provide mechanism for drivers to access L2 registers
>>>
>>> A link would be remarkably helpful.
>>
>> http://archive.arm.linux.org.uk/lurker/message/20160603.205900.1970f20d.en.html
>>
>>>
>>> Better would be to fold that patch into this series, as it's the only
>>> user, and both are helpful review context for the other.
>>>
>>
>> The L2 PMU driver is the first user of the L2-accessors patch
>> but it won't be the only one, which is why I kept it separate.
> 
> If other users aren't going to appear in the same merge window, IMO it
> would be better to place them in the same series for now. Otherwise,
> please have a link in the cover in future postings.

Ok, makes sense.

> Thanks,
> Mark.
> 
> [1] http://lkml.kernel.org/r/1392054264-23570-5-git-send-email-mark.rutland at arm.com
> 

Neil

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
