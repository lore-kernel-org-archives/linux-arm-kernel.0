From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 20 Nov 2015 17:59:10 +0800
Subject: [RFC PATCH] arm64: add __init/__initdata section marker to some
 functions/variables
Message-ID: <1448013550-7622-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These functions/variables are not needed after booting, so mark them
as __init or __initdata.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---

 But I didn't see too much improvements after this patch, I think that
 may be due to the compiler can inline automatically. I'm not sure
 whether we need to do this, that's why the patch is marked as RFC

 arch/arm64/kernel/armv8_deprecated.c | 6 +++---
 arch/arm64/kernel/cpufeature.c       | 9 +++++----
 arch/arm64/kernel/fpsimd.c           | 2 +-
 arch/arm64/mm/dma-mapping.c          | 4 ++--
 arch/arm64/mm/init.c                 | 6 +++---
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 937f5e5..3e01207 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -62,7 +62,7 @@ struct insn_emulation {
 };
 
 static LIST_HEAD(insn_emulation);
-static int nr_insn_emulated;
+static int nr_insn_emulated __initdata;
 static DEFINE_RAW_SPINLOCK(insn_emulation_lock);
 
 static void register_emulation_hooks(struct insn_emulation_ops *ops)
@@ -173,7 +173,7 @@ static int update_insn_emulation_mode(struct insn_emulation *insn,
 	return ret;
 }
 
-static void register_insn_emulation(struct insn_emulation_ops *ops)
+static void __init register_insn_emulation(struct insn_emulation_ops *ops)
 {
 	unsigned long flags;
 	struct insn_emulation *insn;
@@ -237,7 +237,7 @@ static struct ctl_table ctl_abi[] = {
 	{ }
 };
 
-static void register_insn_emulation_sysctl(struct ctl_table *table)
+static void __init register_insn_emulation_sysctl(struct ctl_table *table)
 {
 	unsigned long flags;
 	int i = 0;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c8cf892..d0fd872 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -675,7 +675,7 @@ static const struct arm64_cpu_capabilities arm64_hwcaps[] = {
 	{},
 };
 
-static void cap_set_hwcap(const struct arm64_cpu_capabilities *cap)
+static void __init cap_set_hwcap(const struct arm64_cpu_capabilities *cap)
 {
 	switch (cap->hwcap_type) {
 	case CAP_HWCAP:
@@ -720,7 +720,7 @@ static bool __maybe_unused cpus_have_hwcap(const struct arm64_cpu_capabilities *
 	return rc;
 }
 
-static void setup_cpu_hwcaps(void)
+static void __init setup_cpu_hwcaps(void)
 {
 	int i;
 	const struct arm64_cpu_capabilities *hwcaps = arm64_hwcaps;
@@ -749,7 +749,8 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
  * Run through the enabled capabilities and enable() it on all active
  * CPUs
  */
-static void enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
+static void __init
+enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 {
 	int i;
 
@@ -888,7 +889,7 @@ static inline void set_sys_caps_initialised(void)
 
 #endif	/* CONFIG_HOTPLUG_CPU */
 
-static void setup_feature_capabilities(void)
+static void __init setup_feature_capabilities(void)
 {
 	update_cpu_capabilities(arm64_features, "detected feature:");
 	enable_cpu_capabilities(arm64_features);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 4c46c54..acc1afd 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -289,7 +289,7 @@ static struct notifier_block fpsimd_cpu_pm_notifier_block = {
 	.notifier_call = fpsimd_cpu_pm_notifier,
 };
 
-static void fpsimd_pm_init(void)
+static void __init fpsimd_pm_init(void)
 {
 	cpu_pm_register_notifier(&fpsimd_cpu_pm_notifier_block);
 }
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 131a199..f654e23 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -42,7 +42,7 @@ static pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
 static struct gen_pool *atomic_pool;
 
 #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
-static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;
+static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
 
 static int __init early_coherent_pool(char *p)
 {
@@ -897,7 +897,7 @@ static int __iommu_attach_notifier(struct notifier_block *nb,
 	return 0;
 }
 
-static int register_iommu_dma_ops_notifier(struct bus_type *bus)
+static int __init register_iommu_dma_ops_notifier(struct bus_type *bus)
 {
 	struct notifier_block *nb = kzalloc(sizeof(*nb), GFP_KERNEL);
 	int ret;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 17bf39a..9b8cc67 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -71,7 +71,7 @@ early_param("initrd", early_initrd);
  * currently assumes that for memory starting above 4G, 32-bit devices will
  * use a DMA offset.
  */
-static phys_addr_t max_zone_dma_phys(void)
+static phys_addr_t __init max_zone_dma_phys(void)
 {
 	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, 32);
 	return min(offset + (1ULL << 32), memblock_end_of_DRAM());
@@ -126,11 +126,11 @@ EXPORT_SYMBOL(pfn_valid);
 #endif
 
 #ifndef CONFIG_SPARSEMEM
-static void arm64_memory_present(void)
+static void __init arm64_memory_present(void)
 {
 }
 #else
-static void arm64_memory_present(void)
+static void __init arm64_memory_present(void)
 {
 	struct memblock_region *reg;
 
-- 
2.6.2
