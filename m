From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 8 Jun 2018 10:22:34 +0100
Subject: [PATCH v4 05/14] coresight: get/put module in
 coresight_build/release_path
In-Reply-To: <20180607164747.7e4bb30f69a1fb4c160b6ef1@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
 <20180605210710.22227-6-kim.phillips@arm.com>
 <20180606082422.GB19727@kroah.com>
 <a457594c-b391-23e1-6ab5-d115073cac5a@arm.com>
 <20180606155501.704583e1412996a1a2c6fa61@arm.com>
 <20180607083401.GE16651@kroah.com>
 <3219276b-2703-bc30-92e1-bae80cdc5901@arm.com>
 <20180607091353.GA20438@kroah.com>
 <2f8d233e-8847-ce3d-3a5b-06b175e3944b@arm.com>
 <20180607095322.GA26174@kroah.com>
 <adbabdb0-df2c-be74-3cde-cda4f6bce579@arm.com>
 <20180607121304.017d1d6804466050dd5c0af2@arm.com>
 <39d1089f-585d-bc19-2ecd-c9c9c812f85f@arm.com>
 <20180607164747.7e4bb30f69a1fb4c160b6ef1@arm.com>
Message-ID: <a637db36-4b82-d744-677e-0b4555201a80@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2018 10:47 PM, Kim Phillips wrote:
> On Thu, 7 Jun 2018 22:10:07 +0100
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> 
>> On 06/07/2018 06:13 PM, Kim Phillips wrote:
>>> I'm going to assume the series is still valid after this discussion,
>>> since technically just this patch can get dropped, and the user is able
>>> to shoot themselves in the foot.
>>
>> That doesn't mean the kernel can panic() if the user decided to unload
>> the module while the trace session is in progress. It only means that
>> the trace session could be stopped in between in the worst case. But
>> nothing more harmful to the system.

Kim,

> 
> FWIW, I didn't see the kernel panic in my basic tests; just some bad
> accesses: the new remove functions take care of cleaning up most items,
> and most drivers still depend on the links and sinks (funnel,
> replicator) drivers, so they can't be upset too bad.

Bad accesses are still bad. The bad access could trigger an Oops for 
e.g, or could even corrupt the other parts of the kernel if we try
to access a memory that is free'd (and reallocated to somebody else).
So, the point is there are issues with the series which we know for
sure from code analysis. It may take different forms to show up at
runtime.

> 
>>>   This series is for development  purposes, after all.
>>
>> Do you mean that this series is for internal development purposes and
>> not upstream ? Making the drivers modular are always helpful, especially
> 
> no, I'm posting them for upstream review because I'd like them upstream.
> 
>> for something related to tracing, that allows the module to be unloaded
>> after use. So, it would be good to have this series in, but in a manner
>> which is usable and doesn't cause harm to the overall system usage.
>>
>> I think the summary of the discussion is that we need more robust code
>> to handle the situation, which also allows unloading the modules without
>> any trouble.
> 
> Trouble's relative.  My point was since the series is going to be used
> mainly by developers testing their code, they already prepare for, and
> expect badness to occur anyway.  Greg's point isn't lost here, and in


Making something modular is not really just for the use of developers.
There are and will be other users for a device driver as a module and
it is a fundamental feature people expect (especially in the enterprise
world, where there is one kernel which builds most of the stuff as
module to let the users pick the individual drivers as they need).
So, at the kernel driver you can't really be sure, if the user is
actually aware of the "developer" only mode and he knows that we can
crash the kernel.

> my interpretation, his review of this patch was that it was in the
> wrong direction of safety: it made things unnecessarily too safe, up
> front, and that items relative to the perf core should strive to adhere

One of the areas of improvement towards the "modern" behavior is failing
the activation of the trace schedule, when a component in the path has
been removed when we go through coresight_enable_path(). Right now, we 
create a path and then we do enable_path() and disable_path() around the
trace schedules and the path is destroyed only at pmu->free_aux(). With
the current patch, we hold the reference to the device/driver throughout
the duration of the life time of the tracing, even when the tracing
may be disabled in between.

I think, if we get to that point, we should be at the best we can reach
towards the expected behavior. But having said that, it is indeed tricky
to get that. May be we could play a little bit with the refcounting on
csdev and check if the refcount is only held by the number of paths this
component is part of (needs more thought).


Suzuki
