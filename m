From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Jan 2017 15:17:29 +0000
Subject: [PATCH v3 6/9] kvm: arm/arm64: Add host pmu to support VM
 introspection
In-Reply-To: <87fukgmnf0.fsf@e105922-lin.cambridge.arm.com>
References: <20170110113856.7183-1-punit.agrawal@arm.com>
 <20170110113856.7183-7-punit.agrawal@arm.com>
 <1a6b8d71-58a5-b29b-3f01-e945deb2baf6@arm.com>
 <20170118113523.GB3231@leverpostej>
 <87o9z4msi3.fsf@e105922-lin.cambridge.arm.com>
 <c2382140-b7ac-11d8-89f0-bf421e38f844@arm.com>
 <87fukgmnf0.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20170118151729.GI3231@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 02:51:31PM +0000, Punit Agrawal wrote:
> I should've clarified in my reply that I wasn't looking to support the
> third instance from Mark's examples above - "monitor all vCPUs on a
> pCPU". I think it'll be quite expensive to figure out which threads from
> a given pool are vCPUs.

I'm not sure I follow why you would need to do that?

In that case, we'd open a CPU-bound perf event for the pCPU, which would
get installed in the CPU context immediately. It would be present for
all tasks.

Given it's present for all tasks, we don't need to figure out which
happen to have vCPUs. The !vCPU tasks simply shouldn't trigger events.

Am I missing something?

> For the other instances, we only need to find the vCPU for a given
> pid. Userspace will hand us a pid that needs to be checked against vCPUs
> to establish that it is a valid vCPU pid (here I was looking to use
> kvm_vcpu->pid and kvm->pid introduced in Patch 2).

Thinking about this further, a pid is not a unique identifier for either
a vCPU or a VM.

A single task (which has a single pid), could own multiple VMs, each
with multiple vCPUs. A thread pool (with several pids) could share those
arbitrarily. So we need VM and vCPU IDs which are distinct from pids or
tids.

I see that struct kvm_vcpu has a vcpu_id (which from a glance appears to
be local to the kvm instance). It's not clear to me if a kvm instance
could be shared by multiple processes, or if we can get away with a
process-local ID.

Thanks,
Mark.
