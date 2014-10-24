From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 24 Oct 2014 13:18:42 +0300
Subject: [PATCH v2 4/4] mm: cma: Use %pa to print physical addresses
In-Reply-To: <1414145922-26042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1414145922-26042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1414145922-26042-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Casting physical addresses to unsigned long and using %lu truncates the
values on systems where physical addresses are larger than 32 bits. Use
%pa and get rid of the cast instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Michal Nazarewicz <mina86@mina86.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 mm/cma.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index c30a6edee65c..fde706e1284f 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -218,9 +218,8 @@ int __init cma_declare_contiguous(phys_addr_t base,
 	phys_addr_t highmem_start = __pa(high_memory);
 	int ret = 0;
 
-	pr_debug("%s(size %lx, base %08lx, limit %08lx alignment %08lx)\n",
-		__func__, (unsigned long)size, (unsigned long)base,
-		(unsigned long)limit, (unsigned long)alignment);
+	pr_debug("%s(size %pa, base %pa, limit %pa alignment %pa)\n",
+		__func__, &size, &base, &limit, &alignment);
 
 	if (cma_area_count == ARRAY_SIZE(cma_areas)) {
 		pr_err("Not enough slots for CMA reserved regions!\n");
@@ -258,8 +257,8 @@ int __init cma_declare_contiguous(phys_addr_t base,
 	 */
 	if (fixed && base < highmem_start && base + size > highmem_start) {
 		ret = -EINVAL;
-		pr_err("Region at %08lx defined on low/high memory boundary (%08lx)\n",
-			(unsigned long)base, (unsigned long)highmem_start);
+		pr_err("Region at %pa defined on low/high memory boundary (%pa)\n",
+			&base, &highmem_start);
 		goto err;
 	}
 
@@ -309,8 +308,8 @@ int __init cma_declare_contiguous(phys_addr_t base,
 	if (ret)
 		goto err;
 
-	pr_info("Reserved %ld MiB at %08lx\n", (unsigned long)size / SZ_1M,
-		(unsigned long)base);
+	pr_info("Reserved %ld MiB at %pa\n", (unsigned long)size / SZ_1M,
+		&base);
 	return 0;
 
 err:
-- 
2.0.4
