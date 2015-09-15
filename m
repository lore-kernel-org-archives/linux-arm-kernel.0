From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 15 Sep 2015 05:37:07 +0000
Subject: [PATCH 1/3] drivers:remoteproc:support predefined vq notifyid
In-Reply-To: <1442295429-19137-1-git-send-email-21cnbao@gmail.com>
References: <1442295429-19137-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1442295429-19137-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Chen <Wei.Chen@csr.com>

In current rproc use scenario, the vq notifyid
will be allocated by Linux, and write back this
notifyid to RSC table to tell DSP.

But in some scenarios, we might meet the DSP
predefined the vq notifyid. In these scenarios,
the rproc have to read predefined vq notifyid
from RSC table, and then request a same notifyid
in Linux side.

Signed-off-by: Wei Chen <Wei.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/remoteproc/remoteproc_core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 8b3130f..8f82417 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -206,7 +206,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	struct fw_rsc_vdev *rsc;
 	dma_addr_t dma;
 	void *va;
-	int ret, size, notifyid;
+	int ret, size, notifyid, pre_nid;
 
 	/* actual size of vring (in bytes) */
 	size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
@@ -222,11 +222,16 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	}
 
 	/*
+	 * read predefined notifyids (via resource table)
+	 */
+	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
+	pre_nid = rsc->vring[i].notifyid;
+
+	/*
 	 * Assign an rproc-wide unique index for this vring
 	 * TODO: assign a notifyid for rvdev updates as well
-	 * TODO: support predefined notifyids (via resource table)
 	 */
-	ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
+	ret = idr_alloc(&rproc->notifyids, rvring, pre_nid, 0, GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(dev, "idr_alloc failed: %d\n", ret);
 		dma_free_coherent(dev->parent, size, va, dma);
@@ -247,9 +252,10 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	 * set up the iommu. In this case the device address (da) will
 	 * hold the physical address and not the device address.
 	 */
-	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
 	rsc->vring[i].da = dma;
-	rsc->vring[i].notifyid = notifyid;
+	/* If notifyid is not predefined, write back to rsc */
+	if (!pre_nid)
+		rsc->vring[i].notifyid = notifyid;
 	return 0;
 }
 
-- 
1.9.1
