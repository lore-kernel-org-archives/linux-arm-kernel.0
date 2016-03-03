From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  3 Mar 2016 14:09:40 +0100
Subject: [PATCH 2/3] arm64: cover the .head.text section in the .text segment
 mapping
In-Reply-To: <1457010581-4924-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1457010581-4924-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1457010581-4924-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keeping .head.text out of the .text mapping buys us very little: its actual
payload is only 4 KB, most of which is padding, but the page alignment may
add up to 2 MB (in case of CONFIG_DEBUG_ALIGN_RODATA=y) of additional
padding to the uncompressed kernel Image.

Also, on 4 KB granule kernels, the 4 KB misalignment of .text forces us to
map the adjacent 56 KB of code without the PTE_CONT attribute, and since
this region contains the GIC interrupt handling entry point, among other
things, this region is likely to benefit from the reduced TLB pressure that
results from PTE_CONT mappings.

So remove the alignment between the .head.text and .text sections, and use
the [_text, _etext) rather than the [_stext, _etext) interval for mapping
the .text segment.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/vmlinux.lds.S |  1 -
 arch/arm64/mm/mmu.c             | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 4c56e7a0621b..7a141c098bbb 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -96,7 +96,6 @@ SECTIONS
 		_text = .;
 		HEAD_TEXT
 	}
-	ALIGN_DEBUG_RO_MIN(PAGE_SIZE)
 	.text : {			/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
 			__exception_text_start = .;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d2d8b8c2e17f..1d727018e90b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -387,7 +387,7 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
 
 static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
 {
-	unsigned long kernel_start = __pa(_stext);
+	unsigned long kernel_start = __pa(_text);
 	unsigned long kernel_end = __pa(_etext);
 
 	/*
@@ -419,7 +419,7 @@ static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end
 				     early_pgtable_alloc);
 
 	/*
-	 * Map the linear alias of the [_stext, _etext) interval as
+	 * Map the linear alias of the [_text, _etext) interval as
 	 * read-only/non-executable. This makes the contents of the
 	 * region accessible to subsystems such as hibernate, but
 	 * protects it from inadvertent modification or execution.
@@ -451,8 +451,8 @@ void mark_rodata_ro(void)
 {
 	unsigned long section_size;
 
-	section_size = (unsigned long)__start_rodata - (unsigned long)_stext;
-	create_mapping_late(__pa(_stext), (unsigned long)_stext,
+	section_size = (unsigned long)__start_rodata - (unsigned long)_text;
+	create_mapping_late(__pa(_text), (unsigned long)_text,
 			    section_size, PAGE_KERNEL_ROX);
 	/*
 	 * mark .rodata as read only. Use _etext rather than __end_rodata to
@@ -501,7 +501,7 @@ static void __init map_kernel(pgd_t *pgd)
 {
 	static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_init, vmlinux_data;
 
-	map_kernel_chunk(pgd, _stext, __start_rodata, PAGE_KERNEL_EXEC, &vmlinux_text);
+	map_kernel_chunk(pgd, _text, __start_rodata, PAGE_KERNEL_EXEC, &vmlinux_text);
 	map_kernel_chunk(pgd, __start_rodata, _etext, PAGE_KERNEL, &vmlinux_rodata);
 	map_kernel_chunk(pgd, __init_begin, __init_end, PAGE_KERNEL_EXEC,
 			 &vmlinux_init);
-- 
2.5.0
