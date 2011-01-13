From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 13 Jan 2011 17:04:28 -0500 (EST)
Subject: [PATCH] ARM: make head.S less dependent on the compile time
	PHYS_OFFSET define
Message-ID: <alpine.LFD.2.00.1101131659220.11803@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


In preparation to support a variable PHYS_OFFSET with the same kernel 
binary image, we need to get rid of the dependency on the compile time 
defined PHYS_OFFSET when establishing the initial page table.  The value 
of PHYS_OFFSET can be determined at run time by masking the pc value. A 
mask of 0xf8000000 is used to be consistent with the mask used by the 
CONFIG_AUTO_ZRELADDR feature.

If CONFIG_XIP_KERNEL is selected then the compile time PHYS_OFFSET is 
still used as before, as there is no point having a runtime determined 
PHYS_OFFSET in that case, and masking the pc value wouldn't be right 
anyway.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f17d9a0..be535b3 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -30,10 +30,6 @@
 #error "PHYS_OFFSET must be at an even 2MiB boundary!"
 #endif
 
-#define KERNEL_RAM_VADDR	(PAGE_OFFSET + TEXT_OFFSET)
-#define KERNEL_RAM_PADDR	(PHYS_OFFSET + TEXT_OFFSET)
-
-
 /*
  * swapper_pg_dir is the virtual address of the initial page table.
  * We place the page tables 16K below KERNEL_RAM_VADDR.  Therefore, we must
@@ -41,6 +37,7 @@
  * the least significant 16 bits to be 0x8000, but we could probably
  * relax this restriction to KERNEL_RAM_VADDR >= PAGE_OFFSET + 0x4000.
  */
+#define KERNEL_RAM_VADDR	(PAGE_OFFSET + TEXT_OFFSET)
 #if (KERNEL_RAM_VADDR & 0xffff) != 0x8000
 #error KERNEL_RAM_VADDR must start at 0xXXXX8000
 #endif
@@ -49,15 +46,29 @@
 	.equ	swapper_pg_dir, KERNEL_RAM_VADDR - 0x4000
 
 	.macro	pgtbl, rd
-	ldr	\rd, =(KERNEL_RAM_PADDR - 0x4000)
+	phys_offset \rd
+	add	\rd, \rd, #(TEXT_OFFSET - 0x4000)
 	.endm
 
 #ifdef CONFIG_XIP_KERNEL
+
 #define KERNEL_START	XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
 #define KERNEL_END	_edata_loc
+
+	.macro phys_offset, rd
+	ldr	\rd, =PHYS_OFFSET
+	.endm
+
 #else
+
 #define KERNEL_START	KERNEL_RAM_VADDR
 #define KERNEL_END	_end
+
+	.macro phys_offset, rd
+	mov	\rd, pc
+	and	\rd, \rd, #0xf8000000
+	.endm
+
 #endif
 
 /*
@@ -189,10 +200,9 @@ __create_page_tables:
 	/*
 	 * Map some ram to cover our .data and .bss areas.
 	 */
-	orr	r3, r7, #(KERNEL_RAM_PADDR & 0xff000000)
-	.if	(KERNEL_RAM_PADDR & 0x00f00000)
-	orr	r3, r3, #(KERNEL_RAM_PADDR & 0x00f00000)
-	.endif
+	phys_offset r3
+	add	r3, r3, #TEXT_OFFSET 
+	orr	r3, r3, r7
 	add	r0, r4,  #(KERNEL_RAM_VADDR & 0xff000000) >> 18
 	str	r3, [r0, #(KERNEL_RAM_VADDR & 0x00f00000) >> 18]!
 	ldr	r6, =(_end - 1)
