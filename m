From: ddaney.cavm@gmail.com (David Daney)
Date: Sat, 11 Jul 2015 13:25:22 -0700
Subject: [PATCH 2/3] arm64, mm: Use flush_tlb_all_local() in flush_context().
In-Reply-To: <1436646323-10527-1-git-send-email-ddaney.cavm@gmail.com>
References: <1436646323-10527-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1436646323-10527-3-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

When CONFIG_SMP, we end up calling flush_context() on each CPU
(indirectly) from __new_context().  Because of this, doing a broadcast
TLB invalidate is overkill, as all CPUs will be doing a local
invalidation.

Change the scope of the TLB invalidation operation to be local,
resulting in nr_cpus invalidations, rather than nr_cpus^2.

On CPUs with a large ASID space this operation is not often done.
But, when it is, this reduces the overhead.

Benchmarked "time make -j48" kernel build with and without the patch on
Cavium ThunderX system, one run to warm up the caches, and then five
runs measured:

original      with-patch
139.299s      139.0766s
S.D. 0.321    S.D. 0.159

Probably a little faster, but could be measurement noise.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/mm/context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 76c1e6c..ab5b8d3 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -48,7 +48,7 @@ static void flush_context(void)
 {
 	/* set the reserved TTBR0 before flushing the TLB */
 	cpu_set_reserved_ttbr0();
-	flush_tlb_all();
+	flush_tlb_all_local();
 	if (icache_is_aivivt())
 		__flush_icache_all();
 }
-- 
1.9.1
