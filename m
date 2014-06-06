From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  6 Jun 2014 16:52:28 +0100
Subject: [PATCH 5/9] i2c: Export i2c_match_id() for direct use by device
 drivers
In-Reply-To: <1402069952-28022-1-git-send-email-lee.jones@linaro.org>
References: <1402069952-28022-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1402069952-28022-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When there was no other way to match a I2C device to driver i2c_match_id()
was exclusively used.  However, now there are other types of tables which
are commonly supplied, matching on an i2c_device_id table is used less
frequently.  Instead of _always_ calling i2c_match_id() from within the
framework, we only need to do so from drivers which have no other way of
matching.  This patch makes i2c_match_id() available to the aforementioned
device drivers.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/i2c-core.c | 3 ++-
 include/linux/i2c.h    | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 3507087..3fe8232 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -79,7 +79,7 @@ void i2c_transfer_trace_unreg(void)
 
 /* ------------------------------------------------------------------------- */
 
-static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
+const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 						const struct i2c_client *client)
 {
 	if (!(id && client))
@@ -92,6 +92,7 @@ static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(i2c_match_id);
 
 static int i2c_device_match(struct device *dev, struct device_driver *drv)
 {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index ab5866f..9d36f86 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -229,6 +229,8 @@ struct i2c_client {
 
 extern struct i2c_client *i2c_verify_client(struct device *dev);
 extern struct i2c_adapter *i2c_verify_adapter(struct device *dev);
+extern const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
+						const struct i2c_client *client);
 
 static inline struct i2c_client *kobj_to_i2c_client(struct kobject *kobj)
 {
-- 
1.8.3.2
