From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Mon, 10 May 2010 12:16:10 +0300
Subject: [PATCH] omap iommu: Insert a gap page between IOVMAs against override
In-Reply-To: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Message-ID: <1273482972-5586-7-git-send-email-Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inserting a gap page between IOVMAs could detect an override on other
IOVMA with iommu fault. This was originally suggested by Sakari Ailus
and based on the work and comment by David Cohen.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: David Cohen <david.cohen@nokia.com>
Cc: Sakari Ailus <Sakari.Ailus@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 65c6d1f..5afe013 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -287,16 +287,16 @@ static struct iovm_struct *alloc_iovm_area(struct iommu *obj, u32 da,
 	prev_end = 0;
 	list_for_each_entry(tmp, &obj->mmap, list) {
 
-		if ((prev_end <= start) && (start + bytes < tmp->da_start))
+		if ((prev_end < start) && (start + bytes < tmp->da_start))
 			goto found;
 
 		if (flags & IOVMF_DA_ANON)
-			start = roundup(tmp->da_end, alignement);
+			start = roundup(tmp->da_end + 1, alignement);
 
 		prev_end = tmp->da_end;
 	}
 
-	if ((start >= prev_end) && (ULONG_MAX - start >= bytes))
+	if ((start > prev_end) && (ULONG_MAX - start >= bytes))
 		goto found;
 
 	dev_dbg(obj->dev, "%s: no space to fit %08x(%x) flags: %08x\n",
-- 
1.7.1.rc1
