From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 30 Jun 2013 14:53:11 +0100
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130630134151.GJ3353@n2100.arm.linux.org.uk>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630123741.GJ18285@phenom.ffwll.local>
 <20130630130456.GI3353@n2100.arm.linux.org.uk>
 <20130630134151.GJ3353@n2100.arm.linux.org.uk>
Message-ID: <20130630135311.GK3353@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right, so, incrementally, the changes are (this may not entirely apply
to the version I've posted because I have several patches on top of
that.)

I've also added locking to the calls to drm_mm_dump_table() as otherwise
these walk those lists without holding any locks what so ever, which
could mean that a block is removed while we're walking the list.

 drivers/gpu/drm/armada/armada_debugfs.c |   17 ++++++++++--
 drivers/gpu/drm/armada/armada_fb.c      |   43 ++++++++++++++++++-------------
 drivers/gpu/drm/armada/armada_fbdev.c   |   20 ++++++--------
 drivers/gpu/drm/armada/armada_gem.c     |   29 +++++++++++++++------
 4 files changed, 68 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_debugfs.c b/drivers/gpu/drm/armada/armada_debugfs.c
index f42f3ab..60e1038 100644
--- a/drivers/gpu/drm/armada/armada_debugfs.c
+++ b/drivers/gpu/drm/armada/armada_debugfs.c
@@ -23,16 +23,27 @@ static int armada_debugfs_gem_offs_show(struct seq_file *m, void *data)
 	struct drm_info_node *node = m->private;
 	struct drm_device *dev = node->minor->dev;
 	struct drm_gem_mm *mm = dev->mm_private;
+	int ret;
+
+	mutex_lock(&dev->struct_mutex);
+	ret = drm_mm_dump_table(m, &mm->offset_manager);
+	mutex_unlock(&dev->struct_mutex);
 
-	return drm_mm_dump_table(m, &mm->offset_manager);
+	return ret;
 }
 
 static int armada_debugfs_gem_linear_show(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = m->private;
-	struct armada_private *priv = node->minor->dev->dev_private;
+	struct drm_device *dev = node->minor->dev;
+	struct armada_private *priv = dev->dev_private;
+	int ret;
 
-	return drm_mm_dump_table(m, &priv->linear);
+	mutex_lock(&dev->struct_mutex);
+	ret = drm_mm_dump_table(m, &priv->linear);
+	mutex_unlock(&dev->struct_mutex);
+
+	return ret;
 }
 
 static int armada_debugfs_reg_show(struct seq_file *m, void *data)
diff --git a/drivers/gpu/drm/armada/armada_fb.c b/drivers/gpu/drm/armada/armada_fb.c
index 28965e3..97fbd61 100644
--- a/drivers/gpu/drm/armada/armada_fb.c
+++ b/drivers/gpu/drm/armada/armada_fb.c
@@ -79,6 +79,9 @@ struct armada_framebuffer *armada_framebuffer_create(struct drm_device *dev,
 
 	dfb->fmt = format;
 	dfb->mod = config;
+	dfb->obj = obj;
+
+	drm_helper_mode_fill_fb_struct(&dfb->fb, mode);
 
 	ret = drm_framebuffer_init(dev, &dfb->fb, &armada_fb_funcs);
 	if (ret) {
@@ -86,14 +89,13 @@ struct armada_framebuffer *armada_framebuffer_create(struct drm_device *dev,
 		return ERR_PTR(ret);
 	}
 
-	drm_helper_mode_fill_fb_struct(&dfb->fb, mode);
-
 	/*
-	 * Take a reference on our object - the caller is expected
-	 * to drop their reference to it.
+	 * Take a reference on our object as we're successful - the
+	 * caller already holds a reference, which keeps us safe for
+	 * the above call, but the caller will drop their reference
+	 * to it.  Hence we need to take our own reference.
 	 */
 	drm_gem_object_reference(&obj->obj);
-	dfb->obj = obj;
 
 	return dfb;
 }
@@ -111,39 +113,44 @@ static struct drm_framebuffer *armada_fb_create(struct drm_device *dev,
 		mode->pitches[2]);
 
 	/* We can only handle a single plane at the moment */
-	if (drm_format_num_planes(mode->pixel_format) > 1)
-		return ERR_PTR(-EINVAL);
+	if (drm_format_num_planes(mode->pixel_format) > 1) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	obj = armada_gem_object_lookup(dev, dfile, mode->handles[0]);
 	if (!obj) {
-		DRM_ERROR("failed to lookup gem object\n");
-		return ERR_PTR(-ENOENT);
+		ret = -ENOENT;
+		goto err;
 	}
 
 	if (obj->obj.import_attach && !obj->sgt) {
 		ret = armada_gem_map_import(obj);
 		if (ret)
-			goto unref;
+			goto err_unref;
 	}
 
 	/* Framebuffer objects must have a valid device address for scanout */
 	if (obj->dev_addr == DMA_ERROR_CODE) {
 		ret = -EINVAL;
-		goto unref;
+		goto err_unref;
 	}
 
 	dfb = armada_framebuffer_create(dev, mode, obj);
-	ret = IS_ERR(dfb) ? PTR_ERR(dfb) : 0;
+	if (IS_ERR(dfb)) {
+		ret = PTR_ERR(dfb);
+		goto err;
+	}
 
-unref:
 	drm_gem_object_unreference_unlocked(&obj->obj);
 
-	if (ret) {
-		DRM_ERROR("failed to initialize framebuffer: %d\n", ret);
-		return ERR_PTR(ret);
-	}
-
 	return &dfb->fb;
+
+ err_unref:
+	drm_gem_object_unreference_unlocked(&obj->obj);
+ err:
+	DRM_ERROR("failed to initialize framebuffer: %d\n", ret);
+	return ERR_PTR(ret);
 }
 
 static void armada_output_poll_changed(struct drm_device *dev)
diff --git a/drivers/gpu/drm/armada/armada_fbdev.c b/drivers/gpu/drm/armada/armada_fbdev.c
index 840e322..dd5ea77 100644
--- a/drivers/gpu/drm/armada/armada_fbdev.c
+++ b/drivers/gpu/drm/armada/armada_fbdev.c
@@ -70,12 +70,15 @@ static int armada_fb_create(struct drm_fb_helper *fbh,
 	}
 
 	dfb = armada_framebuffer_create(dev, &mode, obj);
-	if (IS_ERR(dfb)) {
-		ret = PTR_ERR(dfb);
-		goto err_fbcreate;
-	}
 
-	mutex_lock(&dev->struct_mutex);
+	/*
+	 * A reference is now held by the framebuffer object if
+	 * successful, otherwise this drops the ref for the error path.
+	 */
+	drm_gem_object_unreference_unlocked(&obj->obj);
+
+	if (IS_ERR(dfb))
+		return PTR_ERR(dfb);
 
 	info = framebuffer_alloc(0, dev->dev);
 	if (!info) {
@@ -106,19 +109,12 @@ static int armada_fb_create(struct drm_fb_helper *fbh,
 		dfb->fb.width, dfb->fb.height,
 		dfb->fb.bits_per_pixel, obj->phys_addr);
 
-	/* Reference is now held by the framebuffer object */
-	drm_gem_object_unreference(&obj->obj);
-	mutex_unlock(&dev->struct_mutex);
-
 	return 0;
 
  err_fbcmap:
 	framebuffer_release(info);
  err_fballoc:
-	mutex_unlock(&dev->struct_mutex);
 	dfb->fb.funcs->destroy(&dfb->fb);
- err_fbcreate:
-	drm_gem_object_unreference_unlocked(&obj->obj);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index 0aa7246..1c2deb7 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -31,6 +31,7 @@ static int armada_gem_vm_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 	case 0:
 	case -ERESTARTSYS:
 	case -EINTR:
+	case -EBUSY:
 		return VM_FAULT_NOPAGE;
 	case -ENOMEM:
 		return VM_FAULT_OOM;
@@ -50,6 +51,7 @@ static size_t roundup_gem_size(size_t size)
 	return roundup(size, PAGE_SIZE);
 }
 
+/* dev->struct_mutex is held here */
 void armada_gem_free_object(struct drm_gem_object *obj)
 {
 	struct armada_gem_object *dobj = drm_to_armada_gem(obj);
@@ -65,7 +67,8 @@ void armada_gem_free_object(struct drm_gem_object *obj)
 		__free_pages(dobj->page, order);
 	} else if (dobj->linear) {
 		/* linear backed memory */
-		drm_mm_put_block(dobj->linear);
+		drm_mm_remove_node(dobj->linear);
+		kfree(dobj->linear);
 		if (dobj->addr)
 			iounmap(dobj->addr);
 	}
@@ -137,22 +140,32 @@ armada_gem_linear_back(struct drm_device *dev, struct armada_gem_object *obj)
 
 	/* Otherwise, grab it from our linear allocation */
 	if (!obj->page) {
-		struct drm_mm_node *free;
+		struct drm_mm_node *node;
 		unsigned align = min_t(unsigned, size, SZ_2M);
 		void __iomem *ptr;
+		int ret;
+
+		node = kzalloc(sizeof(*node), GFP_KERNEL);
+		if (!node)
+			return -ENOSPC;
 
 		mutex_lock(&dev->struct_mutex);
-		free = drm_mm_search_free(&priv->linear, size, align, 0);
-		if (free)
-			obj->linear = drm_mm_get_block(free, size, align);
+		ret = drm_mm_insert_node(&priv->linear, node, size, align);
 		mutex_unlock(&dev->struct_mutex);
-		if (!obj->linear)
-			return -ENOSPC;
+		if (ret) {
+			kfree(node);
+			return ret;
+		}
+
+		obj->linear = node;
 
 		/* Ensure that the memory we're returning is cleared. */
 		ptr = ioremap_wc(obj->linear->start, size);
 		if (!ptr) {
-			drm_mm_put_block(obj->linear);
+			mutex_lock(&dev->struct_mutex);
+			drm_mm_remove_node(obj->linear);
+			mutex_unlock(&dev->struct_mutex);
+			kfree(obj->linear);
 			obj->linear = NULL;
 			return -ENOMEM;
 		}
