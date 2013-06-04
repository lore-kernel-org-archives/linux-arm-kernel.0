From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue,  4 Jun 2013 10:34:12 +0100
Subject: [RFC PATCH 1/2] ARM: kernel: build MPIDR hash function data structure
In-Reply-To: <1370338453-8749-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1370338453-8749-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1370338453-8749-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM SMP systems, cores are identified by their MPIDR register.
The MPIDR guidelines in the ARM ARM do not provide strict enforcement of
MPIDR layout, only recommendations that, if followed, split the MPIDR
on ARM 32 bit platforms in three affinity levels. In multi-cluster
systems like big.LITTLE, if the affinity guidelines are followed, the
MPIDR can not be considered an index anymore. This means that the
association between logical CPU in the kernel and the HW CPU identifier
becomes somewhat more complicated requiring methods like hashing to
associate a given MPIDR to a CPU logical index, in order for the look-up
to be carried out in an efficient and scalable way.

This patch provides a function in the kernel that starting from the
cpu_logical_map, implement collision-free hashing of MPIDR values by checking
all significative bits of MPIDR affinity level bitfields. The hashing
can then be carried out through bits shifting and ORing; the resulting
hash algorithm is a collision-free though not minimal hash that can be
executed with few assembly instructions. The mpidr is filtered through a
mpidr mask that is built by checking all bits that toggle in the set of
MPIDRs corresponding to possible CPUs. Bits that do not toggle do not carry
information so they do not contribute to the resulting hash.

Pseudo code:

/* check all bits that toggle, so they are required */
for (i = 1, mpidr_mask = 0; i < num_possible_cpus(); i++)
	mpidr_mask |= (cpu_logical_map(i) ^ cpu_logical_map(0));

/*
 * Build shifts to be applied to aff0, aff1, aff2 values to hash the mpidr
 * fls() returns the last bit set in a word, 0 if none
 * ffs() returns the first bit set in a word, 0 if none
 */
fs0 = mpidr_mask[7:0] ? ffs(mpidr_mask[7:0]) - 1 : 0;
fs1 = mpidr_mask[15:8] ? ffs(mpidr_mask[15:8]) - 1 : 0;
fs2 = mpidr_mask[23:16] ? ffs(mpidr_mask[23:16]) - 1 : 0;
ls0 = fls(mpidr_mask[7:0]);
ls1 = fls(mpidr_mask[15:8]);
ls2 = fls(mpidr_mask[23:16]);
bits0 = ls0 - fs0;
bits1 = ls1 - fs1;
bits2 = ls2 - fs2;
aff0_shift = fs0;
aff1_shift = 8 + fs1 - bits0;
aff2_shift = 16 + fs2 - (bits0 + bits1);
u32 hash(u32 mpidr) {
	u32 l0, l1, l2;
	u32 mpidr_masked = mpidr & mpidr_mask;
	l0 = mpidr_masked & 0xff;
	l1 = mpidr_masked & 0xff00;
	l2 = mpidr_masked & 0xff0000;
	return (l0 >> aff0_shift | l1 >> aff1_shift | l2 >> aff2_shift);
}

The hashing algorithm relies on the inherent properties set in the ARM ARM
recommendations for the MPIDR. Exotic configurations, where for instance the
MPIDR values at a given affinity level have large holes, can end up requiring
big hash tables since the compression of values that can be achieved through
shifting is somewhat crippled when holes are present. Kernel warns if
the number of buckets of the resulting hash table exceeds the number of
possible CPUs by a factor of 4, which is a symptom of a very sparse HW
MPIDR configuration.

The hash algorithm is quite simple and can easily be implemented in assembly
code, to be used in code paths where the kernel virtual address space is
not set-up (ie cpu_resume) and instruction and data fetches are strongly
ordered so code must be compact and must carry out few data accesses.

Cc: Dave Martin <dave.martin@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Colin Cross <ccross@android.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/include/asm/smp_plat.h | 12 ++++++++
 arch/arm/kernel/setup.c         | 67 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index aaa61b6..d933b03 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -66,4 +66,16 @@ static inline int get_logical_index(u32 mpidr)
 	return -EINVAL;
 }
 
+struct mpidr_hash {
+	u32	mask;
+	u32	shift_aff[3];
+	u32	bits;
+};
+
+extern struct mpidr_hash mpidr_hash;
+
+static inline u32 mpidr_hash_size(void)
+{
+	return 1 << mpidr_hash.bits;
+}
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 6f5bdd6..74dce64 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -473,6 +473,72 @@ void __init smp_setup_processor_id(void)
 	printk(KERN_INFO "Booting Linux on physical CPU 0x%x\n", mpidr);
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
+	u32 i, affinity;
+	u32 fs[3], bits[3], ls, mask = 0;
+	/*
+	 * Pre-scan the list of MPIDRS and filter out bits that do
+	 * not contribute to affinity levels, ie they never toggle.
+	 */
+	for_each_possible_cpu(i)
+		mask |= (cpu_logical_map(i) ^ cpu_logical_map(0));
+	pr_debug("mask of set bits 0x%x\n", mask);
+	/*
+	 * Find and stash the last and first bit set at all affinity levels to
+	 * check how many bits are required to represent them.
+	 */
+	for (i = 0; i < 3; i++) {
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
+	 * An index can be created from the MPIDR by isolating the
+	 * significant bits@each affinity level and by shifting
+	 * them in order to compress the 24 bits values space to a
+	 * compressed set of values. This is equivalent to hashing
+	 * the MPIDR through shifting and ORing. It is a collision free
+	 * hash though not minimal since some levels might contain a number
+	 * of CPUs that is not an exact power of 2 and their bit
+	 * representation might contain holes, eg MPIDR[7:0] = {0x2, 0x80}.
+	 */
+	mpidr_hash.shift_aff[0] = fs[0];
+	mpidr_hash.shift_aff[1] = MPIDR_LEVEL_BITS + fs[1] - bits[0];
+	mpidr_hash.shift_aff[2] = 2*MPIDR_LEVEL_BITS + fs[2] -
+						(bits[1] + bits[0]);
+	mpidr_hash.mask = mask;
+	mpidr_hash.bits = bits[2] + bits[1] + bits[0];
+	pr_debug("MPIDR hash: aff0[%u] aff1[%u] aff2[%u] mask[0x%x] bits[%u]\n",
+				mpidr_hash.shift_aff[0],
+				mpidr_hash.shift_aff[1],
+				mpidr_hash.shift_aff[2],
+				mpidr_hash.mask,
+				mpidr_hash.bits);
+	/*
+	 * 4x is an arbitrary value used to warn on a hash table much bigger
+	 * than expected on most systems.
+	 */
+	if (mpidr_hash_size() > 4 * num_possible_cpus())
+		pr_warn("Large number of MPIDR hash buckets detected\n");
+	sync_cache_w(&mpidr_hash);
+}
+#endif
+
 static void __init setup_processor(void)
 {
 	struct proc_info_list *list;
@@ -820,6 +886,7 @@ void __init setup_arch(char **cmdline_p)
 				smp_set_ops(mdesc->smp);
 		}
 		smp_init_cpus();
+		smp_build_mpidr_hash();
 	}
 #endif
 
-- 
1.8.2.2
