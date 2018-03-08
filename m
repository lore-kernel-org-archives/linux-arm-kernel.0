From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 8 Mar 2018 13:43:50 +0000
Subject: [PATCH v3 15/22] arm64: capabilities: Change scope of VHE to
 Boot CPU feature
In-Reply-To: <25d774db-0ebd-b06d-20b5-5e31ede58fa3@arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-30-suzuki.poulose@arm.com>
 <20180212171727.GL5862@e103592.cambridge.arm.com>
 <25d774db-0ebd-b06d-20b5-5e31ede58fa3@arm.com>
Message-ID: <20180308134348.GP32331@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 12:10:22PM +0000, Suzuki K Poulose wrote:
> On 12/02/18 17:17, Dave Martin wrote:
> >On Fri, Feb 09, 2018 at 05:54:59PM +0000, Suzuki K Poulose wrote:
> >>We expect all CPUs to be running at the same EL inside the kernel
> >>with or without VHE enabled and we have strict checks to ensure
> >>that any mismatch triggers a kernel panic. If VHE is enabled,
> >>we use the feature based on the boot CPU and all other CPUs
> >>should follow. This makes it a perfect candidate for a cpability
> >
> >capability
> >
> >>based on the boot CPU,  which should be matched by all the CPUs
> >>(both when is ON and OFF). This saves us some not-so-pretty
> >>hooks and special code, just for verifying the conflict.
> >>
> >>Cc: Marc Zyngier <marc.zyngier@arm.com>
> >>Cc: Dave Martin <dave.martin@arm.com>
> >>Cc: Will Deacon <will.deacon@arm.com>
> >>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>---
> >>  arch/arm64/include/asm/cpufeature.h |  7 +++++++
> >>  arch/arm64/include/asm/virt.h       |  6 ------
> >>  arch/arm64/kernel/cpufeature.c      |  5 +++--
> >>  arch/arm64/kernel/smp.c             | 38 -------------------------------------
> >>  4 files changed, 10 insertions(+), 46 deletions(-)
> >>
> >>diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> >>index 5f56a8342065..dfce93f79ae7 100644
> >>--- a/arch/arm64/include/asm/cpufeature.h
> >>+++ b/arch/arm64/include/asm/cpufeature.h
> >>@@ -276,6 +276,13 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
> >>  	(ARM64_CPUCAP_SCOPE_LOCAL_CPU		|	\
> >>  	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU)
> >>+/*
> >>+ * Critical CPU feature used early in the boot based on the boot CPU.
> >>+ * The feature should be matched by all booting CPU (both miss and hit
> >>+ * cases).
> >>+ */
> >>+#define ARM64_CPUCAP_CRITICAL_BOOT_CPU_FEATURE ARM64_CPUCAP_SCOPE_BOOT_CPU
> >>+
> >
> >Nit: would it be consistent with the uses we already have for the word
> >"strict" to use that word here?  i.e.,
> >ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE.
> >Or do you think that would be more confusing?
> 
> We don't use the "STRICT" tag anymore. Moreover, I used CRITICAL to indicate
> that it is special in a way that all the "late" CPUs (in this case all
> secondaries) should match the "state" of the capability  (i.e, both ON and OFF)
> as that of the boot CPU. I am OK to change it to STRICT.

OK, I think so long as the definition is clear the precise name doesn't
matter too much.

I suggest deleting "critical" from the comment though, since that
suggests a circular definition.  The meaning seems clear(er) without
it.

[...]

Cheers
---Dave
