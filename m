From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 29 Jun 2013 23:55:23 +0100
Subject: [PATCH RFC 3/3] DRM: Armada: support for dma_buf import into gem
In-Reply-To: <20130629225210.GF3353@n2100.arm.linux.org.uk>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
Message-ID: <E1Ut439-0000wv-2e@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support importing certain dma_bufs back into gem - notably those which
are either contiguous or are our own exports which do not use
dma_map_sg().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/armada_drv.c |    4 +-
 drivers/gpu/drm/armada/armada_fb.c  |    6 +++
 drivers/gpu/drm/armada/armada_gem.c |   81 ++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/armada/armada_gem.h |    4 ++
 4 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index e0a08e9..268ea28 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -311,9 +311,9 @@ static struct drm_driver armada_drm_driver = {
 	.gem_init_object	= NULL,
 	.gem_free_object	= armada_gem_free_object,
 	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle	= NULL,
+	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
 	.gem_prime_export	= armada_gem_prime_export,
-	.gem_prime_import	= NULL,
+	.gem_prime_import	= armada_gem_prime_import,
 	.dumb_create		= armada_gem_dumb_create,
 	.dumb_map_offset	= armada_gem_dumb_map_offset,
 	.dumb_destroy		= armada_gem_dumb_destroy,
diff --git a/drivers/gpu/drm/armada/armada_fb.c b/drivers/gpu/drm/armada/armada_fb.c
index 5154f04..28965e3 100644
--- a/drivers/gpu/drm/armada/armada_fb.c
+++ b/drivers/gpu/drm/armada/armada_fb.c
@@ -120,6 +120,12 @@ static struct drm_framebuffer *armada_fb_create(struct drm_device *dev,
 		return ERR_PTR(-ENOENT);
 	}
 
+	if (obj->obj.import_attach && !obj->sgt) {
+		ret = armada_gem_map_import(obj);
+		if (ret)
+			goto unref;
+	}
+
 	/* Framebuffer objects must have a valid device address for scanout */
 	if (obj->dev_addr == DMA_ERROR_CODE) {
 		ret = -EINVAL;
diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index d09fa14..ad517ce 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -70,6 +70,12 @@ void armada_gem_free_object(struct drm_gem_object *obj)
 			iounmap(dobj->addr);
 	}
 
+	if (dobj->obj.import_attach) {
+		/* We only ever display imported data */
+		dma_buf_unmap_attachment(dobj->obj.import_attach, dobj->sgt,
+					 DMA_TO_DEVICE);
+		drm_prime_gem_destroy(&dobj->obj, NULL);
+	}
 
 	drm_gem_object_release(&dobj->obj);
 
@@ -270,6 +276,12 @@ int armada_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
 		goto err_unlock;
 	}
 
+	/* Don't allow imported objects to be mapped */
+	if (obj->obj.import_attach) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
 	if (!obj->obj.map_list.map)
 		ret = drm_gem_create_mmap_offset(&obj->obj);
 
@@ -537,5 +549,72 @@ armada_gem_prime_export(struct drm_device *dev, struct drm_gem_object *obj,
 	int flags)
 {
 	return dma_buf_export(obj, &armada_gem_prime_dmabuf_ops, obj->size,
-			      flags);
+			      O_RDWR);
+}
+
+struct drm_gem_object *
+armada_gem_prime_import(struct drm_device *dev, struct dma_buf *buf)
+{
+	struct dma_buf_attachment *attach;
+	struct armada_gem_object *dobj;
+
+	if (buf->ops == &armada_gem_prime_dmabuf_ops) {
+		struct drm_gem_object *obj = buf->priv;
+		if (obj->dev == dev) {
+			/*
+			 * Importing our own dmabuf(s) increases the
+			 * refcount on the gem object itself.
+			 */
+			drm_gem_object_reference(obj);
+			dma_buf_put(buf);
+			return obj;
+		}
+	}
+
+	attach = dma_buf_attach(buf, dev->dev);
+	if (IS_ERR(attach))
+		return ERR_CAST(attach);
+
+	dobj = armada_gem_alloc_private_object(dev, buf->size);
+	if (!dobj) {
+		dma_buf_detach(buf, attach);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	dobj->obj.import_attach = attach;
+
+	/*
+	 * Don't call dma_buf_map_attachment() here - it maps the
+	 * scatterlist immediately for DMA, and this is not always
+	 * an appropriate thing to do.
+	 */
+	return &dobj->obj;
+}
+
+int armada_gem_map_import(struct armada_gem_object *dobj)
+{
+	int ret;
+
+	dobj->sgt = dma_buf_map_attachment(dobj->obj.import_attach,
+					  DMA_TO_DEVICE);
+	if (!dobj->sgt) {
+		DRM_ERROR("dma_buf_map_attachment() returned NULL\n");
+		return -EINVAL;
+	}
+	if (IS_ERR(dobj->sgt)) {
+		ret = PTR_ERR(dobj->sgt);
+		dobj->sgt = NULL;
+		DRM_ERROR("dma_buf_map_attachment() error: %d\n", ret);
+		return ret;
+	}
+	if (dobj->sgt->nents > 1) {
+		DRM_ERROR("dma_buf_map_attachment() returned an (unsupported) scattered list\n");
+		return -EINVAL;
+	}
+	if (sg_dma_len(dobj->sgt->sgl) < dobj->obj.size) {
+		DRM_ERROR("dma_buf_map_attachment() returned a small buffer\n");
+		return -EINVAL;
+	}
+	dobj->dev_addr = sg_dma_address(dobj->sgt->sgl);
+	return 0;
 }
diff --git a/drivers/gpu/drm/armada/armada_gem.h b/drivers/gpu/drm/armada/armada_gem.h
index e3bce9f..00b6cd4 100644
--- a/drivers/gpu/drm/armada/armada_gem.h
+++ b/drivers/gpu/drm/armada/armada_gem.h
@@ -16,6 +16,7 @@ struct armada_gem_object {
 	resource_size_t		dev_addr;
 	struct drm_mm_node	*linear;	/* for linear backed */
 	struct page		*page;		/* for page backed */
+	struct sg_table		*sgt;		/* for imported */
 	void			(*update)(void *);
 	void			*update_data;
 };
@@ -37,6 +38,9 @@ int armada_gem_dumb_destroy(struct drm_file *, struct drm_device *,
 	uint32_t);
 struct dma_buf *armada_gem_prime_export(struct drm_device *dev,
 	struct drm_gem_object *obj, int flags);
+struct drm_gem_object *armada_gem_prime_import(struct drm_device *,
+	struct dma_buf *);
+int armada_gem_map_import(struct armada_gem_object *);
 
 static inline struct armada_gem_object *armada_gem_object_lookup(
 	struct drm_device *dev, struct drm_file *dfile, unsigned handle)
-- 
1.7.4.4
