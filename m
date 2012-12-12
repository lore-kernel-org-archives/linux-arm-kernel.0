From: ido@wizery.com (Ido Yariv)
Date: Wed, 12 Dec 2012 22:24:57 +0200
Subject: [PATCH] hwspinlock/core: Fix unbalanced module_get on error path
Message-ID: <1355343897-17063-1-git-send-email-ido@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case pm_runtime_get_sync() fails, __hwspin_lock_request will exit
without calling module_put. As a result, the module could never be
removed. Fix this.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 drivers/hwspinlock/hwspinlock_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index db713c0..085e28e 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -415,6 +415,7 @@ static int __hwspin_lock_request(struct hwspinlock *hwlock)
 	/* notify PM core that power is now needed */
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
+		module_put(dev->driver->owner);
 		dev_err(dev, "%s: can't power on device\n", __func__);
 		return ret;
 	}
-- 
1.7.7.6
