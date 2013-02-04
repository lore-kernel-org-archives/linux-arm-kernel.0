From: yuvaraj.cd@gmail.com (Yuvaraj Kumar C D)
Date: Mon,  4 Feb 2013 14:33:15 +0530
Subject: [RFC] i2c: Providing hooks for i2c multimaster bus arbitration.
Message-ID: <1359968595-21291-1-git-send-email-yuvaraj.cd@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This RFC patch is w.r.t multimaster bus arbitration which is already
being discussing in the mainline.
This patch provides hooks for the i2c multimaster bus arbitration
and to have the arbitration parameters.

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/i2c/i2c-core.c |   13 ++++++++++++-
 include/linux/i2c.h    |   12 ++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e388590..ed89fc8 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1408,18 +1408,29 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 				(msgs[ret].flags & I2C_M_RECV_LEN) ? "+" : "");
 		}
 #endif
+		if (adap->mm_arbit_algo) {
+			ret = adap->mm_arbit_algo->i2c_mm_bus_get(adap);
+			if (ret)
+				/* I2C bus under control of another master. */
+				return -EAGAIN;
+		}
 
 		if (in_atomic() || irqs_disabled()) {
 			ret = i2c_trylock_adapter(adap);
-			if (!ret)
+			if (!ret && adap->mm_arbit_algo) {
+				adap->mm_arbit_algo->i2c_mm_bus_release(adap);
+
 				/* I2C activity is ongoing. */
 				return -EAGAIN;
+			}
 		} else {
 			i2c_lock_adapter(adap);
 		}
 
 		ret = __i2c_transfer(adap, msgs, num);
 		i2c_unlock_adapter(adap);
+		if (adap->mm_arbit_algo)
+			adap->mm_arbit_algo->i2c_mm_bus_release(adap);
 
 		return ret;
 	} else {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index d0c4db7..61fbfe3 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -371,6 +371,17 @@ struct i2c_algorithm {
 };
 
 /*
+ *This struct provides hooks for i2c multi-master arbitration needs.
+ */
+struct i2c_mm_arbitration {
+	void *arbitration_data;
+
+	/* Should return 0 if mastership could be successfully established */
+	int (*i2c_mm_bus_get)(struct i2c_adapter *adap);
+	void (*i2c_mm_bus_release)(struct i2c_adapter *adap);
+};
+
+/*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
  */
@@ -393,6 +404,7 @@ struct i2c_adapter {
 
 	struct mutex userspace_clients_lock;
 	struct list_head userspace_clients;
+	struct i2c_mm_arbitration *mm_arbit_algo;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
-- 
1.7.9.5
