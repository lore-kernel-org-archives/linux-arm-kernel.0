From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 16 Mar 2010 19:52:47 +0800
Subject: [PATCH 2/8] [ARM] pxa: remove now un-used corgi_ssp.c and corgi_lcd.c
In-Reply-To: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
References: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1268740373-27407-3-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only use of corgi_ssp.c is corgi_ts.c, which is now deprecated
and removed. Remove corgi_ssp.c and corgi_lcd.c and their relevant
function declarations and data structures.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/mach-pxa/Kconfig              |    9 -
 arch/arm/mach-pxa/Makefile             |    1 -
 arch/arm/mach-pxa/corgi_lcd.c          |  288 --------------------------------
 arch/arm/mach-pxa/corgi_ssp.c          |  275 ------------------------------
 arch/arm/mach-pxa/include/mach/corgi.h |    1 -
 arch/arm/mach-pxa/sharpsl.h            |   23 ---
 6 files changed, 0 insertions(+), 597 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/corgi_lcd.c
 delete mode 100644 arch/arm/mach-pxa/corgi_ssp.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 5b6ee46..089579f 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -461,15 +461,6 @@ config SHARPSL_PM_MAX1111
 	select HWMON
 	select SENSORS_MAX1111
 
-config CORGI_SSP_DEPRECATED
-	bool
-	select PXA_SSP
-	select PXA_SSP_LEGACY
-	help
-	  This option will include corgi_ssp.c and corgi_lcd.c
-	  that corgi_ts.c and other legacy drivers (corgi_bl.c
-	  and sharpsl_pm.c) may depend on.
-
 config MACH_POODLE
 	bool "Enable Sharp SL-5600 (Poodle) Support"
 	depends on PXA_SHARPSL
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 86bc87b..a83aff3 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -80,7 +80,6 @@ obj-$(CONFIG_MACH_PALMLD)	+= palmld.o
 obj-$(CONFIG_PALM_TREO)		+= palmtreo.o
 obj-$(CONFIG_PXA_SHARP_C7xx)	+= corgi.o sharpsl_pm.o corgi_pm.o
 obj-$(CONFIG_PXA_SHARP_Cxx00)	+= spitz.o sharpsl_pm.o spitz_pm.o
-obj-$(CONFIG_CORGI_SSP_DEPRECATED)	+= corgi_ssp.o corgi_lcd.o
 obj-$(CONFIG_MACH_POODLE)	+= poodle.o
 obj-$(CONFIG_MACH_TOSA)		+= tosa.o
 obj-$(CONFIG_MACH_ICONTROL)     += icontrol.o mxm8x10.o
diff --git a/arch/arm/mach-pxa/corgi_lcd.c b/arch/arm/mach-pxa/corgi_lcd.c
deleted file mode 100644
index d9b9631..0000000
--- a/arch/arm/mach-pxa/corgi_lcd.c
+++ /dev/null
@@ -1,288 +0,0 @@
-/*
- * linux/arch/arm/mach-pxa/corgi_lcd.c
- *
- * Corgi/Spitz LCD Specific Code
- *
- * Copyright (C) 2005 Richard Purdie
- *
- * Connectivity:
- *   Corgi - LCD to ATI Imageon w100 (Wallaby)
- *   Spitz - LCD to PXA Framebuffer
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#include <linux/delay.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/module.h>
-#include <linux/string.h>
-#include <mach/corgi.h>
-#include <mach/hardware.h>
-#include <mach/sharpsl.h>
-#include <mach/spitz.h>
-#include <asm/hardware/scoop.h>
-#include <asm/mach/sharpsl_param.h>
-#include "generic.h"
-
-/* Register Addresses */
-#define RESCTL_ADRS     0x00
-#define PHACTRL_ADRS    0x01
-#define DUTYCTRL_ADRS   0x02
-#define POWERREG0_ADRS  0x03
-#define POWERREG1_ADRS  0x04
-#define GPOR3_ADRS      0x05
-#define PICTRL_ADRS     0x06
-#define POLCTRL_ADRS    0x07
-
-/* Register Bit Definitions */
-#define RESCTL_QVGA     0x01
-#define RESCTL_VGA      0x00
-
-#define POWER1_VW_ON    0x01  /* VW Supply FET ON */
-#define POWER1_GVSS_ON  0x02  /* GVSS(-8V) Power Supply ON */
-#define POWER1_VDD_ON   0x04  /* VDD(8V),SVSS(-4V) Power Supply ON */
-
-#define POWER1_VW_OFF   0x00  /* VW Supply FET OFF */
-#define POWER1_GVSS_OFF 0x00  /* GVSS(-8V) Power Supply OFF */
-#define POWER1_VDD_OFF  0x00  /* VDD(8V),SVSS(-4V) Power Supply OFF */
-
-#define POWER0_COM_DCLK 0x01  /* COM Voltage DC Bias DAC Serial Data Clock */
-#define POWER0_COM_DOUT 0x02  /* COM Voltage DC Bias DAC Serial Data Out */
-#define POWER0_DAC_ON   0x04  /* DAC Power Supply ON */
-#define POWER0_COM_ON   0x08  /* COM Power Supply ON */
-#define POWER0_VCC5_ON  0x10  /* VCC5 Power Supply ON */
-
-#define POWER0_DAC_OFF  0x00  /* DAC Power Supply OFF */
-#define POWER0_COM_OFF  0x00  /* COM Power Supply OFF */
-#define POWER0_VCC5_OFF 0x00  /* VCC5 Power Supply OFF */
-
-#define PICTRL_INIT_STATE      0x01
-#define PICTRL_INIOFF          0x02
-#define PICTRL_POWER_DOWN      0x04
-#define PICTRL_COM_SIGNAL_OFF  0x08
-#define PICTRL_DAC_SIGNAL_OFF  0x10
-
-#define POLCTRL_SYNC_POL_FALL  0x01
-#define POLCTRL_EN_POL_FALL    0x02
-#define POLCTRL_DATA_POL_FALL  0x04
-#define POLCTRL_SYNC_ACT_H     0x08
-#define POLCTRL_EN_ACT_L       0x10
-
-#define POLCTRL_SYNC_POL_RISE  0x00
-#define POLCTRL_EN_POL_RISE    0x00
-#define POLCTRL_DATA_POL_RISE  0x00
-#define POLCTRL_SYNC_ACT_L     0x00
-#define POLCTRL_EN_ACT_H       0x00
-
-#define PHACTRL_PHASE_MANUAL   0x01
-#define DEFAULT_PHAD_QVGA     (9)
-#define DEFAULT_COMADJ        (125)
-
-/*
- * This is only a psuedo I2C interface. We can't use the standard kernel
- * routines as the interface is write only. We just assume the data is acked...
- */
-static void lcdtg_ssp_i2c_send(u8 data)
-{
-	corgi_ssp_lcdtg_send(POWERREG0_ADRS, data);
-	udelay(10);
-}
-
-static void lcdtg_i2c_send_bit(u8 data)
-{
-	lcdtg_ssp_i2c_send(data);
-	lcdtg_ssp_i2c_send(data | POWER0_COM_DCLK);
-	lcdtg_ssp_i2c_send(data);
-}
-
-static void lcdtg_i2c_send_start(u8 base)
-{
-	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK | POWER0_COM_DOUT);
-	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK);
-	lcdtg_ssp_i2c_send(base);
-}
-
-static void lcdtg_i2c_send_stop(u8 base)
-{
-	lcdtg_ssp_i2c_send(base);
-	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK);
-	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK | POWER0_COM_DOUT);
-}
-
-static void lcdtg_i2c_send_byte(u8 base, u8 data)
-{
-	int i;
-	for (i = 0; i < 8; i++) {
-		if (data & 0x80)
-			lcdtg_i2c_send_bit(base | POWER0_COM_DOUT);
-		else
-			lcdtg_i2c_send_bit(base);
-		data <<= 1;
-	}
-}
-
-static void lcdtg_i2c_wait_ack(u8 base)
-{
-	lcdtg_i2c_send_bit(base);
-}
-
-static void lcdtg_set_common_voltage(u8 base_data, u8 data)
-{
-	/* Set Common Voltage to M62332FP via I2C */
-	lcdtg_i2c_send_start(base_data);
-	lcdtg_i2c_send_byte(base_data, 0x9c);
-	lcdtg_i2c_wait_ack(base_data);
-	lcdtg_i2c_send_byte(base_data, 0x00);
-	lcdtg_i2c_wait_ack(base_data);
-	lcdtg_i2c_send_byte(base_data, data);
-	lcdtg_i2c_wait_ack(base_data);
-	lcdtg_i2c_send_stop(base_data);
-}
-
-/* Set Phase Adjust */
-static void lcdtg_set_phadadj(int mode)
-{
-	int adj;
-	switch(mode) {
-		case 480:
-		case 640:
-			/* Setting for VGA */
-			adj = sharpsl_param.phadadj;
-			if (adj < 0) {
-				adj = PHACTRL_PHASE_MANUAL;
-			} else {
-				adj = ((adj & 0x0f) << 1) | PHACTRL_PHASE_MANUAL;
-			}
-			break;
-		case 240:
-		case 320:
-		default:
-			/* Setting for QVGA */
-			adj = (DEFAULT_PHAD_QVGA << 1) | PHACTRL_PHASE_MANUAL;
-			break;
-	}
-
-	corgi_ssp_lcdtg_send(PHACTRL_ADRS, adj);
-}
-
-static int lcd_inited;
-
-void corgi_lcdtg_hw_init(int mode)
-{
-	if (!lcd_inited) {
-		int comadj;
-
-		/* Initialize Internal Logic & Port */
-		corgi_ssp_lcdtg_send(PICTRL_ADRS, PICTRL_POWER_DOWN | PICTRL_INIOFF | PICTRL_INIT_STATE
-	  			| PICTRL_COM_SIGNAL_OFF | PICTRL_DAC_SIGNAL_OFF);
-
-		corgi_ssp_lcdtg_send(POWERREG0_ADRS, POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_OFF
-				| POWER0_COM_OFF | POWER0_VCC5_OFF);
-
-		corgi_ssp_lcdtg_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_OFF | POWER1_VDD_OFF);
-
-		/* VDD(+8V), SVSS(-4V) ON */
-		corgi_ssp_lcdtg_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_OFF | POWER1_VDD_ON);
-		mdelay(3);
-
-		/* DAC ON */
-		corgi_ssp_lcdtg_send(POWERREG0_ADRS, POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_ON
-				| POWER0_COM_OFF | POWER0_VCC5_OFF);
-
-		/* INIB = H, INI = L  */
-		/* PICTL[0] = H , PICTL[1] = PICTL[2] = PICTL[4] = L */
-		corgi_ssp_lcdtg_send(PICTRL_ADRS, PICTRL_INIT_STATE | PICTRL_COM_SIGNAL_OFF);
-
-		/* Set Common Voltage */
-		comadj = sharpsl_param.comadj;
-		if (comadj < 0)
-			comadj = DEFAULT_COMADJ;
-		lcdtg_set_common_voltage((POWER0_DAC_ON | POWER0_COM_OFF | POWER0_VCC5_OFF), comadj);
-
-		/* VCC5 ON, DAC ON */
-		corgi_ssp_lcdtg_send(POWERREG0_ADRS, POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_ON |
-				POWER0_COM_OFF | POWER0_VCC5_ON);
-
-		/* GVSS(-8V) ON, VDD ON */
-		corgi_ssp_lcdtg_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_ON | POWER1_VDD_ON);
-		mdelay(2);
-
-		/* COM SIGNAL ON (PICTL[3] = L) */
-		corgi_ssp_lcdtg_send(PICTRL_ADRS, PICTRL_INIT_STATE);
-
-		/* COM ON, DAC ON, VCC5_ON */
-		corgi_ssp_lcdtg_send(POWERREG0_ADRS, POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_ON
-				| POWER0_COM_ON | POWER0_VCC5_ON);
-
-		/* VW ON, GVSS ON, VDD ON */
-		corgi_ssp_lcdtg_send(POWERREG1_ADRS, POWER1_VW_ON | POWER1_GVSS_ON | POWER1_VDD_ON);
-
-		/* Signals output enable */
-		corgi_ssp_lcdtg_send(PICTRL_ADRS, 0);
-
-		/* Set Phase Adjust */
-		lcdtg_set_phadadj(mode);
-
-		/* Initialize for Input Signals from ATI */
-		corgi_ssp_lcdtg_send(POLCTRL_ADRS, POLCTRL_SYNC_POL_RISE | POLCTRL_EN_POL_RISE
-				| POLCTRL_DATA_POL_RISE | POLCTRL_SYNC_ACT_L | POLCTRL_EN_ACT_H);
-		udelay(1000);
-
-		lcd_inited=1;
-	} else {
-		lcdtg_set_phadadj(mode);
-	}
-
-	switch(mode) {
-		case 480:
-		case 640:
-			/* Set Lcd Resolution (VGA) */
-			corgi_ssp_lcdtg_send(RESCTL_ADRS, RESCTL_VGA);
-			break;
-		case 240:
-		case 320:
-		default:
-			/* Set Lcd Resolution (QVGA) */
-			corgi_ssp_lcdtg_send(RESCTL_ADRS, RESCTL_QVGA);
-			break;
-	}
-}
-
-void corgi_lcdtg_suspend(void)
-{
-	/* 60Hz x 2 frame = 16.7msec x 2 = 33.4 msec */
-	mdelay(34);
-
-	/* (1)VW OFF */
-	corgi_ssp_lcdtg_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_ON | POWER1_VDD_ON);
-
-	/* (2)COM OFF */
-	corgi_ssp_lcdtg_send(PICTRL_ADRS, PICTRL_COM_SIGNAL_OFF);
-	corgi_ssp_lcdtg_send(POWERREG0_ADRS, POWER0_DAC_ON | POWER0_COM_OFF | POWER0_VCC5_ON);
-
-	/* (3)Set Common Voltage Bias 0V */
-	lcdtg_set_common_voltage(POWER0_DAC_ON | POWER0_COM_OFF | POWER0_VCC5_ON, 0);
-
-	/* (4)GVSS OFF */
-	corgi_ssp_lcdtg_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_OFF | POWER1_VDD_ON);
-
-	/* (5)VCC5 OFF */
-	corgi_ssp_lcdtg_send(POWERREG0_ADRS, POWER0_DAC_ON | POWER0_COM_OFF | POWER0_VCC5_OFF);
-
-	/* (6)Set PDWN, INIOFF, DACOFF */
-	corgi_ssp_lcdtg_send(PICTRL_ADRS, PICTRL_INIOFF | PICTRL_DAC_SIGNAL_OFF |
-			PICTRL_POWER_DOWN | PICTRL_COM_SIGNAL_OFF);
-
-	/* (7)DAC OFF */
-	corgi_ssp_lcdtg_send(POWERREG0_ADRS, POWER0_DAC_OFF | POWER0_COM_OFF | POWER0_VCC5_OFF);
-
-	/* (8)VDD OFF */
-	corgi_ssp_lcdtg_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_OFF | POWER1_VDD_OFF);
-
-	lcd_inited = 0;
-}
-
diff --git a/arch/arm/mach-pxa/corgi_ssp.c b/arch/arm/mach-pxa/corgi_ssp.c
deleted file mode 100644
index 1d9bc11..0000000
--- a/arch/arm/mach-pxa/corgi_ssp.c
+++ /dev/null
@@ -1,275 +0,0 @@
-/*
- *  SSP control code for Sharp Corgi devices
- *
- *  Copyright (c) 2004-2005 Richard Purdie
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-
-#include <mach/ssp.h>
-#include <mach/pxa2xx-gpio.h>
-#include <mach/regs-ssp.h>
-#include "sharpsl.h"
-
-static DEFINE_SPINLOCK(corgi_ssp_lock);
-static struct ssp_dev corgi_ssp_dev;
-static struct ssp_state corgi_ssp_state;
-static struct corgissp_machinfo *ssp_machinfo;
-
-/*
- * There are three devices connected to the SSP interface:
- *   1. A touchscreen controller (TI ADS7846 compatible)
- *   2. An LCD controller (with some Backlight functionality)
- *   3. A battery monitoring IC (Maxim MAX1111)
- *
- * Each device uses a different speed/mode of communication.
- *
- * The touchscreen is very sensitive and the most frequently used
- * so the port is left configured for this.
- *
- * Devices are selected using Chip Selects on GPIOs.
- */
-
-/*
- *  ADS7846 Routines
- */
-unsigned long corgi_ssp_ads7846_putget(ulong data)
-{
-	unsigned long flag;
-	u32 ret = 0;
-
-	spin_lock_irqsave(&corgi_ssp_lock, flag);
-	if (ssp_machinfo->cs_ads7846 >= 0)
-		GPCR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846);
-
-	ssp_write_word(&corgi_ssp_dev,data);
- 	ssp_read_word(&corgi_ssp_dev, &ret);
-
-	if (ssp_machinfo->cs_ads7846 >= 0)
-		GPSR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846);
-	spin_unlock_irqrestore(&corgi_ssp_lock, flag);
-
-	return ret;
-}
-
-/*
- * NOTE: These functions should always be called in interrupt context
- * and use the _lock and _unlock functions. They are very time sensitive.
- */
-void corgi_ssp_ads7846_lock(void)
-{
-	spin_lock(&corgi_ssp_lock);
-	if (ssp_machinfo->cs_ads7846 >= 0)
-		GPCR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846);
-}
-
-void corgi_ssp_ads7846_unlock(void)
-{
-	if (ssp_machinfo->cs_ads7846 >= 0)
-		GPSR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846);
-	spin_unlock(&corgi_ssp_lock);
-}
-
-void corgi_ssp_ads7846_put(ulong data)
-{
-	ssp_write_word(&corgi_ssp_dev,data);
-}
-
-unsigned long corgi_ssp_ads7846_get(void)
-{
-	u32 ret = 0;
-	ssp_read_word(&corgi_ssp_dev, &ret);
-	return ret;
-}
-
-EXPORT_SYMBOL(corgi_ssp_ads7846_putget);
-EXPORT_SYMBOL(corgi_ssp_ads7846_lock);
-EXPORT_SYMBOL(corgi_ssp_ads7846_unlock);
-EXPORT_SYMBOL(corgi_ssp_ads7846_put);
-EXPORT_SYMBOL(corgi_ssp_ads7846_get);
-
-
-/*
- *  LCD/Backlight Routines
- */
-unsigned long corgi_ssp_dac_put(ulong data)
-{
-	unsigned long flag, sscr1 = SSCR1_SPH;
-	u32 tmp;
-
-	spin_lock_irqsave(&corgi_ssp_lock, flag);
-
-	if (machine_is_spitz() || machine_is_akita() || machine_is_borzoi())
-		sscr1 = 0;
-
-	ssp_disable(&corgi_ssp_dev);
-	ssp_config(&corgi_ssp_dev, (SSCR0_Motorola | (SSCR0_DSS & 0x07 )), sscr1, 0, SSCR0_SerClkDiv(ssp_machinfo->clk_lcdcon));
-	ssp_enable(&corgi_ssp_dev);
-
-	if (ssp_machinfo->cs_lcdcon >= 0)
-		GPCR(ssp_machinfo->cs_lcdcon) = GPIO_bit(ssp_machinfo->cs_lcdcon);
-	ssp_write_word(&corgi_ssp_dev,data);
-	/* Read null data back from device to prevent SSP overflow */
-	ssp_read_word(&corgi_ssp_dev, &tmp);
-	if (ssp_machinfo->cs_lcdcon >= 0)
-		GPSR(ssp_machinfo->cs_lcdcon) = GPIO_bit(ssp_machinfo->cs_lcdcon);
-
-	ssp_disable(&corgi_ssp_dev);
-	ssp_config(&corgi_ssp_dev, (SSCR0_National | (SSCR0_DSS & 0x0b )), 0, 0, SSCR0_SerClkDiv(ssp_machinfo->clk_ads7846));
-	ssp_enable(&corgi_ssp_dev);
-
-	spin_unlock_irqrestore(&corgi_ssp_lock, flag);
-
-	return 0;
-}
-
-void corgi_ssp_lcdtg_send(u8 adrs, u8 data)
-{
-	corgi_ssp_dac_put(((adrs & 0x07) << 5) | (data & 0x1f));
-}
-
-void corgi_ssp_blduty_set(int duty)
-{
-	corgi_ssp_lcdtg_send(0x02,duty);
-}
-
-EXPORT_SYMBOL(corgi_ssp_lcdtg_send);
-EXPORT_SYMBOL(corgi_ssp_blduty_set);
-
-/*
- *  Max1111 Routines
- */
-int corgi_ssp_max1111_get(ulong data)
-{
-	unsigned long flag;
-	long voltage = 0, voltage1 = 0, voltage2 = 0;
-
-	spin_lock_irqsave(&corgi_ssp_lock, flag);
-	if (ssp_machinfo->cs_max1111 >= 0)
-		GPCR(ssp_machinfo->cs_max1111) = GPIO_bit(ssp_machinfo->cs_max1111);
-	ssp_disable(&corgi_ssp_dev);
-	ssp_config(&corgi_ssp_dev, (SSCR0_Motorola | (SSCR0_DSS & 0x07 )), 0, 0, SSCR0_SerClkDiv(ssp_machinfo->clk_max1111));
-	ssp_enable(&corgi_ssp_dev);
-
-	udelay(1);
-
-	/* TB1/RB1 */
-	ssp_write_word(&corgi_ssp_dev,data);
-	ssp_read_word(&corgi_ssp_dev, (u32*)&voltage1); /* null read */
-
-	/* TB12/RB2 */
-	ssp_write_word(&corgi_ssp_dev,0);
-	ssp_read_word(&corgi_ssp_dev, (u32*)&voltage1);
-
-	/* TB13/RB3*/
-	ssp_write_word(&corgi_ssp_dev,0);
-	ssp_read_word(&corgi_ssp_dev, (u32*)&voltage2);
-
-	ssp_disable(&corgi_ssp_dev);
-	ssp_config(&corgi_ssp_dev, (SSCR0_National | (SSCR0_DSS & 0x0b )), 0, 0, SSCR0_SerClkDiv(ssp_machinfo->clk_ads7846));
-	ssp_enable(&corgi_ssp_dev);
-	if (ssp_machinfo->cs_max1111 >= 0)
-		GPSR(ssp_machinfo->cs_max1111) = GPIO_bit(ssp_machinfo->cs_max1111);
-	spin_unlock_irqrestore(&corgi_ssp_lock, flag);
-
-	if (voltage1 & 0xc0 || voltage2 & 0x3f)
-		voltage = -1;
-	else
-		voltage = ((voltage1 << 2) & 0xfc) | ((voltage2 >> 6) & 0x03);
-
-	return voltage;
-}
-
-EXPORT_SYMBOL(corgi_ssp_max1111_get);
-
-/*
- *  Support Routines
- */
-
-void __init corgi_ssp_set_machinfo(struct corgissp_machinfo *machinfo)
-{
-	ssp_machinfo = machinfo;
-}
-
-static int __devinit corgi_ssp_probe(struct platform_device *dev)
-{
-	int ret;
-
-	/* Chip Select - Disable All */
-	if (ssp_machinfo->cs_lcdcon >= 0)
-		pxa_gpio_mode(ssp_machinfo->cs_lcdcon  | GPIO_OUT | GPIO_DFLT_HIGH);
-	if (ssp_machinfo->cs_max1111 >= 0)
-	        pxa_gpio_mode(ssp_machinfo->cs_max1111 | GPIO_OUT | GPIO_DFLT_HIGH);
-	if (ssp_machinfo->cs_ads7846 >= 0)
-        	pxa_gpio_mode(ssp_machinfo->cs_ads7846 | GPIO_OUT | GPIO_DFLT_HIGH);
-
-	ret = ssp_init(&corgi_ssp_dev, ssp_machinfo->port, 0);
-
-	if (ret)
-		printk(KERN_ERR "Unable to register SSP handler!\n");
-	else {
-		ssp_disable(&corgi_ssp_dev);
-		ssp_config(&corgi_ssp_dev, (SSCR0_National | (SSCR0_DSS & 0x0b )), 0, 0, SSCR0_SerClkDiv(ssp_machinfo->clk_ads7846));
-		ssp_enable(&corgi_ssp_dev);
-	}
-
-	return ret;
-}
-
-static int corgi_ssp_remove(struct platform_device *dev)
-{
-	ssp_exit(&corgi_ssp_dev);
-	return 0;
-}
-
-static int corgi_ssp_suspend(struct platform_device *dev, pm_message_t state)
-{
-	ssp_flush(&corgi_ssp_dev);
-	ssp_save_state(&corgi_ssp_dev,&corgi_ssp_state);
-
-	return 0;
-}
-
-static int corgi_ssp_resume(struct platform_device *dev)
-{
-	if (ssp_machinfo->cs_lcdcon >= 0)
-		GPSR(ssp_machinfo->cs_lcdcon) = GPIO_bit(ssp_machinfo->cs_lcdcon);  /* High - Disable LCD Control/Timing Gen */
-	if (ssp_machinfo->cs_max1111 >= 0)
-		GPSR(ssp_machinfo->cs_max1111) = GPIO_bit(ssp_machinfo->cs_max1111); /* High - Disable MAX1111*/
-	if (ssp_machinfo->cs_ads7846 >= 0)
-		GPSR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846); /* High - Disable ADS7846*/
-	ssp_restore_state(&corgi_ssp_dev,&corgi_ssp_state);
-	ssp_enable(&corgi_ssp_dev);
-
-	return 0;
-}
-
-static struct platform_driver corgissp_driver = {
-	.probe		= corgi_ssp_probe,
-	.remove		= corgi_ssp_remove,
-	.suspend	= corgi_ssp_suspend,
-	.resume		= corgi_ssp_resume,
-	.driver		= {
-		.name	= "corgi-ssp",
-	},
-};
-
-int __init corgi_ssp_init(void)
-{
-	return platform_driver_register(&corgissp_driver);
-}
-
-arch_initcall(corgi_ssp_init);
diff --git a/arch/arm/mach-pxa/include/mach/corgi.h b/arch/arm/mach-pxa/include/mach/corgi.h
index 7239281..585970e 100644
--- a/arch/arm/mach-pxa/include/mach/corgi.h
+++ b/arch/arm/mach-pxa/include/mach/corgi.h
@@ -113,7 +113,6 @@
  * Shared data structures
  */
 extern struct platform_device corgiscoop_device;
-extern struct platform_device corgissp_device;
 
 #endif /* __ASM_ARCH_CORGI_H  */
 
diff --git a/arch/arm/mach-pxa/sharpsl.h b/arch/arm/mach-pxa/sharpsl.h
index 1439785..0cc1203 100644
--- a/arch/arm/mach-pxa/sharpsl.h
+++ b/arch/arm/mach-pxa/sharpsl.h
@@ -10,29 +10,6 @@
 #include <mach/sharpsl_pm.h>
 
 /*
- * SharpSL SSP Driver
- */
-struct corgissp_machinfo {
-	int port;
-	int cs_lcdcon;
-	int cs_ads7846;
-	int cs_max1111;
-	int clk_lcdcon;
-	int clk_ads7846;
-	int clk_max1111;
-};
-
-void corgi_ssp_set_machinfo(struct corgissp_machinfo *machinfo);
-
-
-/*
- * SharpSL/Corgi LCD Driver
- */
-void corgi_lcdtg_suspend(void);
-void corgi_lcdtg_hw_init(int mode);
-
-
-/*
  * SharpSL Battery/PM Driver
  */
 #define READ_GPIO_BIT(x)    (GPLR(x) & GPIO_bit(x))
-- 
1.6.3.3
