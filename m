From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu,  8 Mar 2018 22:21:00 -0500
Subject: [PATCH 7/7] ARM: simplify and fix linker script for TCM
In-Reply-To: <20180309032100.31039-1-nicolas.pitre@linaro.org>
References: <20180309032100.31039-1-nicolas.pitre@linaro.org>
Message-ID: <20180309032100.31039-8-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's put the TCM stuff in the __init section directly. No need for
a separately freed memory area.

Remove redundant linker sections, as well as comments that were more
confusing than no comments at all. Finally make it XIP compatible by
using LOAD_OFFSET in the section LMA specification.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/vmlinux-xip.lds.S |  8 +++---
 arch/arm/kernel/vmlinux.lds.S     |  8 +++---
 arch/arm/kernel/vmlinux.lds.h     | 52 +++++----------------------------------
 arch/arm/mm/init.c                | 11 ---------
 4 files changed, 14 insertions(+), 65 deletions(-)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index c727c56f3c..d32f5d35f6 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -132,6 +132,10 @@ SECTIONS
 	PERCPU_SECTION(L1_CACHE_BYTES)
 #endif
 
+#ifdef CONFIG_HAVE_TCM
+	ARM_TCM
+#endif
+
 	/*
 	 * End of copied data. We need a dummy section to get its LMA.
 	 * Also located before final ALIGN() as trailing padding is not stored
@@ -143,10 +147,6 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
 
-#ifdef CONFIG_HAVE_TCM
-	ARM_TCM
-#endif
-
 	BSS_SECTION(0, 0, 8)
 	_end = .;
 
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 1e9f2a6b3d..b77dc675ae 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -127,6 +127,10 @@ SECTIONS
 	PERCPU_SECTION(L1_CACHE_BYTES)
 #endif
 
+#ifdef CONFIG_HAVE_TCM
+	ARM_TCM
+#endif
+
 #ifdef CONFIG_STRICT_KERNEL_RWX
 	. = ALIGN(1<<SECTION_SHIFT);
 #else
@@ -138,10 +142,6 @@ SECTIONS
 	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
 	_edata = .;
 
-#ifdef CONFIG_HAVE_TCM
-	ARM_TCM
-#endif
-
 	BSS_SECTION(0, 0, 0)
 	_end = .;
 
diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
index cf9dabbdbd..71281e08e1 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/kernel/vmlinux.lds.h
@@ -115,61 +115,21 @@
 	PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
 
 #define ARM_TCM								\
-        /*								\
-	 * We align everything to a page boundary so we can		\
-	 * free it after init has commenced and TCM contents have	\
-	 * been copied to its destination.				\
-	 */								\
-	.tcm_start : {							\
-		. = ALIGN(PAGE_SIZE);					\
-		__tcm_start = .;					\
-		__itcm_start = .;					\
-	}								\
-									\
-	/*								\
-	 * Link these to the ITCM RAM					\
-	 *								\
-	 * Put VMA to the TCM address and LMA to the common RAM		\
-	 * and we'll upload the contents from RAM to TCM and free	\
-	 * the used RAM after that.					\
-	 */								\
-	.text_itcm ITCM_OFFSET : AT(__itcm_start)			\
-	{								\
+	__itcm_start = ALIGN(4);					\
+	.text_itcm ITCM_OFFSET : AT(__itcm_start - LOAD_OFFSET) {	\
 		__sitcm_text = .;					\
 		*(.tcm.text)						\
 		*(.tcm.rodata)						\
 		. = ALIGN(4);						\
 		__eitcm_text = .;					\
 	}								\
+	. = __itcm_start + SIZEOF(.text_itcm);				\
 									\
-	/*								\
-	 * Reset the dot pointer, this is needed to create the		\
-	 * relative __dtcm_start below (to be used as extern in code).	\
-	 */								\
-	. = ADDR(.tcm_start) + SIZEOF(.tcm_start) + SIZEOF(.text_itcm);	\
-									\
-	.dtcm_start : {							\
-		__dtcm_start = .;					\
-	}								\
-									\
-	/*								\
-	 * TODO: add remainder of ITCM as well,				\
-	 * that can be used for data!					\
-	 */								\
-	.data_dtcm DTCM_OFFSET : AT(__dtcm_start)			\
-	{								\
-		. = ALIGN(4);						\
+	__dtcm_start = .;						\
+	.data_dtcm DTCM_OFFSET : AT(__dtcm_start - LOAD_OFFSET) {	\
 		__sdtcm_data = .;					\
 		*(.tcm.data)						\
 		. = ALIGN(4);						\
 		__edtcm_data = .;					\
 	}								\
-									\
-	/* Reset the dot pointer or the linker gets confused */		\
-	. = ADDR(.dtcm_start) + SIZEOF(.data_dtcm);			\
-									\
-	/* End marker for freeing TCM copy in linked object */		\
-	.tcm_end : AT(ADDR(.dtcm_start) + SIZEOF(.data_dtcm)){		\
-		. = ALIGN(PAGE_SIZE);					\
-		__tcm_end = .;						\
-	}
+	. = __dtcm_start + SIZEOF(.data_dtcm);
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index bd6f451353..c186474422 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -758,20 +758,9 @@ void set_kernel_text_ro(void)
 static inline void fix_kernmem_perms(void) { }
 #endif /* CONFIG_STRICT_KERNEL_RWX */
 
-void free_tcmmem(void)
-{
-#ifdef CONFIG_HAVE_TCM
-	extern char __tcm_start, __tcm_end;
-
-	poison_init_mem(&__tcm_start, &__tcm_end - &__tcm_start);
-	free_reserved_area(&__tcm_start, &__tcm_end, -1, "TCM link");
-#endif
-}
-
 void free_initmem(void)
 {
 	fix_kernmem_perms();
-	free_tcmmem();
 
 	poison_init_mem(__init_begin, __init_end - __init_begin);
 	if (!machine_is_integrator() && !machine_is_cintegrator())
-- 
2.14.3
