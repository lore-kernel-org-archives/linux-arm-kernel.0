From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 06 Nov 2018 13:40:14 +0000
Subject: [PATCH 2/4] ARM: mark critical data with KEEP()
In-Reply-To: <20181106133935.GB30658@n2100.armlinux.org.uk>
References: <20181106133935.GB30658@n2100.armlinux.org.uk>
Message-ID: <E1gK1aY-0000ob-RQ@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for GC sections to work correctly, we need to instruct the
linker to emit all input sections for entry paths and some linker
built tables.

Ensure that the vectors, tag table, CPU table, machine platform table,
and exception tables are kept.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/vmlinux.lds.S | 10 +++++-----
 arch/arm/kernel/vmlinux.lds.h | 18 +++++++++---------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 23150c0f0f4d..3da8db076761 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -73,7 +73,7 @@ SECTIONS
 	. = ALIGN(4);
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
 		__start___ex_table = .;
-		ARM_MMU_KEEP(*(__ex_table))
+		ARM_MMU_KEEP(KEEP(*(__ex_table)))
 		__stop___ex_table = .;
 	}
 
@@ -100,24 +100,24 @@ SECTIONS
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
 
diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
index 8247bc15addc..a83d017f531c 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/kernel/vmlinux.lds.h
@@ -28,22 +28,22 @@
 #define PROC_INFO							\
 		. = ALIGN(4);						\
 		__proc_info_begin = .;					\
-		*(.proc.info.init)					\
+		KEEP(*(.proc.info.init))				\
 		__proc_info_end = .;
 
 #define HYPERVISOR_TEXT							\
 		__hyp_text_start = .;					\
-		*(.hyp.text)						\
+		KEEP(*(.hyp.text))					\
 		__hyp_text_end = .;
 
 #define IDMAP_TEXT							\
 		ALIGN_FUNCTION();					\
 		__idmap_text_start = .;					\
-		*(.idmap.text)						\
+		KEEP(*(.idmap.text))					\
 		__idmap_text_end = .;					\
 		. = ALIGN(PAGE_SIZE);					\
 		__hyp_idmap_text_start = .;				\
-		*(.hyp.idmap.text)					\
+		KEEP(*(.hyp.idmap.text))				\
 		__hyp_idmap_text_end = .;
 
 #define ARM_DISCARD							\
@@ -64,7 +64,7 @@
 #define ARM_TEXT							\
 		IDMAP_TEXT						\
 		__entry_text_start = .;					\
-		*(.entry.text)						\
+		KEEP(*(.entry.text))					\
 		__entry_text_end = .;					\
 		IRQENTRY_TEXT						\
 		SOFTIRQENTRY_TEXT					\
@@ -86,12 +86,12 @@
 	. = ALIGN(8);							\
 	.ARM.unwind_idx : {						\
 		__start_unwind_idx = .;					\
-		*(.ARM.exidx*)						\
+		KEEP(*(.ARM.exidx*))					\
 		__stop_unwind_idx = .;					\
 	}								\
 	.ARM.unwind_tab : {						\
 		__start_unwind_tab = .;					\
-		*(.ARM.extab*)						\
+		KEEP(*(.ARM.extab*))					\
 		__stop_unwind_tab = .;					\
 	}
 
@@ -102,14 +102,14 @@
 #define ARM_VECTORS							\
 	__vectors_start = .;						\
 	.vectors 0xffff0000 : AT(__vectors_start) {			\
-		*(.vectors)						\
+		KEEP(*(.vectors))					\
 	}								\
 	. = __vectors_start + SIZEOF(.vectors);				\
 	__vectors_end = .;						\
 									\
 	__stubs_start = .;						\
 	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_start) {		\
-		*(.stubs)						\
+		KEEP(*(.stubs))						\
 	}								\
 	. = __stubs_start + SIZEOF(.stubs);				\
 	__stubs_end = .;						\
-- 
2.7.4
