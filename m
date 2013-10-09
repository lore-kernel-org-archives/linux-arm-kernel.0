From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue,  8 Oct 2013 18:31:30 -0700
Subject: [RFC PATCH 3/5] arm: align init, text,
 rodata to PMD_SIZE if CONFIG_STRICT_MEMORY_RWX is set
In-Reply-To: <1381282292-25251-1-git-send-email-lauraa@codeaurora.org>
References: <1381282292-25251-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1381282292-25251-4-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Larry Bassel <lbassel@codeaurora.org>

Init code, text, rodata and data need different permissions
and so they need to be on different pages. The kernel 1-to-1
mapping is constructed using section size pages to improve
TLB performance and this should not be changed (to 4K pages).
Therefore ensure that each of these regions starts on a PMD_SIZE
boundary. SECTION_SIZE is not enough as everything is mapped first
and then cleared later and remapped.

Signed-off-by: Larry Bassel <lbassel@codeaurora.org>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/kernel/vmlinux.lds.S |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 7bcee5c..c06e915 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -8,6 +8,9 @@
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/page.h>
+#ifdef CONFIG_STRICT_MEMORY_RWX
+#include <asm/pgtable.h>
+#endif
 	
 #define PROC_INFO							\
 	. = ALIGN(4);							\
@@ -90,6 +93,9 @@ SECTIONS
 		_text = .;
 		HEAD_TEXT
 	}
+#ifdef CONFIG_STRICT_MEMORY_RWX
+	. = ALIGN(1<<PMD_SHIFT);
+#endif
 	.text : {			/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
 			__exception_text_start = .;
@@ -112,6 +118,9 @@ SECTIONS
 			ARM_CPU_KEEP(PROC_INFO)
 	}
 
+#ifdef CONFIG_STRICT_MEMORY_RWX
+	. = ALIGN(1<<PMD_SHIFT);
+#endif
 	RO_DATA(PAGE_SIZE)
 
 	. = ALIGN(4);
@@ -145,7 +154,11 @@ SECTIONS
 	_etext = .;			/* End of text and rodata section */
 
 #ifndef CONFIG_XIP_KERNEL
+#ifdef CONFIG_STRICT_MEMORY_RWX
+	. = ALIGN(1<<PMD_SHIFT);
+#else
 	. = ALIGN(PAGE_SIZE);
+#endif
 	__init_begin = .;
 #endif
 	/*
@@ -173,6 +186,9 @@ SECTIONS
 	.init.proc.info : {
 		ARM_CPU_DISCARD(PROC_INFO)
 	}
+#ifdef CONFIG_STRICT_MEMORY_RWX
+	. = ALIGN(1<<PMD_SHIFT);
+#endif
 	.init.arch.info : {
 		__arch_info_begin = .;
 		*(.arch.info.init)
@@ -219,8 +235,12 @@ SECTIONS
 	__data_loc = ALIGN(4);		/* location in binary */
 	. = PAGE_OFFSET + TEXT_OFFSET;
 #else
-	__init_end = .;
+#ifdef CONFIG_STRICT_MEMORY_RWX
+	. = ALIGN(1<<PMD_SHIFT);
+#else
 	. = ALIGN(THREAD_SIZE);
+#endif
+	__init_end = .;
 	__data_loc = .;
 #endif
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
