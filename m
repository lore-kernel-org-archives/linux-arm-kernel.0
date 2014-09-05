From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu,  4 Sep 2014 23:37:49 -0700
Subject: [PATCH v2] clk: Don't hold prepare_lock across debugfs creation
In-Reply-To: <CAF6AEGtk=KhW+m-jc6VzH=pHGgnE1Uzq0tYiqqnX0sPHV1rbPQ@mail.gmail.com>
References: <CAF6AEGtk=KhW+m-jc6VzH=pHGgnE1Uzq0tYiqqnX0sPHV1rbPQ@mail.gmail.com>
Message-ID: <1409899069-13313-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Clark reports a lockdep splat that involves the prepare_lock
chained with the mmap semaphore.

======================================================
[ INFO: possible circular locking dependency detected ]
3.17.0-rc1-00050-g07a489b #802 Tainted: G        W
-------------------------------------------------------
Xorg.bin/5413 is trying to acquire lock:
 (prepare_lock){+.+.+.}, at: [<c0781280>] clk_prepare_lock+0x88/0xfc

but task is already holding lock:
 (qcom_iommu_lock){+.+...}, at: [<c079f664>] qcom_iommu_unmap+0x1c/0x1f0

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #4 (qcom_iommu_lock){+.+...}:
       [<c079f860>] qcom_iommu_map+0x28/0x450
       [<c079eb50>] iommu_map+0xc8/0x12c
       [<c056c1fc>] msm_iommu_map+0xb4/0x130
       [<c05697bc>] msm_gem_get_iova_locked+0x9c/0xe8
       [<c0569854>] msm_gem_get_iova+0x4c/0x64
       [<c0562208>] mdp4_kms_init+0x4c4/0x6c0
       [<c056881c>] msm_load+0x2ac/0x34c
       [<c0545724>] drm_dev_register+0xac/0x108
       [<c0547510>] drm_platform_init+0x50/0xf0
       [<c0578a60>] try_to_bring_up_master.part.3+0xc8/0x108
       [<c0578b48>] component_master_add_with_match+0xa8/0x104
       [<c0568294>] msm_pdev_probe+0x64/0x70
       [<c057e704>] platform_drv_probe+0x2c/0x60
       [<c057cff8>] driver_probe_device+0x108/0x234
       [<c057b65c>] bus_for_each_drv+0x64/0x98
       [<c057cec0>] device_attach+0x78/0x8c
       [<c057c590>] bus_probe_device+0x88/0xac
       [<c057c9b8>] deferred_probe_work_func+0x68/0x9c
       [<c0259db4>] process_one_work+0x1a0/0x40c
       [<c025a710>] worker_thread+0x44/0x4d8
       [<c025ec54>] kthread+0xd8/0xec
       [<c020e9a8>] ret_from_fork+0x14/0x2c

-> #3 (&dev->struct_mutex){+.+.+.}:
       [<c0541188>] drm_gem_mmap+0x38/0xd0
       [<c05695b8>] msm_gem_mmap+0xc/0x5c
       [<c02f0b6c>] mmap_region+0x35c/0x6c8
       [<c02f11ec>] do_mmap_pgoff+0x314/0x398
       [<c02de1e0>] vm_mmap_pgoff+0x84/0xb4
       [<c02ef83c>] SyS_mmap_pgoff+0x94/0xbc
       [<c020e8e0>] ret_fast_syscall+0x0/0x48

-> #2 (&mm->mmap_sem){++++++}:
       [<c0321138>] filldir64+0x68/0x180
       [<c0333fe0>] dcache_readdir+0x188/0x22c
       [<c0320ed0>] iterate_dir+0x9c/0x11c
       [<c03213b0>] SyS_getdents64+0x78/0xe8
       [<c020e8e0>] ret_fast_syscall+0x0/0x48

-> #1 (&sb->s_type->i_mutex_key#3){+.+.+.}:
       [<c03fc544>] __create_file+0x58/0x1dc
       [<c03fc70c>] debugfs_create_dir+0x1c/0x24
       [<c0781c7c>] clk_debug_create_subtree+0x20/0x170
       [<c0be2af8>] clk_debug_init+0xec/0x14c
       [<c0208c70>] do_one_initcall+0x8c/0x1c8
       [<c0b9cce4>] kernel_init_freeable+0x13c/0x1dc
       [<c0877bc4>] kernel_init+0x8/0xe8
       [<c020e9a8>] ret_from_fork+0x14/0x2c

-> #0 (prepare_lock){+.+.+.}:
       [<c087c408>] mutex_lock_nested+0x70/0x3e8
       [<c0781280>] clk_prepare_lock+0x88/0xfc
       [<c0782c50>] clk_prepare+0xc/0x24
       [<c079f474>] __enable_clocks.isra.4+0x18/0xa4
       [<c079f614>] __flush_iotlb_va+0xe0/0x114
       [<c079f6f4>] qcom_iommu_unmap+0xac/0x1f0
       [<c079ea3c>] iommu_unmap+0x9c/0xe8
       [<c056c2fc>] msm_iommu_unmap+0x64/0x84
       [<c0569da4>] msm_gem_free_object+0x11c/0x338
       [<c05413ec>] drm_gem_object_handle_unreference_unlocked+0xfc/0x130
       [<c0541604>] drm_gem_object_release_handle+0x50/0x68
       [<c0447a98>] idr_for_each+0xa8/0xdc
       [<c0541c10>] drm_gem_release+0x1c/0x28
       [<c0540b3c>] drm_release+0x370/0x428
       [<c031105c>] __fput+0x98/0x1e8
       [<c025d73c>] task_work_run+0xb0/0xfc
       [<c02477ec>] do_exit+0x2ec/0x948
       [<c0247ec0>] do_group_exit+0x4c/0xb8
       [<c025180c>] get_signal+0x28c/0x6ac
       [<c0211204>] do_signal+0xc4/0x3e4
       [<c02116cc>] do_work_pending+0xb4/0xc4
       [<c020e938>] work_pending+0xc/0x20

other info that might help us debug this:

Chain exists of:
  prepare_lock --> &dev->struct_mutex --> qcom_iommu_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(qcom_iommu_lock);
                               lock(&dev->struct_mutex);
                               lock(qcom_iommu_lock);
  lock(prepare_lock);

 *** DEADLOCK ***

3 locks held by Xorg.bin/5413:
 #0:  (drm_global_mutex){+.+.+.}, at: [<c0540800>] drm_release+0x34/0x428
 #1:  (&dev->struct_mutex){+.+.+.}, at: [<c05413bc>] drm_gem_object_handle_unreference_unlocked+0xcc/0x130
 #2:  (qcom_iommu_lock){+.+...}, at: [<c079f664>] qcom_iommu_unmap+0x1c/0x1f0

stack backtrace:
CPU: 1 PID: 5413 Comm: Xorg.bin Tainted: G        W      3.17.0-rc1-00050-g07a489b #802
[<c0216290>] (unwind_backtrace) from [<c0211d8c>] (show_stack+0x10/0x14)
[<c0211d8c>] (show_stack) from [<c087a078>] (dump_stack+0x98/0xb8)
[<c087a078>] (dump_stack) from [<c027f024>] (print_circular_bug+0x218/0x340)
[<c027f024>] (print_circular_bug) from [<c0283e08>] (__lock_acquire+0x1d24/0x20b8)
[<c0283e08>] (__lock_acquire) from [<c0284774>] (lock_acquire+0x9c/0xbc)
[<c0284774>] (lock_acquire) from [<c087c408>] (mutex_lock_nested+0x70/0x3e8)
[<c087c408>] (mutex_lock_nested) from [<c0781280>] (clk_prepare_lock+0x88/0xfc)
[<c0781280>] (clk_prepare_lock) from [<c0782c50>] (clk_prepare+0xc/0x24)
[<c0782c50>] (clk_prepare) from [<c079f474>] (__enable_clocks.isra.4+0x18/0xa4)
[<c079f474>] (__enable_clocks.isra.4) from [<c079f614>] (__flush_iotlb_va+0xe0/0x114)
[<c079f614>] (__flush_iotlb_va) from [<c079f6f4>] (qcom_iommu_unmap+0xac/0x1f0)
[<c079f6f4>] (qcom_iommu_unmap) from [<c079ea3c>] (iommu_unmap+0x9c/0xe8)
[<c079ea3c>] (iommu_unmap) from [<c056c2fc>] (msm_iommu_unmap+0x64/0x84)
[<c056c2fc>] (msm_iommu_unmap) from [<c0569da4>] (msm_gem_free_object+0x11c/0x338)
[<c0569da4>] (msm_gem_free_object) from [<c05413ec>] (drm_gem_object_handle_unreference_unlocked+0xfc/0x130)
[<c05413ec>] (drm_gem_object_handle_unreference_unlocked) from [<c0541604>] (drm_gem_object_release_handle+0x50/0x68)
[<c0541604>] (drm_gem_object_release_handle) from [<c0447a98>] (idr_for_each+0xa8/0xdc)
[<c0447a98>] (idr_for_each) from [<c0541c10>] (drm_gem_release+0x1c/0x28)
[<c0541c10>] (drm_gem_release) from [<c0540b3c>] (drm_release+0x370/0x428)
[<c0540b3c>] (drm_release) from [<c031105c>] (__fput+0x98/0x1e8)
[<c031105c>] (__fput) from [<c025d73c>] (task_work_run+0xb0/0xfc)
[<c025d73c>] (task_work_run) from [<c02477ec>] (do_exit+0x2ec/0x948)
[<c02477ec>] (do_exit) from [<c0247ec0>] (do_group_exit+0x4c/0xb8)
[<c0247ec0>] (do_group_exit) from [<c025180c>] (get_signal+0x28c/0x6ac)
[<c025180c>] (get_signal) from [<c0211204>] (do_signal+0xc4/0x3e4)
[<c0211204>] (do_signal) from [<c02116cc>] (do_work_pending+0xb4/0xc4)
[<c02116cc>] (do_work_pending) from [<c020e938>] (work_pending+0xc/0x20)

We can break this chain if we don't hold the prepare_lock while
creating debugfs directories. We only hold the prepare_lock right
now because we're traversing the clock tree recursively and we
don't want the hierarchy to change during the traversal.
Replacing this traversal with a simple linked list walk allows us
to only grab a list lock instead of the prepare_lock, thus
breaking the lock chain.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

I don't understand why we need to hold the prepare lock around
the kref_put(), so I changed the flow so that we don't do this
when we unregister a clock.

Changes since v1:
 * Squashed two patches into one
 * Focused entirely on debugfs now

 drivers/clk/clk.c           | 66 +++++++++++++++------------------------------
 include/linux/clk-private.h |  1 +
 2 files changed, 23 insertions(+), 44 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b76fa69b44cb..3c04d0d69b96 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -100,6 +100,8 @@ static void clk_enable_unlock(unsigned long flags)
 
 static struct dentry *rootdir;
 static int inited = 0;
+static DEFINE_MUTEX(clk_debug_lock);
+static HLIST_HEAD(clk_debug_list);
 
 static struct hlist_head *all_lists[] = {
 	&clk_root_list,
@@ -300,28 +302,6 @@ out:
 	return ret;
 }
 
-/* caller must hold prepare_lock */
-static int clk_debug_create_subtree(struct clk *clk, struct dentry *pdentry)
-{
-	struct clk *child;
-	int ret = -EINVAL;;
-
-	if (!clk || !pdentry)
-		goto out;
-
-	ret = clk_debug_create_one(clk, pdentry);
-
-	if (ret)
-		goto out;
-
-	hlist_for_each_entry(child, &clk->children, child_node)
-		clk_debug_create_subtree(child, pdentry);
-
-	ret = 0;
-out:
-	return ret;
-}
-
 /**
  * clk_debug_register - add a clk node to the debugfs clk tree
  * @clk: the clk being added to the debugfs clk tree
@@ -329,20 +309,21 @@ out:
  * Dynamically adds a clk to the debugfs clk tree if debugfs has been
  * initialized.  Otherwise it bails out early since the debugfs clk tree
  * will be created lazily by clk_debug_init as part of a late_initcall.
- *
- * Caller must hold prepare_lock.  Only clk_init calls this function (so
- * far) so this is taken care.
  */
 static int clk_debug_register(struct clk *clk)
 {
 	int ret = 0;
 
+	mutex_lock(&clk_debug_lock);
+	hlist_add_head(&clk->debug_node, &clk_debug_list);
+
 	if (!inited)
-		goto out;
+		goto unlock;
 
-	ret = clk_debug_create_subtree(clk, rootdir);
+	ret = clk_debug_create_one(clk, rootdir);
+unlock:
+	mutex_unlock(&clk_debug_lock);
 
-out:
 	return ret;
 }
 
@@ -353,11 +334,13 @@ out:
  * Dynamically removes a clk and all it's children clk nodes from the
  * debugfs clk tree if clk->dentry points to debugfs created by
  * clk_debug_register in __clk_init.
- *
- * Caller must hold prepare_lock.
  */
 static void clk_debug_unregister(struct clk *clk)
 {
+	mutex_lock(&clk_debug_lock);
+	hlist_del_init(&clk->debug_node);
+	mutex_unlock(&clk_debug_lock);
+
 	debugfs_remove_recursive(clk->dentry);
 }
 
@@ -415,17 +398,12 @@ static int __init clk_debug_init(void)
 	if (!d)
 		return -ENOMEM;
 
-	clk_prepare_lock();
-
-	hlist_for_each_entry(clk, &clk_root_list, child_node)
-		clk_debug_create_subtree(clk, rootdir);
-
-	hlist_for_each_entry(clk, &clk_orphan_list, child_node)
-		clk_debug_create_subtree(clk, rootdir);
+	mutex_lock(&clk_debug_lock);
+	hlist_for_each_entry(clk, &clk_debug_list, debug_node)
+		clk_debug_create_one(clk, rootdir);
 
 	inited = 1;
-
-	clk_prepare_unlock();
+	mutex_unlock(&clk_debug_lock);
 
 	return 0;
 }
@@ -2094,7 +2072,8 @@ void clk_unregister(struct clk *clk)
 
 	if (clk->ops == &clk_nodrv_ops) {
 		pr_err("%s: unregistered clock: %s\n", __func__, clk->name);
-		goto out;
+		clk_prepare_unlock();
+		return;
 	}
 	/*
 	 * Assign empty clock ops for consumers that might still hold
@@ -2113,17 +2092,16 @@ void clk_unregister(struct clk *clk)
 			clk_set_parent(child, NULL);
 	}
 
-	clk_debug_unregister(clk);
-
 	hlist_del_init(&clk->child_node);
 
 	if (clk->prepare_count)
 		pr_warn("%s: unregistering prepared clock: %s\n",
 					__func__, clk->name);
+	clk_prepare_unlock();
+
+	clk_debug_unregister(clk);
 
 	kref_put(&clk->ref, __clk_release);
-out:
-	clk_prepare_unlock();
 }
 EXPORT_SYMBOL_GPL(clk_unregister);
 
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index efbf70b9fd84..4ed34105c371 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -48,6 +48,7 @@ struct clk {
 	unsigned long		accuracy;
 	struct hlist_head	children;
 	struct hlist_node	child_node;
+	struct hlist_node	debug_node;
 	unsigned int		notifier_count;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry		*dentry;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
