From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 26 Feb 2015 15:29:06 +0000
Subject: [RFC PATCH 2/3] arm64: make ID map shareable with EL2
In-Reply-To: <1424964547-2118-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1424964547-2118-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1424964547-2118-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changes the ID map creation in head.S so that it can be reused
by KVM to ID map the HYP init code in EL2.

Since the architecture defines the AP[1] bit as RES1 in page table entries
used at EL2, we must ensure that the HYP init code is mapped with the AP[1]
bit set. However, AP[1] means 'writable at EL0' when set at EL1, which
automatically implies PXN == 1 (rendering the entire ID map non-executable)
unless we also set AP[2], which means read-only at both EL0 and EL1.

To prevent having to make the entire ID map read-only, we split the ID map
in two regions, and only set AP[2:1] == 0b11 for the first part, that covers
the HYP .text section. Note that this also moves it to before _stext, which
removes it from the runtime executable at EL1 region. This is a nice bonus,
in fact, since this code should never be executable at EL1 anyway.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S        | 22 ++++++++++++++++++----
 arch/arm64/kernel/vmlinux.lds.S |  2 +-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index a3612eadab3c..0b3fb672640c 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -79,8 +79,10 @@
 
 #ifdef CONFIG_ARM64_64K_PAGES
 #define MM_MMUFLAGS	PTE_ATTRINDX(MT_NORMAL) | PTE_FLAGS
+#define MM_MMUFLAGS_HYP	MM_MMUFLAGS | PTE_HYP | PTE_RDONLY
 #else
 #define MM_MMUFLAGS	PMD_ATTRINDX(MT_NORMAL) | PMD_FLAGS
+#define MM_MMUFLAGS_HYP	MM_MMUFLAGS | PMD_HYP | PMD_SECT_RDONLY
 #endif
 
 /*
@@ -379,8 +381,6 @@ __create_page_tables:
 	cmp	x0, x6
 	b.lo	1b
 
-	ldr	x7, =MM_MMUFLAGS
-
 	/*
 	 * Create the identity mapping.
 	 */
@@ -426,9 +426,23 @@ __create_page_tables:
 #endif
 
 	create_pgd_entry x0, x3, x5, x6
-	ldr	x6, =KERNEL_END
+
+	/*
+	 * Map the first region -which also contains the HYP text sections- with
+	 * HYP compatible attributes, so that we can share the ID map with KVM.
+	 */
+	ldr	x7, =MM_MMUFLAGS_HYP
+	adrp	x6, _stext			// __pa(_stext)
 	mov	x5, x3				// __pa(KERNEL_START)
-	add	x6, x6, x28			// __pa(KERNEL_END)
+	create_block_map x0, x7, x3, x5, x6
+
+	/*
+	 * Map everything else with the default attributes.
+	 */
+	ldr	x7, =MM_MMUFLAGS
+	adrp	x3, (_stext + BLOCK_SIZE - 1)	// next block after _stext
+	adrp	x6, KERNEL_END
+	mov	x5, x3
 	create_block_map x0, x7, x3, x5, x6
 
 	/*
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 17383c257a7d..4874ebca4b3e 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -83,6 +83,7 @@ SECTIONS
 	.head.text : {
 		_text = .;
 		HEAD_TEXT
+		HYPERVISOR_TEXT
 	}
 	ALIGN_DEBUG_RO
 	.text : {			/* Real text segment		*/
@@ -94,7 +95,6 @@ SECTIONS
 			TEXT_TEXT
 			SCHED_TEXT
 			LOCK_TEXT
-			HYPERVISOR_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 		. = ALIGN(16);
-- 
1.8.3.2
