From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Jun 2012 13:56:38 +0100
Subject: [PATCH 02/15] mfd: Generically describe interactions with the DB8500
 PRCMU
In-Reply-To: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1340197011-5435-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is only one method used to communicate with the DB8500 PRCMU, via I2C.
Now this can be assumed, there is no requirement to specify the protocol in
the function name. This patch removes protocol specifics and uses a more
generic naming convention.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-core.c    |   12 ++++++------
 drivers/mfd/ab8500-debugfs.c |    6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index bf2ba0a..8de3b65 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -141,7 +141,7 @@ static const char ab8500_version_str[][7] = {
 	[AB8500_VERSION_AB8540] = "AB8540",
 };
 
-static int ab8500_i2c_write(struct ab8500 *ab8500, u16 addr, u8 data)
+static int ab8500_prcmu_write(struct ab8500 *ab8500, u16 addr, u8 data)
 {
 	int ret;
 
@@ -151,7 +151,7 @@ static int ab8500_i2c_write(struct ab8500 *ab8500, u16 addr, u8 data)
 	return ret;
 }
 
-static int ab8500_i2c_write_masked(struct ab8500 *ab8500, u16 addr, u8 mask,
+static int ab8500_prcmu_write_masked(struct ab8500 *ab8500, u16 addr, u8 mask,
 	u8 data)
 {
 	int ret;
@@ -163,7 +163,7 @@ static int ab8500_i2c_write_masked(struct ab8500 *ab8500, u16 addr, u8 mask,
 	return ret;
 }
 
-static int ab8500_i2c_read(struct ab8500 *ab8500, u16 addr)
+static int ab8500_prcmu_read(struct ab8500 *ab8500, u16 addr)
 {
 	int ret;
 	u8 data;
@@ -1267,9 +1267,9 @@ static int __devinit ab8500_probe(struct platform_device *pdev)
 
 	ab8500->irq = resource->start;
 
-	ab8500->read = ab8500_i2c_read;
-	ab8500->write = ab8500_i2c_write;
-	ab8500->write_masked = ab8500_i2c_write_masked;
+	ab8500->read = ab8500_prcmu_read;
+	ab8500->write = ab8500_prcmu_write;
+	ab8500->write_masked = ab8500_prcmu_write_masked;
 
 	mutex_init(&ab8500->lock);
 	mutex_init(&ab8500->irq_lock);
diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 50c4c89..361de52 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -31,12 +31,12 @@ struct ab8500_reg_range {
 };
 
 /**
- * struct ab8500_i2c_ranges
+ * struct ab8500_prcmu_ranges
  * @num_ranges: the number of ranges in the list
  * @bankid: bank identifier
  * @range: the list of register ranges
  */
-struct ab8500_i2c_ranges {
+struct ab8500_prcmu_ranges {
 	u8 num_ranges;
 	u8 bankid;
 	const struct ab8500_reg_range *range;
@@ -47,7 +47,7 @@ struct ab8500_i2c_ranges {
 
 #define AB8500_REV_REG 0x80
 
-static struct ab8500_i2c_ranges debug_ranges[AB8500_NUM_BANKS] = {
+static struct ab8500_prcmu_ranges debug_ranges[AB8500_NUM_BANKS] = {
 	[0x0] = {
 		.num_ranges = 0,
 		.range = 0,
-- 
1.7.9.5
