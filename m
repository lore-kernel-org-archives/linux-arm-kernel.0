From: will.deacon@arm.com (Will Deacon)
Date: Wed,  6 Dec 2017 12:35:39 +0000
Subject: [PATCH v3 20/20] arm64: kaslr: Put kernel vectors address in separate
 data page
In-Reply-To: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
Message-ID: <1512563739-25239-21-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The literal pool entry for identifying the vectors base is the only piece
of information in the trampoline page that identifies the true location
of the kernel.

This patch moves it into its own page, which is only mapped by the full
kernel page table, which protects against any accidental leakage of the
trampoline contents.

Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/fixmap.h |  1 +
 arch/arm64/kernel/entry.S       | 11 +++++++++++
 arch/arm64/kernel/vmlinux.lds.S | 35 ++++++++++++++++++++++++++++-------
 arch/arm64/mm/mmu.c             | 10 +++++++++-
 4 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 8119b49be98d..ec1e6d6fa14c 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -59,6 +59,7 @@ enum fixed_addresses {
 #endif /* CONFIG_ACPI_APEI_GHES */
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	FIX_ENTRY_TRAMP_DATA,
 	FIX_ENTRY_TRAMP_TEXT,
 #define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT))
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 3eabcb194c87..a70c6dd2cc19 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1030,7 +1030,13 @@ alternative_else_nop_endif
 	msr	tpidrro_el0, x30	// Restored in kernel_ventry
 	.endif
 	tramp_map_kernel	x30
+#ifdef CONFIG_RANDOMIZE_BASE
+	adr	x30, tramp_vectors + PAGE_SIZE
+alternative_insn isb, nop, ARM64_WORKAROUND_QCOM_FALKOR_E1003
+	ldr	x30, [x30]
+#else
 	ldr	x30, =vectors
+#endif
 	prfm	plil1strm, [x30, #(1b - tramp_vectors)]
 	msr	vbar_el1, x30
 	add	x30, x30, #(1b - tramp_vectors)
@@ -1073,6 +1079,11 @@ END(tramp_exit_compat)
 
 	.ltorg
 	.popsection				// .entry.tramp.text
+#ifdef CONFIG_RANDOMIZE_BASE
+	.pushsection ".entry.tramp.data", "a"	// .entry.tramp.data
+	.quad	vectors
+	.popsection				// .entry.tramp.data
+#endif /* CONFIG_RANDOMIZE_BASE */
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
 /*
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 6b4260f22aab..976109b3ae51 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -58,15 +58,28 @@ jiffies = jiffies_64;
 #endif
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-#define TRAMP_TEXT					\
-	. = ALIGN(PAGE_SIZE);				\
-	VMLINUX_SYMBOL(__entry_tramp_text_start) = .;	\
-	*(.entry.tramp.text)				\
-	. = ALIGN(PAGE_SIZE);				\
+#define TRAMP_TEXT						\
+	. = ALIGN(PAGE_SIZE);					\
+	VMLINUX_SYMBOL(__entry_tramp_text_start) = .;		\
+	*(.entry.tramp.text)					\
+	. = ALIGN(PAGE_SIZE);					\
 	VMLINUX_SYMBOL(__entry_tramp_text_end) = .;
+#ifdef CONFIG_RANDOMIZE_BASE
+#define TRAMP_DATA						\
+	.entry.tramp.data : {					\
+		. = ALIGN(PAGE_SIZE);				\
+		VMLINUX_SYMBOL(__entry_tramp_data_start) = .;	\
+		*(.entry.tramp.data)				\
+		. = ALIGN(PAGE_SIZE);				\
+		VMLINUX_SYMBOL(__entry_tramp_data_end) = .;	\
+	}
+#else
+#define TRAMP_DATA
+#endif /* CONFIG_RANDOMIZE_BASE */
 #else
 #define TRAMP_TEXT
-#endif
+#define TRAMP_DATA
+#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
 /*
  * The size of the PE/COFF section that covers the kernel image, which
@@ -137,6 +150,7 @@ SECTIONS
 	RO_DATA(PAGE_SIZE)		/* everything from this point to     */
 	EXCEPTION_TABLE(8)		/* __init_begin will be marked RO NX */
 	NOTES
+	TRAMP_DATA
 
 	. = ALIGN(SEGMENT_ALIGN);
 	__init_begin = .;
@@ -251,7 +265,14 @@ ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
 ASSERT(__hibernate_exit_text_end - (__hibernate_exit_text_start & ~(SZ_4K - 1))
 	<= SZ_4K, "Hibernate exit text too big or misaligned")
 #endif
-
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) == PAGE_SIZE,
+	"Entry trampoline text too big")
+#ifdef CONFIG_RANDOMIZE_BASE
+ASSERT((__entry_tramp_data_end - __entry_tramp_data_start) == PAGE_SIZE,
+	"Entry trampoline data too big")
+#endif
+#endif
 /*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
  */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index fe68a48c64cb..916d9ced1c3f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -541,8 +541,16 @@ static int __init map_entry_trampoline(void)
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
2.1.4
