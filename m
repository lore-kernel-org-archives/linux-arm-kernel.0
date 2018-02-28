From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 11:56:37 +0800
Subject: [PATCH 15/29] arm64: kaslr: Put kernel vectors address in separate
 data page
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519790211-16582-16-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit 6c27c4082f4f upstream.

The literal pool entry for identifying the vectors base is the only piece
of information in the trampoline page that identifies the true location
of the kernel.

This patch moves it into a page-aligned region of the .rodata section
and maps this adjacent to the trampoline text via an additional fixmap
entry, which protects against any accidental leakage of the trampoline
contents.

Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	remove ARM64_WORKAROUND_QCOM_FALKOR_E1003 fix
	in arch/arm64/kernel/entry.S
---
 arch/arm64/include/asm/fixmap.h |  1 +
 arch/arm64/kernel/entry.S       | 13 +++++++++++++
 arch/arm64/kernel/vmlinux.lds.S |  5 ++++-
 arch/arm64/mm/mmu.c             | 10 +++++++++-
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 7b1d88c..d8e5805 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -53,6 +53,7 @@ enum fixed_addresses {
 	FIX_TEXT_POKE0,
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	FIX_ENTRY_TRAMP_DATA,
 	FIX_ENTRY_TRAMP_TEXT,
 #define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT))
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 54f35cc..996c605 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -903,7 +903,12 @@ __ni_sys_trace:
 	msr	tpidrro_el0, x30	// Restored in kernel_ventry
 	.endif
 	tramp_map_kernel	x30
+#ifdef CONFIG_RANDOMIZE_BASE
+	adr	x30, tramp_vectors + PAGE_SIZE
+	ldr	x30, [x30]
+#else
 	ldr	x30, =vectors
+#endif
 	prfm	plil1strm, [x30, #(1b - tramp_vectors)]
 	msr	vbar_el1, x30
 	add	x30, x30, #(1b - tramp_vectors)
@@ -946,6 +951,14 @@ END(tramp_exit_compat)
 
 	.ltorg
 	.popsection				// .entry.tramp.text
+#ifdef CONFIG_RANDOMIZE_BASE
+	.pushsection ".rodata", "a"
+	.align PAGE_SHIFT
+	.globl	__entry_tramp_data_start
+__entry_tramp_data_start:
+	.quad	vectors
+	.popsection				// .rodata
+#endif /* CONFIG_RANDOMIZE_BASE */
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
 /*
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 466a43a..6a58455 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -252,7 +252,10 @@ ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
 ASSERT(__hibernate_exit_text_end - (__hibernate_exit_text_start & ~(SZ_4K - 1))
 	<= SZ_4K, "Hibernate exit text too big or misaligned")
 #endif
-
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) == PAGE_SIZE,
+	"Entry trampoline text too big")
+#endif
 /*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
  */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 84945c9..10db4bf 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -435,8 +435,16 @@ static int __init map_entry_trampoline(void)
 	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
 			     prot, pgd_pgtable_alloc, 0);
 
-	/* ...as well as the kernel page table */
+	/* Map both the text and data into the kernel page table */
 	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
+		extern char __entry_tramp_data_start[];
+
+		__set_fixmap(FIX_ENTRY_TRAMP_DATA,
+			     __pa_symbol(__entry_tramp_data_start),
+			     PAGE_KERNEL_RO);
+	}
+
 	return 0;
 }
 core_initcall(map_entry_trampoline);
-- 
2.7.4
