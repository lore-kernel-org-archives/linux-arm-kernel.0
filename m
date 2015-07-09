From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 09 Jul 2015 10:59:36 +0100
Subject: [PATCH 03/13] arm64: Add ARM64_HAS_VIRT_HOST_EXTN feature
In-Reply-To: <20150709094818.GB20105@leverpostej>
References: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
 <1436372356-30410-4-git-send-email-marc.zyngier@arm.com>
 <20150709094818.GB20105@leverpostej>
Message-ID: <559E4608.5090102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/15 10:48, Mark Rutland wrote:
> On Wed, Jul 08, 2015 at 05:19:06PM +0100, Marc Zyngier wrote:
>> Add a new ARM64_HAS_VIRT_HOST_EXTN features to indicate that the
>> CPU has the ARMv8,1 VHE capability.
> 
> Nit: s/,/./
> 
> It's probably worth mentioning somewhere that we have to check CurrentEL
> rather than a feature register in case some prior software dropped us to
> EL1N (e.g. if we're a guest under this scheme).

Good point, this is a leftover from a previous version that actually
checked the feature register. I'll clean up the commit log.

Thanks,

	M.

> Mark.
> 
>>
>> This will be used to trigger kernel patching in KVM.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/include/asm/cpufeature.h |  3 ++-
>>  arch/arm64/kernel/cpufeature.c      | 11 +++++++++++
>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index c104421..6c3742d 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -25,8 +25,9 @@
>>  #define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE	1
>>  #define ARM64_WORKAROUND_845719			2
>>  #define ARM64_HAS_SYSREG_GIC_CPUIF		3
>> +#define ARM64_HAS_VIRT_HOST_EXTN		4
>>  
>> -#define ARM64_NCAPS				4
>> +#define ARM64_NCAPS				5
>>  
>>  #ifndef __ASSEMBLY__
>>  
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 5ad86ce..e1dcd63 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/types.h>
>>  #include <asm/cpu.h>
>>  #include <asm/cpufeature.h>
>> +#include <asm/virt.h>
>>  
>>  static bool
>>  has_id_aa64pfr0_feature(const struct arm64_cpu_capabilities *entry)
>> @@ -31,6 +32,11 @@ has_id_aa64pfr0_feature(const struct arm64_cpu_capabilities *entry)
>>  	return (val & entry->register_mask) == entry->register_value;
>>  }
>>  
>> +static bool runs_at_el2(const struct arm64_cpu_capabilities *entry)
>> +{
>> +	return is_kernel_in_hyp_mode();
>> +}
>> +
>>  static const struct arm64_cpu_capabilities arm64_features[] = {
>>  	{
>>  		.desc = "GIC system register CPU interface",
>> @@ -39,6 +45,11 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>  		.register_mask = (0xf << 24),
>>  		.register_value = (1 << 24),
>>  	},
>> +	{
>> +		.desc = "Virtualization Host Extensions",
>> +		.capability = ARM64_HAS_VIRT_HOST_EXTN,
>> +		.matches = runs_at_el2,
>> +	},
>>  	{},
>>  };
>>  
>> -- 
>> 2.1.4
>>
>> _______________________________________________
>> kvmarm mailing list
>> kvmarm at lists.cs.columbia.edu
>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>>
> 


-- 
Jazz is not dead. It just smells funny...
