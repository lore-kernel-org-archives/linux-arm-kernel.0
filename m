From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  5 May 2016 14:29:42 +0100
Subject: [PATCH 4/5] remoteproc: core: Supply framework to request,
 declare and fetch shared memory
In-Reply-To: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1462454983-13168-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Normally used for management of; carveout, devmem and trace memory.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 174 +++++++++++++++++++++++++++++++++--
 1 file changed, 167 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 03720c0..3d9798c 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -209,6 +209,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 {
 	struct rproc *rproc = rvdev->rproc;
 	struct device *dev = &rproc->dev;
+	struct device *dma_dev;
 	struct rproc_vring *rvring = &rvdev->vring[i];
 	struct fw_rsc_vdev *rsc;
 	dma_addr_t dma;
@@ -222,7 +223,8 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	 * Allocate non-cacheable memory for the vring. In the future
 	 * this call will also configure the IOMMU for us
 	 */
-	va = dma_alloc_coherent(dev->parent, size, &dma, GFP_KERNEL);
+	dma_dev = rproc_subdev_lookup(rproc, "vring");
+	va = dma_alloc_coherent(dma_dev, size, &dma, GFP_KERNEL);
 	if (!va) {
 		dev_err(dev->parent, "dma_alloc_coherent failed\n");
 		return -EINVAL;
@@ -236,7 +238,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(dev, "idr_alloc failed: %d\n", ret);
-		dma_free_coherent(dev->parent, size, va, dma);
+		dma_free_coherent(dma_dev, size, va, dma);
 		return ret;
 	}
 	notifyid = ret;
@@ -297,8 +299,10 @@ void rproc_free_vring(struct rproc_vring *rvring)
 	struct rproc *rproc = rvring->rvdev->rproc;
 	int idx = rvring->rvdev->vring - rvring;
 	struct fw_rsc_vdev *rsc;
+	struct device *dma_dev;
 
-	dma_free_coherent(rproc->dev.parent, size, rvring->va, rvring->dma);
+	dma_dev = rproc_subdev_lookup(rproc, "vring");
+	dma_free_coherent(dma_dev, size, rvring->va, rvring->dma);
 	idr_remove(&rproc->notifyids, rvring->notifyid);
 
 	/* reset resource entry info */
@@ -572,6 +576,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
 {
 	struct rproc_mem_entry *carveout, *mapping;
 	struct device *dev = &rproc->dev;
+	struct device *dma_dev;
 	dma_addr_t dma;
 	void *va;
 	int ret;
@@ -594,7 +599,8 @@ static int rproc_handle_carveout(struct rproc *rproc,
 	if (!carveout)
 		return -ENOMEM;
 
-	va = dma_alloc_coherent(dev->parent, rsc->len, &dma, GFP_KERNEL);
+	dma_dev = rproc_subdev_lookup(rproc, "carveout");
+	va = dma_alloc_coherent(dma_dev, rsc->len, &dma, GFP_KERNEL);
 	if (!va) {
 		dev_err(dev->parent, "dma_alloc_coherent err: %d\n", rsc->len);
 		ret = -ENOMEM;
@@ -682,7 +688,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
 free_mapping:
 	kfree(mapping);
 dma_free:
-	dma_free_coherent(dev->parent, rsc->len, va, dma);
+	dma_free_coherent(dma_dev, rsc->len, va, dma);
 free_carv:
 	kfree(carveout);
 	return ret;
@@ -766,6 +772,7 @@ static void rproc_resource_cleanup(struct rproc *rproc)
 {
 	struct rproc_mem_entry *entry, *tmp;
 	struct device *dev = &rproc->dev;
+	struct device *dma_dev;
 
 	/* clean up debugfs trace entries */
 	list_for_each_entry_safe(entry, tmp, &rproc->traces, node) {
@@ -791,9 +798,9 @@ static void rproc_resource_cleanup(struct rproc *rproc)
 	}
 
 	/* clean up carveout allocations */
+	dma_dev = rproc_subdev_lookup(rproc, "carveout");
 	list_for_each_entry_safe(entry, tmp, &rproc->carveouts, node) {
-		dma_free_coherent(dev->parent, entry->len, entry->va,
-				  entry->dma);
+		dma_free_coherent(dma_dev, entry->len, entry->va, entry->dma);
 		list_del(&entry->node);
 		kfree(entry);
 	}
@@ -1329,6 +1336,156 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
 #endif
 EXPORT_SYMBOL(rproc_get_by_phandle);
 
+/*
+ * resource structure of rproc_subdev is used for identify the right subdevice
+ * that has the dma coherent memory.
+ */
+static int rproc_subdev_match(struct device *dev, void *data)
+{
+	char *sub_name;
+
+	if (!dev_name(dev))
+		return 0;
+
+	sub_name = strpbrk(dev_name(dev), "#");
+	if (!sub_name)
+		return 0;
+
+	return !strcmp(++sub_name, (char *)data);
+}
+
+/*
+ * find the subdevice child dma coherent memory that match with name region
+ * the rproc parent is the default device, if there is no match
+ */
+struct device *rproc_subdev_lookup(struct rproc *rproc, const char *name)
+{
+	struct device *dev;
+
+	dev = device_find_child(rproc->dev.parent, (void *)name,
+				rproc_subdev_match);
+	if (dev) {
+		/* decrement the matched device's refcount back */
+		put_device(dev);
+		return dev;
+	}
+
+	return rproc->dev.parent;
+}
+EXPORT_SYMBOL(rproc_subdev_lookup);
+
+/**
+ * rproc_subdev_release() - release the existence of a subdevice
+ *
+ * @dev: the subdevice's dev
+ */
+static void rproc_subdev_release(struct device *dev)
+{
+	struct rproc_subdev *sub = to_subdevice(dev);
+
+	kfree(sub);
+}
+
+/**
+ * rproc_subdev_unregister() - unregister sub-device of remote processor
+ *
+ * @dev: rproc sub-device
+ * @data: Not use (just to be compliant with device_for_each_child)
+ *
+ * This function is called by device_for_each_child function when unregister
+ * remote processor.
+ */
+static int rproc_subdev_unregister(struct device *dev, void *data)
+{
+	struct rproc_subdev *sub = to_subdevice(dev);
+	struct rproc *rproc = data;
+
+	if (dev != &(rproc->dev))
+		rproc_subdev_del(sub);
+	return 0;
+}
+
+/**
+ * rproc_subdev_add() - add a sub-device on remote processor
+ *
+ * @rproc: the parent remote processor
+ * @res: resource allow to define the dma coherent memory of sub-device
+ *
+ * This function add a sub-device child on rproc parent. This sub-device allow
+ * to define a new dma coherent memory area. when the rproc would alloc a
+ * dma coherent memory it's find the subdevice that match with physical memory
+ * asked (if there is no children that match, the rproc is the default device)
+ *
+ * Returns the sub-device handle on success, and error on failure.
+ */
+struct rproc_subdev *rproc_subdev_add(struct rproc *rproc, struct resource *res)
+{
+	struct rproc_subdev *sub;
+	int ret;
+
+	if (!res || res->flags != IORESOURCE_MEM || res->name == NULL) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	sub = kzalloc(sizeof(*sub), GFP_KERNEL);
+	if (!sub) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	sub->rproc = rproc;
+	sub->res = res;
+	sub->dev.parent = rproc->dev.parent;
+	sub->dev.release = rproc_subdev_release;
+	dev_set_name(&sub->dev, "%s#%s", dev_name(sub->dev.parent), res->name);
+	dev_set_drvdata(&sub->dev, sub);
+
+	ret = device_register(&sub->dev);
+	if (ret)
+		goto err_dev;
+
+	if (!devm_request_mem_region(&sub->dev, res->start,
+				     resource_size(res),
+				     dev_name(&sub->dev))) {
+		dev_err(&rproc->dev, "failed to get memory region\n");
+		ret = -EINVAL;
+		goto err_dev;
+	}
+
+	ret = dmam_declare_coherent_memory(&sub->dev,
+					   res->start, res->start,
+					   resource_size(res),
+					   DMA_MEMORY_MAP |
+					   DMA_MEMORY_EXCLUSIVE);
+	if (ret < 0)
+		goto err_dev;
+
+	return sub;
+
+err_dev:
+	put_device(&sub->dev);
+err:
+	dev_err(&rproc->dev, "unable to register subdev %s, err = %d\n",
+		(res && res->name) ? res->name : "unnamed", ret);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(rproc_subdev_add);
+
+/**
+ * rproc_subdev_del() - delete a sub-device of remote processor
+ *
+ * @subdev: rproc sub-device
+ */
+void rproc_subdev_del(struct rproc_subdev *subdev)
+{
+	if (get_device(&subdev->dev)) {
+		device_unregister(&subdev->dev);
+		put_device(&subdev->dev);
+	}
+}
+EXPORT_SYMBOL(rproc_subdev_del);
+
 /**
  * rproc_set_fw_name() - change rproc fw name
  * @rproc: rproc handle
@@ -1618,6 +1775,9 @@ int rproc_del(struct rproc *rproc)
 	kfree(rproc->cached_table);
 	rproc->cached_table = NULL;
 
+	device_for_each_child(rproc->dev.parent, rproc,
+			      rproc_subdev_unregister);
+
 	/* the rproc is downref'ed as soon as it's removed from the klist */
 	mutex_lock(&rproc_list_mutex);
 	list_del(&rproc->node);
-- 
2.8.0
