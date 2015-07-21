From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 21 Jul 2015 11:30:08 +0100
Subject: [PATCH v2 6/6] arm64: kernel: Add support for Privileged Access
 Never
In-Reply-To: <1437154221-5736-7-git-send-email-james.morse@arm.com>
References: <1437154221-5736-1-git-send-email-james.morse@arm.com>
 <1437154221-5736-7-git-send-email-james.morse@arm.com>
Message-ID: <55AE1F30.6020803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/15 18:30, James Morse wrote:
> 'Privileged Access Never' is a new arm8.1 feature which prevents
> privileged code from accessing any virtual address where read or write
> access is also permitted at EL0.
>
> This patch enables the PAN feature on all CPUs, and modifies {get,put}_user
> helpers temporarily to permit access.
>
> This will catch kernel bugs where user memory is accessed directly.
> 'Unprivileged loads and stores' using ldtrb et al are unaffected by PAN.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm64/Kconfig                   | 14 ++++++++++++++
>   arch/arm64/include/asm/cpufeature.h  |  3 ++-
>   arch/arm64/include/asm/futex.h       |  8 ++++++++
>   arch/arm64/include/asm/processor.h   |  2 ++
>   arch/arm64/include/asm/sysreg.h      |  9 +++++++++
>   arch/arm64/include/asm/uaccess.h     | 11 +++++++++++
>   arch/arm64/include/uapi/asm/ptrace.h |  1 +
>   arch/arm64/kernel/cpufeature.c       | 20 ++++++++++++++++++++
>   arch/arm64/lib/clear_user.S          |  8 ++++++++
>   arch/arm64/lib/copy_from_user.S      |  8 ++++++++
>   arch/arm64/lib/copy_in_user.S        |  8 ++++++++
>   arch/arm64/lib/copy_to_user.S        |  8 ++++++++
>   arch/arm64/mm/fault.c                | 23 +++++++++++++++++++++++
>   13 files changed, 122 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 318175f62c24..c53a4b1d5968 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -597,6 +597,20 @@ config FORCE_MAX_ZONEORDER
>          default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
>          default "11"
>
> +config ARM64_PAN
> +       bool "Enable support for Privileged Access Never (PAN)"
> +       default y
> +       help
> +        Privileged Access Never (PAN; part of the ARMv8.1 Extensions)
> +        prevents the kernel or hypervisor from accessing user-space (EL0)
> +        memory directly.
> +
> +        Choosing this option will cause any unprotected (not using
> +        copy_to_user et al) memory access to fail with a permission fault.
> +
> +        The feature is detected at runtime, and will remain as a 'nop'
> +        instruction if the cpu does not implement the feature.
> +
>   menuconfig ARMV8_DEPRECATED
>          bool "Emulate deprecated/obsolete ARMv8 instructions"
>          depends on COMPAT
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index ef38e21ed719..420329a1b98f 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -25,8 +25,9 @@
>   #define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE   1
>   #define ARM64_WORKAROUND_845719                        2
>   #define ARM64_HAS_SYSREG_GIC_CPUIF             3
> +#define ARM64_HAS_PAN                          4
>
> -#define ARM64_NCAPS                            4
> +#define ARM64_NCAPS                            5
>
>   #ifndef __ASSEMBLY__
>
> diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
> index 74069b3bd919..775e85b9d1f2 100644
> --- a/arch/arm64/include/asm/futex.h
> +++ b/arch/arm64/include/asm/futex.h
> @@ -20,10 +20,16 @@
>
>   #include <linux/futex.h>
>   #include <linux/uaccess.h>
> +
> +#include <asm/alternative.h>
> +#include <asm/cpufeature.h>
>   #include <asm/errno.h>
> +#include <asm/sysreg.h>
>
>   #define __futex_atomic_op(insn, ret, oldval, uaddr, tmp, oparg)                \
>          asm volatile(                                                   \
> +       ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN,            \
> +                   CONFIG_ARM64_PAN)                                   \
>   "1:    ldxr    %w1, %2\n"                                              \
>          insn "\n"                                                       \
>   "2:    stlxr   %w3, %w0, %2\n"                                         \
> @@ -39,6 +45,8 @@
>   "      .align  3\n"                                                    \
>   "      .quad   1b, 4b, 2b, 4b\n"                                       \
>   "      .popsection\n"                                                  \
> +       ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN,            \
> +                   CONFIG_ARM64_PAN)                                   \
>          : "=&r" (ret), "=&r" (oldval), "+Q" (*uaddr), "=&r" (tmp)       \
>          : "r" (oparg), "Ir" (-EFAULT)                                   \
>          : "memory")
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index e4c893e54f01..98f32355dc97 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -186,4 +186,6 @@ static inline void spin_lock_prefetch(const void *x)
>
>   #endif
>
> +void cpu_enable_pan(void);
> +
>   #endif /* __ASM_PROCESSOR_H */
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 56391fbae1e1..f243bb1adaa5 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -20,12 +20,21 @@
>   #ifndef __ASM_SYSREG_H
>   #define __ASM_SYSREG_H
>
> +#include <asm/opcodes.h>
> +
>   #define SCTLR_EL1_CP15BEN      (0x1 << 5)
>   #define SCTLR_EL1_SED          (0x1 << 8)
>
>   #define sys_reg(op0, op1, crn, crm, op2) \
>          ((((op0)-2)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
>
> +#define REG_PSTATE_PAN_IMM                     sys_reg(2, 0, 4, 0, 4)

I think the above encoding is incorrect (even though, the code works fine).
While setting the PAN with an immediate value, the PAN is treated just like
a Process state field and the encoding becomes:
  Op0=0, Op1=0 ...
The encoding 2,0 ,... works fine in this case due to a bug in the sys_reg()
macro above, where op0 is encoded as (op0 - 2). I took a look at the ARMv8 ARM,
section C5.2.{3, 4, 5, 6} and the system instruction class reserves bits[20-19] for Op0.
I think we should fix that first and use the appropriate encoding mandated by the
architecture to avoid further errors.


> +#define PSTATE_PAN                             (1 << 22)
> +#define SCTLR_EL1_SPAN                         (1 << 23)
> +
> +#define SET_PSTATE_PAN(x) __inst_arm(0xd5000000 | REG_PSTATE_PAN_IMM |\
> +                                    (!!x)<<8 | 0x1f)


Thanks
Suzuki
