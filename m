From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 07 May 2013 17:28:00 +0100
Subject: [PATCH v3 24/32] arm64: KVM: 32bit GP register access
In-Reply-To: <20130502160906.GI20730@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-25-git-send-email-marc.zyngier@arm.com>
 <20130502160906.GI20730@arm.com>
Message-ID: <51892B90.8060706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/13 17:09, Catalin Marinas wrote:
> On Mon, Apr 08, 2013 at 05:17:26PM +0100, Marc Zyngier wrote:
>>  static inline bool kvm_vcpu_reg_is_pc(const struct kvm_vcpu *vcpu, int reg)
>>  {
>> -	return false;
>> +	return (vcpu_mode_is_32bit(vcpu)) && reg == 15;
>>  }
> 
> On AArch64, would ESR_EL2 have SRT == 15 when the source/destination
> register is PC? The mapping between AArch32 and AArch64 registers
> suggests R13_hyp. Maybe 15 is correct but it's not clear to me from the
> spec.

The register reported by ESL_EL2 is indeed r15 when EL1 is in AARch32.
That's because we don't have PC as a GPR on AARch64.

> BTW, on arch/arm it looks like this is used when you get a data abort
> with PC as the destination register and you inject a prefetch abort in
> this case. Why isn't this a normal data abort? Once you get the
> information, you load it into PC but first you need to sort out the data
> abort (unless I don't understand how the kvm_inject_pabt works).

Indeed, it should be a data abort, as we correctly fetched the
instruction. Now, I wonder why we even bother trying to catch this case.
Fetching PC from MMIO looks quite silly, but I don't think anything
really forbids it in the architecture.

	M.
-- 
Jazz is not dead. It just smells funny...
