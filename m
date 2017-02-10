From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 10 Feb 2017 17:16:44 +0000
Subject: [PATCH 3/4] arm64: mmu: map .text as read-only from the outset
In-Reply-To: <1486747005-15973-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1486747005-15973-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1486747005-15973-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that alternatives patching code no longer relies on the primary
mapping of .text being writable, we can remove the code that removes
the writable permissions post-init time, and map it read-only from
the outset.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f4b045d1cc53..5b0dbb9156ce 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -442,9 +442,6 @@ void mark_rodata_ro(void)
 {
 	unsigned long section_size;
 
-	section_size = (unsigned long)_etext - (unsigned long)_text;
-	create_mapping_late(__pa_symbol(_text), (unsigned long)_text,
-			    section_size, PAGE_KERNEL_ROX);
 	/*
 	 * mark .rodata as read only. Use __init_begin rather than __end_rodata
 	 * to cover NOTES and EXCEPTION_TABLE.
@@ -487,7 +484,7 @@ static void __init map_kernel(pgd_t *pgd)
 {
 	static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_init, vmlinux_data;
 
-	map_kernel_segment(pgd, _text, _etext, PAGE_KERNEL_EXEC, &vmlinux_text);
+	map_kernel_segment(pgd, _text, _etext, PAGE_KERNEL_ROX, &vmlinux_text);
 	map_kernel_segment(pgd, __start_rodata, __init_begin, PAGE_KERNEL, &vmlinux_rodata);
 	map_kernel_segment(pgd, __init_begin, __init_end, PAGE_KERNEL_EXEC,
 			   &vmlinux_init);
-- 
2.7.4
