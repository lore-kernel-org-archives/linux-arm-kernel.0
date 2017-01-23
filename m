From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 23 Jan 2017 11:21:36 +0000
Subject: [PATCH v3 6/9] kvm: arm/arm64: Add host pmu to support VM
 introspection
In-Reply-To: <20170119164231.GA5664@cbox> (Christoffer Dall's message of "Thu,
 19 Jan 2017 17:42:31 +0100")
References: <20170110113856.7183-1-punit.agrawal@arm.com>
 <20170110113856.7183-7-punit.agrawal@arm.com>
 <1a6b8d71-58a5-b29b-3f01-e945deb2baf6@arm.com>
 <20170118113523.GB3231@leverpostej>
 <87o9z4msi3.fsf@e105922-lin.cambridge.arm.com>
 <c2382140-b7ac-11d8-89f0-bf421e38f844@arm.com>
 <87fukgmnf0.fsf@e105922-lin.cambridge.arm.com>
 <20170118151729.GI3231@leverpostej>
 <877f5smjg1.fsf@e105922-lin.cambridge.arm.com>
 <20170118180546.GN3231@leverpostej> <20170119164231.GA5664@cbox>
Message-ID: <87a8aikon3.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

Christoffer Dall <christoffer.dall@linaro.org> writes:

> On Wed, Jan 18, 2017 at 06:05:46PM +0000, Mark Rutland wrote:
>> On Wed, Jan 18, 2017 at 04:17:18PM +0000, Punit Agrawal wrote:
>> > Mark Rutland <mark.rutland@arm.com> writes:
>> > 
>> > > On Wed, Jan 18, 2017 at 02:51:31PM +0000, Punit Agrawal wrote:
>> > >> I should've clarified in my reply that I wasn't looking to support the
>> > >> third instance from Mark's examples above - "monitor all vCPUs on a
>> > >> pCPU". I think it'll be quite expensive to figure out which threads from
>> > >> a given pool are vCPUs.
>> > >
>> > > I'm not sure I follow why you would need to do that?
>> > >
>> > > In that case, we'd open a CPU-bound perf event for the pCPU, which would
>> > > get installed in the CPU context immediately. It would be present for
>> > > all tasks.
>> > >
>> > > Given it's present for all tasks, we don't need to figure out which
>> > > happen to have vCPUs. The !vCPU tasks simply shouldn't trigger events.
>> > >
>> > > Am I missing something?
>> > 
>> > When enabling a CPU-bound event for pCPU, we'd have to enable trapping
>> > of TLB operations for the vCPUs running on pCPU. Have a look at Patch
>> > 7/9.
>> > 
>> > Also, we'd have to enable/disable trapping when tasks are migrated
>> > between pCPUs.
>> 
>> Ah, so we can't configure the trap and leave it active, since it'll
>> affect the host.
>> 
>> We could have a per-cpu flag, and a hook into vcpu_run, but that's also
>> gnarly.
>> 
>> I'll have a think.
>> 
>> > So far I've assumed that a VM pid is immutable. If that doesn't hold
>> > then we need to think of another mechanism to refer to a VM from
>> > userspace.
>> 
>> Even if we can't migrate the VM between processes (i.e. it's immutable),
>> it's still not unique within a process, so I'm fairly sure we need
>> another mechanism (even if we get away with the common case today).
>> 
> I don't understand what the requirements here are exactly but the KVM
> API documentation says:
>
>   In general file descriptors can be migrated among processes by means
>   of fork() and the SCM_RIGHTS facility of unix domain socket.  These
>   kinds of tricks are explicitly not supported by kvm.  While they will
>   not cause harm to the host, their actual behavior is not guaranteed by
>   the API.  The only supported use is one virtual machine per process,
>   and one vcpu per thread.
>
> So this code should maintain those semantics and it's fair to assume the
> thread group leader of a given VM stays the same, but the code must not
> rely on this fact for safe operations.

Thanks for clarifying. The current version passes muster on these
assumptions, but I'll have to take a closer look to convince myself of
the safety.

By moving to vCPU pids in the next version, things should further
improve in this regard.

>
> I also don't see why a process couldn't open multiple VMs; however
> messy that may be, it appears possible to me.

I imagine there is an implicit reliance on the VMM to handle any
resulting fallout if it chooses to do this.

>
> -Christoffer
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
