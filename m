From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 06 Jul 2011 11:24:50 +0100
Subject: [PATCH 6/7] ARM: vmlinux.lds: move init sections between text and
	data sections
In-Reply-To: <20110706102245.GO8286@n2100.arm.linux.org.uk>
References: <20110706102245.GO8286@n2100.arm.linux.org.uk>
Message-ID: <E1QePHm-0004zv-O0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Place the init sections between the text and data sections.  This
means all code is grouped together at the beginning of the kernel
image, and all data is at the end of the image.  This avoids problems
with the 24-bit branch instruction relocations becoming invalid with
large initramfs images.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/vmlinux.lds.S |   96 ++++++++++++++++++++--------------------
 arch/arm/mm/init.c            |    4 +-
 2 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index fa812d0..18574b7 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -69,6 +69,53 @@ SECTIONS
 		_stext = .;
 		HEAD_TEXT
 	}
+	.text : {			/* Real text segment		*/
+		_text = .;		/* Text and read-only data	*/
+			__exception_text_start = .;
+			*(.exception.text)
+			__exception_text_end = .;
+			IRQENTRY_TEXT
+			TEXT_TEXT
+			SCHED_TEXT
+			LOCK_TEXT
+			KPROBES_TEXT
+#ifdef CONFIG_MMU
+			*(.fixup)
+#endif
+			*(.gnu.warning)
+			*(.glue_7)
+			*(.glue_7t)
+		. = ALIGN(4);
+		*(.got)			/* Global offset table		*/
+			ARM_CPU_KEEP(PROC_INFO)
+	}
+
+	RO_DATA(PAGE_SIZE)
+
+#ifdef CONFIG_ARM_UNWIND
+	/*
+	 * Stack unwinding tables
+	 */
+	. = ALIGN(8);
+	.ARM.unwind_idx : {
+		__start_unwind_idx = .;
+		*(.ARM.exidx*)
+		__stop_unwind_idx = .;
+	}
+	.ARM.unwind_tab : {
+		__start_unwind_tab = .;
+		*(.ARM.extab*)
+		__stop_unwind_tab = .;
+	}
+#endif
+
+	_etext = .;			/* End of text and rodata section */
+
+#ifndef CONFIG_XIP_KERNEL
+	. = ALIGN(PAGE_SIZE);
+	__init_begin = .;
+#endif
+
 	INIT_TEXT_SECTION(8)
 	.exit.text : {
 		ARM_EXIT_KEEP(EXIT_TEXT)
@@ -116,58 +163,11 @@ SECTIONS
 
 	PERCPU_SECTION(32)
 
-#ifndef CONFIG_XIP_KERNEL
-	__init_begin = _stext;
-	. = ALIGN(PAGE_SIZE);
-	__init_end = .;
-#endif
-
-	.text : {			/* Real text segment		*/
-		_text = .;		/* Text and read-only data	*/
-			__exception_text_start = .;
-			*(.exception.text)
-			__exception_text_end = .;
-			IRQENTRY_TEXT
-			TEXT_TEXT
-			SCHED_TEXT
-			LOCK_TEXT
-			KPROBES_TEXT
-#ifdef CONFIG_MMU
-			*(.fixup)
-#endif
-			*(.gnu.warning)
-			*(.glue_7)
-			*(.glue_7t)
-		. = ALIGN(4);
-		*(.got)			/* Global offset table		*/
-			ARM_CPU_KEEP(PROC_INFO)
-	}
-
-	RO_DATA(PAGE_SIZE)
-
-#ifdef CONFIG_ARM_UNWIND
-	/*
-	 * Stack unwinding tables
-	 */
-	. = ALIGN(8);
-	.ARM.unwind_idx : {
-		__start_unwind_idx = .;
-		*(.ARM.exidx*)
-		__stop_unwind_idx = .;
-	}
-	.ARM.unwind_tab : {
-		__start_unwind_tab = .;
-		*(.ARM.extab*)
-		__stop_unwind_tab = .;
-	}
-#endif
-
-	_etext = .;			/* End of text and rodata section */
-
 #ifdef CONFIG_XIP_KERNEL
 	__data_loc = ALIGN(4);		/* location in binary */
 	. = PAGE_OFFSET + TEXT_OFFSET;
 #else
+	__init_end = .;
 	. = ALIGN(THREAD_SIZE);
 	__data_loc = .;
 #endif
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index c19571c..b8e8912 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -639,8 +639,8 @@ void __init mem_init(void)
 			"    pkmap   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
 #endif
 			"    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-			"      .init : 0x%p" " - 0x%p" "   (%4d kB)\n"
 			"      .text : 0x%p" " - 0x%p" "   (%4d kB)\n"
+			"      .init : 0x%p" " - 0x%p" "   (%4d kB)\n"
 			"      .data : 0x%p" " - 0x%p" "   (%4d kB)\n"
 			"       .bss : 0x%p" " - 0x%p" "   (%4d kB)\n",
 
@@ -662,8 +662,8 @@ void __init mem_init(void)
 #endif
 			MLM(MODULES_VADDR, MODULES_END),
 
-			MLK_ROUNDUP(__init_begin, __init_end),
 			MLK_ROUNDUP(_text, _etext),
+			MLK_ROUNDUP(__init_begin, __init_end),
 			MLK_ROUNDUP(_sdata, _edata),
 			MLK_ROUNDUP(__bss_start, __bss_stop));
 
-- 
1.7.4.4
