From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Feb 2010 19:35:44 -0800
Subject: [PATCH 05/17] omap iommu: fix incorrect address for largepage 1st
	entry
In-Reply-To: <20100211033310.1624.80025.stgit@baageli.muru.com>
References: <20100211033310.1624.80025.stgit@baageli.muru.com>
Message-ID: <20100211033544.1624.99282.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

There was a potential risk that the following "memset" could override
its range if a given address was not the 1st entry of a
largepage. This is not the case for "iovmm".

Reported-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/iommu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index e748119..905ed83 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -1,7 +1,7 @@
 /*
  * omap iommu: tlb and pagetable primitives
  *
- * Copyright (C) 2008-2009 Nokia Corporation
+ * Copyright (C) 2008-2010 Nokia Corporation
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
  *		Paul Mundt and Toshihiro Kobayashi
@@ -646,7 +646,7 @@ static size_t iopgtable_clear_entry_core(struct iommu *obj, u32 da)
 		if (*iopte & IOPTE_LARGE) {
 			nent *= 16;
 			/* rewind to the 1st entry */
-			iopte = (u32 *)((u32)iopte & IOLARGE_MASK);
+			iopte = iopte_offset(iopgd, (da & IOLARGE_MASK));
 		}
 		bytes *= nent;
 		memset(iopte, 0, nent * sizeof(*iopte));
