From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 05 Aug 2015 15:58:51 +0100
Subject: [RFC PATCH 05/10] arm64: Keep track of CPU feature registers
In-Reply-To: <1437731037-25795-6-git-send-email-suzuki.poulose@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
 <1437731037-25795-6-git-send-email-suzuki.poulose@arm.com>
Message-ID: <55C224AB.8020402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/15 10:43, Suzuki K. Poulose wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>
> This patch adds an infrastructure to keep track of the CPU feature
> registers on the system. This patch also consolidates the cpuinfo
> SANITY checks which ensures that we don't have conflicting feature
> supports across the CPUs.
>
> Each register has a set of feature bits defined by the architecture.
> We define the following attributes:
>
>   1) strict - If strict matching is required for the field across the
>      all the CPUs for SANITY checks.
>   2) visible - If the field is exposed to the userspace (See documentation
>      for more details).
>
> The default 'safe' value for the feature is also defined, which will be
> used:
>   1) To set the value for a 'discrete' feature with conflicting values.
>   2) To set the value for an 'invisible' feature for the userspace.
>
> The infrastructure keeps track of the following values for a feature
> register:
>   - user visible value
>   - system wide safe value
>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/include/asm/cpu.h |  149 ++++++++++++++++
>   arch/arm64/kernel/cpuinfo.c  |  399 ++++++++++++++++++++++++++++++++++++++----
>   2 files changed, 511 insertions(+), 37 deletions(-)
>
> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> index a34de72..c7b0b89 100644
> --- a/arch/arm64/include/asm/cpu.h
> +++ b/arch/arm64/include/asm/cpu.h
...
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index a13468b..ae2a37f 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -31,6 +31,207 @@
>   #include <linux/sched.h>
>   #include <linux/smp.h>
>
...
> -#define CHECK_MASK(field, mask, boot, cur, cpu) \
> -       check_reg_mask(#field, mask, (boot)->reg_ ## field, (cur)->reg_ ## field, cpu)
> -
> -#define CHECK(field, boot, cur, cpu) \
> -       CHECK_MASK(field, ~0ULL, boot, cur, cpu)
> +#define CHECK_CPUINFO(field)                                                           \
> +       ({                                                                              \
> +               int __rc = 0;                                                           \
> +               struct arm64_ftr_reg *__regp = get_arm64_sys_reg(sys_ ## field);        \
> +               if (__regp) {                                                           \
> +                       __rc = check_reg_mask(__regp,                                   \
> +                                               (boot)->reg_ ## field,                  \
> +                                               (cur)->reg_ ## field, cpu);             \
> +                       update_cpu_ftr_reg(__regp, cur->reg_ ## field, cpu);            \
> +               }                                                                       \
> +               __rc;                                                                   \
> +       })
>
>   /*
>    * Verify that CPUs don't have unexpected differences that will cause problems.
> @@ -123,17 +448,17 @@ static void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur)
>           * caches should look identical. Userspace JITs will make use of
>           * *minLine.
>           */
> -       diff |= CHECK_MASK(ctr, 0xffff3fff, boot, cur, cpu);
> +       diff |= CHECK_CPUINFO(ctr);
>
>          /*
>           * Userspace may perform DC ZVA instructions. Mismatched block sizes
>           * could result in too much or too little memory being zeroed if a
>           * process is preempted and migrated between CPUs.
>           */
> -       diff |= CHECK(dczid, boot, cur, cpu);
> +       diff |= CHECK_CPUINFO(dczid);
>
>          /* If different, timekeeping will be broken (especially with KVM) */
> -       diff |= CHECK(cntfrq, boot, cur, cpu);
> +       diff |= CHECK_CPUINFO(cntfrq);
>
>          /*
>           * The kernel uses self-hosted debug features and expects CPUs to
> @@ -141,15 +466,15 @@ static void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur)
>           * and BRPs to be identical.
>           * ID_AA64DFR1 is currently RES0.
>           */
> -       diff |= CHECK(id_aa64dfr0, boot, cur, cpu);
> -       diff |= CHECK(id_aa64dfr1, boot, cur, cpu);
> +       diff |= CHECK_CPUINFO(id_aa64dfr0);
> +       diff |= CHECK_CPUINFO(id_aa64dfr1);
>
>          /*
>           * Even in big.LITTLE, processors should be identical instruction-set
>           * wise.
>           */
> -       diff |= CHECK(id_aa64isar0, boot, cur, cpu);
> -       diff |= CHECK(id_aa64isar1, boot, cur, cpu);
> +       diff |= CHECK_CPUINFO(id_aa64isar0);
> +       diff |= CHECK_CPUINFO(id_aa64isar1);
>
>          /*
>           * Differing PARange support is fine as long as all peripherals and
> @@ -157,42 +482,42 @@ static void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur)
>           * Linux should not care about secure memory.
>           * ID_AA64MMFR1 is currently RES0.
>           */
> -       diff |= CHECK_MASK(id_aa64mmfr0, 0xffffffffffff0ff0, boot, cur, cpu);
> -       diff |= CHECK(id_aa64mmfr1, boot, cur, cpu);
> +       diff |= CHECK_CPUINFO(id_aa64mmfr0);
> +       diff |= CHECK_CPUINFO(id_aa64mmfr1);
>
>          /*
>           * EL3 is not our concern.
>           * ID_AA64PFR1 is currently RES0.
>           */
> -       diff |= CHECK_MASK(id_aa64pfr0, 0xffffffffffff0fff, boot, cur, cpu);
> -       diff |= CHECK(id_aa64pfr1, boot, cur, cpu);
> +       diff |= CHECK_CPUINFO(id_aa64pfr0);
> +       diff |= CHECK_CPUINFO(id_aa64pfr1);
>
>          /*
>           * If we have AArch32, we care about 32-bit features for compat. These
>           * registers should be RES0 otherwise.
>           */
> -       diff |= CHECK(id_dfr0, boot, cur, cpu);
> -       diff |= CHECK(id_isar0, boot, cur, cpu);
> -       diff |= CHECK(id_isar1, boot, cur, cpu);
> -       diff |= CHECK(id_isar2, boot, cur, cpu);
> -       diff |= CHECK(id_isar3, boot, cur, cpu);
> -       diff |= CHECK(id_isar4, boot, cur, cpu);
> -       diff |= CHECK(id_isar5, boot, cur, cpu);
> +       diff |= CHECK_CPUINFO(id_dfr0);
> +       diff |= CHECK_CPUINFO(id_isar0);
> +       diff |= CHECK_CPUINFO(id_isar1);
> +       diff |= CHECK_CPUINFO(id_isar2);
> +       diff |= CHECK_CPUINFO(id_isar3);
> +       diff |= CHECK_CPUINFO(id_isar4);
> +       diff |= CHECK_CPUINFO(id_isar5);
>          /*
>           * Regardless of the value of the AuxReg field, the AIFSR, ADFSR, and
>           * ACTLR formats could differ across CPUs and therefore would have to
>           * be trapped for virtualization anyway.
>           */
> -       diff |= CHECK_MASK(id_mmfr0, 0xff0fffff, boot, cur, cpu);
> -       diff |= CHECK(id_mmfr1, boot, cur, cpu);
> -       diff |= CHECK(id_mmfr2, boot, cur, cpu);
> -       diff |= CHECK(id_mmfr3, boot, cur, cpu);
> -       diff |= CHECK(id_pfr0, boot, cur, cpu);
> -       diff |= CHECK(id_pfr1, boot, cur, cpu);
> +       diff |= CHECK_CPUINFO(id_mmfr0);
> +       diff |= CHECK_CPUINFO(id_mmfr1);
> +       diff |= CHECK_CPUINFO(id_mmfr2);
> +       diff |= CHECK_CPUINFO(id_mmfr3);
> +       diff |= CHECK_CPUINFO(id_pfr0);
> +       diff |= CHECK_CPUINFO(id_pfr1);
>
> -       diff |= CHECK(mvfr0, boot, cur, cpu);
> -       diff |= CHECK(mvfr1, boot, cur, cpu);
> -       diff |= CHECK(mvfr2, boot, cur, cpu);
> +       diff |= CHECK_CPUINFO(mvfr0);
> +       diff |= CHECK_CPUINFO(mvfr1);
> +       diff |= CHECK_CPUINFO(mvfr2);
>
>          /*
>           * Mismatched CPU features are a recipe for disaster. Don't even
> @@ -239,7 +564,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
>          cpuinfo_detect_icache_policy(info);
>
>          check_local_cpu_errata();
> -       check_local_cpu_features();
> +       cpuinfo_sanity_check(info);
These two changes shouldn't be there, I have fixed it locally.
>          update_cpu_features(info);
>   }
>
> @@ -247,13 +572,13 @@ void cpuinfo_store_cpu(void)
>   {
>          struct cpuinfo_arm64 *info = this_cpu_ptr(&cpu_data);
>          __cpuinfo_store_cpu(info);
> -       cpuinfo_sanity_check(info);
As above, this line should be retained here.
>   }
>
>   void __init cpuinfo_store_boot_cpu(void)
>   {
>          struct cpuinfo_arm64 *info = &per_cpu(cpu_data, 0);
>          __cpuinfo_store_cpu(info);
> +       init_cpu_ftrs(info);

Thanks
Suzuki
