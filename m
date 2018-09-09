From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun,  9 Sep 2018 21:10:14 +0200
Subject: [PATCH v2 3/4] media: cedrus: Wrap PHYS_PFN_OFFSET with ifdef and add
 dedicated comment
In-Reply-To: <20180909191015.20902-1-contact@paulk.fr>
References: <20180909191015.20902-1-contact@paulk.fr>
Message-ID: <20180909191015.20902-4-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since PHYS_PFN_OFFSET is not defined for all architectures, it is
requried to wrap it with ifdef so that it can be built on all
architectures.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index f4307e8f7908..32adbcbe6175 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -199,8 +199,13 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 	/*
 	 * The VPU is only able to handle bus addresses so we have to subtract
 	 * the RAM offset to the physcal addresses.
+	 *
+	 * This information will eventually be obtained from device-tree.
 	 */
+
+#ifdef PHYS_PFN_OFFSET
 	dev->dev->dma_pfn_offset = PHYS_PFN_OFFSET;
+#endif
 
 	ret = of_reserved_mem_device_init(dev->dev);
 	if (ret && ret != -ENODEV) {
-- 
2.18.0
