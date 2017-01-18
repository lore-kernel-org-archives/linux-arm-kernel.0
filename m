From: roy.pledge@nxp.com (Roy Pledge)
Date: Wed, 18 Jan 2017 17:39:31 -0500
Subject: [PATCH 01/10] soc/qbman: Use portable mapping for the FQD reserved
 memory
In-Reply-To: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1484779180-1344-2-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Claudiu Manoil <claudiu.manoil@nxp.com>

Use memremap/memset to zero the private QBMan areas to ensure
portability.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/qman_ccsr.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index f4e6e70d..43feaa9 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -441,16 +441,14 @@ static unsigned int qm_get_fqid_maxcnt(void)
 static int zero_priv_mem(struct device *dev, struct device_node *node,
 			 phys_addr_t addr, size_t sz)
 {
-	/* map as cacheable, non-guarded */
-	void __iomem *tmpp = ioremap_prot(addr, sz, 0);
-
+	void *tmpp = memremap(addr, sz, MEMREMAP_WB);
 	if (!tmpp)
 		return -ENOMEM;
 
-	memset_io(tmpp, 0, sz);
+	memset(tmpp, 0, sz);
 	flush_dcache_range((unsigned long)tmpp,
 			   (unsigned long)tmpp + sz);
-	iounmap(tmpp);
+	memunmap(tmpp);
 
 	return 0;
 }
-- 
1.7.9.5
