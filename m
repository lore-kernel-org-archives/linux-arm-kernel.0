From: joelagnel@ti.com (Joel A Fernandes)
Date: Fri, 21 Jun 2013 19:02:48 -0500
Subject: [PATCH] ARM: common: edma: Fix dangling pointer dereference
Message-ID: <1371859368-16063-1-git-send-email-joelagnel@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Returning a pointer to a variable in the setup_from_dt function is
causing dangling pointer dereferences. This causes boot to fail
on AM33XX.

Add ninfo to the caller's stack and just return the kzalloc'ed ptr
from the calling function.

Seen on linux-davinci/soc-v2 branch.

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
---
 arch/arm/common/edma.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 2b591b1..f913e82 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1514,10 +1514,9 @@ static struct of_dma_filter_info edma_filter_info = {
 	.filter_fn = edma_filter_fn,
 };
 
-static struct edma_soc_info **edma_setup_info_from_dt(struct device *dev,
+static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
 						      struct device_node *node)
 {
-	static struct edma_soc_info **info;
 	struct edma_soc_info *ninfo;
 	int ret;
 
@@ -1539,9 +1538,7 @@ static struct edma_soc_info **edma_setup_info_from_dt(struct device *dev,
 	of_dma_controller_register(dev->of_node, of_dma_simple_xlate,
 				   &edma_filter_info);
 
-	info = &ninfo;
-
-	return info;
+	return ninfo;
 }
 #else
 static struct edma_soc_info **edma_setup_info_from_dt(struct device *dev,
@@ -1554,6 +1551,7 @@ static struct edma_soc_info **edma_setup_info_from_dt(struct device *dev,
 static int edma_probe(struct platform_device *pdev)
 {
 	struct edma_soc_info	**info = pdev->dev.platform_data;
+	struct edma_soc_info    *ninfo[EDMA_MAX_CC] = {NULL};
 	s8		(*queue_priority_mapping)[2];
 	s8		(*queue_tc_mapping)[2];
 	int			i, j, off, ln, found = 0;
@@ -1572,7 +1570,7 @@ static int edma_probe(struct platform_device *pdev)
 	int			ret;
 
 	if (node) {
-		info = edma_setup_info_from_dt(dev, node);
+		ninfo[0] = edma_setup_info_from_dt(dev, node);
 		if (IS_ERR(info)) {
 			dev_err(dev, "failed to get DT data\n");
 			return PTR_ERR(info);
-- 
1.7.9.5
