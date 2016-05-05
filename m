From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  5 May 2016 14:29:43 +0100
Subject: [PATCH 5/5] remoteproc: core: Clip carveout if it's too big
In-Reply-To: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1462454983-13168-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Carveout size is primarily extracted from the firmware binary.  However,
DT can over-ride this by providing a different (smaller) size.  We're
adding protection here to ensure the we only allocate the smaller of the
two provided sizes in order to decrease the risk of clashes.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 3d9798c..c3cad708 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -577,6 +577,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
 	struct rproc_mem_entry *carveout, *mapping;
 	struct device *dev = &rproc->dev;
 	struct device *dma_dev;
+	struct rproc_subdev *sub;
 	dma_addr_t dma;
 	void *va;
 	int ret;
@@ -600,6 +601,14 @@ static int rproc_handle_carveout(struct rproc *rproc,
 		return -ENOMEM;
 
 	dma_dev = rproc_subdev_lookup(rproc, "carveout");
+	sub = dev_get_drvdata(dma_dev);
+
+	if (rsc->len > resource_size(sub->res)) {
+		dev_warn(dev, "carveout too big (0x%x): clipping to 0x%x\n",
+			 rsc->len, resource_size(sub->res));
+		rsc->len = resource_size(sub->res);
+	}
+
 	va = dma_alloc_coherent(dma_dev, rsc->len, &dma, GFP_KERNEL);
 	if (!va) {
 		dev_err(dev->parent, "dma_alloc_coherent err: %d\n", rsc->len);
-- 
2.8.0
