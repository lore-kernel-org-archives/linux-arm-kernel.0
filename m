From: dhdang@apm.com (Duc Dang)
Date: Fri,  7 Aug 2015 20:18:48 -0700
Subject: [PATCH v5 1/2] usb: make xhci platform driver use 64 bit or 32 bit DMA
In-Reply-To: <CADaLNDkU14GCPZE_zNt_9kMSsUdywyNp1QCiWpokXQgbfRS0qw@mail.gmail.com>
References: <CADaLNDkU14GCPZE_zNt_9kMSsUdywyNp1QCiWpokXQgbfRS0qw@mail.gmail.com>
Message-ID: <74fe0b014334a5ac1db90dec46bdbf6c30c07895.1439002338.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The xhci platform driver needs to work on systems that
either only support 64-bit DMA or only support 32-bit DMA.
Attempt to set a coherent dma mask for 64-bit DMA, and
attempt again with 32-bit DMA if that fails.

[dhdang: Regenerate the patch over 4.2-rc5]
Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Duc Dang <dhdang@apm.com>

---
Changes from v4:
	None

Changes from v3:
        Re-generate the patch over 4.2-rc5
        No code change.

Changes from v2:
        None

Changes from v1:
        Consolidated to use dma_set_mask_and_coherent
        Got rid of the check against sizeof(dma_addr_t)

 drivers/usb/host/xhci-plat.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 890ad9d..5d03f8b 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -93,14 +93,14 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENODEV;
 
-	/* Initialize dma_mask and coherent_dma_mask to 32-bits */
-	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
-	else
-		dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+	/* Try setting the coherent_dma_mask to 64 bits, then try 32 bits */
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (ret)
+			return ret;
+	}
+
 
 	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd)
-- 
1.9.1
