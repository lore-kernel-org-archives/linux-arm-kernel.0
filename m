From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Thu, 24 Sep 2009 01:19:30 +0530
Subject: [PATCH 7/8 v2] mfd: add U8500 STw4500 SPI device support
Message-ID: <1253735370.21542.179.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

This adds core driver support for STw4500 mixed signal
multimedia & power management chip. This connects to U8500
on the SSP (pl022) bus operating in SPI protocol and exports
read/write functions for the device to get access to this chip.
This also registers the client devices and sets the parent.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
Reviewed-by: Mark Brown <broonie@sirena.org.uk>
Reviewed-by: Jean-Christophe <plagnioj@jcrosoft.com>
---
 drivers/mfd/Kconfig         |   10 ++
 drivers/mfd/Makefile        |    1 +
 drivers/mfd/stw4500.c       |  207 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/stw4500.h |  262 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 480 insertions(+), 0 deletions(-)
 create mode 100755 drivers/mfd/stw4500.c
 create mode 100644 include/linux/mfd/stw4500.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 491ac0f..8393bb5 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -256,6 +256,16 @@ config AB3100_CORE
 	  LEDs, vibrator, system power and temperature, power management
 	  and ALSA sound.
 
+config U8500_STW4500
+	tristate "ST-Ericsson U8500 Mixed Signal Power management chip"
+	depends on ARCH_U8500 && SPI
+	default y
+	help
+	  Select this option to enable access to STw4500 power management
+	  chip. This connects to U8500 on the SSP/SPI bus and exports
+	  read/write functions for the devices to get access to this chip.
+	  This chip embeds various other multimedia funtionalities as well.
+
 config EZX_PCAP
 	bool "PCAP Support"
 	depends on GENERIC_HARDIRQS && SPI_MASTER
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 6f8a9a1..9b15e52 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -44,3 +44,4 @@ obj-$(CONFIG_MFD_PCF50633)	+= pcf50633-core.o
 obj-$(CONFIG_PCF50633_ADC)	+= pcf50633-adc.o
 obj-$(CONFIG_PCF50633_GPIO)	+= pcf50633-gpio.o
 obj-$(CONFIG_AB3100_CORE)	+= ab3100-core.o
+obj-$(CONFIG_U8500_STW4500)	+= stw4500.o
diff --git a/drivers/mfd/stw4500.c b/drivers/mfd/stw4500.c
new file mode 100755
index 0000000..1876fa7
--- /dev/null
+++ b/drivers/mfd/stw4500.c
@@ -0,0 +1,207 @@
+/*
+ * Copyright (C) 2009 ST-Ericsson
+ *
+ * Author: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
+ *
+ * This program is free software; you can redistribute it
+ * and/or modify it under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation.
+ *
+ * STw4500 is a companion power management chip used with U8500.
+ * On this platform, this is interfaced with SSP0 controller
+ * which is a ARM primecell pl022.
+ *
+ * At the moment the module just exports read/write features.
+ * Interrupt management to be added - TODO.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/mfd/stw4500.h>
+
+/* just required if probe fails, we need to
+ * unregister the device
+ */
+static struct spi_driver stw4500_driver;
+
+/*
+ * This funtion writes to any STw4500 registers using
+ * SPI protocol &  before it writes it packs the data
+ * in the below 24 bit frame format
+ *
+ *	 *|------------------------------------|
+ *	 *| 23|22...18|17.......10|9|8|7......0|
+ *	 *| r/w  bank       adr          data  |
+ *	 * ------------------------------------
+ *
+ * This function shouldn't be called from interrupt
+ * context
+ */
+int stw4500_write(struct stw4500 *stw4500, unsigned char block,
+		unsigned long addr, unsigned char data)
+{
+	struct spi_transfer xfer;
+	struct spi_message	msg;
+	int err;
+	unsigned long spi_data =
+		block << 18 | addr << 10 | data;
+
+	stw4500->tx_buf[0] = spi_data;
+	stw4500->rx_buf[0] = 0;
+
+	xfer.tx_buf	= stw4500->tx_buf;
+	xfer.rx_buf 	= NULL;
+	xfer.len	= sizeof(unsigned long);
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+
+	mutex_lock(&stw4500->lock);
+	err = spi_sync(stw4500->spi, &msg);
+	mutex_unlock(&stw4500->lock);
+
+	return err;
+}
+EXPORT_SYMBOL(stw4500_write);
+
+int stw4500_read(struct stw4500 *stw4500, unsigned char block,
+		unsigned long addr)
+{
+	struct spi_transfer xfer;
+	struct spi_message	msg;
+	unsigned long spi_data =
+		1 << 23 | block << 18 | addr << 10;
+
+	stw4500->tx_buf[0] = spi_data;
+	stw4500->rx_buf[0] = 0;
+
+	xfer.tx_buf	= stw4500->tx_buf;
+	xfer.rx_buf 	= stw4500->rx_buf;
+	xfer.len	= sizeof(unsigned long);
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+
+	mutex_lock(&stw4500->lock);
+	spi_sync(stw4500->spi, &msg);
+	mutex_unlock(&stw4500->lock);
+
+	return  stw4500->rx_buf[0];
+}
+EXPORT_SYMBOL(stw4500_read);
+
+/* ref: ab3100 core */
+#define STW4500_DEVICE(devname, devid)				\
+static struct platform_device stw4500_##devname##_device = {	\
+	.name	= devid,					\
+	.id	= -1,						\
+}
+
+/* list of childern devices of stw4500 - all are
+ * not populated here - TODO
+ */
+STW4500_DEVICE(charger, "stw4500-charger");
+STW4500_DEVICE(audio, "stw4500-audio");
+STW4500_DEVICE(usb, "stw4500-usb");
+STW4500_DEVICE(tvout, "stw4500-tvout");
+STW4500_DEVICE(sim, "stw4500-sim");
+STW4500_DEVICE(gpadc, "stw4500-gpadc");
+STW4500_DEVICE(clkmgt, "stw4500-clkmgt");
+STW4500_DEVICE(misc, "stw4500-misc");
+
+static struct platform_device *stw4500_platform_devs[] = {
+	&stw4500_charger_device,
+	&stw4500_audio_device,
+	&stw4500_usb_device,
+	&stw4500_tvout_device,
+	&stw4500_sim_device,
+	&stw4500_gpadc_device,
+	&stw4500_clkmgt_device,
+	&stw4500_misc_device,
+};
+
+static int __init stw4500_probe(struct spi_device *spi)
+{
+	struct stw4500	*stw4500;
+	unsigned char revision;
+	int err = 0;
+	int i;
+
+	stw4500 = kzalloc(sizeof *stw4500, GFP_KERNEL);
+	if (!stw4500) {
+		dev_err(&spi->dev, "could not allocate STw4500\n");
+		err = -ENOMEM;
+		goto not_detect;
+	}
+
+	stw4500->spi = spi;
+	spi_set_drvdata(spi, stw4500);
+
+	mutex_init(&stw4500->lock);
+
+	/* read the revision register */
+	revision = stw4500_read(stw4500, STW4500_MISC, STW4500_REV_REG);
+
+	/* revision id 0x0 is for early drop, 0x10 is for cut1.0 */
+	if (revision == 0x0 || revision == 0x10)
+		dev_info(&spi->dev, "Detected chip: %s, revision = %x\n",
+			stw4500_driver.driver.name, revision);
+	else	{
+		dev_err(&spi->dev, "unknown chip: 0x%x\n", revision);
+		goto not_detect;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(stw4500_platform_devs); i++)	{
+		stw4500_platform_devs[i]->dev.parent =
+			&spi->dev;
+		platform_set_drvdata(stw4500_platform_devs[i], stw4500);
+	}
+
+	/* register the stw4500 platform devices */
+	platform_add_devices(stw4500_platform_devs,
+			ARRAY_SIZE(stw4500_platform_devs));
+
+	return err;
+
+ not_detect:
+	spi_unregister_driver(&stw4500_driver);
+	kfree(stw4500);
+	return err;
+}
+
+static int __devexit stw4500_remove(struct spi_device *spi)
+{
+	struct stw4500 *stw4500 =
+		spi_get_drvdata(spi);
+
+	kfree(stw4500);
+
+	return 0;
+}
+
+static struct spi_driver stw4500_driver = {
+	.driver = {
+		.name = "stw4500",
+		.owner = THIS_MODULE,
+	},
+	.probe = stw4500_probe,
+	.remove = __devexit_p(stw4500_remove)
+};
+
+static int __devinit stw4500_init(void)
+{
+	return spi_register_driver(&stw4500_driver);
+}
+
+static void __exit stw4500_exit(void)
+{
+	spi_unregister_driver(&stw4500_driver);
+}
+
+subsys_initcall_sync(stw4500_init);
+
+MODULE_AUTHOR("Srinidhi KASAGAR <srinidhi.kasagar at stericsson.com");
+MODULE_DESCRIPTION("STw4500 core driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/stw4500.h b/include/linux/mfd/stw4500.h
new file mode 100644
index 0000000..40d4737
--- /dev/null
+++ b/include/linux/mfd/stw4500.h
@@ -0,0 +1,262 @@
+/*
+ * Copyright (C) 2009 ST-Ericsson
+ *
+ * Author: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ * STW4500 device core funtions, for client access
+ */
+#ifndef MFD_STW4500_H
+#define MFD_STW4500_H
+
+#include <linux/device.h>
+
+/*
+ * STW4500 bank addresses
+ */
+#define STW4500_SYS_CTRL1_BLOCK	0x1
+#define STW4500_SYS_CTRL2_BLOCK	0x2
+#define STW4500_REGU_CTRL1	0x3
+#define STW4500_REGU_CTRL2	0x4
+#define STW4500_USB		0x5
+#define STW4500_TVOUT		0x6
+#define STW4500_DBI		0x7
+#define STW4500_ECI_AV_ACC	0x8
+#define STW4500_RESERVED	0x9
+#define STw4550_GPADC		0xA
+#define STW4500_CHARGER		0xB
+#define STW4500_GAS_GAUGE	0xC
+#define STW4500_AUDIO		0xD
+#define STW4500_INTERRUPT	0xE
+#define STW4500_RTC		0xF
+#define STW4500_MISC		0x10
+#define STW4500_DEBUG		0x12
+#define STW4500_PROD_TEST	0x13
+#define STW4500_OTP_EMUL	0x15
+
+/*
+ * System control 1 register offsets.
+ * Bank = 0x01
+ */
+#define STW4500_TURNON_STAT_REG		0x0100
+#define STW4500_RESET_STAT_REG		0x0101
+#define STW4500_PONKEY1_PRESS_STAT_REG	0x0102
+
+#define STW4500_FSM_STAT1_REG		0x0140
+#define STW4500_FSM_STAT2_REG		0x0141
+#define STW4500_SYSCLK_REQ_STAT_REG	0x0142
+#define STW4500_USB_STAT1_REG		0x0143
+#define STW4500_USB_STAT2_REG		0x0144
+#define STW4500_STATUS_SPARE1_REG	0x0145
+#define STW4500_STATUS_SPARE2_REG	0x0146
+
+#define STW4500_CTRL1_REG		0x0180
+#define STW4500_CTRL2_REG		0x0181
+
+/*
+ * System control 2 register offsets.
+ * bank = 0x02
+ */
+#define STW4500_CTRL3_REG		0x0200
+#define STW4500_MAIN_WDOG_CTRL_REG	0x0201
+#define STW4500_MAIN_WDOG_TIMER_REG	0x0202
+#define STW4500_LOW_BAT_REG		0x0203
+#define STW4500_BATT_OK_REG		0x0204
+#define STW4500_SYSCLK_TIMER_REG	0x0205
+#define STW4500_SMPSCLK_CTRL_REG	0x0206
+#define STW4500_SMPSCLK_SEL1_REG	0x0207
+#define STW4500_SMPSCLK_SEL2_REG	0x0208
+#define STW4500_SMPSCLK_SEL3_REG	0x0209
+#define STW4500_SYSULPCLK_CONF_REG	0x020A
+#define STW4500_SYSULPCLK_CTRL1_REG	0x020B
+#define STW4500_SYSCLK_CTRL_REG		0x020C
+#define STW4500_SYSCLK_REQ1_VALID_REG	0x020D
+#define STW4500_SYSCLK_REQ_VALID_REG	0x020E
+#define STW4500_SYSCTRL_SPARE_REG	0x020F
+#define STW4500_PAD_CONF_REG		0x0210
+
+/*
+ * Regu control1 register offsets
+ * Bank = 0x03
+ */
+#define STW4500_REGU_SERIAL_CTRL1_REG	0x0300
+#define STW4500_REGU_SERIAL_CTRL2_REG	0x0301
+#define STW4500_REGU_SERIAL_CTRL3_REG	0x0302
+#define STW4500_REGU_REQ_CTRL1_REG	0x0303
+#define STW4500_REGU_REQ_CTRL2_REG	0x0304
+#define STW4500_REGU_REQ_CTRL3_REG	0x0305
+#define STW4500_REGU_REQ_CTRL4_REG	0x0306
+#define STW4500_REGU_MISC1_REG		0x0380
+#define STW4500_REGU_OTGSUPPLY_CTRL_REG	0x0381
+#define STW4500_REGU_VUSB_CTRL_REG	0x0382
+#define STW4500_REGU_VAUDIO_SUPPLY_REG	0x0383
+#define STW4500_REGU_CTRL1_SPARE_REG	0x0384
+
+/*
+ * Regu control2 Vmod register offsets
+ */
+#define STW4500_REGU_VMOD_REGU_REG	0x0440
+#define STW4500_REGU_VMOD_SEL1_REG	0x0441
+#define STW4500_REGU_VMOD_SEL2_REG	0x0442
+#define STW4500_REGU_CTRL_DISCH_REG	0x0443
+#define STW4500_REGU_CTRL_DISCH2_REG	0x0444
+
+/*
+ * USB/ULPI register offsets
+ * Bank : 0x5
+ */
+#define STW4500_USB_LINE_STAT_REG	0x0580
+#define STW4500_USB_LINE_CTRL1_REG	0x0581
+#define STW4500_USB_LINE_CTRL2_REG	0x0582
+#define STW4500_USB_LINE_CTRL3_REG	0x0583
+#define STW4500_USB_LINE_CTRL4_REG	0x0584
+#define STW4500_USB_LINE_CTRL5_REG	0x0585
+#define STW4500_USB_OTG_CTRL_REG	0x0587
+#define STW4500_USB_OTG_STAT_REG	0x0588
+#define STW4500_USB_OTG_STAT_REG	0x0588
+#define STW4500_USB_CTRL_SPARE_REG	0x0589
+#define STW4500_USB_PHY_CTRL_REG	0x058A
+
+/*
+ * TVOUT / CTRL register offsets
+ * Bank : 0x06
+ */
+#define STW4500_TVOUT_CTRL_REG		0x0680
+
+/*
+ * DBI register offsets
+ * Bank : 0x07
+ */
+#define STW4500_DBI_REG1_REG		0x0700
+#define STW4500_DBI_REG2_REG		0x0701
+
+/*
+ * ECI regsiter offsets
+ * Bank : 0x08
+ */
+#define STW4500_ECI_CTRL_REG		0x0800
+#define STW4500_ECI_HOOKLEVEL_REG	0x0801
+#define STW4500_ECI_DATAOUT_REG		0x0802
+#define STW4500_ECI_DATAIN_REG		0x0803
+
+/*
+ * AV Connector register offsets
+ * Bank : 0x08
+ */
+#define STW4500_AV_CONN_REG		0x0840
+
+/*
+ * Accessory detection register offsets
+ * Bank : 0x08
+ */
+#define STW4500_ACC_DET_DB1_REG		0x0880
+#define STW4500_ACC_DET_DB2_REG		0x0881
+
+/*
+ * GPADC register offsets
+ * Bank : 0x0A
+ */
+#define STW4500_GPADC_CTRL1_REG		0x0A00
+#define STW4500_GPADC_CTRL2_REG		0x0A01
+#define STW4500_GPADC_CTRL3_REG		0x0A02
+#define STW4500_GPADC_AUTO_TIMER_REG	0x0A03
+#define STW4500_GPADC_STAT_REG		0x0A04
+#define STW4500_GPADC_MANDATAL_REG	0x0A05
+#define STW4500_GPADC_MANDATAH_REG	0x0A06
+#define STW4500_GPADC_AUTODATAL_REG	0x0A07
+#define STW4500_GPADC_AUTODATAH_REG	0x0A08
+#define STW4500_GPADC_MUX_CTRL_REG	0x0A09
+
+/*
+ * Charger / status register offfsets
+ * Bank : 0x0B
+ */
+#define STW4500_CH_STATUS1_REG		0x0B00
+#define STW4500_CH_STATUS2_REG		0x0B01
+#define STW4500_CH_USBCH_STAT1_REG	0x0B02
+#define STW4500_CH_USBCH_STAT2_REG	0x0B03
+#define STW4500_CH_FSM_STAT_REG		0x0B04
+#define STW4500_CH_STAT_REG		0x0B05
+
+/*
+ * Charger / control register offfsets
+ * Bank : 0x0B
+ */
+#define STW4500_CH_VOLT_LVL_REG		0x0B40
+
+/*
+ * Charger / main control register offfsets
+ * Bank : 0x0B
+ */
+#define STW4500_MCH_CTRL1		0x0B80
+#define STW4500_MCH_CTRL2		0x0B81
+#define STW4500_MCH_IPT_CURLVL_REG	0x0B82
+#define STW4500_CH_WD_REG		0x0B83
+
+/*
+ * Charger / USB control register offsets
+ * Bank : 0x0B
+ */
+#define STW4500_USBCH_CTRL1_REG		0x0BC0
+#define STW4500_USBCH_CTRL2_REG		0x0BC1
+#define STW4500_USBCH_IPT_CRNTLVL_REG	0x0BC2
+
+/*
+ * RTC bank register offsets
+ * Bank : 0xF
+ */
+#define STW4500_RTC_SOFF_STAT_REG	0x0F00
+#define STW4500_RTC_CC_CONF_REG		0x0F01
+#define STW4500_RTC_READ_REQ_REG	0x0F02
+#define STW4500_RTC_WATCH_TSECMID_REG	0x0F03
+#define STW4500_RTC_WATCH_TSECHI_REG	0x0F04
+#define STW4500_RTC_WATCH_TMIN_LOW_REG	0x0F05
+#define STW4500_RTC_WATCH_TMIN_MID_REG	0x0F06
+#define STW4500_RTC_WATCH_TMIN_HI_REG	0x0F07
+#define STW4500_RTC_ALRM_MIN_LOW_REG	0x0F08
+#define STW4500_RTC_ALRM_MIN_MID_REG	0x0F09
+#define STW4500_RTC_ALRM_MIN_HI_REG	0x0F0A
+#define STW4500_RTC_STAT_REG		0x0F0B
+#define STW4500_RTC_BKUP_CHG_REG	0x0F0C
+#define STW4500_RTC_FORCE_BKUP_REG	0x0F0D
+#define STW4500_RTC_CALIB_REG		0x0F0E
+#define STW4500_RTC_SWITCH_STAT_REG	0x0F0F
+
+/*
+ * PWM Out generators
+ * Bank: 0x10
+ */
+#define STW4500_PWM_OUT_CTRL1_REG	0x1060
+#define STW4500_PWM_OUT_CTRL2_REG	0x1061
+#define STW4500_PWM_OUT_CTRL3_REG	0x1062
+#define STW4500_PWM_OUT_CTRL4_REG	0x1063
+#define STW4500_PWM_OUT_CTRL5_REG	0x1064
+#define STW4500_PWM_OUT_CTRL6_REG	0x1065
+#define STW4500_PWM_OUT_CTRL7_REG	0x1066
+
+#define STW4500_I2C_PAD_CTRL_REG	0x1067
+#define STW4500_REV_REG			0x1080
+
+/**
+ * struct stw4500
+ * @spi: spi device structure
+ * @tx_buf: transmit buffer
+ * @rx_buf: receive buffer
+ * @lock: sync primitive
+ */
+struct stw4500 {
+	struct spi_device	*spi;
+	unsigned long		tx_buf[4];
+	unsigned long		rx_buf[4];
+	struct mutex		lock;
+};
+
+int stw4500_write(struct stw4500 *stw4500, unsigned char block,
+		unsigned long addr, unsigned char data);
+int stw4500_read(struct stw4500 *stw4500, unsigned char block,
+		unsigned long addr);
+
+#endif /* MFD_STW4500_H */
-- 
1.6.3.GIT
