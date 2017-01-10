From: labbott@redhat.com (Laura Abbott)
Date: Tue, 10 Jan 2017 13:35:41 -0800
Subject: [PATCHv7 02/11] mm/cma: Cleanup highmem check
In-Reply-To: <1484084150-1523-1-git-send-email-labbott@redhat.com>
References: <1484084150-1523-1-git-send-email-labbott@redhat.com>
Message-ID: <1484084150-1523-3-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


6b101e2a3ce4 ("mm/CMA: fix boot regression due to physical address of
high_memory") added checks to use __pa_nodebug on x86 since
CONFIG_DEBUG_VIRTUAL complains about high_memory not being linearlly
mapped. arm64 is now getting support for CONFIG_DEBUG_VIRTUAL as well.
Rather than add an explosion of arches to the #ifdef, switch to an
alternate method to calculate the physical start of highmem using
the page before highmem starts. This avoids the need for the #ifdef and
extra __pa_nodebug calls.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 mm/cma.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index c960459..94b3460 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -235,18 +235,13 @@ int __init cma_declare_contiguous(phys_addr_t base,
 	phys_addr_t highmem_start;
 	int ret = 0;
 
-#ifdef CONFIG_X86
 	/*
-	 * high_memory isn't direct mapped memory so retrieving its physical
-	 * address isn't appropriate.  But it would be useful to check the
-	 * physical address of the highmem boundary so it's justifiable to get
-	 * the physical address from it.  On x86 there is a validation check for
-	 * this case, so the following workaround is needed to avoid it.
+	 * We can't use __pa(high_memory) directly, since high_memory
+	 * isn't a valid direct map VA, and DEBUG_VIRTUAL will (validly)
+	 * complain. Find the boundary by adding one to the last valid
+	 * address.
 	 */
-	highmem_start = __pa_nodebug(high_memory);
-#else
-	highmem_start = __pa(high_memory);
-#endif
+	highmem_start = __pa(high_memory - 1) + 1;
 	pr_debug("%s(size %pa, base %pa, limit %pa alignment %pa)\n",
 		__func__, &size, &base, &limit, &alignment);
 
-- 
2.7.4
