From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 24 Oct 2017 15:38:03 +0100
Subject: [PATCH v3 2/2] arm64: Fix single stepping in kernel traps
In-Reply-To: <20171024142701.GA14568@arm.com>
References: <1507815783-39929-1-git-send-email-julien.thierry@arm.com>
 <1507815783-39929-3-git-send-email-julien.thierry@arm.com>
 <20171024142701.GA14568@arm.com>
Message-ID: <9f7a93fa-6fd9-f748-4cb9-54e7f33ac6ba@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 24/10/17 15:27, Will Deacon wrote:
> Hi Julien,
> 
> On Thu, Oct 12, 2017 at 02:43:03PM +0100, Julien Thierry wrote:
>> Software Step exception is missing after stepping a trapped instruction.
>>
>> Ensure SPSR.SS gets set to 0 after emulating/skipping a trapped instruction
>> before doing ERET.
> 
> Curious, but how did you spot this?
> 

It was discovered after investigating the issue of single stepping on 
GIC distributor registers accesses from KVM guests. Once the cause of 
the issue was identified as being traps/faults from KVM, it was 
speculated we might have similar issues on EL1 traps which turned out to 
be the case.

>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> ---
>>   arch/arm64/include/asm/insn.h        |  5 +++++
>>   arch/arm64/include/asm/traps.h       |  6 ++++++
>>   arch/arm64/kernel/armv8_deprecated.c |  8 ++++----
>>   arch/arm64/kernel/cpufeature.c       |  2 +-
>>   arch/arm64/kernel/traps.c            | 21 ++++++++++++++++-----
>>   5 files changed, 32 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index 4214c38..de5e31a 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -22,6 +22,11 @@
>>
>>   /* A64 instructions are always 32 bits. */
>>   #define	AARCH64_INSN_SIZE		4
>> +#define	AARCH32_INSN_SIZE		4
>> +
>> +/* Thumb/Thumb2 instruction sizes */
>> +#define	AARCH32_T32_INSN_SIZE		4
>> +#define	AARCH32_T16_INSN_SIZE		2
> 
> The naming here is a bit misleading, since T32 is an instruction set
> consisting of both 32-bit and 16-bit instructions. For now, you might just
> be better off having the caller pass in an immediate directly rather than
> add these confusing #defines.
> 

I see. I guess I'll remove them.

>>   #ifndef __ASSEMBLY__
>>   /*
>> diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
>> index d131501..67b971e 100644
>> --- a/arch/arm64/include/asm/traps.h
>> +++ b/arch/arm64/include/asm/traps.h
>> @@ -37,6 +37,12 @@ struct undef_hook {
>>
>>   void arm64_notify_segfault(struct pt_regs *regs, unsigned long addr);
>>
>> +/*
>> + * Move regs->pc to next instruction and do necessary setup before it
>> + * is executed.
>> + */
>> +void arm64_setup_next_instr(struct pt_regs *regs, unsigned long size);
>> +
>>   static inline int __in_irqentry_text(unsigned long ptr)
>>   {
>>   	return ptr >= (unsigned long)&__irqentry_text_start &&
>> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
>> index d06fbe4..2808e56 100644
>> --- a/arch/arm64/kernel/armv8_deprecated.c
>> +++ b/arch/arm64/kernel/armv8_deprecated.c
>> @@ -431,7 +431,7 @@ static int swp_handler(struct pt_regs *regs, u32 instr)
>>   	pr_warn_ratelimited("\"%s\" (%ld) uses obsolete SWP{B} instruction at 0x%llx\n",
>>   			current->comm, (unsigned long)current->pid, regs->pc);
>>
>> -	regs->pc += 4;
>> +	arm64_setup_next_instr(regs, AARCH32_INSN_SIZE);
>>   	return 0;
>>
>>   fault:
>> @@ -512,7 +512,7 @@ static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
>>   	pr_warn_ratelimited("\"%s\" (%ld) uses deprecated CP15 Barrier instruction at 0x%llx\n",
>>   			current->comm, (unsigned long)current->pid, regs->pc);
>>
>> -	regs->pc += 4;
>> +	arm64_setup_next_instr(regs, AARCH32_INSN_SIZE);
>>   	return 0;
>>   }
>>
>> @@ -586,14 +586,14 @@ static int compat_setend_handler(struct pt_regs *regs, u32 big_endian)
>>   static int a32_setend_handler(struct pt_regs *regs, u32 instr)
>>   {
>>   	int rc = compat_setend_handler(regs, (instr >> 9) & 1);
>> -	regs->pc += 4;
>> +	arm64_setup_next_instr(regs, AARCH32_INSN_SIZE);
>>   	return rc;
>>   }
>>
>>   static int t16_setend_handler(struct pt_regs *regs, u32 instr)
>>   {
>>   	int rc = compat_setend_handler(regs, (instr >> 3) & 1);
>> -	regs->pc += 2;
>> +	arm64_setup_next_instr(regs, AARCH32_T16_INSN_SIZE);
>>   	return rc;
>>   }
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 21e2c95..235834e 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1287,7 +1287,7 @@ static int emulate_mrs(struct pt_regs *regs, u32 insn)
>>   	if (!rc) {
>>   		dst = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
>>   		pt_regs_write_reg(regs, dst, val);
>> -		regs->pc += 4;
>> +		arm64_setup_next_instr(regs, AARCH64_INSN_SIZE);
>>   	}
>>
>>   	return rc;
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index 5ea4b85..f93b33f 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -293,6 +293,17 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
>>   	}
>>   }
>>
>> +void arm64_setup_next_instr(struct pt_regs *regs, unsigned long size)
>> +{
> 
> This strikes me as a pretty broadly named function to be exposing like this.
> How about: arm64_skip_faulting_instruction instead?
> 

Hmmm, I think Alex was not fond of that kind of naming because we are 
not just skipping. Although here we specify it is for faulting instruction.

Your suggestion suits, so if everyone agrees on it I'll change it.

Thanks,

-- 
Julien Thierry
