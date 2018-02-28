From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 11:56:27 +0800
Subject: [PATCH 05/29] arm64: mm: Invalidate both kernel and user ASIDs when
 performing TLBI
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519790211-16582-6-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit 9b0de864b5bc upstream.

Since an mm has both a kernel and a user ASID, we need to ensure that
broadcast TLB maintenance targets both address spaces so that things
like CoW continue to work with the uaccess primitives in the kernel.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/tlbflush.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index deab523..ad6bd8b 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -23,6 +23,7 @@
 
 #include <linux/sched.h>
 #include <asm/cputype.h>
+#include <asm/mmu.h>
 
 /*
  * Raw TLBI operations.
@@ -42,6 +43,11 @@
 
 #define __tlbi(op, ...)		__TLBI_N(op, ##__VA_ARGS__, 1, 0)
 
+#define __tlbi_user(op, arg) do {						\
+	if (arm64_kernel_unmapped_at_el0())					\
+		__tlbi(op, (arg) | USER_ASID_FLAG);				\
+} while (0)
+
 /*
  *	TLB Management
  *	==============
@@ -103,6 +109,7 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 
 	dsb(ishst);
 	__tlbi(aside1is, asid);
+	__tlbi_user(aside1is, asid);
 	dsb(ish);
 }
 
@@ -113,6 +120,7 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 
 	dsb(ishst);
 	__tlbi(vale1is, addr);
+	__tlbi_user(vale1is, addr);
 	dsb(ish);
 }
 
@@ -139,10 +147,13 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 
 	dsb(ishst);
 	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12)) {
-		if (last_level)
+		if (last_level) {
 			__tlbi(vale1is, addr);
-		else
+			__tlbi_user(vale1is, addr);
+		} else {
 			__tlbi(vae1is, addr);
+			__tlbi_user(vae1is, addr);
+		}
 	}
 	dsb(ish);
 }
@@ -182,6 +193,7 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
 	unsigned long addr = uaddr >> 12 | (ASID(mm) << 48);
 
 	__tlbi(vae1is, addr);
+	__tlbi_user(vae1is, addr);
 	dsb(ish);
 }
 
-- 
2.7.4
