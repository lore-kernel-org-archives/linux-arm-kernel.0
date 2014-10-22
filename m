From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Oct 2014 17:43:25 +0200
Subject: [PATCH v3 11/59] dmaengine: Move slave caps to dma_device
In-Reply-To: <1413992653-21963-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413992653-21963-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413992653-21963-12-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous code was relying on the fact that the slave_caps were to be
defined on a per channel basis.

However, this proved to be a bit overkill, since every driver filling these so
far were hardcoding it, disregarding which channel was actually given.

Add these capabilities to the dma_device structure, so that drivers can just
provide them at probe time, and be done with it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 include/linux/dmaengine.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 6b74d9d8977e..98f8163dfbac 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -593,6 +593,14 @@ struct dma_tx_state {
  * @fill_align: alignment shift for memset operations
  * @dev_id: unique device ID
  * @dev: struct device reference for dma mapping api
+ * @src_addr_widths: bit mask of src addr widths the device supports
+ * @dst_addr_widths: bit mask of dst addr widths the device supports
+ * @directions: bit mask of slave direction the device supports since
+ * 	the enum dma_transfer_direction is not defined as bits for
+ * 	each type of direction, the dma controller should fill (1 <<
+ * 	<TYPE>) and same should be checked by controller as well
+ * @residue_granularity: granularity of the transfer residue reported
+ *	by tx_status
  * @device_alloc_chan_resources: allocate resources and return the
  *	number of allocated descriptors
  * @device_free_chan_resources: release DMA channel's resources
@@ -643,6 +651,10 @@ struct dma_device {
 	struct device *dev;
 
 	bool generic_slave_caps;
+	u32 src_addr_widths;
+	u32 dst_addr_widths;
+	u32 directions;
+	enum dma_residue_granularity residue_granularity;
 
 	int (*device_alloc_chan_resources)(struct dma_chan *chan);
 	void (*device_free_chan_resources)(struct dma_chan *chan);
@@ -807,6 +819,11 @@ static inline int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_cap
 	if (device->generic_slave_caps)
 		return -ENXIO;
 
+	caps->src_addr_widths = device->src_addr_widths;
+	caps->dst_addr_widths = device->dst_addr_widths;
+	caps->directions = device->directions;
+	caps->residue_granularity = device->residue_granularity;
+
 	caps->cmd_pause = !!device->device_pause;
 	caps->cmd_terminate = !!device->device_terminate_all;
 
-- 
2.1.1
