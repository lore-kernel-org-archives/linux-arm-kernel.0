From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 28 Apr 2011 23:15:44 +0800
Subject: [PATCH 1/3] i2c: append hardware lock with bus lock
In-Reply-To: <2011042801>
References: <2011042801>
Message-ID: <1304003746-12127-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both AP and CP are contained in Marvell PXA910 silicon. These two ARM
cores are sharing one pair of I2C pins.

In order to keep I2C transaction operated with atomic, hardware lock
(RIPC) is required. Because of this, bus lock in AP side can't afford
this requirement. Now hardware lock is appended.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/i2c-core.c |   22 ++++++++++++++++++----
 include/linux/i2c.h    |    3 +++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 045ba6e..132d46c 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -448,8 +448,11 @@ void i2c_lock_adapter(struct i2c_adapter *adapter)
 
 	if (parent)
 		i2c_lock_adapter(parent);
-	else
+	else {
 		rt_mutex_lock(&adapter->bus_lock);
+		if (adapter->hardware_lock)
+			adapter->hardware_lock(adapter);
+	}
 }
 EXPORT_SYMBOL_GPL(i2c_lock_adapter);
 
@@ -460,11 +463,19 @@ EXPORT_SYMBOL_GPL(i2c_lock_adapter);
 static int i2c_trylock_adapter(struct i2c_adapter *adapter)
 {
 	struct i2c_adapter *parent = i2c_parent_is_i2c_adapter(adapter);
+	int ret = 0;
 
 	if (parent)
 		return i2c_trylock_adapter(parent);
-	else
-		return rt_mutex_trylock(&adapter->bus_lock);
+	else {
+		ret = rt_mutex_trylock(&adapter->bus_lock);
+		if (ret && adapter->hardware_trylock) {
+			ret = adapter->hardware_trylock(adapter);
+			if (!ret)
+				i2c_unlock_adapter(adapter);
+		}
+		return ret;
+	}
 }
 
 /**
@@ -477,8 +488,11 @@ void i2c_unlock_adapter(struct i2c_adapter *adapter)
 
 	if (parent)
 		i2c_unlock_adapter(parent);
-	else
+	else {
+		if (adapter->hardware_unlock)
+			adapter->hardware_unlock(adapter);
 		rt_mutex_unlock(&adapter->bus_lock);
+	}
 }
 EXPORT_SYMBOL_GPL(i2c_unlock_adapter);
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 06a8d9c..f4ef5b0 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -361,6 +361,9 @@ struct i2c_adapter {
 
 	/* data fields that are valid for all devices	*/
 	struct rt_mutex bus_lock;
+	void (*hardware_lock)(struct i2c_adapter *);
+	void (*hardware_unlock)(struct i2c_adapter *);
+	int (*hardware_trylock)(struct i2c_adapter *);
 
 	int timeout;			/* in jiffies */
 	int retries;
-- 
1.7.1
