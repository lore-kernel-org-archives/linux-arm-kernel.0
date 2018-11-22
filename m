From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Nov 2018 16:13:16 +0000
Subject: [PATCH 4/4] arm64: KVM: Implement workaround for Cortex-A76
 erratum 1165522
In-Reply-To: <20181108201054.GG3835@e113682-lin.lund.arm.com>
References: <20181105143617.120602-1-marc.zyngier@arm.com>
 <20181105143617.120602-5-marc.zyngier@arm.com>
 <20181106081546.GH12057@e113682-lin.lund.arm.com>
 <ec7d0e34-022f-125e-00b4-b06be23ee2a8@arm.com>
 <20181108201054.GG3835@e113682-lin.lund.arm.com>
Message-ID: <11733182-4e0a-5607-268e-73b8d00fbcee@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2018 20:10, Christoffer Dall wrote:
> On Thu, Nov 08, 2018 at 06:05:55PM +0000, Marc Zyngier wrote:
>> On 06/11/18 08:15, Christoffer Dall wrote:
>>> On Mon, Nov 05, 2018 at 02:36:16PM +0000, Marc Zyngier wrote:
>>>> Early versions of Cortex-A76 can end-up with corrupt TLBs if they
>>>> speculate an AT instruction in during a guest switch while the
>>>> S1/S2 system registers are in an inconsistent state.
>>>>
>>>> Work around it by:
>>>> - Mandating VHE
>>>> - Make sure that S1 and S2 system registers are consistent before
>>>>   clearing HCR_EL2.TGE, which allows AT to target the EL1 translation
>>>>   regime
>>>>
>>>> These two things together ensure that we cannot hit this erratum.
>>>>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>  Documentation/arm64/silicon-errata.txt |  1 +
>>>>  arch/arm64/Kconfig                     | 12 ++++++++++++
>>>>  arch/arm64/include/asm/cpucaps.h       |  3 ++-
>>>>  arch/arm64/include/asm/kvm_host.h      |  3 +++
>>>>  arch/arm64/include/asm/kvm_hyp.h       |  6 ++++++
>>>>  arch/arm64/kernel/cpu_errata.c         |  8 ++++++++
>>>>  arch/arm64/kvm/hyp/switch.c            | 14 ++++++++++++++
>>>>  7 files changed, 46 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
>>>> index 76ccded8b74c..04f0bc4690c6 100644
>>>> --- a/Documentation/arm64/silicon-errata.txt
>>>> +++ b/Documentation/arm64/silicon-errata.txt
>>>> @@ -57,6 +57,7 @@ stable kernels.
>>>>  | ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
>>>>  | ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
>>>>  | ARM            | Cortex-A76      | #1188873        | ARM64_ERRATUM_1188873       |
>>>> +| ARM            | Cortex-A76      | #1165522        | ARM64_ERRATUM_1165522       |
>>>>  | ARM            | MMU-500         | #841119,#826419 | N/A                         |
>>>>  |                |                 |                 |                             |
>>>>  | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index 787d7850e064..a68bc6cc2167 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -497,6 +497,18 @@ config ARM64_ERRATUM_1188873
>>>>  
>>>>  	  If unsure, say Y.
>>>>  
>>>> +config ARM64_ERRATUM_1165522
>>>> +	bool "Cortex-A76: Speculative AT instruction using out-of-context translation regime could cause subsequent request to generate an incorrect translation"
>>>> +	default y
>>>> +	help
>>>> +	  This option adds work arounds for ARM Cortex-A76 erratum 1165522
>>>> +
>>>> +	  Affected Cortex-A76 cores (r0p0, r1p0, r2p0) could end-up with
>>>> +	  corrupted TLBs by speculating an AT instruction during a guest
>>>> +	  context switch.
>>>> +
>>>> +	  If unsure, say Y.
>>>> +
>>>>  config CAVIUM_ERRATUM_22375
>>>>  	bool "Cavium erratum 22375, 24313"
>>>>  	default y
>>>> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
>>>> index 6e2d254c09eb..62d8cd15fdf2 100644
>>>> --- a/arch/arm64/include/asm/cpucaps.h
>>>> +++ b/arch/arm64/include/asm/cpucaps.h
>>>> @@ -54,7 +54,8 @@
>>>>  #define ARM64_HAS_CRC32				33
>>>>  #define ARM64_SSBS				34
>>>>  #define ARM64_WORKAROUND_1188873		35
>>>> +#define ARM64_WORKAROUND_1165522		36
>>>>  
>>>> -#define ARM64_NCAPS				36
>>>> +#define ARM64_NCAPS				37
>>>>  
>>>>  #endif /* __ASM_CPUCAPS_H */
>>>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>>>> index 7d6e974d024a..8f486026ac87 100644
>>>> --- a/arch/arm64/include/asm/kvm_host.h
>>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>>> @@ -435,6 +435,9 @@ static inline bool kvm_arch_sve_requires_vhe(void)
>>>>  static inline bool kvm_arch_impl_requires_vhe(void)
>>>>  {
>>>>  	/* Some implementations have defects that confine them to VHE */
>>>> +	if (cpus_have_cap(ARM64_WORKAROUND_1165522))
>>>> +		return true;
>>>> +
>>>>  	return false;
>>>>  }
>>>>  
>>>> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
>>>> index 23aca66767f9..9681360d0959 100644
>>>> --- a/arch/arm64/include/asm/kvm_hyp.h
>>>> +++ b/arch/arm64/include/asm/kvm_hyp.h
>>>> @@ -163,6 +163,12 @@ static __always_inline void __hyp_text __load_guest_stage2(struct kvm *kvm)
>>>>  {
>>>>  	write_sysreg(kvm->arch.vtcr, vtcr_el2);
>>>>  	write_sysreg(kvm->arch.vttbr, vttbr_el2);
>>>> +
>>>> +	/*
>>>> +	 * ARM erratum 1165522 requires the actual execution of the
>>>> +	 * above before we can switch to the guest translation regime.
>>>> +	 */
>>>
>>> Is it about a guest translation 'regime' or should this just say before
>>> we can enable stage 2 translation?
>>
>> No, this isn't strictly about enabling stage-2 translation. This is
>> about making sure that anything that impacts the guest translations is
>> actually executed.
>>
>> I wonder if it would be clearer to move this outside of
>> __load_guest_stage2 and make it explicit in the callers of this helper...
> 
> I think it makes sense to have this here to explain the alternative.
> 
> But it's the 'switch to guest translation regime' thing that bothers me
> a bit.  Is that an architectural concept (I thought we only had EL1 and
> EL2 translation regimes in stage 1, and then stage 2 translations).  So
> When you say 'guest translation regime' I'm just not entirely sure what
> that means, unless I'm missing something.

[coming back to this as I'm preparing the next round]

What I'm trying to convey by "guest translation regime" is the following
from the ARM ARM:

C5.4.7 AT S1E1R, Address Translate Stage 1 EL1 Read
[...]

When EL2 is implemented and enabled in the current Security state:
? If HCR_EL2.{E2H, TGE} is not {1, 1}, the EL1&0 translation regime,
accessed from EL1.
? If HCR_EL2.{E2H, TGE} is {1, 1}, the EL2&0 translation regime,
accessed from EL2.

So maybe I should just bite the bullet and call out EL1/EL2 translation
regime instead of guest/host.

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny...
