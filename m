From: robdclark@gmail.com (Rob Clark)
Date: Thu, 4 Sep 2014 20:46:40 -0400
Subject: ccf vs iommu vs drm locking fun
Message-ID: <CAF6AEGtk=KhW+m-jc6VzH=pHGgnE1Uzq0tYiqqnX0sPHV1rbPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, I was looking at the below lockdep splat, and discussing it a bit
w/ sboyd on IRC, and came to a slightly disturbing realization..

The interaction between prepare_lock and debugfs bits is a little bit
worrying.  In particular, it is probably not a good idea to assume
that anyone who needs to grab prepare_lock does not already hold
mmap_sem.  Not holding mmap_sem or locks that interact w/ mmap_sem is
going to be pretty hard to avoid, at least for gpu drivers that are
using iommus that are using CCF ;-)

BR,
-R


----------

[15928.894558]
[15928.894609] ======================================================
[15928.895145] [ INFO: possible circular locking dependency detected ]
[15928.901141] 3.17.0-rc1-00050-g07a489b #802 Tainted: G        W
[15928.907335] -------------------------------------------------------
[15928.907348] Xorg.bin/5413 is trying to acquire lock:
[15928.907417]  (prepare_lock){+.+.+.}, at: [<c0781280>]
clk_prepare_lock+0x88/0xfc
[15928.907424]
[15928.907424] but task is already holding lock:
[15928.907508]  (qcom_iommu_lock){+.+...}, at: [<c079f664>]
qcom_iommu_unmap+0x1c/0x1f0
[15928.907519]
[15928.907519] which lock already depends on the new lock.
[15928.907519]
[15928.907532]
[15928.907532] the existing dependency chain (in reverse order) is:
[15928.907575]
[15928.907575] -> #4 (qcom_iommu_lock){+.+...}:
[15928.907611]        [<c079f860>] qcom_iommu_map+0x28/0x450
[15928.907634]        [<c079eb50>] iommu_map+0xc8/0x12c
[15928.907662]        [<c056c1fc>] msm_iommu_map+0xb4/0x130
[15928.907681]        [<c05697bc>] msm_gem_get_iova_locked+0x9c/0xe8
[15928.907714]        [<c0569854>] msm_gem_get_iova+0x4c/0x64
[15928.907765]        [<c0562208>] mdp4_kms_init+0x4c4/0x6c0
[15928.907813]        [<c056881c>] msm_load+0x2ac/0x34c
[15928.907846]        [<c0545724>] drm_dev_register+0xac/0x108
[15928.907868]        [<c0547510>] drm_platform_init+0x50/0xf0
[15928.907892]        [<c0578a60>] try_to_bring_up_master.part.3+0xc8/0x108
[15928.907913]        [<c0578b48>] component_master_add_with_match+0xa8/0x104
[15928.907934]        [<c0568294>] msm_pdev_probe+0x64/0x70
[15928.907955]        [<c057e704>] platform_drv_probe+0x2c/0x60
[15928.907983]        [<c057cff8>] driver_probe_device+0x108/0x234
[15928.908003]        [<c057b65c>] bus_for_each_drv+0x64/0x98
[15928.908040]        [<c057cec0>] device_attach+0x78/0x8c
[15928.908082]        [<c057c590>] bus_probe_device+0x88/0xac
[15928.908126]        [<c057c9b8>] deferred_probe_work_func+0x68/0x9c
[15928.908182]        [<c0259db4>] process_one_work+0x1a0/0x40c
[15928.908214]        [<c025a710>] worker_thread+0x44/0x4d8
[15928.908237]        [<c025ec54>] kthread+0xd8/0xec
[15928.908262]        [<c020e9a8>] ret_from_fork+0x14/0x2c
[15928.908291]
[15928.908291] -> #3 (&dev->struct_mutex){+.+.+.}:
[15928.908311]        [<c0541188>] drm_gem_mmap+0x38/0xd0
[15928.908329]        [<c05695b8>] msm_gem_mmap+0xc/0x5c
[15928.908358]        [<c02f0b6c>] mmap_region+0x35c/0x6c8
[15928.908377]        [<c02f11ec>] do_mmap_pgoff+0x314/0x398
[15928.908398]        [<c02de1e0>] vm_mmap_pgoff+0x84/0xb4
[15928.908416]        [<c02ef83c>] SyS_mmap_pgoff+0x94/0xbc
[15928.908436]        [<c020e8e0>] ret_fast_syscall+0x0/0x48
[15928.908463]
[15928.908463] -> #2 (&mm->mmap_sem){++++++}:
[15928.908512]        [<c0321138>] filldir64+0x68/0x180
[15928.908558]        [<c0333fe0>] dcache_readdir+0x188/0x22c
[15928.908593]        [<c0320ed0>] iterate_dir+0x9c/0x11c
[15928.908616]        [<c03213b0>] SyS_getdents64+0x78/0xe8
[15928.908640]        [<c020e8e0>] ret_fast_syscall+0x0/0x48
[15928.908671]
[15928.908671] -> #1 (&sb->s_type->i_mutex_key#3){+.+.+.}:
[15928.908706]        [<c03fc544>] __create_file+0x58/0x1dc
[15928.908728]        [<c03fc70c>] debugfs_create_dir+0x1c/0x24
[15928.908761]        [<c0781c7c>] clk_debug_create_subtree+0x20/0x170
[15928.908790]        [<c0be2af8>] clk_debug_init+0xec/0x14c
[15928.908816]        [<c0208c70>] do_one_initcall+0x8c/0x1c8
[15928.908846]        [<c0b9cce4>] kernel_init_freeable+0x13c/0x1dc
[15928.908873]        [<c0877bc4>] kernel_init+0x8/0xe8
[15928.908898]        [<c020e9a8>] ret_from_fork+0x14/0x2c
[15928.908925]
[15928.908925] -> #0 (prepare_lock){+.+.+.}:
[15928.908948]        [<c087c408>] mutex_lock_nested+0x70/0x3e8
[15928.908970]        [<c0781280>] clk_prepare_lock+0x88/0xfc
[15928.909001]        [<c0782c50>] clk_prepare+0xc/0x24
[15928.909022]        [<c079f474>] __enable_clocks.isra.4+0x18/0xa4
[15928.909041]        [<c079f614>] __flush_iotlb_va+0xe0/0x114
[15928.909071]        [<c079f6f4>] qcom_iommu_unmap+0xac/0x1f0
[15928.909093]        [<c079ea3c>] iommu_unmap+0x9c/0xe8
[15928.909112]        [<c056c2fc>] msm_iommu_unmap+0x64/0x84
[15928.909130]        [<c0569da4>] msm_gem_free_object+0x11c/0x338
[15928.909149]        [<c05413ec>]
drm_gem_object_handle_unreference_unlocked+0xfc/0x130
[15928.909166]        [<c0541604>] drm_gem_object_release_handle+0x50/0x68
[15928.909199]        [<c0447a98>] idr_for_each+0xa8/0xdc
[15928.909225]        [<c0541c10>] drm_gem_release+0x1c/0x28
[15928.909258]        [<c0540b3c>] drm_release+0x370/0x428
[15928.909302]        [<c031105c>] __fput+0x98/0x1e8
[15928.909339]        [<c025d73c>] task_work_run+0xb0/0xfc
[15928.909386]        [<c02477ec>] do_exit+0x2ec/0x948
[15928.909415]        [<c0247ec0>] do_group_exit+0x4c/0xb8
[15928.909455]        [<c025180c>] get_signal+0x28c/0x6ac
[15928.909507]        [<c0211204>] do_signal+0xc4/0x3e4
[15928.909548]        [<c02116cc>] do_work_pending+0xb4/0xc4
[15928.909584]        [<c020e938>] work_pending+0xc/0x20
[15928.909595]
[15928.909595] other info that might help us debug this:
[15928.909595]
[15928.909665] Chain exists of:
[15928.909665]   prepare_lock --> &dev->struct_mutex --> qcom_iommu_lock
[15928.909665]
[15928.909675]  Possible unsafe locking scenario:
[15928.909675]
[15928.909685]        CPU0                    CPU1
[15928.909696]        ----                    ----
[15928.909724]   lock(qcom_iommu_lock);
[15928.909753]                                lock(&dev->struct_mutex);
[15928.909769]                                lock(qcom_iommu_lock);
[15928.909786]   lock(prepare_lock);
[15928.909795]
[15928.909795]  *** DEADLOCK ***
[15928.909795]
[15928.909818] 3 locks held by Xorg.bin/5413:
[15928.909905]  #0:  (drm_global_mutex){+.+.+.}, at: [<c0540800>]
drm_release+0x34/0x428
[15928.909954]  #1:  (&dev->struct_mutex){+.+.+.}, at: [<c05413bc>]
drm_gem_object_handle_unreference_unlocked+0xcc/0x130
[15928.910029]  #2:  (qcom_iommu_lock){+.+...}, at: [<c079f664>]
qcom_iommu_unmap+0x1c/0x1f0
[15928.910042]
[15928.910042] stack backtrace:
[15928.910073] CPU: 1 PID: 5413 Comm: Xorg.bin Tainted: G        W
 3.17.0-rc1-00050-g07a489b #802
[15928.910141] [<c0216290>] (unwind_backtrace) from [<c0211d8c>]
(show_stack+0x10/0x14)
[15928.910181] [<c0211d8c>] (show_stack) from [<c087a078>]
(dump_stack+0x98/0xb8)
[15928.910210] [<c087a078>] (dump_stack) from [<c027f024>]
(print_circular_bug+0x218/0x340)
[15928.910250] [<c027f024>] (print_circular_bug) from [<c0283e08>]
(__lock_acquire+0x1d24/0x20b8)
[15928.910293] [<c0283e08>] (__lock_acquire) from [<c0284774>]
(lock_acquire+0x9c/0xbc)
[15928.910332] [<c0284774>] (lock_acquire) from [<c087c408>]
(mutex_lock_nested+0x70/0x3e8)
[15928.910380] [<c087c408>] (mutex_lock_nested) from [<c0781280>]
(clk_prepare_lock+0x88/0xfc)
[15928.910436] [<c0781280>] (clk_prepare_lock) from [<c0782c50>]
(clk_prepare+0xc/0x24)
[15928.910478] [<c0782c50>] (clk_prepare) from [<c079f474>]
(__enable_clocks.isra.4+0x18/0xa4)
[15928.910517] [<c079f474>] (__enable_clocks.isra.4) from [<c079f614>]
(__flush_iotlb_va+0xe0/0x114)
[15928.910561] [<c079f614>] (__flush_iotlb_va) from [<c079f6f4>]
(qcom_iommu_unmap+0xac/0x1f0)
[15928.910602] [<c079f6f4>] (qcom_iommu_unmap) from [<c079ea3c>]
(iommu_unmap+0x9c/0xe8)
[15928.910635] [<c079ea3c>] (iommu_unmap) from [<c056c2fc>]
(msm_iommu_unmap+0x64/0x84)
[15928.910669] [<c056c2fc>] (msm_iommu_unmap) from [<c0569da4>]
(msm_gem_free_object+0x11c/0x338)
[15928.910692] [<c0569da4>] (msm_gem_free_object) from [<c05413ec>]
(drm_gem_object_handle_unreference_unlocked+0xfc/0x130)
[15928.910715] [<c05413ec>]
(drm_gem_object_handle_unreference_unlocked) from [<c0541604>]
(drm_gem_object_release_handle+0x50/0x68)
[15928.910737] [<c0541604>] (drm_gem_object_release_handle) from
[<c0447a98>] (idr_for_each+0xa8/0xdc)
[15928.910759] [<c0447a98>] (idr_for_each) from [<c0541c10>]
(drm_gem_release+0x1c/0x28)
[15928.910786] [<c0541c10>] (drm_gem_release) from [<c0540b3c>]
(drm_release+0x370/0x428)
[15928.910818] [<c0540b3c>] (drm_release) from [<c031105c>] (__fput+0x98/0x1e8)
[15928.910846] [<c031105c>] (__fput) from [<c025d73c>] (task_work_run+0xb0/0xfc)
[15928.910870] [<c025d73c>] (task_work_run) from [<c02477ec>]
(do_exit+0x2ec/0x948)
[15928.910897] [<c02477ec>] (do_exit) from [<c0247ec0>]
(do_group_exit+0x4c/0xb8)
[15928.910920] [<c0247ec0>] (do_group_exit) from [<c025180c>]
(get_signal+0x28c/0x6ac)
[15928.910966] [<c025180c>] (get_signal) from [<c0211204>]
(do_signal+0xc4/0x3e4)
[15928.911019] [<c0211204>] (do_signal) from [<c02116cc>]
(do_work_pending+0xb4/0xc4)
[15928.911054] [<c02116cc>] (do_work_pending) from [<c020e938>]
(work_pending+0xc/0x20)
