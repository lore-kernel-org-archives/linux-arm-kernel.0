From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Aug 2015 15:08:30 +0100
Subject: [PATCH 11/13] arm64: Panic when VHE and non VHE CPUs coexist
In-Reply-To: <1436372356-30410-12-git-send-email-marc.zyngier@arm.com>
References: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
 <1436372356-30410-12-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150806140829.GC17691@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 05:19:14PM +0100, Marc Zyngier wrote:
> Having both VHE and non-VHE capable CPUs in the same system
> is likely to be a recipe for disaster.
> 
> If the boot CPU has VHE, but a secondary is not, we won't be
> able to downgrade and run the kernel at EL1. Add CPU hotplug
> to the mix, and this produces a terrifying mess.
> 
> Let's solve the problem once and for all. If you mix VHE and
> non-VHE CPUs in the same system, you deserve to loose, and this
> patch makes sure you don't get a chance.
> 
> This is implemented by storing the kernel execution level in
> a global variable. Secondaries will park themselves in a
> WFI loop if they observe a mismatch. Also, the primary CPU
> will detect that the secondary CPU has died on a mismatched
> execution level. Panic will follow.

We don't have such system yet but we could try it on the model. Do you
know how far the secondary CPU goes? If it gets to the cpuid sanity
checking, we could do the check together with the rest of the features
(we could add a new CHECK_FATAL macro to make this even more obvious):

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 8e797b2fcc01..36cc81c9b9df 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -29,6 +29,7 @@ struct cpuinfo_arm64 {
 	u32		reg_cntfrq;
 	u32		reg_dczid;
 	u32		reg_midr;
+	u32		reg_currentel;
 
 	u64		reg_id_aa64dfr0;
 	u64		reg_id_aa64dfr1;
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index ee6403df9fe4..de3e8903b5a8 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -118,6 +118,14 @@ static inline bool id_aa64mmfr0_mixed_endian_el0(u64 mmfr0)
 	return (ID_AA64MMFR0_BIGEND(mmfr0) == 0x1) ||
 		(ID_AA64MMFR0_BIGENDEL0(mmfr0) == 0x1);
 }
+
+static inline unsigned int read_currentel(void)
+{
+	u64 el;
+	asm("mrs	%0, CurrentEL" : "=r" (el));
+	return el;
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 75d5a867e7fb..c0269210fd54 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -132,6 +132,9 @@ static void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur)
 	/* If different, timekeeping will be broken (especially with KVM) */
 	diff |= CHECK(cntfrq, boot, cur, cpu);
 
+	/* Same EL for all CPUs */
+	diff |= CHECK(currentel, boot, cur, cpu);
+
 	/*
 	 * The kernel uses self-hosted debug features and expects CPUs to
 	 * support identical debug features. We presently need CTX_CMPs, WRPs,
@@ -205,6 +208,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_ctr = read_cpuid_cachetype();
 	info->reg_dczid = read_cpuid(DCZID_EL0);
 	info->reg_midr = read_cpuid_id();
+	info->reg_currentel = read_currentel();
 
 	info->reg_id_aa64dfr0 = read_cpuid(ID_AA64DFR0_EL1);
 	info->reg_id_aa64dfr1 = read_cpuid(ID_AA64DFR1_EL1);
