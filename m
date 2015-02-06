From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Feb 2015 16:14:28 +0000
Subject: Continuing kallsyms failures - large kernels, XIP kernels, and
 large XIP kernels
In-Reply-To: <20150206142033.GB10842@pengutronix.de>
References: <20150130145642.GK26493@n2100.arm.linux.org.uk>
 <20150130153414.GM26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501301224180.1322@knanqh.ubzr>
 <20150131002253.GR26493@n2100.arm.linux.org.uk>
 <20150204000307.GA8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1502032054460.1322@knanqh.ubzr>
 <20150204094414.GC8656@n2100.arm.linux.org.uk>
 <20150205084323.GS10842@pengutronix.de>
 <20150206142033.GB10842@pengutronix.de>
Message-ID: <20150206161428.GZ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 06, 2015 at 03:20:33PM +0100, Uwe Kleine-K?nig wrote:
> Hello Russell,
> 
> On Thu, Feb 05, 2015 at 09:43:23AM +0100, Uwe Kleine-K?nig wrote:
> > An unmodified 3.19.0-rc6 + efm32_defconfig boots just fine with XIP (and
> > has to little RAM for holding the kernel image in it's 4 MiB RAM).
> And btw next fails to build because of your patch
> 51f36035999ca403d08304176bdfa288a549b50e. Maybe you can limit it to MMU
> configs only to prevent false positives?

I'm intending to drop that patch; I think it's far too difficult to try
and modify vmlinux.lds to be able to detect these kinds of overflows,
which is a real shame.

I have been experimenting with MEMORY {} over the last few days, but
getting that right is proving to be rather problematical - had all the
LMA adjustments for the kernel already used it, that might have been a
way forward (and it certainly does give us protection against any
section getting too large) but as we don't, it's just too big a patch
with too high a chance of breaking stuff.

Part of the problem is that the linker script is already soo damn
obfuscated because of all the NoMMU vs XIP vs MMU variants that we
support through #ifdef hell - and don't even suggest that we can pull
other preprocessor tricks to sort that - it's the fact that stuff is
conditional that's the problem - that makes it much harder to verify
any change, and ensure that the resulting layout is _actually_ correct
and isn't going to break in some corner case.

Yet again, our complexity gets the better of us, and makes stuff
effectively unmaintainable.

So I guess we're just going to have to put up with a kallsyms failure
indicating that something isn't right.

This is what I ended up with so far:

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 9351f7fbdfb1..85a26ed9bf36 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -54,6 +54,43 @@ jiffies = jiffies_64;
 jiffies = jiffies_64 + 4;
 #endif
 
+#ifndef CONFIG_MMU
+MEMORY
+{
+  FLASH (RXA) : ORIGIN = CONFIG_FLASH_MEM_BASE, LENGTH = CONFIG_FLASH_SIZE
+  RAM (!RX) : ORIGIN = CONFIG_DRAM_BASE, LENGTH = CONFIG_DRAM_SIZE
+}
+#define REGION_RO_VMA >FLASH
+#define REGION_RW_VMA >RAM
+#elif defined(CONFIG_XIP_KERNEL)
+MEMORY
+{
+  XIP_VMA_RO   (RX) : ORIGIN = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR) LENGTH = 16M
+  XIP_VMA_RW   (W)  : ORIGIN = (PAGE_OFFSET + TEXT_OFFSET) LENGTH = 16M
+  XIP_VMA_VEC  (RX) : ORIGIN = 0 LENGTH = 4K
+  XIP_VMA_STUB (RX) : ORIGIN = 4K LENGTH = 4K
+
+  XIP_LMA_RO   (RX) : ORIGIN = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR) LENGTH = 32M
+}
+#define REGION_VEC_VMA  >XIP_VMA_VEC
+#define REGION_STUB_VMA >XIP_VMA_STUB
+#define REGION_RO_VMA   >XIP_VMA_RO
+#define REGION_RO_LMA AT>XIP_LMA_RO
+#define REGION_RW_VMA   >XIP_VMA_RW
+#else
+MEMORY
+{
+  VMA (ra) : ORIGIN = (PAGE_OFFSET + TEXT_OFFSET) LENGTH = 1024M
+  VMA_VEC : ORIGIN = 0 LENGTH = 4K
+  VMA_STUB : ORIGIN = 4K LENGTH = 4K
+}
+#define REGION_VEC_VMA  >VMA_VEC
+#define REGION_STUB_VMA >VMA_STUB
+#define REGION_RO_VMA   >VMA
+#define REGION_RO_LMA   AT>VMA
+#define REGION_RW_VMA   >VMA
+#endif
+
 SECTIONS
 {
 	/*
@@ -92,7 +129,7 @@ SECTIONS
 	.head.text : {
 		_text = .;
 		HEAD_TEXT
-	}
+	} REGION_RO_VMA REGION_RO_LMA
 
 #ifdef CONFIG_ARM_KERNMEM_PERMS
 	. = ALIGN(1<<SECTION_SHIFT);
@@ -118,21 +155,25 @@ SECTIONS
 		. = ALIGN(4);
 		*(.got)			/* Global offset table		*/
 			ARM_CPU_KEEP(PROC_INFO)
-	}
+	} REGION_RO_VMA REGION_RO_LMA
 
 #ifdef CONFIG_DEBUG_RODATA
+	/*
+	 * If we want to ensure that data sections can't be executed,
+	 * we need a section boundary@the end of the .text section.
+	 */
 	. = ALIGN(1<<SECTION_SHIFT);
 #endif
 	RO_DATA(PAGE_SIZE)
 
 	. = ALIGN(4);
-	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
+	__ex_table : {
 		__start___ex_table = .;
 #ifdef CONFIG_MMU
 		*(__ex_table)
 #endif
 		__stop___ex_table = .;
-	}
+	} REGION_RO_VMA REGION_RO_LMA
 
 #ifdef CONFIG_ARM_UNWIND
 	/*
@@ -143,15 +184,19 @@ SECTIONS
 		__start_unwind_idx = .;
 		*(.ARM.exidx*)
 		__stop_unwind_idx = .;
-	}
+	} REGION_RO_VMA REGION_RO_LMA
 	.ARM.unwind_tab : {
 		__start_unwind_tab = .;
 		*(.ARM.extab*)
 		__stop_unwind_tab = .;
-	}
+	} REGION_RO_VMA REGION_RO_LMA
 #endif
 
-	NOTES
+	.notes : {
+		__start_notes = .;
+		*(.note.*)
+		__stop_notes = .;
+	} REGION_RO_VMA REGION_RO_LMA
 
 	_etext = .;			/* End of text and rodata section */
 
@@ -168,66 +213,67 @@ SECTIONS
 	 * only thing that matters is their relative offsets
 	 */
 	__vectors_start = .;
-	.vectors 0 : AT(__vectors_start) {
+	.vectors : {
 		*(.vectors)
-	}
+	} REGION_VEC_VMA REGION_RO_LMA
 	. = __vectors_start + SIZEOF(.vectors);
 	__vectors_end = .;
 
 	__stubs_start = .;
-	.stubs 0x1000 : AT(__stubs_start) {
+	.stubs : {
 		*(.stubs)
-	}
+	} REGION_STUB_VMA REGION_RO_LMA
 	. = __stubs_start + SIZEOF(.stubs);
 	__stubs_end = .;
 
 	INIT_TEXT_SECTION(8)
 	.exit.text : {
 		ARM_EXIT_KEEP(EXIT_TEXT)
-	}
+	} REGION_RO_VMA REGION_RO_LMA
 	.init.proc.info : {
 		ARM_CPU_DISCARD(PROC_INFO)
-	}
+	} REGION_RO_VMA REGION_RO_LMA
 	.init.arch.info : {
 		__arch_info_begin = .;
 		*(.arch.info.init)
 		__arch_info_end = .;
-	}
+	} REGION_RO_VMA REGION_RO_LMA
 	.init.tagtable : {
 		__tagtable_begin = .;
 		*(.taglist.init)
 		__tagtable_end = .;
-	}
+	} REGION_RO_VMA REGION_RO_LMA
 #ifdef CONFIG_SMP_ON_UP
 	.init.smpalt : {
 		__smpalt_begin = .;
 		*(.alt.smp.init)
 		__smpalt_end = .;
-	}
+	} REGION_RO_VMA REGION_RO_LMA
 #endif
 	.init.pv_table : {
 		__pv_table_begin = .;
 		*(.pv_table)
 		__pv_table_end = .;
-	}
-	.init.data : {
-#ifndef CONFIG_XIP_KERNEL
-		INIT_DATA
-#endif
+	} REGION_RO_VMA REGION_RO_LMA
+	.init.const.data : {
 		INIT_SETUP(16)
 		INIT_CALLS
 		CON_INITCALL
 		SECURITY_INITCALL
 		INIT_RAM_FS
-	}
+	} REGION_RO_VMA REGION_RO_LMA
+
+#ifdef CONFIG_SMP
+	PERCPU_SECTION(L1_CACHE_BYTES) REGION_RO_VMA
+#endif
+
 #ifndef CONFIG_XIP_KERNEL
+	.init.data : {
+		INIT_DATA
+	} REGION_RW_VMA
 	.exit.data : {
 		ARM_EXIT_KEEP(EXIT_DATA)
-	}
-#endif
-
-#ifdef CONFIG_SMP
-	PERCPU_SECTION(L1_CACHE_BYTES)
+	} REGION_RW_VMA
 #endif
 
 #ifdef CONFIG_XIP_KERNEL
@@ -273,7 +319,7 @@ SECTIONS
 		CONSTRUCTORS
 
 		_edata = .;
-	}
+	} REGION_RW_VMA
 	_edata_loc = __data_loc + SIZEOF(.data);
 
 #ifdef CONFIG_HAVE_TCM
@@ -359,5 +405,5 @@ ASSERT(((__hyp_idmap_text_end - __hyp_idmap_text_start) <= PAGE_SIZE), "HYP init
  * data section.  Since the .text section starts in module space, and that
  * is always below the .data section, this should be sufficient.
  */
-ASSERT((_data >= __data_loc), "Text section oversize")
+/*ASSERT((_data >= __data_loc), "Text section oversize") */
 #endif
 

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
