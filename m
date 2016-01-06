From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  6 Jan 2016 16:54:47 +0100
Subject: [PATCH] mm/kasan: map KASAN zero page read only
Message-ID: <1452095687-18136-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original x86_64-only version of KASAN mapped its zero page
read-only, but this got lost when the code was generalised and
ported to arm64, since, at the time, the PAGE_KERNEL_RO define
did not exist. It has been added to arm64 in the mean time, so
let's use it.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 mm/kasan/kasan_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
index 3f9a41cf0ac6..8726a92604ad 100644
--- a/mm/kasan/kasan_init.c
+++ b/mm/kasan/kasan_init.c
@@ -49,7 +49,7 @@ static void __init zero_pte_populate(pmd_t *pmd, unsigned long addr,
 	pte_t *pte = pte_offset_kernel(pmd, addr);
 	pte_t zero_pte;
 
-	zero_pte = pfn_pte(PFN_DOWN(__pa(kasan_zero_page)), PAGE_KERNEL);
+	zero_pte = pfn_pte(PFN_DOWN(__pa(kasan_zero_page)), PAGE_KERNEL_RO);
 	zero_pte = pte_wrprotect(zero_pte);
 
 	while (addr + PAGE_SIZE <= end) {
-- 
2.5.0
