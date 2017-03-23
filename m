From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 23 Mar 2017 14:37:05 +0000
Subject: [RFC PATCH v2 38/41] arm64/sve: Detect SVE via the cpufeature
 framework
In-Reply-To: <6466e33e-5d22-1a78-bacb-d9dc334ee6d7@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <1490194274-30569-39-git-send-email-Dave.Martin@arm.com>
 <6466e33e-5d22-1a78-bacb-d9dc334ee6d7@arm.com>
Message-ID: <20170323143704.GI3750@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 02:11:50PM +0000, Suzuki K Poulose wrote:
> On 22/03/17 14:51, Dave Martin wrote:
> >For robust feature detection and appropriate handling of feature
> >mismatches between CPUs, this patch adds knowledge of the new
> >feature fields and new registers ZCR_EL1 and ID_AA64ZFR0_EL1 to the
> >cpufeature framework.
> 
> ...
> 
> >
> >The SVE field in AA64PFR0 is made visible visible to userspace MRS
> >emulation.  This should make sense for future architecture
> >extensions.
> 
> Please could you also update the following documentation :
> 
>  Documentation/arm64/cpu-feature-registers.txt

Missed that, thanks.

I'll propose a comment in this file reminding people to keep the
document up to date too.

[...]

> >diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> >index ddb651a..34ec75e 100644
> >--- a/arch/arm64/kernel/fpsimd.c
> >+++ b/arch/arm64/kernel/fpsimd.c
> >@@ -340,6 +340,26 @@ int sve_get_task_vl(struct task_struct *task)
> > 	return sve_prctl_status(task);
> > }
> >
> >+void __init sve_setup(void)
> >+{
> >+	u64 zcr;
> >+
> >+	if (!system_supports_sve())
> >+		return;
> >+
> >+	zcr = read_system_reg(SYS_ZCR_EL1);
> >+
> >+	BUG_ON(((zcr & ZCR_EL1_LEN_MASK) + 1) * 16 > sve_max_vl);
> >+
> >+	sve_max_vl = ((zcr & ZCR_EL1_LEN_MASK) + 1) * 16;
> >+	sve_default_vl = sve_max_vl > 64 ? 64 : sve_max_vl;
> >+
> >+	pr_info("SVE: maximum available vector length %u bytes per vector\n",
> >+		sve_max_vl);
> >+	pr_info("SVE: default vector length %u bytes per vector\n",
> >+		sve_default_vl);
> 
> I think we may need an extra check in verify_local_cpu_capabilities() to make sure the new CPU,
> which comes up late can support the SVE vector length that could possibly used, i.e, sve_max_vl.

You're right -- I had that in a previous draft of the code but forgot
about it when in rewrote it.

> Rest looks good to me.
> 
> Suzuki
> 
> >+}
> >+
> > #ifdef CONFIG_PROC_FS
> >
> > struct default_vl_write_state {
> >@@ -898,9 +918,6 @@ static int __init fpsimd_init(void)
> > 	if (!(elf_hwcap & HWCAP_ASIMD))
> > 		pr_notice("Advanced SIMD is not implemented\n");
> >
> >-	if (!(elf_hwcap & HWCAP_SVE))
> >-		pr_info("Scalable Vector Extension available\n");
> >-
> > 	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE))
> 
> nit: You may use system_supports_sve() here, instead of the elf_hwcap check. Since this
> is not a performance critical path it doesn't really matter, how we check it.

Hmmm, this looks like a rebase weirdness that I missed.

Patch 39 migrates all instances of this check (including this one) over
to system_supports_sve().

Use of system_supports_sve() in patch 38 is a result of later cleanups
that were reordered during squashing.  I might merge the patches
together for the next round.

Otherwise, I'll clean patch 38 up to fix the inconsistency.


Thanks for the review.

Cheers
---Dave
