From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 25 May 2015 16:53:24 +0200
Subject: [PATCH 20/21] dma: of: Probe DMA controllers on demand
In-Reply-To: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1432565608-26036-21-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a DMA controller through its DT node, ensure that the
corresponding device has been registered.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/dma/of-dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index cbd4a8a..2bdb3da 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
+#include <linux/of_platform.h>
 
 static LIST_HEAD(of_dma_list);
 static DEFINE_MUTEX(of_dma_lock);
@@ -174,6 +175,8 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 		if (of_dma_match_channel(np, name, i, &dma_spec))
 			continue;
 
+		of_platform_device_ensure(dma_spec.np);
+
 		mutex_lock(&of_dma_lock);
 		ofdma = of_dma_find_controller(&dma_spec);
 
-- 
2.4.1
