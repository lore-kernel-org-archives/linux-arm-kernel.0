From: tabbott@ksplice.com (Tim Abbott)
Date: Wed, 30 Sep 2009 17:25:35 -0400
Subject: [PATCH 2/2] arm: Clean up linker script using new linker script
	macros.
In-Reply-To: <1254345935-15958-1-git-send-email-tabbott@ksplice.com>
References: <1254345935-15958-1-git-send-email-tabbott@ksplice.com>
Message-ID: <1254345935-15958-3-git-send-email-tabbott@ksplice.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nelson Elhage <nelhage@ksplice.com>

This patch is mostly a straightforward translation. The primary side
effect to the resulting vmlinux should be to increase the alignment on
the initramfs to the standard PAGE_SIZE from 32 bytes.

Signed-off-by: Nelson Elhage <nelhage@ksplice.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tim Abbott <tabbott@ksplice.com>
---
 arch/arm/kernel/vmlinux.lds.S |   75 +++++++++++-----------------------------
 1 files changed, 21 insertions(+), 54 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 0902f80..d5bc5be 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -40,43 +40,31 @@ SECTIONS
 		__tagtable_begin = .;
 			*(.taglist.init)
 		__tagtable_end = .;
-		. = ALIGN(16);
-		__setup_start = .;
-			*(.init.setup)
-		__setup_end = .;
+
+		INIT_SETUP(16)
+
 		__early_begin = .;
 			*(.early_param.init)
 		__early_end = .;
-		__initcall_start = .;
-			INITCALLS
-		__initcall_end = .;
-		__con_initcall_start = .;
-			*(.con_initcall.init)
-		__con_initcall_end = .;
-		__security_initcall_start = .;
-			*(.security_initcall.init)
-		__security_initcall_end = .;
-#ifdef CONFIG_BLK_DEV_INITRD
-		. = ALIGN(32);
-		__initramfs_start = .;
-			usr/built-in.o(.init.ramfs)
-		__initramfs_end = .;
-#endif
-		. = ALIGN(PAGE_SIZE);
-		__per_cpu_load = .;
-		__per_cpu_start = .;
-			*(.data.percpu.page_aligned)
-			*(.data.percpu)
-			*(.data.percpu.shared_aligned)
-		__per_cpu_end = .;
+
+		INIT_CALLS
+		CON_INITCALL
+		SECURITY_INITCALL
+		INIT_RAM_FS
+
 #ifndef CONFIG_XIP_KERNEL
 		__init_begin = _stext;
 		INIT_DATA
-		. = ALIGN(PAGE_SIZE);
-		__init_end = .;
 #endif
 	}
 
+	PERCPU(PAGE_SIZE)
+
+#ifndef CONFIG_XIP_KERNEL
+	. = ALIGN(PAGE_SIZE);
+	__init_end = .;
+#endif
+
 	/DISCARD/ : {			/* Exit code and data		*/
 		EXIT_TEXT
 		EXIT_DATA
@@ -155,7 +143,7 @@ SECTIONS
 		 * first, the init task union, aligned
 		 * to an 8192 byte boundary.
 		 */
-		*(.data.init_task)
+		INIT_TASK_DATA(THREAD_SIZE)
 
 #ifdef CONFIG_XIP_KERNEL
 		. = ALIGN(PAGE_SIZE);
@@ -165,17 +153,8 @@ SECTIONS
 		__init_end = .;
 #endif
 
-		. = ALIGN(PAGE_SIZE);
-		__nosave_begin = .;
-		*(.data.nosave)
-		. = ALIGN(PAGE_SIZE);
-		__nosave_end = .;
-
-		/*
-		 * then the cacheline aligned data
-		 */
-		. = ALIGN(32);
-		*(.data.cacheline_aligned)
+		NOSAVE_DATA
+		CACHELINE_ALIGNED_DATA(32)
 
 		/*
 		 * The exception fixup table (might need resorting at runtime)
@@ -254,20 +233,8 @@ SECTIONS
 	}
 #endif
 
-	.bss : {
-		__bss_start = .;	/* BSS				*/
-		*(.bss)
-		*(COMMON)
-		__bss_stop = .;
-		_end = .;
-	}
-					/* Stabs debugging sections.	*/
-	.stab 0 : { *(.stab) }
-	.stabstr 0 : { *(.stabstr) }
-	.stab.excl 0 : { *(.stab.excl) }
-	.stab.exclstr 0 : { *(.stab.exclstr) }
-	.stab.index 0 : { *(.stab.index) }
-	.stab.indexstr 0 : { *(.stab.indexstr) }
+	BSS_SECTION(0, 0, 0)
+	STABS_DEBUG
 	.comment 0 : { *(.comment) }
 }
 
-- 
1.6.3.3
