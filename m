From: zhanzhenbo@gmail.com (steve.zhan)
Date: Thu, 20 Dec 2012 20:44:28 +0800
Subject: [PATCH] hwspinlock/core: Kernel panic when enable DEBUG_SPINLOCK_SLEEP
 config.
Message-ID: <CAKvkGKcLU4ehteAqozw6+dCodSoQvJRSkpnu85um0C62c7RzSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ohad,

                When enable this config to check kernel, kernel will
complain panic at slab.c(kmem_cache_alloc function): "BUG: sleeping
function called from invalid context".
                 The Backtrace is: hwspin_lock_register ->
radix_tree_insert -> kmem_cache_alloc -> __might_sleep -> BUG

                 Hwspinlock has been inited in postcore_initcall phase, but
kernel sleep check has enable in early_initcall
phase(__might_sleep_init_called ==1 in sched.c)

                 I think the the same problem is in __hwspin_lock_request
function, this function use pm_runtime_get _sync interface, so might seep
that flag don't have RPM_ASYNC value.

Do you hae some good suggestions Or comments about this?


diff --git a/drivers/hwspinlock/hwspinlock_core.c
b/drivers/hwspinlock/hwspinlock_core.c
index db713c0..49ff54a 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -50,7 +50,7 @@
  * tree, looking for an unused hwspinlock instance, is now reduced to a
  * single radix tree API call.
  */
-static RADIX_TREE(hwspinlock_tree, GFP_KERNEL);
+static RADIX_TREE(hwspinlock_tree, GFP_ATOMIC);

 /*
  * Synchronization of access to the tree is achieved using this mutex,
@@ -413,7 +413,7 @@ static int __hwspin_lock_request(struct hwspinlock
*hwlock)
        }

        /* notify PM core that power is now needed */
-       ret = pm_runtime_get_sync(dev);
+       ret = pm_runtime_get(dev);
        if (ret < 0) {
                dev_err(dev, "%s: can't power on device\n", __func__);
                return ret;

-- 
Steve Zhan



-- 
Steve Zhan
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121220/8449dcfc/attachment-0001.html>
