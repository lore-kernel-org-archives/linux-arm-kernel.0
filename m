From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 13 Sep 2016 18:12:39 +0200
Subject: [PATCH 1/3] nvmem: add NXP LPC18xx OTP driver
In-Reply-To: <20160913161241.22492-1-manabian@gmail.com>
References: <20160913161241.22492-1-manabian@gmail.com>
Message-ID: <20160913161241.22492-2-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple read only driver for the internal OTP (One Time Programmable)
memory found on all NXP LPC18xx and LPC43xx devices.

The OTP memory is split into 4 banks each with 4 32-bits word. Some of
the banks contain predefined data while others are for general purpose
and user programmable via the OTP API in ROM. Note that writing to the
OTP memory is not yet supported.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 drivers/nvmem/Kconfig       |  10 ++++
 drivers/nvmem/Makefile      |   2 +
 drivers/nvmem/lpc18xx_otp.c | 123 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 drivers/nvmem/lpc18xx_otp.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index f550c45..282037b 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -35,6 +35,16 @@ config NVMEM_LPC18XX_EEPROM
 	  To compile this driver as a module, choose M here: the module
 	  will be called nvmem_lpc18xx_eeprom.
 
+config NVMEM_LPC18XX_OTP
+	tristate "NXP LPC18XX OTP Memory Support"
+	depends on ARCH_LPC18XX || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say Y here to include support for NXP LPC18xx OTP memory found on
+	  all LPC18xx and LPC43xx devices.
+	  To compile this driver as a module, choose M here: the module
+	  will be called nvmem_lpc18xx_otp.
+
 config NVMEM_MXS_OCOTP
 	tristate "Freescale MXS On-Chip OTP Memory Support"
 	depends on ARCH_MXS || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 45ab1ae..df485a9 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -10,6 +10,8 @@ obj-$(CONFIG_NVMEM_IMX_OCOTP)	+= nvmem-imx-ocotp.o
 nvmem-imx-ocotp-y		:= imx-ocotp.o
 obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
 nvmem_lpc18xx_eeprom-y	:= lpc18xx_eeprom.o
+obj-$(CONFIG_NVMEM_LPC18XX_OTP)	+= nvmem_lpc18xx_otp.o
+nvmem_lpc18xx_otp-y		:= lpc18xx_otp.o
 obj-$(CONFIG_NVMEM_MXS_OCOTP)	+= nvmem-mxs-ocotp.o
 nvmem-mxs-ocotp-y		:= mxs-ocotp.o
 obj-$(CONFIG_MTK_EFUSE)		+= nvmem_mtk-efuse.o
diff --git a/drivers/nvmem/lpc18xx_otp.c b/drivers/nvmem/lpc18xx_otp.c
new file mode 100644
index 0000000..b78ed0b
--- /dev/null
+++ b/drivers/nvmem/lpc18xx_otp.c
@@ -0,0 +1,123 @@
+/*
+ * NXP LPC18xx/43xx OTP memory NVMEM driver
+ *
+ * Copyright (c) 2016 Joachim Eastwood <manabian@gmail.com>
+ *
+ * Based on the imx ocotp driver,
+ * Copyright (c) 2015 Pengutronix, Philipp Zabel <p.zabel@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * TODO: add support for writing OTP register via API in boot ROM.
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/*
+ * LPC18xx OTP memory contains 4 banks with 4 32-bit words. Bank 0 starts
+ * at offset 0 from the base.
+ *
+ * Bank 0 contains the part ID for Flashless devices and is reseverd for
+ * devices with Flash.
+ * Bank 1/2 is generale purpose or AES key storage for secure devices.
+ * Bank 3 contains control data, USB ID and generale purpose words.
+ */
+#define LPC18XX_OTP_NUM_BANKS		4
+#define LPC18XX_OTP_WORDS_PER_BANK	4
+#define LPC18XX_OTP_WORD_SIZE		sizeof(u32)
+#define LPC18XX_OTP_SIZE		(LPC18XX_OTP_NUM_BANKS * \
+					 LPC18XX_OTP_WORDS_PER_BANK * \
+					 LPC18XX_OTP_WORD_SIZE)
+
+struct lpc18xx_otp {
+	void __iomem *base;
+};
+
+static int lpc18xx_otp_read(void *context, unsigned int offset,
+			    void *val, size_t bytes)
+{
+	struct lpc18xx_otp *otp = context;
+	unsigned int count = bytes >> 2;
+	u32 index = offset >> 2;
+	u32 *buf = val;
+	int i;
+
+	if (count > (LPC18XX_OTP_SIZE - index))
+		count = LPC18XX_OTP_SIZE - index;
+
+	for (i = index; i < (index + count); i++)
+		*buf++ = readl(otp->base + i * LPC18XX_OTP_WORD_SIZE);
+
+	return 0;
+}
+
+static struct nvmem_config lpc18xx_otp_nvmem_config = {
+	.name = "lpc18xx-otp",
+	.read_only = true,
+	.word_size = LPC18XX_OTP_WORD_SIZE,
+	.stride = LPC18XX_OTP_WORD_SIZE,
+	.owner = THIS_MODULE,
+	.reg_read = lpc18xx_otp_read,
+};
+
+static int lpc18xx_otp_probe(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem;
+	struct lpc18xx_otp *otp;
+	struct resource *res;
+
+	otp = devm_kzalloc(&pdev->dev, sizeof(*otp), GFP_KERNEL);
+	if (!otp)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	otp->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(otp->base))
+		return PTR_ERR(otp->base);
+
+	lpc18xx_otp_nvmem_config.size = LPC18XX_OTP_SIZE;
+	lpc18xx_otp_nvmem_config.dev = &pdev->dev;
+	lpc18xx_otp_nvmem_config.priv = otp;
+
+	nvmem = nvmem_register(&lpc18xx_otp_nvmem_config);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
+	platform_set_drvdata(pdev, nvmem);
+
+	return 0;
+}
+
+static int lpc18xx_otp_remove(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
+	return nvmem_unregister(nvmem);
+}
+
+static const struct of_device_id lpc18xx_otp_dt_ids[] = {
+	{ .compatible = "nxp,lpc1850-otp" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lpc18xx_otp_dt_ids);
+
+static struct platform_driver lpc18xx_otp_driver = {
+	.probe	= lpc18xx_otp_probe,
+	.remove	= lpc18xx_otp_remove,
+	.driver = {
+		.name	= "lpc18xx_otp",
+		.of_match_table = lpc18xx_otp_dt_ids,
+	},
+};
+module_platform_driver(lpc18xx_otp_driver);
+
+MODULE_AUTHOR("Joachim Eastwoood <manabian@gmail.com>");
+MODULE_DESCRIPTION("NXP LPC18xx OTP NVMEM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.3
