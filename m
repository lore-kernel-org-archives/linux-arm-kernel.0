From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Jul 2015 13:57:03 +0100
Subject: [PATCH 5/5] arm64: kernel: Add support for Privileged Access Never
In-Reply-To: <1437062519-18883-6-git-send-email-james.morse@arm.com>
References: <1437062519-18883-1-git-send-email-james.morse@arm.com>
 <1437062519-18883-6-git-send-email-james.morse@arm.com>
Message-ID: <20150717125702.GF13712@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 05:01:59PM +0100, James Morse wrote:
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 7e419fabe75a..68aa1e399575 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -20,9 +20,18 @@
>  #ifndef __ASM_SYSREG_H
>  #define __ASM_SYSREG_H
>  
> +#include <asm/opcodes.h>
> +
>  #define sys_reg(op0, op1, crn, crm, op2) \
>  	((((op0)-2)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
>  
> +#define REG_PSTATE_PAN_IMM                     sys_reg(2, 0, 4, 0, 4)
> +#define PSTATE_PAN                             (1 << 22)

I missed this before, can we have a PSR_PAN_BIT in uapi/asm/ptrace.h for
consistency with the other PSTATE bits? It's not user accessible but we
did the same with the I and F bits already.

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f260affb825c..0464eaef6667 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -21,6 +21,7 @@
>  #include <linux/types.h>
>  #include <asm/cpu.h>
>  #include <asm/cpufeature.h>
> +#include <asm/processor.h>
>  
>  static bool
>  has_id_aa64pfr0_feature(const struct arm64_cpu_capabilities *entry)
> @@ -32,6 +33,16 @@ has_id_aa64pfr0_feature(const struct arm64_cpu_capabilities *entry)
>  		(val & entry->register_mask) <= entry->max_register_value);
>  }
>  
> +static bool __maybe_unused
> +has_id_aa64mmfr1_feature(const struct arm64_cpu_capabilities *entry)
> +{
> +	u64 val;
> +
> +	val = read_cpuid(id_aa64mmfr1_el1);
> +	return ((val & entry->register_mask) >= entry->min_register_value &&
> +		(val & entry->register_mask) <= entry->max_register_value);
> +}

That's fine until we clarify what we actually want here in the other
patch.

> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 223b093c9440..cea69aae4997 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -277,6 +277,9 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>  	} else {
>  		memset(childregs, 0, sizeof(struct pt_regs));
>  		childregs->pstate = PSR_MODE_EL1h;
> +		if (IS_ENABLED(CONFIG_ARM64_PAN) &&
> +		    cpus_have_cap(ARM64_HAS_PAN))
> +			childregs->pstate |= PSTATE_PAN;
>  		p->thread.cpu_context.x19 = stack_start;
>  		p->thread.cpu_context.x20 = stk_sz;

I wonder if this is actually needed. When we run in kernel mode, PAN is
always set (automatically on exception entry) and only explicitly
cleared for get_user/put_user etc. Switching to a kernel thread is done
via switch_to which preserves PAN, so the regs->pstate here is not
relevant (IOW, we only ever ERET to a kernel thread after an
exception/interrupt but in that case pstate.pan is already set by the
handler).

-- 
Catalin
