From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 19 Aug 2015 16:36:31 -0500
Subject: [PATCH 1/2] USB: ehci-platform: Display a DMA configuration error
 message
In-Reply-To: <1440020192-23754-1-git-send-email-jeremy.linton@arm.com>
References: <1440020192-23754-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1440020192-23754-2-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the ehci driver fails to configure the dma settings then display
a dev error instead of simply failing. This is triggered in an
ACPI world if the user fails to set the _CCA on the device.

Tested-by: Huang Shijie <shijie.huang@arm.com>
Reviewed-by: Graeme Gregory <graeme.gregory@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/usb/host/ehci-platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 2593def..3ce38c3 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -162,8 +162,10 @@ static int ehci_platform_probe(struct platform_device *dev)
 
 	err = dma_coerce_mask_and_coherent(&dev->dev,
 		pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
-	if (err)
+	if (err) {
+		dev_err(&dev->dev, "Error: DMA mask configuration failed\n");
 		return err;
+	}
 
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0) {
-- 
2.4.3
