From: will.deacon@arm.com (Will Deacon)
Date: Tue,  2 Feb 2016 12:46:23 +0000
Subject: [PATCH 1/4] arm64: prefetch: don't provide spin_lock_prefetch with LSE
In-Reply-To: <1454417186-21828-1-git-send-email-will.deacon@arm.com>
References: <1454417186-21828-1-git-send-email-will.deacon@arm.com>
Message-ID: <1454417186-21828-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LSE atomics rely on us not dirtying data at L1 if we can avoid it,
otherwise many of the potential scalability benefits are lost.

This patch replaces spin_lock_prefetch with a nop when the LSE atomics
are in use, so that users don't shoot themselves in the foot by causing
needless coherence traffic at L1.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/processor.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 4acb7ca94fcd..31b76fce4477 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -29,6 +29,7 @@
 
 #include <linux/string.h>
 
+#include <asm/alternative.h>
 #include <asm/fpsimd.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/pgtable-hwdef.h>
@@ -177,9 +178,11 @@ static inline void prefetchw(const void *ptr)
 }
 
 #define ARCH_HAS_SPINLOCK_PREFETCH
-static inline void spin_lock_prefetch(const void *x)
+static inline void spin_lock_prefetch(const void *ptr)
 {
-	prefetchw(x);
+	asm volatile(ARM64_LSE_ATOMIC_INSN(
+		     "prfm pstl1strm, %a0",
+		     "nop") : : "p" (ptr));
 }
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
-- 
2.1.4
