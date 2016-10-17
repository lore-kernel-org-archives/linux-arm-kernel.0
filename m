From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 17 Oct 2016 16:26:23 +0100
Subject: [PATCH] Documentation: DMA-API: Clarify semantics of
 dma_set_mask_and_coherent
Message-ID: <20161017152623.7649-1-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma mapping api howto gives the impression that using the
dma_set_mask_and_coherent (and related DMA APIs) will cause the kernel
to check all the components in the path from the device to memory for
addressing restrictions. In systems with address translations between
the device and memory (e.g., when using IOMMU), this implies that a
successful call to set set dma mask has checked the addressing
constraints of the intermediaries as well.

For the IOMMU drivers in the tree, the check is actually performed while
allocating the DMA buffer rather than when the DMA mask is
configured. For MMUs that do not support the full device addressing
capability, the allocations are made from a reduced address space.

Update the documentation to clarify that even though the call to
dma_set_mask_and_coherent succeeds, it may not be possible to use the
full addressing capability of the device.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/DMA-API-HOWTO.txt | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
index 979228b..240d1ee 100644
--- a/Documentation/DMA-API-HOWTO.txt
+++ b/Documentation/DMA-API-HOWTO.txt
@@ -159,39 +159,46 @@ support 64-bit addressing (DAC) for all transactions.  And at least
 one platform (SGI SN2) requires 64-bit consistent allocations to
 operate correctly when the IO bus is in PCI-X mode.
 
-For correct operation, you must interrogate the kernel in your device
-probe routine to see if the DMA controller on the machine can properly
-support the DMA addressing limitation your device has.  It is good
+For correct operation, you must inform the kernel in your device probe
+routine to see if the DMA controller on the machine can properly
+support the DMA addressing capabilities your device has.  It is good
 style to do this even if your device holds the default setting,
 because this shows that you did think about these issues wrt. your
 device.
 
-The query is performed via a call to dma_set_mask_and_coherent():
+The call to inform the kernel is performed via a call to
+dma_set_mask_and_coherent():
 
 	int dma_set_mask_and_coherent(struct device *dev, u64 mask);
 
-which will query the mask for both streaming and coherent APIs together.
-If you have some special requirements, then the following two separate
-queries can be used instead:
+which will set the mask for both streaming and coherent APIs together.
+If there are some special requirements, then the following two
+separate functions can be used instead:
 
-	The query for streaming mappings is performed via a call to
-	dma_set_mask():
+	The configuration for streaming mappings is performed via a
+	call to dma_set_mask():
 
 		int dma_set_mask(struct device *dev, u64 mask);
 
-	The query for consistent allocations is performed via a call
-	to dma_set_coherent_mask():
+	The configuration for consistent allocations is performed via
+	a call to dma_set_coherent_mask():
 
 		int dma_set_coherent_mask(struct device *dev, u64 mask);
 
 Here, dev is a pointer to the device struct of your device, and mask
 is a bit mask describing which bits of an address your device
 supports.  It returns zero if your card can perform DMA properly on
-the machine given the address mask you provided.  In general, the
-device struct of your device is embedded in the bus-specific device
-struct of your device.  For example, &pdev->dev is a pointer to the
-device struct of a PCI device (pdev is a pointer to the PCI device
-struct of your device).
+the machine given the address mask you provided.  Subsequent to
+calling the above apis, DMA allocations will be made from address
+space that conforms to the mask.  The DMA allocation space maybe
+further restricted if devices along the patch to memory have stricter
+addressing requirements than the device performing the DMA, e.g.,
+IOMMU.
+
+In general, the device struct of your device is embedded in the
+bus-specific device struct of your device.  For example, &pdev->dev is
+a pointer to the device struct of a PCI device (pdev is a pointer to
+the PCI device struct of your device).
 
 If it returns non-zero, your device cannot perform DMA properly on
 this platform, and attempting to do so will result in undefined
-- 
2.9.3
