From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 17 Sep 2015 14:57:13 +0200
Subject: [PATCH v5 19/23] dma: of: Probe DMA controllers on demand
In-Reply-To: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1442494637-3674-20-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a DMA controller through its OF node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/dma/of-dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 1e1f2986eba8..e899832f7df3 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -16,6 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_dma.h>
 
 static LIST_HEAD(of_dma_list);
@@ -263,6 +264,8 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 		if (of_dma_match_channel(np, name, i, &dma_spec))
 			continue;
 
+		of_device_probe(dma_spec.np);
+
 		mutex_lock(&of_dma_lock);
 		ofdma = of_dma_find_controller(&dma_spec);
 
-- 
2.4.3
