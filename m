From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon,  2 May 2016 16:22:58 +0100
Subject: [PATCH v2 2/2] nvmem: mxs-ocotp: remove nvmem regmap dependency
In-Reply-To: <1462202578-15433-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1462202578-15433-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1462202578-15433-3-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves to nvmem support in the driver to use callback
instead of regmap.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/mxs-ocotp.c | 81 +++++++++++++----------------------------------
 1 file changed, 22 insertions(+), 59 deletions(-)

diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
index 2bb3c57..9bf59d6 100644
--- a/drivers/nvmem/mxs-ocotp.c
+++ b/drivers/nvmem/mxs-ocotp.c
@@ -25,7 +25,6 @@
 #include <linux/nvmem-provider.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/stmp_device.h>
 
@@ -66,11 +65,10 @@ static int mxs_ocotp_wait(struct mxs_ocotp *otp)
 	return 0;
 }
 
-static int mxs_ocotp_read(void *context, const void *reg, size_t reg_size,
-			  void *val, size_t val_size)
+static int mxs_ocotp_read(void *context, unsigned int offset,
+			  void *val, size_t bytes)
 {
 	struct mxs_ocotp *otp = context;
-	unsigned int offset = *(u32 *)reg;
 	u32 *buf = val;
 	int ret;
 
@@ -94,17 +92,16 @@ static int mxs_ocotp_read(void *context, const void *reg, size_t reg_size,
 	if (ret)
 		goto close_banks;
 
-	while (val_size >= reg_size) {
+	while (bytes) {
 		if ((offset < OCOTP_DATA_OFFSET) || (offset % 16)) {
 			/* fill up non-data register */
-			*buf = 0;
+			*buf++ = 0;
 		} else {
-			*buf = readl(otp->base + offset);
+			*buf++ = readl(otp->base + offset);
 		}
 
-		buf++;
-		val_size -= reg_size;
-		offset += reg_size;
+		bytes -= 4;
+		offset += 4;
 	}
 
 close_banks:
@@ -117,57 +114,29 @@ disable_clk:
 	return ret;
 }
 
-static int mxs_ocotp_write(void *context, const void *data, size_t count)
-{
-	/* We don't want to support writing */
-	return 0;
-}
-
-static bool mxs_ocotp_writeable_reg(struct device *dev, unsigned int reg)
-{
-	return false;
-}
-
 static struct nvmem_config ocotp_config = {
 	.name = "mxs-ocotp",
+	.stride = 16,
+	.word_size = 4,
 	.owner = THIS_MODULE,
+	.reg_read = mxs_ocotp_read,
 };
 
-static const struct regmap_range imx23_ranges[] = {
-	regmap_reg_range(OCOTP_DATA_OFFSET, 0x210),
-};
-
-static const struct regmap_access_table imx23_access = {
-	.yes_ranges = imx23_ranges,
-	.n_yes_ranges = ARRAY_SIZE(imx23_ranges),
-};
-
-static const struct regmap_range imx28_ranges[] = {
-	regmap_reg_range(OCOTP_DATA_OFFSET, 0x290),
-};
-
-static const struct regmap_access_table imx28_access = {
-	.yes_ranges = imx28_ranges,
-	.n_yes_ranges = ARRAY_SIZE(imx28_ranges),
+struct mxs_data {
+	int size;
 };
 
-static struct regmap_bus mxs_ocotp_bus = {
-	.read = mxs_ocotp_read,
-	.write = mxs_ocotp_write, /* make regmap_init() happy */
-	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
-	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
+static const struct mxs_data imx23_data = {
+	.size = 0x210,
 };
 
-static struct regmap_config mxs_ocotp_config = {
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_stride = 16,
-	.writeable_reg = mxs_ocotp_writeable_reg,
+static const struct mxs_data imx28_data = {
+	.size = 0x290,
 };
 
 static const struct of_device_id mxs_ocotp_match[] = {
-	{ .compatible = "fsl,imx23-ocotp", .data = &imx23_access },
-	{ .compatible = "fsl,imx28-ocotp", .data = &imx28_access },
+	{ .compatible = "fsl,imx23-ocotp", .data = &imx23_data },
+	{ .compatible = "fsl,imx28-ocotp", .data = &imx23_data },
 	{ /* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, mxs_ocotp_match);
@@ -175,6 +144,7 @@ MODULE_DEVICE_TABLE(of, mxs_ocotp_match);
 static int mxs_ocotp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct mxs_data *data;
 	struct mxs_ocotp *otp;
 	struct resource *res;
 	const struct of_device_id *match;
@@ -205,17 +175,10 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	access = match->data;
-	mxs_ocotp_config.rd_table = access;
-	mxs_ocotp_config.max_register = access->yes_ranges[0].range_max;
-
-	regmap = devm_regmap_init(dev, &mxs_ocotp_bus, otp, &mxs_ocotp_config);
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "regmap init failed\n");
-		ret = PTR_ERR(regmap);
-		goto err_clk;
-	}
+	data = match->data;
 
+	ocotp_config.size = data->size;
+	ocotp_config.priv = otp;
 	ocotp_config.dev = dev;
 	otp->nvmem = nvmem_register(&ocotp_config);
 	if (IS_ERR(otp->nvmem)) {
-- 
2.5.0
