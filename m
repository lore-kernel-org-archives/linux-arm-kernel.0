From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 28 Aug 2013 12:35:54 +0100
Subject: [RFC PATCH 02/14] arm64: kernel: build MPIDR_EL1 hash function data
 structure
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1377689766-17642-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM64 SMP systems, cores are identified by their MPIDR_EL1 register.
The MPIDR_EL1 guidelines in the ARM ARM do not provide strict enforcement of
MPIDR_EL1 layout, only recommendations that, if followed, split the MPIDR_EL1
on ARM 64 bit platforms in four affinity levels. In multi-cluster
systems like big.LITTLE, if the affinity guidelines are followed, the
MPIDR_EL1 can not be considered a linear index. This means that the
association between logical CPU in the kernel and the HW CPU identifier
becomes somewhat more complicated requiring methods like hashing to
associate a given MPIDR_EL1 to a CPU logical index, in order for the look-up
to be carried out in an efficient and scalable way.

This patch provides a function in the kernel that starting from the
cpu_logical_map, implement collision-free hashing of MPIDR_EL1 values by
checking all significative bits of MPIDR_EL1 affinity level bitfields.
The hashing can then be carried out through bits shifting and ORing; the
resulting hash algorithm is a collision-free though not minimal hash that can
be executed with few assembly instructions. The mpidr_el1 is filtered through a
mpidr mask that is built by checking all bits that toggle in the set of
MPIDR_EL1s corresponding to possible CPUs. Bits that do not toggle do not
carry information so they do not contribute to the resulting hash.

Pseudo code:

/* check all bits that toggle, so they are required */
for (i = 1, mpidr_el1_mask = 0; i < num_possible_cpus(); i++)
	mpidr_el1_mask |= (cpu_logical_map(i) ^ cpu_logical_map(0));

/*
 * Build shifts to be applied to aff0, aff1, aff2, aff3 values to hash the
 * mpidr_el1
 * fls() returns the last bit set in a word, 0 if none
 * ffs() returns the first bit set in a word, 0 if none
 */
fs0 = mpidr_el1_mask[7:0] ? ffs(mpidr_el1_mask[7:0]) - 1 : 0;
fs1 = mpidr_el1_mask[15:8] ? ffs(mpidr_el1_mask[15:8]) - 1 : 0;
fs2 = mpidr_el1_mask[23:16] ? ffs(mpidr_el1_mask[23:16]) - 1 : 0;
fs3 = mpidr_el1_mask[39:32] ? ffs(mpidr_el1_mask[39:32]) - 1 : 0;
ls0 = fls(mpidr_el1_mask[7:0]);
ls1 = fls(mpidr_el1_mask[15:8]);
ls2 = fls(mpidr_el1_mask[23:16]);
ls3 = fls(mpidr_el1_mask[39:32]);
bits0 = ls0 - fs0;
bits1 = ls1 - fs1;
bits2 = ls2 - fs2;
bits3 = ls3 - fs3;
aff0_shift = fs0;
aff1_shift = 8 + fs1 - bits0;
aff2_shift = 16 + fs2 - (bits0 + bits1);
aff3_shift = 32 + fs3 - (bits0 + bits1 + bits2);
u32 hash(u64 mpidr_el1) {
	u32 l0, l1, l2;
	u64 mpidr_el1_masked = mpidr_el1 & mpidr_el1_mask;
	l0 = mpidr_el1_masked & 0xff;
	l1 = mpidr_el1_masked & 0xff00;
	l2 = mpidr_el1_masked & 0xff0000;
	l3 = mpidr_el1_masked & 0xff00000000;
	return (l0 >> aff0_shift | l1 >> aff1_shift | l2 >> aff2_shift |
		l3 >> aff3_shift);
}

The hashing algorithm relies on the inherent properties set in the ARM ARM
recommendations for the MPIDR_EL1. Exotic configurations, where for instance
the MPIDR_EL1 values at a given affinity level have large holes, can end up
requiring big hash tables since the compression of values that can be achieved
through shifting is somewhat crippled when holes are present. Kernel warns if
the number of buckets of the resulting hash table exceeds the number of
possible CPUs by a factor of 4, which is a symptom of a very sparse HW
MPIDR_EL1 configuration.

The hash algorithm is quite simple and can easily be implemented in assembly
code, to be used in code paths where the kernel virtual address space is
not set-up (ie cpu_resume) and instruction and data fetches are strongly
ordered so code must be compact and must carry out few data accesses.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/smp_plat.h | 13 ++++++++
 arch/arm64/kernel/asm-offsets.c   |  5 +++
 arch/arm64/kernel/setup.c         | 70 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
index ed43a0d..59e2823 100644
--- a/arch/arm64/include/asm/smp_plat.h
+++ b/arch/arm64/include/asm/smp_plat.h
@@ -21,6 +21,19 @@
 
 #include <asm/types.h>
 
+struct mpidr_hash {
+	u64	mask;
+	u32	shift_aff[4];
+	u32	bits;
+};
+
+extern struct mpidr_hash mpidr_hash;
+
+static inline u32 mpidr_hash_size(void)
+{
+	return 1 << mpidr_hash.bits;
+}
+
 /*
  * Logical CPU mapping.
  */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 666e231..f300a13 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -25,6 +25,7 @@
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/cputable.h>
+#include <asm/smp_plat.h>
 #include <asm/vdso_datapage.h>
 #include <linux/kbuild.h>
 
@@ -138,5 +139,9 @@ int main(void)
   DEFINE(KVM_VTTBR,		offsetof(struct kvm, arch.vttbr));
   DEFINE(KVM_VGIC_VCTRL,	offsetof(struct kvm, arch.vgic.vctrl_base));
 #endif
+#ifdef CONFIG_ARM_CPU_SUSPEND
+  DEFINE(MPIDR_HASH_MASK,	offsetof(struct mpidr_hash, mask));
+  DEFINE(MPIDR_HASH_SHIFTS,	offsetof(struct mpidr_hash, shift_aff));
+#endif
   return 0;
 }
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index add6ea6..3601186 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -97,6 +97,75 @@ void __init early_print(const char *str, ...)
 	printk("%s", buf);
 }
 
+struct mpidr_hash mpidr_hash;
+#ifdef CONFIG_SMP
+/**
+ * smp_build_mpidr_hash - Pre-compute shifts required at each affinity
+ *			  level in order to build a linear index from an
+ *			  MPIDR value. Resulting algorithm is a collision
+ *			  free hash carried out through shifting and ORing
+ */
+static void __init smp_build_mpidr_hash(void)
+{
+	u32 i, affinity, fs[4], bits[4], ls;
+	u64 mask = 0;
+	/*
+	 * Pre-scan the list of MPIDRS and filter out bits that do
+	 * not contribute to affinity levels, ie they never toggle.
+	 */
+	for_each_possible_cpu(i)
+		mask |= (cpu_logical_map(i) ^ cpu_logical_map(0));
+	pr_debug("mask of set bits %#llx\n", mask);
+	/*
+	 * Find and stash the last and first bit set at all affinity levels to
+	 * check how many bits are required to represent them.
+	 */
+	for (i = 0; i < 4; i++) {
+		affinity = MPIDR_AFFINITY_LEVEL(mask, i);
+		/*
+		 * Find the MSB bit and LSB bits position
+		 * to determine how many bits are required
+		 * to express the affinity level.
+		 */
+		ls = fls(affinity);
+		fs[i] = affinity ? ffs(affinity) - 1 : 0;
+		bits[i] = ls - fs[i];
+	}
+	/*
+	 * An index can be created from the MPIDR_EL1 by isolating the
+	 * significant bits@each affinity level and by shifting
+	 * them in order to compress the 32 bits values space to a
+	 * compressed set of values. This is equivalent to hashing
+	 * the MPIDR_EL1 through shifting and ORing. It is a collision free
+	 * hash though not minimal since some levels might contain a number
+	 * of CPUs that is not an exact power of 2 and their bit
+	 * representation might contain holes, eg MPIDR_EL1[7:0] = {0x2, 0x80}.
+	 */
+	mpidr_hash.shift_aff[0] = MPIDR_LEVEL_SHIFT(0) + fs[0];
+	mpidr_hash.shift_aff[1] = MPIDR_LEVEL_SHIFT(1) + fs[1] - bits[0];
+	mpidr_hash.shift_aff[2] = MPIDR_LEVEL_SHIFT(2) + fs[2] -
+						(bits[1] + bits[0]);
+	mpidr_hash.shift_aff[3] = MPIDR_LEVEL_SHIFT(3) +
+				  fs[3] - (bits[2] + bits[1] + bits[0]);
+	mpidr_hash.mask = mask;
+	mpidr_hash.bits = bits[3] + bits[2] + bits[1] + bits[0];
+	pr_debug("MPIDR hash: aff0[%u] aff1[%u] aff2[%u] aff3[%u] mask[%#llx] bits[%u]\n",
+		mpidr_hash.shift_aff[0],
+		mpidr_hash.shift_aff[1],
+		mpidr_hash.shift_aff[2],
+		mpidr_hash.shift_aff[3],
+		mpidr_hash.mask,
+		mpidr_hash.bits);
+	/*
+	 * 4x is an arbitrary value used to warn on a hash table much bigger
+	 * than expected on most systems.
+	 */
+	if (mpidr_hash_size() > 4 * num_possible_cpus())
+		pr_warn("Large number of MPIDR hash buckets detected\n");
+	__flush_dcache_area(&mpidr_hash, sizeof(struct mpidr_hash));
+}
+#endif
+
 static void __init setup_processor(void)
 {
 	struct cpu_info *cpu_info;
@@ -271,6 +340,7 @@ void __init setup_arch(char **cmdline_p)
 	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
 #ifdef CONFIG_SMP
 	smp_init_cpus();
+	smp_build_mpidr_hash();
 #endif
 
 #ifdef CONFIG_VT
-- 
1.8.3.4
