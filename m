From: fernando.lugo@ti.com (Fernando Guzman Lugo)
Date: Tue, 14 Dec 2010 18:54:00 -0600
Subject: [PATCHv7 1/4] omap: iovmm - no gap checking for fixed address
In-Reply-To: <1292374443-4055-1-git-send-email-fernando.lugo@ti.com>
References: <1292374443-4055-1-git-send-email-fernando.lugo@ti.com>
Message-ID: <1292374443-4055-2-git-send-email-fernando.lugo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guzman Lugo, Fernando <x0095840@ti.com>

If some fixed da address is wanted to be mapped and the page
is freed but it is used as gap, the mapping will fail.
This patch is fixing that and olny keeps the gap for
not fixed address.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 8ce0de2..34f0012 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -289,10 +289,10 @@ static struct iovm_struct *alloc_iovm_area(struct iommu *obj, u32 da,
 	prev_end = 0;
 	list_for_each_entry(tmp, &obj->mmap, list) {
 
-		if (prev_end >= start)
+		if (prev_end > start)
 			break;
 
-		if (start + bytes < tmp->da_start)
+		if (start + bytes <= tmp->da_start)
 			goto found;
 
 		if (flags & IOVMF_DA_ANON)
@@ -301,7 +301,7 @@ static struct iovm_struct *alloc_iovm_area(struct iommu *obj, u32 da,
 		prev_end = tmp->da_end;
 	}
 
-	if ((start > prev_end) && (ULONG_MAX - start >= bytes))
+	if ((start >= prev_end) && (ULONG_MAX - start + 1 >= bytes))
 		goto found;
 
 	dev_dbg(obj->dev, "%s: no space to fit %08x(%x) flags: %08x\n",
-- 
1.7.0.4
