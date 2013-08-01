From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 01 Aug 2013 23:03:10 +0100
Subject: [PATCH RFC 29/51] DMA-API: ata: pata_octeon_cf: convert to use
 dma_coerce_mask_and_coherent()
In-Reply-To: <20130801213420.GL23006@n2100.arm.linux.org.uk>
References: <20130801213420.GL23006@n2100.arm.linux.org.uk>
Message-ID: <E1V50xi-0006sT-OX@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert this code sequence:
	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
to use dma_coerce_mask_and_coherent() to avoid bypassing the architecture
check on the DMA mask.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/ata/pata_octeon_cf.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index e73bef3..4c393a3 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -1014,8 +1014,9 @@ static int octeon_cf_probe(struct platform_device *pdev)
 	}
 	cf_port->c0 = ap->ioaddr.ctl_addr;
 
-	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
-	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	rv = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (rv)
+		return ret;
 
 	ata_port_desc(ap, "cmd %p ctl %p", base, ap->ioaddr.ctl_addr);
 
-- 
1.7.4.4
