From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Wed, 11 Sep 2013 18:32:37 +0300
Subject: [PATCH v2 6/9] mfd: wm8994: convert to use I2C core runtime PM
In-Reply-To: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
Message-ID: <1378913560-2752-7-git-send-email-mika.westerberg@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C core now prepares runtime PM on behalf of the I2C client device, so
only thing the driver needs to do is to call pm_runtime_put() at the end of
its ->probe().

This patch converts wm8994 driver to use this model.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/mfd/wm8994-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 3fdee90..9928bb1 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -706,8 +706,7 @@ static int wm8994_device_init(struct wm8994 *wm8994, int irq)
 		goto err_irq;
 	}
 
-	pm_runtime_enable(wm8994->dev);
-	pm_runtime_idle(wm8994->dev);
+	pm_runtime_put(wm8994->dev);
 
 	return 0;
 
@@ -723,7 +722,7 @@ err:
 
 static void wm8994_device_exit(struct wm8994 *wm8994)
 {
-	pm_runtime_disable(wm8994->dev);
+	pm_runtime_get(wm8994->dev);
 	mfd_remove_devices(wm8994->dev);
 	wm8994_irq_exit(wm8994);
 	regulator_bulk_disable(wm8994->num_supplies,
-- 
1.8.4.rc3
