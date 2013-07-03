From: cb@sgoc.de (Christoph G. Baumann)
Date: Wed,  3 Jul 2013 14:39:12 +0200
Subject: [PATCH 1/3] Added support for On Chip OTP in i.MX23/28
In-Reply-To: <1372855154-8422-1-git-send-email-cb@sgoc.de>
References: <1372855154-8422-1-git-send-email-cb@sgoc.de>
Message-ID: <1372855154-8422-2-git-send-email-cb@sgoc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Christoph G. Baumann" <cb@sgoc.de>

Signed-off-by: Christoph G. Baumann <cb@sgoc.de>
---
 drivers/misc/fsl_otp.c |  249 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/fsl_otp.h |  201 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 450 insertions(+)
 create mode 100644 drivers/misc/fsl_otp.c
 create mode 100644 drivers/misc/fsl_otp.h

diff --git a/drivers/misc/fsl_otp.c b/drivers/misc/fsl_otp.c
new file mode 100644
index 0000000..fd1941a
--- /dev/null
+++ b/drivers/misc/fsl_otp.c
@@ -0,0 +1,249 @@
+/*
+ * Freescale On-Chip OTP driver
+ *
+ * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * Ported to 3.7 by Christoph G. Baumann <cgb@debian.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+#include <linux/kobject.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/fcntl.h>
+#include <linux/mutex.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+
+#include "fsl_otp.h"
+
+static DEFINE_MUTEX(otp_mutex);
+static struct kobject *otp_kobj;
+static struct attribute **attrs;
+static struct kobj_attribute *kattr;
+static struct attribute_group attr_group;
+
+static inline unsigned int get_reg_index(struct kobj_attribute *tmp)
+{
+	return tmp - kattr;
+}
+
+static int otp_wait_busy(u32 flags)
+{
+	int count;
+	u32 c;
+
+	for (count = 10000; count >= 0; count--) {
+		c = __raw_readl(REGS_OCOTP_BASE + HW_OCOTP_CTRL);
+		if (!(c & (BM_OCOTP_CTRL_BUSY | BM_OCOTP_CTRL_ERROR | flags)))
+			break;
+		cpu_relax();
+	}
+
+	if (count < 0)
+		return -ETIMEDOUT;
+	return 0;
+}
+
+static ssize_t otp_show(struct kobject *kobj, struct kobj_attribute *attr,
+		      char *buf)
+{
+	unsigned int index = get_reg_index(attr);
+	u32 value = 0;
+
+	/* sanity check */
+	if (index >= otp_data.fuse_num)
+		return 0;
+
+	mutex_lock(&otp_mutex);
+
+	if (otp_read_prepare()) {
+		mutex_unlock(&otp_mutex);
+		return 0;
+	}
+	value = __raw_readl(REGS_OCOTP_BASE + HW_OCOTP_CUST_N(index));
+	otp_read_post();
+
+	mutex_unlock(&otp_mutex);
+	return sprintf(buf, "0x%x\n", value);
+}
+
+static int otp_write_bits(int addr, u32 data, u32 magic)
+{
+	u32 c; /* for control register */
+
+	/* init the control register */
+	c = __raw_readl(REGS_OCOTP_BASE + HW_OCOTP_CTRL);
+	c &= ~BM_OCOTP_CTRL_ADDR;
+	c |= BF(addr, OCOTP_CTRL_ADDR);
+	c |= BF(magic, OCOTP_CTRL_WR_UNLOCK);
+	__raw_writel(c, REGS_OCOTP_BASE + HW_OCOTP_CTRL);
+
+	/* init the data register */
+	__raw_writel(data, REGS_OCOTP_BASE + HW_OCOTP_DATA);
+	otp_wait_busy(0);
+
+	mdelay(2); /* Write Postamble */
+	return 0;
+}
+
+static ssize_t otp_store(struct kobject *kobj, struct kobj_attribute *attr,
+		       const char *buf, size_t count)
+{
+	unsigned int index = get_reg_index(attr);
+	int value;
+
+	/* sanity check */
+	if (index >= otp_data.fuse_num)
+		return 0;
+
+	sscanf(buf, "0x%x", &value);
+
+	mutex_lock(&otp_mutex);
+	if (otp_write_prepare()) {
+		mutex_unlock(&otp_mutex);
+		return 0;
+	}
+	otp_write_bits(index, value, 0x3e77);
+	otp_write_post();
+	mutex_unlock(&otp_mutex);
+
+	return count;
+}
+
+static void free_otp_attr(void)
+{
+	kfree(attrs);
+	attrs = NULL;
+
+	kfree(kattr);
+	kattr = NULL;
+}
+
+static int alloc_otp_attr(void)
+{
+	int i;
+
+	/* The last one is NULL, which is used to detect the end */
+	attrs = kzalloc((otp_data.fuse_num + 1) * sizeof(attrs[0]),
+			GFP_KERNEL);
+	kattr = kzalloc(otp_data.fuse_num * sizeof(struct kobj_attribute),
+			GFP_KERNEL);
+
+	if (!attrs || !kattr)
+		goto error_out;
+
+	for (i = 0; i < otp_data.fuse_num; i++) {
+		kattr[i].attr.name = otp_data.fuse_name[i];
+		kattr[i].attr.mode = 0600;
+		kattr[i].show  = otp_show;
+		kattr[i].store = otp_store;
+		attrs[i] = &kattr[i].attr;
+		sysfs_attr_init(attrs[i]);
+	}
+	memset(&attr_group, 0, sizeof(attr_group));
+	attr_group.attrs = attrs;
+	return 0;
+
+error_out:
+	free_otp_attr();
+	return -ENOMEM;
+}
+
+static int fsl_otp_probe(struct platform_device *pdev)
+{
+	int retval;
+	struct fsl_otp_data *pdata;
+
+
+	pdata = &otp_data;
+	if (pdev->dev.platform_data == NULL)
+		pdev->dev.platform_data = &otp_data;
+
+	retval = alloc_otp_attr();
+	if (retval)
+		return retval;
+
+	retval = map_ocotp_addr(pdev);
+	if (retval)
+		goto error;
+
+	otp_kobj = kobject_create_and_add("fsl_otp", NULL);
+	if (!otp_kobj) {
+		retval = -ENOMEM;
+		goto error;
+	}
+
+	retval = sysfs_create_group(otp_kobj, &attr_group);
+	if (retval)
+		goto error;
+
+	mutex_init(&otp_mutex);
+	return 0;
+error:
+	kobject_put(otp_kobj);
+	otp_kobj = NULL;
+	free_otp_attr();
+	unmap_ocotp_addr();
+	return retval;
+}
+
+static int otp_remove(struct platform_device *pdev)
+{
+	kobject_put(otp_kobj);
+	otp_kobj = NULL;
+
+	free_otp_attr();
+	unmap_ocotp_addr();
+	return 0;
+}
+
+static const struct of_device_id mxs_otp_dt_ids[] = {
+	{ .compatible = "fsl,ocotp", .data = NULL, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxs_otp_dt_ids);
+
+static struct platform_driver ocotp_driver = {
+	.probe		= fsl_otp_probe,
+	.remove		= otp_remove,
+	.driver		= {
+		.name   = "ocotp",
+		.owner	= THIS_MODULE,
+		.of_match_table = mxs_otp_dt_ids,
+	},
+};
+
+static int __init fsl_otp_init(void)
+{
+	return platform_driver_register(&ocotp_driver);
+}
+
+static void __exit fsl_otp_exit(void)
+{
+	platform_driver_unregister(&ocotp_driver);
+}
+module_init(fsl_otp_init);
+module_exit(fsl_otp_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Huang Shijie <b32955@freescale.com>");
+MODULE_DESCRIPTION("Common driver for OTP controller");
diff --git a/drivers/misc/fsl_otp.h b/drivers/misc/fsl_otp.h
new file mode 100644
index 0000000..b429479
--- /dev/null
+++ b/drivers/misc/fsl_otp.h
@@ -0,0 +1,201 @@
+/*
+ * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * Ported to 3.7 by Christoph G. Baumann <cgb@debian.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#ifndef __FREESCALE_OTP__
+#define __FREESCALE_OTP__
+
+
+static int otp_wait_busy(u32 flags);
+
+/* IMX23 and IMX28 share most of the defination ========================= */
+#if (defined(CONFIG_SOC_IMX23) || defined(CONFIG_SOC_IMX28))
+
+#if defined(CONFIG_SOC_IMX28) && defined(CONFIG_SOC_IMX23)
+#undef CONFIG_SOC_IMX23
+#endif
+
+#include <linux/regulator/consumer.h>
+#include <mach/hardware.h>
+#include <mach/mxs.h>
+
+#if defined(CONFIG_SOC_IMX23)
+#include <mach/mx23.h>
+#include <mach/mx23-ocotp.h>
+#else
+#include <mach/mx28.h>
+#include <mach/mx28-ocotp.h>
+#endif
+
+#define OCOTP_PHYS_ADDR         MXS_OCOTP_BASE_ADDR
+#define REGS_OCOTP_BASE		(MXS_IO_ADDRESS(OCOTP_PHYS_ADDR))
+#define BF(value, field)	(((value) << BP_##field) & BM_##field)
+
+#if defined(CONFIG_SOC_IMX28)
+/* Building up eight registers's names of a bank */
+#define MXS_OTP_BANK(a, b, c, d, e, f, g, h)	\
+	{\
+	("HW_OCOTP_"#a), ("HW_OCOTP_"#b), ("HW_OCOTP_"#c), ("HW_OCOTP_"#d), \
+	("HW_OCOTP_"#e), ("HW_OCOTP_"#f), ("HW_OCOTP_"#g), ("HW_OCOTP_"#h) \
+	}
+
+#define MXS_OTP_BANKS		(5)
+#define MXS_OTP_BANK_ITEMS	(8)
+static const char *bank_reg_desc[MXS_OTP_BANKS][MXS_OTP_BANK_ITEMS] = {
+MXS_OTP_BANK(CUST0, CUST1, CUST2, CUST3, CRYPTO0, CRYPTO1, CRYPTO2, CRYPTO3),
+MXS_OTP_BANK(HWCAP0, HWCAP1, HWCAP2, HWCAP3, HWCAP4, HWCAP5, SWCAP, CUSTCAP),
+MXS_OTP_BANK(LOCK, OPS0, OPS1, OPS2, OPS3, UN0, UN1, UN2),
+MXS_OTP_BANK(ROM0, ROM1, ROM2, ROM3, ROM4, ROM5, ROM6, ROM7),
+MXS_OTP_BANK(SRK0, SRK1, SRK2, SRK3, SRK4, SRK5, SRK6, SRK7),
+};
+#endif /* if defined(CONFIG_SOC_IMX28) */
+
+
+#if defined(CONFIG_SOC_IMX23)
+/* Building up eight registers's names of a bank */
+#define MXS_OTP_BANK(a, b, c, d, e, f, g, h)	\
+	{\
+	("HW_OCOTP_"#a), ("HW_OCOTP_"#b), ("HW_OCOTP_"#c), ("HW_OCOTP_"#d), \
+	("HW_OCOTP_"#e), ("HW_OCOTP_"#f), ("HW_OCOTP_"#g), ("HW_OCOTP_"#h) \
+	}
+
+#define MXS_OTP_BANKS		(4)
+#define MXS_OTP_BANK_ITEMS	(8)
+static const char *bank_reg_desc[MXS_OTP_BANKS][MXS_OTP_BANK_ITEMS] = {
+MXS_OTP_BANK(CUST0, CUST1, CUST2, CUST3, CRYPTO0, CRYPTO1, CRYPTO2, CRYPTO3),
+MXS_OTP_BANK(HWCAP0, HWCAP1, HWCAP2, HWCAP3, HWCAP4, HWCAP5, SWCAP, CUSTCAP),
+MXS_OTP_BANK(LOCK, OPS0, OPS1, OPS2, OPS3, UN0, UN1, UN2),
+MXS_OTP_BANK(ROM0, ROM1, ROM2, ROM3, ROM4, ROM5, ROM6, ROM7),
+};
+
+#endif/* if defined(CONFIG_SOC_IMX23) */
+
+static unsigned long otp_hclk_saved;
+static u32 otp_voltage_saved;
+struct regulator *regu;
+
+struct fsl_otp_data {
+	char		**fuse_name;
+	char		*regulator_name;
+	unsigned int	fuse_num;
+};
+
+static struct fsl_otp_data otp_data = {
+	.fuse_name	= (char **)bank_reg_desc,
+	.regulator_name	= "vddio-sd0",
+	.fuse_num	= MXS_OTP_BANKS * MXS_OTP_BANK_ITEMS,
+};
+
+/* open the bank for the imx23/imx28 */
+static int otp_read_prepare(void)
+{
+	int r;
+
+	/* [1] set the HCLK */
+	/* [2] check BUSY and ERROR bit */
+	r = otp_wait_busy(0);
+	if (r < 0)
+		goto error;
+
+	/* [3] open bank */
+	__raw_writel(BM_OCOTP_CTRL_RD_BANK_OPEN,
+		REGS_OCOTP_BASE + HW_OCOTP_CTRL_SET);
+	udelay(10);
+
+	/* [4] wait for BUSY */
+	r = otp_wait_busy(0);
+	return 0;
+error:
+	return r;
+}
+
+static int otp_read_post(void)
+{
+	/* [5] close bank */
+	__raw_writel(BM_OCOTP_CTRL_RD_BANK_OPEN,
+		REGS_OCOTP_BASE + HW_OCOTP_CTRL_CLR);
+	return 0;
+}
+
+static int otp_write_prepare(void)
+{
+	struct clk *hclk;
+	int err = 0;
+
+	/* [1] HCLK to 24MHz. */
+	hclk = clk_get_sys("hbus", NULL);
+	if (IS_ERR(hclk)) {
+		err = PTR_ERR(hclk);
+		goto out;
+	}
+	/*
+	   WARNING  ACHTUNG  UWAGA
+
+	   the code below changes HCLK clock rate to 24M. This is
+	   required to write OTP bits (7.2.2 in STMP378x Target
+	   Specification), and might affect LCD operation, for example.
+	   Moreover, this hacky code changes VDDIO to 2.8V; and resto-
+	   res it only on otp_close(). This may affect... anything.
+
+	   You are warned now.
+	 */
+	otp_hclk_saved = clk_get_rate(hclk);
+	clk_set_rate(hclk, 24000000);
+
+	/* [2] The voltage is set to 2.8V */
+	regu = regulator_get(NULL, otp_data.regulator_name);
+	otp_voltage_saved = regulator_get_voltage(regu);
+	regulator_set_voltage(regu, 2800000, 2800000);
+
+	/* [3] wait for BUSY and ERROR */
+	err = otp_wait_busy(BM_OCOTP_CTRL_RD_BANK_OPEN);
+out:
+	return err;
+}
+
+static int otp_write_post(void)
+{
+	struct clk *hclk;
+
+	hclk = clk_get_sys("hbus", NULL);
+	if (IS_ERR(hclk))
+		return PTR_ERR(hclk);
+
+	/* restore the clock and voltage */
+	clk_set_rate(hclk, otp_hclk_saved);
+	regulator_set_voltage(regu, otp_voltage_saved, otp_voltage_saved);
+	otp_wait_busy(0);
+
+	/* reset */
+	__raw_writel(BM_OCOTP_CTRL_RELOAD_SHADOWS,
+			REGS_OCOTP_BASE + HW_OCOTP_CTRL_SET);
+	otp_wait_busy(BM_OCOTP_CTRL_RELOAD_SHADOWS);
+	return 0;
+}
+
+static int __init map_ocotp_addr(struct platform_device *pdev)
+{
+	return 0;
+}
+static void unmap_ocotp_addr(void)
+{
+}
+
+
+#endif /* (defined(CONFIG_SOC_IMX23) || defined(CONFIG_SOC_IMX28)) */
+#endif
-- 
1.7.9.5
