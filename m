From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 28 Aug 2014 15:35:32 +0100
Subject: [PATCH 2/8] i2c: Add the ability to match device to compatible string
 without an of_node
In-Reply-To: <1409236538-21274-1-git-send-email-lee.jones@linaro.org>
References: <1409236538-21274-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1409236538-21274-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A great deal of I2C devices are currently matched via DT node name, and
as such the compatible naming convention of '<vendor>,<device>' has gone
somewhat awry - some nodes don't supply one, some supply an arbitrary
string and others the correct device name with an arbitrary vendor prefix.

In an effort to correct this problem we have to supply a mechanism to
match a device by compatible string AND by simple device name.  This
function strips off the '<vendor>,' part of a supplied compatible string
and attempts to match without it.

The plan is to remove this function once all of the compatible strings
for each device have been brought into line.

Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/i2c-core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d3c8e9f..eb46d15 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1095,6 +1095,27 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
 	return i2c_verify_adapter(dev);
 }
 EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
+
+static const struct of_device_id*
+i2c_of_match_device_strip_vendor(const struct of_device_id *matches,
+				  struct i2c_client *client)
+{
+	const char *name;
+
+	for (; matches->compatible[0]; matches++) {
+		name = strchr(matches->compatible, ',');
+		if (!name)
+			name = matches->compatible;
+		else
+			name++;
+
+		if (!strnicmp(client->name, name, strlen(client->name)))
+			return matches;
+	}
+
+	return NULL;
+}
+
 #else
 static void of_i2c_register_devices(struct i2c_adapter *adap) { }
 #endif /* CONFIG_OF */
-- 
1.9.1
