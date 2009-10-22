From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Oct 2009 15:11:49 -0700
Subject: [PATCH 03/10] omap: iommu: fix wrong condition check for SUPERSECTION
In-Reply-To: <20091022221013.27408.443.stgit@localhost>
References: <20091022221013.27408.443.stgit@localhost>
Message-ID: <20091022221149.27408.67112.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

A bit (2 << 0) is set both on SECTION and SUPERSECTION. To identify
SUPERSECTION correctly, other bits should be compared too.

Reported-by: "Srinivas Pulukuru" <srinivas.pulukuru@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 4b60127..94584f1 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -664,7 +664,7 @@ static size_t iopgtable_clear_entry_core(struct iommu *obj, u32 da)
 		nent = 1; /* for the next L1 entry */
 	} else {
 		bytes = IOPGD_SIZE;
-		if (*iopgd & IOPGD_SUPER) {
+		if ((*iopgd & IOPGD_SUPER) == IOPGD_SUPER) {
 			nent *= 16;
 			/* rewind to the 1st entry */
 			iopgd = (u32 *)((u32)iopgd & IOSUPER_MASK);
