From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 28 Jul 2015 15:19:51 +0200
Subject: [PATCH v2 20/22] dma: of: Probe DMA controllers on demand
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438089593-7696-21-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a DMA controller through its firmware node, probe it if
it hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/dma/of-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 1e1f2986eba8..de411a6a63af 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -263,6 +263,8 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 		if (of_dma_match_channel(np, name, i, &dma_spec))
 			continue;
 
+		fwnode_ensure_device(&dma_spec.np->fwnode);
+
 		mutex_lock(&of_dma_lock);
 		ofdma = of_dma_find_controller(&dma_spec);
 
-- 
2.4.3
