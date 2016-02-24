From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Feb 2016 17:21:31 +0100
Subject: [RFC PATCH 4/6] arm64: mm: avoid virt_to_page() translation for the
 zero page
In-Reply-To: <1456330893-19228-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456330893-19228-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456330893-19228-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zero page is statically allocated, so grab its struct page pointer
without using virt_to_page(), which will be restricted to the linear
mapping later.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 8e6baea0ff61..ab84cafde3c9 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -118,7 +118,7 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
  * for zero-mapped memory areas etc..
  */
 extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
-#define ZERO_PAGE(vaddr)	virt_to_page(empty_zero_page)
+#define ZERO_PAGE(vaddr)	pfn_to_page(__pa(empty_zero_page) >> PAGE_SHIFT)
 
 #define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
 
-- 
2.5.0
