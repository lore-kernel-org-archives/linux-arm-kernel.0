From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 26 Aug 2016 13:03:35 +0200
Subject: [PATCH v2 9/9] arm64: Work around systems with mismatched cache
 line sizes
In-Reply-To: <1472203398-8751-10-git-send-email-suzuki.poulose@arm.com>
References: <1472203398-8751-1-git-send-email-suzuki.poulose@arm.com>
 <1472203398-8751-10-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CAKv+Gu_AyrQLdjf+1-QuZu3k2goT-_6Dk5mQbvP6XSmu30V4cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Suzuki,

On 26 August 2016 at 11:23, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> Systems with differing CPU i-cache/d-cache line sizes can cause
> problems with the cache management by software when the execution
> is migrated from one to another. Usually, the application reads
> the cache size on a CPU and then uses that length to perform cache
> operations. However, if it gets migrated to another CPU with a smaller
> cache line size, things could go completely wrong. To prevent such
> cases, always use the smallest cache line size among the CPUs. The
> kernel CPU feature infrastructure already keeps track of the safe
> value for all CPUID registers including CTR. This patch works around
> the problem by :
>
> For kernel, dynamically patch the kernel to read the cache size
> from the system wide copy of CTR_EL0.
>
> For applications, trap read accesses to CTR_EL0 (by clearing the SCTLR.UCT)
> and emulate the mrs instruction to return the system wide safe value
> of CTR_EL0.
>
> For faster access (i.e, avoiding to lookup the system wide value of CTR_EL0
> via read_system_reg), we keep track of the pointer to table entry for
> CTR_EL0 in the CPU feature infrastructure.
>

IIUC it is the runtime sorting of the arm64_ftr_reg array that
requires you to stash a pointer to CTR_EL0's entry somewhere, so that
you can dereference it without doing the bsearch.

IMO, this is a pattern that we should avoid: you are introducing one
instance now, which will make it hard to say no to the next one in the
future. Isn't there a better way to organize the arm64_ftr_reg array
that allows us to reference entries directly? Ideally, a way that gets
rid of the runtime sorting, since I don't think that is a good
replacement for developer discipline anyway (although I should have
spoken up when that was first introduced) Or am I missing something
here?

-- 
Ard.

> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/assembler.h  | 25 +++++++++++++++++++++++--
>  arch/arm64/include/asm/cpufeature.h |  4 +++-
>  arch/arm64/include/asm/esr.h        |  8 ++++++++
>  arch/arm64/include/asm/sysreg.h     |  1 +
>  arch/arm64/kernel/asm-offsets.c     |  2 ++
>  arch/arm64/kernel/cpu_errata.c      | 22 ++++++++++++++++++++++
>  arch/arm64/kernel/cpufeature.c      |  9 +++++++++
>  arch/arm64/kernel/traps.c           | 14 ++++++++++++++
>  8 files changed, 82 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index a4bb3f5..66bd268 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -216,6 +216,21 @@ lr .req    x30             // link register
>         .macro  mmid, rd, rn
>         ldr     \rd, [\rn, #MM_CONTEXT_ID]
>         .endm
> +/*
> + * read_ctr - read CTR_EL0. If the system has mismatched
> + * cache line sizes, provide the system wide safe value.
> + */
> +       .macro  read_ctr, reg
> +alternative_if_not ARM64_MISMATCHED_CACHE_LINE_SIZE
> +       mrs     \reg, ctr_el0                   // read CTR
> +       nop
> +       nop
> +alternative_else
> +       ldr_l   \reg, sys_ctr_ftr               // Read system wide safe CTR value
> +       ldr     \reg, [\reg, #ARM64_FTR_SYSVAL] // from sys_ctr_ftr->sys_val
> +alternative_endif
> +       .endm
> +
>
>  /*
>   * raw_dcache_line_size - get the minimum D-cache line size on this CPU
> @@ -232,7 +247,10 @@ lr .req    x30             // link register
>   * dcache_line_size - get the safe D-cache line size across all CPUs
>   */
>         .macro  dcache_line_size, reg, tmp
> -       raw_dcache_line_size    \reg, \tmp
> +       read_ctr        \tmp
> +       ubfm            \tmp, \tmp, #16, #19    // cache line size encoding
> +       mov             \reg, #4                // bytes per word
> +       lsl             \reg, \reg, \tmp        // actual cache line size
>         .endm
>
>  /*
> @@ -250,7 +268,10 @@ lr .req    x30             // link register
>   * icache_line_size - get the safe I-cache line size across all CPUs
>   */
>         .macro  icache_line_size, reg, tmp
> -       raw_icache_line_size    \reg, \tmp
> +       read_ctr        \tmp
> +       and             \tmp, \tmp, #0xf        // cache line size encoding
> +       mov             \reg, #4                // bytes per word
> +       lsl             \reg, \reg, \tmp        // actual cache line size
>         .endm
>
>  /*
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 692b8d3..e99f2af 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -37,8 +37,9 @@
>  #define ARM64_WORKAROUND_CAVIUM_27456          12
>  #define ARM64_HAS_32BIT_EL0                    13
>  #define ARM64_HYP_OFFSET_LOW                   14
> +#define ARM64_MISMATCHED_CACHE_LINE_SIZE       15
>
> -#define ARM64_NCAPS                            15
> +#define ARM64_NCAPS                            16
>
>  #ifndef __ASSEMBLY__
>
> @@ -109,6 +110,7 @@ struct arm64_cpu_capabilities {
>  };
>
>  extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
> +extern struct arm64_ftr_reg *sys_ctr_ftr;
>
>  bool this_cpu_has_cap(unsigned int cap);
>
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index 9875b32..d14c478 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -149,6 +149,9 @@
>                                          ((op2) << ESR_ELx_SYS64_ISS_OP2_SHIFT) | \
>                                          ((crn) << ESR_ELx_SYS64_ISS_CRN_SHIFT) | \
>                                          ((crm) << ESR_ELx_SYS64_ISS_CRM_SHIFT))
> +
> +#define ESR_ELx_SYS64_ISS_SYS_OP_MASK  (ESR_ELx_SYS64_ISS_SYS_MASK | \
> +                                        ESR_ELx_SYS64_ISS_DIR_MASK)
>  /*
>   * User space cache operations have the following sysreg encoding
>   * in System instructions.
> @@ -167,6 +170,11 @@
>  #define ESR_ELx_SYS64_ISS_EL0_CACHE_OP_VAL \
>                                 (ESR_ELx_SYS64_ISS_SYS_VAL(1, 3, 1, 7, 0) | \
>                                  ESR_ELx_SYS64_ISS_DIR_WRITE)
> +
> +#define ESR_ELx_SYS64_ISS_SYS_CTR      ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 1, 0, 0)
> +#define ESR_ELx_SYS64_ISS_SYS_CTR_READ (ESR_ELx_SYS64_ISS_SYS_CTR | \
> +                                        ESR_ELx_SYS64_ISS_DIR_READ)
> +
>  #ifndef __ASSEMBLY__
>  #include <asm/types.h>
>
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index cc06794..4f26ad5 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -100,6 +100,7 @@
>  /* SCTLR_EL1 specific flags. */
>  #define SCTLR_EL1_UCI          (1 << 26)
>  #define SCTLR_EL1_SPAN         (1 << 23)
> +#define SCTLR_EL1_UCT          (1 << 15)
>  #define SCTLR_EL1_SED          (1 << 8)
>  #define SCTLR_EL1_CP15BEN      (1 << 5)
>
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 05070b7..4a2f0f0 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -23,6 +23,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/kvm_host.h>
>  #include <linux/suspend.h>
> +#include <asm/cpufeature.h>
>  #include <asm/thread_info.h>
>  #include <asm/memory.h>
>  #include <asm/smp_plat.h>
> @@ -145,5 +146,6 @@ int main(void)
>    DEFINE(HIBERN_PBE_ORIG,      offsetof(struct pbe, orig_address));
>    DEFINE(HIBERN_PBE_ADDR,      offsetof(struct pbe, address));
>    DEFINE(HIBERN_PBE_NEXT,      offsetof(struct pbe, next));
> +  DEFINE(ARM64_FTR_SYSVAL,     offsetof(struct arm64_ftr_reg, sys_val));
>    return 0;
>  }
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 5836b3d..621fa7f 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -30,6 +30,21 @@ is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int scope)
>                                        entry->midr_range_max);
>  }
>
> +static bool
> +has_mismatched_cache_line_size(const struct arm64_cpu_capabilities *entry,
> +                               int scope)
> +{
> +       WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
> +       return (read_cpuid_cachetype() & sys_ctr_ftr->strict_mask) !=
> +                (sys_ctr_ftr->sys_val & sys_ctr_ftr->strict_mask);
> +}
> +
> +static void cpu_enable_trap_ctr_access(void *__unused)
> +{
> +       /* Clear SCTLR_EL1.UCT */
> +       config_sctlr_el1(SCTLR_EL1_UCT, 0);
> +}
> +
>  #define MIDR_RANGE(model, min, max) \
>         .def_scope = SCOPE_LOCAL_CPU, \
>         .matches = is_affected_midr_range, \
> @@ -108,6 +123,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>         },
>  #endif
>         {
> +               .desc = "Mismatched cache line size",
> +               .capability = ARM64_MISMATCHED_CACHE_LINE_SIZE,
> +               .matches = has_mismatched_cache_line_size,
> +               .def_scope = SCOPE_LOCAL_CPU,
> +               .enable = cpu_enable_trap_ctr_access,
> +       },
> +       {
>         }
>  };
>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index fcf87ca..c1db313 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -46,6 +46,13 @@ unsigned int compat_elf_hwcap2 __read_mostly;
>
>  DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>
> +/*
> + * If we have mismatched cache line sizes, we need to emulate access to
> + * CTRL_EL0. To avoid a lookup everytime (via read_system_reg()), cache
> + * the table entry for CTR_EL0.
> + */
> +struct arm64_ftr_reg *sys_ctr_ftr;
> +
>  #define __ARM64_FTR_BITS(SIGNED, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
>         {                                               \
>                 .sign = SIGNED,                         \
> @@ -461,6 +468,8 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
>                 init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
>         }
>
> +       /* Keep track of the CTR feature register */
> +       sys_ctr_ftr = get_arm64_ftr_reg(SYS_CTR_EL0);
>  }
>
>  static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 224f64e..7c28898 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -480,6 +480,14 @@ static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
>                 regs->pc += 4;
>  }
>
> +static void ctr_read_handler(unsigned int esr, struct pt_regs *regs)
> +{
> +       int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
> +
> +       regs->regs[rt] = sys_ctr_ftr->sys_val;
> +       regs->pc += 4;
> +}
> +
>  struct sys64_hook {
>         unsigned int esr_mask;
>         unsigned int esr_val;
> @@ -492,6 +500,12 @@ static struct sys64_hook sys64_hooks[] = {
>                 .esr_val = ESR_ELx_SYS64_ISS_EL0_CACHE_OP_VAL,
>                 .handler = user_cache_maint_handler,
>         },
> +       {
> +               /* Trap read access to CTR_EL0 */
> +               .esr_mask = ESR_ELx_SYS64_ISS_SYS_OP_MASK,
> +               .esr_val = ESR_ELx_SYS64_ISS_SYS_CTR_READ,
> +               .handler = ctr_read_handler,
> +       },
>         {},
>  };
>
> --
> 2.7.4
>
