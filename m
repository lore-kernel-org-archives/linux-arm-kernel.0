From: nleeder@codeaurora.org (Neil Leeder)
Date: Wed, 8 Jun 2016 11:21:16 -0400
Subject: [PATCH 0/2] qcom: add l2 cache perf events driver
In-Reply-To: <20160606090416.GB6831@leverpostej>
References: <1464987812-14360-1-git-send-email-nleeder@codeaurora.org>
 <20160606090416.GB6831@leverpostej>
Message-ID: <f4fc5806-7cf0-28ea-08d5-9bb26dbd576a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 6/6/2016 05:04 AM, Mark Rutland wrote:
> On Fri, Jun 03, 2016 at 05:03:30PM -0400, Neil Leeder wrote:
>> This adds a new dynamic PMU to the Perf Events framework to program
>> and control the L2 cache PMUs in some Qualcomm Technologies SOCs.
>>
>> The driver exports formatting and event information to sysfs so it can
>> be used by the perf user space tools with the syntax:
>> perf stat -e l2cache/event=0x42/
>>
>> One point to note is that there are certain combinations of events
>> which are invalid, and which are detected in event_add().
> 
> Which combinations of events are invalid?
> 
> Please elaborate.
> 
>> Simply having event_add() fail would result in event_sched_in() making
>> it Inactive, treating it as over-allocation of counters, leading to
>> repeated attempts to allocate the events and ending up with a
>> statistical count.  A solution for this situation is to turn the
>> conflicting event off in event_add(). This allows a single error
>> message to be generated, and no recurring attempts to re-add the
>> invalid event. In order for this to work, event_sched_in()
>> needs to detect that event_add() changed the state, and not override it
>> and force it to Inactive.
> 
> For heterogeneous PMUs, we added the pmu::filter_match(event) callback
> for a similar purpose: preventing an event from being scheduled on a
> core which does not support that event, while allowing other events to
> be scheduled.
> 
> So if you truly need to filter events, the infrastructure for doing so
> already exists.
> 
> However, you will need to elaborate on "there are certain combinations
> of events which are invalid".
> 

Qualcomm PMUs have events arranged in a matrix of rows and columns.
Only one event can be enabled from each column at once. So this isn't a
heterogeneous CPU issue, and it doesn't seem to fit into filter_match()
because it is not an absolute restriction that this event can't be
enabled on this cpu, it's related to the other events which have 
already been enabled.

>> This patchset requires:
>> [PATCH] soc: qcom: provide mechanism for drivers to access L2 registers
> 
> A link would be remarkably helpful.

http://archive.arm.linux.org.uk/lurker/message/20160603.205900.1970f20d.en.html

> 
> Better would be to fold that patch into this series, as it's the only
> user, and both are helpful review context for the other.
> 

The L2 PMU driver is the first user of the L2-accessors patch
but it won't be the only one, which is why I kept it separate.

> Thanks,
> Mark.
> 

Neil

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
