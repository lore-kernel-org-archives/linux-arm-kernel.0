From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 12 Oct 2009 18:33:22 +0200
Subject: [PATCH v3 7/7] mfd: add AB4500 SPI used in U8500
In-Reply-To: <1255300105.21542.415.camel@vinay-desktop>
References: <1255300105.21542.415.camel@vinay-desktop>
Message-ID: <20091012163321.GB20786@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinidhi,

On Mon, Oct 12, 2009 at 03:58:25AM +0530, srinidhi kasagar wrote:
> From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> 
> This adds core driver support for AB4500 mixed signal
> multimedia & power management chip. This connects to U8500
> on the SSP (pl022) and exports read/write functions for
> the device to get access to this chip. This also registers
> the client devices and sets the parent.
> 
> The chip is now called as AB4500, whereas in the older version
> it was called as STW4500. This just renames stw4500 as ab4500.
Path applied to my for-next branch, thanks.
I had to apply a build fix for this driver as it wouldnt build as a module.
See:
http://git.kernel.org/?p=linux/kernel/git/sameo/mfd-2.6.git;a=commit;h=2c7ddb89e5fb17723198cf7e67c80a324d1d9784

Cheers,
Samuel.


> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
> Reviewed-by: Mark Brown <broonie@sirena.org.uk>
> Reviewed-by: Jean-Christophe <plagnioj@jcrosoft.com>
> ---
>  drivers/mfd/Kconfig        |   10 ++
>  drivers/mfd/Makefile       |    1 +
>  drivers/mfd/ab4500-core.c  |  207 ++++++++++++++++++++++++++++++++++
>  include/linux/mfd/ab4500.h |  262 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 480 insertions(+), 0 deletions(-)
>  create mode 100755 drivers/mfd/ab4500-core.c
>  create mode 100644 include/linux/mfd/ab4500.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 570be13..4b2c97d 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -305,6 +305,16 @@ config EZX_PCAP
>  	  This enables the PCAP ASIC present on EZX Phones. This is
>  	  needed for MMC, TouchScreen, Sound, USB, etc..
>  
> +config AB4500_CORE
> +	tristate "ST-Ericsson's AB4500 Mixed Signal Power management chip"
> +	depends on SPI
> +	default y
> +	help
> +	  Select this option to enable access to AB4500 power management
> +	  chip. This connects to U8500 on the SSP/SPI bus and exports
> +	  read/write functions for the devices to get access to this chip.
> +	  This chip embeds various other multimedia funtionalities as well.
> +
>  endmenu
>  
>  menu "Multimedia Capabilities Port drivers"
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f3b277b..0d98968 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -50,3 +50,4 @@ obj-$(CONFIG_PCF50633_ADC)	+= pcf50633-adc.o
>  obj-$(CONFIG_PCF50633_GPIO)	+= pcf50633-gpio.o
>  obj-$(CONFIG_AB3100_CORE)	+= ab3100-core.o
>  obj-$(CONFIG_AB3100_OTP)	+= ab3100-otp.o
> +obj-$(CONFIG_AB4500_CORE)	+= ab4500-core.o
> diff --git a/drivers/mfd/ab4500-core.c b/drivers/mfd/ab4500-core.c
> new file mode 100755
> index 0000000..3ad91f7
> --- /dev/null
> +++ b/drivers/mfd/ab4500-core.c
> @@ -0,0 +1,207 @@
> +/*
> + * Copyright (C) 2009 ST-Ericsson
> + *
> + * Author: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
> + *
> + * This program is free software; you can redistribute it
> + * and/or modify it under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation.
> + *
> + * AB4500 is a companion power management chip used with U8500.
> + * On this platform, this is interfaced with SSP0 controller
> + * which is a ARM primecell pl022.
> + *
> + * At the moment the module just exports read/write features.
> + * Interrupt management to be added - TODO.
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/mfd/ab4500.h>
> +
> +/* just required if probe fails, we need to
> + * unregister the device
> + */
> +static struct spi_driver ab4500_driver;
> +
> +/*
> + * This funtion writes to any AB4500 registers using
> + * SPI protocol &  before it writes it packs the data
> + * in the below 24 bit frame format
> + *
> + *	 *|------------------------------------|
> + *	 *| 23|22...18|17.......10|9|8|7......0|
> + *	 *| r/w  bank       adr          data  |
> + *	 * ------------------------------------
> + *
> + * This function shouldn't be called from interrupt
> + * context
> + */
> +int ab4500_write(struct ab4500 *ab4500, unsigned char block,
> +		unsigned long addr, unsigned char data)
> +{
> +	struct spi_transfer xfer;
> +	struct spi_message	msg;
> +	int err;
> +	unsigned long spi_data =
> +		block << 18 | addr << 10 | data;
> +
> +	mutex_lock(&ab4500->lock);
> +	ab4500->tx_buf[0] = spi_data;
> +	ab4500->rx_buf[0] = 0;
> +
> +	xfer.tx_buf	= ab4500->tx_buf;
> +	xfer.rx_buf 	= NULL;
> +	xfer.len	= sizeof(unsigned long);
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +
> +	err = spi_sync(ab4500->spi, &msg);
> +	mutex_unlock(&ab4500->lock);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(ab4500_write);
> +
> +int ab4500_read(struct ab4500 *ab4500, unsigned char block,
> +		unsigned long addr)
> +{
> +	struct spi_transfer xfer;
> +	struct spi_message	msg;
> +	unsigned long spi_data =
> +		1 << 23 | block << 18 | addr << 10;
> +
> +	mutex_lock(&ab4500->lock);
> +	ab4500->tx_buf[0] = spi_data;
> +	ab4500->rx_buf[0] = 0;
> +
> +	xfer.tx_buf	= ab4500->tx_buf;
> +	xfer.rx_buf 	= ab4500->rx_buf;
> +	xfer.len	= sizeof(unsigned long);
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +
> +	spi_sync(ab4500->spi, &msg);
> +	mutex_unlock(&ab4500->lock);
> +
> +	return  ab4500->rx_buf[0];
> +}
> +EXPORT_SYMBOL(ab4500_read);
> +
> +/* ref: ab3100 core */
> +#define AB4500_DEVICE(devname, devid)				\
> +static struct platform_device ab4500_##devname##_device = {	\
> +	.name	= devid,					\
> +	.id	= -1,						\
> +}
> +
> +/* list of childern devices of ab4500 - all are
> + * not populated here - TODO
> + */
> +AB4500_DEVICE(charger, "ab4500-charger");
> +AB4500_DEVICE(audio, "ab4500-audio");
> +AB4500_DEVICE(usb, "ab4500-usb");
> +AB4500_DEVICE(tvout, "ab4500-tvout");
> +AB4500_DEVICE(sim, "ab4500-sim");
> +AB4500_DEVICE(gpadc, "ab4500-gpadc");
> +AB4500_DEVICE(clkmgt, "ab4500-clkmgt");
> +AB4500_DEVICE(misc, "ab4500-misc");
> +
> +static struct platform_device *ab4500_platform_devs[] = {
> +	&ab4500_charger_device,
> +	&ab4500_audio_device,
> +	&ab4500_usb_device,
> +	&ab4500_tvout_device,
> +	&ab4500_sim_device,
> +	&ab4500_gpadc_device,
> +	&ab4500_clkmgt_device,
> +	&ab4500_misc_device,
> +};
> +
> +static int __init ab4500_probe(struct spi_device *spi)
> +{
> +	struct ab4500	*ab4500;
> +	unsigned char revision;
> +	int err = 0;
> +	int i;
> +
> +	ab4500 = kzalloc(sizeof *ab4500, GFP_KERNEL);
> +	if (!ab4500) {
> +		dev_err(&spi->dev, "could not allocate AB4500\n");
> +		err = -ENOMEM;
> +		goto not_detect;
> +	}
> +
> +	ab4500->spi = spi;
> +	spi_set_drvdata(spi, ab4500);
> +
> +	mutex_init(&ab4500->lock);
> +
> +	/* read the revision register */
> +	revision = ab4500_read(ab4500, AB4500_MISC, AB4500_REV_REG);
> +
> +	/* revision id 0x0 is for early drop, 0x10 is for cut1.0 */
> +	if (revision == 0x0 || revision == 0x10)
> +		dev_info(&spi->dev, "Detected chip: %s, revision = %x\n",
> +			ab4500_driver.driver.name, revision);
> +	else	{
> +		dev_err(&spi->dev, "unknown chip: 0x%x\n", revision);
> +		goto not_detect;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(ab4500_platform_devs); i++)	{
> +		ab4500_platform_devs[i]->dev.parent =
> +			&spi->dev;
> +		platform_set_drvdata(ab4500_platform_devs[i], ab4500);
> +	}
> +
> +	/* register the ab4500 platform devices */
> +	platform_add_devices(ab4500_platform_devs,
> +			ARRAY_SIZE(ab4500_platform_devs));
> +
> +	return err;
> +
> + not_detect:
> +	spi_unregister_driver(&ab4500_driver);
> +	kfree(ab4500);
> +	return err;
> +}
> +
> +static int __devexit ab4500_remove(struct spi_device *spi)
> +{
> +	struct ab4500 *ab4500 =
> +		spi_get_drvdata(spi);
> +
> +	kfree(ab4500);
> +
> +	return 0;
> +}
> +
> +static struct spi_driver ab4500_driver = {
> +	.driver = {
> +		.name = "ab4500",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = ab4500_probe,
> +	.remove = __devexit_p(ab4500_remove)
> +};
> +
> +static int __devinit ab4500_init(void)
> +{
> +	return spi_register_driver(&ab4500_driver);
> +}
> +
> +static void __exit ab4500_exit(void)
> +{
> +	spi_unregister_driver(&ab4500_driver);
> +}
> +
> +subsys_initcall_sync(ab4500_init);
> +
> +MODULE_AUTHOR("Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com");
> +MODULE_DESCRIPTION("AB4500 core driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/ab4500.h b/include/linux/mfd/ab4500.h
> new file mode 100644
> index 0000000..a42a703
> --- /dev/null
> +++ b/include/linux/mfd/ab4500.h
> @@ -0,0 +1,262 @@
> +/*
> + * Copyright (C) 2009 ST-Ericsson
> + *
> + * Author: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2, as
> + * published by the Free Software Foundation.
> + *
> + * AB4500 device core funtions, for client access
> + */
> +#ifndef MFD_AB4500_H
> +#define MFD_AB4500_H
> +
> +#include <linux/device.h>
> +
> +/*
> + * AB4500 bank addresses
> + */
> +#define AB4500_SYS_CTRL1_BLOCK	0x1
> +#define AB4500_SYS_CTRL2_BLOCK	0x2
> +#define AB4500_REGU_CTRL1	0x3
> +#define AB4500_REGU_CTRL2	0x4
> +#define AB4500_USB		0x5
> +#define AB4500_TVOUT		0x6
> +#define AB4500_DBI		0x7
> +#define AB4500_ECI_AV_ACC	0x8
> +#define AB4500_RESERVED		0x9
> +#define AB4500_GPADC		0xA
> +#define AB4500_CHARGER		0xB
> +#define AB4500_GAS_GAUGE	0xC
> +#define AB4500_AUDIO		0xD
> +#define AB4500_INTERRUPT	0xE
> +#define AB4500_RTC		0xF
> +#define AB4500_MISC		0x10
> +#define AB4500_DEBUG		0x12
> +#define AB4500_PROD_TEST	0x13
> +#define AB4500_OTP_EMUL		0x15
> +
> +/*
> + * System control 1 register offsets.
> + * Bank = 0x01
> + */
> +#define AB4500_TURNON_STAT_REG		0x0100
> +#define AB4500_RESET_STAT_REG		0x0101
> +#define AB4500_PONKEY1_PRESS_STAT_REG	0x0102
> +
> +#define AB4500_FSM_STAT1_REG		0x0140
> +#define AB4500_FSM_STAT2_REG		0x0141
> +#define AB4500_SYSCLK_REQ_STAT_REG	0x0142
> +#define AB4500_USB_STAT1_REG		0x0143
> +#define AB4500_USB_STAT2_REG		0x0144
> +#define AB4500_STATUS_SPARE1_REG	0x0145
> +#define AB4500_STATUS_SPARE2_REG	0x0146
> +
> +#define AB4500_CTRL1_REG		0x0180
> +#define AB4500_CTRL2_REG		0x0181
> +
> +/*
> + * System control 2 register offsets.
> + * bank = 0x02
> + */
> +#define AB4500_CTRL3_REG		0x0200
> +#define AB4500_MAIN_WDOG_CTRL_REG	0x0201
> +#define AB4500_MAIN_WDOG_TIMER_REG	0x0202
> +#define AB4500_LOW_BAT_REG		0x0203
> +#define AB4500_BATT_OK_REG		0x0204
> +#define AB4500_SYSCLK_TIMER_REG		0x0205
> +#define AB4500_SMPSCLK_CTRL_REG		0x0206
> +#define AB4500_SMPSCLK_SEL1_REG		0x0207
> +#define AB4500_SMPSCLK_SEL2_REG		0x0208
> +#define AB4500_SMPSCLK_SEL3_REG		0x0209
> +#define AB4500_SYSULPCLK_CONF_REG	0x020A
> +#define AB4500_SYSULPCLK_CTRL1_REG	0x020B
> +#define AB4500_SYSCLK_CTRL_REG		0x020C
> +#define AB4500_SYSCLK_REQ1_VALID_REG	0x020D
> +#define AB4500_SYSCLK_REQ_VALID_REG	0x020E
> +#define AB4500_SYSCTRL_SPARE_REG	0x020F
> +#define AB4500_PAD_CONF_REG		0x0210
> +
> +/*
> + * Regu control1 register offsets
> + * Bank = 0x03
> + */
> +#define AB4500_REGU_SERIAL_CTRL1_REG	0x0300
> +#define AB4500_REGU_SERIAL_CTRL2_REG	0x0301
> +#define AB4500_REGU_SERIAL_CTRL3_REG	0x0302
> +#define AB4500_REGU_REQ_CTRL1_REG	0x0303
> +#define AB4500_REGU_REQ_CTRL2_REG	0x0304
> +#define AB4500_REGU_REQ_CTRL3_REG	0x0305
> +#define AB4500_REGU_REQ_CTRL4_REG	0x0306
> +#define AB4500_REGU_MISC1_REG		0x0380
> +#define AB4500_REGU_OTGSUPPLY_CTRL_REG	0x0381
> +#define AB4500_REGU_VUSB_CTRL_REG	0x0382
> +#define AB4500_REGU_VAUDIO_SUPPLY_REG	0x0383
> +#define AB4500_REGU_CTRL1_SPARE_REG	0x0384
> +
> +/*
> + * Regu control2 Vmod register offsets
> + */
> +#define AB4500_REGU_VMOD_REGU_REG	0x0440
> +#define AB4500_REGU_VMOD_SEL1_REG	0x0441
> +#define AB4500_REGU_VMOD_SEL2_REG	0x0442
> +#define AB4500_REGU_CTRL_DISCH_REG	0x0443
> +#define AB4500_REGU_CTRL_DISCH2_REG	0x0444
> +
> +/*
> + * USB/ULPI register offsets
> + * Bank : 0x5
> + */
> +#define AB4500_USB_LINE_STAT_REG	0x0580
> +#define AB4500_USB_LINE_CTRL1_REG	0x0581
> +#define AB4500_USB_LINE_CTRL2_REG	0x0582
> +#define AB4500_USB_LINE_CTRL3_REG	0x0583
> +#define AB4500_USB_LINE_CTRL4_REG	0x0584
> +#define AB4500_USB_LINE_CTRL5_REG	0x0585
> +#define AB4500_USB_OTG_CTRL_REG		0x0587
> +#define AB4500_USB_OTG_STAT_REG		0x0588
> +#define AB4500_USB_OTG_STAT_REG		0x0588
> +#define AB4500_USB_CTRL_SPARE_REG	0x0589
> +#define AB4500_USB_PHY_CTRL_REG		0x058A
> +
> +/*
> + * TVOUT / CTRL register offsets
> + * Bank : 0x06
> + */
> +#define AB4500_TVOUT_CTRL_REG		0x0680
> +
> +/*
> + * DBI register offsets
> + * Bank : 0x07
> + */
> +#define AB4500_DBI_REG1_REG		0x0700
> +#define AB4500_DBI_REG2_REG		0x0701
> +
> +/*
> + * ECI regsiter offsets
> + * Bank : 0x08
> + */
> +#define AB4500_ECI_CTRL_REG		0x0800
> +#define AB4500_ECI_HOOKLEVEL_REG	0x0801
> +#define AB4500_ECI_DATAOUT_REG		0x0802
> +#define AB4500_ECI_DATAIN_REG		0x0803
> +
> +/*
> + * AV Connector register offsets
> + * Bank : 0x08
> + */
> +#define AB4500_AV_CONN_REG		0x0840
> +
> +/*
> + * Accessory detection register offsets
> + * Bank : 0x08
> + */
> +#define AB4500_ACC_DET_DB1_REG		0x0880
> +#define AB4500_ACC_DET_DB2_REG		0x0881
> +
> +/*
> + * GPADC register offsets
> + * Bank : 0x0A
> + */
> +#define AB4500_GPADC_CTRL1_REG		0x0A00
> +#define AB4500_GPADC_CTRL2_REG		0x0A01
> +#define AB4500_GPADC_CTRL3_REG		0x0A02
> +#define AB4500_GPADC_AUTO_TIMER_REG	0x0A03
> +#define AB4500_GPADC_STAT_REG		0x0A04
> +#define AB4500_GPADC_MANDATAL_REG	0x0A05
> +#define AB4500_GPADC_MANDATAH_REG	0x0A06
> +#define AB4500_GPADC_AUTODATAL_REG	0x0A07
> +#define AB4500_GPADC_AUTODATAH_REG	0x0A08
> +#define AB4500_GPADC_MUX_CTRL_REG	0x0A09
> +
> +/*
> + * Charger / status register offfsets
> + * Bank : 0x0B
> + */
> +#define AB4500_CH_STATUS1_REG		0x0B00
> +#define AB4500_CH_STATUS2_REG		0x0B01
> +#define AB4500_CH_USBCH_STAT1_REG	0x0B02
> +#define AB4500_CH_USBCH_STAT2_REG	0x0B03
> +#define AB4500_CH_FSM_STAT_REG		0x0B04
> +#define AB4500_CH_STAT_REG		0x0B05
> +
> +/*
> + * Charger / control register offfsets
> + * Bank : 0x0B
> + */
> +#define AB4500_CH_VOLT_LVL_REG		0x0B40
> +
> +/*
> + * Charger / main control register offfsets
> + * Bank : 0x0B
> + */
> +#define AB4500_MCH_CTRL1		0x0B80
> +#define AB4500_MCH_CTRL2		0x0B81
> +#define AB4500_MCH_IPT_CURLVL_REG	0x0B82
> +#define AB4500_CH_WD_REG		0x0B83
> +
> +/*
> + * Charger / USB control register offsets
> + * Bank : 0x0B
> + */
> +#define AB4500_USBCH_CTRL1_REG		0x0BC0
> +#define AB4500_USBCH_CTRL2_REG		0x0BC1
> +#define AB4500_USBCH_IPT_CRNTLVL_REG	0x0BC2
> +
> +/*
> + * RTC bank register offsets
> + * Bank : 0xF
> + */
> +#define AB4500_RTC_SOFF_STAT_REG	0x0F00
> +#define AB4500_RTC_CC_CONF_REG		0x0F01
> +#define AB4500_RTC_READ_REQ_REG		0x0F02
> +#define AB4500_RTC_WATCH_TSECMID_REG	0x0F03
> +#define AB4500_RTC_WATCH_TSECHI_REG	0x0F04
> +#define AB4500_RTC_WATCH_TMIN_LOW_REG	0x0F05
> +#define AB4500_RTC_WATCH_TMIN_MID_REG	0x0F06
> +#define AB4500_RTC_WATCH_TMIN_HI_REG	0x0F07
> +#define AB4500_RTC_ALRM_MIN_LOW_REG	0x0F08
> +#define AB4500_RTC_ALRM_MIN_MID_REG	0x0F09
> +#define AB4500_RTC_ALRM_MIN_HI_REG	0x0F0A
> +#define AB4500_RTC_STAT_REG		0x0F0B
> +#define AB4500_RTC_BKUP_CHG_REG		0x0F0C
> +#define AB4500_RTC_FORCE_BKUP_REG	0x0F0D
> +#define AB4500_RTC_CALIB_REG		0x0F0E
> +#define AB4500_RTC_SWITCH_STAT_REG	0x0F0F
> +
> +/*
> + * PWM Out generators
> + * Bank: 0x10
> + */
> +#define AB4500_PWM_OUT_CTRL1_REG	0x1060
> +#define AB4500_PWM_OUT_CTRL2_REG	0x1061
> +#define AB4500_PWM_OUT_CTRL3_REG	0x1062
> +#define AB4500_PWM_OUT_CTRL4_REG	0x1063
> +#define AB4500_PWM_OUT_CTRL5_REG	0x1064
> +#define AB4500_PWM_OUT_CTRL6_REG	0x1065
> +#define AB4500_PWM_OUT_CTRL7_REG	0x1066
> +
> +#define AB4500_I2C_PAD_CTRL_REG		0x1067
> +#define AB4500_REV_REG			0x1080
> +
> +/**
> + * struct ab4500
> + * @spi: spi device structure
> + * @tx_buf: transmit buffer
> + * @rx_buf: receive buffer
> + * @lock: sync primitive
> + */
> +struct ab4500 {
> +	struct spi_device	*spi;
> +	unsigned long		tx_buf[4];
> +	unsigned long		rx_buf[4];
> +	struct mutex		lock;
> +};
> +
> +int ab4500_write(struct ab4500 *ab4500, unsigned char block,
> +		unsigned long addr, unsigned char data);
> +int ab4500_read(struct ab4500 *ab4500, unsigned char block,
> +		unsigned long addr);
> +
> +#endif /* MFD_AB4500_H */
> -- 
> 1.6.3.GIT
> 
> 
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
