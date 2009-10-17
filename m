From: julia@diku.dk (Julia Lawall)
Date: Sat, 17 Oct 2009 08:42:30 +0200 (CEST)
Subject: [PATCH 12/14] arch/arm/plat-omap: Drop an unnecessary NULL test
Message-ID: <Pine.LNX.4.64.0910170842120.9213@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <julia@diku.dk>

map_iovm_area is only called from a context where its second argument is
known not to be NULL, so drop the unnecessary test.  If new could be NULL,
the initialization of da should be moved below the test.

A simplified version of the semantic match that detects this problem is as
follows (http://coccinelle.lip6.fr/):

// <smpl>
@match exists@
expression x, E;
identifier fld;
@@

* x->fld
  ... when != \(x = E\|&x\)
* x == NULL
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/arm/plat-omap/iovmm.c          |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index dc3fac3..21c73d4 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -449,7 +449,7 @@ static int map_iovm_area(struct iommu *obj, struct iovm_struct *new,
 	struct scatterlist *sg;
 	u32 da = new->da_start;
 
-	if (!obj || !new || !sgt)
+	if (!obj || !sgt)
 		return -EINVAL;
 
 	BUG_ON(!sgtable_ok(sgt));
