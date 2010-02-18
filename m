From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 18 Feb 2010 14:29:09 +0530
Subject: [PATCH 4/9] omap: sdma: Limit the secure reserve channel fix for omap3
In-Reply-To: <1266483554-15044-3-git-send-email-santosh.shilimkar@ti.com>
References: <1266483554-15044-1-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-2-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1266483554-15044-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 'ba50ea7e' reserves DMA channels 0 and 1 on high
security devices, in order to avoid collision between kernel
dma transfers and ROM code dma transfers.

This fix is applicable only for OMAP3 so add an appropriate
check.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
CC: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
CC: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/dma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 5ec96db..049165c 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2149,7 +2149,8 @@ static int __init omap_init_dma(void)
 			DMA_SYSCONFIG_AUTOIDLE);
 		dma_write(v , OCP_SYSCONFIG);
 		/* reserve dma channels 0 and 1 in high security devices */
-		if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
+		if (cpu_is_omap34xx() &&
+			(omap_type() != OMAP2_DEVICE_TYPE_GP)) {
 			printk(KERN_INFO "Reserving DMA channels 0 and 1 for "
 					"HS ROM code\n");
 			dma_chan[0].dev_id = 0;
-- 
1.6.0.4
