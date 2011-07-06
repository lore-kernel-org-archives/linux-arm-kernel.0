From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 6 Jul 2011 09:21:33 -0400 (EDT)
Subject: [PATCH] ARM: get rid of a few StrongARM cache-related build time
	constants
In-Reply-To: <20110706075542.GK8286@n2100.arm.linux.org.uk>
References: <1309919636-20546-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706075542.GK8286@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107060912490.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jul 2011, Russell King - ARM Linux wrote:

> On Tue, Jul 05, 2011 at 10:33:56PM -0400, Nicolas Pitre wrote:
> > index 087bc77..f8a94d6 100644
> > --- a/arch/arm/mach-ebsa110/core.c
> > +++ b/arch/arm/mach-ebsa110/core.c
> > @@ -23,6 +23,7 @@
> >  #include <asm/pgtable.h>
> >  #include <asm/page.h>
> >  #include <asm/system.h>
> > +#include <asm/cacheflush.h>
> >  
> >  #include <asm/mach/arch.h>
> >  #include <asm/mach/irq.h>
> > @@ -114,9 +115,12 @@ static struct map_desc ebsa110_io_desc[] __initdata = {
> >  	}
> >  };
> >  
> > +#define SRAM_PHYS		0xdf000000
> ...
> > -#define FLUSH_BASE_PHYS		0x40000000
> > -#define FLUSH_BASE		0xdf000000
> 
> Looks like you chose the wrong constant.

Oops.  Here's a fixed patch.

Could you test this patch as well?  You're the only one I know who might 
still have access to the affected hardware.

commit 14b70a36ce97d4c375ac88f0489a000616e1d1c5
Author: Nicolas Pitre <nicolas.pitre@linaro.org>
Date:   Tue Jul 5 22:33:28 2011 -0400

    ARM: get rid of a few StrongARM cache-related build time constants
    
    The StrongARM based machines define a couple constants which are
    obstacles to a single kernel image.  Amongst them are FLUSH_BASE,
    FLUSH_BASE_PHYS, FLUSH_BASE_MINICACHE and UNCACHEABLE_ADDR.
    The affected code can be found in mm/mmu.c, mm/proc-sa110.S,
    mm/proc-sa1100.S and cache-v4wb.S.  Let's create some code to
    deal with the differences at run time and initialize the proper
    mappings with common virtual addresses for them instead.
    
    This should be functionally equivalent except for the following
    details:
    
    - Mappings are created using second level PTEs instead of first
      level sections.  The first level page table covering those PTEs
      is already there because of the fixmaps and the vector page so no
      additional memory is required.  There might also be more TLB usage,
      however this is not something one might be concerned about when the
      whole cache is being flushed, completely pushing the cost of those
      TLBs below noise level.
    
    - CACHE_DLIMIT is now the same for both SA110 and SA1100.  This is
      unclear if loading a variable each time v4wb_flush_user_cache_range
      is called would be beneficial.
    
    - The way UNCACHEABLE_ADDR was defined and used on RiscPC and Shark
      didn't produce a real uncacheable address, probably inhibiting the
      clock switching in cpu_sa110_do_idle().  As a  side effect, this patch
      fixes this.
    
    Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

diff --git a/Documentation/arm/memory.txt b/Documentation/arm/memory.txt
index 771d48d..b7a5ae8 100644
--- a/Documentation/arm/memory.txt
+++ b/Documentation/arm/memory.txt
@@ -31,9 +31,10 @@ ffff0000	ffff0fff	CPU vector page.
 				CPU supports vector relocation (control
 				register V bit.)
 
-fffe0000	fffeffff	XScale cache flush area.  This is used
-				in proc-xscale.S to flush the whole data
-				cache. (XScale does not have TCM.)
+fffe0000	fffeffff	StrongARM and XScale cache flush area.
+				This is used in cache-v4wb.S and proc-xscale.S
+				to flush the whole data cache.
+				(Neither StrongARM nor XScale have TCM.)
 
 fffe8000	fffeffff	DTCM mapping area for platforms with
 				DTCM mounted inside the CPU.
diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index d5d8d5c..1821757 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -157,6 +157,16 @@ extern void dmac_flush_range(const void *, const void *);
 
 #endif
 
+#ifdef CONFIG_CPU_CACHE_V4WB
+
+enum cache_v4wb_cputype { CACHE_CPU_SA110, CACHE_CPU_SA1100 };
+
+extern void cache_v4wb_init(unsigned long flush_phys_addr,
+			    unsigned long uncached_phys_addr,
+			    enum cache_v4wb_cputype cpu_type);
+
+#endif
+
 /*
  * Copy user data from/to a page which is mapped into a different
  * processes address space.  Really, we want to allow our "user
diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index 087bc77..66f9847 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -23,6 +23,7 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/system.h>
+#include <asm/cacheflush.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
@@ -114,9 +115,12 @@ static struct map_desc ebsa110_io_desc[] __initdata = {
 	}
 };
 
+#define SRAM_PHYS		0x40000000
+
 static void __init ebsa110_map_io(void)
 {
 	iotable_init(ebsa110_io_desc, ARRAY_SIZE(ebsa110_io_desc));
+	cache_v4wb_init(SRAM_PHYS, TRICK4_PHYS, CACHE_CPU_SA110);
 }
 
 
diff --git a/arch/arm/mach-ebsa110/include/mach/hardware.h b/arch/arm/mach-ebsa110/include/mach/hardware.h
index 4b2fb77..705dc40 100644
--- a/arch/arm/mach-ebsa110/include/mach/hardware.h
+++ b/arch/arm/mach-ebsa110/include/mach/hardware.h
@@ -54,10 +54,5 @@
 #define PIT_BASE		0xfc000000
 #define SOFT_BASE		0xfd000000
 
-/*
- * RAM definitions
- */
-#define UNCACHEABLE_ADDR	0xff000000	/* IRQ_STAT */
-
 #endif
 
diff --git a/arch/arm/mach-ebsa110/include/mach/memory.h b/arch/arm/mach-ebsa110/include/mach/memory.h
index 8e49066..2af7ec4 100644
--- a/arch/arm/mach-ebsa110/include/mach/memory.h
+++ b/arch/arm/mach-ebsa110/include/mach/memory.h
@@ -21,10 +21,4 @@
  */
 #define PLAT_PHYS_OFFSET	UL(0x00000000)
 
-/*
- * Cache flushing area - SRAM
- */
-#define FLUSH_BASE_PHYS		0x40000000
-#define FLUSH_BASE		0xdf000000
-
 #endif
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 38a44f9..2b9d83a 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -21,6 +21,7 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 #include <asm/setup.h>
+#include <asm/cacheflush.h>
 #include <asm/hardware/dec21285.h>
 
 #include <asm/mach/irq.h>
@@ -185,6 +186,8 @@ static struct map_desc ebsa285_host_io_desc[] __initdata = {
 
 void __init footbridge_map_io(void)
 {
+	cache_v4wb_init(0x50000000, 0x50010000, CACHE_CPU_SA110);
+
 	/*
 	 * Set up the common mapping first; we need this to
 	 * determine whether we're in host mode or not.
diff --git a/arch/arm/mach-footbridge/include/mach/hardware.h b/arch/arm/mach-footbridge/include/mach/hardware.h
index b6fdf23..f8b7e95 100644
--- a/arch/arm/mach-footbridge/include/mach/hardware.h
+++ b/arch/arm/mach-footbridge/include/mach/hardware.h
@@ -63,8 +63,6 @@
 #define XBUS_SWITCH_J17_11	((*XBUS_SWITCH) & (1 << 5))
 #define XBUS_SWITCH_J17_9	((*XBUS_SWITCH) & (1 << 6))
 
-#define UNCACHEABLE_ADDR	(ARMCSR_BASE + 0x108)
-
 
 /* PIC irq control */
 #define PIC_LO			0x20
diff --git a/arch/arm/mach-footbridge/include/mach/memory.h b/arch/arm/mach-footbridge/include/mach/memory.h
index 5c6df37..3e17e5c 100644
--- a/arch/arm/mach-footbridge/include/mach/memory.h
+++ b/arch/arm/mach-footbridge/include/mach/memory.h
@@ -55,15 +55,8 @@ extern unsigned long __bus_to_pfn(unsigned long);
 #endif
 
 /*
- * Cache flushing area.
- */
-#define FLUSH_BASE		0xf9000000
-
-/*
  * Physical DRAM offset.
  */
 #define PLAT_PHYS_OFFSET		UL(0x00000000)
 
-#define FLUSH_BASE_PHYS		0x50000000
-
 #endif
diff --git a/arch/arm/mach-rpc/include/mach/hardware.h b/arch/arm/mach-rpc/include/mach/hardware.h
index dde6b3c..4f3b227 100644
--- a/arch/arm/mach-rpc/include/mach/hardware.h
+++ b/arch/arm/mach-rpc/include/mach/hardware.h
@@ -46,8 +46,6 @@
 #define SCREEN_END		0xdfc00000
 #define SCREEN_BASE		0xdf800000
 
-#define UNCACHEABLE_ADDR	0xdf010000
-
 /*
  * IO Addresses
  */
diff --git a/arch/arm/mach-rpc/include/mach/memory.h b/arch/arm/mach-rpc/include/mach/memory.h
index 18a2210..e2fcf9b 100644
--- a/arch/arm/mach-rpc/include/mach/memory.h
+++ b/arch/arm/mach-rpc/include/mach/memory.h
@@ -24,12 +24,6 @@
 #define PLAT_PHYS_OFFSET	UL(0x10000000)
 
 /*
- * Cache flushing area - ROM
- */
-#define FLUSH_BASE_PHYS		0x00000000
-#define FLUSH_BASE		0xdf000000
-
-/*
  * Sparsemem support.  Each section is a maximum of 64MB.  The sections
  * are offset by 128MB and can cover 128MB, so that gives us a maximum
  * of 29 physmem bits.
diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
index 580b3c7..fd086ff 100644
--- a/arch/arm/mach-rpc/riscpc.c
+++ b/arch/arm/mach-rpc/riscpc.c
@@ -27,6 +27,7 @@
 #include <asm/page.h>
 #include <asm/domain.h>
 #include <asm/setup.h>
+#include <asm/cacheflush.h>
 
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
@@ -84,6 +85,9 @@ static struct map_desc rpc_io_desc[] __initdata = {
 static void __init rpc_map_io(void)
 {
 	iotable_init(rpc_io_desc, ARRAY_SIZE(rpc_io_desc));
+#ifdef CPU_CACHE_V4WB
+	cache_v4wb_init(0, 0x10000, CACHE_CPU_SA110);
+#endif
 
 	/*
 	 * Turn off floppy.
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index e21f347..9ddd265 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -21,6 +21,7 @@
 #include <asm/div64.h>
 #include <mach/hardware.h>
 #include <asm/system.h>
+#include <asm/cacheflush.h>
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 #include <asm/irq.h>
@@ -403,12 +404,16 @@ static struct map_desc standard_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(0xb0000000),
 		.length		= 0x00200000,
 		.type		= MT_DEVICE
-	},
+	}
 };
 
+#define SA1100_ZERO_BANK	0xe0000000
+#define ICIP_PHYS_ADDR		0x90050000
+
 void __init sa1100_map_io(void)
 {
 	iotable_init(standard_io_desc, ARRAY_SIZE(standard_io_desc));
+	cache_v4wb_init(SA1100_ZERO_BANK, ICIP_PHYS_ADDR, CACHE_CPU_SA1100);
 }
 
 /*
diff --git a/arch/arm/mach-sa1100/include/mach/hardware.h b/arch/arm/mach-sa1100/include/mach/hardware.h
index 967ae76..355f0b0 100644
--- a/arch/arm/mach-sa1100/include/mach/hardware.h
+++ b/arch/arm/mach-sa1100/include/mach/hardware.h
@@ -12,10 +12,6 @@
 #ifndef __ASM_ARCH_HARDWARE_H
 #define __ASM_ARCH_HARDWARE_H
 
-
-#define UNCACHEABLE_ADDR	0xfa050000
-
-
 /*
  * SA1100 internal I/O mappings
  *
diff --git a/arch/arm/mach-sa1100/include/mach/memory.h b/arch/arm/mach-sa1100/include/mach/memory.h
index 12d3767..8b56fb3 100644
--- a/arch/arm/mach-sa1100/include/mach/memory.h
+++ b/arch/arm/mach-sa1100/include/mach/memory.h
@@ -31,11 +31,4 @@
 #define MAX_PHYSMEM_BITS	32
 #define SECTION_SIZE_BITS	27
 
-/*
- * Cache flushing area - SA1100 zero bank
- */
-#define FLUSH_BASE_PHYS		0xe0000000
-#define FLUSH_BASE		0xf5000000
-#define FLUSH_BASE_MINICACHE	0xf5100000
-
 #endif
diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
index ac2873c..1173082 100644
--- a/arch/arm/mach-shark/core.c
+++ b/arch/arm/mach-shark/core.c
@@ -15,6 +15,7 @@
 #include <asm/mach-types.h>
 #include <asm/leds.h>
 #include <asm/param.h>
+#include <asm/cacheflush.h>
 
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
@@ -116,6 +117,7 @@ static struct map_desc shark_io_desc[] __initdata = {
 static void __init shark_map_io(void)
 {
 	iotable_init(shark_io_desc, ARRAY_SIZE(shark_io_desc));
+	cache_v4wb_init(0x80000000, 0x80010000, CACHE_CPU_SA110);
 }
 
 #define IRQ_TIMER 0
diff --git a/arch/arm/mach-shark/include/mach/hardware.h b/arch/arm/mach-shark/include/mach/hardware.h
index 94d84b2..dab0857 100644
--- a/arch/arm/mach-shark/include/mach/hardware.h
+++ b/arch/arm/mach-shark/include/mach/hardware.h
@@ -10,8 +10,6 @@
 #ifndef __ASM_ARCH_HARDWARE_H
 #define __ASM_ARCH_HARDWARE_H
 
-#define UNCACHEABLE_ADDR        0xdf010000
-
 #define pcibios_assign_all_busses()     1
 
 #define PCIBIOS_MIN_IO          0x6000
diff --git a/arch/arm/mach-shark/include/mach/memory.h b/arch/arm/mach-shark/include/mach/memory.h
index 1cf8d69..e19df6f 100644
--- a/arch/arm/mach-shark/include/mach/memory.h
+++ b/arch/arm/mach-shark/include/mach/memory.h
@@ -17,10 +17,4 @@
  */
 #define PLAT_PHYS_OFFSET     UL(0x08000000)
 
-/*
- * Cache flushing area
- */
-#define FLUSH_BASE_PHYS		0x80000000
-#define FLUSH_BASE		0xdf000000
-
 #endif
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index bca7e61..14b0af1 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_CPU_PABRT_V7)	+= pabort-v7.o
 obj-$(CONFIG_CPU_CACHE_V3)	+= cache-v3.o
 obj-$(CONFIG_CPU_CACHE_V4)	+= cache-v4.o
 obj-$(CONFIG_CPU_CACHE_V4WT)	+= cache-v4wt.o
-obj-$(CONFIG_CPU_CACHE_V4WB)	+= cache-v4wb.o
+obj-$(CONFIG_CPU_CACHE_V4WB)	+= cache-v4wb.o cache-v4wb-init.o
 obj-$(CONFIG_CPU_CACHE_V6)	+= cache-v6.o
 obj-$(CONFIG_CPU_CACHE_V7)	+= cache-v7.o
 obj-$(CONFIG_CPU_CACHE_FA)	+= cache-fa.o
diff --git a/arch/arm/mm/cache-v4wb-init.c b/arch/arm/mm/cache-v4wb-init.c
new file mode 100644
index 0000000..e86b14e
--- /dev/null
+++ b/arch/arm/mm/cache-v4wb-init.c
@@ -0,0 +1,89 @@
+/*
+ * linux/arch/arm/mm/cache-v4wb-init.c
+ *
+ * Author:	Nicolas Pitre
+ * Copyright:	(C) 2011 Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Runtime initialization for the code in cache-v4wb.S.
+ */
+
+#include <linux/init.h>
+#include <asm/sizes.h>
+#include <asm/cacheflush.h>
+#include <asm/mach/map.h>
+
+#define FLUSH_BASE		0xfffe0000
+#define FLUSH_OFF_ALT		SZ_32K
+#define FLUSH_BASE_ALT		(FLUSH_BASE + FLUSH_OFF_ALT)
+#define UNCACHEABLE_ADDR 	0xfffee000
+
+static struct map_desc cache_v4wb_map[] __initdata = {
+	{
+		.virtual	= FLUSH_BASE,
+		.length		= SZ_16K,
+		.type		= MT_CACHECLEAN,
+	}, {
+		.virtual	= FLUSH_BASE + SZ_16K,
+		.length		= PAGE_SIZE,
+		.type		= MT_MINICLEAN,
+	}, {
+		.virtual	= FLUSH_BASE_ALT,
+		.length		= SZ_16K,
+		.type		= MT_CACHECLEAN,
+	}, {
+		.virtual	= FLUSH_BASE_ALT + SZ_16K,
+		.length		= PAGE_SIZE,
+		.type		= MT_MINICLEAN,
+	}, {
+		.virtual	= UNCACHEABLE_ADDR,
+		.length		= PAGE_SIZE,
+		.type		= MT_UNCACHED,
+	}
+};
+
+/* shared with cache-v4wb.S */
+struct {
+	unsigned long addr;
+	unsigned long size;
+} cache_v4wb_params;
+
+/*
+ * This sets up cache flushing areas for the SA110 and SA11x0 processors.
+ * For convenience, uncached_phys_addr is used here to create an uncacheable
+ * mapping as needed by proc-sa110.S and proc-sa1100.S.
+ */
+void __init cache_v4wb_init(unsigned long flush_phys_addr,
+			    unsigned long uncached_phys_addr,
+			    enum cache_v4wb_cputype cpu_type)
+{
+	cache_v4wb_map[0].pfn = __phys_to_pfn(flush_phys_addr);
+	cache_v4wb_map[1].pfn = __phys_to_pfn(flush_phys_addr + SZ_16K);
+	cache_v4wb_map[2].pfn = __phys_to_pfn(flush_phys_addr + FLUSH_OFF_ALT);
+	cache_v4wb_map[3].pfn = __phys_to_pfn(flush_phys_addr + FLUSH_OFF_ALT + SZ_16K);
+	cache_v4wb_map[4].pfn = __phys_to_pfn(uncached_phys_addr);
+
+	/*
+	 * SA110 has a 16KB cache and no minicache.
+	 * SA1100 has a 8KB cache and a 512-byte minicache.
+	 * To make the flush code straight forward, we simply pretend
+	 * that the SA1100 has a cache of 8704 bytes in size and its
+	 * flush area is located at an offset of 8192 bytes into
+	 * the mapped area.
+	 */
+	switch (cpu_type) {
+	case CACHE_CPU_SA110:
+		cache_v4wb_params.addr = FLUSH_BASE;
+		cache_v4wb_params.size = SZ_16K;
+		break;
+	case CACHE_CPU_SA1100:
+		cache_v4wb_params.addr = FLUSH_BASE + SZ_8K;
+		cache_v4wb_params.size = SZ_8K + 512;
+		break;
+	}
+
+	iotable_init(cache_v4wb_map, ARRAY_SIZE(cache_v4wb_map));
+}
diff --git a/arch/arm/mm/cache-v4wb.S b/arch/arm/mm/cache-v4wb.S
index f40c696..bff5fec 100644
--- a/arch/arm/mm/cache-v4wb.S
+++ b/arch/arm/mm/cache-v4wb.S
@@ -19,17 +19,6 @@
 #define CACHE_DLINESIZE	32
 
 /*
- * The total size of the data cache.
- */
-#if defined(CONFIG_CPU_SA110)
-# define CACHE_DSIZE	16384
-#elif defined(CONFIG_CPU_SA1100)
-# define CACHE_DSIZE	8192
-#else
-# error Unknown cache size
-#endif
-
-/*
  * This is the size at which it becomes more efficient to
  * clean the whole cache, rather than using the individual
  * cache line maintenance instructions.
@@ -43,11 +32,8 @@
  * 131072  591 591 591   656 657 651
  *  Whole  132 136 132   221 217 207 <---
  */
-#define CACHE_DLIMIT	(CACHE_DSIZE * 4)
+#define CACHE_DLIMIT	32768
 
-	.data
-flush_base:
-	.long	FLUSH_BASE
 	.text
 
 /*
@@ -78,21 +64,14 @@ ENTRY(v4wb_flush_kern_cache_all)
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache
 __flush_whole_cache:
-	ldr	r3, =flush_base
-	ldr	r1, [r3, #0]
-	eor	r1, r1, #CACHE_DSIZE
+	ldr	r3, =cache_v4wb_params
+	ldmia	r3, {r1, r2}
+	eor	r1, r1, #32768			@ FLUSH_OFF_ALT
 	str	r1, [r3, #0]
-	add	r2, r1, #CACHE_DSIZE
-1:	ldr	r3, [r1], #32
-	cmp	r1, r2
-	blo	1b
-#ifdef FLUSH_BASE_MINICACHE
-	add	r2, r2, #FLUSH_BASE_MINICACHE - FLUSH_BASE
-	sub	r1, r2, #512			@ only 512 bytes
+	add	r2, r1, r2
 1:	ldr	r3, [r1], #32
 	cmp	r1, r2
 	blo	1b
-#endif
 	mcr	p15, 0, ip, c7, c10, 4		@ drain write buffer
 	mov	pc, lr
 
diff --git a/arch/arm/mm/proc-sa110.S b/arch/arm/mm/proc-sa110.S
index 46f09ed..e8c44a2 100644
--- a/arch/arm/mm/proc-sa110.S
+++ b/arch/arm/mm/proc-sa110.S
@@ -30,6 +30,11 @@
  */
 #define DCACHELINESIZE	32
 
+/*
+ * Address used for uncached access (mapping set up in cache-v4wb-init.c)
+ */
+#define UNCACHEABLE_ADDR 0xfffee000
+
 	.text
 
 /*
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 184a9c9..2d805ae 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -34,6 +34,11 @@
  */
 #define DCACHELINESIZE	32
 
+/*
+ * Address used for uncached access (mapping set up in cache-v4wb-init.c)
+ */
+#define UNCACHEABLE_ADDR 0xfffee000
+
 	__INIT
 
 /*



> 
