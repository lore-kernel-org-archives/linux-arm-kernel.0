From: Haiying.Wang@nxp.com (Haiying Wang)
Date: Thu, 20 Apr 2017 15:34:18 -0400
Subject: [PATCH 3/3] bus: fsl-mc: dpio: change CENA regs to be cacheable
In-Reply-To: <1492716858-24509-1-git-send-email-Haiying.Wang@nxp.com>
References: <1492716858-24509-1-git-send-email-Haiying.Wang@nxp.com>
Message-ID: <1492716858-24509-4-git-send-email-Haiying.Wang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

plus non-shareable to meet the performance requirement.
QMan's CENA region contains registers and structures that
are 64byte in size and are inteneded to be accessed using a
single 64 byte bus transaction, therefore this portal
memory should be configured as cache-enabled. Also because
the write allocate stash transcations of QBMan should be
issued as cachable and non-coherent(non-sharable), we
need to configure this region to be non-shareable.

Signed-off-by: Haiying Wang <Haiying.Wang@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
index e36da20..97f909c 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
@@ -168,10 +168,10 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	desc.cpu = next_cpu;
 
 	/*
-	 * Set the CENA regs to be the cache inhibited area of the portal to
-	 * avoid coherency issues if a user migrates to another core.
+	 * Set the CENA regs to be the cache enalbed area of the portal to
+	 * archieve the best performance.
 	 */
-	desc.regs_cena = ioremap_wc(dpio_dev->regions[1].start,
+	desc.regs_cena = ioremap_cache_ns(dpio_dev->regions[1].start,
 		resource_size(&dpio_dev->regions[1]));
 	desc.regs_cinh = ioremap(dpio_dev->regions[1].start,
 		resource_size(&dpio_dev->regions[1]));
-- 
2.7.4
