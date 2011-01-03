From: inki.dae@samsung.com (daeinki)
Date: Mon, 03 Jan 2011 11:14:29 +0900
Subject: [PATCH 4/5] S5PC110: add MIPI-DSI Controller driver.
In-Reply-To: <013b01cba8b7$a0bcf250$e236d6f0$%kim@samsung.com>
References: <1293535589-24825-1-git-send-email-inki.dae@samsung.com>
	<013b01cba8b7$a0bcf250$e236d6f0$%kim@samsung.com>
Message-ID: <4D213105.9010405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim ? ?:
> Inki Dae wrote:
>> S5PC110 and S5PC210 SoC platform have one or two MIPI-DSI Controller.
>> MIPI-DSI Controller can be used to connect MIPI-DSI based LCD Panel.
>> this patch adds MIPI-DSI Controller driver.(or Master driver)
>>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>> ---
>>  arch/arm/plat-s5p/include/plat/mipi-ddi.h  |   54 +++
>>  arch/arm/plat-s5p/include/plat/mipi-dsi.h  |  450 ++++++++++++++++++++
>>  arch/arm/plat-s5p/include/plat/regs-dsim.h |  299 +++++++++++++
>>  drivers/video/Kconfig                      |    7 +
>>  drivers/video/Makefile                     |    2 +
>>  drivers/video/s5p_mipi_dsi.c               |  429 +++++++++++++++++++
>>  drivers/video/s5p_mipi_dsi_common.c        |  630
>> ++++++++++++++++++++++++++++
>>  drivers/video/s5p_mipi_dsi_common.h        |   34 ++
>>  drivers/video/s5p_mipi_dsi_lowlevel.c      |  569
> +++++++++++++++++++++++++
>>  drivers/video/s5p_mipi_dsi_lowlevel.h      |   93 ++++
>>  10 files changed, 2567 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/plat-s5p/include/plat/mipi-ddi.h
>>  create mode 100644 arch/arm/plat-s5p/include/plat/mipi-dsi.h
>>  create mode 100644 arch/arm/plat-s5p/include/plat/regs-dsim.h
>>  create mode 100644 drivers/video/s5p_mipi_dsi.c
>>  create mode 100644 drivers/video/s5p_mipi_dsi_common.c
>>  create mode 100644 drivers/video/s5p_mipi_dsi_common.h
>>  create mode 100644 drivers/video/s5p_mipi_dsi_lowlevel.c
>>  create mode 100644 drivers/video/s5p_mipi_dsi_lowlevel.h
>>
>> diff --git a/arch/arm/plat-s5p/include/plat/mipi-ddi.h b/arch/arm/plat-
>> s5p/include/plat/mipi-ddi.h
>> new file mode 100644
>> index 0000000..3f4efb4
>> --- /dev/null
>> +++ b/arch/arm/plat-s5p/include/plat/mipi-ddi.h
>> @@ -0,0 +1,54 @@
>> +/* linux/arm/arch/plat-s5p/include/plat/mipi_ddi.h
>> + *
>> + * definitions for DDI based MIPI-DSI.
>> + *
>> + * Copyright (c) 2009 Samsung Electronics
>> + * InKi Dae <inki.dae@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#ifndef _MIPI_DDI_H
>> +#define _MIPI_DDI_H
>> +
>> +#include <linux/lcd.h>
>> +
>> +enum mipi_ddi_interface {
>> +	RGB_IF = 0x4000,
>> +	I80_IF = 0x8000,
>> +	YUV_601 = 0x10000,
>> +	YUV_656 = 0x20000,
>> +	MIPI_VIDEO = 0x1000,
>> +	MIPI_COMMAND = 0x2000,
>> +};
>> +
>> +enum mipi_ddi_panel_select {
>> +	DDI_MAIN_LCD = 0,
>> +	DDI_SUB_LCD = 1,
> 
> 	DDI_MAIN_LCD,
> 	DDI_SUB_LCD,
> 
>> +};
>> +
>> +struct mipi_ddi_platform_data {
>> +	/*
>> +	 * it is used for command mode lcd panel and
>> +	 * when all contents of framebuffer in panel module are transfered
>> +	 * to lcd panel it occurs te signal.
>> +	 *
>> +	 * note:
>> +	 * - in case of command mode(cpu mode), it should be triggered only
>> +	 *   when TE signal of lcd panel and frame done interrupt of display
>> +	 *   controller or mipi controller occurs.
>> +	 */
>> +	unsigned int te_irq;
>> +
>> +	int (*lcd_reset) (struct lcd_device *ld);
>> +	int (*lcd_power_on) (struct lcd_device *ld, int enable);
>> +	int (*backlight_on) (struct lcd_device *ld, int enable);
>> +
>> +	unsigned int reset_delay;
>> +	unsigned int power_on_delay;
>> +	unsigned int power_off_delay;
>> +};
>> +
>> +#endif /* _MIPI_DDI_H */
> 
> I'm not sure whether we really need above header in here.
> 
they would be used for lcd panel driver.
please, see MIPI based sample lcd driver.

>> diff --git a/arch/arm/plat-s5p/include/plat/mipi-dsi.h b/arch/arm/plat-
>> s5p/include/plat/mipi-dsi.h
>> new file mode 100644
>> index 0000000..371efe4
>> --- /dev/null
>> +++ b/arch/arm/plat-s5p/include/plat/mipi-dsi.h
> 
> Sometimes used MIPI DSI or MIPI DSIM...
> I think should be used same name like MIPI CSIS.
> 
> If possible, please same rule...according to data sheet, MIPI DSIM is
> better.
> 
as I said before, modified as "DSIM"

>> @@ -0,0 +1,450 @@
>> +/* linux/arm/arch/plat-s5p/include/plat/mipi_dsi.h
> 
> mipi_dsi.h? mipi-dsi.h?
> 
>> + *
>> + * Platform data header for Samsung MIPI-DSI.
>> + *
>> + * Copyright (c) 2009 Samsung Electronics
>> + * InKi Dae <inki.dae@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#ifndef _MIPI_DSI_H
>> +#define _MIPI_DSI_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/fb.h>
>> +
>> +#define PANEL_NAME_SIZE		(32)
>> +
>> +enum dsim_interface_type {
>> +	DSIM_COMMAND = 0,
>> +	DSIM_VIDEO = 1,
> 
> 	DSIM_COMMAND,
> 	DSIM_VIDEO,
> 
>> +};
>> +
>> +enum dsim_state {
>> +	DSIM_STATE_RESET = 0,
>> +	DSIM_STATE_INIT = 1,
>> +	DSIM_STATE_STOP = 2,
>> +	DSIM_STATE_HSCLKEN = 3,
>> +	DSIM_STATE_ULPS = 4,
> 
> 	DSIM_STATE_RESET,
> 	DSIM_STATE_INIT,
> 	DSIM_STATE_STOP,
> 	DSIM_STATE_HSCLKEN,
> 	DSIM_STATE_ULPS,
> 
>> +};
>> +
>> +enum dsim_virtual_ch_no {
>> +	DSIM_VIRTUAL_CH_0 = 0,
>> +	DSIM_VIRTUAL_CH_1 = 1,
>> +	DSIM_VIRTUAL_CH_2 = 2,
>> +	DSIM_VIRTUAL_CH_3 = 3,
> 
> 	DSIM_VIRTUAL_CH_0,
> 	DSIM_VIRTUAL_CH_1,
> 	DSIM_VIRTUAL_CH_2,
> 	DSIM_VIRTUAL_CH_3,
> 
> ....
> 
> 
> And if not used, please remove that.
> We don't need unnecessary codes.
> 
>> +};
>> +
> 
no, used for mipi-dsi driver.
please, see the s5p_mipi_dsi_common.c and lowlevel.c file.
and I will move this header file to driver.

> (snip)
> 
>> diff --git a/arch/arm/plat-s5p/include/plat/regs-dsim.h b/arch/arm/plat-
>> s5p/include/plat/regs-dsim.h
>> new file mode 100644
>> index 0000000..fcd9c1f
>> --- /dev/null
>> +++ b/arch/arm/plat-s5p/include/plat/regs-dsim.h
>> @@ -0,0 +1,299 @@
>> +/* linux/arch/arm/plat-s5p/include/plat/regs-dsim.h
>> + *
>> + * Register definition file for Samsung MIPI-DSIM driver
>> + *
>> + * InKi Dae <inki.dae@samsung.com>, Copyright (c) 2009 Samsung
> Electronics
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#ifndef _REGS_DSIM_H
>> +#define _REGS_DSIM_H
>> +
> 
> If not used some definitios, we don't need that.
> I don't think that we need every below definitions.
> 
also.

>> +#define S5P_DSIM_STATUS		(0x0)	/* Status register */
>> +#define S5P_DSIM_SWRST		(0x4)	/* Software reset register
> */
>> +#define S5P_DSIM_CLKCTRL	(0x8)	/* Clock control register */
>> +#define S5P_DSIM_TIMEOUT	(0xc)	/* Time out register */
>> +#define S5P_DSIM_CONFIG		(0x10)	/* Configuration register */
>> +#define S5P_DSIM_ESCMODE	(0x14)	/* Escape mode register */
>> +
>> +/* Main display image resolution register */
>> +#define S5P_DSIM_MDRESOL	(0x18)
>> +#define S5P_DSIM_MVPORCH	(0x1c)	/* Main display Vporch register */
>> +#define S5P_DSIM_MHPORCH	(0x20)	/* Main display Hporch register */
>> +#define S5P_DSIM_MSYNC		(0x24)	/* Main display sync area
>> register */
>> +
>> +/* Sub display image resolution register */
>> +#define S5P_DSIM_SDRESOL	(0x28)
>> +#define S5P_DSIM_INTSRC		(0x2c)	/* Interrupt source register
> */
>> +#define S5P_DSIM_INTMSK		(0x30)	/* Interrupt mask register
> */
>> +#define S5P_DSIM_PKTHDR		(0x34)	/* Packet Header FIFO
> register
>> */
>> +#define S5P_DSIM_PAYLOAD	(0x38)	/* Payload FIFO register */
>> +#define S5P_DSIM_RXFIFO		(0x3c)	/* Read FIFO register */
>> +#define S5P_DSIM_FIFOTHLD	(0x40)	/* FIFO threshold level register */
>> +#define S5P_DSIM_FIFOCTRL	(0x44)	/* FIFO status and control register
> */
>> +
>> +/* FIFO memory AC characteristic register */
>> +#define S5P_DSIM_MEMACCHR	(0x48)
>> +#define S5P_DSIM_PLLCTRL	(0x4c)	/* PLL control register */
>> +#define S5P_DSIM_PLLTMR		(0x50)	/* PLL timer register */
>> +#define S5P_DSIM_PHYACCHR	(0x54)	/* D-PHY AC characteristic register
> */
>> +#define S5P_DSIM_PHYACCHR1	(0x58)	/* D-PHY AC characteristic register1
> */
>> +
>> +/* DSIM_SWRST */
>> +#define DSIM_FUNCRST		(1 << 16)
>> +#define DSIM_SWRST		(1 << 0)
>> +
>> +/* S5P_DSIM_TIMEOUT */
>> +#define DSIM_LPDR_TOUT_SHIFT	(0)
>> +#define DSIM_BTA_TOUT_SHIFT	(16)
>> +#define DSIM_LPDR_TOUT(x)	(((x) & 0xffff) << DSIM_LPDR_TOUT_SHIFT)
>> +#define DSIM_BTA_TOUT(x)	(((x) & 0xff) << DSIM_BTA_TOUT_SHIFT)
>> +
>> +/* S5P_DSIM_CLKCTRL */
>> +#define DSIM_ESC_PRESCALER_SHIFT	(0)
>> +#define DSIM_LANE_ESC_CLKEN_SHIFT	(19)
>> +#define DSIM_BYTE_CLKEN_SHIFT		(24)
>> +#define DSIM_BYTE_CLK_SRC_SHIFT		(25)
>> +#define DSIM_PLL_BYPASS_SHIFT		(27)
>> +#define DSIM_ESC_CLKEN_SHIFT		(28)
>> +#define DSIM_TX_REQUEST_HSCLK_SHIFT	(31)
>> +#define DSIM_ESC_PRESCALER(x)		(((x) & 0xffff) << \
>> +						DSIM_ESC_PRESCALER_SHIFT)
>> +#define DSIM_LANE_ESC_CLKEN(x)		(((x) & 0x1f) << \
>> +						DSIM_LANE_ESC_CLKEN_SHIFT)
>> +#define DSIM_BYTE_CLK_ENABLE		(1 << DSIM_BYTE_CLKEN_SHIFT)
>> +#define DSIM_BYTE_CLK_DISABLE		(0 << DSIM_BYTE_CLKEN_SHIFT)
>> +#define DSIM_BYTE_CLKSRC(x)		(((x) & 0x3) <<
> DSIM_BYTE_CLK_SRC_SHIFT)
>> +#define DSIM_PLL_BYPASS_PLL		(0 << DSIM_PLL_BYPASS_SHIFT)
>> +#define DSIM_PLL_BYPASS_EXTERNAL	(1 << DSIM_PLL_BYPASS_SHIFT)
>> +#define DSIM_ESC_CLKEN_ENABLE		(1 << DSIM_ESC_CLKEN_SHIFT)
>> +#define DSIM_ESC_CLKEN_DISABLE		(0 << DSIM_ESC_CLKEN_SHIFT)
>> +
>> +/* S5P_DSIM_CONFIG */
>> +#define DSIM_LANE_EN_SHIFT		(0)
>> +#define DSIM_NUM_OF_DATALANE_SHIFT	(5)
>> +#define DSIM_SUB_PIX_FORMAT_SHIFT	(8)
>> +#define DSIM_MAIN_PIX_FORMAT_SHIFT	(12)
>> +#define DSIM_SUB_VC_SHIFT		(16)
>> +#define DSIM_MAIN_VC_SHIFT		(18)
>> +#define DSIM_HSA_MODE_SHIFT		(20)
>> +#define DSIM_HBP_MODE_SHIFT		(21)
>> +#define DSIM_HFP_MODE_SHIFT		(22)
>> +#define DSIM_HSE_MODE_SHIFT		(23)
>> +#define DSIM_AUTO_MODE_SHIFT		(24)
>> +#define DSIM_VIDEO_MODE_SHIFT		(25)
>> +#define DSIM_BURST_MODE_SHIFT		(26)
>> +#define DSIM_SYNC_INFORM_SHIFT		(27)
>> +#define DSIM_EOT_R03_SHIFT		(28)
>> +#define DSIM_LANE_ENx(x)		((1) << x)
>> +
>> +/* in case of Gemunus, it should be 0x1. */
>> +#define DSIM_NUM_OF_DATA_LANE(x)	((x) << 5)
>> +#define DSIM_SUB_PIX_FORMAT_3BPP	(0 << 8)	/* command mode only
> */
>> +#define DSIM_SUB_PIX_FORMAT_8BPP	(1 << 8)	/* command mode only
> */
>> +#define DSIM_SUB_PIX_FORMAT_12BPP	(2 << 8)	/* command mode only
> */
>> +#define DSIM_SUB_PIX_FORMAT_16BPP	(3 << 8)	/* command mode only
> */
>> +#define DSIM_SUB_PIX_FORMAT_16BPP_RGB	(4 << 8)	/* video
> mode
>> only */
>> +#define DSIM_SUB_PIX_FORMAT_18BPP_PRGB	(5 << 8)	/* video
> mode
>> only */
>> +#define DSIM_SUB_PIX_FORMAT_18BPP_LRGB	(6 << 8)	/* common */
>> +#define DSIM_SUB_PIX_FORMAT_24BPP_RGB	(7 << 8)	/* common */
>> +#define DSIM_MAIN_PIX_FORMAT_3BPP	(0 << 12)	/* command mode only
> */
>> +#define DSIM_MAIN_PIX_FORMAT_8BPP	(1 << 12)	/* command mode only
> */
>> +#define DSIM_MAIN_PIX_FORMAT_12BPP	(2 << 12)	/* command mode only
> */
>> +#define DSIM_MAIN_PIX_FORMAT_16BPP	(3 << 12)	/* command mode only
> */
>> +#define DSIM_MAIN_PIX_FORMAT_16BPP_RGB	(4 << 12)	/* video
> mode
>> only */
>> +#define DSIM_MAIN_PIX_FORMAT_18BPP_PRGB	(5 << 12)	/* video
> mode
>> only */
>> +#define DSIM_MAIN_PIX_FORMAT_18BPP_LRGB	(6 << 12)	/* common */
>> +#define DSIM_MAIN_PIX_FORMAT_24BPP_RGB	(7 << 12)	/* common */
>> +
>> +/* Virtual channel number for sub display */
>> +#define DSIM_SUB_VC(x)			(((x) & 0x3) << 16)
>> +/* Virtual channel number for main display */
>> +#define DSIM_MAIN_VC(x)			(((x) & 0x3) << 18)
>> +#define DSIM_HSA_MODE_ENABLE		(1 << 20)
>> +#define DSIM_HSA_MODE_DISABLE		(0 << 20)
>> +#define DSIM_HBP_MODE_ENABLE		(1 << 21)
>> +#define DSIM_HBP_MODE_DISABLE		(0 << 21)
>> +#define DSIM_HFP_MODE_ENABLE		(1 << 22)
>> +#define DSIM_HFP_MODE_DISABLE		(0 << 22)
>> +#define DSIM_HSE_MODE_ENABLE		(1 << 23)
>> +#define DSIM_HSE_MODE_DISABLE		(0 << 23)
>> +#define DSIM_AUTO_MODE			(1 << 24)
>> +#define DSIM_CONFIGURATION_MODE		(0 << 24)
>> +#define DSIM_VIDEO_MODE			(1 << 25)
>> +#define DSIM_COMMAND_MODE		(0 << 25)
>> +#define DSIM_BURST_MODE			(1 << 26)
>> +#define DSIM_NON_BURST_MODE		(0 << 26)
>> +#define DSIM_SYNC_INFORM_PULSE		(1 << 27)
>> +#define DSIM_SYNC_INFORM_EVENT		(0 << 27)
>> +/* enable EoT packet generation for V1.01r11 */
>> +#define DSIM_EOT_R03_ENABLE		(0 << 28)
>> +/* disable EoT packet generation for V1.01r03 */
>> +#define DSIM_EOT_R03_DISABLE		(1 << 28)
>> +
>> +/* S5P_DSIM_ESCMODE */
>> +#define DSIM_STOP_STATE_CNT_SHIFT	(21)
>> +#define DSIM_STOP_STATE_CNT(x)		(((x) & 0x3ff) << \
>> +						DSIM_STOP_STATE_CNT_SHIFT)
>> +#define DSIM_FORCE_STOP_STATE_SHIFT	(20)
>> +#define DSIM_FORCE_BTA_SHIFT		(16)
>> +#define DSIM_CMD_LPDT_HS_MODE		(0 << 7)
>> +#define DSIM_CMD_LPDT_LP_MODE		(1 << 7)
>> +#define DSIM_TX_LPDT_HS_MODE		(0 << 6)
>> +#define DSIM_TX_LPDT_LP_MODE		(1 << 6)
>> +#define DSIM_TX_TRIGGER_RST_SHIFT	(4)
>> +#define DSIM_TX_UIPS_DAT_SHIFT		(3)
>> +#define DSIM_TX_UIPS_EXIT_SHIFT		(2)
>> +#define DSIM_TX_UIPS_CLK_SHIFT		(1)
>> +#define DSIM_TX_UIPS_CLK_EXIT_SHIFT	(0)
>> +
>> +/* S5P_DSIM_MDRESOL */
>> +#define DSIM_MAIN_STAND_BY		(1 << 31)
>> +#define DSIM_MAIN_NOT_READY		(0 << 31)
>> +#define DSIM_MAIN_VRESOL(x)		(((x) & 0x7ff) << 16)
>> +#define DSIM_MAIN_HRESOL(x)		(((x) & 0X7ff) << 0)
>> +
>> +/* S5P_DSIM_MVPORCH */
>> +#define DSIM_CMD_ALLOW_SHIFT		(28)
>> +#define DSIM_STABLE_VFP_SHIFT		(16)
>> +#define DSIM_MAIN_VBP_SHIFT		(0)
>> +#define DSIM_CMD_ALLOW_MASK		(0xf << DSIM_CMD_ALLOW_SHIFT)
>> +#define DSIM_STABLE_VFP_MASK		(0x7ff << DSIM_STABLE_VFP_SHIFT)
>> +#define DSIM_MAIN_VBP_MASK		(0x7ff << DSIM_MAIN_VBP_SHIFT)
>> +#define DSIM_CMD_ALLOW(x)		(((x) & 0xf) <<
> DSIM_CMD_ALLOW_SHIFT)
>> +#define DSIM_STABLE_VFP(x)		(((x) & 0x7ff) <<
> DSIM_STABLE_VFP_SHIFT)
>> +#define DSIM_MAIN_VBP(x)		(((x) & 0x7ff) <<
> DSIM_MAIN_VBP_SHIFT)
>> +
>> +/* S5P_DSIM_MHPORCH */
>> +#define DSIM_MAIN_HFP_SHIFT		(16)
>> +#define DSIM_MAIN_HBP_SHIFT		(0)
>> +#define DSIM_MAIN_HFP_MASK		((0xffff) << DSIM_MAIN_HFP_SHIFT)
>> +#define DSIM_MAIN_HBP_MASK		((0xffff) << DSIM_MAIN_HBP_SHIFT)
>> +#define DSIM_MAIN_HFP(x)		(((x) & 0xffff) <<
> DSIM_MAIN_HFP_SHIFT)
>> +#define DSIM_MAIN_HBP(x)		(((x) & 0xffff) <<
> DSIM_MAIN_HBP_SHIFT)
>> +
>> +/* S5P_DSIM_MSYNC */
>> +#define DSIM_MAIN_VSA_SHIFT		(22)
>> +#define DSIM_MAIN_HSA_SHIFT		(0)
>> +#define DSIM_MAIN_VSA_MASK		((0x3ff) << DSIM_MAIN_VSA_SHIFT)
>> +#define DSIM_MAIN_HSA_MASK		((0xffff) << DSIM_MAIN_HSA_SHIFT)
>> +#define DSIM_MAIN_VSA(x)		(((x) & 0x3ff) <<
> DSIM_MAIN_VSA_SHIFT)
>> +#define DSIM_MAIN_HSA(x)		(((x) & 0xffff) <<
> DSIM_MAIN_HSA_SHIFT)
>> +
>> +/* S5P_DSIM_SDRESOL */
>> +#define DSIM_SUB_STANDY_SHIFT		(31)
>> +#define DSIM_SUB_VRESOL_SHIFT		(16)
>> +#define DSIM_SUB_HRESOL_SHIFT		(0)
>> +#define DSIM_SUB_STANDY_MASK		((0x1) << DSIM_SUB_STANDY_SHIFT)
>> +#define DSIM_SUB_VRESOL_MASK		((0x7ff) << DSIM_SUB_VRESOL_SHIFT)
>> +#define DSIM_SUB_HRESOL_MASK		((0x7ff) << DSIM_SUB_HRESOL_SHIFT)
>> +#define DSIM_SUB_STANDY			(1 << DSIM_SUB_STANDY_SHIFT)
>> +#define DSIM_SUB_NOT_READY		(0 << DSIM_SUB_STANDY_SHIFT)
>> +#define DSIM_SUB_VRESOL(x)		(((x) & 0x7ff) <<
> DSIM_SUB_VRESOL_SHIFT)
>> +#define DSIM_SUB_HRESOL(x)		(((x) & 0x7ff) <<
> DSIM_SUB_HRESOL_SHIFT)
>> +
>> +/* S5P_DSIM_INTSRC */
>> +#define INTSRC_ERR_CONTENT_LP1		(1 << 0)
>> +#define INTSRC_ERR_CONTENT_LP0		(1 << 1)
>> +#define INTSRC_ERR_CONTROL0		(1 << 2)
>> +#define INTSRC_ERR_CONTROL1		(1 << 3)
>> +#define INTSRC_ERR_CONTROL2		(1 << 4)
>> +#define INTSRC_ERR_CONTROL3		(1 << 5)
>> +#define INTSRC_ERR_SYNC0		(1 << 6)
>> +#define INTSRC_ERR_SYNC1		(1 << 7)
>> +#define INTSRC_ERR_SYNC2		(1 << 8)
>> +#define INTSRC_ERR_SYNC3		(1 << 9)
>> +#define INTSRC_ERR_ESC0			(1 << 10)
>> +#define INTSRC_ERR_ESC1			(1 << 11)
>> +#define INTSRC_ERR_ESC2			(1 << 12)
>> +#define INTSRC_ERR_ESC3			(1 << 13)
>> +#define INTSRC_ERR_RX_CRC		(1 << 14)
>> +#define INTSRC_ERR_RX_ECC		(1 << 15)
>> +#define INTSRC_RX_ACK			(1 << 16)
>> +#define INTSRC_RX_TE			(1 << 17)
>> +#define INTSRC_RX_DAT_DONE		(1 << 18)
>> +#define INTSRC_TA_TOUT			(1 << 20)
>> +#define INTSRC_LPDR_TOUT		(1 << 21)
>> +#define INTSRC_FRAME_DONE		(1 << 24)
>> +#define INTSRC_BUS_TURN_OVER		(1 << 25)
>> +#define INTSRC_SYNC_OVERRIDE		(1 << 28)
>> +#define INTSRC_SFR_FIFO_EMPTY		(1 << 29)
>> +#define INTSRC_SW_RST_RELEASE		(1 << 30)
>> +#define INTSRC_PLL_STABLE		(1 << 31)
>> +
>> +/* S5P_DSIM_INTMSK */
>> +#define INTMSK_ERR_CONTENT_LP1		(1 << 0)
>> +#define INTMSK_ERR_CONTENT_LP0		(1 << 1)
>> +#define INTMSK_ERR_CONTROL0		(1 << 2)
>> +#define INTMSK_ERR_CONTROL1		(1 << 3)
>> +#define INTMSK_ERR_CONTROL2		(1 << 4)
>> +#define INTMSK_ERR_CONTROL3		(1 << 5)
>> +#define INTMSK_ERR_SYNC0		(1 << 6)
>> +#define INTMSK_ERR_SYNC1		(1 << 7)
>> +#define INTMSK_ERR_SYNC2		(1 << 8)
>> +#define INTMSK_ERR_SYNC3		(1 << 9)
>> +#define INTMSK_ERR_ESC0			(1 << 10)
>> +#define INTMSK_ERR_ESC1			(1 << 11)
>> +#define INTMSK_ERR_ESC2			(1 << 12)
>> +#define INTMSK_ERR_ESC3			(1 << 13)
>> +#define INTMSK_ERR_RX_CRC		(1 << 14)
>> +#define INTMSK_ERR_RX_ECC		(1 << 15)
>> +#define INTMSK_RX_ACK			(1 << 16)
>> +#define INTMSK_RX_TE			(1 << 17)
>> +#define INTMSK_RX_DAT_DONE		(1 << 18)
>> +#define INTMSK_TA_TOUT			(1 << 20)
>> +#define INTMSK_LPDR_TOUT		(1 << 21)
>> +#define INTMSK_FRAME_DONE		(1 << 24)
>> +#define INTMSK_BUS_TURN_OVER		(1 << 25)
>> +#define INTMSK_SFR_FIFO_EMPTY		(1 << 29)
>> +#define INTMSK_SW_RST_RELEASE		(1 << 30)
>> +#define INTMSK_PLL_STABLE		(1 << 31)
>> +
>> +/* S5P_DSIM_PKTHDR */
>> +#define DSIM_PACKET_HEADER_DI(x)	(((x) & 0xff) << 0)
>> +/* Word count lower byte for long packet */
>> +#define DSIM_PACKET_HEADER_DAT0(x)	(((x) & 0xff) << 8)
>> +/* Word count upper byte for long packet */
>> +#define DSIM_PACKET_HEADER_DAT1(x)	(((x) & 0xff) << 16)
>> +
>> +/* S5P_DSIM_FIFOCTRL */
>> +#define DSIM_MAIN_DISP_FIFO		(1 << 0)
>> +#define DSIM_SUB_DISP_FIFO		(1 << 1)
>> +#define DSIM_I80_FIFO			(1 << 2)
>> +#define DSIM_TX_SFR_FIFO		(1 << 3)
>> +#define DSIM_RX_FIFO			(1 << 4)
>> +#define MAIN_DISP_PAYLOAD_EMPTY		(1 << 8)
>> +#define MAIN_DISP_PAYLOAD_FULL		(1 << 9)
>> +#define MAIN_DISP_HEADER_EMPTY		(1 << 10)
>> +#define MAIN_DISP_HEADER_FULL		(1 << 11)
>> +#define SUB_DISP_PAYLOAD_EMPTY		(1 << 12)
>> +#define SUB_DISP_PAYLOAD_FULL		(1 << 13)
>> +#define SUB_DISP_HEADER_EMPTY		(1 << 14)
>> +#define SUB_DISP_HEADER_FULL		(1 << 15)
>> +#define I80_PALOAD_EMPTY		(1 << 16)
>> +#define I80_PALOAD_FULL			(1 << 17)
>> +#define I80_HEADER_EMPTY		(1 << 18)
>> +#define I80_HEADER_FULL			(1 << 19)
>> +#define SFR_PAYLOAD_EMPTY		(1 << 20)
>> +#define SFR_PAYLOAD_FULL		(1 << 21)
>> +#define SFR_HEADER_EMPTY		(1 << 22)
>> +#define SFR_HEADER_FULL			(1 << 23)
>> +#define DSIM_RX_DATA_EMPTY		(1 << 24)
>> +#define DSIM_RX_DATA_FULL		(1 << 25)
>> +
>> +/* S5P_DSIM_PHYACCHR */
>> +#define DSIM_AFC_CTL(x)			(((x) & 0x7) << 5)
>> +#define DSIM_AFC_ENABLE			(1 << 14)
>> +#define DSIM_AFC_DISABLE		(0 << 14)
>> +
>> +/* S5P_DSIM_PLLCTRL */
>> +#define DSIM_PMS_SHIFT			(1)
>> +#define DSIM_PLL_EN_SHIFT		(23)
>> +#define DSIM_FREQ_BAND_SHIFT		(24)
>> +#define DSIM_PMS(x)			(((x) & 0x7ffff) << DSIM_PMS_SHIFT)
>> +#define DSIM_FREQ_BAND(x)		(((x) & 0xf) <<
> DSIM_FREQ_BAND_SHIFT)
>> +
>> +#endif /* _REGS_DSIM_H */
>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>> index 27c1fb4..aa305c5 100644
>> --- a/drivers/video/Kconfig
>> +++ b/drivers/video/Kconfig
>> @@ -1996,6 +1996,13 @@ config FB_S3C2410_DEBUG
>>  	  Turn on debugging messages. Note that you can set/unset at run
> time
>>  	  through sysfs
>>
>> +config S5P_MIPI_DSI
> 
> How about S5P_MIPI_DSIM?
> 
S5P_MIPI_DSIM is too long, I think DSIM is better than it.

>> +	tristate "Samsung SoC MIPI-DSI support."
>> +	depends on ARCH_S5PV210
>> +	default n
>> +	---help---
>> +	  This enables support for MIPI-DSI device.
>> +
>>  config FB_NUC900
>>          bool "NUC900 LCD framebuffer support"
>>          depends on FB && ARCH_W90X900
> 
> I'm on holiday too...so don't have much time to review this.
> Will read remained part next week.
> 
> (snip)
> 
> Thanks.
> 
Thank you for your comments and I will look forward to your next comments.

My actions is as the following.
1. corrected naming, (MIPI -> DSIM)
2. header files in plat-s5p would be moved to driver and also removed
unnecessary codes.
3. code clean.

> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> 
