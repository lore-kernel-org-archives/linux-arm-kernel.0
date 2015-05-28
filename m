From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 28 May 2015 19:02:46 +0530
Subject: [PATCH 1/3] i2c: core: append hardware lock with bus lock
In-Reply-To: <1432819968-17515-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432819968-17515-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1432819968-17515-2-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To justify the need for hardware lock, lets take a real usecase scenario -

In case of Marvell SoC, PXA910 silicon, both AP and CP are present and
 these two ARM cores are sharing one pair of I2C pins.

In order to keep I2C transaction operated with atomic, hardware lock
(RIPC) is required.

This patch extends support for atomic operation by adding hardware lock.

History:
The attempt has been made to push this patch-sets upstream sometime back in
2011, but not sure what happened later. I am making another attempt, hopefully
will conclude it now.

Link to previous patch:
http://marc.info/?l=linux-i2c&m=130432846300735&w=2

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/i2c/i2c-core.c | 22 ++++++++++++++++++----
 include/linux/i2c.h    |  5 +++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 987c124..daea523 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -868,8 +868,11 @@ void i2c_lock_adapter(struct i2c_adapter *adapter)
 
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
 
@@ -880,11 +883,19 @@ EXPORT_SYMBOL_GPL(i2c_lock_adapter);
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
@@ -897,8 +908,11 @@ void i2c_unlock_adapter(struct i2c_adapter *adapter)
 
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
index e83a738..0758fb3 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -504,6 +504,11 @@ struct i2c_adapter {
 	/* data fields that are valid for all devices	*/
 	struct rt_mutex bus_lock;
 
+	/* if hardware lock feature provided */
+	void (*hardware_lock)(struct i2c_adapter *);
+	void (*hardware_unlock)(struct i2c_adapter *);
+	int (*hardware_trylock)(struct i2c_adapter *);
+
 	int timeout;			/* in jiffies */
 	int retries;
 	struct device dev;		/* the adapter device */
-- 
1.9.1
