From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Nov 2017 11:59:13 +0000
Subject: [PATCHv2] arm64: mm: cleanup stale AIVIVT references
Message-ID: <20171121115913.28127-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit:

  155433cb365ee466 ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")

... the kernel no longer cares about AIVIVT I-caches, as these were
removed from the architecture.

This patch removes the stale references to such I-caches.

The comment in flush_context() is also updated to clarify when and where
the TLB invalidation occurs.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cacheflush.h | 2 +-
 arch/arm64/mm/context.c             | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

This was previously sent as "arm64: mm: remove stale comment" [1].

Since v1 [1]:
* remove stale cacheflush comment text
* clarify TLB invalidation comment

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/543043.html

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 76d1cc85d5b1..955130762a3c 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -38,7 +38,7 @@
  *
  *	See Documentation/cachetlb.txt for more information. Please note that
  *	the implementation assumes non-aliasing VIPT D-cache and (aliasing)
- *	VIPT or ASID-tagged VIVT I-cache.
+ *	VIPT I-cache.
  *
  *	flush_cache_mm(mm)
  *
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index ab9f5f0fb2c7..28a45a19aae7 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -117,7 +117,10 @@ static void flush_context(unsigned int cpu)
 		per_cpu(reserved_asids, i) = asid;
 	}
 
-	/* Queue a TLB invalidate and flush the I-cache if necessary. */
+	/*
+	 * Queue a TLB invalidation for each CPU to perform on next
+	 * context-switch
+	 */
 	cpumask_setall(&tlb_flush_pending);
 }
 
-- 
2.11.0
