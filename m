From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Jun 2013 14:36:27 +0200
Subject: [PATCH v3 0/3] Separate generic header usage from
 ARCH_MULTIPLATFORM
In-Reply-To: <1370602111-28737-1-git-send-email-jonathan.austin@arm.com>
References: <1370602111-28737-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <3002059.2ORUa6RLPf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013 11:48:28 Jonathan Austin wrote:
> The original aim of this series was to restore the ability to build a NOMMU
> kernel for Versatile Express, something that was lost when we converted
> ARCH_VEXPRESS for ARCH_MULTIPLATFORM.
> 
> In order to do this, it is necessary to abstract the use of generic headers
> from selection of ARCH_MULTIPLATFORM so that the two can be used separately.
> This is necessary becuase building a multiplatform kernel for processors
> without and MMU doesn't make sense (it is necessary to hardcode certain mem-map
> related data) and the versatile express can host NOMMU processors.
> 
> This series performs this separation, and then goes on to add a 'dummy'
> ARCH_VEXPRESS_NOMMU platform that can be selected as standalone platform.
> 
> Patch 2 was sent to the list as an RFC some time ago where it was ACKd, but
> alone is not sufficient to solve the problem, hence this follow-up series.

I'd like to revisit whether we can't just make !CONFIG_MMU work in combination
with CONFIG_ARCH_MULTIPLATFORM. I've spent some time recently on randconfig
builds and used the patch below to actually fix all build-time bugs I see
with that. The changes need to be split up into separate patches and reviewed
one by one, but I think the only one you really need is to not select
ARM_PATCH_PHYS_VIRT when building a NOMMU kernel.

	Arnd

commit b62a2b6e472bfb3c7b224b300f25365112be1ea9
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Mon Jun 3 11:06:23 2013 +0200

    ARM: make "randconfig" work with NOMMU
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bbe5b2a..25763ce 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -19,7 +19,7 @@ config ARM
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select HARDIRQS_SW_RESEND
-	select HAVE_AOUT
+	select HAVE_AOUT if MMU
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER
@@ -285,13 +285,11 @@ config MMU
 #
 choice
 	prompt "ARM system type"
-	default ARCH_VERSATILE if !MMU
-	default ARCH_MULTIPLATFORM if MMU
+	default ARCH_MULTIPLATFORM
 
 config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
-	depends on MMU
-	select ARM_PATCH_PHYS_VIRT
+	select ARM_PATCH_PHYS_VIRT if MMU
 	select AUTO_ZRELADDR
 	select COMMON_CLK
 	select MULTI_IRQ_HANDLER
@@ -1812,6 +1810,7 @@ config XEN
 	depends on ARM && AEABI && OF
 	depends on CPU_V7 && !CPU_V6
 	depends on !GENERIC_ATOMIC64
+	depends on MMU
 	select ARM_PSCI
 	select PARAVIRT
 	help
diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index bff7138..ba960e5 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -248,7 +248,7 @@ vivt_flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
 	}
 }
 
-#ifndef CONFIG_CPU_CACHE_VIPT
+#if !defined(CONFIG_CPU_CACHE_VIPT) || !defined(CONFIG_MMU)
 #define flush_cache_mm(mm) \
 		vivt_flush_cache_mm(mm)
 #define flush_cache_range(vma,start,end) \
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 56752a6..b6821ab 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -166,7 +166,11 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 /* PCI fixed i/o mapping */
 #define PCI_IO_VIRT_BASE	0xfee00000
 
+#ifdef CONFIG_MMU
 extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);
+#else
+static inline int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr) { return 0; }
+#endif
 
 /*
  * Now, pick up the machine-defined IO definitions
diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 2fe141f..d380191 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -55,8 +55,9 @@ extern const struct mem_type *get_mem_type(unsigned int type);
 extern int ioremap_page(unsigned long virt, unsigned long phys,
 			const struct mem_type *mtype);
 #else
-#define iotable_init(map,num)	do { } while (0)
+#define iotable_init(map,num)	do { (void)(map); } while (0)
 #define vm_reserve_area_early(a,s,c)	do { } while (0)
+static inline void debug_ll_io_init(void) {}
 #endif
 
 #endif
diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index a0a0efe..748c269 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -35,7 +35,7 @@
 
 #else /* !CONFIG_MMU */
 		.macro	addruart_current, rx, tmp1, tmp2
-		addruart	\rx, \tmp1
+		addruart	\rx, \tmp1, \tmp2
 		.endm
 
 #endif /* CONFIG_MMU */
diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 5b391a6..b5f304e 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -175,6 +175,8 @@ __lookup_processor_type_data:
 	.long	__proc_info_end
 	.size	__lookup_processor_type_data, . - __lookup_processor_type_data
 
+	__HEAD
+
 __error_p:
 #ifdef CONFIG_DEBUG_LL
 	adr	r0, str_p1
diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index c59c97e..ebfcb44 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -22,7 +22,9 @@ void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr)
 	*save_ptr = virt_to_phys(ptr);
 
 	/* This must correspond to the LDM in cpu_resume() assembly */
+#ifdef CONFIG_MMU
 	*ptr++ = virt_to_phys(idmap_pgd);
+#endif
 	*ptr++ = sp;
 	*ptr++ = virt_to_phys(cpu_do_resume);
 
@@ -53,11 +55,11 @@ void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr)
  */
 int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 {
-	struct mm_struct *mm = current->active_mm;
 	int ret;
-
+#ifdef CONFIG_MMU
 	if (!idmap_pgd)
 		return -EINVAL;
+#endif
 
 	/*
 	 * Provide a temporary page table with an identity mapping for
@@ -66,11 +68,14 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	 * back to the correct page tables.
 	 */
 	ret = __cpu_suspend(arg, fn);
+#ifdef CONFIG_MMU
 	if (ret == 0) {
+		struct mm_struct *mm = current->active_mm;
 		cpu_switch_mm(mm->pgd, mm);
 		local_flush_bp_all();
 		local_flush_tlb_all();
 	}
+#endif
 
 	return ret;
 }
diff --git a/arch/arm/mach-at91/Kconfig.non_dt b/arch/arm/mach-at91/Kconfig.non_dt
index 6cd554a..ab8d2ce 100644
--- a/arch/arm/mach-at91/Kconfig.non_dt
+++ b/arch/arm/mach-at91/Kconfig.non_dt
@@ -36,6 +36,7 @@ config ARCH_AT91SAM9G45
 config ARCH_AT91X40
 	bool "AT91x40"
 	depends on !MMU
+	select CPU_ARM9TDMI
 	select ARCH_USES_GETTIMEOFFSET
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index a7d1910..fbfb1eb 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,7 +1,7 @@
 config ARCH_MXC
 	bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
 	select ARCH_REQUIRE_GPIOLIB
-	select ARM_PATCH_PHYS_VIRT
+	select ARM_PATCH_PHYS_VIRT if MMU
 	select AUTO_ZRELADDR if !ZBOOT_ROM
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index 82e79c6..3b98409e6 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -110,7 +110,9 @@ static int mx5_suspend_enter(suspend_state_t state)
 	}
 
 	if (state == PM_SUSPEND_MEM) {
+#ifdef CONFIG_MMU
 		local_flush_tlb_all();
+#endif
 		flush_cache_all();
 
 		/*clear the EMPGC0/1 bits */
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 18cc48b..d29727b 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -100,7 +100,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	bool "Typical OMAP configuration"
 	default y
 	select AEABI
-	select HIGHMEM
+	select HIGHMEM if MMU
 	select I2C
 	select I2C_OMAP
 	select MENELAUS if ARCH_OMAP2
diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index b970440..98624fe 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -60,8 +60,8 @@ int __init omap_secure_ram_reserve_memblock(void)
 {
 	u32 size = OMAP_SECURE_RAM_STORAGE;
 
-	size = ALIGN(size, SECTION_SIZE);
-	omap_secure_memblock_base = arm_memblock_steal(size, SECTION_SIZE);
+	size = ALIGN(size, SZ_1M);
+	omap_secure_memblock_base = arm_memblock_steal(size, SZ_1M);
 
 	return 0;
 }
diff --git a/arch/arm/mach-picoxcell/Kconfig b/arch/arm/mach-picoxcell/Kconfig
index 13bae78..dc98377 100644
--- a/arch/arm/mach-picoxcell/Kconfig
+++ b/arch/arm/mach-picoxcell/Kconfig
@@ -1,7 +1,7 @@
 config ARCH_PICOXCELL
 	bool "Picochip PicoXcell" if ARCH_MULTI_V6
 	select ARCH_REQUIRE_GPIOLIB
-	select ARM_PATCH_PHYS_VIRT
+	select ARM_PATCH_PHYS_VIRT if MMU
 	select ARM_VIC
 	select CPU_V6K
 	select DW_APB_TIMER
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9e8101e..3397d05 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -6,7 +6,7 @@ comment "Processor Type"
 
 # ARM7TDMI
 config CPU_ARM7TDMI
-	bool "Support ARM7TDMI processor"
+	bool
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
@@ -56,7 +56,7 @@ config CPU_ARM740T
 
 # ARM9TDMI
 config CPU_ARM9TDMI
-	bool "Support ARM9TDMI processor"
+	bool
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_NOMMU
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index a5bc92d..ad4d277 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -81,7 +81,11 @@ void __init omap_map_sram(unsigned long start, unsigned long size,
 	start = ROUND_DOWN(start, PAGE_SIZE);
 	omap_sram_size = size;
 	omap_sram_skip = skip;
+#ifdef CONFIG_MMU
 	omap_sram_base = __arm_ioremap_exec(start, size, cached);
+#else
+	omap_sram_base = (void __iomem *)start;
+#endif
 	if (!omap_sram_base) {
 		pr_err("SRAM: Could not map\n");
 		return;
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c332fb9..adaf609 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -130,7 +130,7 @@ config IRQ_REMAP
 # OMAP IOMMU support
 config OMAP_IOMMU
 	bool "OMAP IOMMU Support"
-	depends on ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS && MMU
 	select IOMMU_API
 
 config OMAP_IOVMM
diff --git a/drivers/staging/android/Kconfig b/drivers/staging/android/Kconfig
index c0c95be..85fc94b 100644
--- a/drivers/staging/android/Kconfig
+++ b/drivers/staging/android/Kconfig
@@ -10,6 +10,7 @@ if ANDROID
 
 config ANDROID_BINDER_IPC
 	bool "Android Binder IPC Driver"
+	depends on MMU
 	default n
 	---help---
 	  Binder is used in Android for both communication between processes,
diff --git a/drivers/staging/zsmalloc/Kconfig b/drivers/staging/zsmalloc/Kconfig
index 7fab032..0ae13cd 100644
--- a/drivers/staging/zsmalloc/Kconfig
+++ b/drivers/staging/zsmalloc/Kconfig
@@ -1,5 +1,6 @@
 config ZSMALLOC
 	bool "Memory allocator for compressed pages"
+	depends on MMU
 	default n
 	help
 	  zsmalloc is a slab-based memory allocator designed to store
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index cf23b15..9cc4d43 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -193,13 +193,17 @@ extern int _cond_resched(void);
 		(__x < 0) ? -__x : __x;		\
 	})
 
-#ifdef CONFIG_PROVE_LOCKING
-void might_fault(void);
-#else
+#ifndef CONFIG_MMU
+static inline void might_fault(void)
+{
+}
+#elif !defined(CONFIG_PROVE_LOCKING)
 static inline void might_fault(void)
 {
 	might_sleep();
 }
+#else
+void might_fault(void);
 #endif
 
 extern struct atomic_notifier_head panic_notifier_list;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b87681a..5511a1c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -919,7 +919,11 @@ extern bool skip_free_areas_node(unsigned int flags, int nid);
 
 int shmem_zero_setup(struct vm_area_struct *);
 
+#ifdef CONFIG_MMU
 extern int can_do_mlock(void);
+#else
+static inline int can_do_mlock(void) { return 0; }
+#endif
 extern int user_shm_lock(size_t, struct user_struct *);
 extern void user_shm_unlock(size_t, struct user_struct *);
 
diff --git a/mm/nommu.c b/mm/nommu.c
index ecd1f15..a7709f1 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -54,6 +54,7 @@
 #endif
 
 void *high_memory;
+EXPORT_SYMBOL(high_memory);
 struct page *mem_map;
 unsigned long max_mapnr;
 unsigned long highest_memmap_pfn;
