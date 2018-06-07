From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 7 Jun 2018 15:59:54 -0600
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
Message-ID: <CANLsYkyk=RoZge3d2iEnKwQ7vQ_tsJMwVD_eJVQHJJ1iQji+XQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 June 2018 at 15:47, Kim Phillips <kim.phillips@arm.com> wrote:
> On Thu, 7 Jun 2018 22:10:07 +0100
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>> On 06/07/2018 06:13 PM, Kim Phillips wrote:
>> > I'm going to assume the series is still valid after this discussion,
>> > since technically just this patch can get dropped, and the user is able
>> > to shoot themselves in the foot.
>>
>> That doesn't mean the kernel can panic() if the user decided to unload
>> the module while the trace session is in progress. It only means that
>> the trace session could be stopped in between in the worst case. But
>> nothing more harmful to the system.
>
> FWIW, I didn't see the kernel panic in my basic tests; just some bad
> accesses: the new remove functions take care of cleaning up most items,
> and most drivers still depend on the links and sinks (funnel,
> replicator) drivers, so they can't be upset too bad.
>
>> >  This series is for development  purposes, after all.
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
> my interpretation, his review of this patch was that it was in the
> wrong direction of safety: it made things unnecessarily too safe, up
> front, and that items relative to the perf core should strive to adhere
> to the higher standards set in place by the networking subsystem.  So,
> this patch doesn't get his ack.

Greg's point was that it's OK to let users harm themselves (which I
totally support), but if you're going to prevent it, make sure to do
it right.

>
> I compiled a new v5 series that omits this patch, and overwrote the v4
> series here:
>
> git://linux-arm.org/linux-kp.git, coresight-modules branch
>
> but I'll hold of submitting a v5 for now.
>
> I don't know how the perf core handles AUXTRACE drivers hanging up on
> it.  I see intel-pt record support can't be built as a module.  I'm
> guessing more testing for actual panics when using perf or sysfs is
> what's being sought here?

There are two ways to approach the problem:

1) Kill active trace sessions (either sysFS or perf) if a driver that
is being used is removed.
2) Deal with the removal in the coresight core, making sure we don't
access operations provided by removed drivers.

The end result in both cases will be the same: failure to properly
terminate the trace session because of user action.

I'm personally in favour of the second option, simply because it keeps
problems resolution with the CS subsystem.

>
> Kim
