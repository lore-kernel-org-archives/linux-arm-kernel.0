From: robin.murphy@arm.com (Robin Murphy)
Date: Wed,  7 Nov 2018 16:30:32 +0000
Subject: [PATCH v2] of/device: Really only set bus DMA mask when appropriate
Message-ID: <43b231d67abf2dc589af1c3b9d4f01211cda0b89.1541608043.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_dma_configure() was *supposed* to be following the same logic as
acpi_dma_configure() and only setting bus_dma_mask if some range was
specified by the firmware. However, it seems that subtlety got lost in
the process of fitting it into the differently-shaped control flow, and
as a result the force_dma==true case ends up always setting the bus mask
to the 32-bit default, which is not what anyone wants.

Make sure we only touch it if the DT actually said so.

Fixes: 6c2fb2ea7636 ("of/device: Set bus DMA mask as appropriate")
Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Tested-by: John Stultz <john.stultz@linaro.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Robert Richter <robert.richter@cavium.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

 v2: Add comment, collect tested-by tags

 drivers/of/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 0f27fad9fe94..5592437bb3d1 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -149,9 +149,11 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	 * set by the driver.
 	 */
 	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
-	dev->bus_dma_mask = mask;
 	dev->coherent_dma_mask &= mask;
 	*dev->dma_mask &= mask;
+	/* ...but only set bus mask if we found valid dma-ranges earlier */
+	if (!ret)
+		dev->bus_dma_mask = mask;
 
 	coherent = of_dma_is_coherent(np);
 	dev_dbg(dev, "device is%sdma coherent\n",
-- 
2.19.1.dirty
