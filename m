From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 27 Jan 2017 15:14:16 +0900
Subject: [PATCH/RFC v2 1/4] iommu/of: Skip IOMMU devices disabled in DT
In-Reply-To: <148549764733.22203.16459470412085471955.sendpatchset@little-apple>
References: <148549764733.22203.16459470412085471955.sendpatchset@little-apple>
Message-ID: <148549765644.22203.4025544332917256731.sendpatchset@little-apple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend the shared IOMMU code to skip over ->xlate() in case the
IOMMU device pointed to by a slave device has been disabled in DT.

Difficult to trigger in case a single IOMMU device is used, however
when multiple IOMMUs are used and some of them are disabled in DT
then this patch makes sure that ->xlate() only gets invoked for the
enabled ones.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 I used to keep this as a local check in the xlate() callback
 for the not-yet-merged-upstream R-Car Gen3 IPMMU driver stack.

 Since honoring DT disabled devices probably makes sense for most users
 it seems like a good plan to try to push it into the common subsystem level.

 Thanks to Geert for suggesting this ages ago.

 Developed on top of renesas-drivers-2017-01-24-v4.10-rc5 which
 includes a recent version of iommu/next.

 drivers/iommu/of_iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/iommu/of_iommu.c
+++ work/drivers/iommu/of_iommu.c	2017-01-27 13:19:22.540607110 +0900
@@ -159,7 +159,7 @@ const struct iommu_ops *of_iommu_configu
 		np = iommu_spec.np;
 		ops = of_iommu_get_ops(np);
 
-		if (!ops || !ops->of_xlate ||
+		if (!ops || !ops->of_xlate || !of_device_is_available(np) ||
 		    iommu_fwspec_init(dev, &np->fwnode, ops) ||
 		    ops->of_xlate(dev, &iommu_spec))
 			goto err_put_node;
