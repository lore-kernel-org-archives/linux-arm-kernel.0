From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 Oct 2017 15:41:37 +0100
Subject: [PATCH 01/10] KVM: arm/arm64: Split dcache/icache flushing
In-Reply-To: <20171017142834.GG5886@lvm>
References: <20171009152032.27804-1-marc.zyngier@arm.com>
 <20171009152032.27804-2-marc.zyngier@arm.com> <20171016200735.GE1845@lvm>
 <33ad478f-dcd7-5a9e-d353-d564e09c3254@arm.com> <20171017142834.GG5886@lvm>
Message-ID: <1afeddb0-0263-fca2-9de2-2e07569e90d0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/17 15:28, Christoffer Dall wrote:
> On Tue, Oct 17, 2017 at 09:57:34AM +0100, Marc Zyngier wrote:
>> On 16/10/17 21:07, Christoffer Dall wrote>>> unrelated: I went and read the comment in __kvm_tlb_flush_vmid_ipa, and
>>> I don't really understand why there is only a need to flush the icache
>>> if the host is running at EL1.
>>>
>>> The text seems to describe the problem of remapping executable pages
>>> within the guest.  That seems to me would require icache maintenance of
>>> the page that gets overwritten with new code, regardless of whether the
>>> host runs at EL1 or EL2.
>>>
>>> Of course it's easier done on VHE because we don't have to take a trap,
>>> but the code seems to not invalidate the icache at all for VHE systems
>>> that have VPIPT.  I'm confused.  Can you help?
>>
>> [+ Will, as he wrote that code and can reply if I say something stupid]
>>
>> Here's the trick: The VMID-tagged aspect of VPIPT only applies if the
>> CMO is used at EL0 or EL1. When used at EL2, it behaves exactly like a
>> VPIPT operation (see D4.10.2 in the ARMv8 ARM version B_b).
>>
>> So in the end, we deal with VPIPT the following way:
>>
>> - Without VHE, we perform the icache invalidation on unmap, blatting the
>> whole icache.
> 
> ok, but why can't we do the invalidation by jumping to EL2 like we do
> for some of the other CMOs ?

I don't think we have any other CMO requiring jumping to EL2. VPIPT
handling is the only one so far. I think that's why Will coupled it to
the TLB invalidation (we're already at EL2 for that).

Now, we could easily change that to follow the same flow as the rest of
the code. It only takes a separate entry point.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
