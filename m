From: dave.long@linaro.org (David Long)
Date: Mon, 13 Jun 2016 00:19:52 -0400
Subject: [PATCH v13 03/10] arm64: add conditional instruction simulation
 support
In-Reply-To: <20160604125318.0f5c6fe348fec92502bef3b9@kernel.org>
References: <1464924384-15269-1-git-send-email-dave.long@linaro.org>
 <1464924384-15269-4-git-send-email-dave.long@linaro.org>
 <20160604125318.0f5c6fe348fec92502bef3b9@kernel.org>
Message-ID: <575E3468.2000304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2016 11:53 PM, Masami Hiramatsu wrote:
> On Thu,  2 Jun 2016 23:26:17 -0400
> David Long <dave.long@linaro.org> wrote:
>
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Cease using the arm32 arm_check_condition() function and replace it with
>> a local version for use in deprecated instruction support on arm64. Also
>> make the function table used by this available for future use by kprobes
>> and/or uprobes.
>>
>> This function is dervied from code written by Sandeepa Prabhu.
>>
>
> Basically looks good to me. I have some comments;
>
>> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>>   arch/arm64/include/asm/insn.h        |  3 ++
>>   arch/arm64/kernel/Makefile           |  3 +-
>>   arch/arm64/kernel/armv8_deprecated.c | 19 ++++++-
>>   arch/arm64/kernel/insn.c             | 98 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 119 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index 9785d10..98e4edd 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -406,6 +406,9 @@ u32 aarch64_extract_system_register(u32 insn);
>>   u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
>>   u32 aarch32_insn_mcr_extract_opc2(u32 insn);
>>   u32 aarch32_insn_mcr_extract_crm(u32 insn);
>> +
>> +typedef bool (pstate_check_t)(unsigned long);
>> +extern pstate_check_t * const opcode_condition_checks[16];
>
> Are those condition checkers only for aarch32 opcode? or
> general for aarch64 too? If it is only for aarch32, we'd better
> add aarch32 prefix.
>

I have this vague recollection there once was a reason for this but I 
can't for the life of me remember why. I altered the symbol name to 
something that begins with aarch32.

>>   #endif /* __ASSEMBLY__ */
>>
>>   #endif	/* __ASM_INSN_H */
>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>> index 2173149..4653aca 100644
>> --- a/arch/arm64/kernel/Makefile
>> +++ b/arch/arm64/kernel/Makefile
>> @@ -26,8 +26,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
>>   	$(call if_changed,objcopy)
>>
>>   arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
>> -					   sys_compat.o entry32.o		\
>> -					   ../../arm/kernel/opcodes.o
>> +					   sys_compat.o entry32.o
>>   arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
>>   arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
>>   arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
>> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
>> index c37202c..88b9165 100644
>> --- a/arch/arm64/kernel/armv8_deprecated.c
>> +++ b/arch/arm64/kernel/armv8_deprecated.c
>> @@ -366,6 +366,21 @@ static int emulate_swpX(unsigned int address, unsigned int *data,
>>   	return res;
>>   }
>>
>> +#define	ARM_OPCODE_CONDITION_UNCOND	0xf
>> +
>> +static unsigned int __kprobes arm32_check_condition(u32 opcode, u32 psr)
>
> Would you be OK for using arm32 instead of aarch32 prefix?

I think you meant the opposite of that?  I guess that would make sense, 
and would be simple enough since it's an internal function.  I will 
change arm32 to aarch32.

>
>> +{
>> +	u32 cc_bits  = opcode >> 28;
>> +
>> +	if (cc_bits != ARM_OPCODE_CONDITION_UNCOND) {
>> +		if ((*opcode_condition_checks[cc_bits])(psr))
>> +			return ARM_OPCODE_CONDTEST_PASS;
>> +		else
>> +			return ARM_OPCODE_CONDTEST_FAIL;
>> +	}
>> +	return ARM_OPCODE_CONDTEST_UNCOND;
>> +}
>
> Thank you,
>

Thanks,
-dl
