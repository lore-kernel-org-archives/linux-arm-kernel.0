From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 21:54:26 +0100
Subject: [RFC PATCH 04/10] arm64: mm: avoid __pa translations on
 empty_zero_page
In-Reply-To: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456174472-30028-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable empty_zero_page is part of the static kernel text, so we
should use __pa_symbol() not __pa() to take its physical address.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 arch/arm64/include/asm/pgtable.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 40fc56f3ed52..b03272fc501e 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -49,7 +49,7 @@ static inline void contextidr_thread_switch(struct task_struct *next)
  */
 static inline void cpu_set_reserved_ttbr0(void)
 {
-	unsigned long ttbr = virt_to_phys(empty_zero_page);
+	unsigned long ttbr = __pa_symbol(empty_zero_page);
 
 	asm(
 	"	msr	ttbr0_el1, %0			// set TTBR0\n"
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a440f5a85d08..528482f53f12 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -117,7 +117,7 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
  * for zero-mapped memory areas etc..
  */
 extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
-#define ZERO_PAGE(vaddr)	virt_to_page(empty_zero_page)
+#define ZERO_PAGE(vaddr)	phys_to_page(__pa_symbol(empty_zero_page))
 
 #define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
 
-- 
2.5.0
