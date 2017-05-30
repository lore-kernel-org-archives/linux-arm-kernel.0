From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 May 2017 15:21:37 +0100
Subject: [PATCH 15/31] KVM: arm64: vgic-v3: Add ICV_AP1Rn_EL1 handler
In-Reply-To: <e07081cf-82c5-0878-52f9-930f1727574d@redhat.com>
References: <20170503104606.19342-1-marc.zyngier@arm.com>
 <20170503104606.19342-16-marc.zyngier@arm.com>
 <b672d790-738b-df50-06fc-8b72c7692abe@redhat.com>
 <e07081cf-82c5-0878-52f9-930f1727574d@redhat.com>
Message-ID: <054e7899-52b6-d509-8f73-f226d5fbeff8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 30/05/17 09:02, Auger Eric wrote:
> Hi Marc,
> 
> On 30/05/2017 09:48, Auger Eric wrote:
>> H Marc,
>>
>> On 03/05/2017 12:45, Marc Zyngier wrote:
>>> Add a handler for reading/writing the guest's view of the ICV_AP1Rn_EL1
>>> registers. We just map them to the corresponding ICH_AP1Rn_EL2 registers.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  arch/arm64/include/asm/sysreg.h |  1 +
>>>  virt/kvm/arm/hyp/vgic-v3-sr.c   | 94 +++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 95 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>>> index 15c142ce991c..aad46b8eea5e 100644
>>> --- a/arch/arm64/include/asm/sysreg.h
>>> +++ b/arch/arm64/include/asm/sysreg.h
>>> @@ -180,6 +180,7 @@
>>>  
>>>  #define SYS_VBAR_EL1			sys_reg(3, 0, 12, 0, 0)
>>>  
>>> +#define SYS_ICC_AP1Rn_EL1(n)		sys_reg(3, 0, 12, 9, n)
>>>  #define SYS_ICC_DIR_EL1			sys_reg(3, 0, 12, 11, 1)
>>>  #define SYS_ICC_SGI1R_EL1		sys_reg(3, 0, 12, 11, 5)
>>>  #define SYS_ICC_IAR1_EL1		sys_reg(3, 0, 12, 12, 0)
>>> diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
>>> index a76351b3ad66..b6803989da1f 100644
>>> --- a/virt/kvm/arm/hyp/vgic-v3-sr.c
>>> +++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
>>> @@ -684,6 +684,76 @@ static void __hyp_text __vgic_v3_write_bpr1(struct kvm_vcpu *vcpu, u32 vmcr, int
>>>  	__vgic_v3_write_vmcr(vmcr);
>>>  }
>>>  
>>> +static void __hyp_text __vgic_v3_read_apxrn(struct kvm_vcpu *vcpu, int rt, int n)
>> Shouldn't you test somewhere that n is correct given the number of
>> implemented priority bits

If n is invalid, then the corresponding system register access will have
UNDEFed at EL1, irrespective of the trapping (UNDEF has a higher
priority than trapping, unfortunately).

>>> +{
>>> +	u32 val;
>>> +
>>> +	if (!__vgic_v3_get_group(vcpu))
>> I don't really get how an access to AP1Rn can end up in AP0Rn. I am not
>> able to find any related description in the spec?
> Forget that one. This is simply a generic helper and an access from NS
> world will access the AP1Rn reg.

It is not really S vs NS here, since the guest is probably aware it is
running non-secure. The GICv3 architecture allows the guest to have its
own Group0 interrupts (reported as FIQ).

> so besides the comment on "n" check,
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!

	M.
-- 
Jazz is not dead. It just smells funny...
