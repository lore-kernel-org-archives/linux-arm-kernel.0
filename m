From: roy.pledge@nxp.com (Roy Pledge)
Date: Wed, 18 Jan 2017 17:39:36 -0500
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for flush_dcache_range()
In-Reply-To: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1484779180-1344-7-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Claudiu Manoil <claudiu.manoil@nxp.com>

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/qman_ccsr.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 43feaa9..67ae073 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -446,8 +446,14 @@ static int zero_priv_mem(struct device *dev, struct device_node *node,
 		return -ENOMEM;
 
 	memset(tmpp, 0, sz);
+#ifdef CONFIG_PPC
 	flush_dcache_range((unsigned long)tmpp,
 			   (unsigned long)tmpp + sz);
+#elif defined(CONFIG_ARM)
+	__cpuc_flush_dcache_area(tmpp, sz);
+#elif defined(CONFIG_ARM64)
+	__flush_dcache_area(tmpp, sz);
+#endif
 	memunmap(tmpp);
 
 	return 0;
-- 
1.7.9.5
