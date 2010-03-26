From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Fri, 26 Mar 2010 01:35:52 +0100
Subject: [RFC] IXP4xx little-endian data-coherent support
Message-ID: <m3eij73onr.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm finally trying to eliminate the performance hit caused by IXP4xx NPE
network engines working in big-endian mode only (which means on LE
system network buffers have to be byte-swapped by the CPU).

I have already booted Linux in LE-DC mode and it generally works, and
the remaining changes needed seem trivial, though a few questions
remains.

The LE data-coherent mode on IXP4xx is achieved by setting a certain bit
(9) in first level page table descriptors. This means we can control
data-coherent vs value-coherent with 1 MB of virtual address space
granularity (LE DC is just hardware byte-swapping).

Options:

1. use DC mode on whole virtual address space.
Pro: simplicity
Con: using value-coherent mode for certain (most) peripherals
(registers) is faster, since there is no byte-unswapping to be done.

2. use DC mode for most devices (including RAM and PCI address space
(but not PCI controller registers)), and value-coherent mode for the
peripherals.
Pro: faster
Con: we have to provide different mappings ("memory types"?) for
different devices. It could use something like ioremap_byteswapped()
- does it make sense?

Another possibility for #2: map all those peripherals at boot (we're
already doing it except for a small QMgr region), set their page table
entry bit statically in MMU code (= value-coherent), then everything
else is DC. Much simpler, though it means the ROM area (EXP bus) has to
be mapped DC as well - perhaps an advantage (few drivers including MTD
and IDE drivers have to be modified).
That's what I personally prefer at this point.


Another question is entering the DC mode. It's only possible with MMU,
so the "boot" code has to be value-coherent. Then, just before enabling
the MMU, all active memory resources (such as the page table, the boot
loader tags, kernel image and possibly the external initramfs) have to
byte-swapped. Possibly, the kernel and/or external initramfs can be
pre-swapped (only parts which are running with MMU - not sure if it's
practical with the kernel). I'm currently just byte-swapping the entire
RAM except for a small area in which the swapping code (and MMU-on)
resides. Guess I could use a "trampoline" in QMgr SRAM area (with a
"section" mapping for simplicity).

Comments?

I'm attaching a working patch (core only, no drivers), it isn't pretty
but I think it shows the idea. It needs another trivial patch which adds
Kbuild option IXP4XX_SUPPORT_425A0 (LE data-coherent mode requires
IXP425 stepping B0 or later CPU).
-- 
Krzysztof Halasa

--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -649,6 +649,16 @@ config CPU_ENDIAN_BE32
 	help
 	  Support for the BE-32 (big-endian) mode on pre-ARMv6 processors.
 
+config CPU_LITTLE_ENDIAN_DATA_COHERENT
+	bool "Data-coherent CPU mode"
+	depends on !CPU_BIG_ENDIAN && ARCH_IXP4XX && !IXP4XX_SUPPORT_425A0
+	help
+	  Use data-coherent mode to access peripherals. This will improve
+	  performance of certain Ethernet and WAN drivers, at the cost of
+	  added complexity. Not very well tested.
+
+	  If unsure, say "N".
+
 config CPU_HIGH_VECTOR
 	depends on !MMU && CPU_CP15 && !CPU_ARM740T
 	bool "Select the High exception vector"

Perhaps this MT_DEVICE_VALUE_COHERENT isn't best name, MT_DEVICE_BYTESWAPPED?
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -27,6 +27,7 @@ struct map_desc {
 #define MT_MEMORY		9
 #define MT_ROM			10
 #define MT_MEMORY_NONCACHED	11
+#define MT_DEVICE_VALUE_COHERENT 12
 
 #ifdef CONFIG_MMU
 extern void iotable_init(struct map_desc *, int);



The following also removes PMD_BIT4, it seems XScale wants it cleared:
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -20,8 +20,15 @@
 
 #ifdef CONFIG_MMU
 
+
+#if defined(CONFIG_ARCH_IXP4XX) && defined(CONFIG_CPU_LITTLE_ENDIAN_DATA_COHERENT)
+#define _PAGE_USER_TABLE	(PMD_TYPE_TABLE | PMD_DOMAIN(DOMAIN_USER) | (1 << 9))
+#define _PAGE_KERNEL_TABLE	(PMD_TYPE_TABLE | PMD_DOMAIN(DOMAIN_KERNEL) | (1 << 9))
+#else
 #define _PAGE_USER_TABLE	(PMD_TYPE_TABLE | PMD_BIT4 | PMD_DOMAIN(DOMAIN_USER))
 #define _PAGE_KERNEL_TABLE	(PMD_TYPE_TABLE | PMD_BIT4 | PMD_DOMAIN(DOMAIN_KERNEL))
+#endif
+
 
 /*
  * Since we have only two-level page tables, these are trivial



Since our RAM is big-endian, we have to swap PCI accesses:
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -415,6 +415,6 @@ void __init ixp4xx_pci_preinit(void)
 	 * little-endian PCI and the big-endian AHB bus
 	 */
-#ifdef __ARMEB__
+#if defined(__ARMEB__) || defined(CONFIG_CPU_LITTLE_ENDIAN_DATA_COHERENT)
 	*PCI_CSR = PCI_CSR_IC | PCI_CSR_ABE | PCI_CSR_PDS | PCI_CSR_ADS;
 #else
 	*PCI_CSR = PCI_CSR_IC | PCI_CSR_ABE;
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -53,24 +53,29 @@ static struct map_desc ixp4xx_io_desc[] __initdata = {
 		.virtual	= IXP4XX_PERIPHERAL_BASE_VIRT,
 		.pfn		= __phys_to_pfn(IXP4XX_PERIPHERAL_BASE_PHYS),
 		.length		= IXP4XX_PERIPHERAL_REGION_SIZE,
-		.type		= MT_DEVICE
+		.type		= MT_DEVICE_VALUE_COHERENT
 	}, {	/* Expansion Bus Config Registers */
 		.virtual	= IXP4XX_EXP_CFG_BASE_VIRT,
 		.pfn		= __phys_to_pfn(IXP4XX_EXP_CFG_BASE_PHYS),
 		.length		= IXP4XX_EXP_CFG_REGION_SIZE,
-		.type		= MT_DEVICE
+		.type		= MT_DEVICE_VALUE_COHERENT
 	}, {	/* PCI Registers */
 		.virtual	= IXP4XX_PCI_CFG_BASE_VIRT,
 		.pfn		= __phys_to_pfn(IXP4XX_PCI_CFG_BASE_PHYS),
 		.length		= IXP4XX_PCI_CFG_REGION_SIZE,
-		.type		= MT_DEVICE
+		.type		= MT_DEVICE_VALUE_COHERENT
+	}, {	/* Queue Manager */
+		.virtual	= IXP4XX_QMGR_BASE_VIRT,
+		.pfn		= __phys_to_pfn(IXP4XX_QMGR_BASE_PHYS),
+		.length		= IXP4XX_QMGR_REGION_SIZE,
+		.type		= MT_DEVICE_VALUE_COHERENT
 	},
 #ifdef CONFIG_DEBUG_LL
 	{	/* Debug UART mapping */
 		.virtual	= IXP4XX_DEBUG_UART_BASE_VIRT,
 		.pfn		= __phys_to_pfn(IXP4XX_DEBUG_UART_BASE_PHYS),
 		.length		= IXP4XX_DEBUG_UART_REGION_SIZE,
-		.type		= MT_DEVICE
+		.type		= MT_DEVICE_VALUE_COHERENT
 	}
 #endif
 };
--- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
@@ -30,19 +30,24 @@
  *
  * 0x50000000	0x10000000	ioremap'd	EXP BUS
  *
- * 0x6000000	0x00004000	ioremap'd	QMgr
+ * 0xFFA00000 -> 0xFFBFFFFF is value-preserving in little-endian mode
  *
- * 0xC0000000	0x00001000	0xffbff000	PCI CFG
+ * 0x60000000	0x00004000	0xffbe7000	QMgr
+ *
+ * 0xC8000000	0x00013000	0xffbeb000	On-Chip Peripherals
  *
  * 0xC4000000	0x00001000	0xffbfe000	EXP CFG
  *
- * 0xC8000000	0x00013000	0xffbeb000	On-Chip Peripherals
+ * 0xC0000000	0x00001000	0xffbff000	PCI CFG
+ *
+ * (this should end on 0xFEFFFFFF, only VMALLOC_END -> 0xFEFFFFFF is for platform usage)
  */
 
 /*
  * Queue Manager
  */
 #define IXP4XX_QMGR_BASE_PHYS		(0x60000000)
+#define IXP4XX_QMGR_BASE_VIRT		(0xFFBE7000)
 #define IXP4XX_QMGR_REGION_SIZE		(0x00004000)
 
 /*
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -257,6 +257,13 @@ static struct mem_type mem_types[] = {
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
 	},
+	[MT_DEVICE_VALUE_COHERENT] = {
+		.prot_pte	= PROT_PTE_DEVICE | L_PTE_MT_DEV_SHARED |
+				  L_PTE_SHARED,
+		.prot_l1	= PMD_TYPE_TABLE,
+		.prot_sect	= PROT_SECT_DEVICE | PMD_SECT_S,
+		.domain		= DOMAIN_IO,
+	},
 };
 
 const struct mem_type *get_mem_type(unsigned int type)
@@ -315,6 +322,12 @@ static void __init build_mem_type_table(void)
 		for (i = 0; i < ARRAY_SIZE(mem_types); i++) {
 			mem_types[i].prot_sect &= ~PMD_BIT4;
 			mem_types[i].prot_l1 &= ~PMD_BIT4;
+#if defined(CONFIG_ARCH_IXP4XX) && defined(CONFIG_CPU_LITTLE_ENDIAN_DATA_COHERENT)
+			if (i != MT_DEVICE_VALUE_COHERENT) {
+				mem_types[i].prot_l1 |= 1 << 9;
+				mem_types[i].prot_sect |= 1 << 9;
+			}
+#endif
 		}
 	} else if (cpu_arch < CPU_ARCH_ARMv6) {
 		for (i = 0; i < ARRAY_SIZE(mem_types); i++) {
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 93df472..796eb87 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -23,11 +23,13 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
+#include <asm/domain.h>
 #include <asm/hwcap.h>
 #include <asm/pgtable.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
+#include <asm/system.h>
 #include "proc-macros.S"
 
 /*
@@ -480,6 +482,64 @@ __xscale_setup:
 	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I, D caches & BTB
 	mcr	p15, 0, ip, c7, c10, 4		@ Drain Write (& Fill) Buffer
 	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I, D TLBs
+#ifndef __ARMEB__
+	mrc	p15, 0, r0, c1, c0, 1
+	orr	r0, r0, #2			@ set the page table P bit
+	mcr	p15, 0, r0, c1, c0, 1
+
+#define TRAMPOLINE 0x200
+
+	/*
+	 * Create identity mapping for on-chip Queue Manager SRAM to cater for
+	 * the MMU enable.  This identity mapping will be removed by
+	 * paging_init().  We use our current program counter to determine
+	 * corresponding section base address.
+	 */
+#if 0
+	mov	r0, #0x60000000
+	orr	r0, #0x00000C00
+	orr	r0, #0x0000000E
+#endif
+	mov	r0, #0x00000C00
+	orr	r0, #0x0000000E
+	@ add	r3, r4, #0x600 << 2		@ r4 = page table address
+	str	r0, [r4]			@ identity mapping @ 0x60002100
+
+	adr	r6, BSYM(__xscale_setup_moved)
+	@mov	r7, #0x60000000
+	@orr	r7, #0x00002100
+	mov	r7, #TRAMPOLINE
+	mov	r3, #0x100
+1:	ldr	r0, [r6], #4
+	str	r0, [r7], #4
+	subs	r3, r3, #1
+	bne	1b
+	@mov	r7, #0x60000000
+	@orr	r7, #0x00002100
+	mov	r7, #TRAMPOLINE
+	mov	pc, r7
+
+__xscale_setup_moved:
+	mov	r6, #0				@ base address to swap
+2:	ldr	r0, [r6]
+	eor	r7, r0, r0, ror #16
+	bic	r7, r7, #0x00ff0000
+	mov	r0, r0, ror #8
+	eor	r0, r0, r7, lsr #8
+	str	r0, [r6], #4
+	cmp	r6, #0x200			@ end address
+	bne	2b
+
+	mov	r6, #0x400			@ base address to swap
+3:	ldr	r0, [r6]
+	eor	r7, r0, r0, ror #16
+	bic	r7, r7, #0x00ff0000
+	mov	r0, r0, ror #8
+	eor	r0, r0, r7, lsr #8
+	str	r0, [r6], #4
+	cmp	r6, #64 * 1024 * 1024		@ end address
+	bne	3b
+#endif
 	mov	r0, #1 << 6			@ cp6 for IOP3xx and Bulverde
 	orr	r0, r0, #1 << 13		@ Its undefined whether this
 	mcr	p15, 0, r0, c15, c1, 0		@ affects USR or SVC modes
@@ -489,7 +549,57 @@ __xscale_setup:
 	mrc	p15, 0, r0, c1, c0, 0		@ get control register
 	bic	r0, r0, r5
 	orr	r0, r0, r6
+
+#ifdef __ARMEB__
 	mov	pc, lr
+#else
+/*
+ * Setup common bits before finally enabling the MMU.  Essentially
+ * this is just loading the page table pointer and domain access
+ * registers.
+ */
+#ifdef CONFIG_ALIGNMENT_TRAP
+	orr	r0, r0, #CR_A
+#else
+	bic	r0, r0, #CR_A
+#endif
+#ifdef CONFIG_CPU_DCACHE_DISABLE
+	bic	r0, r0, #CR_C
+#endif
+#ifdef CONFIG_CPU_BPREDICT_DISABLE
+	bic	r0, r0, #CR_Z
+#endif
+#ifdef CONFIG_CPU_ICACHE_DISABLE
+	bic	r0, r0, #CR_I
+#endif
+	mov	r5, #(domain_val(DOMAIN_USER, DOMAIN_MANAGER) | \
+		      domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
+		      domain_val(DOMAIN_TABLE, DOMAIN_MANAGER) | \
+		      domain_val(DOMAIN_IO, DOMAIN_CLIENT))
+	mcr	p15, 0, r5, c3, c0, 0		@ load domain access register
+	mcr	p15, 0, r4, c2, c0, 0		@ load page table pointer
+	b	__xscale_turn_mmu_on
+
+/*
+ * Enable the MMU.  This completely changes the structure of the visible
+ * memory space.  You will not be able to trace execution through this.
+ * If you have an enquiry about this, *please* check the linux-arm-kernel
+ * mailing list archives BEFORE sending another post to the list.
+ *
+ *  r0  = cp#15 control register
+ *  r13 = *virtual* address to jump to upon completion
+ *
+ * other registers depend on the function called upon completion
+ */
+	.align	5
+__xscale_turn_mmu_on:
+	mov	r0, r0
+	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
+	mrc	p15, 0, r3, c0, c0, 0		@ read id reg
+	mov	r3, r3
+	mov	r3, r13
+	mov	pc, r3
+#endif
 	.size	__xscale_setup, . - __xscale_setup
 
 	/*
@@ -823,7 +933,7 @@ __ixp42x_proc_info:
 		PMD_SECT_BUFFERABLE | \
 		PMD_SECT_CACHEABLE | \
 		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
+		PMD_SECT_AP_READ | (1 << 9)
 	.long   PMD_TYPE_SECT | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
