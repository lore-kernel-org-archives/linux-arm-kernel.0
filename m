From: nicola@corna.info (Nicola Corna)
Date: Thu, 29 Oct 2015 12:34:26 +0100
Subject: [PATCH 4/5] i2c: add i2c_check_quirks helper function
In-Reply-To: <1446118467-26453-1-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
Message-ID: <1446118467-26453-4-git-send-email-nicola@corna.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a i2c_check_quirks helper function to check the quirk flags
of an i2c adapter, in a similar way to i2c_check_functionality.

Signed-off-by: Nicola Corna <nicola@corna.info>
---
 include/linux/i2c.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 9697002..51028f3 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -617,6 +617,20 @@ static inline int i2c_check_functionality(struct i2c_adapter *adap, u32 func)
 	return (func & i2c_get_functionality(adap)) == func;
 }
 
+/**
+ * i2c_check_quirks() - Function for checking the quirk flags in an i2c adapter
+ * @adap: i2c adapter
+ * @quirks: quirk flags
+ *
+ * Return: true if the adapter has all the specified quirk flags, false if not
+ */
+static inline bool i2c_check_quirks(struct i2c_adapter *adap, u64 quirks)
+{
+	if (!adap->quirks)
+		return false;
+	return (adap->quirks->flags & quirks) == quirks;
+}
+
 /* Return the adapter number for a specific adapter */
 static inline int i2c_adapter_id(struct i2c_adapter *adap)
 {
-- 
2.6.1
