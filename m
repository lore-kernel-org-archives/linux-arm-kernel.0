From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 01 Aug 2013 23:06:11 +0100
Subject: [PATCH RFC 32/51] DMA-API: mmc: sdhci-acpi: use
 dma_coerce_mask_and_coherent()
In-Reply-To: <20130801213420.GL23006@n2100.arm.linux.org.uk>
References: <20130801213420.GL23006@n2100.arm.linux.org.uk>
Message-ID: <E1V510d-0006so-6W@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code sequence:
	dev->dma_mask = &dev->coherent_dma_mask;
	dev->coherent_dma_mask = dma_mask;
bypasses the architectures check on the DMA mask.  It can be replaced
with dma_coerce_mask_and_coherent(), avoiding the direct initialization
of this mask.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-acpi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index cdd4ce0..ef19874 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -310,8 +310,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 			dma_mask = DMA_BIT_MASK(32);
 		}
 
-		dev->dma_mask = &dev->coherent_dma_mask;
-		dev->coherent_dma_mask = dma_mask;
+		err = dma_coerce_mask_and_coherent(dev, dma_mask);
+		if (err)
+			goto err_free;
 	}
 
 	if (c->slot) {
-- 
1.7.4.4
