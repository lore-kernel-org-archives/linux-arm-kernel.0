From: gdavis@mvista.com (gdavis at mvista.com)
Date: Thu,  6 Oct 2011 01:08:31 -0400
Subject: [RFC/PATCH 4/7] ARM: ARM11 MPCore: clean_dcache_area is not preempt
	safe
In-Reply-To: <1317877714-11355-1-git-send-email-gdavis@mvista.com>
References: <05942148-7AFB-4755-A22F-355E0360B098@mvista.com>
	<1317877714-11355-1-git-send-email-gdavis@mvista.com>
Message-ID: <1317877714-11355-5-git-send-email-gdavis@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: George G. Davis <gdavis@mvista.com>

If preemption and subsequent task migration occurs during calls to
clean_dcache_area on ARM11 MPCore machines, global memory state
can become inconsistent.  To prevent inconsistent memory state on
these machines, disable preemption in callers of these functions
around memory modifications and subsequent clean_dcache_area calls.

Signed-off-by: George G. Davis <gdavis@mvista.com>
---
 arch/arm/plat-omap/iommu.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 34fc31e..ef8e065 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -1014,8 +1014,12 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
 		err = -ENOMEM;
 		goto err_pgd;
 	}
+	if (cache_ops_need_broadcast())
+		get_cpu();
 	memset(p, 0, IOPGD_TABLE_SIZE);
 	clean_dcache_area(p, IOPGD_TABLE_SIZE);
+	if (cache_ops_need_broadcast())
+		put_cpu();
 	obj->iopgd = p;
 
 	BUG_ON(!IS_ALIGNED((unsigned long)obj->iopgd, IOPGD_TABLE_SIZE));
@@ -1069,7 +1073,13 @@ static struct platform_driver omap_iommu_driver = {
 
 static void iopte_cachep_ctor(void *iopte)
 {
+	if (cache_ops_need_broadcast())
+		get_cpu();
+	/* FIXME: This will not work on ARM11 MPCore.
+	 */
 	clean_dcache_area(iopte, IOPTE_TABLE_SIZE);
+	if (cache_ops_need_broadcast())
+		put_cpu();
 }
 
 static int __init omap_iommu_init(void)
-- 
1.7.4.4
