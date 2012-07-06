From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Fri, 06 Jul 2012 13:56:06 +0900
Subject: [PATCH 1/3] hwspinlock/core: use global ID to register hwspinlocks on
 multiple devices
In-Reply-To: <4FF66FBD.5090601@renesas.com>
References: <4FF66FBD.5090601@renesas.com>
Message-ID: <4FF66FE6.1060005@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 300bab9770 (hwspinlock/core: register a bank of hwspinlocks in a
single API call, 2011-09-06) introduced 'hwspin_lock_register_single()'
to register numerous (a bank of) hwspinlock instances in a single API,
'hwspin_lock_register()'.

At which time, 'hwspin_lock_register()' accidentally passes 'local IDs'
to 'hwspin_lock_register_single()', despite that ..._single() requires
'global IDs' to register hwspinlocks.

We have to convert into global IDs by supplying the missing 'base_id'.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---

Note that we used to have a similar bug in omap_hwspinlock.c driver,
and fixed it in this commit:

| commit c3c1250e93a7ab1327a9fc49d2a22405672f4204
| Author: Ohad Ben-Cohen <ohad@wizery.com>
| Date:   Mon Sep 5 23:15:06 2011 +0300
|
|     hwspinlock/core/omap: fix id issues on multiple hwspinlock devices

Commit 300bab9770 made the same mistake when sorting our the core code.

 drivers/hwspinlock/hwspinlock_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index ed4e000..ba45f96 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -345,7 +345,7 @@ int hwspin_lock_register(struct hwspinlock_device *bank, struct device *dev,
 		spin_lock_init(&hwlock->lock);
 		hwlock->bank = bank;
 
-		ret = hwspin_lock_register_single(hwlock, i);
+		ret = hwspin_lock_register_single(hwlock, base_id + i);
 		if (ret)
 			goto reg_failed;
 	}
-- 
1.7.11.1
