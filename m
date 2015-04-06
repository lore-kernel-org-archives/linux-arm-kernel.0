From: grygorii.strashko@linaro.org (grygorii.strashko at linaro.org)
Date: Mon,  6 Apr 2015 15:38:39 +0300
Subject: [PATCH v4 1/3] i2c: recovery: change input parameter to i2c_adapter
 for prepare/unprepare_recovery
In-Reply-To: <1428323921-25832-1-git-send-email-grygorii.strashko@linaro.org>
References: <1428323921-25832-1-git-send-email-grygorii.strashko@linaro.org>
Message-ID: <1428323921-25832-2-git-send-email-grygorii.strashko@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

This patch changes type of input parameter for .prepare/unprepare_recovery()
callbacks from struct i2c_bus_recovery_info * to struct i2c_adapter *.
This allows to simplify implementation of these callbacks and avoid
type conversations from i2c_bus_recovery_info to i2c_adapter.
The i2c_bus_recovery_info can be simply retrieved from struct i2c_adapter
which contains pointer on it.

CC: Sekhar Nori <nsekhar@ti.com>
CC: Kevin Hilman <khilman@deeprootsystems.com>
CC: Santosh Shilimkar <ssantosh@kernel.org>
CC: Murali Karicheri <m-karicheri2@ti.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/i2c/i2c-core.c | 4 ++--
 include/linux/i2c.h    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index fe80f85..617a19a 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -561,7 +561,7 @@ static int i2c_generic_recovery(struct i2c_adapter *adap)
 	int i = 0, val = 1, ret = 0;
 
 	if (bri->prepare_recovery)
-		bri->prepare_recovery(bri);
+		bri->prepare_recovery(adap);
 
 	/*
 	 * By this time SCL is high, as we need to give 9 falling-rising edges
@@ -586,7 +586,7 @@ static int i2c_generic_recovery(struct i2c_adapter *adap)
 	}
 
 	if (bri->unprepare_recovery)
-		bri->unprepare_recovery(bri);
+		bri->unprepare_recovery(adap);
 
 	return ret;
 }
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index c5e4bb2..898033f 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -435,8 +435,8 @@ struct i2c_bus_recovery_info {
 	void (*set_scl)(struct i2c_adapter *, int val);
 	int (*get_sda)(struct i2c_adapter *);
 
-	void (*prepare_recovery)(struct i2c_bus_recovery_info *bri);
-	void (*unprepare_recovery)(struct i2c_bus_recovery_info *bri);
+	void (*prepare_recovery)(struct i2c_adapter *);
+	void (*unprepare_recovery)(struct i2c_adapter *);
 
 	/* gpio recovery */
 	int scl_gpio;
-- 
1.9.1
