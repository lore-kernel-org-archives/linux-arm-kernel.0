From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 20 Jun 2014 13:02:28 +0100
Subject: [PATCH 4/9] i2c: Match using traditional OF methods,
 then by vendor-less compatible strings
In-Reply-To: <1403265753-25851-1-git-send-email-lee.jones@linaro.org>
References: <1403265753-25851-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1403265753-25851-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function provides a single call for all I2C devices which need to
match firstly using traditional OF means i.e by of_node, then if that
fails we attempt to match using the supplied I2C client name with a
list of supplied compatible strings with the '<vendor>,' string
removed.  The latter is required due to the unruly naming conventions
used currently by I2C devices.

Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/i2c-core.c | 16 ++++++++++++++++
 include/linux/i2c.h    | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 8a37745..a9c97c4 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1111,6 +1111,22 @@ i2c_of_match_device_strip_vendor(const struct of_device_id *matches,
 	return NULL;
 }
 
+const struct of_device_id
+*i2c_of_match_device(const struct of_device_id *matches,
+		     struct i2c_client *client)
+{
+	const struct of_device_id *match;
+
+	if (!(client && matches))
+		return NULL;
+
+	match = of_match_device(matches, &client->dev);
+	if (match)
+		return match;
+
+	return i2c_of_match_device_strip_vendor(matches, client);
+}
+EXPORT_SYMBOL_GPL(i2c_of_match_device);
 #else
 static void of_i2c_register_devices(struct i2c_adapter *adap) { }
 #endif /* CONFIG_OF */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index b556e0a..3d0350c 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -564,6 +564,10 @@ extern struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
 /* must call put_device() when done with returned i2c_adapter device */
 extern struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node);
 
+extern const struct of_device_id
+*i2c_of_match_device(const struct of_device_id *matches,
+		     struct i2c_client *client);
+
 #else
 
 static inline struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
@@ -575,6 +579,14 @@ static inline struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node
 {
 	return NULL;
 }
+
+const struct of_device_id
+*i2c_of_match_device(const struct of_device_id *matches,
+		     struct i2c_client *client)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_OF */
 
 #endif /* _LINUX_I2C_H */
-- 
1.8.3.2
