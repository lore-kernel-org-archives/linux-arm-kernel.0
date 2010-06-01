From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Tue,  1 Jun 2010 08:30:43 +0300
Subject: [PATCH 4/8] omap iommu: Fix Memory leak
In-Reply-To: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
References: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Message-ID: <1275370247-15888-4-git-send-email-Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Satish <x0124230@ti.com>

The memory allocated for sgt structure is not freed on error
when sg_alloc_table is called in sgtable_alloc().

Signed-off-by: Satish Kumar <x0124230@ti.com>
Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: vimal singh <vimal.newwork@gmail.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index e43983b..8ce0de2 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -140,8 +140,10 @@ static struct sg_table *sgtable_alloc(const size_t bytes, u32 flags)
 		return ERR_PTR(-ENOMEM);
 
 	err = sg_alloc_table(sgt, nr_entries, GFP_KERNEL);
-	if (err)
+	if (err) {
+		kfree(sgt);
 		return ERR_PTR(err);
+	}
 
 	pr_debug("%s: sgt:%p(%d entries)\n", __func__, sgt, nr_entries);
 
-- 
1.7.1.rc1
