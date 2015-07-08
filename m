From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 08 Jul 2015 18:54:52 +0100
Subject: [PATCH 07/13] arm64: KVM: VHE: Patch out use of HVC
In-Reply-To: <559D5A8A.4030901@redhat.com>
References: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
 <1436372356-30410-8-git-send-email-marc.zyngier@arm.com>
 <559D5A8A.4030901@redhat.com>
Message-ID: <559D63EC.2090602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/15 18:14, Paolo Bonzini wrote:
> 
> 
> On 08/07/2015 18:19, Marc Zyngier wrote:
>> +/* Hack to allow stringification of macros... */
>> +#define __S__(a,args...)	__stringify(a, ##args)
>> +#define _S_(a,args...)		__S__(a, args)
>> +
>> +.macro ifnvhe nonvhe vhe
>> +	alternative_insn	"\nonvhe", "\vhe", ARM64_HAS_VIRT_HOST_EXTN
>> +.endm
> 
> Why not use this in patch 6 too?

I tried, and ended up in #include hell. vhe-macros.h is local to
arch/arm64/kvm, and including it from asm/kvm_mmu.h breaks (we include
it from arch/arm/kvm/ and virt/kvm/arm/).

Alternatively, I could move it to arch/arm64/include/asm (renamed to
kvm_vhe_macros.h?), which would solve this issue. I just gave it a go,
and that seems sensible enough.

Thanks for the suggestion!

	M.
-- 
Jazz is not dead. It just smells funny...
