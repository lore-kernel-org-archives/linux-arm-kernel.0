From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 20:10:16 +0200
Subject: [PATCH 01/44] firmware/ivc: use dma_mapping_error
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Message-ID: <20170616181059.19206-2-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA_ERROR_CODE is not supposed to be used by drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/firmware/tegra/ivc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/tegra/ivc.c b/drivers/firmware/tegra/ivc.c
index 29ecfd815320..a01461d63f68 100644
--- a/drivers/firmware/tegra/ivc.c
+++ b/drivers/firmware/tegra/ivc.c
@@ -646,12 +646,12 @@ int tegra_ivc_init(struct tegra_ivc *ivc, struct device *peer, void *rx,
 	if (peer) {
 		ivc->rx.phys = dma_map_single(peer, rx, queue_size,
 					      DMA_BIDIRECTIONAL);
-		if (ivc->rx.phys == DMA_ERROR_CODE)
+		if (dma_mapping_error(peer, ivc->rx.phys))
 			return -ENOMEM;
 
 		ivc->tx.phys = dma_map_single(peer, tx, queue_size,
 					      DMA_BIDIRECTIONAL);
-		if (ivc->tx.phys == DMA_ERROR_CODE) {
+		if (dma_mapping_error(peer, ivc->tx.phys)) {
 			dma_unmap_single(peer, ivc->rx.phys, queue_size,
 					 DMA_BIDIRECTIONAL);
 			return -ENOMEM;
-- 
2.11.0
