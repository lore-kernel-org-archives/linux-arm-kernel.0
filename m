From: zhouqiao@marvell.com (Qiao Zhou)
Date: Thu, 28 Jun 2012 11:13:32 +0800
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
References: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
Message-ID: <1340853214-5429-2-git-send-email-zhouqiao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM800 and 88PM805 are two discrete chips used for power management.
Hardware designer can use them together or only one of them according to
requirement.

due to hardware design, there are some registers used by pm805, but actually
defined in pm800 chip. so pm805 needs to access pm800 register in some
occasion. A workaround is used in driver to solve such issue and would be
removed when it's fixed in latter new chip version.

All I2C operations are accessed by 80x-i2c driver, and register access is via
regmap interface.

The benefit is that client drivers only need one kind of read/write API. I2C
and MFD driver can be shared in both 800 and 805.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 drivers/mfd/88pm80x-core.c  |  545 ++++++++++++++++++++++++++++++++++
 drivers/mfd/88pm80x-i2c.c   |  274 +++++++++++++++++
 drivers/mfd/Kconfig         |   12 +
 drivers/mfd/Makefile        |    2 +
 include/linux/mfd/88pm80x.h |  678 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1511 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mfd/88pm80x-core.c
 create mode 100644 drivers/mfd/88pm80x-i2c.c
 create mode 100644 include/linux/mfd/88pm80x.h

diff --git a/drivers/mfd/88pm80x-core.c b/drivers/mfd/88pm80x-core.c
new file mode 100644
index 0000000..b836c0c
--- /dev/null
+++ b/drivers/mfd/88pm80x-core.c
@@ -0,0 +1,545 @@
+/*
+ * Base driver for Marvell 88PM80X
+ *
+ * Copyright (C) 2012 Marvell International Ltd.
+ * Haojian Zhuang <haojian.zhuang@marvell.com>
+ * Joseph(Yossi) Hanin <yhanin@marvell.com>
+ * Qiao Zhou <zhouqiao@marvell.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/88pm80x.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+static struct resource rtc_resources[] = {
+	{
+	 .name = "88pm80x-rtc",
+	 .start = PM800_IRQ_RTC,
+	 .end = PM800_IRQ_RTC,
+	 .flags = IORESOURCE_IRQ,
+	 },
+};
+
+static struct mfd_cell rtc_devs[] = {
+	{
+	 .name = "88pm80x-rtc",
+	 .num_resources = ARRAY_SIZE(rtc_resources),
+	 .resources = &rtc_resources[0],
+	 .id = -1,
+	 },
+};
+
+static struct resource onkey_resources[] = {
+	{
+	 .name = "88pm80x-onkey",
+	 .start = PM800_IRQ_ONKEY,
+	 .end = PM800_IRQ_ONKEY,
+	 .flags = IORESOURCE_IRQ,
+	 },
+};
+
+static struct mfd_cell onkey_devs[] = {
+	{
+	 .name = "88pm80x-onkey",
+	 .num_resources = 1,
+	 .resources = &onkey_resources[0],
+	 .id = -1,
+	 },
+};
+
+static struct resource codec_resources[] = {
+	{
+	 /* Headset microphone insertion or removal */
+	 .name = "micin",
+	 .start = PM805_IRQ_MIC_DET,
+	 .end = PM805_IRQ_MIC_DET,
+	 .flags = IORESOURCE_IRQ,
+	 },
+	{
+	 /* Audio short HP1 */
+	 .name = "audio-short1",
+	 .start = PM805_IRQ_HP1_SHRT,
+	 .end = PM805_IRQ_HP1_SHRT,
+	 .flags = IORESOURCE_IRQ,
+	 },
+	{
+	 /* Audio short HP2 */
+	 .name = "audio-short2",
+	 .start = PM805_IRQ_HP2_SHRT,
+	 .end = PM805_IRQ_HP2_SHRT,
+	 .flags = IORESOURCE_IRQ,
+	 },
+};
+
+static struct mfd_cell codec_devs[] = {
+	{
+	 .name = "88pm80x-codec",
+	 .num_resources = ARRAY_SIZE(codec_resources),
+	 .resources = &codec_resources[0],
+	 .id = -1,
+	 },
+};
+
+static const struct regmap_irq pm800_irqs[] = {
+	/* INT0 */
+	[PM800_IRQ_ONKEY] = {
+		.mask = PM800_ONKEY_INT_ENA1,
+	},
+	[PM800_IRQ_EXTON] = {
+		.mask = PM800_EXTON_INT_ENA1,
+	},
+	[PM800_IRQ_CHG] = {
+		.mask = PM800_CHG_INT_ENA1,
+	},
+	[PM800_IRQ_BAT] = {
+		.mask = PM800_BAT_INT_ENA1,
+	},
+	[PM800_IRQ_RTC] = {
+		.mask = PM800_RTC_INT_ENA1,
+	},
+	[PM800_IRQ_CLASSD] = {
+		.mask = PM800_CLASSD_OC_INT_ENA1,
+	},
+	/* INT1 */
+	[PM800_IRQ_VBAT] = {
+		.reg_offset = 1,
+		.mask = PM800_VBAT_INT_ENA2,
+	},
+	[PM800_IRQ_VSYS] = {
+		.reg_offset = 1,
+		.mask = PM800_VSYS_INT_ENA2,
+	},
+	[PM800_IRQ_VCHG] = {
+		.reg_offset = 1,
+		.mask = PM800_VCHG_INT_ENA2,
+	},
+	[PM800_IRQ_TINT] = {
+		.reg_offset = 1,
+		.mask = PM800_TINT_INT_ENA2,
+	},
+	/* INT2 */
+	[PM800_IRQ_GPADC0] = {
+		.reg_offset = 2,
+		.mask = PM800_GPADC0_INT_ENA3,
+	},
+	[PM800_IRQ_GPADC1] = {
+		.reg_offset = 2,
+		.mask = PM800_GPADC1_INT_ENA3,
+	},
+	[PM800_IRQ_GPADC2] = {
+		.reg_offset = 2,
+		.mask = PM800_GPADC2_INT_ENA3,
+	},
+	[PM800_IRQ_GPADC3] = {
+		.reg_offset = 2,
+		.mask = PM800_GPADC3_INT_ENA3,
+	},
+	[PM800_IRQ_GPADC4] = {
+		.reg_offset = 2,
+		.mask = PM800_GPADC4_INT_ENA3,
+	},
+	/* INT3 */
+	[PM800_IRQ_GPIO0] = {
+		.reg_offset = 3,
+		.mask = PM800_GPIO0_INT_ENA4,
+	},
+	[PM800_IRQ_GPIO1] = {
+		.reg_offset = 3,
+		.mask = PM800_GPIO1_INT_ENA4,
+	},
+	[PM800_IRQ_GPIO2] = {
+		.reg_offset = 3,
+		.mask = PM800_GPIO2_INT_ENA4,
+	},
+	[PM800_IRQ_GPIO3] = {
+		.reg_offset = 3,
+		.mask = PM800_GPIO3_INT_ENA4,
+	},
+	[PM800_IRQ_GPIO4] = {
+		.reg_offset = 3,
+		.mask = PM800_GPIO4_INT_ENA4,
+	},
+};
+
+static struct regmap_irq pm805_irqs[] = {
+	/* INT0 */
+	[PM805_IRQ_LDO_OFF] = {
+		.mask = PM805_INT1_HP1_SHRT,
+	},
+	[PM805_IRQ_SRC_DPLL_LOCK] = {
+		.mask = PM805_INT1_HP2_SHRT,
+	},
+	[PM805_IRQ_CLIP_FAULT] = {
+		.mask = PM805_INT1_MIC_CONFLICT,
+	},
+	[PM805_IRQ_MIC_CONFLICT] = {
+		.mask = PM805_INT1_CLIP_FAULT,
+	},
+	[PM805_IRQ_HP2_SHRT] = {
+		.mask = PM805_INT1_LDO_OFF,
+	},
+	[PM805_IRQ_HP1_SHRT] = {
+		.mask = PM805_INT1_SRC_DPLL_LOCK,
+	},
+	/* INT1 */
+	[PM805_IRQ_FINE_PLL_FAULT] = {
+		.reg_offset = 1,
+		.mask = PM805_INT2_MIC_DET,
+	},
+	[PM805_IRQ_RAW_PLL_FAULT] = {
+		.reg_offset = 1,
+		.mask = PM805_INT2_SHRT_BTN_DET,
+	},
+	[PM805_IRQ_VOLP_BTN_DET] = {
+		.reg_offset = 1,
+		.mask = PM805_INT2_VOLM_BTN_DET,
+	},
+	[PM805_IRQ_VOLM_BTN_DET] = {
+		.reg_offset = 1,
+		.mask = PM805_INT2_VOLP_BTN_DET,
+	},
+	[PM805_IRQ_SHRT_BTN_DET] = {
+		.reg_offset = 1,
+		.mask = PM805_INT2_RAW_PLL_FAULT,
+	},
+	[PM805_IRQ_MIC_DET] = {
+		.reg_offset = 1,
+		.mask = PM805_INT2_FINE_PLL_FAULT,
+	},
+};
+
+static int __devinit device_gpadc_init(struct pm80x_chip *chip,
+				       struct pm80x_platform_data *pdata)
+{
+	struct pm80x_subchip *subchip = chip->subchip;
+	struct i2c_client *i2c = subchip->gpadc_page;
+	struct regmap *map = dev_get_regmap(&i2c->dev, NULL);
+	int data = 0, mask = 0, ret = 0;
+
+	if (!map) {
+		dev_warn(chip->dev,
+			 "Warning: gpadc regmap is not available!\n");
+		return -EINVAL;
+	}
+	/* initialize GPADC without activating it turn on GPADC
+	 * measurments
+	 */
+	ret = regmap_update_bits(map,
+				 PM800_GPADC_MISC_CONFIG2,
+				 PM800_GPADC_MISC_GPFSM_EN,
+				 PM800_GPADC_MISC_GPFSM_EN);
+	if (ret < 0)
+		goto out;
+	/*
+	 * This function configures the ADC as requires for
+	 * CP implementation.CP does not "own" the ADC configuration
+	 * registers and relies on AP.
+	 * Reason: enable automatic ADC measurements needed
+	 * for CP to get VBAT and RF temperature readings.
+	 */
+	ret = regmap_update_bits(map, PM800_GPADC_MEAS_EN1,
+				 PM800_MEAS_EN1_VBAT, PM800_MEAS_EN1_VBAT);
+	if (ret < 0)
+		goto out;
+	ret = regmap_update_bits(map, PM800_GPADC_MEAS_EN2,
+				 (PM800_MEAS_EN2_RFTMP | PM800_MEAS_GP0_EN),
+				 (PM800_MEAS_EN2_RFTMP | PM800_MEAS_GP0_EN));
+	if (ret < 0)
+		goto out;
+
+	/* the defult of PM800 is GPADC operates@100Ks/s rate
+	 * and Number of GPADC slots with active current bias prior
+	 * to GPADC sampling = 1 slot for all GPADCs set for
+	 * Temprature mesurmants
+	 */
+	mask = (PM800_GPADC_GP_BIAS_EN0 | PM800_GPADC_GP_BIAS_EN1 |
+		PM800_GPADC_GP_BIAS_EN2 | PM800_GPADC_GP_BIAS_EN3);
+
+	if (pdata && (pdata->batt_det == 0)) {
+		data = (PM800_GPADC_GP_BIAS_EN0 | PM800_GPADC_GP_BIAS_EN1 |
+			PM800_GPADC_GP_BIAS_EN2 | PM800_GPADC_GP_BIAS_EN3);
+	} else {
+		data = (PM800_GPADC_GP_BIAS_EN0 | PM800_GPADC_GP_BIAS_EN2 |
+			PM800_GPADC_GP_BIAS_EN3);
+	}
+	ret = regmap_update_bits(map, PM800_GP_BIAS_ENA1, mask, data);
+	if (ret < 0)
+		goto out;
+
+	dev_info(chip->dev, "pm80x device_gpadc_init: Done\n");
+	return 0;
+
+out:
+	dev_info(chip->dev, "pm80x device_gpadc_init: Failed!\n");
+	return ret;
+}
+
+static int __devinit device_irq_init_80x(struct pm80x_chip *chip)
+{
+	struct i2c_client *i2c = chip->client;
+	struct regmap *map = dev_get_regmap(&i2c->dev, NULL);
+	unsigned long flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
+	int data, mask, ret = -EINVAL;
+
+	if (!map || !chip->irq) {
+		dev_err(chip->dev, "incorrect parameters\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * irq_mode defines the way of clearing interrupt. currently only
+	 * suport write 1 to clear status, which is aligned with regmap
+	 * implementation.
+	 */
+	if (chip->id == CHIP_PM800) {
+		flags |= IRQF_SHARED;
+		mask =
+		    PM800_WAKEUP2_INV_INT | PM800_WAKEUP2_INT_CLEAR |
+		    PM800_WAKEUP2_INT_MASK;
+
+		data = PM800_WAKEUP2_INT_CLEAR;
+		ret = regmap_update_bits(map, PM800_WAKEUP2, mask, data);
+	} else if (chip->id == CHIP_PM805) {
+		mask =
+		    PM805_STATUS0_INT_CLEAR | PM805_STATUS0_INV_INT |
+		    PM800_STATUS0_INT_MASK;
+
+		data = PM805_STATUS0_INT_CLEAR;
+		ret = regmap_update_bits(map, PM805_INT_STATUS0, mask, data);
+		/* PM805_INT_STATUS is under 32K clock domain, so need to
+		 * add proper delay before the next I2C register access.
+		 */
+		msleep(1);
+	}
+
+	if (ret < 0)
+		goto out;
+
+	ret =
+	    regmap_add_irq_chip(chip->regmap, chip->irq, flags, chip->irq_base,
+				chip->regmap_irq_chip, &chip->irq_data);
+
+out:
+	return ret;
+}
+
+static void device_irq_exit_80x(struct pm80x_chip *chip)
+{
+	regmap_del_irq_chip(chip->irq, chip->irq_data);
+}
+
+static struct regmap_irq_chip pm805_irq_chip = {
+	.name = "88pm805",
+	.irqs = pm805_irqs,
+	.num_irqs = ARRAY_SIZE(pm805_irqs),
+
+	.num_regs = 2,
+	.status_base = PM805_INT_STATUS1,
+	.mask_base = PM805_INT_MASK1,
+	.ack_base = PM805_INT_STATUS1,
+};
+
+static struct regmap_irq_chip pm800_irq_chip = {
+	.name = "88pm800",
+	.irqs = pm800_irqs,
+	.num_irqs = ARRAY_SIZE(pm800_irqs),
+
+	.num_regs = 4,
+	.status_base = PM800_INT_STATUS1,
+	.mask_base = PM800_INT_ENA_1,
+	.ack_base = PM800_INT_STATUS1,
+};
+
+static int __devinit device_805_init(struct pm80x_chip *chip,
+				     struct i2c_client *i2c,
+				     struct pm80x_platform_data *pdata)
+{
+	int ret = 0;
+	struct regmap *map = dev_get_regmap(&i2c->dev, NULL);
+
+	if (!map) {
+		dev_err(chip->dev, "regmap is invalid\n");
+		return -EINVAL;
+	}
+
+	dev_info(chip->dev, "pm80x:%s slave addr[0x%x]\n", __func__, i2c->addr);
+
+	regmap_read(map, PM805_CHIP_ID, &ret);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read CHIP ID: %d\n", ret);
+		goto out_irq_init;
+	}
+	chip->version = ret;
+
+	chip->regmap_irq_chip = &pm805_irq_chip;
+
+	ret = device_irq_init_80x(chip);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to init pm805 irq!\n");
+		goto out_irq_init;
+	}
+
+	ret = mfd_add_devices(chip->dev, 0, &codec_devs[0],
+			      ARRAY_SIZE(codec_devs), &codec_resources[0], 0);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to add codec subdev\n");
+		goto out_codec;
+	} else
+		dev_info(chip->dev, "[%s]:Added mfd codec_devs\n", __func__);
+
+	if (pdata->pm80x_plat_config)
+		pdata->pm80x_plat_config(chip, pdata);
+
+	return 0;
+
+out_codec:
+	device_irq_exit_80x(chip);
+out_irq_init:
+	return ret;
+}
+
+static int __devinit device_800_init(struct pm80x_chip *chip,
+				     struct i2c_client *i2c,
+				     struct pm80x_platform_data *pdata)
+{
+	struct regmap *map = dev_get_regmap(&i2c->dev, NULL);
+	int ret, data, pmic_id;
+
+	if (!map) {
+		dev_err(chip->dev, "regmap is invalid\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_read(map, PM800_CHIP_ID, &data);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read CHIP ID: %d\n", ret);
+		goto out;
+	}
+
+	pmic_id = data & PM80X_VERSION_MASK;
+
+	if ((pmic_id >= PM800_CHIP_A0) && (pmic_id <= PM800_CHIP_END)) {
+		chip->version = data;
+		dev_info(chip->dev,
+			 "88PM80x:Marvell 88PM800 (ID:0x%x) detected\n", ret);
+	} else {
+		dev_err(chip->dev,
+			"Failed to detect Marvell 88PM800:ChipID[0x%x]\n", ret);
+		goto out;
+	}
+
+	/*
+	 * alarm wake up bit will be clear in device_irq_init(),
+	 * read before that
+	 */
+	ret = regmap_read(map, PM800_RTC_CONTROL, &data);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read RTC register: %d\n", ret);
+		goto out;
+	}
+	if (data & PM800_ALARM_WAKEUP) {
+		if (pdata && pdata->rtc)
+			pdata->rtc->rtc_wakeup = 1;
+	}
+
+	ret = device_gpadc_init(chip, pdata);
+	if (ret < 0) {
+		dev_err(chip->dev, "[%s]Failed to init gpadc\n", __func__);
+		goto out;
+	}
+
+	chip->regmap_irq_chip = &pm800_irq_chip;
+
+	ret = device_irq_init_80x(chip);
+	if (ret < 0) {
+		dev_err(chip->dev, "[%s]Failed to init pm800 irq\n", __func__);
+		goto out;
+	}
+
+	ret = mfd_add_devices(chip->dev, 0, &onkey_devs[0],
+			      ARRAY_SIZE(onkey_devs), &onkey_resources[0],
+			      chip->irq_base);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to add onkey subdev\n");
+		goto out_dev;
+	} else
+		dev_info(chip->dev, "[%s]:Added mfd onkey_devs\n", __func__);
+
+	if (pdata && pdata->rtc) {
+		rtc_devs[0].platform_data = pdata->rtc;
+		rtc_devs[0].pdata_size = sizeof(struct pm80x_rtc_pdata);
+		ret = mfd_add_devices(chip->dev, 0, &rtc_devs[0],
+				      ARRAY_SIZE(rtc_devs), NULL,
+				      chip->irq_base);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to add rtc subdev\n");
+			goto out_dev;
+		} else
+			dev_info(chip->dev,
+				 "[%s]:Added mfd rtc_devs\n", __func__);
+	}
+
+	if (pdata->pm80x_plat_config)
+		pdata->pm80x_plat_config(chip, pdata);
+
+	return 0;
+out_dev:
+	mfd_remove_devices(chip->dev);
+	device_irq_exit_80x(chip);
+out:
+	return ret;
+}
+
+int __devinit pm80x_device_init(struct pm80x_chip *chip,
+				struct pm80x_platform_data *pdata)
+{
+	int ret = 0;
+
+	switch (chip->id) {
+	case CHIP_PM800:
+		ret = device_800_init(chip, chip->client, pdata);
+		break;
+	case CHIP_PM805:
+		ret = device_805_init(chip, chip->client, pdata);
+		break;
+	default:
+		dev_err(chip->dev, "%s incorrect chip id!\n", __func__);
+		return -EINVAL;
+	}
+
+	if (ret)
+		dev_err(chip->dev, "%s id 0x%x failed!\n", __func__, chip->id);
+
+	return ret;
+}
+
+void __devexit pm80x_device_exit(struct pm80x_chip *chip)
+{
+	device_irq_exit_80x(chip);
+	mfd_remove_devices(chip->dev);
+}
+
+MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM80x");
+MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/88pm80x-i2c.c b/drivers/mfd/88pm80x-i2c.c
new file mode 100644
index 0000000..71ebcd5
--- /dev/null
+++ b/drivers/mfd/88pm80x-i2c.c
@@ -0,0 +1,274 @@
+/*
+ * I2C driver for Marvell 88PM80x
+ *
+ * Copyright (C) 2012 Marvell International Ltd.
+ * Haojian Zhuang <haojian.zhuang@marvell.com>
+ * Joseph(Yossi) Hanin <yhanin@marvell.com>
+ * Qiao Zhou <zhouqiao@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/mfd/88pm80x.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/uaccess.h>
+#include <linux/err.h>
+
+/*
+ * workaround: some registers needed by pm805 are defined in pm800, so
+ * need to use this global variable to maintain the relation between
+ * pm800 and pm805. would remove it after HW chip fixes the issue.
+ */
+static struct pm80x_chip *g_pm80x_chip;
+
+static struct regmap_config pm80x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct i2c_device_id pm80x_id_table[] = {
+	{"88PM800", CHIP_PM800},
+	{"88PM805", CHIP_PM805},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
+
+static int pm80x_pages_init(struct pm80x_chip *chip, struct i2c_client *client)
+{
+	struct pm80x_subchip *subchip;
+
+	subchip = chip->subchip;
+	/* PM800 block power: i2c addr 0x31 */
+	if (subchip->power_page_addr) {
+		subchip->power_page =
+		    i2c_new_dummy(client->adapter, subchip->power_page_addr);
+		subchip->regmap_power =
+		    devm_regmap_init_i2c(subchip->power_page,
+					 &pm80x_regmap_config);
+		i2c_set_clientdata(subchip->power_page, chip);
+	} else
+		dev_info(chip->dev,
+			 "PM800 block power 0x31: No power_page_addr\n");
+
+	/* PM800 block GPADC: i2c addr 0x32 */
+	if (subchip->gpadc_page_addr) {
+		subchip->gpadc_page = i2c_new_dummy(client->adapter,
+						    subchip->gpadc_page_addr);
+		subchip->regmap_gpadc =
+		    devm_regmap_init_i2c(subchip->gpadc_page,
+					 &pm80x_regmap_config);
+		i2c_set_clientdata(subchip->gpadc_page, chip);
+	} else
+		dev_info(chip->dev,
+			 "PM800 block GPADC 0x32: No gpadc_page_addr\n");
+
+	return 0;
+}
+
+static void pm80x_pages_exit(struct pm80x_chip *chip)
+{
+	struct pm80x_subchip *subchip;
+
+	/*
+	 * workaround: clear the dependency between pm800 and pm805.
+	 * would remove it after HW chip fixes the issue.
+	 */
+	if (g_pm80x_chip->companion)
+		g_pm80x_chip->companion = NULL;
+	else
+		g_pm80x_chip = NULL;
+
+	regmap_exit(chip->regmap);
+	i2c_unregister_device(chip->client);
+
+	if (chip->id != CHIP_PM800 || !chip->subchip)
+		return;
+
+	subchip = chip->subchip;
+	if (subchip->power_page) {
+		regmap_exit(subchip->regmap_power);
+		i2c_unregister_device(subchip->power_page);
+	}
+	if (subchip->gpadc_page) {
+		regmap_exit(subchip->regmap_gpadc);
+		i2c_unregister_device(subchip->gpadc_page);
+	}
+}
+
+static int __devinit pm80x_probe(struct i2c_client *client,
+				 const struct i2c_device_id *id)
+{
+	struct pm80x_platform_data *pdata = client->dev.platform_data;
+	struct pm80x_chip *chip;
+	struct pm80x_subchip *subchip;
+	struct regmap *map;
+	int ret = 0;
+
+	if (!pdata) {
+		dev_err(&client->dev, "No platform data in %s!\n", __func__);
+		return -EINVAL;
+	}
+
+	chip =
+	    devm_kzalloc(&client->dev, sizeof(struct pm80x_chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	map = devm_regmap_init_i2c(client, &pm80x_regmap_config);
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		dev_err(&client->dev, "Failed to allocate register map: %d\n",
+			ret);
+		goto err_regmap_init;
+	}
+
+	chip->id = id->driver_data;
+	if (chip->id < CHIP_PM800 || chip->id > CHIP_PM805) {
+		ret = -EINVAL;
+		goto err_subchip_alloc;
+	}
+
+	chip->client = client;
+	chip->regmap = map;
+
+	chip->irq = client->irq;
+	chip->irq_base = pdata->irq_base;
+
+	i2c_set_clientdata(client, chip);
+	chip->dev = &client->dev;
+	dev_set_drvdata(chip->dev, chip);
+
+	/*
+	 * workaround: set g_pm80x_chip to the first probed chip. if the
+	 * second chip is probed, just point to the companion to each
+	 * other so that pm805 can access those specific register. would
+	 * remove it after HW chip fixes the issue.
+	 */
+	if (!g_pm80x_chip)
+		g_pm80x_chip = chip;
+	else {
+		chip->companion = g_pm80x_chip->client;
+		g_pm80x_chip->companion = chip->client;
+	}
+
+	chip->regmap = devm_regmap_init_i2c(client, &pm80x_regmap_config);
+	i2c_set_clientdata(chip->client, chip);
+
+	device_init_wakeup(&client->dev, 1);
+
+	/* init subchip for PM800 */
+	if (chip->id == CHIP_PM800) {
+		subchip =
+		    devm_kzalloc(&client->dev, sizeof(struct pm80x_subchip),
+				 GFP_KERNEL);
+		if (!subchip) {
+			ret = -ENOMEM;
+			goto err_subchip_alloc;
+		}
+
+		subchip->power_page_addr = pdata->power_page_addr;
+		subchip->gpadc_page_addr = pdata->gpadc_page_addr;
+		chip->subchip = subchip;
+
+		ret = pm80x_pages_init(chip, client);
+		if (ret) {
+			dev_err(&client->dev, "pm80x_pages_init failed!\n");
+			devm_kfree(&client->dev, subchip);
+			goto err_subchip_alloc;
+		}
+	}
+
+	ret = pm80x_device_init(chip, pdata);
+	if (ret) {
+		dev_err(&client->dev,
+			"Chip[0x%x]:pm80x_device_init failed!\n", chip->id);
+		goto err_dev_init;
+	}
+
+	return 0;
+
+err_dev_init:
+	pm80x_device_exit(chip);
+	pm80x_pages_exit(chip);
+err_subchip_alloc:
+	regmap_exit(map);
+err_regmap_init:
+	devm_kfree(&client->dev, chip);
+	return ret;
+}
+
+static int __devexit pm80x_remove(struct i2c_client *client)
+{
+	struct pm80x_chip *chip = i2c_get_clientdata(client);
+
+	pm80x_device_exit(chip);
+	pm80x_pages_exit(chip);
+	if (chip->id == CHIP_PM800)
+		devm_kfree(&client->dev, chip->subchip);
+	devm_kfree(&client->dev, chip);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int pm80x_suspend(struct device *dev)
+{
+	struct i2c_client *client = container_of(dev, struct i2c_client, dev);
+	struct pm80x_chip *chip = i2c_get_clientdata(client);
+
+	if (chip && chip->wu_flag)
+		if (device_may_wakeup(chip->dev))
+			enable_irq_wake(chip->irq);
+
+	return 0;
+}
+
+static int pm80x_resume(struct device *dev)
+{
+	struct i2c_client *client = container_of(dev, struct i2c_client, dev);
+	struct pm80x_chip *chip = i2c_get_clientdata(client);
+
+	if (chip && chip->wu_flag)
+		if (device_may_wakeup(chip->dev))
+			disable_irq_wake(chip->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(pm80x_pm_ops, pm80x_suspend, pm80x_resume);
+
+static struct i2c_driver pm80x_driver = {
+	.driver = {
+		.name = "88PM80x",
+		.owner = THIS_MODULE,
+		.pm = &pm80x_pm_ops,
+		},
+	.probe = pm80x_probe,
+	.remove = __devexit_p(pm80x_remove),
+	.id_table = pm80x_id_table,
+};
+
+static int __init pm80x_i2c_init(void)
+{
+	return i2c_add_driver(&pm80x_driver);
+}
+
+subsys_initcall(pm80x_i2c_init);
+
+static void __exit pm80x_i2c_exit(void)
+{
+	i2c_del_driver(&pm80x_driver);
+}
+
+module_exit(pm80x_i2c_exit);
+
+MODULE_DESCRIPTION("I2C Driver for Marvell 88PM80x");
+MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index e129c82..96dd2d7 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -20,6 +20,18 @@ config MFD_88PM860X
 	  select individual components like voltage regulators, RTC and
 	  battery-charger under the corresponding menus.
 
+config MFD_88PM80X
+	bool "Support Marvell 88PM800/88PM805"
+	depends on I2C=y && GENERIC_HARDIRQS
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	select MFD_CORE
+	help
+	  This supports for Marvell 88PM800/88PM805 Power Management IC.
+	  This includes the I2C driver and the core APIs _only_, you have to
+	  select individual components like voltage regulators, RTC and
+	  battery-charger under the corresponding menus.
+
 config MFD_SM501
 	tristate "Support for Silicon Motion SM501"
 	 ---help---
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 75f6ed6..bf5de13 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -3,7 +3,9 @@
 #
 
 88pm860x-objs			:= 88pm860x-core.o 88pm860x-i2c.o
+88pm80x-objs			:= 88pm80x-core.o 88pm80x-i2c.o
 obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
+obj-$(CONFIG_MFD_88PM80X)	+= 88pm80x.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
 obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
 
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
new file mode 100644
index 0000000..9e2e11d
--- /dev/null
+++ b/include/linux/mfd/88pm80x.h
@@ -0,0 +1,678 @@
+/*
+ * Marvell 88PM80x Interface
+ *
+ * Copyright (C) 2012 Marvell International Ltd.
+ * Qiao Zhou <zhouqiao@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_MFD_88PM80X_H
+#define __LINUX_MFD_88PM80X_H
+
+#define PM80X_VERSION_MASK		(0xFF)	/* 80X chip ID mask */
+enum {
+	CHIP_INVALID = 0,
+	CHIP_PM800,
+	CHIP_PM805,
+	CHIP_MAX,
+};
+
+enum {
+	/* Procida */
+	PM800_CHIP_A0  = 0x60,
+	PM800_CHIP_A1  = 0x61,
+	PM800_CHIP_B0  = 0x62,
+	PM800_CHIP_C0  = 0x63,
+	PM800_CHIP_END = PM800_CHIP_C0,
+
+	/* Make sure to update this to the last stepping */
+	PM8XXX_CHIP_END = PM800_CHIP_END
+};
+
+enum {
+	PM800_ID_INVALID,
+	PM800_ID_VIBRATOR,
+	PM800_ID_SOUND,
+	PM800_ID_MAX,
+};
+
+enum {
+	PM800_ID_BUCK1 = 0,
+	PM800_ID_BUCK2,
+	PM800_ID_BUCK3,
+	PM800_ID_BUCK4,
+	PM800_ID_BUCK5,
+
+	PM800_ID_LDO1,
+	PM800_ID_LDO2,
+	PM800_ID_LDO3,
+	PM800_ID_LDO4,
+	PM800_ID_LDO5,
+	PM800_ID_LDO6,
+	PM800_ID_LDO7,
+	PM800_ID_LDO8,
+	PM800_ID_LDO9,
+	PM800_ID_LDO10,
+	PM800_ID_LDO11,
+	PM800_ID_LDO12,
+	PM800_ID_LDO13,
+	PM800_ID_LDO14,
+	PM800_ID_LDO15,
+	PM800_ID_LDO16,
+	PM800_ID_LDO17,
+	PM800_ID_LDO18,
+	PM800_ID_LDO19,
+
+	PM800_ID_RG_MAX,
+};
+#define PM800_MAX_REGULATOR	PM800_ID_RG_MAX	/* 5 Bucks, 19 LDOs */
+#define PM800_NUM_BUCK (5)	/*5 Bucks */
+#define PM800_NUM_LDO (19)	/*19 Bucks */
+
+/* 88PM805 Registers */
+#define PM805_CHIP_ID			(0x00)
+
+/*Audio*/
+
+/*88PM800 registers*/
+enum {
+	PM80X_INVALID_PAGE = 0,
+	PM80X_BASE_PAGE,
+	PM80X_POWER_PAGE,
+	PM80X_GPADC_PAGE,
+	PM80X_TEST_PAGE,
+};
+/*********************************/
+/*page 0 basic: slave adder 0x60*/
+/*********************************/
+/* Interrupt Registers */
+#define PM800_CHIP_ID			(0x00)
+
+#define PM800_STATUS_1			(0x01)
+#define PM800_ONKEY_STS1		(1 << 0)
+#define PM800_EXTON_STS1		(1 << 1)
+#define PM800_CHG_STS1			(1 << 2)
+#define PM800_BAT_STS1			(1 << 3)
+#define PM800_VBUS_STS1			(1 << 4)
+#define PM800_LDO_PGOOD_STS1	(1 << 5)
+#define PM800_BUCK_PGOOD_STS1	(1 << 6)
+
+#define PM800_STATUS_2			(0x02)
+#define PM800_RTC_ALARM_STS2	(1 << 0)
+
+#define PM800_INT_STATUS1		(0x05)
+#define PM800_ONKEY_INT_STS1		(1 << 0)
+#define PM800_EXTON_INT_STS1		(1 << 1)
+#define PM800_CHG_INT_STS1			(1 << 2)
+#define PM800_BAT_INT_STS1			(1 << 3)
+#define PM800_RTC_INT_STS1			(1 << 4)
+#define PM800_CLASSD_OC_INT_STS1	(1 << 5)
+
+#define PM800_INT_STATUS2		(0x06)
+#define PM800_VBAT_INT_STS2		(1 << 0)
+#define PM800_VSYS_INT_STS2		(1 << 1)
+#define PM800_VCHG_INT_STS2		(1 << 2)
+#define PM800_TINT_INT_STS2		(1 << 3)
+#define PM800_GPADC0_INT_STS2	(1 << 4)
+#define PM800_TBAT_INT_STS2		(1 << 5)
+#define PM800_GPADC2_INT_STS2	(1 << 6)
+#define PM800_GPADC3_INT_STS2	(1 << 7)
+
+#define PM800_INT_STATUS3		(0x07)
+
+#define PM800_INT_STATUS4		(0x08)
+#define PM800_GPIO0_INT_STS4		(1 << 0)
+#define PM800_GPIO1_INT_STS4		(1 << 1)
+#define PM800_GPIO2_INT_STS4		(1 << 2)
+#define PM800_GPIO3_INT_STS4		(1 << 3)
+#define PM800_GPIO4_INT_STS4		(1 << 4)
+
+#define PM800_INT_ENA_1		(0x09)
+#define PM800_ONKEY_INT_ENA1		(1 << 0)
+#define PM800_EXTON_INT_ENA1		(1 << 1)
+#define PM800_CHG_INT_ENA1			(1 << 2)
+#define PM800_BAT_INT_ENA1			(1 << 3)
+#define PM800_RTC_INT_ENA1			(1 << 4)
+#define PM800_CLASSD_OC_INT_ENA1	(1 << 5)
+
+#define PM800_INT_ENA_2		(0x0A)
+#define PM800_VBAT_INT_ENA2		(1 << 0)
+#define PM800_VSYS_INT_ENA2		(1 << 1)
+#define PM800_VCHG_INT_ENA2		(1 << 2)
+#define PM800_TINT_INT_ENA2		(1 << 3)
+
+#define PM800_INT_ENA_3		(0x0B)
+#define PM800_GPADC0_INT_ENA3		(1 << 0)
+#define PM800_GPADC1_INT_ENA3		(1 << 1)
+#define PM800_GPADC2_INT_ENA3		(1 << 2)
+#define PM800_GPADC3_INT_ENA3		(1 << 3)
+#define PM800_GPADC4_INT_ENA3		(1 << 4)
+
+#define PM800_INT_ENA_4		(0x0C)
+#define PM800_GPIO0_INT_ENA4		(1 << 0)
+#define PM800_GPIO1_INT_ENA4		(1 << 1)
+#define PM800_GPIO2_INT_ENA4		(1 << 2)
+#define PM800_GPIO3_INT_ENA4		(1 << 3)
+#define PM800_GPIO4_INT_ENA4		(1 << 4)
+
+/*number of INT_ENA & INT_STATUS regs*/
+#define PM800_INT_REG_NUM			(4)
+
+/* Wakeup Registers */
+#define PM800_WAKEUP1		(0x0D)
+
+#define PM800_WAKEUP2		(0x0E)
+#define PM800_WAKEUP2_INV_INT		(1 << 0)
+#define PM800_WAKEUP2_INT_CLEAR		(1 << 1)
+#define PM800_WAKEUP2_INT_MASK		(1 << 2)
+
+#define PM800_POWER_UP_LOG	(0x10)
+
+/*test page*/
+#define PM800_TEST_PAGE_ENTRY	(0x1F)
+
+/*Referance and low power registers*/
+#define PM800_LOW_POWER1		(0x20)
+#define PM800_LOW_POWER2		(0x21)
+#define PM800_LOW_POWER_CONFIG3	(0x22)
+#define PM800_LOW_POWER_CONFIG4	(0x23)
+
+/*GPIO register*/
+#define PM800_GPIO_0_1_CNTRL		(0x30)
+#define PM800_GPIO0_VAL				(1 << 0)
+#define PM800_GPIO0_GPIO_MODE(x)	(x << 1)
+#define PM800_GPIO1_VAL				(1 << 4)
+#define PM800_GPIO1_GPIO_MODE(x)	(x << 5)
+
+#define PM800_GPIO_2_3_CNTRL		(0x31)
+#define PM800_GPIO2_VAL				(1 << 0)
+#define PM800_GPIO2_GPIO_MODE(x)	(x << 1)
+#define PM800_GPIO3_VAL				(1 << 4)
+#define PM800_GPIO3_GPIO_MODE(x)	(x << 5)
+#define PM800_GPIO3_MODE_MASK		0x1F
+#define PM800_GPIO3_HEADSET_MODE	PM800_GPIO3_GPIO_MODE(6)
+
+#define PM800_GPIO_4_CNTRL			(0x32)
+#define PM800_GPIO4_VAL				(1 << 0)
+#define PM800_GPIO4_GPIO_MODE(x)	(x << 1)
+
+#define PM800_HEADSET_CNTRL		(0x38)
+#define PM800_HEADSET_DET_EN		(1 << 7)
+#define PM800_HSDET_SLP			(1 << 1)
+/*PWM register*/
+#define PM800_PWM1		(0x40)
+#define PM800_PWM2		(0x41)
+#define PM800_PWM3		(0x42)
+#define PM800_PWM4		(0x43)
+
+/*RTC Registers*/
+#define PM800_RTC_CONTROL		(0xD0)
+#define PM800_RTC_COUNTER1		(0xD1)
+#define PM800_RTC_COUNTER2		(0xD2)
+#define PM800_RTC_COUNTER3		(0xD3)
+#define PM800_RTC_COUNTER4		(0xD4)
+#define PM800_RTC_EXPIRE1_1		(0xD5)
+#define PM800_RTC_EXPIRE1_2		(0xD6)
+#define PM800_RTC_EXPIRE1_3		(0xD7)
+#define PM800_RTC_EXPIRE1_4		(0xD8)
+#define PM800_RTC_TRIM1			(0xD9)
+#define PM800_RTC_TRIM2			(0xDA)
+#define PM800_RTC_TRIM3			(0xDB)
+#define PM800_RTC_TRIM4			(0xDC)
+#define PM800_RTC_EXPIRE2_1		(0xDD)
+#define PM800_RTC_EXPIRE2_2		(0xDE)
+#define PM800_RTC_EXPIRE2_3		(0xDF)
+#define PM800_RTC_EXPIRE2_4		(0xE0)
+#define PM800_RTC_MISC1			(0xE1)
+#define PM800_RTC_MISC2			(0xE2)
+#define PM800_RTC_MISC3			(0xE3)
+#define PM800_RTC_MISC4			(0xE4)
+
+/* bit definitions of RTC Register 1 (0xD0) */
+#define PM800_ALARM1_EN			(1 << 0)
+#define PM800_ALARM_WAKEUP		(1 << 4)
+#define PM800_ALARM			(1 << 5)
+#define PM800_RTC1_USE_XO		(1 << 7)
+
+/*for save RTC offset*/
+#define PM800_USER_DATA1		(0xE8)
+#define PM800_USER_DATA2		(0xE9)
+#define PM800_USER_DATA3		(0xEA)
+#define PM800_USER_DATA4		(0xEB)
+#define PM800_USER_DATA5		(0xEC)
+#define PM800_USER_DATA6		(0xED)
+#define PM800_USER_DATA7		(0xEE)
+#define PM800_USER_DATA8		(0xEF)
+
+#define PM800_POWER_DOWN_LOG1	(0xE5)
+#define PM800_POWER_DOWN_LOG2	(0xE6)
+
+#define PM800_RTC_MISC5			(0xE7)
+
+/*********************************/
+/*page 1 Power: slave adder 0x01*/
+/********************************/
+#define PM800_BUCK_POWER_GOOD_STS	(0x01)
+#define PM800_LDO_POWER_GOOD_STS1	(0x02)
+#define PM800_LDO_POWER_GOOD_STS2	(0x03)
+#define PM800_LDO_POWER_GOOD_STS3	(0x04)
+#define PM800_LDO_LAST_GROUP		(0x05)	/*reg#? not sure */
+
+/* Regulator Control Registers: BUCK1,BUCK5,LDO1 have DVC */
+/* LDO1 with DVC[0..3] */
+#define PM800_LDO1_VOUT		(0x08) /* VOUT1 */
+#define PM800_LDO1_VOUT_2	(0x09)
+#define PM800_LDO1_VOUT_3	(0x0A)
+#define PM800_LDO2_VOUT		(0x0B)
+#define PM800_LDO3_VOUT		(0x0C)
+#define PM800_LDO4_VOUT		(0x0D)
+#define PM800_LDO5_VOUT		(0x0E)
+#define PM800_LDO6_VOUT		(0x0F)
+#define PM800_LDO7_VOUT		(0x10)
+#define PM800_LDO8_VOUT		(0x11)
+#define PM800_LDO9_VOUT		(0x12)
+#define PM800_LDO10_VOUT	(0x13)
+#define PM800_LDO11_VOUT	(0x14)
+#define PM800_LDO12_VOUT	(0x15)
+#define PM800_LDO13_VOUT	(0x16)
+#define PM800_LDO14_VOUT	(0x17)
+#define PM800_LDO15_VOUT	(0x18)
+#define PM800_LDO16_VOUT	(0x19)
+#define PM800_LDO17_VOUT	(0x1A)
+#define PM800_LDO18_VOUT	(0x1B)
+#define PM800_LDO19_VOUT	(0x1C)
+
+/*buck registers*/
+#define PM800_SLEEP_BUCK1	(0x30)
+#define PM800_SLEEP_BUCK2	(0x31)
+#define PM800_SLEEP_BUCK3	(0x32)
+#define PM800_SLEEP_BUCK4	(0x33)
+#define PM800_SLEEP_BUCK5	(0x34)
+/* BUCK1 with DVC[0..3] */
+#define PM800_BUCK1			(0x3C)
+#define PM800_BUCK1_1		(0x3D)
+#define PM800_BUCK1_2		(0x3E)
+#define PM800_BUCK1_3		(0x3F)
+#define PM800_BUCK2			(0x40)
+#define PM800_BUCK3			(0x41)
+#define PM800_BUCK3_DOUBLE	(1 << 6)
+#define PM800_BUCK4			(0x42)
+/* BUCK5 with DVC[0..3] */
+#define PM800_BUCK5			(0x43)
+#define PM800_BUCK5_1		(0x44)
+#define PM800_BUCK5_2		(0x45)
+#define PM800_BUCK5_3		(0x46)
+
+#define PM800_BUCK_ENA		(0x50)
+#define PM800_LDO_ENA1_1	(0x51)
+#define PM800_LDO_ENA1_2	(0x52)
+#define PM800_LDO_ENA1_3	(0x53)
+
+#define PM800_LDO_ENA2_1	(0x56)
+#define PM800_LDO_ENA2_2	(0x57)
+#define PM800_LDO_ENA2_3	(0x58)
+
+/* BUCK Sleep Mode Register 1: BUCK[1..4] */
+#define PM800_BUCK_SLP1		(0x5A)
+#define PM800_BUCK1_SLP1_SHIFT	0
+#define PM800_BUCK1_SLP1_MASK	(0x3 << PM800_BUCK1_SLP1_SHIFT)
+#define PM800_BUCK2_SLP1_SHIFT	2
+#define PM800_BUCK2_SLP1_MASK	(0x3 << PM800_BUCK2_SLP1_SHIFT)
+#define PM800_BUCK3_SLP1_SHIFT	4
+#define PM800_BUCK3_SLP1_MASK	(0x3 << PM800_BUCK3_SLP1_SHIFT)
+#define PM800_BUCK4_SLP1_SHIFT	6
+#define PM800_BUCK4_SLP1_MASK	(0x3 << PM800_BUCK4_SLP1_SHIFT)
+/* BUCK Sleep Mode Register 2: BUCK5 */
+#define PM800_BUCK_SLP2		(0x5B)
+#define PM800_BUCK5_SLP2_SHIFT	0
+#define PM800_BUCK5_SLP2_MASK	(0x3 << PM800_BUCK5_SLP2_SHIFT)
+
+/* LDO Sleep Mode Register 1: LDO[1..4] */
+#define PM800_LDO_SLP1		(0x5C)
+#define PM800_LDO1_SLP1_SHIFT	0
+#define PM800_LDO1_SLP1_MASK	(0x3 << PM800_LDO1_SLP1_SHIFT)
+#define PM800_LDO2_SLP1_SHIFT	2
+#define PM800_LDO2_SLP1_MASK	(0x3 << PM800_LDO2_SLP1_SHIFT)
+#define PM800_LDO3_SLP1_SHIFT	4
+#define PM800_LDO3_SLP1_MASK	(0x3 << PM800_LDO3_SLP1_SHIFT)
+#define PM800_LDO4_SLP1_SHIFT	6
+#define PM800_LDO4_SLP1_MASK	(0x3 << PM800_LDO4_SLP1_SHIFT)
+
+/* LDO Sleep Mode Register 2: LDO[5..8] */
+#define PM800_LDO_SLP2		(0x5D)
+#define PM800_LDO5_SLP2_SHIFT	0
+#define PM800_LDO5_SLP2_MASK	(0x3 << PM800_LDO5_SLP2_SHIFT)
+#define PM800_LDO6_SLP2_SHIFT	2
+#define PM800_LDO6_SLP2_MASK	(0x3 << PM800_LDO6_SLP2_SHIFT)
+#define PM800_LDO7_SLP2_SHIFT	4
+#define PM800_LDO7_SLP2_MASK	(0x3 << PM800_LDO7_SLP2_SHIFT)
+#define PM800_LDO8_SLP2_SHIFT	6
+#define PM800_LDO8_SLP2_MASK	(0x3 << PM800_LDO8_SLP2_SHIFT)
+
+/* LDO Sleep Mode Register 3: LDO[9..12] */
+#define PM800_LDO_SLP3		(0x5E)
+#define PM800_LDO9_SLP3_SHIFT	0
+#define PM800_LDO9_SLP3_MASK	(0x3 << PM800_LDO9_SLP3_SHIFT)
+#define PM800_LDO10_SLP3_SHIFT	2
+#define PM800_LDO10_SLP3_MASK	(0x3 << PM800_LDO10_SLP3_SHIFT)
+#define PM800_LDO11_SLP3_SHIFT	4
+#define PM800_LDO11_SLP3_MASK	(0x3 << PM800_LDO11_SLP3_SHIFT)
+#define PM800_LDO12_SLP3_SHIFT	6
+#define PM800_LDO12_SLP3_MASK	(0x3 << PM800_LDO12_SLP3_SHIFT)
+
+/* LDO Sleep Mode Register 4: LDO[13..16] */
+#define PM800_LDO_SLP4		(0x5F)
+#define PM800_LDO13_SLP4_SHIFT	0
+#define PM800_LDO13_SLP4_MASK	(0x3 << PM800_LDO13_SLP4_SHIFT)
+#define PM800_LDO14_SLP4_SHIFT	2
+#define PM800_LDO14_SLP4_MASK	(0x3 << PM800_LDO14_SLP4_SHIFT)
+#define PM800_LDO15_SLP4_SHIFT	4
+#define PM800_LDO15_SLP4_MASK	(0x3 << PM800_LDO15_SLP4_SHIFT)
+#define PM800_LDO16_SLP4_SHIFT	6
+#define PM800_LDO16_SLP4_MASK	(0x3 << PM800_LDO16_SLP4_SHIFT)
+
+/* LDO Sleep Mode Register 5: LDO[17..19] */
+#define PM800_LDO_SLP5		(0x60)
+#define PM800_LDO17_SLP5_SHIFT	0
+#define PM800_LDO17_SLP5_MASK	(0x3 << PM800_LDO17_SLP5_SHIFT)
+#define PM800_LDO18_SLP5_SHIFT	2
+#define PM800_LDO18_SLP5_MASK	(0x3 << PM800_LDO18_SLP5_SHIFT)
+#define PM800_LDO19_SLP5_SHIFT	4
+#define PM800_LDO19_SLP5_MASK	(0x3 << PM800_LDO19_SLP5_SHIFT)
+
+#define PM800_LDO_GROUP1	(0x68)
+#define PM800_LDO_GROUP2	(0x69)
+#define PM800_LDO_GROUP3	(0x6A)
+#define PM800_LDO_GROUP4	(0x6B)
+#define PM800_LDO_GROUP5	(0x6C)
+#define PM800_LDO_GROUP6	(0x6D)
+#define PM800_LDO_GROUP7	(0x6E)
+#define PM800_LDO_GROUP8	(0x6F)
+#define PM800_LDO_GROUP9	(0x70)
+#define PM800_LDO_GROUP10	(0x71)
+
+#define PM800_LDO_MISC1		(0x90)
+#define PM800_LDO_MISC2		(0x91)
+#define PM800_LDO_MISC3		(0x92)
+#define PM800_LDO_MISC4		(0x93)
+#define PM800_LDO_MISC5		(0x94)
+#define PM800_LDO_MISC6		(0x95)
+#define PM800_LDO_MISC7		(0x96)
+#define PM800_LDO_MISC8		(0x97)
+#define PM800_LDO_MISC9		(0x98)
+#define PM800_LDO_MISC10	(0x99)
+#define PM800_LDO_MISC11	(0x9A)
+
+/*********************************/
+/*page 2 GPADC: slave adder 0x02*/
+/********************************/
+#define PM800_GPADC_MEAS_EN1		(0x01)
+#define PM800_MEAS_EN1_VBAT         (1 << 2)
+#define PM800_GPADC_MEAS_EN2		(0x02)
+#define PM800_MEAS_EN2_RFTMP        (1 << 0)
+#define PM800_MEAS_GP0_EN			(1 << 2)
+#define PM800_MEAS_GP1_EN			(1 << 3)
+#define PM800_MEAS_GP2_EN			(1 << 4)
+#define PM800_MEAS_GP3_EN			(1 << 5)
+#define PM800_MEAS_GP4_EN			(1 << 6)
+
+#define PM800_GPADC_MISC_CONFIG1	(0x05)
+#define PM800_GPADC_MISC_CONFIG2	(0x06)
+#define PM800_GPADC_MISC_GPFSM_EN	(1 << 0)
+#define PM800_GPADC_SLOW_MODE(x)	(x << 3)
+
+#define PM800_GPADC_MEAS_OFF_TIME1	(0x07)
+#define PM800_GPADC_MEAS_OFF_TIME2	(0x08)
+
+#define PM800_GPADC_MISC_CONFIG3		(0x09)
+#define PM800_GPADC_MISC_CONFIG4		(0x0A)
+#define PM800_GPADC_MEAS_OFF_TIME2_1	(0x07)
+#define PM800_GPADC_MEAS_OFF_TIME2_2	(0x08)
+
+#define PM800_GPADC_PREBIAS1			(0x0F)
+#define PM800_GPADC0_GP_PREBIAS_TIME(x)	(x << 0)
+#define PM800_GPADC_PREBIAS2			(0x10)
+
+#define PM800_GP_BIAS_ENA1				(0x14)
+#define PM800_GPADC_GP_BIAS_EN0			(1 << 0)
+#define PM800_GPADC_GP_BIAS_EN1			(1 << 1)
+#define PM800_GPADC_GP_BIAS_EN2			(1 << 2)
+#define PM800_GPADC_GP_BIAS_EN3			(1 << 3)
+
+#define PM800_GP_BIAS_OUT1		(0x15)
+#define PM800_BIAS_OUT_GP0		(1 << 0)
+#define PM800_BIAS_OUT_GP1		(1 << 1)
+#define PM800_BIAS_OUT_GP2		(1 << 2)
+#define PM800_BIAS_OUT_GP3		(1 << 3)
+
+#define PM800_GPADC0_LOW_TH		0x20
+#define PM800_GPADC1_LOW_TH		0x21
+#define PM800_GPADC2_LOW_TH		0x22
+#define PM800_GPADC3_LOW_TH		0x23
+#define PM800_GPADC4_LOW_TH		0x24
+
+#define PM800_GPADC0_UPP_TH		0x30
+#define PM800_GPADC1_UPP_TH		0x31
+#define PM800_GPADC2_UPP_TH		0x32
+#define PM800_GPADC3_UPP_TH		0x33
+#define PM800_GPADC4_UPP_TH		0x34
+
+#define PM800_VBBAT_MEAS1		0x40
+#define PM800_VBBAT_MEAS2		0x41
+#define PM800_VBAT_MEAS1		0x42
+#define PM800_VBAT_MEAS2		0x43
+#define PM800_VSYS_MEAS1		0x44
+#define PM800_VSYS_MEAS2		0x45
+#define PM800_VCHG_MEAS1		0x46
+#define PM800_VCHG_MEAS2		0x47
+#define PM800_TINT_MEAS1		0x50
+#define PM800_TINT_MEAS2		0x51
+#define PM800_PMOD_MEAS1		0x52
+#define PM800_PMOD_MEAS2		0x53
+
+#define PM800_GPADC0_MEAS1		0x54
+#define PM800_GPADC0_MEAS2		0x55
+#define PM800_GPADC1_MEAS1		0x56
+#define PM800_GPADC1_MEAS2		0x57
+#define PM800_GPADC2_MEAS1		0x58
+#define PM800_GPADC2_MEAS2		0x59
+#define PM800_GPADC3_MEAS1		0x5A
+#define PM800_GPADC3_MEAS2		0x5B
+#define PM800_GPADC4_MEAS1		0x5C
+#define PM800_GPADC4_MEAS2		0x5D
+
+#define PM800_GPADC4_AVG1		0xA8
+#define PM800_GPADC4_AVG2		0xA9
+/*********************************/
+/*page 7 TEST PAGE: slave adder 0x07*/
+/********************************/
+
+/*******************************
+ * customer configuration start*
+********************************/
+
+/*****************************
+ * customer configuration end*
+******************************/
+
+/* 88PM805 Registers */
+#define PM805_MAIN_POWERUP		(0x01)
+#define PM805_INT_STATUS0		(0x02)	/*for ena/dis all interrupts */
+
+#define PM805_STATUS0_INT_CLEAR		(1 << 0)
+#define PM805_STATUS0_INV_INT		(1 << 1)
+#define PM800_STATUS0_INT_MASK		(1 << 2)
+
+#define PM805_INT_STATUS1		(0x03)
+
+#define PM805_INT1_HP1_SHRT		(1 << 0)
+#define PM805_INT1_HP2_SHRT		(1 << 1)
+#define PM805_INT1_MIC_CONFLICT		(1 << 2)
+#define PM805_INT1_CLIP_FAULT		(1 << 3)
+#define PM805_INT1_LDO_OFF			(1 << 4)
+#define PM805_INT1_SRC_DPLL_LOCK	(1 << 5)
+
+#define PM805_INT_STATUS2		(0x04)
+
+#define PM805_INT2_MIC_DET			(1 << 0)
+#define PM805_INT2_SHRT_BTN_DET		(1 << 1)
+#define PM805_INT2_VOLM_BTN_DET		(1 << 2)
+#define PM805_INT2_VOLP_BTN_DET		(1 << 3)
+#define PM805_INT2_RAW_PLL_FAULT	(1 << 4)
+#define PM805_INT2_FINE_PLL_FAULT	(1 << 5)
+
+#define PM805_INT_MASK1			(0x05)
+#define PM805_INT_MASK2			(0x06)
+#define PM805_SHRT_BTN_DET		(1 << 1)
+
+/*number of status and int reg in a row*/
+#define PM805_INT_REG_NUM		(2)
+
+#define PM805_MIC_DET1			(0x07)
+#define PM805_MIC_DET_EN_MIC_DET (1 << 0)
+#define PM805_MIC_DET2			(0x08)
+#define PM805_MIC_DET_STATUS1	(0x09)
+/*where is 2?*/
+#define PM805_MIC_DET_STATUS3	(0x0A)
+#define PM805_AUTO_SEQ_STATUS1	(0x0B)
+#define PM805_AUTO_SEQ_STATUS2	(0x0C)
+
+#define PM805_ADC_SETTING1		(0x10)
+#define PM805_ADC_SETTING2		(0x11)
+#define PM805_ADC_SETTING3		(0x11)
+#define PM805_ADC_GAIN1			(0x12)
+#define PM805_ADC_GAIN2			(0x13)
+#define PM805_DMIC_SETTING		(0x15)
+#define PM805_DWS_SETTING		(0x16)
+#define PM805_MIC_CONFLICT_STS	(0x17)
+
+#define PM805_PDM_SETTING1		(0x20)
+#define PM805_PDM_SETTING2		(0x21)
+#define PM805_PDM_SETTING3		(0x22)
+#define PM805_PDM_CONTROL1		(0x23)
+#define PM805_PDM_CONTROL2		(0x24)
+#define PM805_PDM_CONTROL3		(0x25)
+
+#define PM805_HEADPHONE_SETTING			(0x26)
+#define PM805_HEADPHONE_GAIN_A2A		(0x27)
+#define PM805_HEADPHONE_SHORT_STATE		(0x28)
+#define PM805_EARPHONE_SETTING			(0x29)
+#define PM805_AUTO_SEQ_SETTING			(0x2A)
+
+#define get_pmic_version(chip) (*(unsigned char *) chip)
+
+/*******************************
+ * customer configuration start*
+********************************/
+/* for disabling the use of PM805*/
+/*#define NO_PM805_CHIP*/
+/*****************************
+ * customer configuration end*
+******************************/
+
+/* Interrupt Number in 88PM800 */
+enum {
+	PM800_IRQ_ONKEY,	/*EN1b0 *//*0 */
+	PM800_IRQ_EXTON,	/*EN1b1 */
+	PM800_IRQ_CHG,		/*EN1b2 */
+	PM800_IRQ_BAT,		/*EN1b3 */
+	PM800_IRQ_RTC,		/*EN1b4 */
+	PM800_IRQ_CLASSD,	/*EN1b5 *//*5 */
+	PM800_IRQ_VBAT,		/*EN2b0 */
+	PM800_IRQ_VSYS,		/*EN2b1 */
+	PM800_IRQ_VCHG,		/*EN2b2 */
+	PM800_IRQ_TINT,		/*EN2b3 */
+	PM800_IRQ_GPADC0,	/*EN3b0 *//*10 */
+	PM800_IRQ_GPADC1,	/*EN3b1 */
+	PM800_IRQ_GPADC2,	/*EN3b2 */
+	PM800_IRQ_GPADC3,	/*EN3b3 */
+	PM800_IRQ_GPADC4,	/*EN3b4 */
+	PM800_IRQ_GPIO0,	/*EN4b0 *//*15 */
+	PM800_IRQ_GPIO1,	/*EN4b1 */
+	PM800_IRQ_GPIO2,	/*EN4b2 */
+	PM800_IRQ_GPIO3,	/*EN4b3 */
+	PM800_IRQ_GPIO4,	/*EN4b4 *//*19 */
+	PM800_MAX_IRQ,
+};
+
+/* Interrupt Number in 88PM805 */
+enum {
+	PM805_IRQ_LDO_OFF,	/*0 */
+	PM805_IRQ_SRC_DPLL_LOCK,	/*1 */
+	PM805_IRQ_CLIP_FAULT,
+	PM805_IRQ_MIC_CONFLICT,
+	PM805_IRQ_HP2_SHRT,
+	PM805_IRQ_HP1_SHRT,	/*5 */
+	PM805_IRQ_FINE_PLL_FAULT,
+	PM805_IRQ_RAW_PLL_FAULT,
+	PM805_IRQ_VOLP_BTN_DET,
+	PM805_IRQ_VOLM_BTN_DET,
+	PM805_IRQ_SHRT_BTN_DET,	/*10 */
+	PM805_IRQ_MIC_DET,	/*11 */
+
+	PM805_MAX_IRQ,
+};
+
+struct pm80x_subchip {
+	struct i2c_client *power_page;	/* chip client for power page */
+	struct i2c_client *gpadc_page;	/* chip client for gpadc page */
+	struct regmap *regmap_power;
+	struct regmap *regmap_gpadc;
+	unsigned short power_page_addr;	/* power page I2C address */
+	unsigned short gpadc_page_addr;	/* gpadc page I2C address */
+};
+
+struct pm80x_chip {
+	struct pm80x_subchip *subchip;
+	struct device *dev;
+	struct i2c_client *client;
+	struct i2c_client *companion;
+	struct regmap *regmap;
+	struct regmap_irq_chip *regmap_irq_chip;
+	struct regmap_irq_chip_data *irq_data;
+	unsigned char version;
+	int id;
+	int irq;
+	int irq_mode;
+	int irq_base;
+	unsigned int wu_flag;
+};
+
+enum {
+	PM80X_GPIO1_SUPPLY_VBUS = 1,
+	PM80X_GPIO2_SUPPLY_VBUS = 2,
+};
+
+enum {
+	PM80X_IDPIN_NO_USE = 0,
+	PM80X_IDPIN_USE_GPADC0,
+	PM80X_IDPIN_USE_GPADC1,
+	PM80X_IDPIN_USE_GPADC2,
+	PM80X_IDPIN_USE_GPADC3,
+};
+
+struct pm80x_rtc_pdata {
+	int		vrtc;
+	int		rtc_wakeup;
+};
+
+struct pm80x_platform_data {
+	struct pm80x_rtc_pdata *rtc;
+	unsigned short pm800_addr;
+	unsigned short pm805_addr;
+	unsigned short power_page_addr;	/* power page I2C address */
+	unsigned short gpadc_page_addr;	/* gpadc page I2C address */
+	int irq_mode;		/* Clear interrupt by read/write(0/1) */
+	int irq_base;		/* IRQ base of chip */
+	int batt_det;		/* enable/disable */
+	int (*pm80x_plat_config)(struct pm80x_chip *chip,
+				struct pm80x_platform_data *pdata);
+};
+
+extern int pm80x_device_init(struct pm80x_chip *chip,
+			     struct pm80x_platform_data *pdata) __devinit;
+extern void pm80x_device_exit(struct pm80x_chip *chip) __devexit;
+#endif /* __LINUX_MFD_88PM80X_H */
-- 
1.7.0.4
