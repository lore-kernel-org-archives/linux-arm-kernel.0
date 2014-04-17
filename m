From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 17 Apr 2014 14:35:21 -0600
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <53501E87.6070307@codeaurora.org>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <534EF153.5050603@codeaurora.org>
 <alpine.LFD.2.11.1404161853530.980@knanqh.ubzr>
 <53501E87.6070307@codeaurora.org>
Message-ID: <20140417203521.GB22411@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 02:33:43PM -0400, Christopher Covington wrote:
> On 04/16/2014 07:21 PM, Nicolas Pitre wrote:
> > On Wed, 16 Apr 2014, Christopher Covington wrote:
> 
> >> Thank you for the suggestion. This approach also came to mind, but it would
> >> require new documentation and tooling in the JTAG scripts or simulator
> >> equivalent. That's another aspect of the ELF-based approaches that I
> >> like--hopefully existing documentation and tool support could be reused.
> > 
> > The above is useful for loading the raw uncompressed Image without 
> > carrying the full ELF baggage.
> 
> What exactly is the full ELF baggage? Aren't there existing mechanisms to omit
> debugging symbols, for example, if size is of concern?

FWIW, it is a small non-intrusive change to produce ELFs with the
proper LMA, if it is useful for specialized tooling, here is the 3.14
version of the patch I created (I see it needs a bit of cleanup..)
You must also force PATCH_PHYS_VIRT off.

The ELF also has the correct entry point address, so ELF tooling can
just jump into it, after setting the proper register values according
to the boot protocol.

>From ca9763668eed2eaaf0c0c2640f1502c22b68a739 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Fri, 14 Sep 2012 11:27:17 -0600
Subject: [PATCH] [ARM] Use AT() in the linker script to create correct program
 headers

The standard linux asm-generic/vmlinux.lds.h already supports this,
and it seems other architectures do as well.

The goal is to create an ELF file that has correct program headers. We
want to see the VirtAddr be the runtime address of the kernel with the
MMU turned on, and PhysAddr be the physical load address for the section
with no MMU.

This allows ELF based boot loaders to properly load vmlinux:

$ readelf -l vmlinux
Entry point 0x8000
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  LOAD           0x008000 0xc0008000 0x00008000 0x372244 0x3a4310 RWE 0x8000

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/arm/include/asm/memory.h |  2 +-
 arch/arm/kernel/vmlinux.lds.S | 51 +++++++++++++++++++++++++------------------
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 8756e4b..551e971 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -350,7 +350,7 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
 #define virt_addr_valid(kaddr)	(((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory) \
 					&& pfn_valid(__pa(kaddr) >> PAGE_SHIFT) )
 
-#endif
+#endif /* __ASSEMBLY__ */
 
 #include <asm-generic/memory_model.h>
 
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 7bcee5c..15353d2 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -3,6 +3,13 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
  */
 
+/* If we have a known, fixed physical load address then set LOAD_OFFSET
+   and generate an ELF that has the physical load address in the program
+   headers. */
+#ifndef CONFIG_ARM_PATCH_PHYS_VIRT
+#define LOAD_OFFSET (PAGE_OFFSET - PLAT_PHYS_OFFSET)
+#endif
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
@@ -43,7 +50,7 @@
 #endif
 
 OUTPUT_ARCH(arm)
-ENTRY(stext)
+ENTRY(phys_start)
 
 #ifndef __ARMEB__
 jiffies = jiffies_64;
@@ -86,11 +93,13 @@ SECTIONS
 #else
 	. = PAGE_OFFSET + TEXT_OFFSET;
 #endif
-	.head.text : {
+	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
 		_text = .;
+		phys_start = . - LOAD_OFFSET;
 		HEAD_TEXT
 	}
-	.text : {			/* Real text segment		*/
+	/* Real text segment */
+	.text :  AT(ADDR(.text) - LOAD_OFFSET) {
 		_stext = .;		/* Text and read-only data	*/
 			__exception_text_start = .;
 			*(.exception.text)
@@ -128,12 +137,12 @@ SECTIONS
 	 * Stack unwinding tables
 	 */
 	. = ALIGN(8);
-	.ARM.unwind_idx : {
+	.ARM.unwind_idx : AT(ADDR(.ARM.unwind_idx) - LOAD_OFFSET) {
 		__start_unwind_idx = .;
 		*(.ARM.exidx*)
 		__stop_unwind_idx = .;
 	}
-	.ARM.unwind_tab : {
+	.ARM.unwind_tab : AT(ADDR(.ARM.unwind_tab) - LOAD_OFFSET) {
 		__start_unwind_tab = .;
 		*(.ARM.extab*)
 		__stop_unwind_tab = .;
@@ -153,49 +162,49 @@ SECTIONS
 	 * only thing that matters is their relative offsets
 	 */
 	__vectors_start = .;
-	.vectors 0 : AT(__vectors_start) {
+	.vectors 0 : AT(__vectors_start - LOAD_OFFSET) {
 		*(.vectors)
 	}
 	. = __vectors_start + SIZEOF(.vectors);
 	__vectors_end = .;
 
 	__stubs_start = .;
-	.stubs 0x1000 : AT(__stubs_start) {
+	.stubs 0x1000 : AT(__stubs_start - LOAD_OFFSET) {
 		*(.stubs)
 	}
 	. = __stubs_start + SIZEOF(.stubs);
 	__stubs_end = .;
 
 	INIT_TEXT_SECTION(8)
-	.exit.text : {
+	.exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) {
 		ARM_EXIT_KEEP(EXIT_TEXT)
 	}
-	.init.proc.info : {
+	.init.proc.info : AT(ADDR(.init.proc.info) - LOAD_OFFSET) {
 		ARM_CPU_DISCARD(PROC_INFO)
 	}
-	.init.arch.info : {
+	.init.arch.info : AT(ADDR(.init.arch.info) - LOAD_OFFSET) {
 		__arch_info_begin = .;
 		*(.arch.info.init)
 		__arch_info_end = .;
 	}
-	.init.tagtable : {
+	.init.tagtable : AT(ADDR(.init.tagtable) - LOAD_OFFSET) {
 		__tagtable_begin = .;
 		*(.taglist.init)
 		__tagtable_end = .;
 	}
 #ifdef CONFIG_SMP_ON_UP
-	.init.smpalt : {
+	.init.smpalt : AT(ADDR(.init.smpalt) - LOAD_OFFSET) {
 		__smpalt_begin = .;
 		*(.alt.smp.init)
 		__smpalt_end = .;
 	}
 #endif
-	.init.pv_table : {
+	.init.pv_table : AT(ADDR(.init.pv_table) - LOAD_OFFSET) {
 		__pv_table_begin = .;
 		*(.pv_table)
 		__pv_table_end = .;
 	}
-	.init.data : {
+	.init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
 #ifndef CONFIG_XIP_KERNEL
 		INIT_DATA
 #endif
@@ -206,7 +215,7 @@ SECTIONS
 		INIT_RAM_FS
 	}
 #ifndef CONFIG_XIP_KERNEL
-	.exit.data : {
+	.exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET) {
 		ARM_EXIT_KEEP(EXIT_DATA)
 	}
 #endif
@@ -224,7 +233,7 @@ SECTIONS
 	__data_loc = .;
 #endif
 
-	.data : AT(__data_loc) {
+	.data : AT(__data_loc - LOAD_OFFSET) {
 		_data = .;		/* address in memory */
 		_sdata = .;
 
@@ -263,7 +272,7 @@ SECTIONS
 	 * free it after init has commenced and TCM contents have
 	 * been copied to its destination.
 	 */
-	.tcm_start : {
+	.tcm_start : AT(ADDR(.tcm_start) - LOAD_OFFSET) {
 		. = ALIGN(PAGE_SIZE);
 		__tcm_start = .;
 		__itcm_start = .;
@@ -275,7 +284,7 @@ SECTIONS
 	 * and we'll upload the contents from RAM to TCM and free
 	 * the used RAM after that.
 	 */
-	.text_itcm ITCM_OFFSET : AT(__itcm_start)
+	.text_itcm ITCM_OFFSET : AT(__itcm_start - LOAD_OFFSET)
 	{
 		__sitcm_text = .;
 		*(.tcm.text)
@@ -290,12 +299,12 @@ SECTIONS
 	 */
 	. = ADDR(.tcm_start) + SIZEOF(.tcm_start) + SIZEOF(.text_itcm);
 
-	.dtcm_start : {
+	.dtcm_start : AT(ADDR(.dtcm_start) - LOAD_OFFSET) {
 		__dtcm_start = .;
 	}
 
 	/* TODO: add remainder of ITCM as well, that can be used for data! */
-	.data_dtcm DTCM_OFFSET : AT(__dtcm_start)
+	.data_dtcm DTCM_OFFSET : AT(__dtcm_start - LOAD_OFFSET)
 	{
 		. = ALIGN(4);
 		__sdtcm_data = .;
@@ -308,7 +317,7 @@ SECTIONS
 	. = ADDR(.dtcm_start) + SIZEOF(.data_dtcm);
 
 	/* End marker for freeing TCM copy in linked object */
-	.tcm_end : AT(ADDR(.dtcm_start) + SIZEOF(.data_dtcm)){
+	.tcm_end : AT(ADDR(.dtcm_start) + SIZEOF(.data_dtcm) - LOAD_OFFSET){
 		. = ALIGN(PAGE_SIZE);
 		__tcm_end = .;
 	}
-- 
1.9.1
