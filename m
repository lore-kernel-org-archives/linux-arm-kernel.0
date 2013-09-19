From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 19 Sep 2013 22:57:02 +0100
Subject: [PATCH 32/51] DMA-API: mmc: sdhci-acpi: use
 dma_coerce_mask_and_coherent()
In-Reply-To: <20130919212235.GD12758@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
Message-ID: <E1VMmDe-0007j6-Tj@rmk-PC.arm.linux.org.uk>
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
