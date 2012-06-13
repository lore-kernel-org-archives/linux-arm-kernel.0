From: zhouqiao@marvell.com (Qiao Zhou)
Date: Wed, 13 Jun 2012 17:04:09 +0800
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <1339578251-15009-1-git-send-email-zhouqiao@marvell.com>
References: <1339578251-15009-1-git-send-email-zhouqiao@marvell.com>
Message-ID: <1339578251-15009-2-git-send-email-zhouqiao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM800 and 88PM805 are two discrete chips used for power management.
Hardware designer can use them together or only one of them according to
requirement.

There's some logic tightly linked between these two chips. For example, USB
charger driver needs to access both chips by I2C interface.

Now share one driver to these two devices. Only one I2C client is identified
in platform init data. If one chip is also used, user should mark it with
related i2c_addr field of platform init data. Then driver could create another
I2C client for the chip.

All I2C operations are accessed by 80x-i2c driver. In order to support all
I2C client address, the read/write API is changed in below.

reg_read(client, offset)
reg_write(client, offset, data)

The benefit is that client drivers only need one kind of read/write API. I2C
and MFD driver can be shared in both 800 and 805.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 drivers/mfd/88pm80x-core.c  | 1002 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/88pm80x-i2c.c   |  370 ++++++++++++++++
 drivers/mfd/Kconfig         |   11 +
 drivers/mfd/Makefile        |    2 +
 include/linux/mfd/88pm80x.h |  701 ++++++++++++++++++++++++++++++
 5 files changed, 2086 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mfd/88pm80x-core.c
 create mode 100644 drivers/mfd/88pm80x-i2c.c
 create mode 100644 include/linux/mfd/88pm80x.h

diff --git a/drivers/mfd/88pm80x-core.c b/drivers/mfd/88pm80x-core.c
new file mode 100644
index 0000000..dd27aad
--- /dev/null
+++ b/drivers/mfd/88pm80x-core.c
@@ -0,0 +1,1002 @@
+/*
+ * Base driver for Marvell 88PM800
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
+struct pm80x_irq_data {
+	int reg;
+	int mask_reg;
+	int enable;		/* enable or not */
+	int offs;		/* bit offset in mask register */
+};
+
+static struct pm80x_irq_data pm800_irqs[] = {
+	[PM800_IRQ_ONKEY] = {	/*0 */
+			     .reg = PM800_INT_STATUS1,
+			     .mask_reg = PM800_INT_ENA_1,
+			     .offs = 1 << 0,
+			     },
+	[PM800_IRQ_EXTON] = {
+			     .reg = PM800_INT_STATUS1,
+			     .mask_reg = PM800_INT_ENA_1,
+			     .offs = 1 << 1,
+			     },
+	[PM800_IRQ_CHG] = {
+			   .reg = PM800_INT_STATUS1,
+			   .mask_reg = PM800_INT_ENA_1,
+			   .offs = 1 << 2,
+			   },
+	[PM800_IRQ_BAT] = {
+			   .reg = PM800_INT_STATUS1,
+			   .mask_reg = PM800_INT_ENA_1,
+			   .offs = 1 << 3,
+			   },
+	[PM800_IRQ_RTC] = {
+			   .reg = PM800_INT_STATUS1,
+			   .mask_reg = PM800_INT_ENA_1,
+			   .offs = 1 << 4,
+			   },
+	[PM800_IRQ_CLASSD] = {	/*5 */
+			      .reg = PM800_INT_STATUS1,
+			      .mask_reg = PM800_INT_ENA_1,
+			      .offs = 1 << 5,
+			      },
+	[PM800_IRQ_VBAT] = {
+			    .reg = PM800_INT_STATUS2,
+			    .mask_reg = PM800_INT_ENA_2,
+			    .offs = 1 << 0,
+			    },
+	[PM800_IRQ_VSYS] = {
+			    .reg = PM800_INT_STATUS2,
+			    .mask_reg = PM800_INT_ENA_2,
+			    .offs = 1 << 1,
+			    },
+	[PM800_IRQ_VCHG] = {
+			    .reg = PM800_INT_STATUS2,
+			    .mask_reg = PM800_INT_ENA_2,
+			    .offs = 1 << 2,
+			    },
+	[PM800_IRQ_TINT] = {
+			    .reg = PM800_INT_STATUS2,
+			    .mask_reg = PM800_INT_ENA_2,
+			    .offs = 1 << 3,
+			    },
+	[PM800_IRQ_GPADC0] = {	/*10 */
+			      .reg = PM800_INT_STATUS3,
+			      .mask_reg = PM800_INT_ENA_3,
+			      .offs = 1 << 0,
+			      },
+	[PM800_IRQ_GPADC1] = {
+			      .reg = PM800_INT_STATUS3,
+			      .mask_reg = PM800_INT_ENA_3,
+			      .offs = 1 << 1,
+			      },
+	[PM800_IRQ_GPADC2] = {
+			      .reg = PM800_INT_STATUS3,
+			      .mask_reg = PM800_INT_ENA_3,
+			      .offs = 1 << 2,
+			      },
+	[PM800_IRQ_GPADC3] = {
+			      .reg = PM800_INT_STATUS3,
+			      .mask_reg = PM800_INT_ENA_3,
+			      .offs = 1 << 3,
+			      },
+	[PM800_IRQ_GPADC4] = {
+			      .reg = PM800_INT_STATUS3,
+			      .mask_reg = PM800_INT_ENA_3,
+			      .offs = 1 << 4,
+			      },
+	[PM800_IRQ_GPIO0] = {	/*15 */
+			     .reg = PM800_INT_STATUS4,
+			     .mask_reg = PM800_INT_ENA_4,
+			     .offs = 1 << 0,
+			     },
+	[PM800_IRQ_GPIO1] = {
+			     .reg = PM800_INT_STATUS4,
+			     .mask_reg = PM800_INT_ENA_4,
+			     .offs = 1 << 1,
+			     },
+	[PM800_IRQ_GPIO2] = {
+			     .reg = PM800_INT_STATUS4,
+			     .mask_reg = PM800_INT_ENA_4,
+			     .offs = 1 << 2,
+			     },
+	[PM800_IRQ_GPIO3] = {
+			     .reg = PM800_INT_STATUS4,
+			     .mask_reg = PM800_INT_ENA_4,
+			     .offs = 1 << 3,
+			     },
+	[PM800_IRQ_GPIO4] = {	/*19 */
+			     .reg = PM800_INT_STATUS4,
+			     .mask_reg = PM800_INT_ENA_4,
+			     .offs = 1 << 4,
+			     },
+};
+
+static inline struct pm80x_irq_data *irq_to_pm800(struct pm80x_chip *chip,
+						  int irq)
+{
+	int offset = irq - chip->pm800_chip->irq_base;
+	if (!chip->pm800_chip || (offset < 0)
+	    || (offset >= ARRAY_SIZE(pm800_irqs)))
+		return NULL;
+	return &pm800_irqs[offset];
+}
+
+static irqreturn_t pm800_irq(int irq, void *data)
+{
+	struct pm80x_chip *chip = data;
+	struct pm80x_subchip *pm800_chip = chip->pm800_chip;
+	struct pm80x_irq_data *irq_data;
+	struct i2c_client *i2c = chip->base_page;
+	int read_reg = -1, value = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pm800_irqs); i++) {
+		irq_data = &pm800_irqs[i];
+		if (read_reg != irq_data->reg) {
+			read_reg = irq_data->reg;
+			value = pm80x_reg_read(i2c, irq_data->reg);
+		}
+		if (value & irq_data->enable)
+			handle_nested_irq(pm800_chip->irq_base + i);
+	}
+	return IRQ_HANDLED;
+}
+
+static void pm800_irq_lock(struct irq_data *data)
+{
+	struct pm80x_chip *chip = irq_data_get_irq_chip_data(data);
+
+	mutex_lock(&chip->pm800_irq_lock);
+}
+
+static void pm800_irq_sync_unlock(struct irq_data *data)
+{
+	struct pm80x_chip *chip = irq_data_get_irq_chip_data(data);
+	struct pm80x_irq_data *irq_data;
+	struct i2c_client *i2c;
+	unsigned char mask[PM800_INT_REG_NUM] = { 0x0, 0x0, 0x0, 0x0 };
+	int i;
+
+	i2c = chip->base_page;
+
+	for (i = 0; i < ARRAY_SIZE(pm800_irqs); i++) {
+		irq_data = &pm800_irqs[i];
+		switch (irq_data->mask_reg) {
+		case PM800_INT_ENA_1:
+			mask[0] &= ~irq_data->offs;
+			mask[0] |= irq_data->enable;
+			break;
+		case PM800_INT_ENA_2:
+			mask[1] &= ~irq_data->offs;
+			mask[1] |= irq_data->enable;
+			break;
+		case PM800_INT_ENA_3:
+			mask[2] &= ~irq_data->offs;
+			mask[2] |= irq_data->enable;
+			break;
+		case PM800_INT_ENA_4:
+			mask[3] &= ~irq_data->offs;
+			mask[3] |= irq_data->enable;
+			break;
+		default:
+			dev_err(chip->dev, "wrong IRQ\n");
+			break;
+		}
+	}
+	/* update mask into registers */
+	for (i = 0; i < PM800_INT_REG_NUM; i++)
+		pm80x_reg_write(i2c, PM800_INT_ENA_1 + i, mask[i]);
+
+	mutex_unlock(&chip->pm800_irq_lock);
+}
+
+static void pm800_irq_enable(struct irq_data *data)
+{
+	struct pm80x_chip *chip = irq_data_get_irq_chip_data(data);
+	struct pm80x_subchip *pm800_chip = chip->pm800_chip;
+	int offset = data->irq - pm800_chip->irq_base;
+	if ((offset >= 0) && (offset < ARRAY_SIZE(pm800_irqs)))
+		pm800_irqs[offset].enable = pm800_irqs[offset].offs;
+}
+
+static void pm800_irq_disable(struct irq_data *data)
+{
+	struct pm80x_chip *chip = irq_data_get_irq_chip_data(data);
+	struct pm80x_subchip *pm800_chip = chip->pm800_chip;
+	int offset = data->irq - pm800_chip->irq_base;
+	if ((offset >= 0) && (offset < ARRAY_SIZE(pm800_irqs)))
+		pm800_irqs[data->irq - pm800_chip->irq_base].enable = 0;
+}
+
+static struct irq_chip pm800_irq_chip = {
+	.name = "88pm80x",
+	.irq_bus_lock = pm800_irq_lock,
+	.irq_bus_sync_unlock = pm800_irq_sync_unlock,
+	.irq_enable = pm800_irq_enable,
+	.irq_disable = pm800_irq_disable,
+};
+
+static struct pm80x_irq_data pm805_irqs[] = {
+	[PM805_IRQ_LDO_OFF] = {	/*0 */
+			       .reg = PM805_INT_STATUS1,
+			       .mask_reg = PM805_INT_MASK1,
+			       .offs = 1 << 5,
+			       },
+	[PM805_IRQ_SRC_DPLL_LOCK] = {
+				     .reg = PM805_INT_STATUS1,
+				     .mask_reg = PM805_INT_MASK1,
+				     .offs = 1 << 4,
+				     },
+	[PM805_IRQ_CLIP_FAULT] = {
+				  .reg = PM805_INT_STATUS1,
+				  .mask_reg = PM805_INT_MASK1,
+				  .offs = 1 << 3,
+				  },
+	[PM805_IRQ_MIC_CONFLICT] = {
+				    .reg = PM805_INT_STATUS1,
+				    .mask_reg = PM805_INT_MASK1,
+				    .offs = 1 << 2,
+				    },
+	[PM805_IRQ_HP2_SHRT] = {
+				.reg = PM805_INT_STATUS1,
+				.mask_reg = PM805_INT_MASK1,
+				.offs = 1 << 1,
+				},
+	[PM805_IRQ_HP1_SHRT] = {	/*5 */
+				.reg = PM805_INT_STATUS1,
+				.mask_reg = PM805_INT_MASK1,
+				.offs = 1 << 0,
+				},
+	[PM805_IRQ_FINE_PLL_FAULT] = {
+				      .reg = PM805_INT_STATUS2,
+				      .mask_reg = PM805_INT_MASK2,
+				      .offs = 1 << 5,
+				      },
+	[PM805_IRQ_RAW_PLL_FAULT] = {
+				     .reg = PM805_INT_STATUS2,
+				     .mask_reg = PM805_INT_MASK2,
+				     .offs = 1 << 4,
+				     },
+	[PM805_IRQ_VOLP_BTN_DET] = {
+				    .reg = PM805_INT_STATUS2,
+				    .mask_reg = PM805_INT_MASK2,
+				    .offs = 1 << 3,
+				    },
+	[PM805_IRQ_VOLM_BTN_DET] = {
+				    .reg = PM805_INT_STATUS2,
+				    .mask_reg = PM805_INT_MASK2,
+				    .offs = 1 << 2,
+				    },
+	[PM805_IRQ_SHRT_BTN_DET] = {	/*10 */
+				    .reg = PM805_INT_STATUS2,
+				    .mask_reg = PM805_INT_MASK2,
+				    .offs = 1 << 1,
+				    },
+	[PM805_IRQ_MIC_DET] = {	/*11 */
+			       .reg = PM805_INT_STATUS2,
+			       .mask_reg = PM805_INT_MASK2,
+			       .offs = 1 << 0,
+			       },
+};
+
+static inline struct pm80x_irq_data *irq_to_pm805(struct pm80x_chip *chip,
+						  int irq)
+{
+	int offset = irq - chip->pm805_chip->irq_base;
+	if (!chip->pm805_chip || (offset < 0)
+	    || (offset >= ARRAY_SIZE(pm805_irqs)))
+		return NULL;
+	return &pm805_irqs[offset];
+}
+
+static irqreturn_t pm805_irq(int irq, void *data)
+{
+	struct pm80x_chip *chip = data;
+	struct pm80x_subchip *pm805_chip = chip->pm805_chip;
+	struct pm80x_irq_data *irq_data;
+	struct i2c_client *i2c;
+	int i, read_reg = -1, value = 0;
+
+	i2c = pm805_chip->client;
+
+	for (i = 0; i < ARRAY_SIZE(pm805_irqs); i++) {
+		irq_data = &pm805_irqs[i];
+		if (read_reg != irq_data->reg) {
+			read_reg = irq_data->reg;
+			value = pm80x_reg_read(i2c, irq_data->reg);
+		}
+		if (value & irq_data->enable)
+			handle_nested_irq(pm805_chip->irq_base + i);
+	}
+	return IRQ_HANDLED;
+}
+
+static void pm805_irq_lock(struct irq_data *data)
+{
+	struct pm80x_chip *chip = irq_data_get_irq_chip_data(data);
+
+	mutex_lock(&chip->pm805_irq_lock);
+}
+
+static void pm805_irq_sync_unlock(struct irq_data *data)
+{
+	struct pm80x_chip *chip = irq_data_get_irq_chip_data(data);
+	struct pm80x_subchip *pm805_chip = chip->pm805_chip;
+	struct pm80x_irq_data *irq_data;
+	struct i2c_client *i2c;
+	unsigned char mask[PM805_INT_REG_NUM] = { 0x0 };
+	int i;
+
+	i2c = pm805_chip->client;
+
+	for (i = 0; i < ARRAY_SIZE(pm805_irqs); i++) {
+		irq_data = &pm805_irqs[i];
+		switch (irq_data->mask_reg) {
+		case PM805_INT_MASK1:
+			mask[0] &= ~irq_data->offs;
+			mask[0] |= irq_data->enable;
+			break;
+		case PM805_INT_MASK2:
+			mask[1] &= ~irq_data->offs;
+			mask[1] |= irq_data->enable;
+			break;
+		default:
+			dev_err(chip->dev, "wrong IRQ\n");
+			break;
+		}
+	}
+	/* update mask into registers */
+	for (i = 0; i < PM805_INT_REG_NUM; i++)
+		pm80x_reg_write(i2c, PM805_INT_MASK1 + i, mask[i]);
+
+	mutex_unlock(&chip->pm805_irq_lock);
+}
+
+static void pm805_irq_enable(struct irq_data *data)
+{
+	struct pm80x_chip *chip = irq_data_get_irq_chip_data(data);
+	struct pm80x_subchip *pm805_chip = chip->pm805_chip;
+	int offset = data->irq - pm805_chip->irq_base;
+	if ((offset >= 0) && (offset < ARRAY_SIZE(pm805_irqs)))
+		pm805_irqs[offset].enable = pm805_irqs[offset].offs;
+}
+
+static void pm805_irq_disable(struct irq_data *data)
+{
+	struct pm80x_chip *chip = irq_data_get_irq_chip_data(data);
+	struct pm80x_subchip *pm805_chip = chip->pm805_chip;
+	int offset = data->irq - pm805_chip->irq_base;
+	if ((offset >= 0) && (offset < ARRAY_SIZE(pm805_irqs)))
+		pm805_irqs[offset].enable = 0;
+}
+
+static struct irq_chip pm805_irq_chip = {
+	.name = "88pm805",
+	.irq_bus_lock = pm805_irq_lock,
+	.irq_bus_sync_unlock = pm805_irq_sync_unlock,
+	.irq_enable = pm805_irq_enable,
+	.irq_disable = pm805_irq_disable,
+};
+
+static int __devinit device_gpadc_init(struct pm80x_chip *chip,
+				       struct pm80x_platform_data *pdata)
+{
+	struct i2c_client *i2c_gpadc = chip->gpadc_page;
+	int data = 0, mask = 0, ret = 0;
+
+	if (!i2c_gpadc) {
+		dev_warn(chip->dev,
+			 "Warning: I2C gpdac page is not available!\n");
+		return -EINVAL;
+	}
+	/* initialize GPADC without activating it */
+	/* turn on GPADC measurments */
+	ret = pm80x_set_bits(i2c_gpadc,
+			     PM800_GPADC_MISC_CONFIG2,
+			     PM800_GPADC_MISC_GPFSM_EN,
+			     PM800_GPADC_MISC_GPFSM_EN);
+	if (ret < 0)
+		goto out;
+	/*
+	   This function configures the ADC as requires for
+	   CP implementation.CP does not "own" the ADC configuration
+	   registers and relies on AP.
+	   Reason: enable automatic ADC measurements needed
+	   for CP to get VBAT and RF temperature readings.
+	 */
+	ret = pm80x_set_bits(i2c_gpadc, PM800_GPADC_MEAS_EN1,
+			     PM800_MEAS_EN1_VBAT, PM800_MEAS_EN1_VBAT);
+	if (ret < 0)
+		goto out;
+	ret = pm80x_set_bits(i2c_gpadc, PM800_GPADC_MEAS_EN2,
+			     (PM800_MEAS_EN2_RFTMP | PM800_MEAS_GP0_EN),
+			     (PM800_MEAS_EN2_RFTMP | PM800_MEAS_GP0_EN));
+	if (ret < 0)
+		goto out;
+
+	/* the defult of PM800 is GPADC operates@100Ks/s rate */
+	/* and Number of GPADC slots with active current bias prior to
+	   GPADC sampling = 1 slot for all GPADCs */
+
+	/* set for Temprature mesurmants */
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
+	ret = pm80x_set_bits(i2c_gpadc, PM800_GP_BIAS_ENA1, mask, data);
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
+static void genirq_init_800(struct pm80x_chip *chip, int irq_base)
+{
+	int i, __irq;
+	for (i = 0; i < ARRAY_SIZE(pm800_irqs); i++) {
+		__irq = i + irq_base;
+		irq_set_chip_data(__irq, chip);
+		irq_set_chip_and_handler(__irq, &pm800_irq_chip,
+					 handle_edge_irq);
+		irq_set_nested_thread(__irq, 1);
+#ifdef CONFIG_ARM
+		set_irq_flags(__irq, IRQF_VALID);
+#else
+		irq_set_noprobe(__irq);
+#endif
+	}
+}
+
+static void genirq_exit_800(int irq_base)
+{
+	int i, __irq;
+	for (i = 0; i < ARRAY_SIZE(pm800_irqs); i++) {
+		__irq = i + irq_base;
+#ifdef CONFIG_ARM
+		set_irq_flags(__irq, 0);
+#endif
+		irq_set_chip_and_handler(__irq, NULL, NULL);
+		irq_set_chip_data(__irq, NULL);
+	}
+}
+
+static int __devinit device_irq_init_800(struct pm80x_chip *chip,
+					 struct pm80x_platform_data *pdata)
+{
+	struct pm80x_subchip *pm800_chip = chip->pm800_chip;
+	struct i2c_client *i2c_base = chip->base_page;
+	unsigned char status_buf[PM800_INT_REG_NUM];
+	unsigned long flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT | IRQF_SHARED;
+	struct irq_desc *desc;
+	int data, mask, ret = -EINVAL;
+	int irq, irq_base;
+
+	if (!pdata) {
+		dev_err(chip->dev, "missing platform data\n");
+		return -EINVAL;
+	}
+	if (!i2c_base) {
+		dev_err(chip->dev, "missing base_page\n");
+		return -EINVAL;
+	}
+
+	irq = pm800_chip->irq;
+	irq_base = pm800_chip->irq_base;
+
+	if (!irq) {
+		dev_err(chip->dev, "No interrupt IRQ for pm800\n");
+		return -EINVAL;
+	}
+
+	mask = PM800_WAKEUP2_INV_INT | PM800_WAKEUP2_INT_CLEAR
+	    | PM800_WAKEUP2_INT_MASK;
+	data = 0;
+	if (pdata && pdata->irq_mode) {
+		/*
+		 * irq_mode defines the way of clearing interrupt. If it's 1,
+		 * clear IRQ by write. Otherwise, clear it by read.
+		 */
+		data |= PM800_WAKEUP2_INT_CLEAR;
+		pm800_chip->irq_mode = 1;
+	}
+	ret = pm80x_set_bits(i2c_base, PM800_WAKEUP2, mask, data);
+	if (ret < 0)
+		goto out;
+
+	/* mask all IRQs */
+	memset(status_buf, 0, PM800_INT_REG_NUM);
+	ret = pm80x_bulk_write(i2c_base, PM800_INT_ENA_1,
+			       PM800_INT_REG_NUM, status_buf);
+	if (ret < 0)
+		goto out;
+
+	if (pm800_chip->irq_mode) {
+		/* clear interrupt status by write */
+		memset(status_buf, 0xFF, PM800_INT_REG_NUM);
+		ret = pm80x_bulk_write(i2c_base, PM800_INT_STATUS1,
+				       PM800_INT_REG_NUM, status_buf);
+	} else {
+		/* clear interrupt status by read */
+		ret = pm80x_bulk_read(i2c_base, PM800_INT_STATUS1,
+				      PM800_INT_REG_NUM, status_buf);
+	}
+	if (ret < 0)
+		goto out;
+
+	mutex_init(&chip->pm800_irq_lock);
+
+	desc = irq_to_desc(irq);
+	pm800_irq_chip.irq_set_wake = desc->irq_data.chip->irq_set_wake;
+
+	/* Register IRQ by genirq */
+	genirq_init_800(chip, irq_base);
+	/* Request IRQ */
+	ret = request_threaded_irq(irq, NULL, pm800_irq, flags,
+				   "88pm800", chip);
+	if (ret) {
+		pm800_chip->irq = 0;
+		dev_err(chip->dev, "Failed to request pm800 IRQ: %d\n", ret);
+		goto out_request_irq;
+	}
+	return 0;
+
+out_request_irq:
+	genirq_exit_800(irq_base);
+out:
+	return ret;
+}
+
+static void device_irq_exit_800(struct pm80x_chip *chip)
+{
+	if (chip->pm800_chip && chip->pm800_chip->irq) {
+		free_irq(chip->pm800_chip->irq, chip);
+		genirq_exit_800(chip->pm800_chip->irq_base);
+	}
+}
+
+static void genirq_init_805(struct pm80x_chip *chip, int irq_base)
+{
+	int i, __irq;
+	for (i = 0; i < ARRAY_SIZE(pm805_irqs); i++) {
+		__irq = i + irq_base;
+		irq_set_chip_data(__irq, chip);
+		irq_set_chip_and_handler(__irq, &pm805_irq_chip,
+					 handle_edge_irq);
+		irq_set_nested_thread(__irq, 1);
+#ifdef CONFIG_ARM
+		set_irq_flags(__irq, IRQF_VALID);
+#else
+		irq_set_noprobe(__irq);
+#endif
+	}
+}
+
+static void genirq_exit_805(int irq_base)
+{
+	int i, __irq;
+	for (i = 0; i < ARRAY_SIZE(pm805_irqs); i++) {
+		__irq = i + irq_base;
+#ifdef CONFIG_ARM
+		set_irq_flags(__irq, 0);
+#endif
+		irq_set_chip_and_handler(__irq, NULL, NULL);
+		irq_set_chip_data(__irq, NULL);
+	}
+}
+
+static int __devinit device_irq_init_805(struct pm80x_chip *chip,
+					 struct pm80x_platform_data *pdata)
+{
+	struct pm80x_subchip *pm805_chip = chip->pm805_chip;
+	struct i2c_client *i2c = pm805_chip->client;
+	unsigned char status_buf[PM805_INT_REG_NUM];
+	unsigned long flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
+	struct irq_desc *desc;
+	int data, mask, ret = -EINVAL;
+	int irq, irq_base;
+
+	if (!pdata) {
+		dev_warn(chip->dev, "missing platform data\n");
+		return -EINVAL;
+	}
+
+	irq = pm805_chip->irq;
+	irq_base = pm805_chip->irq_base;
+	if (!irq) {
+		dev_warn(chip->dev, "No interrupt IRQ for pm805\n");
+		return -EINVAL;
+	}
+	mask = PM805_STATUS0_INT_CLEAR | PM805_STATUS0_INV_INT
+	    | PM800_STATUS0_INT_MASK;
+
+	data = 0;
+
+	if (pdata->irq_mode) {
+		data |= PM805_STATUS0_INT_CLEAR;
+		pm805_chip->irq_mode = 1;
+	}
+
+	ret = pm80x_set_bits(i2c, PM805_INT_STATUS0, mask, data);
+	if (ret < 0)
+		goto out;
+
+	/* Need to use delay between accesses to 32K-registers */
+	msleep(1);
+
+	/* mask all IRQs */
+	memset(status_buf, 0, PM805_INT_REG_NUM);
+	ret = pm80x_bulk_write(i2c, PM805_INT_MASK1,
+			       PM805_INT_REG_NUM, status_buf);
+	if (ret < 0)
+		goto out;
+
+	/* Need to use delay between accesses to 32K-registers */
+	msleep(1);
+
+	if (pm805_chip->irq_mode) {
+		/* clear interrupt status by write */
+		memset(status_buf, 0xFF, PM805_INT_REG_NUM);
+		ret = pm80x_bulk_write(i2c, PM805_INT_STATUS1,
+				       PM805_INT_REG_NUM, status_buf);
+	} else {
+		/* clear interrupt status by read */
+		ret = pm80x_bulk_read(i2c, PM805_INT_STATUS1,
+				      PM805_INT_REG_NUM, status_buf);
+	}
+	if (ret < 0)
+		goto out;
+
+	mutex_init(&chip->pm805_irq_lock);
+
+	if (!irq)
+		goto out;
+
+	desc = irq_to_desc(irq);
+	pm805_irq_chip.irq_set_wake = desc->irq_data.chip->irq_set_wake;
+
+	/* Register IRQ by genirq */
+	genirq_init_805(chip, irq_base);
+	/* Request IRQ */
+	ret = request_threaded_irq(irq, NULL, pm805_irq, flags,
+				   "88pm805", chip);
+	if (ret) {
+		pm805_chip->irq = 0;
+		dev_err(chip->dev, "Failed to request pm805 IRQ: %d\n", ret);
+		goto out_request_irq;
+	}
+	return 0;
+
+out_request_irq:
+	genirq_exit_805(irq_base);
+out:
+	return ret;
+}
+
+static void device_irq_exit_805(struct pm80x_chip *chip)
+{
+	if (chip->pm805_chip && chip->pm805_chip->irq) {
+		free_irq(chip->pm805_chip->irq, chip);
+		genirq_exit_805(chip->pm805_chip->irq_base);
+	}
+}
+
+static int __devinit device_805_init(struct pm80x_chip *chip,
+				     struct i2c_client *i2c,
+				     struct pm80x_platform_data *pdata)
+{
+	int ret = 0;
+	struct pm80x_subchip *pm805_chip;
+
+	dev_info(chip->dev, "pm80x:%s slave addr[0x%x]\n", __func__, i2c->addr);
+
+	/* Init PM805 subchip */
+	pm805_chip =
+	    devm_kzalloc(chip->dev, sizeof(struct pm80x_subchip), GFP_KERNEL);
+	if (!pm805_chip)
+		return -ENOMEM;
+	chip->pm805_chip = pm805_chip;
+	pm805_chip->dev = chip->dev;
+	pm805_chip->chip = chip;
+	pm805_chip->pdata = pdata;
+	pm805_chip->client = i2c;
+	pm805_chip->irq = chip->irq_pm805;
+	pm805_chip->irq_base = chip->irq_pm805_base;
+
+	ret = pm80x_reg_read(i2c, PM805_CHIP_ID);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read CHIP ID: %d\n", ret);
+		goto out_chip_id;
+	}
+	chip->chip805_version = ret;
+
+	ret = device_irq_init_805(chip, pdata);
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
+	if (pdata->pm805_plat_config)
+		pdata->pm805_plat_config(chip, pdata);
+
+	return 0;
+
+out_codec:
+	device_irq_exit_805(chip);
+out_irq_init:
+out_chip_id:
+	devm_kfree(chip->dev, chip->pm805_chip);
+	chip->pm805_chip = NULL;
+	return ret;
+}
+
+static int __devinit device_800_init(struct pm80x_chip *chip,
+				     struct i2c_client *i2c,
+				     struct pm80x_platform_data *pdata)
+{
+	struct i2c_client *i2c_base = chip->base_page;
+	struct pm80x_subchip *pm800_chip;
+	int ret, pmic_id;
+
+	if (!i2c_base) {
+		dev_err(chip->dev, "base_page is invalid\n");
+		return -EINVAL;
+	}
+
+	/* Init PM800 subchip */
+	pm800_chip =
+	    devm_kzalloc(chip->dev, sizeof(struct pm80x_subchip), GFP_KERNEL);
+	if (!pm800_chip)
+		return -ENOMEM;
+	chip->pm800_chip = pm800_chip;
+
+	pm800_chip->dev = chip->dev;
+	pm800_chip->chip = chip;
+	pm800_chip->pdata = pdata;
+	pm800_chip->client = i2c;
+	pm800_chip->irq = chip->irq_pm800;
+	pm800_chip->irq_base = chip->irq_pm800_base;
+
+	ret = pm80x_reg_read(i2c, PM800_CHIP_ID);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read CHIP ID: %d\n", ret);
+		goto out;
+	}
+
+	pmic_id = ret & PM80X_VERSION_MASK;
+
+	if ((pmic_id >= PM800_CHIP_A0) && (pmic_id <= PM800_CHIP_END)) {
+		chip->chip800_version = ret;
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
+	ret = pm80x_reg_read(chip->base_page, PM800_RTC_CONTROL);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read RTC register: %d\n", ret);
+		goto out;
+	}
+	if (ret & PM800_ALARM_WAKEUP) {
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
+	ret = device_irq_init_800(chip, pdata);
+	if (ret < 0) {
+		dev_err(chip->dev, "[%s]Failed to init pm800 irq\n", __func__);
+		goto out;
+	}
+
+	ret = mfd_add_devices(chip->dev, 0, &onkey_devs[0],
+			      ARRAY_SIZE(onkey_devs), &onkey_resources[0], pm800_chip->irq_base);
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
+				      pm800_chip->irq_base);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to add rtc subdev\n");
+			goto out_dev;
+		} else
+			dev_info(chip->dev,
+				 "[%s]:Added mfd rtc_devs\n", __func__);
+	}
+
+	if (pdata->pm800_plat_config)
+		pdata->pm800_plat_config(chip, pdata);
+
+	return 0;
+out_dev:
+	mfd_remove_devices(chip->dev);
+	device_irq_exit_800(chip);
+out:
+	devm_kfree(chip->dev, chip->pm800_chip);
+	chip->pm800_chip = NULL;
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
+		/* set PM800 as main chip */
+		ret = device_800_init(chip, chip->client_pm800, pdata);
+		if (ret) {
+			dev_err(chip->dev, "%s failed!\n", __func__);
+			return ret;
+		}
+
+		if (chip->client_pm805)
+			ret = device_805_init(chip, chip->client_pm805, pdata);
+
+		break;
+	case CHIP_PM805:
+		/* set PM805 as main chip */
+		ret = device_805_init(chip, chip->client_pm805, pdata);
+		break;
+	}
+	if (ret) {
+		dev_err(chip->dev, "%s failed!\n", __func__);
+		return ret;
+	}
+
+	return ret;
+}
+
+void __devexit pm80x_device_exit(struct pm80x_chip *chip)
+{
+	if (chip->pm800_chip) {
+		device_irq_exit_800(chip);
+		devm_kfree(chip->dev, chip->pm800_chip);
+	}
+	if (chip->pm805_chip) {
+		device_irq_exit_805(chip);
+		devm_kfree(chip->dev, chip->pm805_chip);
+	}
+	mfd_remove_devices(chip->dev);
+}
+
+MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM80x");
+MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/88pm80x-i2c.c b/drivers/mfd/88pm80x-i2c.c
new file mode 100644
index 0000000..cb3198a
--- /dev/null
+++ b/drivers/mfd/88pm80x-i2c.c
@@ -0,0 +1,370 @@
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
+#include <linux/uaccess.h>
+#include <linux/err.h>
+
+static struct regmap_config pm80x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static struct regmap *verify_regmap(struct i2c_client *i2c)
+{
+	struct regmap *map;
+	struct pm80x_chip *chip = i2c_get_clientdata(i2c);
+
+	if (i2c == chip->base_page)
+		map = chip->regmap_pm800;
+	else if (i2c == chip->client_pm805)
+		map = chip->regmap_pm805;
+	else if (i2c == chip->power_page)
+		map = chip->regmap_power;
+	else if (i2c == chip->gpadc_page)
+		map = chip->regmap_gpadc;
+	else {
+		dev_err(&i2c->dev, "no matched regmap for i2c client\n");
+		map = NULL;
+	}
+
+	return map;
+}
+
+int pm80x_reg_read(struct i2c_client *i2c, int reg)
+{
+	struct regmap *map = verify_regmap(i2c);
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(map, reg, &data);
+	if (ret < 0)
+		return ret;
+	else
+		return (int)data;
+}
+EXPORT_SYMBOL(pm80x_reg_read);
+
+int pm80x_reg_write(struct i2c_client *i2c, int reg,
+		     unsigned char data)
+{
+	struct regmap *map = verify_regmap(i2c);
+	int ret;
+
+	ret = regmap_write(map, reg, data);
+	return ret;
+}
+EXPORT_SYMBOL(pm80x_reg_write);
+
+int pm80x_bulk_read(struct i2c_client *i2c, int reg,
+		    int count, unsigned char *buf)
+{
+	struct regmap *map = verify_regmap(i2c);
+	int ret;
+
+	if (!map)
+		return -EINVAL;
+	ret = regmap_raw_read(map, reg, buf, count);
+
+	return ret;
+}
+EXPORT_SYMBOL(pm80x_bulk_read);
+
+int pm80x_bulk_write(struct i2c_client *i2c, int reg,
+		     int count, unsigned char *buf)
+{
+	struct regmap *map = verify_regmap(i2c);
+	int ret;
+
+	if (!map)
+		return -EINVAL;
+	ret = regmap_raw_write(map, reg, buf, count);
+
+	return ret;
+}
+EXPORT_SYMBOL(pm80x_bulk_write);
+
+int pm80x_set_bits(struct i2c_client *i2c, int reg,
+		   unsigned char mask, unsigned char data)
+{
+	struct regmap *map = verify_regmap(i2c);
+	int ret;
+
+	if (!map)
+		return -EINVAL;
+	ret = regmap_update_bits(map, reg, mask, data);
+
+	return ret;
+}
+EXPORT_SYMBOL(pm80x_set_bits);
+
+static const struct i2c_device_id pm80x_id_table[] = {
+	{"88PM80x", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
+
+static int verify_addr(struct i2c_client *i2c)
+{
+	unsigned short addr_800[] = { 0x30, 0x34 };
+	unsigned short addr_805[] = { 0x38, 0x39 };
+	int size, i;
+
+	if (i2c == NULL)
+		return 0;
+	size = ARRAY_SIZE(addr_800);
+	for (i = 0; i < size; i++) {
+		if (i2c->addr == *(addr_800 + i))
+			return CHIP_PM800;
+	}
+	size = ARRAY_SIZE(addr_805);
+	for (i = 0; i < size; i++) {
+		if (i2c->addr == *(addr_805 + i))
+			return CHIP_PM805;
+	}
+	return 0;
+}
+
+static int pm80x_pages_init(struct pm80x_chip *chip, struct i2c_client *client,
+			    struct pm80x_platform_data *pdata)
+{
+	/*
+	 * Both pm800 and pm805 shares the same platform driver.
+	 * check whether we have have pm805 driver.
+	 */
+	if (pdata->pm805_addr) {
+		chip->pm805_addr = pdata->pm805_addr;
+		/* in case we only have pm805, it already registers
+		 * i2c handle, then no need to register again.
+		 */
+		if (chip->id != CHIP_PM805) {
+			chip->client_pm805 =
+			    i2c_new_dummy(client->adapter, chip->pm805_addr);
+			chip->regmap_pm805 = devm_regmap_init_i2c(chip->client_pm805, &pm80x_regmap_config);
+			i2c_set_clientdata(chip->client_pm805, chip);
+
+			device_init_wakeup(&chip->client_pm805->dev, 1);
+		}
+		dev_info(&client->dev, "pm805_addr=0x%x\n", chip->pm805_addr);
+	} else
+		dev_info(&client->dev, "No pm805 chip\n");
+
+	if (chip->id != CHIP_PM800)
+		return 0;
+
+	/* PM800 block base 0x30 */
+	if (pdata->base_page_addr) {
+		chip->base_page_addr = pdata->base_page_addr;
+		/* do not need to register base page again */
+		chip->base_page = client;
+
+		device_init_wakeup(&client->dev, 1);
+	} else
+		dev_info(chip->dev,
+			 "PM800 block base 0x30: No base_page_addr\n");
+
+	/* PM800 block power 0x31 */
+	if (pdata->power_page_addr) {
+		chip->power_page_addr = pdata->power_page_addr;
+		chip->power_page = i2c_new_dummy(client->adapter,
+						 chip->power_page_addr);
+		chip->regmap_power = devm_regmap_init_i2c(chip->power_page, &pm80x_regmap_config);
+		i2c_set_clientdata(chip->power_page, chip);
+	} else
+		dev_info(chip->dev,
+			 "PM800 block power 0x31: No power_page_addr\n");
+
+	/* PM800 block GPADC 0x32 */
+	if (pdata->gpadc_page_addr) {
+		chip->gpadc_page_addr = pdata->gpadc_page_addr;
+		chip->gpadc_page = i2c_new_dummy(client->adapter,
+						 chip->gpadc_page_addr);
+		chip->regmap_gpadc = devm_regmap_init_i2c(chip->gpadc_page, &pm80x_regmap_config);
+		i2c_set_clientdata(chip->gpadc_page, chip);
+	} else
+		dev_info(chip->dev,
+			 "PM800 block GPADC 0x32: No gpadc_page_addr\n");
+
+	return 0;
+}
+
+static void pm80x_pages_exit(struct pm80x_chip *chip)
+{
+	if (chip->client_pm805) {
+		regmap_exit(chip->regmap_pm805);
+		i2c_unregister_device(chip->client_pm805);
+	}
+	if (chip->id != CHIP_PM800)
+		return;
+	if (chip->base_page) {
+		regmap_exit(chip->regmap_pm800);
+		i2c_unregister_device(chip->base_page);
+	}
+	if (chip->power_page) {
+		regmap_exit(chip->regmap_power);
+		i2c_unregister_device(chip->power_page);
+	}
+	if (chip->gpadc_page) {
+		regmap_exit(chip->regmap_gpadc);
+		i2c_unregister_device(chip->gpadc_page);
+	}
+}
+
+static int __devinit pm80x_probe(struct i2c_client *client,
+				 const struct i2c_device_id *id)
+{
+	struct pm80x_platform_data *pdata = client->dev.platform_data;
+	struct pm80x_chip *chip;
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
+				ret);
+		goto err_regmap_init;
+	}
+
+	chip->id = verify_addr(client);
+	if (chip->id == CHIP_PM800) {
+		chip->client_pm800 = client;
+		chip->regmap_pm800 = map;
+	}
+	else if (chip->id == CHIP_PM805) {
+		chip->client_pm805 = client;
+		chip->regmap_pm805 = map;
+	}
+	i2c_set_clientdata(client, chip);
+	chip->dev = &client->dev;
+	mutex_init(&chip->io_lock);
+	dev_set_drvdata(chip->dev, chip);
+
+	chip->irq_pm800 = pdata->irq_pm800;
+	chip->irq_pm805 = pdata->irq_pm805;
+	chip->irq_pm800_base = pdata->irq_pm800_base;
+	chip->irq_pm805_base = pdata->irq_pm805_base;
+
+	ret = pm80x_pages_init(chip, client, pdata);
+	if (ret) {
+		dev_err(&client->dev, "pm80x_pages_init failed!\n");
+		goto err_pages_init;
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
+err_pages_init:
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
+	devm_kfree(&client->dev, chip);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int pm80x_suspend(struct device *dev)
+{
+	struct pm80x_chip *chip = i2c_get_clientdata(client);
+
+	if (chip->pm805_chip && chip->wu_flag_pm805)
+		if (device_may_wakeup(&chip->client_pm805->dev))
+			enable_irq_wake(chip->irq_pm805);
+
+	if (chip->pm800_chip && chip->wu_flag_pm800)
+		if (device_may_wakeup(&chip->client_pm800->dev))
+			enable_irq_wake(chip->irq_pm800);
+
+	return 0;
+}
+
+static int pm80x_resume(struct device *dev)
+{
+	struct pm80x_chip *chip = i2c_get_clientdata(client);
+
+	if (chip->pm800_chip && chip->wu_flag_pm800)
+		if (device_may_wakeup(&chip->client_pm800->dev))
+			disable_irq_wake(chip->irq_pm800);
+
+	if (chip->pm805_chip && chip->wu_flag_pm805)
+		if (device_may_wakeup(&chip->client_pm805->dev))
+			disable_irq_wake(chip->irq_pm805);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(pm80x_pm_ops, pm80x_suspend, pm80x_resume);
+
+static struct i2c_driver pm80x_driver = {
+	.driver = {
+		   .name = "88PM80x",
+		   .owner = THIS_MODULE,
+		   .pm = &pm80x_pm_ops,
+		   },
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
index e129c82..b083111 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -20,6 +20,17 @@ config MFD_88PM860X
 	  select individual components like voltage regulators, RTC and
 	  battery-charger under the corresponding menus.
 
+config MFD_88PM80X
+	bool "Support Marvell 88PM800/88PM805"
+	depends on I2C=y && GENERIC_HARDIRQS
+	select REGMAP_I2C
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
index 0000000..49354ca
--- /dev/null
+++ b/include/linux/mfd/88pm80x.h
@@ -0,0 +1,701 @@
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
+#define PM805_INT_STATUS2		(0x04)
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
+	struct device *dev;
+	struct pm80x_chip *chip;
+	struct pm80x_platform_data *pdata;
+	struct i2c_client *client;
+	int irq;
+	int irq_base;
+	int irq_mode;
+};
+
+struct pm80x_chip {
+	/*chip_version can only on the top of the struct*/
+	unsigned char chip800_version;
+	unsigned char chip805_version;
+	struct device *dev;
+	struct pm80x_subchip *pm800_chip;
+	struct pm80x_subchip *pm805_chip;
+	struct mutex io_lock;
+	struct mutex pm800_irq_lock;
+	struct mutex pm805_irq_lock;
+	struct i2c_client *client_pm800;
+	struct i2c_client *client_pm805;
+	struct i2c_client *base_page;	/* chip client for base page */
+	struct i2c_client *power_page;	/* chip client for power page */
+	struct i2c_client *gpadc_page;	/* chip client for gpadc page */
+	struct regmap *regmap_pm800;
+	struct regmap *regmap_pm805;
+	struct regmap *regmap_power;
+	struct regmap *regmap_gpadc;
+
+	unsigned short pm800_addr;
+	unsigned short pm805_addr;
+	unsigned short base_page_addr;	/* base page I2C address */
+	unsigned short power_page_addr;	/* power page I2C address */
+	unsigned short gpadc_page_addr;	/* gpadc page I2C address */
+	int id;
+	int irq_pm800;
+	int irq_pm805;
+	int irq_pm800_base;
+	int irq_pm805_base;
+	unsigned int wu_flag_pm800;
+	unsigned int wu_flag_pm805;
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
+	int		(*sync)(unsigned int ticks);
+	int		vrtc;
+	int             rtc_wakeup;
+};
+
+struct pm80x_platform_data {
+	struct pm80x_rtc_pdata *rtc;
+	unsigned short pm800_addr;
+	unsigned short pm805_addr;
+	unsigned short base_page_addr;	/* base page I2C address */
+	unsigned short power_page_addr;	/* power page I2C address */
+	unsigned short gpadc_page_addr;	/* gpadc page I2C address */
+	unsigned short test_page_addr;	/* test page regs I2C address */
+	int i2c_port;		/* Controlled by GI2C or PI2C */
+	int irq_mode;		/* Clear interrupt by read/write(0/1) */
+	int irq_pm800;		/* IRQ of 88pm800 */
+	int irq_pm805;		/* IRQ of 88pm805 */
+	int irq_pm800_base;		/* IRQ base number of 88pm800 */
+	int irq_pm805_base;		/* IRQ base number of 88pm805 */
+	int batt_det;		/* enable/disable */
+
+	int (*pm800_plat_config)(struct pm80x_chip *chip,
+				struct pm80x_platform_data *pdata);
+	int (*pm805_plat_config)(struct pm80x_chip *chip,
+				struct pm80x_platform_data *pdata);
+};
+
+extern int pm80x_reg_read(struct i2c_client *, int);
+extern int pm80x_reg_write(struct i2c_client *, int, unsigned char);
+extern int pm80x_bulk_read(struct i2c_client *, int, int, unsigned char *);
+extern int pm80x_bulk_write(struct i2c_client *, int, int, unsigned char *);
+extern int pm80x_set_bits(struct i2c_client *, int, unsigned char,
+			  unsigned char);
+extern int pm80x_device_init(struct pm80x_chip *chip,
+			     struct pm80x_platform_data *pdata) __devinit;
+extern void pm80x_device_exit(struct pm80x_chip *chip) __devexit;
+
+extern int pm805_device_init(struct pm80x_chip *chip,
+			     struct pm80x_platform_data *pdata) __devinit;
+extern void pm805_device_exit(struct pm80x_chip *chip) __devexit;
+#endif /* __LINUX_MFD_88PM80X_H */
-- 
1.7.4.1
