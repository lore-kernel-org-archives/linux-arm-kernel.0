From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Sep 2015 18:22:02 +0100
Subject: [PATCH 3/3] arm64: pgtable: use a single bit for PTE_WRITE regardless
 of DBM
In-Reply-To: <1441992122-19888-1-git-send-email-catalin.marinas@arm.com>
References: <1441992122-19888-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1441992122-19888-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

Depending on CONFIG_ARM64_HW_AFDBM, we use either bit 57 or 51 of the
pte to represent PTE_WRITE. Given that bit 51 is reserved prior to
ARMv8.1, we can just use that bit regardless of the config option. That
also matches what happens if a kernel configured with ARM64_HW_AFDBM=y
is run on a CPU without the DBM functionality.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Julien Grall <julien.grall@citrix.com>
---
 arch/arm64/include/asm/pgtable.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 31df98adf005..b0329be95cb1 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -26,13 +26,9 @@
  * Software defined PTE bits definition.
  */
 #define PTE_VALID		(_AT(pteval_t, 1) << 0)
+#define PTE_WRITE		(PTE_DBM)		 /* same as DBM (51) */
 #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
-#ifdef CONFIG_ARM64_HW_AFDBM
-#define PTE_WRITE		(PTE_DBM)		 /* same as DBM */
-#else
-#define PTE_WRITE		(_AT(pteval_t, 1) << 57)
-#endif
 #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
 
 /*
