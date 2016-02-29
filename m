From: architt@codeaurora.org (Archit Taneja)
Date: Tue, 1 Mar 2016 00:19:48 +0530
Subject: [PATCH v6 07/11] drm/hisilicon: Add designware dsi encoder driver
In-Reply-To: <1456476028-36880-8-git-send-email-xinliang.liu@linaro.org>
References: <1456476028-36880-1-git-send-email-xinliang.liu@linaro.org>
 <1456476028-36880-8-git-send-email-xinliang.liu@linaro.org>
Message-ID: <56D492CC.2090901@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2/26/2016 2:10 PM, Xinliang Liu wrote:
> Add DesignWare MIPI DSI Host Controller v1.02 encoder driver
> for hi6220 SoC.
>
> v6:
> - Change "pclk_dsi" to "pclk".
> v5: None.
> v4: None.
> v3:
> - Rename file name to dw_drm_dsi.c
> - Make encoder type as DRM_MODE_ENCODER_DSI.
> - A few cleanup.
> v2:
> - Remove abtraction layer.
>
> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> ---
>   drivers/gpu/drm/hisilicon/kirin/Kconfig      |   1 +
>   drivers/gpu/drm/hisilicon/kirin/Makefile     |   3 +-
>   drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 743 +++++++++++++++++++++++++++
>   drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h |  83 +++
>   4 files changed, 829 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
>   create mode 100644 drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h
>
> diff --git a/drivers/gpu/drm/hisilicon/kirin/Kconfig b/drivers/gpu/drm/hisilicon/kirin/Kconfig
> index 3ac4b8edeac1..de0d454c5c13 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/Kconfig
> +++ b/drivers/gpu/drm/hisilicon/kirin/Kconfig
> @@ -4,6 +4,7 @@ config DRM_HISI_KIRIN
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_CMA_HELPER
>   	select DRM_KMS_CMA_HELPER
> +	select DRM_MIPI_DSI
>   	help
>   	  Choose this option if you have a hisilicon Kirin chipsets(hi6220).
>   	  If M is selected the module will be called kirin-drm.
> diff --git a/drivers/gpu/drm/hisilicon/kirin/Makefile b/drivers/gpu/drm/hisilicon/kirin/Makefile
> index 2a61ab006ddb..5dcd0d4328b6 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/Makefile
> +++ b/drivers/gpu/drm/hisilicon/kirin/Makefile
> @@ -1,4 +1,5 @@
>   kirin-drm-y := kirin_drm_drv.o \
> -	       kirin_drm_ade.o
> +	       kirin_drm_ade.o \
> +	       dw_drm_dsi.o
>
>   obj-$(CONFIG_DRM_HISI_KIRIN) += kirin-drm.o
> diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> new file mode 100644
> index 000000000000..8329148cc89d
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> @@ -0,0 +1,743 @@
> +/*
> + * DesignWare MIPI DSI Host Controller v1.02 driver
> + *
> + * Copyright (c) 2016 Linaro Limited.
> + * Copyright (c) 2014-2016 Hisilicon Limited.
> + *
> + * Author:
> + *	Xinliang Liu <z.liuxinliang@hisilicon.com>
> + *	Xinliang Liu <xinliang.liu@linaro.org>
> + *	Xinwei Kong <kong.kongxinwei@hisilicon.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/component.h>
> +#include <linux/of_graph.h>
> +
> +#include <drm/drm_of.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_encoder_slave.h>
> +#include <drm/drm_atomic_helper.h>
> +
> +#include "dw_dsi_reg.h"
> +
> +#define MAX_TX_ESC_CLK		   (10)
> +#define ROUND(x, y) ((x) / (y) + ((x) % (y) * 10 / (y) >= 5 ? 1 : 0))
> +#define PHY_REF_CLK_RATE   19200000
> +#define PHY_REF_CLK_PERIOD_PS (1000000000 / (PHY_REF_CLK_RATE / 1000))
> +
> +#define encoder_to_dsi(encoder) \
> +	container_of(encoder, struct dw_dsi, encoder)
> +#define host_to_dsi(host) \
> +	container_of(host, struct dw_dsi, host)
> +
> +struct mipi_phy_params {
> +	u32 clk_t_lpx;
> +	u32 clk_t_hs_prepare;
> +	u32 clk_t_hs_zero;
> +	u32 clk_t_hs_trial;
> +	u32 clk_t_wakeup;
> +	u32 data_t_lpx;
> +	u32 data_t_hs_prepare;
> +	u32 data_t_hs_zero;
> +	u32 data_t_hs_trial;
> +	u32 data_t_ta_go;
> +	u32 data_t_ta_get;
> +	u32 data_t_wakeup;
> +	u32 hstx_ckg_sel;
> +	u32 pll_fbd_div5f;
> +	u32 pll_fbd_div1f;
> +	u32 pll_fbd_2p;
> +	u32 pll_enbwt;
> +	u32 pll_fbd_p;
> +	u32 pll_fbd_s;
> +	u32 pll_pre_div1p;
> +	u32 pll_pre_p;
> +	u32 pll_vco_750M;
> +	u32 pll_lpf_rs;
> +	u32 pll_lpf_cs;
> +	u32 clklp2hs_time;
> +	u32 clkhs2lp_time;
> +	u32 lp2hs_time;
> +	u32 hs2lp_time;
> +	u32 clk_to_data_delay;
> +	u32 data_to_clk_delay;
> +	u32 lane_byte_clk_kHz;
> +	u32 clk_division;
> +};
> +
> +struct dsi_hw_ctx {
> +	void __iomem *base;
> +	struct clk *pclk;
> +};
> +
> +struct dw_dsi {
> +	struct drm_encoder encoder;
> +	struct drm_display_mode cur_mode;
> +	struct dsi_hw_ctx *ctx;
> +	struct mipi_phy_params phy;
> +
> +	u32 lanes;
> +	enum mipi_dsi_pixel_format format;
> +	unsigned long mode_flags;
> +	bool enable;
> +};
> +
> +struct dsi_data {
> +	struct dw_dsi dsi;
> +	struct dsi_hw_ctx ctx;
> +};
> +
> +struct dsi_phy_range {
> +	u32 min_range_kHz;
> +	u32 max_range_kHz;
> +	u32 pll_vco_750M;
> +	u32 hstx_ckg_sel;
> +};
> +
> +static const struct dsi_phy_range dphy_range_info[] = {
> +	{   46875,    62500,   1,    7 },
> +	{   62500,    93750,   0,    7 },
> +	{   93750,   125000,   1,    6 },
> +	{  125000,   187500,   0,    6 },
> +	{  187500,   250000,   1,    5 },
> +	{  250000,   375000,   0,    5 },
> +	{  375000,   500000,   1,    4 },
> +	{  500000,   750000,   0,    4 },
> +	{  750000,  1000000,   1,    0 },
> +	{ 1000000,  1500000,   0,    0 }
> +};
> +
> +static void dsi_get_phy_params(u32 phy_freq_kHz,
> +			       struct mipi_phy_params *phy)
> +{
> +	u32 ui = 0;
> +	u32 cfg_clk_ps = PHY_REF_CLK_PERIOD_PS;
> +	u32 i = 0;
> +	u32 q_pll = 1;
> +	u32 m_pll = 0;
> +	u32 n_pll = 0;
> +	u32 r_pll = 1;
> +	u32 m_n = 0;
> +	u32 m_n_int = 0;
> +	u64 f_kHz;
> +	u64 temp;
> +	u64 tmp_kHz = phy_freq_kHz;
> +
> +	do {
> +		f_kHz = tmp_kHz;
> +
> +		/* Find the PLL clock range from the table */
> +		for (i = 0; i < ARRAY_SIZE(dphy_range_info); i++)
> +			if (f_kHz >= dphy_range_info[i].min_range_kHz &&
> +			    f_kHz <= dphy_range_info[i].max_range_kHz)
> +				break;
> +
> +		if (i == ARRAY_SIZE(dphy_range_info)) {
> +			DRM_ERROR("%lldkHz out of range\n", f_kHz);
> +			return;
> +		}
> +
> +		phy->pll_vco_750M = dphy_range_info[i].pll_vco_750M;
> +		phy->hstx_ckg_sel = dphy_range_info[i].hstx_ckg_sel;
> +
> +		if (phy->hstx_ckg_sel <= 7 &&
> +		    phy->hstx_ckg_sel >= 4)
> +			q_pll = 0x10 >> (7 - phy->hstx_ckg_sel);
> +
> +		temp = f_kHz * (u64)q_pll * (u64)cfg_clk_ps;
> +		m_n_int = temp / (u64)1000000000;
> +		m_n = (temp % (u64)1000000000) / (u64)100000000;
> +
> +		if (m_n_int % 2 == 0) {
> +			if (m_n * 6 >= 50) {
> +				n_pll = 2;
> +				m_pll = (m_n_int + 1) * n_pll;
> +			} else if (m_n * 6 >= 30) {
> +				n_pll = 3;
> +				m_pll = m_n_int * n_pll + 2;
> +			} else {
> +				n_pll = 1;
> +				m_pll = m_n_int * n_pll;
> +			}
> +		} else {
> +			if (m_n * 6 >= 50) {
> +				n_pll = 1;
> +				m_pll = (m_n_int + 1) * n_pll;
> +			} else if (m_n * 6 >= 30) {
> +				n_pll = 1;
> +				m_pll = (m_n_int + 1) * n_pll;
> +			} else if (m_n * 6 >= 10) {
> +				n_pll = 3;
> +				m_pll = m_n_int * n_pll + 1;
> +			} else {
> +				n_pll = 2;
> +				m_pll = m_n_int * n_pll;
> +			}
> +		}
> +
> +		if (n_pll == 1) {
> +			phy->pll_fbd_p = 0;
> +			phy->pll_pre_div1p = 1;
> +		} else {
> +			phy->pll_fbd_p = n_pll;
> +			phy->pll_pre_div1p = 0;
> +		}
> +
> +		if (phy->pll_fbd_2p <= 7 && phy->pll_fbd_2p >= 4)
> +			r_pll = 0x10 >> (7 - phy->pll_fbd_2p);
> +
> +		if (m_pll == 2) {
> +			phy->pll_pre_p = 0;
> +			phy->pll_fbd_s = 0;
> +			phy->pll_fbd_div1f = 0;
> +			phy->pll_fbd_div5f = 1;
> +		} else if (m_pll >= 2 * 2 * r_pll && m_pll <= 2 * 4 * r_pll) {
> +			phy->pll_pre_p = m_pll / (2 * r_pll);
> +			phy->pll_fbd_s = 0;
> +			phy->pll_fbd_div1f = 1;
> +			phy->pll_fbd_div5f = 0;
> +		} else if (m_pll >= 2 * 5 * r_pll && m_pll <= 2 * 150 * r_pll) {
> +			if (((m_pll / (2 * r_pll)) % 2) == 0) {
> +				phy->pll_pre_p =
> +					(m_pll / (2 * r_pll)) / 2 - 1;
> +				phy->pll_fbd_s =
> +					(m_pll / (2 * r_pll)) % 2 + 2;
> +			} else {
> +				phy->pll_pre_p =
> +					(m_pll / (2 * r_pll)) / 2;
> +				phy->pll_fbd_s =
> +					(m_pll / (2 * r_pll)) % 2;
> +			}
> +			phy->pll_fbd_div1f = 0;
> +			phy->pll_fbd_div5f = 0;
> +		} else {
> +			phy->pll_pre_p = 0;
> +			phy->pll_fbd_s = 0;
> +			phy->pll_fbd_div1f = 0;
> +			phy->pll_fbd_div5f = 1;
> +		}
> +
> +		f_kHz = (u64)1000000000 * (u64)m_pll /
> +			((u64)cfg_clk_ps * (u64)n_pll * (u64)q_pll);
> +
> +		if (f_kHz >= phy_freq_kHz)
> +			break;
> +
> +		tmp_kHz += 10;
> +
> +	} while (1);
> +
> +	ui = 1000000 / f_kHz;
> +
> +	phy->clk_t_lpx = ROUND(50, 8 * ui);
> +	phy->clk_t_hs_prepare = ROUND(133, 16 * ui) - 1;
> +
> +	phy->clk_t_hs_zero = ROUND(262, 8 * ui);
> +	phy->clk_t_hs_trial = 2 * (ROUND(60, 8 * ui) - 1);
> +	phy->clk_t_wakeup = ROUND(1000000, (cfg_clk_ps / 1000) - 1);
> +	if (phy->clk_t_wakeup > 0xff)
> +		phy->clk_t_wakeup = 0xff;
> +	phy->data_t_wakeup = phy->clk_t_wakeup;
> +	phy->data_t_lpx = phy->clk_t_lpx;
> +	phy->data_t_hs_prepare = ROUND(125 + 10 * ui, 16 * ui) - 1;
> +	phy->data_t_hs_zero = ROUND(105 + 6 * ui, 8 * ui);
> +	phy->data_t_hs_trial = 2 * (ROUND(60 + 4 * ui, 8 * ui) - 1);
> +	phy->data_t_ta_go = 3;
> +	phy->data_t_ta_get = 4;
> +
> +	phy->pll_enbwt = 1;
> +	phy->clklp2hs_time = ROUND(407, 8 * ui) + 12;
> +	phy->clkhs2lp_time = ROUND(105 + 12 * ui, 8 * ui);
> +	phy->lp2hs_time = ROUND(240 + 12 * ui, 8 * ui) + 1;
> +	phy->hs2lp_time = phy->clkhs2lp_time;
> +	phy->clk_to_data_delay = 1 + phy->clklp2hs_time;
> +	phy->data_to_clk_delay = ROUND(60 + 52 * ui, 8 * ui) +
> +				phy->clkhs2lp_time;
> +
> +	phy->lane_byte_clk_kHz = f_kHz / 8;
> +	phy->clk_division = phy->lane_byte_clk_kHz / MAX_TX_ESC_CLK;
> +	if (phy->lane_byte_clk_kHz % MAX_TX_ESC_CLK)
> +		phy->clk_division++;
> +}
> +
> +static u32 dsi_get_dpi_color_coding(enum mipi_dsi_pixel_format format)
> +{
> +	u32 val;
> +
> +	/* TODO: only support RGB888 now, to support more */
> +	switch (format) {
> +	case MIPI_DSI_FMT_RGB888:
> +		val = DSI_24BITS_1;
> +		break;
> +	default:
> +		val = DSI_24BITS_1;
> +		break;
> +	}
> +
> +	return val;
> +}
> +
> +/*
> + * dsi phy reg write function
> + */
> +static void dsi_phy_tst_set(void __iomem *base, u32 reg, u32 val)
> +{
> +	writel(reg, base + PHY_TST_CTRL1);
> +	/* reg addr written at first */
> +	wmb();
> +	writel(0x02, base + PHY_TST_CTRL0);
> +	/* cmd1 sent for write */
> +	wmb();
> +	writel(0x00, base + PHY_TST_CTRL0);
> +	/* cmd2 sent for write */
> +	wmb();
> +	writel(val, base + PHY_TST_CTRL1);
> +	/* Then write data */
> +	wmb();
> +	writel(0x02, base + PHY_TST_CTRL0);
> +	/* cmd2 sent for write */
> +	wmb();
> +	writel(0x00, base + PHY_TST_CTRL0);

You can use iowrite32 here to prevent calling wmb before each
write.

> +}
> +
> +static void dsi_set_mipi_phy(void __iomem *base,
> +			     struct mipi_phy_params *phy,
> +			     u32 lanes)
> +{
> +	u32 delay_count;
> +	u32 val;
> +	u32 i;
> +
> +	/* set lanes value */
> +	val = (lanes - 1) | (PHY_STOP_WAIT_TIME << 8);
> +	writel(val, base + PHY_IF_CFG);
> +
> +	/* set phy clk division */
> +	val = readl(base + CLKMGR_CFG) | phy->clk_division;
> +	writel(val, base + CLKMGR_CFG);
> +
> +	/* clean up phy set param */
> +	writel(0, base + PHY_RSTZ);
> +	writel(0, base + PHY_TST_CTRL0);
> +	writel(1, base + PHY_TST_CTRL0);
> +	writel(0, base + PHY_TST_CTRL0);
> +
> +	/* clock lane Timing control - TLPX */
> +	dsi_phy_tst_set(base, 0x10010, phy->clk_t_lpx);
> +
> +	/* clock lane Timing control - THS-PREPARE */
> +	dsi_phy_tst_set(base, 0x10011, phy->clk_t_hs_prepare);
> +
> +	/* clock lane Timing control - THS-ZERO */
> +	dsi_phy_tst_set(base, 0x10012, phy->clk_t_hs_zero);
> +
> +	/* clock lane Timing control - THS-TRAIL */
> +	dsi_phy_tst_set(base, 0x10013, phy->clk_t_hs_trial);
> +
> +	/* clock lane Timing control - TWAKEUP */
> +	dsi_phy_tst_set(base, 0x10014, phy->clk_t_wakeup);
> +
> +	/* data lane */
> +	for (i = 0; i < lanes; i++) {
> +		/* Timing control - TLPX */
> +		dsi_phy_tst_set(base, 0x10020 + (i << 4), phy->data_t_lpx);

Some macros here for these PHY registers would be nice.

> +
> +		/* Timing control - THS-PREPARE */
> +		dsi_phy_tst_set(base, 0x10021 + (i << 4),
> +				phy->data_t_hs_prepare);
> +
> +		/* Timing control - THS-ZERO */
> +		dsi_phy_tst_set(base, 0x10022 + (i << 4), phy->data_t_hs_zero);
> +
> +		/* Timing control - THS-TRAIL */
> +		dsi_phy_tst_set(base, 0x10023 + (i << 4), phy->data_t_hs_trial);
> +
> +		/* Timing control - TTA-GO */
> +		dsi_phy_tst_set(base, 0x10024 + (i << 4), phy->data_t_ta_go);
> +
> +		/* Timing control - TTA-GET */
> +		dsi_phy_tst_set(base, 0x10025 + (i << 4), phy->data_t_ta_get);
> +
> +		/* Timing control - TWAKEUP */
> +		dsi_phy_tst_set(base, 0x10026 + (i << 4), phy->data_t_wakeup);

Something like the macro below would be more readable here:

#define PHY_TWAKEUP(i) (0x10026 + (i << 4))

Looks good otherwise.

Archit

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
