From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Dec 2013 15:35:17 -0800
Subject: [PATCH 2/8] mfd: ssbi: Constify buffer in ssbi_write
In-Reply-To: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1386718523-2587-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for passing a const pointer directly to
ssbi_write() from the regmap APIs.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/mfd/ssbi.c   | 8 ++++----
 include/linux/ssbi.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/ssbi.c b/drivers/mfd/ssbi.c
index 435c6f7..dd1d28f 100644
--- a/drivers/mfd/ssbi.c
+++ b/drivers/mfd/ssbi.c
@@ -77,7 +77,7 @@ struct ssbi {
 	spinlock_t		lock;
 	enum ssbi_controller_type controller_type;
 	int (*read)(struct ssbi *, u16 addr, u8 *buf, int len);
-	int (*write)(struct ssbi *, u16 addr, u8 *buf, int len);
+	int (*write)(struct ssbi *, u16 addr, const u8 *buf, int len);
 };
 
 #define to_ssbi(dev)	platform_get_drvdata(to_platform_device(dev))
@@ -146,7 +146,7 @@ err:
 }
 
 static int
-ssbi_write_bytes(struct ssbi *ssbi, u16 addr, u8 *buf, int len)
+ssbi_write_bytes(struct ssbi *ssbi, u16 addr, const u8 *buf, int len)
 {
 	int ret = 0;
 
@@ -223,7 +223,7 @@ err:
 }
 
 static int
-ssbi_pa_write_bytes(struct ssbi *ssbi, u16 addr, u8 *buf, int len)
+ssbi_pa_write_bytes(struct ssbi *ssbi, u16 addr, const u8 *buf, int len)
 {
 	u32 cmd;
 	int ret = 0;
@@ -255,7 +255,7 @@ int ssbi_read(struct device *dev, u16 addr, u8 *buf, int len)
 }
 EXPORT_SYMBOL_GPL(ssbi_read);
 
-int ssbi_write(struct device *dev, u16 addr, u8 *buf, int len)
+int ssbi_write(struct device *dev, u16 addr, const u8 *buf, int len)
 {
 	struct ssbi *ssbi = to_ssbi(dev);
 	unsigned long flags;
diff --git a/include/linux/ssbi.h b/include/linux/ssbi.h
index a92561a..bcbb642 100644
--- a/include/linux/ssbi.h
+++ b/include/linux/ssbi.h
@@ -17,7 +17,7 @@
 
 #include <linux/types.h>
 
-int ssbi_write(struct device *dev, u16 addr, u8 *buf, int len);
+int ssbi_write(struct device *dev, u16 addr, const u8 *buf, int len);
 int ssbi_read(struct device *dev, u16 addr, u8 *buf, int len);
 
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
