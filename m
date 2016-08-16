From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 15 Aug 2016 18:00:45 -0700
Subject: [PATCH 2/4] qcom: ipq4019: ASoC clock driver support
In-Reply-To: <1468566426-19598-3-git-send-email-njaigane@codeaurora.org>
References: <1468566426-19598-1-git-send-email-njaigane@codeaurora.org>
 <1468566426-19598-3-git-send-email-njaigane@codeaurora.org>
Message-ID: <20160816010045.GY361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15, njaigane at codeaurora.org wrote:
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 2a25f4e..aec6ab4 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -4,6 +4,7 @@ clk-qcom-y += common.o
>  clk-qcom-y += clk-regmap.o
>  clk-qcom-y += clk-alpha-pll.o
>  clk-qcom-y += clk-pll.o
> +clk-qcom-y += clk-qcapll.o
>  clk-qcom-y += clk-rcg.o
>  clk-qcom-y += clk-rcg2.o
>  clk-qcom-y += clk-branch.o
> @@ -15,6 +16,7 @@ clk-qcom-$(CONFIG_QCOM_GDSC) += gdsc.o
>  obj-$(CONFIG_APQ_GCC_8084) += gcc-apq8084.o
>  obj-$(CONFIG_APQ_MMCC_8084) += mmcc-apq8084.o
>  obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
> +obj-$(CONFIG_IPQ_ADCC_4019) += adcc-ipq4019.o

Alphabetize on config please.

>  obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
>  obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
>  obj-$(CONFIG_MSM_GCC_8660) += gcc-msm8660.o
> diff --git a/drivers/clk/qcom/adcc-ipq4019.c b/drivers/clk/qcom/adcc-ipq4019.c
> new file mode 100644
> index 0000000..0ed90e1
> --- /dev/null
> +++ b/drivers/clk/qcom/adcc-ipq4019.c
> @@ -0,0 +1,700 @@
> +/*
> + * Copyright (c) 2014 - 2016 The Linux Foundation. All rights reserved.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#include <dt-bindings/clock/qca,adcc-ipq4019.h>
> +
> +#include "common.h"
> +#include "clk-regmap.h"
> +#include "clk-rcg.h"
> +#include "clk-qcapll.h"
> +#include "clk-branch.h"
> +#include "reset.h"
> +
> +#define AUDIO_PLL_CONFIG_REG				0x00000
> +#define AUDIO_PLL_MODULATION_REG			0x00004
> +#define AUDIO_PLL_MOD_STEP_REG				0x00008
> +#define CURRENT_AUDIO_PLL_MODULATION_REG		0x0000c
> +#define AUDIO_PLL_CONFIG1_REG				0x00010
> +#define AUDIO_ATB_SETTING_REG				0x00014
> +#define AUDIO_RXB_CFG_MUXR_REG				0x000cc
> +#define AUDIO_RXB_MISC_REG				0x000d0
> +#define AUDIO_RXB_CBCR_REG				0x000D4
> +#define AUDIO_RXM_CMD_RCGR_REG				0x000e8
> +#define AUDIO_RXM_CFG_RCGR_REG				0x000ec
> +#define AUDIO_RXM_MISC_REG				0x000f0
> +#define AUDIO_RXM_CBCR_REG				0x000F4
> +#define AUDIO_TXB_CFG_MUXR_REG				0x0010c
> +#define AUDIO_TXB_MISC_REG				0x00110
> +#define AUDIO_TXB_CBCR_REG				0x00114
> +#define AUDIO_SPDIF_MISC_REG				0x00118
> +#define AUDIO_SPDIF_CBCR_REG				0x0011c
> +#define AUDIO_SPDIFDIV2_MISC_REG			0x00120
> +#define AUDIO_SPDIFDIV2_CBCR_REG			0x00124
> +#define AUDIO_TXM_CMD_RCGR_REG				0x00128
> +#define AUDIO_TXM_CFG_RCGR_REG				0x0012c
> +#define AUDIO_TXM_MISC_REG				0x00130
> +#define AUDIO_TXM_CBCR_REG				0x00134
> +#define AUDIO_SAMPLE_CBCR_REG				0x00154
> +#define AUDIO_PCM_CMD_RCGR_REG				0x00168
> +#define AUDIO_PCM_CFG_RCGR_REG				0x0016C
> +#define AUDIO_PCM_MISC_REG				0x00170
> +#define AUDIO_PCM_CBCR_REG				0x00174
> +#define AUDIO_XO_CBCR_REG				0x00194
> +#define AUDIO_SPDIFINFAST_CMD_RCGR_REG			0x001A8
> +#define AUDIO_SPDIFINFAST_CFG_RCGR_REG			0x001AC
> +#define AUDIO_SPDIFINFAST_CBCR_REG			0x001B4
> +#define AUDIO_AHB_CBCR_REG				0x001c8
> +#define AUDIO_AHB_I2S0_CBCR_REG				0x001cc
> +#define AUDIO_AHB_I2S3_CBCR_REG				0x001d0
> +#define AUDIO_AHB_MBOX0_CBCR_REG			0x001D4
> +#define AUDIO_AHB_MBOX3_CBCR_REG			0x001d8

Lowercase hex only please. Also, just put the registers in the
structures directly. The defines are just a waste of lines.

> +
> +#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }

Is this used?

> +#define P_XO 0
> +#define ADSS_PLL 1
> +#define MCLK_MCLK_IN 2
> +#define BCLK_BCLK_IN 2
> +#define BCLK_MCLK_IN 3

Please preface all the sources with P_ so we know they're
"parents".

> +
> +static struct parent_map adcc_xo_adpll_padmclk_map[] = {
> +	{  P_XO, 0 },
> +	{  ADSS_PLL, 1 },
> +	{  MCLK_MCLK_IN, 2 },
> +};
> +
> +static const char * const adcc_xo_adpll_padmclk[] = {
> +	"xo",
> +	"adss_pll",
> +	"padmclk",
> +};
> +
> +static struct parent_map adcc_xo_adpll_padbclk_padmclk_map[] = {
> +	{  P_XO, 0 },
> +	{  ADSS_PLL, 1 },
> +	{  MCLK_MCLK_IN, 2 },
> +	{  BCLK_MCLK_IN, 3 },
> +};
> +
> +static const char * const adcc_xo_adpll_padbclk_padmclk[] = {
> +	"xo",
> +	"adss_pll",
> +	"padbclk",
> +	"padmclk",
> +};
> +
> +static struct parent_map adcc_xo_adpll_map[] = {
> +	{  P_XO, 0 },
> +	{  ADSS_PLL, 1 },
> +};
> +
> +static const char * const adcc_xo_adpll[] = {
> +	"xo",
> +	"adss_pll",
> +};
> +
> +static const struct pll_freq_tbl adss_freq_tbl[] = {
> +	{163840000, 1, 5, 40, 0x3D708},
> +	{180633600, 1, 5, 45, 0xA234},
> +	{184320000, 1, 5, 46, 0x51E9},
> +	{196608000, 1, 5, 49, 0x9bA6},
> +	{197568000, 1, 5, 49, 0x19168},

Spaces around braces please.

	{ 197568000, 1, 5, 49, 0x19168 },

> +	{}
> +};
> +
> +static struct clk_qcapll adss_pll_src = {
> +	.config_reg		= AUDIO_PLL_CONFIG_REG,
> +	.mod_reg		= AUDIO_PLL_MODULATION_REG,
> +	.modstep_reg		= AUDIO_PLL_MOD_STEP_REG,
> +	.current_mod_pll_reg	= CURRENT_AUDIO_PLL_MODULATION_REG,
> +	.config1_reg		= AUDIO_PLL_CONFIG1_REG,
> +	.freq_tbl = adss_freq_tbl,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "adss_pll",
> +		.parent_names = (const char *[]){ "xo" },
> +		.num_parents = 1,
> +		.ops = &clk_qcapll_ops,
> +		.flags = CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_m_clk[] = {
> +	{255, MCLK_MCLK_IN, 1, 0, 0},
> +	{2048000, ADSS_PLL, 96, 0, 0},
> +	{2822400, ADSS_PLL, 64, 0, 0},
> +	{4096000, ADSS_PLL, 48, 0, 0},
> +	{5644800, ADSS_PLL, 32, 0, 0},
> +	{6144000, ADSS_PLL, 32, 0, 0},
> +	{8192000, ADSS_PLL, 24, 0, 0},
> +	{11289600, ADSS_PLL, 16, 0, 0},
> +	{12288000, ADSS_PLL, 16, 0, 0},
> +	{14112000, ADSS_PLL, 14, 0, 0},
> +	{15360000, ADSS_PLL, 12, 0, 0},
> +	{16384000, ADSS_PLL, 12, 0, 0},
> +	{20480000, ADSS_PLL, 8, 0, 0},
> +	{22579200, ADSS_PLL, 8, 0, 0},
> +	{24576000, ADSS_PLL, 8, 0, 0},
> +	{30720000, ADSS_PLL, 6, 0, 0},
> +	{ }
> +};
> +
> +static struct clk_cdiv_rcg2 rxm_clk_src = {
> +	.cdiv.offset = AUDIO_RXM_MISC_REG,
> +	.cdiv.shift = 4,
> +	.cdiv.mask = 0xf,
> +	.cmd_rcgr = AUDIO_RXM_CMD_RCGR_REG,
> +	.hid_width = 5,
> +	.parent_map = adcc_xo_adpll_padmclk_map,
> +	.freq_tbl = ftbl_m_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "rxm_clk_src",
> +		.parent_names = adcc_xo_adpll_padmclk,
> +		.num_parents = 3,
> +		.ops = &clk_cdiv_rcg2_ops,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_branch adcc_rxm_clk_src = {
> +	.halt_reg = AUDIO_RXM_CBCR_REG,
> +	.clkr = {
> +		.enable_reg = AUDIO_RXM_CBCR_REG,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "adcc_rxm_clk_src",
> +			.parent_names = (const char *[]){"rxm_clk_src"},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_SET_RATE_PARENT,
> +		},
> +	},
> +};
> +
> +static struct clk_cdiv_rcg2 txm_clk_src = {
> +	.cdiv.offset = AUDIO_TXM_MISC_REG,
> +	.cdiv.shift = 4,
> +	.cdiv.mask = 0xf,
> +	.cmd_rcgr = AUDIO_TXM_CMD_RCGR_REG,
> +	.hid_width = 5,
> +	.parent_map = adcc_xo_adpll_padmclk_map,
> +	.freq_tbl = ftbl_m_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "txm_clk_src",
> +		.parent_names = adcc_xo_adpll_padmclk,
> +		.num_parents = 3,
> +		.ops = &clk_cdiv_rcg2_ops,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_branch adcc_txm_clk_src = {
> +	.halt_reg = AUDIO_TXM_CBCR_REG,
> +	.clkr = {
> +		.enable_reg = AUDIO_TXM_CBCR_REG,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "adcc_txm_clk_src",
> +			.parent_names = (const char *[]){
> +				"txm_clk_src",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_SET_RATE_PARENT,
> +		},
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_bclk_clk[] = {
> +	{254, BCLK_BCLK_IN, 1, 0, 0},
> +	{255, BCLK_MCLK_IN, 1, 0, 0},
> +	{512000, ADSS_PLL, 384, 0, 0},
> +	{705600, ADSS_PLL, 256, 0, 0},
> +	{1024000, ADSS_PLL, 192, 0, 0},
> +	{1411200, ADSS_PLL, 128, 0, 0},
> +	{1536000, ADSS_PLL, 128, 0, 0},
> +	{2048000, ADSS_PLL, 96, 0, 0},
> +	{2822400, ADSS_PLL, 64, 0, 0},
> +	{3072000, ADSS_PLL, 64, 0, 0},
> +	{4096000, ADSS_PLL, 48, 0, 0},
> +	{5120000, ADSS_PLL, 32, 0, 0},
> +	{5644800, ADSS_PLL, 32, 0, 0},
> +	{6144000, ADSS_PLL, 32, 0, 0},
> +	{7056000, ADSS_PLL, 24, 0, 0},
> +	{7680000, ADSS_PLL, 24, 0, 0},
> +	{8192000, ADSS_PLL, 24, 0, 0},
> +	{10240000, ADSS_PLL, 16, 0, 0},
> +	{11289600, ADSS_PLL, 16, 0, 0},
> +	{12288000, ADSS_PLL, 16, 0, 0},
> +	{14112000, ADSS_PLL, 16, 0, 0},
> +	{15360000, ADSS_PLL, 12, 0, 0},
> +	{16384000, ADSS_PLL, 12, 0, 0},
> +	{22579200, ADSS_PLL, 8, 0, 0},
> +	{24576000, ADSS_PLL,  8, 0, 0},
> +	{30720000, ADSS_PLL,  6, 0, 0},
> +	{ }
> +};
> +
> +static struct clk_muxr_misc txb_clk_src = {
> +	.misc.offset = AUDIO_TXB_MISC_REG,
> +	.misc.shift = 1,
> +	.misc.mask = 0x1FF,
> +	.muxr.offset = AUDIO_TXB_CFG_MUXR_REG,
> +	.muxr.shift = 8,
> +	.muxr.mask = 0x7,
> +	.parent_map = adcc_xo_adpll_padbclk_padmclk_map,
> +	.freq_tbl = ftbl_bclk_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "txb_clk_src",
> +		.parent_names = adcc_xo_adpll_padbclk_padmclk,
> +		.num_parents = 4,
> +		.ops = &clk_muxr_misc_ops,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_branch adcc_txb_clk_src = {
> +	.halt_reg = AUDIO_TXB_CBCR_REG,
> +	.clkr = {
> +		.enable_reg = AUDIO_TXB_CBCR_REG,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "adcc_txb_clk_src",
> +			.parent_names = (const char *[]){
> +				"txb_clk_src",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_SET_RATE_PARENT,
> +		},
> +	},
> +};
> +
> +static struct clk_muxr_misc rxb_clk_src = {
> +	.misc.offset = AUDIO_RXB_MISC_REG,
> +	.misc.shift = 1,
> +	.misc.mask = 0x1FF,
> +	.muxr.offset = AUDIO_RXB_CFG_MUXR_REG,
> +	.muxr.shift = 8,
> +	.muxr.mask = 0x7,
> +	.parent_map = adcc_xo_adpll_padbclk_padmclk_map,
> +	.freq_tbl = ftbl_bclk_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "rxb_clk_src",
> +		.parent_names = adcc_xo_adpll_padbclk_padmclk,
> +		.num_parents = 4,
> +		.ops = &clk_muxr_misc_ops,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +
> +static struct clk_branch adcc_rxb_clk_src = {
> +	.halt_reg = AUDIO_RXB_CBCR_REG,
> +	.clkr = {
> +		.enable_reg = AUDIO_RXB_CBCR_REG,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "adcc_rxb_clk_src",
> +			.parent_names = (const char *[]){
> +				"rxb_clk_src",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_SET_RATE_PARENT,
> +		},
> +	},
> +};
> +
> +
> +
> +static const struct freq_tbl ftbl_adcc_pcm_clk[] = {
> +	{8192000, ADSS_PLL, 24, 0, 0},
> +	{16384000, ADSS_PLL, 12, 0, 0},
> +	{ }
> +};
> +
> +static struct clk_cdiv_rcg2 pcm_clk_src = {
> +	.cdiv.offset = AUDIO_PCM_MISC_REG,
> +	.cdiv.shift = 4,
> +	.cdiv.mask = 0xf,
> +	.cmd_rcgr = AUDIO_PCM_CMD_RCGR_REG,
> +	.hid_width = 5,
> +	.parent_map = adcc_xo_adpll_map,
> +	.freq_tbl = ftbl_adcc_pcm_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "pcm_clk_src",
> +		.parent_names = adcc_xo_adpll,
> +		.num_parents = 2,
> +		.ops = &clk_cdiv_rcg2_ops,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +
> +
> +static struct clk_branch adcc_pcm_clk_src = {
> +	.halt_reg = AUDIO_PCM_CBCR_REG,
> +	.clkr = {
> +		.enable_reg = AUDIO_PCM_CBCR_REG,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "adcc_pcm_clk_src",
> +			.parent_names = (const char *[]){
> +				"pcm_clk_src",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		},
> +	},
> +};
> +
> +
> +

Remove all but one newline here.

> +static const struct freq_tbl ftbl_adcc_spdifinfast_clk[] = {
> +	F(49152000, ADSS_PLL, 0x04, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 spdifinfast_src = {
> +	.cmd_rcgr = AUDIO_SPDIFINFAST_CMD_RCGR_REG,
> +	.hid_width = 5,
> +	.parent_map = adcc_xo_adpll_map,
> +	.freq_tbl = ftbl_adcc_spdifinfast_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "spdifinfast_src",
> +		.parent_names = adcc_xo_adpll,
> +		.num_parents = 2,
> +		.ops = &clk_rcg2_ops,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_branch adcc_spdifinfast_src = {
> +	.halt_reg = AUDIO_SPDIFINFAST_CBCR_REG,
> +	.clkr = {
> +		.enable_reg = AUDIO_SPDIFINFAST_CBCR_REG,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "adcc_spdifinfast_src",
> +			.parent_names = (const char *[]){
> +				"spdifinfast_src",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		},
> +	},
> +};
> +
> +static struct clk_muxr_misc spdif_src = {
> +	.misc.offset = AUDIO_SPDIF_MISC_REG,
> +	.misc.shift = 1,
> +	.misc.mask = 0x1FF,
> +	.muxr.offset = AUDIO_TXB_CFG_MUXR_REG,
> +	.muxr.shift = 8,
> +	.muxr.mask = 0x7,
> +	.parent_map = adcc_xo_adpll_padbclk_padmclk_map,
> +	.freq_tbl = ftbl_m_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "spdif_src",
> +		.parent_names = adcc_xo_adpll_padbclk_padmclk,
> +		.num_parents = 4,
> +		.ops = &clk_muxr_misc_ops,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_branch adcc_spdif_src = {
> +	.halt_reg = AUDIO_SPDIF_CBCR_REG,
> +	.clkr = {
> +		.enable_reg = AUDIO_SPDIF_CBCR_REG,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "adcc_spdif_src",
> +			.parent_names = (const char *[]){
> +				"spdif_src",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		},
> +	},
> +};
> +
> +static struct clk_muxr_misc spdifdiv2_src = {
> +	.misc.offset = AUDIO_SPDIFDIV2_MISC_REG,
> +	.misc.shift = 1,
> +	.misc.mask = 0x1FF,
> +	.parent_map = adcc_xo_adpll_padbclk_padmclk_map,
> +	.muxr.offset = AUDIO_TXB_CFG_MUXR_REG,
> +	.muxr.shift = 8,
> +	.muxr.mask = 0x7,
> +	.freq_tbl = ftbl_bclk_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "spdifdiv2_src",
> +		.parent_names = adcc_xo_adpll_padbclk_padmclk,
> +		.num_parents = 4,
> +		.ops = &clk_muxr_misc_ops,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_branch adcc_spdifdiv2_src = {
> +	.halt_reg = AUDIO_SPDIFDIV2_CBCR_REG,
> +	.clkr = {
> +		.enable_reg = AUDIO_SPDIFDIV2_CBCR_REG,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "adcc_spdifdiv2_src",
> +			.parent_names = (const char *[]){
> +				"spdifdiv2_src",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		},
> +	},
> +};
> +
> +static struct clk_branch adcc_sample_src = {
> +	.halt_reg = AUDIO_SAMPLE_CBCR_REG,
> +	.clkr = {
> +		.enable_reg = AUDIO_SAMPLE_CBCR_REG,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "adcc_sample_src",
> +			.parent_names = (const char *[]){
> +				"pcnoc_clk_src",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		},
> +	},
> +};
> +
> +static struct clk_branch adcc_xo_src = {
> +	.halt_reg = AUDIO_XO_CBCR_REG,
> +	.clkr = {
> +		.enable_reg = AUDIO_XO_CBCR_REG,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "adcc_xo_src",
> +			.parent_names = (const char *[]){
> +				"XO",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		},
> +	},
> +};
> +
> +
> +static struct clk_branch adcc_ahb_src = {
> +	.halt_reg = AUDIO_AHB_CBCR_REG,
> +	.clkr = {
> +		.enable_reg = AUDIO_AHB_CBCR_REG,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "adcc_audio_ahb_src",
> +			.parent_names = (const char *[]){
> +				"pcnoc_clk_src",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_IGNORE_UNUSED,
> +		},
> +	},
> +};
> +
> +static struct clk_branch adcc_ahb_i2s0_src = {
> +	.halt_reg = AUDIO_AHB_I2S0_CBCR_REG,
> +	.clkr = {
> +		.enable_reg = AUDIO_AHB_I2S0_CBCR_REG,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "adcc_audio_ahb_i2s0",
> +			.parent_names = (const char *[]){
> +				"pcnoc_clk_src",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_IGNORE_UNUSED,
> +		},
> +	},
> +};
> +
> +static struct clk_branch adcc_ahb_i2s3_src = {
> +	.halt_reg = AUDIO_AHB_I2S3_CBCR_REG,
> +	.clkr = {
> +		.enable_reg = AUDIO_AHB_I2S3_CBCR_REG,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "adcc_audio_ahb_i2s3",
> +			.parent_names = (const char *[]){
> +				"pcnoc_clk_src",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_IGNORE_UNUSED,
> +		},
> +	},
> +};
> +
> +static struct clk_branch adcc_ahb_mbox0_src = {
> +	.halt_reg = AUDIO_AHB_MBOX0_CBCR_REG,
> +	.clkr = {
> +		.enable_reg = AUDIO_AHB_MBOX0_CBCR_REG,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "adcc_audio_mbox0_src",
> +			.parent_names = (const char *[]){
> +				"pcnoc_clk_src",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_IGNORE_UNUSED,
> +		},
> +	},
> +};
> +
> +static struct clk_branch adcc_ahb_mbox3_src = {
> +	.halt_reg = AUDIO_AHB_MBOX3_CBCR_REG,
> +	.clkr = {
> +		.enable_reg = AUDIO_AHB_MBOX3_CBCR_REG,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "adcc_ahb_mbox3_src",
> +			.parent_names = (const char *[]){
> +				"pcnoc_clk_src",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_IGNORE_UNUSED,
> +		},
> +	},
> +};
> +
> +static struct clk_regmap *adcc_ipq4019_clocks[] = {
> +	[ADSS_PLL_SRC]				= &adss_pll_src.clkr,
> +	[RXM_CLK_SRC]				= &rxm_clk_src.clkr,
> +	[ADCC_RXM_CLK_SRC]			= &adcc_rxm_clk_src.clkr,
> +	[TXM_CLK_SRC]				= &txm_clk_src.clkr,
> +	[ADCC_TXM_CLK_SRC]			= &adcc_txm_clk_src.clkr,
> +	[TXB_CLK_SRC]				= &txb_clk_src.clkr,
> +	[ADCC_TXB_CLK_SRC]			= &adcc_txb_clk_src.clkr,
> +	[RXB_CLK_SRC]				= &rxb_clk_src.clkr,
> +	[ADCC_RXB_CLK_SRC]			= &adcc_rxb_clk_src.clkr,
> +	[PCM_CLK_SRC]				= &pcm_clk_src.clkr,
> +	[ADCC_PCM_CLK_SRC]			= &adcc_pcm_clk_src.clkr,
> +	[AUDIO_SPDIFINFAST_SRC]			= &spdifinfast_src.clkr,
> +	[ADCC_AUDIO_SPDIFINFAST_SRC]		= &adcc_spdifinfast_src.clkr,
> +	[ADCC_AUDIO_AHB_SRC]			= &adcc_ahb_src.clkr,
> +	[ADCC_AHB_I2S0]				= &adcc_ahb_i2s0_src.clkr,
> +	[ADCC_AHB_I2S3]				= &adcc_ahb_i2s3_src.clkr,
> +	[ADCC_AHB_MBOX0_SRC]			= &adcc_ahb_mbox0_src.clkr,
> +	[ADCC_AHB_MBOX3_SRC]			= &adcc_ahb_mbox3_src.clkr,
> +	[SPDIF_SRC]				= &spdif_src.clkr,
> +	[ADCC_SPDIF_SRC]			= &adcc_spdif_src.clkr,
> +	[SPDIFDIV2_SRC]				= &spdifdiv2_src.clkr,
> +	[ADCC_SPDIFDIV2_SRC]			= &adcc_spdifdiv2_src.clkr,
> +	[ADCC_SAMPLE_SRC]			= &adcc_sample_src.clkr,
> +	[ADCC_XO_SRC]				= &adcc_xo_src.clkr,
> +};
> +
> +static const struct qcom_reset_map adcc_ipq4019_resets[] = {
> +};

Are there any resets? If not, please update the common.c file to
handle that case and not register a reset provider.

> +
> +struct cdiv_fixed {

Is this structure used?

> +	char	*name;
> +	char	*pname;
> +	u32	flags;
> +	u32	mult;
> +	u32	div;
> +};
> +
> +static const struct regmap_config adcc_ipq4019_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= 0x2ff,
> +	.fast_io	= true,
> +};
> +
> +static const struct qcom_cc_desc adcc_ipq4019_desc = {
> +	.config = &adcc_ipq4019_regmap_config,
> +	.clks = adcc_ipq4019_clocks,
> +	.num_clks = ARRAY_SIZE(adcc_ipq4019_clocks),
> +	.resets = adcc_ipq4019_resets,
> +	.num_resets = ARRAY_SIZE(adcc_ipq4019_resets),
> +};
> +
> +static const struct of_device_id adcc_ipq4019_match_table[] = {
> +	{ .compatible = "qcom,adcc-ipq4019" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gcc_ipq4019_match_table);
> +
> +static int adcc_ipq4019_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +
> +	/* High speed external clock */
> +	clk_register_fixed_rate(dev, "xo", NULL, CLK_IS_ROOT, 48000000);

This should come from the board, don't register it here.

> +
> +	/* External padbclk & padmclk clock.These [254 & 255] frequencies are

Multiline comments put the "/*" on a separate line from the rest
of the text.

> +	 * taken as tokens only to support the INPUTS from PADS.
> +	 * Reference: ADSS_HPG/HDD document for IPQ4019
> +	 */
> +	clk_register_fixed_rate(dev, "padbclk", NULL, CLK_IS_ROOT, 254);
> +	clk_register_fixed_rate(dev, "padmclk", NULL, CLK_IS_ROOT, 255);

This looks like a hack. What's going on?

> +
> +	regmap = qcom_cc_map(pdev, &adcc_ipq4019_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return qcom_cc_really_probe(pdev, &adcc_ipq4019_desc, regmap);

You don't have to call qcom_cc_map() and qcom_cc_really_probe()
if you don't need to do anything with the mapping in this probe.
Just call qcom_cc_probe().

> +}
> +
> +static int adcc_ipq4019_remove(struct platform_device *pdev)
> +{
> +	qcom_cc_remove(pdev);
> +	return 0;

This is useless to call now, and in fact it's been deleted.

> +}

> diff --git a/drivers/clk/qcom/clk-qcapll.c b/drivers/clk/qcom/clk-qcapll.c
> new file mode 100644
> index 0000000..fac45c8
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-qcapll.c
> @@ -0,0 +1,197 @@
> +/*
> + * Copyright (c) 2013, 2015-2016 The Linux Foundation. All rights reserved.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/export.h>
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +
> +#include <asm/div64.h>
> +
> +#include "clk-qcapll.h"
> +
> +#define PLL_CONFIG1_SRESET_L		BIT(0)
> +#define PLL_MODULATION_START		BIT(0)
> +#define PLL_CONFIG_PLLPWD		BIT(5)
> +
> +#define PLL_POSTDIV_MASK	0x380
> +#define PLL_POSTDIV_SHFT	7
> +#define PLL_PLLPWD_MASK         0x20
> +#define PLL_PLLPWD_SHFT         5
> +#define PLL_REFDIV_MASK		0x7
> +#define PLL_REFDIV_SHFT		0
> +#define PLL_TGT_INT_SHFT	1
> +#define PLL_TGT_INT_MASK	0x3FE
> +#define PLL_TGT_FRAC_MASK	0x1FFFF800
> +#define PLL_TGT_FRAC_SHFT	11
> +
> +
> +static int clk_qcapll_enable(struct clk_hw *hw)
> +{
> +	struct clk_qcapll *pll = to_clk_qcapll(hw);
> +	int ret;
> +
> +	/* Enable PLL bypass mode. */
> +	ret = regmap_update_bits(pll->clkr.regmap, pll->config_reg,
> +				 PLL_CONFIG_PLLPWD, 0);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void clk_qcapll_disable(struct clk_hw *hw)
> +{
> +	struct clk_qcapll *pll = to_clk_qcapll(hw);
> +
> +	/* Disable PLL bypass mode. */
> +	regmap_update_bits(pll->clkr.regmap, pll->config_reg, PLL_CONFIG_PLLPWD,
> +			   0x1);
> +}
> +
> +static int clk_qcapll_is_enabled(struct clk_hw *hw)
> +{
> +	u32 config;
> +	struct clk_qcapll *pll = to_clk_qcapll(hw);
> +
> +	regmap_read(pll->clkr.regmap, pll->config_reg, &config);
> +	return config & PLL_PLLPWD_MASK;
> +}
> +
> +static unsigned long
> +clk_qcapll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct clk_qcapll *pll = to_clk_qcapll(hw);
> +	u32 ref_div, post_plldiv, tgt_div_frac, tgt_div_int;
> +	u32 config, mod_reg;
> +
> +	regmap_read(pll->clkr.regmap, pll->config_reg, &config);
> +	regmap_read(pll->clkr.regmap, pll->mod_reg, &mod_reg);
> +
> +	ref_div = (config & PLL_REFDIV_MASK) >> PLL_REFDIV_SHFT;
> +	post_plldiv = (config & PLL_POSTDIV_SHFT) >> PLL_POSTDIV_SHFT;

Why did we read these if we don't do math?

> +	tgt_div_frac = (mod_reg & PLL_TGT_FRAC_MASK) >>  PLL_TGT_FRAC_SHFT;
> +	tgt_div_int = (mod_reg & PLL_TGT_INT_MASK) >> PLL_TGT_INT_SHFT;
> +
> +	/*
> +	 * FICO = (Fref / (refdiv+1)) * (Ninv + Nfrac[17:5]/2^13
> +	 *	   + Nfrac[4:0]/(25*2^13)).
> +	 *
> +	 * we use this Lookups to get the precise frequencies as we need

why is Lookups capitalized?

> +	 * the calculation would need use of some math functions to get
> +	 * precise values which will add to the complexity. Hence, a simple
> +	 * lookup table based on the Fract values

Why is Fract capitalized? What does Fract even mean?

> +	 */
> +
> +	if (tgt_div_frac == 0x3D708)
> +		return 163840000;
> +	else if (tgt_div_frac == 0xA234)
> +		return 180633600;
> +	else if (tgt_div_frac == 0x51E9)
> +		return 184320000;
> +	else if (tgt_div_frac == 0x9bA6)
> +		return 196608000;
> +	else if (tgt_div_frac == 0x19168)
> +		return 197568000;

Math is ok, this isn't performance sensitive code.

> +
> +	return 0;
> +}
> +
> +static const
> +struct pll_freq_tbl *find_freq(const struct pll_freq_tbl *f, unsigned long rate)
> +{
> +	if (!f)
> +		return NULL;
> +
> +	for (; f->freq; f++)
> +		if (rate <= f->freq)
> +			return f;
> +
> +	return NULL;
> +}

We have qcom_find_freq for this I thought? Ah I see that this is
the same named structure but qca pll specific. Please rename the
struct and function to be qca specific.

> +
> +static int
> +clk_qcapll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
> +{
> +	struct clk_qcapll *pll = to_clk_qcapll(hw);
> +	const struct pll_freq_tbl *f;
> +	unsigned long rate;
> +
> +	f = find_freq(pll->freq_tbl, req->rate);
> +	if (!f)
> +		rate = clk_qcapll_recalc_rate(hw, req->best_parent_rate);
> +	else
> +		rate = f->freq;
> +
> +	req->best_parent_rate = req->rate = rate;
> +
> +	return 0;
> +}
> +
> +static int
> +clk_qcapll_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long p_rate)
> +{
> +	struct clk_qcapll *pll = to_clk_qcapll(hw);
> +	const struct pll_freq_tbl *f;
> +	u32 val, mask;
> +
> +	f = find_freq(pll->freq_tbl, rate);
> +	if (!f)
> +		return -EINVAL;
> +
> +	if (clk_qcapll_is_enabled(hw))
> +		clk_qcapll_disable(hw);
> +
> +	regmap_write(pll->clkr.regmap, pll->config1_reg, 0xc);
> +	udelay(2);
> +	regmap_write(pll->clkr.regmap, pll->config1_reg, 0xd);
> +
> +	val = f->postplldiv << PLL_POSTDIV_SHFT;
> +	val |= f->refdiv << PLL_REFDIV_SHFT;
> +
> +	mask = PLL_POSTDIV_MASK | PLL_REFDIV_MASK;
> +	regmap_update_bits(pll->clkr.regmap, pll->config_reg, mask, val);
> +
> +	clk_qcapll_enable(hw);
> +
> +	val = f->tgt_div_int << PLL_TGT_INT_SHFT;
> +	val |= f->tgt_div_frac << PLL_TGT_FRAC_SHFT;
> +
> +	mask = PLL_TGT_FRAC_MASK | PLL_TGT_INT_MASK;
> +	regmap_update_bits(pll->clkr.regmap, pll->mod_reg, mask, val);
> +
> +	/* Start the PLL to initiate the Modulation. */

Please drop full stop.

> +	regmap_update_bits(pll->clkr.regmap, pll->mod_reg,
> +						PLL_MODULATION_START, 0);
> +
> +	/*
> +	 * Wait until PLL is locked. Refer DPLL document for IPQ4019.
> +	 * This is recommended settling time for the PLL.
> +	 */
> +	udelay(50);
> +
> +	return 0;
> +}
> +
> +const struct clk_ops clk_qcapll_ops = {
> +	.enable = clk_qcapll_enable,
> +	.disable = clk_qcapll_disable,
> +	.is_enabled = clk_qcapll_is_enabled,
> +	.recalc_rate = clk_qcapll_recalc_rate,
> +	.determine_rate = clk_qcapll_determine_rate,
> +	.set_rate = clk_qcapll_set_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_qcapll_ops);
> diff --git a/drivers/clk/qcom/clk-qcapll.h b/drivers/clk/qcom/clk-qcapll.h
> new file mode 100644
> index 0000000..c0304ac
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-qcapll.h
> @@ -0,0 +1,60 @@
> +/*
> + * Copyright (c) 2013, 2015-2016 The Linux Foundation. All rights reserved.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __QCOM_CLK_QCA_PLL_H__
> +#define __QCOM_CLK_QCA_PLL_H__
> +
> +#include <linux/clk-provider.h>
> +#include "clk-regmap.h"
> +
> +/**
> + * struct pll_freq_tbl - PLL frequency table

Missing freq. Perhaps we should expand the general pll_freq_tbl
structure with these parameters? Or use a union for different
types of pll settings? Or just rename it to be qca specific.

> + * @postplldiv: postplldiv value
> + * @refdiv: refdiv value
> + * @tgt_div_int: tgt_div_int value
> + * @tgt_div_frac: tgt_div_frac values
> + */
> +struct pll_freq_tbl {
> +	unsigned long freq;
> +	u8 postplldiv;
> +	u8 refdiv;
> +	u8 tgt_div_int;
> +	u32 tgt_div_frac;
> +};
> +
> +/**
> + * struct clk_pll - phase locked loop (PLL)

It isn't called that.

> + * @config_reg: config register
> + * @mode_reg: mode register
> + * @status_reg: status register
> + * @status_bit: ANDed with @status_reg to determine if PLL is enabled
> + * @freq_tbl: PLL frequency table
> + * @hw: handle between common and hardware-specific interfaces

This doesn't even exist. clkr instead?

> + */
> +struct clk_qcapll {
> +	u32 config_reg;
> +	u32 mod_reg;
> +	u32 modstep_reg;
> +	u32 current_mod_pll_reg;
> +	u32 config1_reg;
> +
> +	const struct pll_freq_tbl *freq_tbl;
> +	struct clk_regmap clkr;
> +};
> +
> +extern const struct clk_ops clk_qcapll_ops;
> +
> +#define to_clk_qcapll(_hw) container_of(to_clk_regmap(_hw), \
> +						struct clk_qcapll, clkr)
> +
> +#endif
> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> index b904c33..562207c 100644
> --- a/drivers/clk/qcom/clk-rcg.h
> +++ b/drivers/clk/qcom/clk-rcg.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2013, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2013-2016 The Linux Foundation. All rights reserved.
>   *
>   * This software is licensed under the terms of the GNU General Public
>   * License version 2, as published by the Free Software Foundation, and
> @@ -20,7 +20,7 @@
>  struct freq_tbl {
>  	unsigned long freq;
>  	u8 src;
> -	u8 pre_div;
> +	u16 pre_div;

This needs explaining.

>  	u16 m;
>  	u16 n;
>  };
> @@ -68,6 +68,18 @@ struct pre_div {
>  };
>  
>  /**
> + * struct c_div - custom-divider used with Different Offsets

Why is Different and Offsets capitalized?

> + * @c_div_offset: offset of the CDIV in the ADDRESS Space

it's just called offset. And I have no idea why ADDRESS is caps
and Space is capitalized and why it isn't just "address offset".

> + * @c_div_shift: lowest bit of pre divider field
> + * @c_div_width: number of bits in pre divider
> + */
> +struct c_div {
> +	u32	offset;
> +	u8	shift;
> +	u32	mask;
> +};
> +
> +/**
>   * struct src_sel - source selector
>   * @src_sel_shift: lowest bit of source selection field
>   * @parent_map: map from software's parent index to hardware's src_sel field
> @@ -172,6 +184,55 @@ struct clk_rcg2 {
>  
>  #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg2, clkr)
>  
> +/**
> + * struct clk_cdiv_rcg2 - cdiv with root clock generator
> + *
> + * @cmd_rcgr: corresponds to *_CMD_RCGR
> + * @mnd_width: number of bits in m/n/d values
> + * @hid_width: number of bits in half integer divider
> + * @parent_map: map from software's parent index to hardware's src_sel field

missing cdiv

> + * @freq_tbl: frequency table
> + * @clkr: regmap clock handle
> + * @lock: register lock

No lock.

> + *
> + */
> +struct clk_cdiv_rcg2 {
> +	u32		cmd_rcgr;
> +	u8		mnd_width;
> +	u8		hid_width;
> +	struct c_div	cdiv;
> +	const struct parent_map	*parent_map;
> +	const struct freq_tbl	*freq_tbl;
> +	struct clk_regmap	clkr;
> +};
> +
> +#define to_clk_cdiv_rcg2(_hw) container_of(to_clk_regmap(_hw), \
> +						struct clk_cdiv_rcg2, clkr)
> +
> +
> +/**
> + * struct clk_muxr_misc - mux and misc register
> + *
> + * @cmd_rcgr: corresponds to *_CMD_RCGR
> + * @mnd_width: number of bits in m/n/d values
> + * @hid_width: number of bits in half integer divider

Huh?

> + * @parent_map: map from software's parent index to hardware's src_sel field
> + * @freq_tbl: frequency table
> + * @clkr: regmap clock handle
> + * @lock: register lock

Where?

> + *
> + */
> +struct clk_muxr_misc {
> +	struct c_div			muxr;
> +	struct c_div			misc;
> +	const struct parent_map		*parent_map;
> +	const struct freq_tbl	*freq_tbl;
> +	struct clk_regmap		clkr;
> +};
> +
> +#define to_clk_muxr_misc(_hw) container_of(to_clk_regmap(_hw), \
> +						struct clk_muxr_misc, clkr)
> +
>  extern const struct clk_ops clk_rcg2_ops;
>  extern const struct clk_ops clk_rcg2_shared_ops;
>  extern const struct clk_ops clk_edp_pixel_ops;
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index a071bba..000c423 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2013, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2013-2016, The Linux Foundation. All rights reserved.
>   *
>   * This software is licensed under the terms of the GNU General Public
>   * License version 2, as published by the Free Software Foundation, and
> @@ -20,7 +20,6 @@
>  #include <linux/delay.h>
>  #include <linux/regmap.h>
>  #include <linux/math64.h>
> -
>  #include <asm/div64.h>

No.

>  
>  #include "clk-rcg.h"
> @@ -46,6 +45,7 @@
>  #define M_REG			0x8
>  #define N_REG			0xc
>  #define D_REG			0x10
> +#define FEPLL_500_SRC		0x2

No.

>  
>  static int clk_rcg2_is_enabled(struct clk_hw *hw)
>  {
> @@ -209,6 +209,7 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw,
>  	} else {
>  		rate =  clk_hw_get_rate(p);
>  	}
> +
>  	req->best_parent_hw = p;
>  	req->best_parent_rate = rate;
>  	req->rate = f->freq;

Noise.

> @@ -810,3 +811,697 @@ const struct clk_ops clk_gfx3d_ops = {
>  	.determine_rate = clk_gfx3d_determine_rate,
>  };
>  EXPORT_SYMBOL_GPL(clk_gfx3d_ops);
> +
> +static int clk_cdiv_rcg2_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_cdiv_rcg2 *rcg = to_clk_cdiv_rcg2(hw);
> +	u32 cmd = 0;
> +	int ret;
> +
> +	ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG, &cmd);
> +	if (ret < 0)
> +		return false;
> +
> +	return (cmd & CMD_ROOT_OFF) == 0;
> +}
> +
> +static u8 clk_cdiv_rcg2_get_parent(struct clk_hw *hw)
> +{
> +	struct clk_cdiv_rcg2 *rcg = to_clk_cdiv_rcg2(hw);
> +	int num_parents = clk_hw_get_num_parents(hw);
> +	u32 cfg;
> +	int i, ret;
> +
> +	ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
> +	if (ret)
> +		goto err;
> +
> +	cfg &= CFG_SRC_SEL_MASK;
> +	cfg >>= CFG_SRC_SEL_SHIFT;
> +
> +	for (i = 0; i < num_parents; i++)
> +		if (cfg == rcg->parent_map[i].cfg)
> +			return i;
> +err:
> +	pr_debug("%s: Cannot find parent of %s clock, using default.\n",
> +			__func__, __clk_get_name(hw->clk));
> +	return 0;
> +}
> +
> +static int cdiv_update_config(struct clk_cdiv_rcg2 *rcg)
> +{
> +	int count, ret;
> +	struct clk_hw *hw = &rcg->clkr.hw;
> +	const char *name = __clk_get_name(hw->clk);
> +
> +	ret = regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG,
> +				 CMD_UPDATE, CMD_UPDATE);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for update to take effect */
> +	for (count = 500; count > 0; count--) {
> +		u32 cmd = ~0U;
> +
> +		/* ignore regmap errors - until we exhaust retry count. */

Why? Is a regmap error going to get better somehow?

> +		ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG,
> +									&cmd);
> +
> +		if (ret >= 0 && !(cmd & CMD_UPDATE))
> +			return 0;
> +
> +		udelay(1);
> +	}
> +
> +	WARN(ret, "%s: rcg didn't update its configuration.", name);
> +	return ret ? ret : -ETIMEDOUT;
> +}
> +
> +static int clk_cdiv_rcg2_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct clk_cdiv_rcg2 *rcg = to_clk_cdiv_rcg2(hw);
> +	int ret;
> +
> +	ret = regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
> +				 CFG_SRC_SEL_MASK,
> +				 rcg->parent_map[index].cfg <<
> +				 CFG_SRC_SEL_SHIFT);
> +	if (ret)
> +		return ret;
> +
> +	return cdiv_update_config(rcg);
> +}
> +
> +static unsigned long
> +clk_cdiv_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct clk_cdiv_rcg2 *rcg = to_clk_cdiv_rcg2(hw);
> +	u32 cfg, hid_div, m = 0, n = 0, mode = 0, mask, rate, cdiv;
> +	int ret;
> +
> +	ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
> +	if (ret)
> +		return 0UL;
> +
> +	if (rcg->mnd_width) {
> +		mask = BIT(rcg->mnd_width) - 1;
> +		ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + M_REG, &m);
> +		if (ret)
> +			return 0UL;
> +
> +		m &= mask;
> +		ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + N_REG, &n);
> +		if (ret)
> +			return 0UL;
> +
> +		n =  ~n;
> +		n &= mask;
> +
> +		n += m;
> +		mode = cfg & CFG_MODE_MASK;
> +		mode >>= CFG_MODE_SHIFT;
> +	}
> +
> +	mask = BIT(rcg->hid_width) - 1;
> +	hid_div = cfg >> CFG_SRC_DIV_SHIFT;
> +	hid_div &= mask;
> +	rate = calc_rate(parent_rate, m, n, mode, hid_div);
> +
> +	ret = regmap_read(rcg->clkr.regmap, rcg->cdiv.offset, &cdiv);
> +	if (ret)
> +		return 0UL;
> +
> +	cdiv &= (rcg->cdiv.mask << rcg->cdiv.shift);
> +	cdiv =  (cdiv >> rcg->cdiv.shift);
> +	if (cdiv)
> +		rate *= cdiv + 1;
> +	return rate;
> +}
> +
> +static int _cdiv_rcg2_freq_tbl_determine_rate(struct clk_hw *hw,
> +		const struct freq_tbl *f,
> +		struct clk_rate_request *req)
> +{
> +	unsigned long clk_flags;
> +	struct clk_hw *p_hw;
> +	unsigned long rate = req->rate;
> +
> +	f = qcom_find_freq(f, rate);
> +	if (!f)
> +		return 0L;
> +
> +	clk_flags = __clk_get_flags(hw->clk);
> +	p_hw = clk_hw_get_parent_by_index(hw, f->src);
> +	if (clk_flags & CLK_SET_RATE_PARENT) {
> +		if (f->pre_div)
> +			rate *= f->pre_div;
> +		if (f->n) {
> +			u64 tmp = rate;
> +
> +			tmp = tmp * f->n;
> +			do_div(tmp, f->m);
> +			rate = tmp;
> +		}
> +	} else {
> +		rate =	clk_hw_get_rate(p_hw);
> +	}
> +
> +	req->best_parent_rate = rate;
> +	req->best_parent_hw = p_hw;
> +	req->rate = f->freq;
> +
> +	return 0;
> +}
> +
> +
> +static int clk_cdiv_rcg2_determine_rate(struct clk_hw *hw,
> +					struct clk_rate_request *req)
> +{
> +	struct clk_cdiv_rcg2 *rcg = to_clk_cdiv_rcg2(hw);
> +
> +	return _cdiv_rcg2_freq_tbl_determine_rate(hw, rcg->freq_tbl, req);
> +}
> +
> +static int clk_cdiv_rcg2_configure(struct clk_cdiv_rcg2 *rcg,
> +				const struct freq_tbl *f)
> +{
> +	u32 cfg = 0, mask;
> +	u32 i;
> +	int ret;
> +
> +	if (rcg->mnd_width && f->n) {
> +		mask = BIT(rcg->mnd_width) - 1;
> +		ret = regmap_update_bits(rcg->clkr.regmap,
> +				rcg->cmd_rcgr + M_REG, mask, f->m);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(rcg->clkr.regmap,
> +				rcg->cmd_rcgr + N_REG, mask, ~(f->n - f->m));
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(rcg->clkr.regmap,
> +				rcg->cmd_rcgr + D_REG, mask, ~f->n);
> +		if (ret)
> +			return ret;
> +	}
> +
> +
> +	if (rcg->cdiv.mask && f->pre_div > 16) {
> +
> +		/* The division is handled by two dividers. Both of which can
> +		 * divide by a maximum value of 16. To achieve a division of
> +		 * 256 = 16 * 16, we use a divider of 16 in the RCGR and the
> +		 * other divider of 16 in the MISC Register.
> +		 */
> +		for (i = 2; i <= 16; i++) {
> +			if (f->pre_div % i == 0)
> +				cfg = i;
> +		}
> +
> +		if (f->pre_div/cfg > 16)
> +			return -EINVAL;
> +		mask = (rcg->cdiv.mask)<<rcg->cdiv.shift;
> +		ret = regmap_update_bits(rcg->clkr.regmap,
> +					rcg->cdiv.offset, mask,
> +				((cfg - 1) << rcg->cdiv.shift) & mask);
> +		if (ret)
> +			return ret;
> +		cfg = (2 * (f->pre_div / cfg)) - 1;
> +	} else {
> +		ret = regmap_write(rcg->clkr.regmap, rcg->cdiv.offset, 0x0);
> +		if (ret)
> +			return ret;
> +		cfg = ((2 * f->pre_div) - 1) << CFG_SRC_DIV_SHIFT;
> +	}
> +
> +	mask = BIT(rcg->hid_width) - 1;
> +	mask |= CFG_SRC_SEL_MASK | CFG_MODE_MASK;
> +	cfg |= rcg->parent_map[f->src].cfg << CFG_SRC_SEL_SHIFT;
> +	if (rcg->mnd_width && f->n)
> +		cfg |= CFG_MODE_DUAL_EDGE;
> +	ret = regmap_update_bits(rcg->clkr.regmap,
> +			rcg->cmd_rcgr + CFG_REG, mask, cfg);
> +	if (ret)
> +		return ret;
> +
> +	return cdiv_update_config(rcg);
> +}
> +
> +static int __clk_cdiv_rcg2_set_rate(struct clk_hw *hw, unsigned long rate)
> +{
> +	struct clk_cdiv_rcg2 *rcg = to_clk_cdiv_rcg2(hw);
> +	const struct freq_tbl *f;
> +
> +	f = qcom_find_freq(rcg->freq_tbl, rate);
> +	if (!f)
> +		return -EINVAL;
> +
> +	return clk_cdiv_rcg2_configure(rcg, f);
> +}
> +
> +static int clk_cdiv_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long parent_rate)
> +{
> +	return __clk_cdiv_rcg2_set_rate(hw, rate);
> +}
> +
> +static int clk_cdiv_rcg2_set_rate_and_parent(struct clk_hw *hw,
> +		unsigned long rate, unsigned long parent_rate, u8 index)
> +{
> +	return __clk_cdiv_rcg2_set_rate(hw, rate);
> +}
> +
> +const struct clk_ops clk_cdiv_rcg2_ops = {
> +	.is_enabled			= clk_cdiv_rcg2_is_enabled,
> +	.get_parent			= clk_cdiv_rcg2_get_parent,
> +	.set_parent			= clk_cdiv_rcg2_set_parent,
> +	.recalc_rate			= clk_cdiv_rcg2_recalc_rate,
> +	.determine_rate			= clk_cdiv_rcg2_determine_rate,
> +	.set_rate			= clk_cdiv_rcg2_set_rate,
> +	.set_rate_and_parent		= clk_cdiv_rcg2_set_rate_and_parent,
> +};
> +EXPORT_SYMBOL_GPL(clk_cdiv_rcg2_ops);

There's a lot of copy paste going on here. Why? Is this a cdiv
in front of an RCG? Why not model that as two clks then?

> +
> +static int clk_muxr_is_enabled(struct clk_hw *hw)
> +{
> +	return 0;
> +}

Seems impossible.

> +
> +static u8 clk_muxr_get_parent(struct clk_hw *hw)
> +{
> +	struct clk_muxr_misc *rcg = to_clk_muxr_misc(hw);
> +	int num_parents = clk_hw_get_num_parents(hw);
> +	u32 cfg;
> +	int i, ret;
> +
> +	ret = regmap_read(rcg->clkr.regmap, rcg->muxr.offset, &cfg);
> +	if (ret)
> +		goto err;
> +
> +	cfg >>= rcg->muxr.shift;
> +	cfg &= rcg->muxr.mask;
> +
> +	for (i = 0; i < num_parents; i++)
> +		if (cfg == rcg->parent_map[i].cfg)
> +			return i;
> +
> +err:
> +	pr_debug("%s: Cannot find parent of %s clock, using default.\n",
> +			__func__, __clk_get_name(hw->clk));
> +	return 0;
> +}
> +
> +static int clk_muxr_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct clk_muxr_misc *rcg = to_clk_muxr_misc(hw);
> +	int ret;
> +
> +	ret = regmap_update_bits(rcg->clkr.regmap, rcg->muxr.offset,
> +				 (rcg->muxr.mask<<rcg->muxr.shift),
> +				 rcg->parent_map[index].cfg << rcg->muxr.shift);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static unsigned long
> +clk_muxr_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct clk_muxr_misc *rcg = to_clk_muxr_misc(hw);
> +	u32 misc;
> +	int ret;
> +
> +	ret = regmap_read(rcg->clkr.regmap, rcg->misc.offset, &misc);
> +	if (ret)
> +		return 0UL;
> +
> +	misc &= rcg->misc.mask;
> +	misc >>= rcg->misc.shift;
> +
> +	return parent_rate * (misc + 1);
> +}
> +
> +static int clk_muxr_determine_rate(struct clk_hw *hw,
> +				   struct clk_rate_request *req)
> +{
> +	struct clk_muxr_misc *rcg = to_clk_muxr_misc(hw);
> +	const struct freq_tbl *f;
> +	unsigned long clk_flags;
> +	unsigned long rate = req->rate;
> +	struct clk_hw *p_hw;
> +
> +	f = qcom_find_freq(rcg->freq_tbl, rate);
> +	if (!f)
> +		return 0L;
> +
> +	clk_flags = __clk_get_flags(hw->clk);
> +	p_hw = clk_hw_get_parent_by_index(hw, f->src);
> +	if (clk_flags & CLK_SET_RATE_PARENT) {
> +		if (f->pre_div)
> +			rate *= f->pre_div;
> +	} else {
> +		rate =	clk_hw_get_rate(p_hw);
> +	}
> +
> +	req->best_parent_rate = rate;
> +	req->best_parent_hw = p_hw;
> +	req->rate = f->freq;
> +
> +	return 0;
> +}
> +
> +static int __clk_muxr_set_rate(struct clk_hw *hw, unsigned long rate)
> +{
> +	struct clk_muxr_misc *rcg = to_clk_muxr_misc(hw);
> +	const struct freq_tbl *f;
> +	int ret;
> +
> +	f = qcom_find_freq(rcg->freq_tbl, rate);
> +	if (!f)
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(rcg->clkr.regmap, rcg->muxr.offset,
> +				rcg->muxr.mask << rcg->muxr.shift,
> +				rcg->parent_map[f->src].cfg << rcg->muxr.shift);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(rcg->clkr.regmap, rcg->misc.offset,
> +				rcg->misc.mask << rcg->misc.shift,
> +				(f->pre_div - 1) << rcg->misc.shift);
> +	return ret;
> +}
> +
> +static int clk_muxr_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long parent_rate)
> +{
> +	return __clk_muxr_set_rate(hw, rate);
> +}
> +
> +static int clk_muxr_set_rate_and_parent(struct clk_hw *hw,
> +		unsigned long rate, unsigned long parent_rate, u8 index)
> +{
> +	return __clk_muxr_set_rate(hw, rate);
> +}
> +
> +const struct clk_ops clk_muxr_misc_ops = {
> +	.is_enabled	=	clk_muxr_is_enabled,
> +	.get_parent	=	clk_muxr_get_parent,
> +	.set_parent	=	clk_muxr_set_parent,
> +	.recalc_rate	=	clk_muxr_recalc_rate,
> +	.determine_rate	=	clk_muxr_determine_rate,
> +	.set_rate	=	clk_muxr_set_rate,
> +	.set_rate_and_parent	=	clk_muxr_set_rate_and_parent,
> +};
> +EXPORT_SYMBOL_GPL(clk_muxr_misc_ops);
> +
> +static int clk_cpu_rcg2_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_cdiv_rcg2 *rcg = to_clk_cdiv_rcg2(hw);
> +	u32 cmd;
> +	int ret;
> +
> +	ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG, &cmd);
> +	if (ret)
> +		return 0;
> +
> +	return (cmd & CMD_ROOT_OFF) == 0;
> +
> +}
> +
> +static u8 clk_cpu_rcg2_get_parent(struct clk_hw *hw)
> +{
> +	struct clk_cdiv_rcg2 *rcg = to_clk_cdiv_rcg2(hw);
> +	int num_parents = clk_hw_get_num_parents(hw);
> +	u32 cfg;
> +	int i, ret;
> +
> +	ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
> +	if (ret)
> +		goto err;
> +
> +	cfg &= CFG_SRC_SEL_MASK;
> +	cfg >>= CFG_SRC_SEL_SHIFT;
> +
> +	for (i = 0; i < num_parents; i++)
> +		if (cfg == rcg->parent_map[i].cfg)
> +			return i;
> +
> +err:
> +	pr_debug("%s: Cannot find parent of %s clock, using default.\n",
> +			__func__, __clk_get_name(hw->clk));
> +	return 0;
> +}
> +
> +static int cpu_rcg2_update_config(struct clk_cdiv_rcg2 *rcg)
> +{
> +	int count, ret;
> +	u32 cmd;
> +	struct clk_hw *hw = &rcg->clkr.hw;
> +	const char *name = __clk_get_name(hw->clk);
> +
> +	ret = regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG,
> +				 CMD_UPDATE, CMD_UPDATE);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for update to take effect */
> +	for (count = 500; count > 0; count--) {
> +		/* ignore regmap errors until we exhaust retry count.*/
> +		ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG,
> +									&cmd);
> +		if (ret >= 0 && !(cmd & CMD_UPDATE))
> +			return 0;
> +
> +		udelay(1);
> +	}
> +
> +	WARN(1, "%s: rcg didn't update its configuration.", name);
> +	return ret ? ret : -ETIMEDOUT;
> +}
> +
> +static int clk_cpu_rcg2_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct clk_cdiv_rcg2 *rcg = to_clk_cdiv_rcg2(hw);
> +	int ret;
> +
> +	ret = regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
> +				 CFG_SRC_SEL_MASK,
> +				 rcg->parent_map[index].cfg <<
> +				 CFG_SRC_SEL_SHIFT);
> +	if (ret)
> +		return ret;
> +
> +	return cpu_rcg2_update_config(rcg);
> +}
> +
> +
> +/*
> + * These are used for looking up the actual divider ratios
> + * the divider used for DDR PLL Post divider is not linear,
> + * hence we need this look up table
> + */
> +static const unsigned char ddrpll_div[] = {

unsigned char... but they're numbers.

> +		12,
> +		13,
> +		14,
> +		15,
> +		16,
> +		17,
> +		18,
> +		19,
> +		20,
> +		21,
> +		22,
> +		24,
> +		26,
> +		28
> +};
> +
> +static unsigned long
> +clk_cpu_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct clk_cdiv_rcg2 *rcg = to_clk_cdiv_rcg2(hw);
> +	u32 cfg, hid_div, m = 0, n = 0, mode = 0, mask, cdiv;
> +	unsigned long rate;
> +	u32 src;
> +	int ret;
> +
> +	ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
> +	if (ret)
> +		return 0UL;
> +
> +	if (rcg->mnd_width) {
> +		mask = BIT(rcg->mnd_width) - 1;
> +		ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + M_REG, &m);
> +		if (ret)
> +			return 0UL;
> +
> +		m &= mask;
> +
> +		ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + N_REG, &n);
> +		if (ret)
> +			return 0UL;
> +
> +		n =  ~n;
> +		n &= mask;
> +
> +		n += m;
> +		mode = cfg & CFG_MODE_MASK;
> +		mode >>= CFG_MODE_SHIFT;
> +	}
> +
> +	mask = BIT(rcg->hid_width) - 1;
> +	hid_div = cfg >> CFG_SRC_DIV_SHIFT;
> +	hid_div &= mask;
> +	rate = calc_rate(parent_rate, m, n, mode, hid_div);
> +	src = (cfg >> CFG_SRC_SEL_SHIFT) & 0xf;
> +	if (src == 0x1) {

What does 1 mean?

> +		u64 tmp;
> +
> +		ret = regmap_read(rcg->clkr.regmap, rcg->cdiv.offset, &cdiv);
> +		if (ret)
> +			return 0UL;
> +
> +		cdiv &= (rcg->cdiv.mask << rcg->cdiv.shift);
> +		cdiv = cdiv >> rcg->cdiv.shift;
> +		tmp = rate;
> +		do_div(tmp, ddrpll_div[cdiv]);
> +		rate = tmp;
> +		rate *= 16;
> +		tmp = rate;
> +		do_div(tmp, 1000000);
> +		rate = tmp;
> +		rate = rate * 1000000;
> +	}
> +	return rate;
> +}
> +
> +static int _cpu_rcg2_freq_tbl_determine_rate(struct clk_hw *hw,
> +		const struct freq_tbl *f,
> +		struct clk_rate_request *req)
> +{
> +	unsigned long clk_flags;
> +	struct clk_hw *p_hw;
> +	unsigned long rate;
> +
> +	f = qcom_find_freq(f, req->rate);
> +	if (!f)
> +		return 0L;
> +
> +	clk_flags = __clk_get_flags(hw->clk);

Is this used?

> +	p_hw = clk_hw_get_parent_by_index(hw, f->src);
> +	rate = clk_hw_get_rate(p_hw);
> +
> +	req->best_parent_rate = rate;
> +	req->best_parent_hw = p_hw;
> +	req->rate = f->freq;
> +
> +	return 0;

Is this function any different from the one for rcg2?

> +}
> +
> +static int clk_cpu_rcg2_determine_rate(struct clk_hw *hw,
> +					struct clk_rate_request *req)
> +{
> +	struct clk_cdiv_rcg2 *rcg = to_clk_cdiv_rcg2(hw);
> +
> +	return _cpu_rcg2_freq_tbl_determine_rate(hw, rcg->freq_tbl, req);
> +}
> +
> +
> +static int clk_cpu_rcg2_configure(struct clk_cdiv_rcg2 *rcg,
> +						const struct freq_tbl *f)
> +{
> +	u32 cfg, mask;
> +	int ret;
> +
> +	if (rcg->mnd_width && f->n) {
> +		mask = BIT(rcg->mnd_width) - 1;
> +		ret = regmap_update_bits(rcg->clkr.regmap,
> +				rcg->cmd_rcgr + M_REG, mask, f->m);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(rcg->clkr.regmap,
> +				rcg->cmd_rcgr + N_REG, mask, ~(f->n - f->m));
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(rcg->clkr.regmap,
> +				rcg->cmd_rcgr + D_REG, mask, ~f->n);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if ((rcg->parent_map[f->src].cfg == 0x01)) {

What is going on?

> +		mask = (BIT(rcg->hid_width) - 1);
> +		mask |= CFG_SRC_SEL_MASK | CFG_MODE_MASK;
> +		cfg = FEPLL_500_SRC << CFG_SRC_SEL_SHIFT;
> +		cfg |= (1 << CFG_SRC_DIV_SHIFT);
> +		ret = regmap_update_bits(rcg->clkr.regmap,
> +					rcg->cmd_rcgr + CFG_REG, mask, cfg);
> +		if (ret)
> +			return ret;
> +		cpu_rcg2_update_config(rcg);
> +		mask = (rcg->cdiv.mask)<<rcg->cdiv.shift;
> +		ret = regmap_update_bits(rcg->clkr.regmap,
> +					rcg->cdiv.offset, mask,
> +				(f->pre_div << rcg->cdiv.shift) & mask);
> +		udelay(1);
> +		mask = BIT(rcg->hid_width) - 1;
> +		mask |= CFG_SRC_SEL_MASK | CFG_MODE_MASK;
> +		cfg = 1 << CFG_SRC_DIV_SHIFT;
> +	} else {
> +		mask = BIT(rcg->hid_width) - 1;
> +		mask |= CFG_SRC_SEL_MASK | CFG_MODE_MASK;
> +		cfg = f->pre_div << CFG_SRC_DIV_SHIFT;
> +	}
> +
> +	cfg |= rcg->parent_map[f->src].cfg << CFG_SRC_SEL_SHIFT;
> +	if (rcg->mnd_width && f->n)
> +		cfg |= CFG_MODE_DUAL_EDGE;
> +	ret = regmap_update_bits(rcg->clkr.regmap,
> +					rcg->cmd_rcgr + CFG_REG, mask, cfg);
> +	if (ret)
> +		return ret;
> +
> +	return cpu_rcg2_update_config(rcg);
> +}
> +
> +static int __clk_cpu_rcg2_set_rate(struct clk_hw *hw, unsigned long rate)
> +{
> +	struct clk_cdiv_rcg2 *rcg = to_clk_cdiv_rcg2(hw);
> +	const struct freq_tbl *f;
> +
> +	f = qcom_find_freq(rcg->freq_tbl, rate);
> +	if (!f)
> +		return -EINVAL;
> +
> +	return clk_cpu_rcg2_configure(rcg, f);
> +}
> +
> +static int clk_cpu_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long parent_rate)
> +{
> +	return __clk_cpu_rcg2_set_rate(hw, rate);
> +}
> +
> +static int clk_cpu_rcg2_set_rate_and_parent(struct clk_hw *hw,
> +		unsigned long rate, unsigned long parent_rate, u8 index)
> +{
> +	return __clk_cpu_rcg2_set_rate(hw, rate);
> +}
> +
> +const struct clk_ops clk_cpu_rcg2_ops = {
> +	.is_enabled	=	clk_cpu_rcg2_is_enabled,
> +	.get_parent	=	clk_cpu_rcg2_get_parent,
> +	.set_parent	=	clk_cpu_rcg2_set_parent,
> +	.recalc_rate	=	clk_cpu_rcg2_recalc_rate,
> +	.determine_rate	=	clk_cpu_rcg2_determine_rate,
> +	.set_rate	=	clk_cpu_rcg2_set_rate,
> +	.set_rate_and_parent	=	clk_cpu_rcg2_set_rate_and_parent,
> +};
> +EXPORT_SYMBOL_GPL(clk_cpu_rcg2_ops);

So a ton of stuff is duplicated. I don't even want to read it
because the same rcg code is copied a few times and then some
modifications are made and special cases are made in generic code
for SoC specific things.

> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index f7c226a..0851122 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2013-2016, The Linux Foundation. All rights reserved.
>   *
>   * This software is licensed under the terms of the GNU General Public
>   * License version 2, as published by the Free Software Foundation, and
> @@ -269,4 +269,11 @@ int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
>  }
>  EXPORT_SYMBOL_GPL(qcom_cc_probe);
>  
> +void qcom_cc_remove(struct platform_device *pdev)
> +{
> +	of_clk_del_provider(pdev->dev.of_node);
> +	reset_controller_unregister(platform_get_drvdata(pdev));
> +}
> +EXPORT_SYMBOL_GPL(qcom_cc_remove);
> +

Nope.

>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> index ae9bdeb..ad66ae2 100644
> --- a/drivers/clk/qcom/common.h
> +++ b/drivers/clk/qcom/common.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2014, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2014-2016 The Linux Foundation. All rights reserved.
>   *
>   * This software is licensed under the terms of the GNU General Public
>   * License version 2, as published by the Free Software Foundation, and
> @@ -48,5 +48,6 @@ extern int qcom_cc_really_probe(struct platform_device *pdev,
>  				struct regmap *regmap);
>  extern int qcom_cc_probe(struct platform_device *pdev,
>  			 const struct qcom_cc_desc *desc);
> +extern void qcom_cc_remove(struct platform_device *pdev);
>  

Nope.

>  #endif
> diff --git a/include/dt-bindings/clock/qcom,gcc-ipq4019.h b/include/dt-bindings/clock/qcom,gcc-ipq4019.h
> index 6240e5b..c75b98a 100644
> --- a/include/dt-bindings/clock/qcom,gcc-ipq4019.h
> +++ b/include/dt-bindings/clock/qcom,gcc-ipq4019.h
> @@ -1,4 +1,5 @@
> -/* Copyright (c) 2015 The Linux Foundation. All rights reserved.
> +/*
> + * Copyright (c) 2015-2016 The Linux Foundation. All rights reserved.
>   *
>   * Permission to use, copy, modify, and/or distribute this software for any
>   * purpose with or without fee is hereby granted, provided that the above
> @@ -154,5 +155,6 @@
>  #define GCC_QDSS_BCR					69
>  #define GCC_MPM_BCR					70
>  #define GCC_SPDM_BCR					71
> +#define AUDIO_BLK_ARES					GCC_AUDIO_BCR
>  
>  #endif
> diff --git a/include/dt-bindings/sound/ipq4019-audio.h b/include/dt-bindings/sound/ipq4019-audio.h
> new file mode 100644
> index 0000000..7bf8036
> --- /dev/null
> +++ b/include/dt-bindings/sound/ipq4019-audio.h

Why is this here?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
