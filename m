From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  5 May 2011 16:52:01 +0200
Subject: [RFC PATCH] arm: drop Execute-In-Place
Message-ID: <1304607121-13612-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nearly no-one use it, only amop1, pxa and sa1100 implement it
this is the only reason why we need to keep the PLAT_PHY_OFFSET
and do not enable the "Patch physical to virtual translations at runtime"
support when have MMU enabled

As done on AT91

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Eric Miao <eric.miao@canonical.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/Kconfig                            |   49 +++------------------
 arch/arm/Makefile                           |    7 +---
 arch/arm/boot/Makefile                      |   21 +---------
 arch/arm/boot/compressed/head.S             |    2 +-
 arch/arm/include/asm/memory.h               |    7 ---
 arch/arm/include/asm/mtd-xip.h              |   23 ----------
 arch/arm/kernel/head.S                      |   28 ------------
 arch/arm/kernel/module.c                    |   11 -----
 arch/arm/kernel/vmlinux.lds.S               |   22 ----------
 arch/arm/mach-omap1/include/mach/mtd-xip.h  |   61 ---------------------------
 arch/arm/mach-pxa/include/mach/mtd-xip.h    |   36 ----------------
 arch/arm/mach-sa1100/include/mach/mtd-xip.h |   26 -----------
 arch/arm/mm/init.c                          |    4 --
 arch/arm/mm/mmu.c                           |   16 -------
 14 files changed, 10 insertions(+), 303 deletions(-)
 delete mode 100644 arch/arm/include/asm/mtd-xip.h
 delete mode 100644 arch/arm/mach-omap1/include/mach/mtd-xip.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/mtd-xip.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/mtd-xip.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2336363..38d2416 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -10,11 +10,11 @@ config ARM
 	select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
 	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
 	select HAVE_ARCH_KGDB
-	select HAVE_KPROBES if (!XIP_KERNEL && !THUMB2_KERNEL)
+	select HAVE_KPROBES if (!THUMB2_KERNEL)
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
-	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
-	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
-	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
+	select HAVE_FUNCTION_TRACER
+	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
@@ -180,9 +180,6 @@ config GENERIC_ISA_DMA
 config FIQ
 	bool
 
-config ARCH_MTD_XIP
-	bool
-
 config VECTORS_BASE
 	hex
 	default 0xffff0000 if MMU || CPU_HIGH_VECTOR
@@ -194,13 +191,13 @@ config VECTORS_BASE
 config ARM_PATCH_PHYS_VIRT
 	bool "Patch physical to virtual translations at runtime (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
-	depends on !XIP_KERNEL && MMU
+	depends on MMU
 	depends on !ARCH_REALVIEW || !SPARSEMEM
 	help
 	  Patch phys-to-virt translation functions at runtime according to
 	  the position of the kernel in system memory.
 
-	  This can only be used with non-XIP with MMU kernels where
+	  This can only be used with MMU kernels where
 	  the base of physical memory is at a 16MB boundary.
 
 config ARM_PATCH_PHYS_VIRT_16BIT
@@ -616,7 +613,6 @@ config ARCH_PNX4008
 config ARCH_PXA
 	bool "PXA2xx/PXA3xx-based"
 	depends on MMU
-	select ARCH_MTD_XIP
 	select ARCH_HAS_CPUFREQ
 	select CLKDEV_LOOKUP
 	select ARCH_REQUIRE_GPIOLIB
@@ -672,7 +668,6 @@ config ARCH_SA1100
 	select CPU_SA1100
 	select ISA
 	select ARCH_SPARSEMEM_ENABLE
-	select ARCH_MTD_XIP
 	select ARCH_HAS_CPUFREQ
 	select CPU_FREQ
 	select GENERIC_CLOCKEVENTS
@@ -1350,7 +1345,7 @@ config SMP
 config SMP_ON_UP
 	bool "Allow booting SMP kernel on uniprocessor systems (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
-	depends on SMP && !XIP_KERNEL
+	depends on SMP
 	default y
 	help
 	  SMP kernels contain instructions which fail on non-SMP processors.
@@ -1755,36 +1750,6 @@ config CMDLINE_FORCE
 
 	  If unsure, say N.
 
-config XIP_KERNEL
-	bool "Kernel Execute-In-Place from ROM"
-	depends on !ZBOOT_ROM
-	help
-	  Execute-In-Place allows the kernel to run from non-volatile storage
-	  directly addressable by the CPU, such as NOR flash. This saves RAM
-	  space since the text section of the kernel is not loaded from flash
-	  to RAM.  Read-write sections, such as the data section and stack,
-	  are still copied to RAM.  The XIP kernel is not compressed since
-	  it has to run directly from flash, so it will take more space to
-	  store it.  The flash address used to link the kernel object files,
-	  and for storing it, is configuration dependent. Therefore, if you
-	  say Y here, you must know the proper physical address where to
-	  store the kernel image depending on your own flash memory usage.
-
-	  Also note that the make target becomes "make xipImage" rather than
-	  "make zImage" or "make Image".  The final kernel binary to put in
-	  ROM memory will be arch/arm/boot/xipImage.
-
-	  If unsure, say N.
-
-config XIP_PHYS_ADDR
-	hex "XIP Kernel Physical Location"
-	depends on XIP_KERNEL
-	default "0x00080000"
-	help
-	  This is the physical address in your flash memory the kernel will
-	  be linked for and stored to.  This address is dependent on your
-	  own flash usage.
-
 config KEXEC
 	bool "Kexec system call (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c7d321a..e7a748b 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -265,11 +265,7 @@ drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/
 libs-y				:= arch/arm/lib/ $(libs-y)
 
 # Default target when executing plain make
-ifeq ($(CONFIG_XIP_KERNEL),y)
-KBUILD_IMAGE := xipImage
-else
 KBUILD_IMAGE := zImage
-endif
 
 all:	$(KBUILD_IMAGE)
 
@@ -281,7 +277,7 @@ archprepare:
 # Convert bzImage to zImage
 bzImage: zImage
 
-zImage Image xipImage bootpImage uImage: vmlinux
+zImage Image bootpImage uImage: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
 
 zinstall uinstall install: vmlinux
@@ -299,7 +295,6 @@ i zi:;	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 define archhelp
   echo  '* zImage        - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
-  echo  '* xipImage      - XIP kernel image, if configured (arch/$(ARCH)/boot/xipImage)'
   echo  '  uImage        - U-Boot wrapped zImage'
   echo  '  bootpImage    - Combined zImage and initial RAM disk' 
   echo  '                  (supply initrd image via make variable INITRD=<path>)'
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 9128fdd..9d5fc43 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -27,24 +27,7 @@ INITRD_PHYS := $(initrd_phys-y)
 
 export ZRELADDR INITRD_PHYS PARAMS_PHYS
 
-targets := Image zImage xipImage bootpImage uImage
-
-ifeq ($(CONFIG_XIP_KERNEL),y)
-
-$(obj)/xipImage: vmlinux FORCE
-	$(call if_changed,objcopy)
-	@echo '  Kernel: $@ is ready (physical address: $(CONFIG_XIP_PHYS_ADDR))'
-
-$(obj)/Image $(obj)/zImage: FORCE
-	@echo 'Kernel configured for XIP (CONFIG_XIP_KERNEL=y)'
-	@echo 'Only the xipImage target is available in this case'
-	@false
-
-else
-
-$(obj)/xipImage: FORCE
-	@echo 'Kernel not configured for XIP (CONFIG_XIP_KERNEL!=y)'
-	@false
+targets := Image zImage bootpImage uImage
 
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
@@ -57,8 +40,6 @@ $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
 	@echo '  Kernel: $@ is ready'
 
-endif
-
 quiet_cmd_uimage = UIMAGE  $@
       cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A arm -O linux -T kernel \
 		   -C none -a $(LOADADDR) -e $(STARTADDR) \
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index adf583c..faf84d8 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -208,7 +208,7 @@ restart:	adr	r0, LC0
  *   r4  = final kernel address
  *   r5  = start of this image
  *   r9  = size of decompressed image
- *   r10 = end of this image, including  bss/stack/malloc space if non XIP
+ *   r10 = end of this image, including  bss/stack/malloc space
  * We basically want:
  *   r4 >= r10 -> OK
  *   r4 + image length <= r5 -> OK
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 431077c..9cf1fb8 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -66,13 +66,6 @@
 #endif
 
 /*
- * The XIP kernel gets mapped at the bottom of the module vm area.
- * Since we use sections to map it, this macro replaces the physical address
- * with its virtual address while keeping offset from the base section.
- */
-#define XIP_VIRT_ADDR(physaddr)  (MODULES_VADDR + ((physaddr) & 0x000fffff))
-
-/*
  * Allow 16MB-aligned ioremap pages
  */
 #define IOREMAP_MAX_ORDER	24
diff --git a/arch/arm/include/asm/mtd-xip.h b/arch/arm/include/asm/mtd-xip.h
deleted file mode 100644
index d79d66d..0000000
--- a/arch/arm/include/asm/mtd-xip.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * MTD primitives for XIP support. Architecture specific functions
- *
- * Do not include this file directly. It's included from linux/mtd/xip.h
- * 
- * Author:	Nicolas Pitre
- * Created:	Nov 2, 2004
- * Copyright:	(C) 2004 MontaVista Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ARM_MTD_XIP_H__
-#define __ARM_MTD_XIP_H__
-
-#include <mach/mtd-xip.h>
-
-/* fill instruction prefetch */
-#define xip_iprefetch() 	do { asm volatile (".rep 8; nop; .endr"); } while (0)
-
-#endif /* __ARM_MTD_XIP_H__ */
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index c9173cf..3308c3c 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -45,13 +45,8 @@
 	add	\rd, \phys, #TEXT_OFFSET - 0x4000
 	.endm
 
-#ifdef CONFIG_XIP_KERNEL
-#define KERNEL_START	XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
-#define KERNEL_END	_edata_loc
-#else
 #define KERNEL_START	KERNEL_RAM_VADDR
 #define KERNEL_END	_end
-#endif
 
 /*
  * Kernel startup entry point.
@@ -81,14 +76,10 @@ ENTRY(stext)
  THUMB( it	eq )		@ force fixup-able long branch encoding
 	beq	__error_p			@ yes, error 'p'
 
-#ifndef CONFIG_XIP_KERNEL
 	adr	r3, 2f
 	ldmia	r3, {r4, r8}
 	sub	r4, r3, r4			@ (PHYS_OFFSET - PAGE_OFFSET)
 	add	r8, r8, r4			@ PHYS_OFFSET
-#else
-	ldr	r8, =PLAT_PHYS_OFFSET
-#endif
 
 	/*
 	 * r1 = machine no, r2 = atags,
@@ -119,10 +110,8 @@ ENTRY(stext)
 1:	b	__enable_mmu
 ENDPROC(stext)
 	.ltorg
-#ifndef CONFIG_XIP_KERNEL
 2:	.long	.
 	.long	PAGE_OFFSET
-#endif
 
 /*
  * Setup the initial page tables.  We only setup the barest
@@ -188,23 +177,6 @@ __create_page_tables:
 	strls	r3, [r0], #4
 	bls	1b
 
-#ifdef CONFIG_XIP_KERNEL
-	/*
-	 * Map some ram to cover our .data and .bss areas.
-	 */
-	add	r3, r8, #TEXT_OFFSET
-	orr	r3, r3, r7
-	add	r0, r4,  #(KERNEL_RAM_VADDR & 0xff000000) >> 18
-	str	r3, [r0, #(KERNEL_RAM_VADDR & 0x00f00000) >> 18]!
-	ldr	r6, =(_end - 1)
-	add	r0, r0, #4
-	add	r6, r4, r6, lsr #18
-1:	cmp	r0, r6
-	add	r3, r3, #1 << 20
-	strls	r3, [r0], #4
-	bls	1b
-#endif
-
 	/*
 	 * Then map boot params address in r2 or
 	 * the first 1MB of ram if boot params address is not specified.
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index fee7c36..6582334 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -25,17 +25,6 @@
 #include <asm/smp_plat.h>
 #include <asm/unwind.h>
 
-#ifdef CONFIG_XIP_KERNEL
-/*
- * The XIP kernel text is mapped in the module area for modules and
- * some other stuff to work without any indirect relocations.
- * MODULES_VADDR is redefined here and not in asm/memory.h to avoid
- * recompiling the whole kernel when CONFIG_XIP_KERNEL is turned on/off.
- */
-#undef MODULES_VADDR
-#define MODULES_VADDR	(((unsigned long)_etext + ~PGDIR_MASK) & PGDIR_MASK)
-#endif
-
 #ifdef CONFIG_MMU
 void *module_alloc(unsigned long size)
 {
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b4348e6..5024972 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -38,11 +38,7 @@ jiffies = jiffies_64 + 4;
 
 SECTIONS
 {
-#ifdef CONFIG_XIP_KERNEL
-	. = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
-#else
 	. = PAGE_OFFSET + TEXT_OFFSET;
-#endif
 
 	.init : {			/* Init code and data		*/
 		_stext = .;
@@ -75,19 +71,15 @@ SECTIONS
 		SECURITY_INITCALL
 		INIT_RAM_FS
 
-#ifndef CONFIG_XIP_KERNEL
 		__init_begin = _stext;
 		INIT_DATA
 		ARM_EXIT_KEEP(EXIT_DATA)
-#endif
 	}
 
 	PERCPU(32, PAGE_SIZE)
 
-#ifndef CONFIG_XIP_KERNEL
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
-#endif
 
 	/*
 	 * unwind exit sections must be discarded before the rest of the
@@ -152,13 +144,8 @@ SECTIONS
 
 	_etext = .;			/* End of text and rodata section */
 
-#ifdef CONFIG_XIP_KERNEL
-	__data_loc = ALIGN(4);		/* location in binary */
-	. = PAGE_OFFSET + TEXT_OFFSET;
-#else
 	. = ALIGN(THREAD_SIZE);
 	__data_loc = .;
-#endif
 
 	.data : AT(__data_loc) {
 		_data = .;		/* address in memory */
@@ -170,15 +157,6 @@ SECTIONS
 		 */
 		INIT_TASK_DATA(THREAD_SIZE)
 
-#ifdef CONFIG_XIP_KERNEL
-		. = ALIGN(PAGE_SIZE);
-		__init_begin = .;
-		INIT_DATA
-		ARM_EXIT_KEEP(EXIT_DATA)
-		. = ALIGN(PAGE_SIZE);
-		__init_end = .;
-#endif
-
 		NOSAVE_DATA
 		CACHELINE_ALIGNED_DATA(32)
 		READ_MOSTLY_DATA(32)
diff --git a/arch/arm/mach-omap1/include/mach/mtd-xip.h b/arch/arm/mach-omap1/include/mach/mtd-xip.h
deleted file mode 100644
index f82a8dc..0000000
--- a/arch/arm/mach-omap1/include/mach/mtd-xip.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * MTD primitives for XIP support. Architecture specific functions.
- *
- * Do not include this file directly. It's included from linux/mtd/xip.h
- *
- * Author: Vladimir Barinov <vbarinov@embeddedalley.com>
- *
- * (c) 2005 MontaVista Software, Inc.  This file is licensed under the
- * terms of the GNU General Public License version 2.  This program is
- * licensed "as is" without any warranty of any kind, whether express or
- * implied.
- */
-
-#ifndef __ARCH_OMAP_MTD_XIP_H__
-#define __ARCH_OMAP_MTD_XIP_H__
-
-#include <mach/hardware.h>
-#define OMAP_MPU_TIMER_BASE	(0xfffec500)
-#define OMAP_MPU_TIMER_OFFSET	0x100
-
-typedef struct {
-	u32 cntl;			/* CNTL_TIMER, R/W */
-	u32 load_tim;			/* LOAD_TIM,   W */
-	u32 read_tim;			/* READ_TIM,   R */
-} xip_omap_mpu_timer_regs_t;
-
-#define xip_omap_mpu_timer_base(n)					\
-((volatile xip_omap_mpu_timer_regs_t*)OMAP1_IO_ADDRESS(OMAP_MPU_TIMER_BASE +	\
-	(n)*OMAP_MPU_TIMER_OFFSET))
-
-static inline unsigned long xip_omap_mpu_timer_read(int nr)
-{
-	volatile xip_omap_mpu_timer_regs_t* timer = xip_omap_mpu_timer_base(nr);
-	return timer->read_tim;
-}
-
-#define xip_irqpending()	\
-	(omap_readl(OMAP_IH1_ITR) & ~omap_readl(OMAP_IH1_MIR))
-#define xip_currtime()		(~xip_omap_mpu_timer_read(0))
-
-/*
- * It's permitted to do approxmation for xip_elapsed_since macro
- * (see linux/mtd/xip.h)
- */
-
-#ifdef CONFIG_MACH_OMAP_PERSEUS2
-#define xip_elapsed_since(x)	(signed)((~xip_omap_mpu_timer_read(0) - (x)) / 7)
-#else
-#define xip_elapsed_since(x)	(signed)((~xip_omap_mpu_timer_read(0) - (x)) / 6)
-#endif
-
-/*
- * xip_cpu_idle() is used when waiting for a delay equal or larger than
- * the system timer tick period.  This should put the CPU into idle mode
- * to save power and to be woken up only when some interrupts are pending.
- * As above, this should not rely upon standard kernel code.
- */
-
-#define xip_cpu_idle()  asm volatile ("mcr p15, 0, %0, c7, c0, 4" :: "r" (1))
-
-#endif /* __ARCH_OMAP_MTD_XIP_H__ */
diff --git a/arch/arm/mach-pxa/include/mach/mtd-xip.h b/arch/arm/mach-pxa/include/mach/mtd-xip.h
deleted file mode 100644
index 297387e..0000000
--- a/arch/arm/mach-pxa/include/mach/mtd-xip.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * MTD primitives for XIP support. Architecture specific functions
- *
- * Do not include this file directly. It's included from linux/mtd/xip.h
- * 
- * Author:	Nicolas Pitre
- * Created:	Nov 2, 2004
- * Copyright:	(C) 2004 MontaVista Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ARCH_PXA_MTD_XIP_H__
-#define __ARCH_PXA_MTD_XIP_H__
-
-#include <mach/regs-ost.h>
-#include <mach/regs-intc.h>
-
-#define xip_irqpending()	(ICIP & ICMR)
-
-/* we sample OSCR and convert desired delta to usec (1/4 ~= 1000000/3686400) */
-#define xip_currtime()		(OSCR)
-#define xip_elapsed_since(x)	(signed)((OSCR - (x)) / 4)
-
-/*
- * xip_cpu_idle() is used when waiting for a delay equal or larger than
- * the system timer tick period.  This should put the CPU into idle mode
- * to save power and to be woken up only when some interrupts are pending.
- * As above, this should not rely upon standard kernel code.
- */
-
-#define xip_cpu_idle()  asm volatile ("mcr p14, 0, %0, c7, c0, 0" :: "r" (1))
-
-#endif /* __ARCH_PXA_MTD_XIP_H__ */
diff --git a/arch/arm/mach-sa1100/include/mach/mtd-xip.h b/arch/arm/mach-sa1100/include/mach/mtd-xip.h
deleted file mode 100644
index b3d6840..0000000
--- a/arch/arm/mach-sa1100/include/mach/mtd-xip.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * MTD primitives for XIP support. Architecture specific functions
- *
- * Do not include this file directly. It's included from linux/mtd/xip.h
- * 
- * Author:	Nicolas Pitre
- * Created:	Nov 2, 2004
- * Copyright:	(C) 2004 MontaVista Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ARCH_SA1100_MTD_XIP_H__
-#define __ARCH_SA1100_MTD_XIP_H__
-
-#include <mach/hardware.h>
-
-#define xip_irqpending()	(ICIP & ICMR)
-
-/* we sample OSCR and convert desired delta to usec (1/4 ~= 1000000/3686400) */
-#define xip_currtime()		(OSCR)
-#define xip_elapsed_since(x)	(signed)((OSCR - (x)) / 4)
-
-#endif /* __ARCH_SA1100_MTD_XIP_H__ */
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index e5f6fc4..0c9d60e 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -291,11 +291,7 @@ void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
 		memblock_add(mi->bank[i].start, mi->bank[i].size);
 
 	/* Register the kernel text, kernel data and initrd with memblock. */
-#ifdef CONFIG_XIP_KERNEL
-	memblock_reserve(__pa(_sdata), _end - _sdata);
-#else
 	memblock_reserve(__pa(_stext), _end - _stext);
-#endif
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (phys_initrd_size &&
 	    memblock_is_region_reserved(phys_initrd_start, phys_initrd_size)) {
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 6cf76b3..1c0f040 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -867,10 +867,6 @@ static inline void prepare_page_table(void)
 	for (addr = 0; addr < MODULES_VADDR; addr += PGDIR_SIZE)
 		pmd_clear(pmd_off_k(addr));
 
-#ifdef CONFIG_XIP_KERNEL
-	/* The XIP kernel is mapped in the module area -- skip over it */
-	addr = ((unsigned long)_etext + PGDIR_SIZE - 1) & PGDIR_MASK;
-#endif
 	for ( ; addr < PAGE_OFFSET; addr += PGDIR_SIZE)
 		pmd_clear(pmd_off_k(addr));
 
@@ -931,18 +927,6 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 		pmd_clear(pmd_off_k(addr));
 
 	/*
-	 * Map the kernel if it is XIP.
-	 * It is always first in the modulearea.
-	 */
-#ifdef CONFIG_XIP_KERNEL
-	map.pfn = __phys_to_pfn(CONFIG_XIP_PHYS_ADDR & SECTION_MASK);
-	map.virtual = MODULES_VADDR;
-	map.length = ((unsigned long)_etext - map.virtual + ~SECTION_MASK) & SECTION_MASK;
-	map.type = MT_ROM;
-	create_mapping(&map);
-#endif
-
-	/*
 	 * Map the cache flushing regions.
 	 */
 #ifdef FLUSH_BASE
-- 
1.7.4.1
