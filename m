From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Mar 2016 17:43:06 +0200
Subject: [PATCH v2 1/4] arm64: use 'segment' rather than 'chunk' to describe
 mapped kernel regions
In-Reply-To: <1459352589-28721-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459352589-28721-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459352589-28721-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the poorly defined term chunk with segment, which is a term that is
already used by the ELF spec to describe contiguous mappings with the same
permission attributes of statically allocated ranges of an executable.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f3e5c74233f3..9be2065f8ddb 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -471,8 +471,8 @@ void fixup_init(void)
 	unmap_kernel_range((u64)__init_begin, (u64)(__init_end - __init_begin));
 }
 
-static void __init map_kernel_chunk(pgd_t *pgd, void *va_start, void *va_end,
-				    pgprot_t prot, struct vm_struct *vma)
+static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
+				      pgprot_t prot, struct vm_struct *vma)
 {
 	phys_addr_t pa_start = __pa(va_start);
 	unsigned long size = va_end - va_start;
@@ -499,11 +499,11 @@ static void __init map_kernel(pgd_t *pgd)
 {
 	static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_init, vmlinux_data;
 
-	map_kernel_chunk(pgd, _stext, __start_rodata, PAGE_KERNEL_EXEC, &vmlinux_text);
-	map_kernel_chunk(pgd, __start_rodata, _etext, PAGE_KERNEL, &vmlinux_rodata);
-	map_kernel_chunk(pgd, __init_begin, __init_end, PAGE_KERNEL_EXEC,
-			 &vmlinux_init);
-	map_kernel_chunk(pgd, _data, _end, PAGE_KERNEL, &vmlinux_data);
+	map_kernel_segment(pgd, _stext, __start_rodata, PAGE_KERNEL_EXEC, &vmlinux_text);
+	map_kernel_segment(pgd, __start_rodata, _etext, PAGE_KERNEL, &vmlinux_rodata);
+	map_kernel_segment(pgd, __init_begin, __init_end, PAGE_KERNEL_EXEC,
+			   &vmlinux_init);
+	map_kernel_segment(pgd, _data, _end, PAGE_KERNEL, &vmlinux_data);
 
 	if (!pgd_val(*pgd_offset_raw(pgd, FIXADDR_START))) {
 		/*
-- 
2.5.0
