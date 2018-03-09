From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu,  8 Mar 2018 22:20:56 -0500
Subject: [PATCH 3/7] ARM: linker script: factor out stuff for the .text section
In-Reply-To: <20180309032100.31039-1-nicolas.pitre@linaro.org>
References: <20180309032100.31039-1-nicolas.pitre@linaro.org>
Message-ID: <20180309032100.31039-4-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move common entries to vmlinux.lds.h as ARM_TEXT.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/vmlinux-xip.lds.S | 19 +------------------
 arch/arm/kernel/vmlinux.lds.S     | 19 +------------------
 arch/arm/kernel/vmlinux.lds.h     | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 4bd422966d..4ddb547b19 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -53,24 +53,7 @@ SECTIONS
 
 	.text : {			/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
-			IDMAP_TEXT
-			__entry_text_start = .;
-			*(.entry.text)
-			__entry_text_end = .;
-			IRQENTRY_TEXT
-			SOFTIRQENTRY_TEXT
-			TEXT_TEXT
-			SCHED_TEXT
-			CPUIDLE_TEXT
-			LOCK_TEXT
-			HYPERVISOR_TEXT
-			KPROBES_TEXT
-			*(.gnu.warning)
-			*(.glue_7)
-			*(.glue_7t)
-		. = ALIGN(4);
-		*(.got)			/* Global offset table		*/
-			ARM_CPU_KEEP(PROC_INFO)
+		ARM_TEXT
 	}
 
 	RO_DATA(PAGE_SIZE)
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b34fbafd54..a02a96c651 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -56,24 +56,7 @@ SECTIONS
 
 	.text : {			/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
-			IDMAP_TEXT
-			__entry_text_start = .;
-			*(.entry.text)
-			__entry_text_end = .;
-			IRQENTRY_TEXT
-			SOFTIRQENTRY_TEXT
-			TEXT_TEXT
-			SCHED_TEXT
-			CPUIDLE_TEXT
-			LOCK_TEXT
-			HYPERVISOR_TEXT
-			KPROBES_TEXT
-			*(.gnu.warning)
-			*(.glue_7)
-			*(.glue_7t)
-		. = ALIGN(4);
-		*(.got)			/* Global offset table		*/
-			ARM_CPU_KEEP(PROC_INFO)
+		ARM_TEXT
 	}
 
 #ifdef CONFIG_DEBUG_ALIGN_RODATA
diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
index 1258b66487..0ef86d75a0 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/kernel/vmlinux.lds.h
@@ -58,3 +58,23 @@
 		ARM_MMU_DISCARD(*(__ex_table))				\
 		*(.discard)						\
 		*(.discard.*)
+
+#define ARM_TEXT							\
+		IDMAP_TEXT						\
+		__entry_text_start = .;					\
+		*(.entry.text)						\
+		__entry_text_end = .;					\
+		IRQENTRY_TEXT						\
+		SOFTIRQENTRY_TEXT					\
+		TEXT_TEXT						\
+		SCHED_TEXT						\
+		CPUIDLE_TEXT						\
+		LOCK_TEXT						\
+		HYPERVISOR_TEXT						\
+		KPROBES_TEXT						\
+		*(.gnu.warning)						\
+		*(.glue_7)						\
+		*(.glue_7t)						\
+		. = ALIGN(4);						\
+		*(.got)			/* Global offset table */	\
+		ARM_CPU_KEEP(PROC_INFO)
-- 
2.14.3
