From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Mar 2017 17:50:00 +0100
Subject: [PATCH] [EXPERIMENTAL,
 v2] enable thin archives and --gc-sections on ARM
Message-ID: <20170315165109.3451216-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm still build testing with an experimental change to enable
thin architeves and --gc-sections on ARM, which should bring
multiple benefits

- improve build times
- allow 'allyesconfig' to succeed without exceeding the
  section size when linking drivers/built-in.o
- reduce the kernel image size

However, I have now run into a build error binutils commit
f02cb05 ("Always descend into output section statements in
lang_do_assignments") in binutils-2.28 and later:

   no __ex_table in  file: vmlinux

Any idea what's going wrong here?

Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Alan Modra <amodra@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                  |  2 ++
 arch/arm/kernel/Makefile          |  3 +++
 arch/arm/kernel/vmlinux-xip.lds.S | 32 +++++++++++++++++++++-----------
 arch/arm/kernel/vmlinux.lds.S     | 22 ++++++++++++++++------
 4 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 27e738b82e45..333a1f685abb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -89,6 +89,7 @@ config ARM
 	select HAVE_UID16
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_FORCED_THREADING
+	select LD_DEAD_CODE_DATA_ELIMINATION
 	select MODULES_USE_ELF_REL
 	select NO_BOOTMEM
 	select OF_EARLY_FLATTREE if OF
@@ -98,6 +99,7 @@ config ARM
 	select PERF_USE_VMALLOC
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
+	select THIN_ARCHIVES
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
 	help
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index d1b06cd79b23..469b78f5f529 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -13,6 +13,9 @@ endif
 
 CFLAGS_REMOVE_return_address.o = -pg
 
+ccflags-y              += -fno-function-sections -fno-data-sections
+subdir-ccflags-y       += -fno-function-sections -fno-data-sections
+
 # Object file lists.
 
 obj-y		:= elf.o entry-common.o irq.o opcodes.o \
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 2e5b5f0dbadf..bf900f5421a1 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -18,17 +18,17 @@
 #define PROC_INFO							\
 	. = ALIGN(4);							\
 	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
-	*(.proc.info.init)						\
+	KEEP(*(.proc.info.init))					\
 	VMLINUX_SYMBOL(__proc_info_end) = .;
 
 #define IDMAP_TEXT							\
 	ALIGN_FUNCTION();						\
 	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
-	*(.idmap.text)							\
+	KEEP(*(.idmap.text))						\
 	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
 	. = ALIGN(PAGE_SIZE);						\
 	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;			\
-	*(.hyp.idmap.text)						\
+	KEEP(*(.hyp.idmap.text))					\
 	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -48,6 +48,16 @@
 #define ARM_EXIT_DISCARD(x)	x
 #endif
 
+#undef TEXT_TEXT
+#define TEXT_TEXT							\
+		ALIGN_FUNCTION();					\
+		*(.text.hot .text.hot.*)				\
+		*(.text.unlikely .text.unlikely.*)			\
+		*(.text .text.*)					\
+		*(.ref.text)						\
+	MEM_KEEP(init.text)						\
+	MEM_KEEP(exit.text)						\
+
 OUTPUT_ARCH(arm)
 ENTRY(stext)
 
@@ -121,7 +131,7 @@ SECTIONS
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
 		__start___ex_table = .;
 #ifdef CONFIG_MMU
-		*(__ex_table)
+		KEEP(*(__ex_table))
 #endif
 		__stop___ex_table = .;
 	}
@@ -133,12 +143,12 @@ SECTIONS
 	. = ALIGN(8);
 	.ARM.unwind_idx : {
 		__start_unwind_idx = .;
-		*(.ARM.exidx*)
+		KEEP(*(.ARM.exidx*))
 		__stop_unwind_idx = .;
 	}
 	.ARM.unwind_tab : {
 		__start_unwind_tab = .;
-		*(.ARM.extab*)
+		KEEP(*(.ARM.extab*))
 		__stop_unwind_tab = .;
 	}
 #endif
@@ -153,7 +163,7 @@ SECTIONS
 	 */
 	__vectors_start = .;
 	.vectors 0xffff0000 : AT(__vectors_start) {
-		*(.vectors)
+		KEEP(*(.vectors))
 	}
 	. = __vectors_start + SIZEOF(.vectors);
 	__vectors_end = .;
@@ -176,24 +186,24 @@ SECTIONS
 	}
 	.init.arch.info : {
 		__arch_info_begin = .;
-		*(.arch.info.init)
+		KEEP(*(.arch.info.init))
 		__arch_info_end = .;
 	}
 	.init.tagtable : {
 		__tagtable_begin = .;
-		*(.taglist.init)
+		KEEP(*(.taglist.init))
 		__tagtable_end = .;
 	}
 #ifdef CONFIG_SMP_ON_UP
 	.init.smpalt : {
 		__smpalt_begin = .;
-		*(.alt.smp.init)
+		KEEP(*(.alt.smp.init))
 		__smpalt_end = .;
 	}
 #endif
 	.init.pv_table : {
 		__pv_table_begin = .;
-		*(.pv_table)
+		KEEP(*(.pv_table))
 		__pv_table_end = .;
 	}
 	.init.data : {
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 30f04ce52dde..5f2c8c90beac 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -17,7 +17,7 @@
 #define PROC_INFO							\
 	. = ALIGN(4);							\
 	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
-	*(.proc.info.init)						\
+	KEEP(*(.proc.info.init))					\
 	VMLINUX_SYMBOL(__proc_info_end) = .;
 
 #define HYPERVISOR_TEXT							\
@@ -35,6 +35,16 @@
 	*(.hyp.idmap.text)						\
 	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
 
+#undef TEXT_TEXT
+#define TEXT_TEXT							\
+		ALIGN_FUNCTION();					\
+		*(.text.hot .text.hot.*)				\
+		*(.text.unlikely .text.unlikely.*)			\
+		*(.text .text.*)					\
+		*(.ref.text)						\
+	MEM_KEEP(init.text)						\
+	MEM_KEEP(exit.text)						\
+
 #ifdef CONFIG_HOTPLUG_CPU
 #define ARM_CPU_DISCARD(x)
 #define ARM_CPU_KEEP(x)		x
@@ -170,7 +180,7 @@ SECTIONS
 	 */
 	__vectors_start = .;
 	.vectors 0xffff0000 : AT(__vectors_start) {
-		*(.vectors)
+		KEEP(*(.vectors))
 	}
 	. = __vectors_start + SIZEOF(.vectors);
 	__vectors_end = .;
@@ -193,24 +203,24 @@ SECTIONS
 	}
 	.init.arch.info : {
 		__arch_info_begin = .;
-		*(.arch.info.init)
+		KEEP(*(.arch.info.init))
 		__arch_info_end = .;
 	}
 	.init.tagtable : {
 		__tagtable_begin = .;
-		*(.taglist.init)
+		KEEP(*(.taglist.init))
 		__tagtable_end = .;
 	}
 #ifdef CONFIG_SMP_ON_UP
 	.init.smpalt : {
 		__smpalt_begin = .;
-		*(.alt.smp.init)
+		KEEP(*(.alt.smp.init))
 		__smpalt_end = .;
 	}
 #endif
 	.init.pv_table : {
 		__pv_table_begin = .;
-		*(.pv_table)
+		KEEP(*(.pv_table))
 		__pv_table_end = .;
 	}
 	.init.data : {
-- 
2.9.0
