From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu,  8 Mar 2018 22:20:55 -0500
Subject: [PATCH 2/7] ARM: linker script: factor out stuff for the DISCARD
 section
In-Reply-To: <20180309032100.31039-1-nicolas.pitre@linaro.org>
References: <20180309032100.31039-1-nicolas.pitre@linaro.org>
Message-ID: <20180309032100.31039-3-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move common entries to vmlinux.lds.h and leave XIP and non-XIP entries
in their respective file. The ARM_NOMMU_KEEP() and ARM_NOMMU_DISCARD()
macros are added to be usable within the definition of ARM_DISCARD macro.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/vmlinux-xip.lds.S | 19 +++----------------
 arch/arm/kernel/vmlinux.lds.S     | 18 ++----------------
 arch/arm/kernel/vmlinux.lds.h     | 20 ++++++++++++++++++++
 3 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 0a8922b616..4bd422966d 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -38,20 +38,9 @@ SECTIONS
 	 * unwind sections get included.
 	 */
 	/DISCARD/ : {
-		*(.ARM.exidx.exit.text)
-		*(.ARM.extab.exit.text)
-		ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))
-		ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))
-		ARM_EXIT_DISCARD(EXIT_TEXT)
-		ARM_EXIT_DISCARD(EXIT_DATA)
-		EXIT_CALL
-#ifndef CONFIG_MMU
-		*(.text.fixup)
-		*(__ex_table)
-#endif
+		ARM_DISCARD
 		*(.alt.smp.init)
-		*(.discard)
-		*(.discard.*)
+		*(.pv_table)
 	}
 
 	. = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
@@ -89,9 +78,7 @@ SECTIONS
 	. = ALIGN(4);
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
 		__start___ex_table = .;
-#ifdef CONFIG_MMU
-		*(__ex_table)
-#endif
+		ARM_MMU_KEEP(*(__ex_table))
 		__stop___ex_table = .;
 	}
 
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 6a6eb483d9..b34fbafd54 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -38,22 +38,10 @@ SECTIONS
 	 * unwind sections get included.
 	 */
 	/DISCARD/ : {
-		*(.ARM.exidx.exit.text)
-		*(.ARM.extab.exit.text)
-		ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))
-		ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))
-		ARM_EXIT_DISCARD(EXIT_TEXT)
-		ARM_EXIT_DISCARD(EXIT_DATA)
-		EXIT_CALL
-#ifndef CONFIG_MMU
-		*(.text.fixup)
-		*(__ex_table)
-#endif
+		ARM_DISCARD
 #ifndef CONFIG_SMP_ON_UP
 		*(.alt.smp.init)
 #endif
-		*(.discard)
-		*(.discard.*)
 	}
 
 	. = PAGE_OFFSET + TEXT_OFFSET;
@@ -98,9 +86,7 @@ SECTIONS
 	. = ALIGN(4);
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
 		__start___ex_table = .;
-#ifdef CONFIG_MMU
-		*(__ex_table)
-#endif
+		ARM_MMU_KEEP(*(__ex_table))
 		__stop___ex_table = .;
 	}
 
diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
index 0a86e8a111..1258b66487 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/kernel/vmlinux.lds.h
@@ -17,6 +17,14 @@
 #define ARM_EXIT_DISCARD(x)	x
 #endif
 
+#ifdef CONFIG_MMU
+#define ARM_MMU_KEEP(x)		x
+#define ARM_MMU_DISCARD(x)
+#else
+#define ARM_MMU_KEEP(x)
+#define ARM_MMU_DISCARD(x)	x
+#endif
+
 #define PROC_INFO							\
 		. = ALIGN(4);						\
 		VMLINUX_SYMBOL(__proc_info_begin) = .;			\
@@ -38,3 +46,15 @@
 		*(.hyp.idmap.text)					\
 		VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
 
+#define ARM_DISCARD							\
+		*(.ARM.exidx.exit.text)					\
+		*(.ARM.extab.exit.text)					\
+		ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))		\
+		ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))		\
+		ARM_EXIT_DISCARD(EXIT_TEXT)				\
+		ARM_EXIT_DISCARD(EXIT_DATA)				\
+		EXIT_CALL						\
+		ARM_MMU_DISCARD(*(.text.fixup))				\
+		ARM_MMU_DISCARD(*(__ex_table))				\
+		*(.discard)						\
+		*(.discard.*)
-- 
2.14.3
