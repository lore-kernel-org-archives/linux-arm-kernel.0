From: spnlinux@gmail.com (Sylwester Nawrocki)
Date: Sat, 27 Nov 2010 18:58:48 +0100
Subject: [PATCH 4/4] S5PC110: add MIPI-DSI driver.
In-Reply-To: <1290496601-4949-1-git-send-email-inki.dae@samsung.com>
References: <1290496601-4949-1-git-send-email-inki.dae@samsung.com>
Message-ID: <4CF146D8.4080705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 11/23/2010 08:16 AM, Inki Dae wrote:
> driver features:
> . Maximum resolution ranges up to XGA (1024x760)
> . CSIS0 supports 1,2,3 or 4 data lanes
> . CSIS1 supports 1 or 2 data lanes
> . support pixel format : 16bpp, 18bpp packed,
>    18bpp loosely packed (3 byte format), and 24bpp
>    (now would use 24bpp)
> . support RGB interface for video image from display controller
> . support I80 interface for command mode image input from display controller
> . support PMS control interface for PLL to configure byte clock frequency
> . support Prescaler to generate escape clock from byte clock
>
> Signed-off-by: Inki Dae<inki.dae@samsung.com>
> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
> ---
>   arch/arm/plat-s5p/include/plat/dsim.h      |  470 +++++++++++++++++++
>   arch/arm/plat-s5p/include/plat/mipi_ddi.h  |   94 ++++
>   arch/arm/plat-s5p/include/plat/regs-dsim.h |  281 +++++++++++
>   drivers/video/Kconfig                      |    7 +
>   drivers/video/Makefile                     |    2 +
>   drivers/video/s5p-dsim.c                   |  463 +++++++++++++++++++
>   drivers/video/s5p_dsim_common.c            |  691 ++++++++++++++++++++++++++++
>   drivers/video/s5p_dsim_common.h            |   35 ++
>   drivers/video/s5p_dsim_lowlevel.c          |  569 +++++++++++++++++++++++
>   drivers/video/s5p_dsim_lowlevel.h          |  101 ++++
>   10 files changed, 2713 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/plat-s5p/include/plat/dsim.h
>   create mode 100644 arch/arm/plat-s5p/include/plat/mipi_ddi.h
>   create mode 100644 arch/arm/plat-s5p/include/plat/regs-dsim.h
>   create mode 100644 drivers/video/s5p-dsim.c
>   create mode 100644 drivers/video/s5p_dsim_common.c
>   create mode 100644 drivers/video/s5p_dsim_common.h
>   create mode 100644 drivers/video/s5p_dsim_lowlevel.c
>   create mode 100644 drivers/video/s5p_dsim_lowlevel.h
>
> diff --git a/arch/arm/plat-s5p/include/plat/dsim.h b/arch/arm/plat-s5p/include/plat/dsim.h
> new file mode 100644
> index 0000000..14bc13f
> --- /dev/null
> +++ b/arch/arm/plat-s5p/include/plat/dsim.h
> @@ -0,0 +1,470 @@
> +/* linux/arm/arch/plat-s5p/include/plat/dsim.h
> + *
> + * Platform data header for Samsung MIPI-DSIM.
> + *
> + * Copyright (c) 2009 Samsung Electronics
> + * InKi Dae<inki.dae@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef _DSIM_H
> +#define _DSIM_H
> +
> +#include<linux/device.h>
> +
> +/* h/w configuration */
> +#define MIPI_FIN		24000000
> +
> +#define DSIM_TRUE		1
> +#define DSIM_FALSE		0
> +
> +#define DSIM_HEADER_FIFO_SZ	16
> +
> +enum dsim_interface_type {
> +	DSIM_COMMAND = 0,
> +	DSIM_VIDEO = 1,
> +};
> +
> +enum dsim_state {
> +	DSIM_STATE_RESET = 0,
> +	DSIM_STATE_INIT = 1,
> +	DSIM_STATE_STOP = 2,
> +	DSIM_STATE_HSCLKEN = 3,
> +	DSIM_STATE_ULPS = 4,
> +};
> +
> +enum dsim_virtual_ch_no {
> +	DSIM_VIRTUAL_CH_0 = 0,
> +	DSIM_VIRTUAL_CH_1 = 1,
> +	DSIM_VIRTUAL_CH_2 = 2,
> +	DSIM_VIRTUAL_CH_3 = 3,
> +};

The enum type suggest the meaning so what is the point of
redefining numbers?

> +
> +enum dsim_video_mode_type {
> +	DSIM_NON_BURST_SYNC_EVENT = 0,
> +	DSIM_NON_BURST_SYNC_PULSE = 2,
> +	DSIM_BURST = 3,
> +	DSIM_NON_VIDEO_MODE = 4,
> +};
> +
> +enum dsim_fifo_state {
> +	DSIM_RX_DATA_FULL = (1<<  25),
> +	DSIM_RX_DATA_EMPTY = (1<<  24),
> +	SFR_HEADER_FULL = (1<<  23),
> +	SFR_HEADER_EMPTY = (1<<  22),
> +	SFR_PAYLOAD_FULL = (1<<  21),
> +	SFR_PAYLOAD_EMPTY = (1<<  20),
> +	I80_HEADER_FULL = (1<<  19),
> +	I80_HEADER_EMPTY = (1<<  18),
> +	I80_PALOAD_FULL = (1<<  17),
> +	I80_PALOAD_EMPTY = (1<<  16),
> +	SUB_DISP_HEADER_FULL = (1<<  15),
> +	SUB_DISP_HEADER_EMPTY = (1<<  14),
> +	SUB_DISP_PAYLOAD_FULL = (1<<  13),
> +	SUB_DISP_PAYLOAD_EMPTY = (1<<  12),
> +	MAIN_DISP_HEADER_FULL = (1<<  11),
> +	MAIN_DISP_HEADER_EMPTY = (1<<  10),
> +	MAIN_DISP_PAYLOAD_FULL = (1<<  9),
> +	MAIN_DISP_PAYLOAD_EMPTY = (1<<  8),
> +};
> +
> +enum dsim_no_of_data_lane {
> +	DSIM_DATA_LANE_1 = 0,
> +	DSIM_DATA_LANE_2 = 1,
> +	DSIM_DATA_LANE_3 = 2,
> +	DSIM_DATA_LANE_4 = 3,
> +};
> +
> +enum dsim_byte_clk_src {
> +	DSIM_PLL_OUT_DIV8 = 0,
> +	DSIM_EXT_CLK_DIV8 = 1,
> +	DSIM_EXT_CLK_BYPASS = 2,
> +};
> +
> +enum dsim_lane {
> +	DSIM_LANE_DATA0 = (1<<  0),
> +	DSIM_LANE_DATA1 = (1<<  1),
> +	DSIM_LANE_DATA2 = (1<<  2),
> +	DSIM_LANE_DATA3 = (1<<  3),
> +	DSIM_LANE_DATA_ALL = 0xf,
> +	DSIM_LANE_CLOCK = (1<<  4),
> +	DSIM_LANE_ALL = DSIM_LANE_CLOCK | DSIM_LANE_DATA_ALL,
> +};
> +
> +enum dsim_pixel_format {
> +	DSIM_CMD_3BPP = 0,
> +	DSIM_CMD_8BPP = 1,
> +	DSIM_CMD_12BPP = 2,
> +	DSIM_CMD_16BPP = 3,
> +	DSIM_VID_16BPP_565 = 4,
> +	DSIM_VID_18BPP_666PACKED = 5,
> +	DSIM_18BPP_666LOOSELYPACKED = 6,
> +	DSIM_24BPP_888 = 7,
> +};
> +
> +enum dsim_lane_state {
> +	DSIM_LANE_STATE_HS_READY,
> +	DSIM_LANE_STATE_ULPS,
> +	DSIM_LANE_STATE_STOP,
> +	DSIM_LANE_STATE_LPDT,
> +};
> +
> +enum dsim_transfer {
> +	DSIM_TRANSFER_NEITHER	= 0,
> +	DSIM_TRANSFER_BYCPU	= (1<<  7),
> +	DSIM_TRANSFER_BYLCDC	= (1<<  6),
> +	DSIM_TRANSFER_BOTH	= (0x3<<  6)
> +};
> +
> +enum dsim_lane_change {
> +	DSIM_NO_CHANGE = 0,
> +	DSIM_DATA_LANE_CHANGE = 1,
> +	DSIM_CLOCK_NALE_CHANGE = 2,
> +	DSIM_ALL_LANE_CHANGE = 3,
> +};
> +
> +enum dsim_int_src {
> +	DSIM_ALL_OF_INTR = 0xffffffff,
> +	DSIM_PLL_STABLE = (1<<  31),
> +};
> +
<snip>
> +
> +/**
> + * struct s5p_platform_dsim - interface to platform data for mipi-dsi driver.
> + *
> + * @clk_name: specifies clock name for mipi-dsi.
> + * @lcd_panel_name: specifies lcd panel name registered to mipi-dsi driver.
> + *	lcd panel driver searched would be actived.
> + * @mipi_1_1v_name: specifies mipi 1.1v regulator name.
> + * @mipi_1_8v_name: specifies mipi 1.8v regulator name.
> + * @platfrom_rev: specifies platform revision number.
> + *	revision number should become 1.
> + * @dsim_config: pointer of structure for configuring mipi-dsi controller.
> + * @dsim_lcd_info: pointer to structure for configuring
> + *	mipi-dsi based lcd panel.
> + * @mipi_power: callback pointer for enabling or disabling mipi power.
> + * @part_reset: callback pointer for reseting mipi phy.
> + * @init_d_phy: callback pointer for enabing d_phy of dsi master.
> + * @get_fb_frame_done: callback pointer for getting frame done status of the
> + *	display controller(FIMD).
> + * @trigger: callback pointer for triggering display controller(FIMD)
> + *	in case of CPU mode.
> + * @delay_for_stabilization: specifies stable time.
> + *	this delay needs when writing data on SFR
> + *	after mipi mode became LP mode.
> + */
> +struct s5p_platform_dsim {
> +	char	*clk_name;
> +	char	*mipi_1_1v_name;
> +	char	*mipi_1_8v_name;
> +	char	lcd_panel_name[64];
> +	unsigned int platform_rev;
> +
> +	struct dsim_config *dsim_info;
> +	struct dsim_lcd_config *dsim_lcd_info;
> +
> +	unsigned int delay_for_stabilization;
> +
> +	int (*mipi_power) (struct dsim_global *dsim,
> +		struct regulator *p_mipi_1_1v,
> +		struct regulator *p_mipi_1_8v, unsigned int enable);
> +	int (*part_reset) (struct dsim_global *dsim);
> +	int (*init_d_phy) (struct dsim_global *dsim);
> +	int (*get_fb_frame_done) (struct fb_info *info);
> +	void (*trigger) (struct fb_info *info);

Since we may want to get prepared for the flattened device tree
I would rather avoid defining fancy callbacks in the platform data struct.


<snip>
> +
> +#endif /* _MIPI_DDI_H */
> diff --git a/arch/arm/plat-s5p/include/plat/regs-dsim.h b/arch/arm/plat-s5p/include/plat/regs-dsim.h
> new file mode 100644
> index 0000000..c4bfab5
> --- /dev/null
> +++ b/arch/arm/plat-s5p/include/plat/regs-dsim.h
> @@ -0,0 +1,281 @@
> +/* linux/arch/arm/plat-s5p/include/plat/regs-dsim.h
> + *
> + * Register definition file for Samsung MIPI-DSIM driver
> + *
> + * InKi Dae<inki.dae@samsung.com>, Copyright (c) 2009 Samsung Electronics
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef _REGS_DSIM_H
> +#define _REGS_DSIM_H
> +
> +#define S5P_DSIM_STATUS		(0x0)	/* Status register */
> +#define S5P_DSIM_SWRST		(0x4)	/* Software reset register */
> +#define S5P_DSIM_CLKCTRL	(0x8)	/* Clock control register */
> +#define S5P_DSIM_TIMEOUT	(0xc)	/* Time out register */
> +#define S5P_DSIM_CONFIG		(0x10)	/* Configuration register */
> +#define S5P_DSIM_ESCMODE	(0x14)	/* Escape mode register */
> +
> +/* Main display image resolution register */
> +#define S5P_DSIM_MDRESOL	(0x18)
> +#define S5P_DSIM_MVPORCH	(0x1c)	/* Main display Vporch register */
> +#define S5P_DSIM_MHPORCH	(0x20)	/* Main display Hporch register */
> +#define S5P_DSIM_MSYNC		(0x24)	/* Main display sync area register */
> +
> +/* Sub display image resolution register */
> +#define S5P_DSIM_SDRESOL	(0x28)
> +#define S5P_DSIM_INTSRC		(0x2c)	/* Interrupt source register */
> +#define S5P_DSIM_INTMSK		(0x30)	/* Interrupt mask register */
> +#define S5P_DSIM_PKTHDR		(0x34)	/* Packet Header FIFO register */
> +#define S5P_DSIM_PAYLOAD	(0x38)	/* Payload FIFO register */
> +#define S5P_DSIM_RXFIFO		(0x3c)	/* Read FIFO register */
> +#define S5P_DSIM_FIFOTHLD	(0x40)	/* FIFO threshold level register */
> +#define S5P_DSIM_FIFOCTRL	(0x44)	/* FIFO status and control register */
> +
> +/* FIFO memory AC characteristic register */
> +#define S5P_DSIM_MEMACCHR	(0x48)
> +#define S5P_DSIM_PLLCTRL	(0x4c)	/* PLL control register */
> +#define S5P_DSIM_PLLTMR		(0x50)	/* PLL timer register */
> +#define S5P_DSIM_PHYACCHR	(0x54)	/* D-PHY AC characteristic register */
> +#define S5P_DSIM_PHYACCHR1	(0x58)	/* D-PHY AC characteristic register1 */
> +
> +/* DSIM_SWRST */
> +#define DSIM_FUNCRST		(1<<  16)
> +#define DSIM_SWRST		(1<<  0)
> +
> +/* S5P_DSIM_TIMEOUT */
> +#define DSIM_LPDR_TOUT_SHIFT	(0)
> +#define DSIM_BTA_TOUT_SHIFT	(16)
> +#define DSIM_LPDR_TOUT(x)	(((x)&  0xffff)<<  DSIM_LPDR_TOUT_SHIFT)
> +#define DSIM_BTA_TOUT(x)	(((x)&  0xff)<<  DSIM_BTA_TOUT_SHIFT)
> +
> +/* S5P_DSIM_CLKCTRL */
> +#define DSIM_ESC_PRESCALER_SHIFT	(0)
> +#define DSIM_LANE_ESC_CLKEN_SHIFT	(19)
> +#define DSIM_BYTE_CLKEN_SHIFT		(24)
> +#define DSIM_BYTE_CLK_SRC_SHIFT		(25)
> +#define DSIM_PLL_BYPASS_SHIFT		(27)
> +#define DSIM_ESC_CLKEN_SHIFT		(28)
> +#define DSIM_TX_REQUEST_HSCLK_SHIFT	(31)
> +#define DSIM_ESC_PRESCALER(x)		(((x)&  0xffff)<<  \
> +						DSIM_ESC_PRESCALER_SHIFT)
> +#define DSIM_LANE_ESC_CLKEN(x)		(((x)&  0x1f)<<  \
> +						DSIM_LANE_ESC_CLKEN_SHIFT)
> +#define DSIM_BYTE_CLK_ENABLE		(1<<  DSIM_BYTE_CLKEN_SHIFT)
> +#define DSIM_BYTE_CLK_DISABLE		(0<<  DSIM_BYTE_CLKEN_SHIFT)
> +#define DSIM_BYTE_CLKSRC(x)		(((x)&  0x3)<<  DSIM_BYTE_CLK_SRC_SHIFT)
> +#define DSIM_PLL_BYPASS_PLL		(0<<  DSIM_PLL_BYPASS_SHIFT)
> +#define DSIM_PLL_BYPASS_EXTERNAL	(1<<  DSIM_PLL_BYPASS_SHIFT)
> +#define DSIM_ESC_CLKEN_ENABLE		(1<<  DSIM_ESC_CLKEN_SHIFT)
> +#define DSIM_ESC_CLKEN_DISABLE		(0<<  DSIM_ESC_CLKEN_SHIFT)
> +
> +/* S5P_DSIM_CONFIG */
> +#define DSIM_LANE_EN_SHIFT		(0)
> +#define DSIM_NUM_OF_DATALANE_SHIFT	(5)
> +#define DSIM_SUB_PIX_FORMAT_SHIFT	(8)
> +#define DSIM_MAIN_PIX_FORMAT_SHIFT	(12)
> +#define DSIM_SUB_VC_SHIFT		(16)
> +#define DSIM_MAIN_VC_SHIFT		(18)
> +#define DSIM_HSA_MODE_SHIFT		(20)
> +#define DSIM_HBP_MODE_SHIFT		(21)
> +#define DSIM_HFP_MODE_SHIFT		(22)
> +#define DSIM_HSE_MODE_SHIFT		(23)
> +#define DSIM_AUTO_MODE_SHIFT		(24)
> +#define DSIM_VIDEO_MODE_SHIFT		(25)
> +#define DSIM_BURST_MODE_SHIFT		(26)
> +#define DSIM_SYNC_INFORM_SHIFT		(27)
> +#define DSIM_EOT_R03_SHIFT		(28)
> +#define DSIM_LANE_ENx(x)		((1)<<  x)
> +
> +/* in case of Gemunus, it should be 0x1. */
> +#define DSIM_NUM_OF_DATA_LANE(x)	((x)<<  5)
> +#define DSIM_SUB_PIX_FORMAT_3BPP	(0<<  8)	/* command mode only */
> +#define DSIM_SUB_PIX_FORMAT_8BPP	(1<<  8)	/* command mode only */
> +#define DSIM_SUB_PIX_FORMAT_12BPP	(2<<  8)	/* command mode only */
> +#define DSIM_SUB_PIX_FORMAT_16BPP	(3<<  8)	/* command mode only */
> +#define DSIM_SUB_PIX_FORMAT_16BPP_RGB	(4<<  8)	/* video mode only */
> +#define DSIM_SUB_PIX_FORMAT_18BPP_PRGB	(5<<  8)	/* video mode only */
> +#define DSIM_SUB_PIX_FORMAT_18BPP_LRGB	(6<<  8)	/* common */
> +#define DSIM_SUB_PIX_FORMAT_24BPP_RGB	(7<<  8)	/* common */
> +#define DSIM_MAIN_PIX_FORMAT_3BPP	(0<<  12)	/* command mode only */
> +#define DSIM_MAIN_PIX_FORMAT_8BPP	(1<<  12)	/* command mode only */
> +#define DSIM_MAIN_PIX_FORMAT_12BPP	(2<<  12)	/* command mode only */
> +#define DSIM_MAIN_PIX_FORMAT_16BPP	(3<<  12)	/* command mode only */
> +#define DSIM_MAIN_PIX_FORMAT_16BPP_RGB	(4<<  12)	/* video mode only */
> +#define DSIM_MAIN_PIX_FORMAT_18BPP_PRGB	(5<<  12)	/* video mode only */
> +#define DSIM_MAIN_PIX_FORMAT_18BPP_LRGB	(6<<  12)	/* common */
> +#define DSIM_MAIN_PIX_FORMAT_24BPP_RGB	(7<<  12)	/* common */
> +
> +/* Virtual channel number for sub display */
> +#define DSIM_SUB_VC(x)			(((x)&  0x3)<<  16)
> +/* Virtual channel number for main display */
> +#define DSIM_MAIN_VC(x)			(((x)&  0x3)<<  18)
> +#define DSIM_HSA_MODE_ENABLE		(1<<  20)
> +#define DSIM_HSA_MODE_DISABLE		(0<<  20)
> +#define DSIM_HBP_MODE_ENABLE		(1<<  21)
> +#define DSIM_HBP_MODE_DISABLE		(0<<  21)
> +#define DSIM_HFP_MODE_ENABLE		(1<<  22)
> +#define DSIM_HFP_MODE_DISABLE		(0<<  22)
> +#define DSIM_HSE_MODE_ENABLE		(1<<  23)
> +#define DSIM_HSE_MODE_DISABLE		(0<<  23)
> +#define DSIM_AUTO_MODE			(1<<  24)
> +#define DSIM_CONFIGURATION_MODE		(0<<  24)
> +#define DSIM_VIDEO_MODE			(1<<  25)
> +#define DSIM_COMMAND_MODE		(0<<  25)
> +#define DSIM_BURST_MODE			(1<<  26)
> +#define DSIM_NON_BURST_MODE		(0<<  26)
> +#define DSIM_SYNC_INFORM_PULSE		(1<<  27)
> +#define DSIM_SYNC_INFORM_EVENT		(0<<  27)
> +/* enable EoT packet generation for V1.01r11 */
> +#define DSIM_EOT_R03_ENABLE		(0<<  28)
> +/* disable EoT packet generation for V1.01r03 */
> +#define DSIM_EOT_R03_DISABLE		(1<<  28)
> +
> +/* S5P_DSIM_ESCMODE */
> +#define DSIM_STOP_STATE_CNT_SHIFT	(21)
> +#define DSIM_STOP_STATE_CNT(x)		(((x)&  0x3ff)<<  \
> +						DSIM_STOP_STATE_CNT_SHIFT)
> +#define DSIM_FORCE_STOP_STATE_SHIFT	(20)
> +#define DSIM_FORCE_BTA_SHIFT		(16)
> +#define DSIM_CMD_LPDT_HS_MODE		(0<<  7)
> +#define DSIM_CMD_LPDT_LP_MODE		(1<<  7)
> +#define DSIM_TX_LPDT_HS_MODE		(0<<  6)
> +#define DSIM_TX_LPDT_LP_MODE		(1<<  6)
> +#define DSIM_TX_TRIGGER_RST_SHIFT	(4)
> +#define DSIM_TX_UIPS_DAT_SHIFT		(3)
> +#define DSIM_TX_UIPS_EXIT_SHIFT		(2)
> +#define DSIM_TX_UIPS_CLK_SHIFT		(1)
> +#define DSIM_TX_UIPS_CLK_EXIT_SHIFT	(0)
> +
> +/* S5P_DSIM_MDRESOL */
> +#define DSIM_MAIN_STAND_BY		(1<<  31)
> +#define DSIM_MAIN_NOT_READY		(0<<  31)
> +#define DSIM_MAIN_VRESOL(x)		(((x)&  0x7ff)<<  16)
> +#define DSIM_MAIN_HRESOL(x)		(((x)&  0X7ff)<<  0)
> +
> +/* S5P_DSIM_MVPORCH */
> +#define DSIM_CMD_ALLOW_SHIFT		(28)
> +#define DSIM_STABLE_VFP_SHIFT		(16)
> +#define DSIM_MAIN_VBP_SHIFT		(0)
> +#define DSIM_CMD_ALLOW_MASK		(0xf<<  DSIM_CMD_ALLOW_SHIFT)
> +#define DSIM_STABLE_VFP_MASK		(0x7ff<<  DSIM_STABLE_VFP_SHIFT)
> +#define DSIM_MAIN_VBP_MASK		(0x7ff<<  DSIM_MAIN_VBP_SHIFT)
> +#define DSIM_CMD_ALLOW(x)		(((x)&  0xf)<<  DSIM_CMD_ALLOW_SHIFT)
> +#define DSIM_STABLE_VFP(x)		(((x)&  0x7ff)<<  DSIM_STABLE_VFP_SHIFT)
> +#define DSIM_MAIN_VBP(x)		(((x)&  0x7ff)<<  DSIM_MAIN_VBP_SHIFT)
> +
> +/* S5P_DSIM_MHPORCH */
> +#define DSIM_MAIN_HFP_SHIFT		(16)
> +#define DSIM_MAIN_HBP_SHIFT		(0)
> +#define DSIM_MAIN_HFP_MASK		((0xffff)<<  DSIM_MAIN_HFP_SHIFT)
> +#define DSIM_MAIN_HBP_MASK		((0xffff)<<  DSIM_MAIN_HBP_SHIFT)
> +#define DSIM_MAIN_HFP(x)		(((x)&  0xffff)<<  DSIM_MAIN_HFP_SHIFT)
> +#define DSIM_MAIN_HBP(x)		(((x)&  0xffff)<<  DSIM_MAIN_HBP_SHIFT)
> +
> +/* S5P_DSIM_MSYNC */
> +#define DSIM_MAIN_VSA_SHIFT		(22)
> +#define DSIM_MAIN_HSA_SHIFT		(0)
> +#define DSIM_MAIN_VSA_MASK		((0x3ff)<<  DSIM_MAIN_VSA_SHIFT)
> +#define DSIM_MAIN_HSA_MASK		((0xffff)<<  DSIM_MAIN_HSA_SHIFT)
> +#define DSIM_MAIN_VSA(x)		(((x)&  0x3ff)<<  DSIM_MAIN_VSA_SHIFT)
> +#define DSIM_MAIN_HSA(x)		(((x)&  0xffff)<<  DSIM_MAIN_HSA_SHIFT)
> +
> +/* S5P_DSIM_SDRESOL */
> +#define DSIM_SUB_STANDY_SHIFT		(31)
> +#define DSIM_SUB_VRESOL_SHIFT		(16)
> +#define DSIM_SUB_HRESOL_SHIFT		(0)
> +#define DSIM_SUB_STANDY_MASK		((0x1)<<  DSIM_SUB_STANDY_SHIFT)
> +#define DSIM_SUB_VRESOL_MASK		((0x7ff)<<  DSIM_SUB_VRESOL_SHIFT)
> +#define DSIM_SUB_HRESOL_MASK		((0x7ff)<<  DSIM_SUB_HRESOL_SHIFT)
> +#define DSIM_SUB_STANDY			(1<<  DSIM_SUB_STANDY_SHIFT)
> +#define DSIM_SUB_NOT_READY		(0<<  DSIM_SUB_STANDY_SHIFT)
> +#define DSIM_SUB_VRESOL(x)		(((x)&  0x7ff)<<  DSIM_SUB_VRESOL_SHIFT)
> +#define DSIM_SUB_HRESOL(x)		(((x)&  0x7ff)<<  DSIM_SUB_HRESOL_SHIFT)
> +
> +/* S5P_DSIM_INTSRC */
> +#define INTSRC_ERR_CONTENT_LP1		(1<<  0)
> +#define INTSRC_ERR_CONTENT_LP0		(1<<  1)
> +#define INTSRC_ERR_CONTROL0		(1<<  2)
> +#define INTSRC_ERR_CONTROL1		(1<<  3)
> +#define INTSRC_ERR_CONTROL2		(1<<  4)
> +#define INTSRC_ERR_CONTROL3		(1<<  5)
> +#define INTSRC_ERR_SYNC0		(1<<  6)
> +#define INTSRC_ERR_SYNC1		(1<<  7)
> +#define INTSRC_ERR_SYNC2		(1<<  8)
> +#define INTSRC_ERR_SYNC3		(1<<  9)
> +#define INTSRC_ERR_ESC0			(1<<  10)
> +#define INTSRC_ERR_ESC1			(1<<  11)
> +#define INTSRC_ERR_ESC2			(1<<  12)
> +#define INTSRC_ERR_ESC3			(1<<  13)
> +#define INTSRC_ERR_RX_CRC		(1<<  14)
> +#define INTSRC_ERR_RX_ECC		(1<<  15)
> +#define INTSRC_RX_ACK			(1<<  16)
> +#define INTSRC_RX_TE			(1<<  17)
> +#define INTSRC_RX_DAT_DONE		(1<<  18)
> +#define INTSRC_TA_TOUT			(1<<  20)
> +#define INTSRC_LPDR_TOUT		(1<<  21)
> +#define INTSRC_FRAME_DONE		(1<<  24)
> +#define INTSRC_BUS_TURN_OVER		(1<<  25)
> +#define INTSRC_SYNC_OVERRIDE		(1<<  28)
> +#define INTSRC_SFR_FIFO_EMPTY		(1<<  29)
> +#define INTSRC_SW_RST_RELEASE		(1<<  30)
> +#define INTSRC_PLL_STABLE		(1<<  31)
> +
> +/* S5P_DSIM_INTMSK */
> +#define INTMSK_ERR_CONTENT_LP1		(1<<  0)
> +#define INTMSK_ERR_CONTENT_LP0		(1<<  1)
> +#define INTMSK_ERR_CONTROL0		(1<<  2)
> +#define INTMSK_ERR_CONTROL1		(1<<  3)
> +#define INTMSK_ERR_CONTROL2		(1<<  4)
> +#define INTMSK_ERR_CONTROL3		(1<<  5)
> +#define INTMSK_ERR_SYNC0		(1<<  6)
> +#define INTMSK_ERR_SYNC1		(1<<  7)
> +#define INTMSK_ERR_SYNC2		(1<<  8)
> +#define INTMSK_ERR_SYNC3		(1<<  9)
> +#define INTMSK_ERR_ESC0			(1<<  10)
> +#define INTMSK_ERR_ESC1			(1<<  11)
> +#define INTMSK_ERR_ESC2			(1<<  12)
> +#define INTMSK_ERR_ESC3			(1<<  13)
> +#define INTMSK_ERR_RX_CRC		(1<<  14)
> +#define INTMSK_ERR_RX_ECC		(1<<  15)
> +#define INTMSK_RX_ACK			(1<<  16)
> +#define INTMSK_RX_TE			(1<<  17)
> +#define INTMSK_RX_DAT_DONE		(1<<  18)
> +#define INTMSK_TA_TOUT			(1<<  20)
> +#define INTMSK_LPDR_TOUT		(1<<  21)
> +#define INTMSK_FRAME_DONE		(1<<  24)
> +#define INTMSK_BUS_TURN_OVER		(1<<  25)
> +#define INTMSK_SFR_FIFO_EMPTY		(1<<  29)
> +#define INTMSK_SW_RST_RELEASE		(1<<  30)
> +#define INTMSK_PLL_STABLE		(1<<  31)
> +
> +/* S5P_DSIM_PKTHDR */
> +#define DSIM_PACKET_HEADER_DI(x)	(((x)&  0xff)<<  0)
> +/* Word count lower byte for long packet */
> +#define DSIM_PACKET_HEADER_DAT0(x)	(((x)&  0xff)<<  8)
> +/* Word count upper byte for long packet */
> +#define DSIM_PACKET_HEADER_DAT1(x)	(((x)&  0xff)<<  16)
> +
> +/* S5P_DSIM_FIFOCTRL */
> +#define DSIM_RX_FIFO			(1<<  4)
> +#define DSIM_TX_SFR_FIFO		(1<<  3)
> +#define DSIM_I80_FIFO			(1<<  2)
> +#define DSIM_SUB_DISP_FIFO		(1<<  1)
> +#define DSIM_MAIN_DISP_FIFO		(1<<  0)
> +
> +/* S5P_DSIM_PHYACCHR */
> +#define DSIM_AFC_CTL(x)			(((x)&  0x7)<<  5)
> +#define DSIM_AFC_ENABLE			(1<<  14)
> +#define DSIM_AFC_DISABLE		(0<<  14)
> +
> +/* S5P_DSIM_PLLCTRL */
> +#define DSIM_PMS_SHIFT			(1)
> +#define DSIM_PLL_EN_SHIFT		(23)
> +#define DSIM_FREQ_BAND_SHIFT		(24)
> +#define DSIM_PMS(x)			(((x)&  0x7ffff)<<  DSIM_PMS_SHIFT)
> +#define DSIM_FREQ_BAND(x)		(((x)&  0xf)<<  DSIM_FREQ_BAND_SHIFT)
> +
> +#endif /* _REGS_DSIM_H */

All these registers' definitions seem to be referenced only from
one driver in drivers/video/s5p_dsim*.c. How about creating s5p-dsim
directory in drivers/video/ and moving this whole pile of definitions
there?
Also please see this thread
http://www.mail-archive.com/linux-media at vger.kernel.org/msg21129.html
for more insight.

> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 27c1fb4..2017a0b 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1996,6 +1996,13 @@ config FB_S3C2410_DEBUG
>   	  Turn on debugging messages. Note that you can set/unset at run time
>   	  through sysfs
>
> +config S5P_MIPI_DSI
> +	tristate "Samsung SoC MIPI-DSI support."
> +	depends on FB_S3C&&  ARCH_S5PV210
> +	default n
> +	help
> +	  This enables support for MIPI-DSI device for samsung SoC S5PV210.
> +
>   config FB_NUC900
>           bool "NUC900 LCD framebuffer support"
>           depends on FB&&  ARCH_W90X900
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 485e8ed..6d1be1a 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -115,6 +115,8 @@ obj-$(CONFIG_FB_SH7760)		  += sh7760fb.o
>   obj-$(CONFIG_FB_IMX)              += imxfb.o
>   obj-$(CONFIG_FB_S3C)		  += s3c-fb.o
>   obj-$(CONFIG_FB_S3C2410)	  += s3c2410fb.o
> +obj-$(CONFIG_S5P_MIPI_DSI)	  += s5p-dsim.o s5p_dsim_common.o \
> +    					s5p_dsim_lowlevel.o
>   obj-$(CONFIG_FB_FSL_DIU)	  += fsl-diu-fb.o
>   obj-$(CONFIG_FB_COBALT)           += cobalt_lcdfb.o
>   obj-$(CONFIG_FB_PNX4008_DUM)	  += pnx4008/
> diff --git a/drivers/video/s5p-dsim.c b/drivers/video/s5p-dsim.c
> new file mode 100644
> index 0000000..076bc7d
> --- /dev/null
> +++ b/drivers/video/s5p-dsim.c
> @@ -0,0 +1,463 @@
> +/* linux/drivers/video/s5p-dsim.c
> + *
> + * Samsung MIPI-DSIM driver.
> + *
> + * InKi Dae,<inki.dae@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include<linux/module.h>
> +#include<linux/kernel.h>
> +#include<linux/errno.h>
> +#include<linux/clk.h>
> +#include<linux/mutex.h>
> +#include<linux/wait.h>
> +#include<linux/fs.h>
> +#include<linux/mm.h>
> +#include<linux/fb.h>
> +#include<linux/ctype.h>
> +#include<linux/platform_device.h>
> +#include<linux/io.h>
> +#include<linux/irq.h>
> +#include<linux/memory.h>
> +#include<linux/delay.h>
> +#include<linux/interrupt.h>
> +#include<linux/kthread.h>
> +#include<linux/regulator/consumer.h>
> +#include<linux/notifier.h>
> +
> +#include<plat/fb.h>
> +#include<plat/regs-dsim.h>
> +#include<plat/dsim.h>
> +#include<plat/mipi_ddi.h>
> +
> +#include<mach/map.h>
> +
> +#include "s5p_dsim_common.h"
> +
> +struct mipi_lcd_info {
> +	struct list_head	list;
> +	struct mipi_lcd_driver	*mipi_drv;
> +};
> +
> +static LIST_HEAD(lcd_info_list);
> +static DEFINE_MUTEX(mipi_lock);
> +
> +struct dsim_global dsim;

Using a global variable like this seems rather hacky.. The driver
will not be usable when there are more than one instance of the
s5p-dsim device in the system. Or is it impossible that there
could  be multiple entities of MIPI-DSIM in the SoC?
How about allocating an instance of struct dsim_global
(and perhaps changing it's name since it's not global any more?..)
during device probing and storing a pointer to it in driver's private
data in struct device/platform_device? Isn't that doable?


Regards,
Sylwester

> +
> +struct s5p_platform_dsim *to_dsim_plat(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	return (struct s5p_platform_dsim *)pdev->dev.platform_data;
> +}
> +
> +/*
> + * notifier callback function for fb_blank
> + * - this function would be called by device specific fb_blank.
> + */
> +static int s5p_dsim_notifier_callback(struct notifier_block *self,
> +	unsigned long event, void *data)
> +{
> +	switch (event) {
> +	case FB_BLANK_UNBLANK:
> +	case FB_BLANK_NORMAL:
> +		if (dsim.pd->mipi_power)
> +			dsim.pd->mipi_power(&dsim, dsim.r_mipi_1_1v,
> +				dsim.r_mipi_1_8v, 1);
> +
> +		clk_enable(dsim.clock);
> +
> +		if (dsim.mipi_drv->resume)
> +			dsim.mipi_drv->resume(dsim.dev);
> +
> +		s5p_dsim_init_dsim(&dsim);
> +		s5p_dsim_init_link(&dsim);
> +
> +		s5p_dsim_set_hs_enable(&dsim);
> +		s5p_dsim_set_data_transfer_mode(&dsim,
> +			DSIM_TRANSFER_BYCPU, 1);
> +
> +		/* it needs delay for stabilization */
> +		mdelay(dsim.pd->delay_for_stabilization);
> +
> +		if (dsim.mipi_drv->init)
> +			dsim.mipi_drv->init(dsim.dev);
> +		else
> +			dev_warn(dsim.dev, "init func is null.\n");
> +
> +		s5p_dsim_set_display_mode(&dsim, dsim.dsim_lcd_info, NULL);
> +
> +		s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TRANSFER_BYLCDC, 1);
> +		dsim.mipi_ddi_pd->resume_complete = 1;
> +
> +		dev_dbg(dsim.dev, "FB_BLANK_NORMAL or UNBLANK.\n");
> +
> +		break;
> +	case FB_BLANK_POWERDOWN:
> +		dsim.mipi_ddi_pd->resume_complete = 0;
> +
> +		if (dsim.mipi_drv->suspend)
> +			dsim.mipi_drv->suspend(dsim.dev);
> +
> +		clk_disable(dsim.clock);
> +
> +		if (dsim.pd->mipi_power)
> +			dsim.pd->mipi_power(&dsim, dsim.r_mipi_1_1v,
> +				dsim.r_mipi_1_8v, 0);
> +
> +		dev_dbg(dsim.dev, "FB_BLANK_POWERDOWN.\n");
> +		break;
> +	default:
> +		dev_warn(dsim.dev, "unknown FB_BLANK command.\n");
> +		break;
> +	}
> +
> +	return 0;
> +}

<snip>


-- 
Regards,
Sylwester
