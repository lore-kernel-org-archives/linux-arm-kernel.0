From: dhdang@apm.com (Duc Dang)
Date: Thu, 17 Sep 2015 11:19:48 -0700
Subject: [PATCH v8 3/3] usb: xhci: configure 32-bit DMA if the controller does
 not support 64-bit DMA
In-Reply-To: <cover.1442513540.git.dhdang@apm.com>
References: <cover.1442513540.git.dhdang@apm.com>
Message-ID: <8e5db2c671927f55bc40ac50ac0b3a5e78ced245.1442513540.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change avoids DMA error in the cases where dma_mask and
coherent_dma_mask of a 32-bit controller get configured as
DMA_BIT_MASK(64) when running on a 64-bit system.

Signed-off-by: Duc Dang <dhdang@apm.com>
---
 drivers/usb/host/xhci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6b0f4a4..8cb8f39 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4908,6 +4908,16 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 			!dma_set_mask(dev, DMA_BIT_MASK(64))) {
 		xhci_dbg(xhci, "Enabling 64-bit DMA addresses.\n");
 		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
+	} else {
+		/*
+		 * This is to avoid error in cases where a 32-bit USB
+		 * controller is used on a 64-bit capable system.
+		 */
+		retval = dma_set_mask(dev, DMA_BIT_MASK(32));
+		if (retval)
+			return retval;
+		xhci_dbg(xhci, "Enabling 32-bit DMA addresses.\n");
+		dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	}
 
 	xhci_dbg(xhci, "Calling HCD init\n");
-- 
1.9.1
