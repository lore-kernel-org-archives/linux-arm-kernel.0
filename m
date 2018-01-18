From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 18 Jan 2018 14:45:22 +0000
Subject: [RFC PATCH v2 1/3] arm64/kernel: kaslr: reduce module randomization
 range to 4 GB
In-Reply-To: <20180118144524.18704-1-ard.biesheuvel@linaro.org>
References: <20180118144524.18704-1-ard.biesheuvel@linaro.org>
Message-ID: <20180118144524.18704-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently have to rely on the GCC large code model for KASLR for
two distinct but related reasons:
- if we enable full randomization, modules will be loaded very far away
  from the core kernel, where they are out of range for ADRP instructions,
- even without full randomization, the fact that the 128 MB module region
  is now no longer fully reserved for kernel modules means that there is
  a very low likelihood that the normal bottom-up allocation of other
  vmalloc regions may collide, and use up the range for other things.

Large model code is suboptimal, given that each symbol reference involves
a literal load that goes through the D-cache, reducing cache utilization.
But more importantly, literals are not instructions but part of .text
nonetheless, and hence mapped with executable permissions.

So let's get rid of our dependency on the large model for KASLR, by:
- reducing the full randomization range to 4 GB, thereby ensuring that
  ADRP references between modules and the kernel are always in range,
- reduce the spillover range to 4 GB as well, so that we fallback to a
  region that is still guaranteed to be in range
- move the randomization window of the core kernel to the middle of the
  VMALLOC space

Note that KASAN always uses the module region outside of the vmalloc space,
so keep the kernel close to that if KASAN is enabled.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig         |  6 +++---
 arch/arm64/kernel/kaslr.c  | 20 ++++++++++++--------
 arch/arm64/kernel/module.c | 10 +++++++---
 include/linux/sizes.h      |  2 ++
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b488076d63c2..1cb3441558fa 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1140,12 +1140,12 @@ config RANDOMIZE_BASE
 	  If unsure, say N.
 
 config RANDOMIZE_MODULE_REGION_FULL
-	bool "Randomize the module region independently from the core kernel"
+	bool "Randomize the module region over a 4 GB range"
 	depends on RANDOMIZE_BASE
 	default y
 	help
-	  Randomizes the location of the module region without considering the
-	  location of the core kernel. This way, it is impossible for modules
+	  Randomizes the location of the module region inside a 4 GB window
+	  covering the core kernel. This way, it is less likely for modules
 	  to leak information about the location of core kernel data structures
 	  but it does imply that function calls between modules and the core
 	  kernel will need to be resolved via veneers in the module PLT.
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 47080c49cc7e..9e68a37429b9 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -117,13 +117,15 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	/*
 	 * OK, so we are proceeding with KASLR enabled. Calculate a suitable
 	 * kernel image offset from the seed. Let's place the kernel in the
-	 * lower half of the VMALLOC area (VA_BITS - 2).
+	 * middle half of the VMALLOC area (VA_BITS - 2), and stay clear of
+	 * the lower and upper quarters to avoid colliding with other
+	 * allocations.
 	 * Even if we could randomize at page granularity for 16k and 64k pages,
 	 * let's always round to 2 MB so we don't interfere with the ability to
 	 * map using contiguous PTEs
 	 */
 	mask = ((1UL << (VA_BITS - 2)) - 1) & ~(SZ_2M - 1);
-	offset = seed & mask;
+	offset = BIT(VA_BITS - 3) + (seed & mask);
 
 	/* use the top 16 bits to randomize the linear region */
 	memstart_offset_seed = seed >> 48;
@@ -149,21 +151,23 @@ u64 __init kaslr_early_init(u64 dt_phys)
 		 * vmalloc region, since shadow memory is allocated for each
 		 * module at load time, whereas the vmalloc region is shadowed
 		 * by KASAN zero pages. So keep modules out of the vmalloc
-		 * region if KASAN is enabled.
+		 * region if KASAN is enabled, and put the kernel within 4 GB
+		 * of the module region.
 		 */
-		return offset;
+		return offset % SZ_2G;
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_MODULE_REGION_FULL)) {
 		/*
-		 * Randomize the module region independently from the core
-		 * kernel. This prevents modules from leaking any information
+		 * Randomize the module region over a 4 GB window covering the
+		 * kernel. This reduces the risk of modules leaking information
 		 * about the address of the kernel itself, but results in
 		 * branches between modules and the core kernel that are
 		 * resolved via PLTs. (Branches between modules will be
 		 * resolved normally.)
 		 */
-		module_range = VMALLOC_END - VMALLOC_START - MODULES_VSIZE;
-		module_alloc_base = VMALLOC_START;
+		module_range = SZ_4G - (u64)(_end - _stext);
+		module_alloc_base = max((u64)_end + offset - SZ_4G,
+					(u64)MODULES_VADDR);
 	} else {
 		/*
 		 * Randomize the module region by setting module_alloc_base to
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index f469e0435903..c28a04256e1f 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -45,7 +45,10 @@ void *module_alloc(unsigned long size)
 				NUMA_NO_NODE, __builtin_return_address(0));
 
 	if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
-	    !IS_ENABLED(CONFIG_KASAN))
+	    !IS_ENABLED(CONFIG_KASAN)) {
+		u64 start = max(_end - SZ_4G, MODULES_VADDR);
+		u64 end = start + SZ_4G;
+
 		/*
 		 * KASAN can only deal with module allocations being served
 		 * from the reserved module region, since the remainder of
@@ -55,9 +58,10 @@ void *module_alloc(unsigned long size)
 		 * less likely that the module region gets exhausted, so we
 		 * can simply omit this fallback in that case.
 		 */
-		p = __vmalloc_node_range(size, MODULE_ALIGN, VMALLOC_START,
-				VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_EXEC, 0,
+		p = __vmalloc_node_range(size, MODULE_ALIGN, start,
+				end, GFP_KERNEL, PAGE_KERNEL_EXEC, 0,
 				NUMA_NO_NODE, __builtin_return_address(0));
+	}
 
 	if (p && (kasan_module_alloc(p, size) < 0)) {
 		vfree(p);
diff --git a/include/linux/sizes.h b/include/linux/sizes.h
index ce3e8150c174..bc621db852d9 100644
--- a/include/linux/sizes.h
+++ b/include/linux/sizes.h
@@ -44,4 +44,6 @@
 #define SZ_1G				0x40000000
 #define SZ_2G				0x80000000
 
+#define SZ_4G				0x100000000ULL
+
 #endif /* __LINUX_SIZES_H__ */
-- 
2.11.0
