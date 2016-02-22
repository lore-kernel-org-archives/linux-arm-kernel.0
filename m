From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Feb 2016 22:08:38 +0100
Subject: [PATCH 4/8] drm: msm: split out GEM code into helper module
In-Reply-To: <1456175331-714117-1-git-send-email-arnd@arndb.de>
References: <1456175331-714117-1-git-send-email-arnd@arndb.de>
Message-ID: <1456175331-714117-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GEM code is used by dsi, so it can't be part of
the main module. This exports all functions that are called
by other code, and puts it into the helper module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/Makefile  |  3 +--
 drivers/gpu/drm/msm/msm_gem.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index acc02aef1b42..6817e9390153 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -25,7 +25,6 @@ drm-msm-y := \
 	msm_atomic.o \
 	msm_drv.o \
 	msm_fb.o \
-	msm_gem.o \
 	msm_gem_prime.o \
 	msm_gem_submit.o \
 	msm_gpu.o \
@@ -46,4 +45,4 @@ obj-$(CONFIG_DRM_MSM_EDP) += edp/
 
 obj-$(CONFIG_DRM_MSM)	+= drm-msm.o drm_msm_helper.o
 
-drm_msm_helper-y	+= msm_iotrace.o msm_fence.o
+drm_msm_helper-y	+= msm_iotrace.o msm_fence.o msm_gem.o
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 3cedb8d5c855..1d64febee274 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -143,11 +143,13 @@ struct page **msm_gem_get_pages(struct drm_gem_object *obj)
 	mutex_unlock(&dev->struct_mutex);
 	return p;
 }
+EXPORT_SYMBOL_GPL(msm_gem_get_pages);
 
 void msm_gem_put_pages(struct drm_gem_object *obj)
 {
 	/* when we start tracking the pin count, then do something here */
 }
+EXPORT_SYMBOL_GPL(msm_gem_put_pages);
 
 int msm_gem_mmap_obj(struct drm_gem_object *obj,
 		struct vm_area_struct *vma)
@@ -177,6 +179,7 @@ int msm_gem_mmap_obj(struct drm_gem_object *obj,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(msm_gem_mmap_obj);
 
 int msm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 {
@@ -190,6 +193,7 @@ int msm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	return msm_gem_mmap_obj(vma->vm_private_data, vma);
 }
+EXPORT_SYMBOL_GPL(msm_gem_mmap);
 
 int msm_gem_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 {
@@ -246,6 +250,7 @@ out:
 		return VM_FAULT_SIGBUS;
 	}
 }
+EXPORT_SYMBOL_GPL(msm_gem_fault);
 
 /** get mmap offset */
 static uint64_t mmap_offset(struct drm_gem_object *obj)
@@ -274,6 +279,7 @@ uint64_t msm_gem_mmap_offset(struct drm_gem_object *obj)
 	mutex_unlock(&obj->dev->struct_mutex);
 	return offset;
 }
+EXPORT_SYMBOL_GPL(msm_gem_mmap_offset);
 
 /* should be called under struct_mutex.. although it can be called
  * from atomic context without struct_mutex to acquire an extra
@@ -316,6 +322,7 @@ int msm_gem_get_iova_locked(struct drm_gem_object *obj, int id,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(msm_gem_get_iova_locked);
 
 /* get iova, taking a reference.  Should have a matching put */
 int msm_gem_get_iova(struct drm_gem_object *obj, int id, uint32_t *iova)
@@ -336,6 +343,7 @@ int msm_gem_get_iova(struct drm_gem_object *obj, int id, uint32_t *iova)
 	mutex_unlock(&obj->dev->struct_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(msm_gem_get_iova);
 
 /* get iova without taking a reference, used in places where you have
  * already done a 'msm_gem_get_iova()'.
@@ -346,6 +354,7 @@ uint32_t msm_gem_iova(struct drm_gem_object *obj, int id)
 	WARN_ON(!msm_obj->domain[id].iova);
 	return msm_obj->domain[id].iova;
 }
+EXPORT_SYMBOL_GPL(msm_gem_iova);
 
 void msm_gem_put_iova(struct drm_gem_object *obj, int id)
 {
@@ -356,6 +365,7 @@ void msm_gem_put_iova(struct drm_gem_object *obj, int id)
 	// if another _get_iova_locked() fails we can start unmapping
 	// things that are no longer needed..
 }
+EXPORT_SYMBOL_GPL(msm_gem_put_iova);
 
 int msm_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 		struct drm_mode_create_dumb *args)
@@ -365,6 +375,7 @@ int msm_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 	return msm_gem_new_handle(dev, file, args->size,
 			MSM_BO_SCANOUT | MSM_BO_WC, &args->handle);
 }
+EXPORT_SYMBOL_GPL(msm_gem_dumb_create);
 
 int msm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
 		uint32_t handle, uint64_t *offset)
@@ -386,6 +397,7 @@ int msm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
 fail:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(msm_gem_dumb_map_offset);
 
 void *msm_gem_vaddr_locked(struct drm_gem_object *obj)
 {
@@ -400,6 +412,7 @@ void *msm_gem_vaddr_locked(struct drm_gem_object *obj)
 	}
 	return msm_obj->vaddr;
 }
+EXPORT_SYMBOL_GPL(msm_gem_vaddr_locked);
 
 void *msm_gem_vaddr(struct drm_gem_object *obj)
 {
@@ -409,6 +422,7 @@ void *msm_gem_vaddr(struct drm_gem_object *obj)
 	mutex_unlock(&obj->dev->struct_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(msm_gem_vaddr);
 
 /* setup callback for when bo is no longer busy..
  * TODO probably want to differentiate read vs write..
@@ -421,6 +435,7 @@ int msm_gem_queue_inactive_cb(struct drm_gem_object *obj,
 			MSM_PREP_READ | MSM_PREP_WRITE);
 	return msm_queue_fence_cb(obj->dev, cb, fence);
 }
+EXPORT_SYMBOL_GPL(msm_gem_queue_inactive_cb);
 
 void msm_gem_move_to_active(struct drm_gem_object *obj,
 		struct msm_gpu *gpu, bool write, uint32_t fence)
@@ -434,6 +449,7 @@ void msm_gem_move_to_active(struct drm_gem_object *obj,
 	list_del_init(&msm_obj->mm_list);
 	list_add_tail(&msm_obj->mm_list, &gpu->active_list);
 }
+EXPORT_SYMBOL_GPL(msm_gem_move_to_active);
 
 void msm_gem_move_to_inactive(struct drm_gem_object *obj)
 {
@@ -449,6 +465,7 @@ void msm_gem_move_to_inactive(struct drm_gem_object *obj)
 	list_del_init(&msm_obj->mm_list);
 	list_add_tail(&msm_obj->mm_list, &priv->inactive_list);
 }
+EXPORT_SYMBOL_GPL(msm_gem_move_to_inactive);
 
 int msm_gem_cpu_prep(struct drm_gem_object *obj, uint32_t op, ktime_t *timeout)
 {
@@ -469,12 +486,14 @@ int msm_gem_cpu_prep(struct drm_gem_object *obj, uint32_t op, ktime_t *timeout)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(msm_gem_cpu_prep);
 
 int msm_gem_cpu_fini(struct drm_gem_object *obj)
 {
 	/* TODO cache maintenance */
 	return 0;
 }
+EXPORT_SYMBOL_GPL(msm_gem_cpu_fini);
 
 #ifdef CONFIG_DEBUG_FS
 void msm_gem_describe(struct drm_gem_object *obj, struct seq_file *m)
@@ -490,6 +509,7 @@ void msm_gem_describe(struct drm_gem_object *obj, struct seq_file *m)
 			obj->name, obj->refcount.refcount.counter,
 			off, msm_obj->vaddr, obj->size);
 }
+EXPORT_SYMBOL_GPL(msm_gem_describe);
 
 void msm_gem_describe_objects(struct list_head *list, struct seq_file *m)
 {
@@ -507,6 +527,7 @@ void msm_gem_describe_objects(struct list_head *list, struct seq_file *m)
 
 	seq_printf(m, "Total %d objects, %zu bytes\n", count, size);
 }
+EXPORT_SYMBOL_GPL(msm_gem_describe_objects);
 #endif
 
 void msm_gem_free_object(struct drm_gem_object *obj)
@@ -554,6 +575,7 @@ void msm_gem_free_object(struct drm_gem_object *obj)
 
 	kfree(msm_obj);
 }
+EXPORT_SYMBOL_GPL(msm_gem_free_object);
 
 /* convenience method to construct a GEM buffer object, and userspace handle */
 int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
@@ -580,6 +602,7 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(msm_gem_new_handle);
 
 static int msm_gem_new_impl(struct drm_device *dev,
 		uint32_t size, uint32_t flags,
@@ -663,6 +686,7 @@ fail:
 
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(msm_gem_new);
 
 struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 		uint32_t size, struct sg_table *sgt)
@@ -707,3 +731,8 @@ fail:
 
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(msm_gem_import);
+
+MODULE_AUTHOR("Rob Clark <robdclark@gmail.com");
+MODULE_DESCRIPTION("MSM DRM Driver GEM implementation");
+MODULE_LICENSE("GPL");
-- 
2.7.0
