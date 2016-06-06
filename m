From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 06 Jun 2016 18:00:36 +0100
Subject: [PATCH kexec-tools v2 22/32] arm: use generic mem_region sorting
 implementation
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
Message-ID: <E1b9xtE-0003tY-W5@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the generic mem_region sorting implementation.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 85afd9f..d6db566 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -202,19 +202,6 @@ static void crash_exclude_range(void)
 	}
 }
 
-static int range_cmp(const void *a1, const void *a2)
-{
-	const struct memory_range *r1 = a1;
-	const struct memory_range *r2 = a2;
-
-	if (r1->start > r2->start)
-		return 1;
-	if (r1->start < r2->start)
-		return -1;
-
-	return 0;
-}
-
 /**
  * crash_get_memory_ranges() - read system physical memory
  *
@@ -246,8 +233,7 @@ static int crash_get_memory_ranges(void)
 	/*
 	 * Make sure that the memory regions are sorted.
 	 */
-	qsort(usablemem_rgns.ranges, usablemem_rgns.size,
-	      sizeof(*usablemem_rgns.ranges), range_cmp);
+	mem_regions_sort(&usablemem_rgns);
 
 	return 0;
 }
-- 
1.9.1
