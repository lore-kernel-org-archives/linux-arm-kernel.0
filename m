From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 2 Sep 2016 16:52:25 +0100
Subject: [PATCH 2/2] arm64: Use static keys for CPU features
In-Reply-To: <f690f532-a05e-5c13-6b97-b94203701d3d@arm.com>
References: <1472145992-10660-1-git-send-email-catalin.marinas@arm.com>
 <1472145992-10660-3-git-send-email-catalin.marinas@arm.com>
 <f690f532-a05e-5c13-6b97-b94203701d3d@arm.com>
Message-ID: <20160902155224.GC391@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 10:22:13AM +0100, Suzuki K. Poulose wrote:
> On 25/08/16 18:26, Catalin Marinas wrote:
> > static inline int __attribute_const__
> >diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >index 62272eac1352..919b2d0d68ae 100644
> >--- a/arch/arm64/kernel/cpufeature.c
> >+++ b/arch/arm64/kernel/cpufeature.c
> >@@ -46,6 +46,9 @@ unsigned int compat_elf_hwcap2 __read_mostly;
> >
> > DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
> >
> >+DEFINE_STATIC_KEY_ARRAY_FALSE(cpu_hwcap_keys, ARM64_NCAPS);
> >+EXPORT_SYMBOL(cpu_hwcap_keys);
> >+
> > #define __ARM64_FTR_BITS(SIGNED, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
> > 	{						\
> > 		.sign = SIGNED,				\
> >diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> >index ed1b84fe6925..6a141e399daf 100644
> >--- a/arch/arm64/kernel/cpuinfo.c
> >+++ b/arch/arm64/kernel/cpuinfo.c
> >@@ -377,6 +377,12 @@ void cpuinfo_store_cpu(void)
> > void __init cpuinfo_store_boot_cpu(void)
> > {
> > 	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, 0);
> >+
> >+	/*
> >+	 * Initialise the static keys early as they may be enabled by
> >+	 * check_local_cpu_errata() -> update_cpu_capabilities().
> >+	 */
> >+	jump_label_init();
> > 	__cpuinfo_store_cpu(info);
> 
> Just a heads up. I have a patch [1] which moves the "check_local_cpu_errata()"
> around to smp_prepare_boot_cpu(). This patch should still work fine with that
> case. Only that may be we could move the jump_lable_init() to smp_prepare_boot_cpu(),
> before we call "update_cpu_errata_work_arounds()" for Boot CPU.

IIUC, we wouldn't call update_cpu_errata_work_arounds() until the CPU
feature infrastructure is initialised via cpuinfo_store_boot_cpu(). So
I don't think moving the jump_label_init() call above is necessary.

> [1] https://lkml.kernel.org/r/1471525832-21209-4-git-send-email-suzuki.poulose at arm.com

-- 
Catalin
