From: monstr@monstr.eu (Michal Simek)
Date: Mon, 18 Jun 2012 13:30:10 +0200
Subject: [RFC PATCH 7/8] ARM: vmlinux.lds: Setup physical load address not
 virtual
In-Reply-To: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
Message-ID: <1340019011-18642-8-git-send-email-monstr@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup correct virtual and physical address in ELF LOAD section.

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 arch/arm/include/asm/page.h   |    2 ++
 arch/arm/kernel/vmlinux.lds.S |   28 ++++++++++++++--------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index ecf9019..4070209 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -15,6 +15,8 @@
 #define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
 #define PAGE_MASK		(~(PAGE_SIZE-1))
 
+#define LOAD_OFFSET	(CONFIG_PAGE_OFFSET - CONFIG_PHYS_OFFSET)
+
 #ifndef __ASSEMBLY__
 
 #ifndef CONFIG_MMU
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index c887be0..b996bc0 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -3,11 +3,11 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
  */
 
+#include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
-#include <asm/page.h>
 	
 #define PROC_INFO							\
 	. = ALIGN(4);							\
@@ -86,11 +86,11 @@ SECTIONS
 #else
 	. = PAGE_OFFSET + TEXT_OFFSET;
 #endif
-	.head.text : {
+	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
 		_text = .;
 		HEAD_TEXT
 	}
-	.text : {			/* Real text segment		*/
+	.text : AT(ADDR(.text) - LOAD_OFFSET){	/* Real text segment	*/
 		_stext = .;		/* Text and read-only data	*/
 			__exception_text_start = .;
 			*(.exception.text)
@@ -132,12 +132,12 @@ SECTIONS
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
@@ -152,35 +152,35 @@ SECTIONS
 #endif
 
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
@@ -191,7 +191,7 @@ SECTIONS
 		INIT_RAM_FS
 	}
 #ifndef CONFIG_XIP_KERNEL
-	.exit.data : {
+	.exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET) {
 		ARM_EXIT_KEEP(EXIT_DATA)
 	}
 #endif
@@ -207,7 +207,7 @@ SECTIONS
 	__data_loc = .;
 #endif
 
-	.data : AT(__data_loc) {
+	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		_data = .;		/* address in memory */
 		_sdata = .;
 
-- 
1.7.0.4
