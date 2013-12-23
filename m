From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Dec 2013 12:46:00 -0800
Subject: [PATCH v2 4/7] mfd: ssbi: Add regmap read/write helpers
In-Reply-To: <1387831563-13535-1-git-send-email-sboyd@codeaurora.org>
References: <1387831563-13535-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1387831563-13535-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add read and write helper functions that the pm8921-core driver
can use to read and write ssbi regsiters via a "no-bus" regmap.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/mfd/ssbi.c   | 13 +++++++++++++
 include/linux/ssbi.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/mfd/ssbi.c b/drivers/mfd/ssbi.c
index b78942e..c5d270f 100644
--- a/drivers/mfd/ssbi.c
+++ b/drivers/mfd/ssbi.c
@@ -269,6 +269,19 @@ int ssbi_write(struct device *dev, u16 addr, const u8 *buf, int len)
 }
 EXPORT_SYMBOL_GPL(ssbi_write);
 
+int ssbi_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	*val = 0;
+	return ssbi_read(context, reg, (u8 *)val, 1);
+}
+EXPORT_SYMBOL_GPL(ssbi_reg_read);
+
+int ssbi_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	return ssbi_write(context, reg, (u8 *)&val, 1);
+}
+EXPORT_SYMBOL_GPL(ssbi_reg_write);
+
 static int ssbi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
diff --git a/include/linux/ssbi.h b/include/linux/ssbi.h
index bcbb642..b862f3d 100644
--- a/include/linux/ssbi.h
+++ b/include/linux/ssbi.h
@@ -20,4 +20,7 @@
 int ssbi_write(struct device *dev, u16 addr, const u8 *buf, int len);
 int ssbi_read(struct device *dev, u16 addr, u8 *buf, int len);
 
+int ssbi_reg_read(void *context, unsigned int reg, unsigned int *val);
+int ssbi_reg_write(void *context, unsigned int reg, unsigned int val);
+
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
