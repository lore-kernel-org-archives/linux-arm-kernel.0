From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 19 Mar 2018 19:19:54 +0800
Subject: [RFC PATCH 2/6] arm64/mm: create dedicated segment for pgdir mappings
In-Reply-To: <20180319111958.4171-1-ard.biesheuvel@linaro.org>
References: <20180319111958.4171-1-ard.biesheuvel@linaro.org>
Message-ID: <20180319111958.4171-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to allow the pgdir mapping to be backed by a non-adjacent
physical region in a future patch, split it off from the data segment
and create a dedicated pgdir segment for it.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/kernel/vmlinux.lds.S   |  3 +++
 arch/arm64/mm/mmu.c               | 10 +++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index caab039d6305..f6b70a3fb332 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -29,5 +29,6 @@ extern char __inittext_begin[], __inittext_end[];
 extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
 extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
+extern char __pgdir_segment_start[], __pgdir_segment_end[];
 
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 0221aca6493d..b0fa2277e8d0 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -219,6 +219,8 @@ SECTIONS
 	idmap_pg_dir = .;
 	. += IDMAP_DIR_SIZE;
 
+	. = ALIGN(SEGMENT_ALIGN);
+	__pgdir_segment_start = .;
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	tramp_pg_dir = .;
 	. += PAGE_SIZE;
@@ -229,6 +231,7 @@ SECTIONS
 	. += RESERVED_TTBR0_SIZE;
 #endif
 	swapper_pg_dir = .;
+	__pgdir_segment_end = . + PAGE_SIZE;
 	. += SWAPPER_DIR_SIZE;
 	swapper_pg_end = .;
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 007b2e32ca71..0a9c08c0948c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -572,7 +572,7 @@ core_initcall(map_entry_trampoline);
 static void __init map_kernel(pgd_t *pgdp)
 {
 	static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_inittext,
-				vmlinux_initdata, vmlinux_data;
+				vmlinux_initdata, vmlinux_data, vmlinux_pgdir;
 
 	/*
 	 * External debuggers may need to write directly to the text
@@ -596,8 +596,12 @@ static void __init map_kernel(pgd_t *pgdp)
 	map_kernel_segment(pgdp, __initdata_begin, __initdata_end,
 			   __pa_symbol(__initdata_begin), PAGE_KERNEL,
 			   &vmlinux_initdata, 0, VM_NO_GUARD);
-	map_kernel_segment(pgdp, _data, _end, __pa_symbol(_data), PAGE_KERNEL,
-			   &vmlinux_data, 0, 0);
+	map_kernel_segment(pgdp, _data, __pgdir_segment_start,
+			   __pa_symbol(_data), PAGE_KERNEL,
+			   &vmlinux_data, 0, VM_NO_GUARD);
+	map_kernel_segment(pgdp, __pgdir_segment_start, __pgdir_segment_end,
+			   __pa_symbol(__pgdir_segment_start), PAGE_KERNEL,
+			   &vmlinux_pgdir, 0, 0);
 
 	if (!READ_ONCE(pgd_val(*pgd_offset_raw(pgdp, FIXADDR_START)))) {
 		/*
-- 
2.11.0
