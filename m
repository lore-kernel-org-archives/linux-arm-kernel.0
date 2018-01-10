From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 10 Jan 2018 19:07:26 +0000
Subject: [RFC 1/4] arm64: Correct type for PUD macros
In-Reply-To: <20180110190729.18383-1-punit.agrawal@arm.com>
References: <20180110190729.18383-1-punit.agrawal@arm.com>
Message-ID: <20180110190729.18383-2-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PUD macros (PUD_TABLE_BIT, PUD_TYPE_MASK, PUD_TYPE_SECT) use the
pgdval_t even when pudval_t is available. Even though the underlying
type for both (u64) is the same it is confusing and may lead to issues
in the future.

Fix this by using pudval_t to define the PUD_* macros.

Fixes: 084bd29810a56 ("ARM64: mm: HugeTLB support.")
Fixes: 206a2a73a62d3 ("arm64: mm: Create gigabyte kernel logical mappings where possible")
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index eb0c2bd90de9..40a998cdd399 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -116,9 +116,9 @@
  * Level 1 descriptor (PUD).
  */
 #define PUD_TYPE_TABLE		(_AT(pudval_t, 3) << 0)
-#define PUD_TABLE_BIT		(_AT(pgdval_t, 1) << 1)
-#define PUD_TYPE_MASK		(_AT(pgdval_t, 3) << 0)
-#define PUD_TYPE_SECT		(_AT(pgdval_t, 1) << 0)
+#define PUD_TABLE_BIT		(_AT(pudval_t, 1) << 1)
+#define PUD_TYPE_MASK		(_AT(pudval_t, 3) << 0)
+#define PUD_TYPE_SECT		(_AT(pudval_t, 1) << 0)
 
 /*
  * Level 2 descriptor (PMD).
-- 
2.15.1
