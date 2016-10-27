From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Oct 2016 10:49:00 +0100
Subject: [PATCH] arm/arm64: KVM: Perform local TLB invalidation when
 multiplexing vcpus on a single CPU
In-Reply-To: <20161027091906.GA14734@cbox>
References: <1477323088-18768-1-git-send-email-marc.zyngier@arm.com>
 <20161027091906.GA14734@cbox>
Message-ID: <7541af85-05c4-25f9-2fa8-2eb7a0afbe84@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 27/10/16 10:19, Christoffer Dall wrote:
> On Mon, Oct 24, 2016 at 04:31:28PM +0100, Marc Zyngier wrote:
>> Architecturally, TLBs are private to the (physical) CPU they're
>> associated with. But when multiple vcpus from the same VM are
>> being multiplexed on the same CPU, the TLBs are not private
>> to the vcpus (and are actually shared across the VMID).
>>
>> Let's consider the following scenario:
>>
>> - vcpu-0 maps PA to VA
>> - vcpu-1 maps PA' to VA
>>
>> If run on the same physical CPU, vcpu-1 can hit TLB entries generated
>> by vcpu-0 accesses, and access the wrong physical page.
>>
>> The solution to this is to keep a per-VM map of which vcpu ran last
>> on each given physical CPU, and invalidate local TLBs when switching
>> to a different vcpu from the same VM.
> 
> Just making sure I understand this:  The reason you cannot rely on the
> guest doing the necessary distinction with ASIDs or invalidating the TLB
> is that a guest (which assumes it's running on hardware) can validly
> defer any neccessary invalidation until it starts running on other
> physical CPUs, but we do this transparently in KVM?

The guest wouldn't have to do any invalidation at all on real HW,
because the TLBs are strictly private to a physical CPU (only the
invalidation can be broadcast to the Inner Shareable domain). But when
we multiplex two vcpus on the same physical CPU, we break the private
semantics, and a vcpu could hit in the TLB entries populated by the
another one.

As we cannot segregate the TLB entries per vcpu (but only per VMID), the
workaround is to nuke all the TLBs for this VMID (locally only - no
broadcast) each time we find that two vcpus are sharing the same
physical CPU.

Is that clearer?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
