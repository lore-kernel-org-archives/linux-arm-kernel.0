From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 16 Mar 2015 00:27:20 +0800
Subject: [PATCH 3/5] clk: mediatek: Add basic clocks for Mediatek MT8135.
In-Reply-To: <1424605765-19751-4-git-send-email-s.hauer@pengutronix.de>
References: <1424605765-19751-1-git-send-email-s.hauer@pengutronix.de>
 <1424605765-19751-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAGS+omBrJObfif2aRWYwpqEstfv0gFESXSubAbG7dcQGfnVvxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Drive-by review...

On Sun, Feb 22, 2015 at 7:49 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> From: James Liao <jamesjj.liao@mediatek.com>
>
> This patch adds basic clocks for MT8135, including TOPCKGEN, PLLs,
> INFRA and PERI clocks.
>
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/clk/mediatek/Makefile                      |   1 +
>  drivers/clk/mediatek/clk-mt8135.c                  | 634 +++++++++++++++++++++
>  include/dt-bindings/clock/mt8135-clk.h             | 190 ++++++
>  .../dt-bindings/reset-controller/mt8135-resets.h   |  64 +++
>  4 files changed, 889 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8135.c
>  create mode 100644 include/dt-bindings/clock/mt8135-clk.h
>  create mode 100644 include/dt-bindings/reset-controller/mt8135-resets.h
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 0b6f1c3..12ce576 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -1,2 +1,3 @@
>  obj-y += clk-mtk.o clk-pll.o clk-gate.o
>  obj-$(CONFIG_RESET_CONTROLLER) += reset.o
> +obj-y += clk-mt8135.o
> diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
> new file mode 100644
> index 0000000..6157447
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8135.c
> @@ -0,0 +1,634 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: James Liao <jamesjj.liao@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/syscon.h>
> +#include <dt-bindings/clock/mt8135-clk.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +static DEFINE_SPINLOCK(lock);
> +

> +static struct mtk_fixed_factor root_clk_alias[] __initdata = {

Any reason you can't use "static const" here, and on all of the other
static constant structures/arrays throughout this patch.

Thanks,
-Dan

> +       FACTOR(TOP_DSI0_LNTC_DSICLK, "dsi0_lntc_dsiclk", "clk_null", 1, 1),
> +       FACTOR(TOP_HDMITX_CLKDIG_CTS, "hdmitx_clkdig_cts", "clk_null", 1, 1),
> +       FACTOR(TOP_CLKPH_MCK, "clkph_mck", "clk_null", 1, 1),
> +       FACTOR(TOP_CPUM_TCK_IN, "cpum_tck_in", "clk_null", 1, 1),
> +};
> +
> +static struct mtk_fixed_factor top_divs[] __initdata = {
> +       FACTOR(TOP_MAINPLL_806M, "mainpll_806m", "mainpll", 1, 2),
> +       FACTOR(TOP_MAINPLL_537P3M, "mainpll_537p3m", "mainpll", 1, 3),
> +       FACTOR(TOP_MAINPLL_322P4M, "mainpll_322p4m", "mainpll", 1, 5),
> +       FACTOR(TOP_MAINPLL_230P3M, "mainpll_230p3m", "mainpll", 1, 7),
> +
> +       FACTOR(TOP_UNIVPLL_624M, "univpll_624m", "univpll", 1, 2),
> +       FACTOR(TOP_UNIVPLL_416M, "univpll_416m", "univpll", 1, 3),
> +       FACTOR(TOP_UNIVPLL_249P6M, "univpll_249p6m", "univpll", 1, 5),
> +       FACTOR(TOP_UNIVPLL_178P3M, "univpll_178p3m", "univpll", 1, 7),
> +       FACTOR(TOP_UNIVPLL_48M, "univpll_48m", "univpll", 1, 26),
> +
> +       FACTOR(TOP_MMPLL_D2, "mmpll_d2", "mmpll", 1, 2),
> +       FACTOR(TOP_MMPLL_D3, "mmpll_d3", "mmpll", 1, 3),
> +       FACTOR(TOP_MMPLL_D5, "mmpll_d5", "mmpll", 1, 5),
> +       FACTOR(TOP_MMPLL_D7, "mmpll_d7", "mmpll", 1, 7),
> +       FACTOR(TOP_MMPLL_D4, "mmpll_d4", "mmpll_d2", 1, 2),
> +       FACTOR(TOP_MMPLL_D6, "mmpll_d6", "mmpll_d3", 1, 2),
> +
> +       FACTOR(TOP_SYSPLL_D2, "syspll_d2", "mainpll_806m", 1, 1),
> +       FACTOR(TOP_SYSPLL_D4, "syspll_d4", "mainpll_806m", 1, 2),
> +       FACTOR(TOP_SYSPLL_D6, "syspll_d6", "mainpll_806m", 1, 3),
> +       FACTOR(TOP_SYSPLL_D8, "syspll_d8", "mainpll_806m", 1, 4),
> +       FACTOR(TOP_SYSPLL_D10, "syspll_d10", "mainpll_806m", 1, 5),
> +       FACTOR(TOP_SYSPLL_D12, "syspll_d12", "mainpll_806m", 1, 6),
> +       FACTOR(TOP_SYSPLL_D16, "syspll_d16", "mainpll_806m", 1, 8),
> +       FACTOR(TOP_SYSPLL_D24, "syspll_d24", "mainpll_806m", 1, 12),
> +
> +       FACTOR(TOP_SYSPLL_D3, "syspll_d3", "mainpll_537p3m", 1, 1),
> +
> +       FACTOR(TOP_SYSPLL_D2P5, "syspll_d2p5", "mainpll_322p4m", 2, 1),
> +       FACTOR(TOP_SYSPLL_D5, "syspll_d5", "mainpll_322p4m", 1, 1),
> +
> +       FACTOR(TOP_SYSPLL_D3P5, "syspll_d3p5", "mainpll_230p3m", 2, 1),
> +
> +       FACTOR(TOP_UNIVPLL1_D2, "univpll1_d2", "univpll_624m", 1, 2),
> +       FACTOR(TOP_UNIVPLL1_D4, "univpll1_d4", "univpll_624m", 1, 4),
> +       FACTOR(TOP_UNIVPLL1_D6, "univpll1_d6", "univpll_624m", 1, 6),
> +       FACTOR(TOP_UNIVPLL1_D8, "univpll1_d8", "univpll_624m", 1, 8),
> +       FACTOR(TOP_UNIVPLL1_D10, "univpll1_d10", "univpll_624m", 1, 10),
> +
> +       FACTOR(TOP_UNIVPLL2_D2, "univpll2_d2", "univpll_416m", 1, 2),
> +       FACTOR(TOP_UNIVPLL2_D4, "univpll2_d4", "univpll_416m", 1, 4),
> +       FACTOR(TOP_UNIVPLL2_D6, "univpll2_d6", "univpll_416m", 1, 6),
> +       FACTOR(TOP_UNIVPLL2_D8, "univpll2_d8", "univpll_416m", 1, 8),
> +
> +       FACTOR(TOP_UNIVPLL_D3, "univpll_d3", "univpll_416m", 1, 1),
> +       FACTOR(TOP_UNIVPLL_D5, "univpll_d5", "univpll_249p6m", 1, 1),
> +       FACTOR(TOP_UNIVPLL_D7, "univpll_d7", "univpll_178p3m", 1, 1),
> +       FACTOR(TOP_UNIVPLL_D10, "univpll_d10", "univpll_249p6m", 1, 5),
> +       FACTOR(TOP_UNIVPLL_D26, "univpll_d26", "univpll_48m", 1, 1),
> +
> +       FACTOR(TOP_APLL_CK, "apll_ck", "audpll", 1, 1),
> +       FACTOR(TOP_APLL_D4, "apll_d4", "audpll", 1, 4),
> +       FACTOR(TOP_APLL_D8, "apll_d8", "audpll", 1, 8),
> +       FACTOR(TOP_APLL_D16, "apll_d16", "audpll", 1, 16),
> +       FACTOR(TOP_APLL_D24, "apll_d24", "audpll", 1, 24),
> +
> +       FACTOR(TOP_LVDSPLL_D2, "lvdspll_d2", "lvdspll", 1, 2),
> +       FACTOR(TOP_LVDSPLL_D4, "lvdspll_d4", "lvdspll", 1, 4),
> +       FACTOR(TOP_LVDSPLL_D8, "lvdspll_d8", "lvdspll", 1, 8),
> +
> +       FACTOR(TOP_LVDSTX_CLKDIG_CT, "lvdstx_clkdig_cts", "lvdspll", 1, 1),
> +       FACTOR(TOP_VPLL_DPIX_CK, "vpll_dpix_ck", "lvdspll", 1, 1),
> +
> +       FACTOR(TOP_TVHDMI_H_CK, "tvhdmi_h_ck", "tvdpll", 1, 1),
> +
> +       FACTOR(TOP_HDMITX_CLKDIG_D2, "hdmitx_clkdig_d2", "hdmitx_clkdig_cts", 1, 2),
> +       FACTOR(TOP_HDMITX_CLKDIG_D3, "hdmitx_clkdig_d3", "hdmitx_clkdig_cts", 1, 3),
> +
> +       FACTOR(TOP_TVHDMI_D2, "tvhdmi_d2", "tvhdmi_h_ck", 1, 2),
> +       FACTOR(TOP_TVHDMI_D4, "tvhdmi_d4", "tvhdmi_h_ck", 1, 4),
> +
> +       FACTOR(TOP_MEMPLL_MCK_D4, "mempll_mck_d4", "clkph_mck", 1, 4),
> +};
> +
> +static const char *axi_parents[] __initconst = {
> +       "clk26m",
> +       "syspll_d3",
> +       "syspll_d4",
> +       "syspll_d6",
> +       "univpll_d5",
> +       "univpll2_d2",
> +       "syspll_d3p5"
> +};
> +
> +static const char *smi_parents[] __initconst = {
> +       "clk26m",
> +       "clkph_mck",
> +       "syspll_d2p5",
> +       "syspll_d3",
> +       "syspll_d8",
> +       "univpll_d5",
> +       "univpll1_d2",
> +       "univpll1_d6",
> +       "mmpll_d3",
> +       "mmpll_d4",
> +       "mmpll_d5",
> +       "mmpll_d6",
> +       "mmpll_d7",
> +       "vdecpll",
> +       "lvdspll"
> +};
> +
> +static const char *mfg_parents[] __initconst = {
> +       "clk26m",
> +       "univpll1_d4",
> +       "syspll_d2",
> +       "syspll_d2p5",
> +       "syspll_d3",
> +       "univpll_d5",
> +       "univpll1_d2",
> +       "mmpll_d2",
> +       "mmpll_d3",
> +       "mmpll_d4",
> +       "mmpll_d5",
> +       "mmpll_d6",
> +       "mmpll_d7"
> +};
> +
> +static const char *irda_parents[] __initconst = {
> +       "clk26m",
> +       "univpll2_d8",
> +       "univpll1_d6"
> +};
> +
> +static const char *cam_parents[] __initconst = {
> +       "clk26m",
> +       "syspll_d3",
> +       "syspll_d3p5",
> +       "syspll_d4",
> +       "univpll_d5",
> +       "univpll2_d2",
> +       "univpll_d7",
> +       "univpll1_d4"
> +};
> +
> +static const char *aud_intbus_parents[] __initconst = {
> +       "clk26m",
> +       "syspll_d6",
> +       "univpll_d10"
> +};
> +
> +static const char *jpg_parents[] __initconst = {
> +       "clk26m",
> +       "syspll_d5",
> +       "syspll_d4",
> +       "syspll_d3",
> +       "univpll_d7",
> +       "univpll2_d2",
> +       "univpll_d5"
> +};
> +
> +static const char *disp_parents[] __initconst = {
> +       "clk26m",
> +       "syspll_d3p5",
> +       "syspll_d3",
> +       "univpll2_d2",
> +       "univpll_d5",
> +       "univpll1_d2",
> +       "lvdspll",
> +       "vdecpll"
> +};
> +
> +static const char *msdc30_parents[] __initconst = {
> +       "clk26m",
> +       "syspll_d6",
> +       "syspll_d5",
> +       "univpll1_d4",
> +       "univpll2_d4",
> +       "msdcpll"
> +};
> +
> +static const char *usb20_parents[] __initconst = {
> +       "clk26m",
> +       "univpll2_d6",
> +       "univpll1_d10"
> +};
> +
> +static const char *venc_parents[] __initconst = {
> +       "clk26m",
> +       "syspll_d3",
> +       "syspll_d8",
> +       "univpll_d5",
> +       "univpll1_d6",
> +       "mmpll_d4",
> +       "mmpll_d5",
> +       "mmpll_d6"
> +};
> +
> +static const char *spi_parents[] __initconst = {
> +       "clk26m",
> +       "syspll_d6",
> +       "syspll_d8",
> +       "syspll_d10",
> +       "univpll1_d6",
> +       "univpll1_d8"
> +};
> +
> +static const char *uart_parents[] __initconst = {
> +       "clk26m",
> +       "univpll2_d8"
> +};
> +
> +static const char *mem_parents[] __initconst = {
> +       "clk26m",
> +       "clkph_mck"
> +};
> +
> +static const char *camtg_parents[] __initconst = {
> +       "clk26m",
> +       "univpll_d26",
> +       "univpll1_d6",
> +       "syspll_d16",
> +       "syspll_d8"
> +};
> +
> +static const char *audio_parents[] __initconst = {
> +       "clk26m",
> +       "syspll_d24"
> +};
> +
> +static const char *fix_parents[] __initconst = {
> +       "rtc32k",
> +       "clk26m",
> +       "univpll_d5",
> +       "univpll_d7",
> +       "univpll1_d2",
> +       "univpll1_d4",
> +       "univpll1_d6",
> +       "univpll1_d8"
> +};
> +
> +static const char *vdec_parents[] __initconst = {
> +       "clk26m",
> +       "vdecpll",
> +       "clkph_mck",
> +       "syspll_d2p5",
> +       "syspll_d3",
> +       "syspll_d3p5",
> +       "syspll_d4",
> +       "syspll_d5",
> +       "syspll_d6",
> +       "syspll_d8",
> +       "univpll1_d2",
> +       "univpll2_d2",
> +       "univpll_d7",
> +       "univpll_d10",
> +       "univpll2_d4",
> +       "lvdspll"
> +};
> +
> +static const char *ddrphycfg_parents[] __initconst = {
> +       "clk26m",
> +       "axi_sel",
> +       "syspll_d12"
> +};
> +
> +static const char *dpilvds_parents[] __initconst = {
> +       "clk26m",
> +       "lvdspll",
> +       "lvdspll_d2",
> +       "lvdspll_d4",
> +       "lvdspll_d8"
> +};
> +
> +static const char *pmicspi_parents[] __initconst = {
> +       "clk26m",
> +       "univpll2_d6",
> +       "syspll_d8",
> +       "syspll_d10",
> +       "univpll1_d10",
> +       "mempll_mck_d4",
> +       "univpll_d26",
> +       "syspll_d24"
> +};
> +
> +static const char *smi_mfg_as_parents[] __initconst = {
> +       "clk26m",
> +       "smi_sel",
> +       "mfg_sel",
> +       "mem_sel"
> +};
> +
> +static const char *gcpu_parents[] __initconst = {
> +       "clk26m",
> +       "syspll_d4",
> +       "univpll_d7",
> +       "syspll_d5",
> +       "syspll_d6"
> +};
> +
> +static const char *dpi1_parents[] __initconst = {
> +       "clk26m",
> +       "tvhdmi_h_ck",
> +       "tvhdmi_d2",
> +       "tvhdmi_d4"
> +};
> +
> +static const char *cci_parents[] __initconst = {
> +       "clk26m",
> +       "mainpll_537p3m",
> +       "univpll_d3",
> +       "syspll_d2p5",
> +       "syspll_d3",
> +       "syspll_d5"
> +};
> +
> +static const char *apll_parents[] __initconst = {
> +       "clk26m",
> +       "apll_ck",
> +       "apll_d4",
> +       "apll_d8",
> +       "apll_d16",
> +       "apll_d24"
> +};
> +
> +static const char *hdmipll_parents[] __initconst = {
> +       "clk26m",
> +       "hdmitx_clkdig_cts",
> +       "hdmitx_clkdig_d2",
> +       "hdmitx_clkdig_d3"
> +};
> +
> +static struct mtk_composite top_muxes[] __initdata = {
> +       /* CLK_CFG_0 */
> +       MUX_GATE(TOP_AXI_SEL, "axi_sel", axi_parents,
> +               0x0140, 0, 3, INVALID_MUX_GATE_BIT),
> +       MUX_GATE(TOP_SMI_SEL, "smi_sel", smi_parents, 0x0140, 8, 4, 15),
> +       MUX_GATE(TOP_MFG_SEL, "mfg_sel", mfg_parents, 0x0140, 16, 4, 23),
> +       MUX_GATE(TOP_IRDA_SEL, "irda_sel", irda_parents, 0x0140, 24, 2, 31),
> +       /* CLK_CFG_1 */
> +       MUX_GATE(TOP_CAM_SEL, "cam_sel", cam_parents, 0x0144, 0, 3, 7),
> +       MUX_GATE(TOP_AUD_INTBUS_SEL, "aud_intbus_sel", aud_intbus_parents,
> +               0x0144, 8, 2, 15),
> +       MUX_GATE(TOP_JPG_SEL, "jpg_sel", jpg_parents, 0x0144, 16, 3, 23),
> +       MUX_GATE(TOP_DISP_SEL, "disp_sel", disp_parents, 0x0144, 24, 3, 31),
> +       /* CLK_CFG_2 */
> +       MUX_GATE(TOP_MSDC30_1_SEL, "msdc30_1_sel", msdc30_parents, 0x0148, 0, 3, 7),
> +       MUX_GATE(TOP_MSDC30_2_SEL, "msdc30_2_sel", msdc30_parents, 0x0148, 8, 3, 15),
> +       MUX_GATE(TOP_MSDC30_3_SEL, "msdc30_3_sel", msdc30_parents, 0x0148, 16, 3, 23),
> +       MUX_GATE(TOP_MSDC30_4_SEL, "msdc30_4_sel", msdc30_parents, 0x0148, 24, 3, 31),
> +       /* CLK_CFG_3 */
> +       MUX_GATE(TOP_USB20_SEL, "usb20_sel", usb20_parents, 0x014c, 0, 2, 7),
> +       /* CLK_CFG_4 */
> +       MUX_GATE(TOP_VENC_SEL, "venc_sel", venc_parents, 0x0150, 8, 3, 15),
> +       MUX_GATE(TOP_SPI_SEL, "spi_sel", spi_parents, 0x0150, 16, 3, 23),
> +       MUX_GATE(TOP_UART_SEL, "uart_sel", uart_parents, 0x0150, 24, 2, 31),
> +       /* CLK_CFG_6 */
> +       MUX_GATE(TOP_MEM_SEL, "mem_sel", mem_parents, 0x0158, 0, 2, 7),
> +       MUX_GATE(TOP_CAMTG_SEL, "camtg_sel", camtg_parents, 0x0158, 8, 3, 15),
> +       MUX_GATE(TOP_AUDIO_SEL, "audio_sel", audio_parents, 0x0158, 24, 2, 31),
> +       /* CLK_CFG_7 */
> +       MUX_GATE(TOP_FIX_SEL, "fix_sel", fix_parents, 0x015c, 0, 3, 7),
> +       MUX_GATE(TOP_VDEC_SEL, "vdec_sel", vdec_parents, 0x015c, 8, 4, 15),
> +       MUX_GATE(TOP_DDRPHYCFG_SEL, "ddrphycfg_sel", ddrphycfg_parents,
> +               0x015c, 16, 2, 23),
> +       MUX_GATE(TOP_DPILVDS_SEL, "dpilvds_sel", dpilvds_parents, 0x015c, 24, 3, 31),
> +       /* CLK_CFG_8 */
> +       MUX_GATE(TOP_PMICSPI_SEL, "pmicspi_sel", pmicspi_parents, 0x0164, 0, 3, 7),
> +       MUX_GATE(TOP_MSDC30_0_SEL, "msdc30_0_sel", msdc30_parents, 0x0164, 8, 3, 15),
> +       MUX_GATE(TOP_SMI_MFG_AS_SEL, "smi_mfg_as_sel", smi_mfg_as_parents,
> +               0x0164, 16, 2, 23),
> +       MUX_GATE(TOP_GCPU_SEL, "gcpu_sel", gcpu_parents, 0x0164, 24, 3, 31),
> +       /* CLK_CFG_9 */
> +       MUX_GATE(TOP_DPI1_SEL, "dpi1_sel", dpi1_parents, 0x0168, 0, 2, 7),
> +       MUX_GATE(TOP_CCI_SEL, "cci_sel", cci_parents, 0x0168, 8, 3, 15),
> +       MUX_GATE(TOP_APLL_SEL, "apll_sel", apll_parents, 0x0168, 16, 3, 23),
> +       MUX_GATE(TOP_HDMIPLL_SEL, "hdmipll_sel", hdmipll_parents, 0x0168, 24, 2, 31),
> +};
> +
> +static void __init mtk_init_clk_topckgen(void __iomem *top_base,
> +               struct clk_onecell_data *clk_data)
> +{
> +       int i;
> +       struct clk *clk;
> +
> +       for (i = 0; i < ARRAY_SIZE(top_muxes); i++) {
> +               struct mtk_composite *mux = &top_muxes[i];
> +
> +               clk = mtk_clk_register_composite(mux, top_base, &lock);
> +
> +               if (IS_ERR(clk)) {
> +                       pr_err("Failed to register clk %s: %ld\n",
> +                                       mux->name, PTR_ERR(clk));
> +                       continue;
> +               }
> +
> +               if (clk_data)
> +                       clk_data->clks[mux->id] = clk;
> +       }
> +}
> +
> +static struct mtk_gate_regs infra_cg_regs = {
> +       .set_ofs = 0x0040,
> +       .clr_ofs = 0x0044,
> +       .sta_ofs = 0x0048,
> +};
> +
> +#define GATE_ICG(_id, _name, _parent, _shift) {        \
> +               .id = _id,                                      \
> +               .name = _name,                                  \
> +               .parent_name = _parent,                         \
> +               .regs = &infra_cg_regs,                         \
> +               .shift = _shift,                                \
> +               .ops = &mtk_clk_gate_ops_setclr,                \
> +       }
> +
> +static struct mtk_gate infra_clks[] __initdata = {
> +       GATE_ICG(INFRA_PMIC_WRAP_CK, "pmic_wrap_ck", "axi_sel", 23),
> +       GATE_ICG(INFRA_PMICSPI_CK, "pmicspi_ck", "pmicspi_sel", 22),
> +       GATE_ICG(INFRA_CCIF1_AP_CTRL, "ccif1_ap_ctrl", "axi_sel", 21),
> +       GATE_ICG(INFRA_CCIF0_AP_CTRL, "ccif0_ap_ctrl", "axi_sel", 20),
> +       GATE_ICG(INFRA_KP_CK, "kp_ck", "axi_sel", 16),
> +       GATE_ICG(INFRA_CPUM_CK, "cpum_ck", "cpum_tck_in", 15),
> +       GATE_ICG(INFRA_M4U_CK, "m4u_ck", "mem_sel", 8),
> +       GATE_ICG(INFRA_MFGAXI_CK, "mfgaxi_ck", "axi_sel", 7),
> +       GATE_ICG(INFRA_DEVAPC_CK, "devapc_ck", "axi_sel", 6),
> +       GATE_ICG(INFRA_AUDIO_CK, "audio_ck", "aud_intbus_sel", 5),
> +       GATE_ICG(INFRA_MFG_BUS_CK, "mfg_bus_ck", "axi_sel", 2),
> +       GATE_ICG(INFRA_SMI_CK, "smi_ck", "smi_sel", 1),
> +       GATE_ICG(INFRA_DBGCLK_CK, "dbgclk_ck", "axi_sel", 0),
> +};
> +
> +static struct mtk_gate_regs peri0_cg_regs = {
> +       .set_ofs = 0x0008,
> +       .clr_ofs = 0x0010,
> +       .sta_ofs = 0x0018,
> +};
> +
> +static struct mtk_gate_regs peri1_cg_regs = {
> +       .set_ofs = 0x000c,
> +       .clr_ofs = 0x0014,
> +       .sta_ofs = 0x001c,
> +};
> +
> +#define GATE_PERI0(_id, _name, _parent, _shift) {      \
> +               .id = _id,                                      \
> +               .name = _name,                                  \
> +               .parent_name = _parent,                         \
> +               .regs = &peri0_cg_regs,                         \
> +               .shift = _shift,                                \
> +               .ops = &mtk_clk_gate_ops_setclr,                \
> +       }
> +
> +#define GATE_PERI1(_id, _name, _parent, _shift) {      \
> +               .id = _id,                                      \
> +               .name = _name,                                  \
> +               .parent_name = _parent,                         \
> +               .regs = &peri1_cg_regs,                         \
> +               .shift = _shift,                                \
> +               .ops = &mtk_clk_gate_ops_setclr,                \
> +       }
> +
> +static struct mtk_gate peri_clks[] __initdata = {
> +       /* PERI0 */
> +       GATE_PERI0(PERI_I2C5_CK, "i2c5_ck", "axi_sel", 31),
> +       GATE_PERI0(PERI_I2C4_CK, "i2c4_ck", "axi_sel", 30),
> +       GATE_PERI0(PERI_I2C3_CK, "i2c3_ck", "axi_sel", 29),
> +       GATE_PERI0(PERI_I2C2_CK, "i2c2_ck", "axi_sel", 28),
> +       GATE_PERI0(PERI_I2C1_CK, "i2c1_ck", "axi_sel", 27),
> +       GATE_PERI0(PERI_I2C0_CK, "i2c0_ck", "axi_sel", 26),
> +       GATE_PERI0(PERI_UART3_CK, "uart3_ck", "axi_sel", 25),
> +       GATE_PERI0(PERI_UART2_CK, "uart2_ck", "axi_sel", 24),
> +       GATE_PERI0(PERI_UART1_CK, "uart1_ck", "axi_sel", 23),
> +       GATE_PERI0(PERI_UART0_CK, "uart0_ck", "axi_sel", 22),
> +       GATE_PERI0(PERI_IRDA_CK, "irda_ck", "irda_sel", 21),
> +       GATE_PERI0(PERI_NLI_CK, "nli_ck", "axi_sel", 20),
> +       GATE_PERI0(PERI_MD_HIF_CK, "md_hif_ck", "axi_sel", 19),
> +       GATE_PERI0(PERI_AP_HIF_CK, "ap_hif_ck", "axi_sel", 18),
> +       GATE_PERI0(PERI_MSDC30_3_CK, "msdc30_3_ck", "msdc30_4_sel", 17),
> +       GATE_PERI0(PERI_MSDC30_2_CK, "msdc30_2_ck", "msdc30_3_sel", 16),
> +       GATE_PERI0(PERI_MSDC30_1_CK, "msdc30_1_ck", "msdc30_2_sel", 15),
> +       GATE_PERI0(PERI_MSDC20_2_CK, "msdc20_2_ck", "msdc30_1_sel", 14),
> +       GATE_PERI0(PERI_MSDC20_1_CK, "msdc20_1_ck", "msdc30_0_sel", 13),
> +       GATE_PERI0(PERI_AP_DMA_CK, "ap_dma_ck", "axi_sel", 12),
> +       GATE_PERI0(PERI_USB1_CK, "usb1_ck", "usb20_sel", 11),
> +       GATE_PERI0(PERI_USB0_CK, "usb0_ck", "usb20_sel", 10),
> +       GATE_PERI0(PERI_PWM_CK, "pwm_ck", "axi_sel", 9),
> +       GATE_PERI0(PERI_PWM7_CK, "pwm7_ck", "axi_sel", 8),
> +       GATE_PERI0(PERI_PWM6_CK, "pwm6_ck", "axi_sel", 7),
> +       GATE_PERI0(PERI_PWM5_CK, "pwm5_ck", "axi_sel", 6),
> +       GATE_PERI0(PERI_PWM4_CK, "pwm4_ck", "axi_sel", 5),
> +       GATE_PERI0(PERI_PWM3_CK, "pwm3_ck", "axi_sel", 4),
> +       GATE_PERI0(PERI_PWM2_CK, "pwm2_ck", "axi_sel", 3),
> +       GATE_PERI0(PERI_PWM1_CK, "pwm1_ck", "axi_sel", 2),
> +       GATE_PERI0(PERI_THERM_CK, "therm_ck", "axi_sel", 1),
> +       GATE_PERI0(PERI_NFI_CK, "nfi_ck", "axi_sel", 0),
> +       /* PERI1 */
> +       GATE_PERI1(PERI_USBSLV_CK, "usbslv_ck", "axi_sel", 8),
> +       GATE_PERI1(PERI_USB1_MCU_CK, "usb1_mcu_ck", "axi_sel", 7),
> +       GATE_PERI1(PERI_USB0_MCU_CK, "usb0_mcu_ck", "axi_sel", 6),
> +       GATE_PERI1(PERI_GCPU_CK, "gcpu_ck", "gcpu_sel", 5),
> +       GATE_PERI1(PERI_FHCTL_CK, "fhctl_ck", "clk26m", 4),
> +       GATE_PERI1(PERI_SPI1_CK, "spi1_ck", "spi_sel", 3),
> +       GATE_PERI1(PERI_AUXADC_CK, "auxadc_ck", "clk26m", 2),
> +       GATE_PERI1(PERI_PERI_PWRAP_CK, "peri_pwrap_ck", "axi_sel", 1),
> +       GATE_PERI1(PERI_I2C6_CK, "i2c6_ck", "axi_sel", 0),
> +};
> +
> +static void __init mtk_topckgen_init(struct device_node *node)
> +{
> +       struct clk_onecell_data *clk_data;
> +       void __iomem *base;
> +       int r;
> +
> +       base = of_iomap(node, 0);
> +       if (!base) {
> +               pr_err("%s(): ioremap failed\n", __func__);
> +               return;
> +       }
> +
> +       clk_data = mtk_alloc_clk_data(TOP_NR_CLK);
> +
> +       mtk_clk_register_factors(root_clk_alias, ARRAY_SIZE(root_clk_alias), clk_data);
> +       mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
> +       mtk_init_clk_topckgen(base, clk_data);
> +
> +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +       if (r)
> +               pr_err("%s(): could not register clock provider: %d\n",
> +                       __func__, r);
> +}
> +CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8135-topckgen", mtk_topckgen_init);
> +
> +static void __init mtk_infrasys_init(struct device_node *node)
> +{
> +       struct clk_onecell_data *clk_data;
> +       int r;
> +
> +       clk_data = mtk_alloc_clk_data(INFRA_NR_CLK);
> +
> +       mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
> +                                               clk_data);
> +
> +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +       if (r)
> +               pr_err("%s(): could not register clock provider: %d\n",
> +                       __func__, r);
> +
> +       mtk_register_reset_controller(node, 2, 0x30);
> +}
> +CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8135-infracfg", mtk_infrasys_init);
> +
> +static void __init mtk_pericfg_init(struct device_node *node)
> +{
> +       struct clk_onecell_data *clk_data;
> +       int r;
> +
> +       clk_data = mtk_alloc_clk_data(PERI_NR_CLK);
> +
> +       mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
> +                                               clk_data);
> +
> +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +       if (r)
> +               pr_err("%s(): could not register clock provider: %d\n",
> +                       __func__, r);
> +
> +       mtk_register_reset_controller(node, 2, 0);
> +}
> +CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8135-pericfg", mtk_pericfg_init);
> +
> +#define MT8135_PLL_FMAX                (2000 * MHZ)
> +#define CON0_MT8135_RST_BAR    BIT(27)
> +
> +#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift) { \
> +               .id = _id,                                              \
> +               .name = _name,                                          \
> +               .reg = _reg,                                            \
> +               .pwr_reg = _pwr_reg,                                    \
> +               .en_mask = _en_mask,                                    \
> +               .flags = _flags,                                        \
> +               .rst_bar_mask = CON0_MT8135_RST_BAR,                    \
> +               .fmax = MT8135_PLL_FMAX,                                \
> +               .pcwbits = _pcwbits,                                    \
> +               .pd_reg = _pd_reg,                                      \
> +               .pd_shift = _pd_shift,                                  \
> +               .tuner_reg = _tuner_reg,                                \
> +               .pcw_reg = _pcw_reg,                                    \
> +               .pcw_shift = _pcw_shift,                                \
> +       }
> +
> +static struct mtk_pll_data plls[] = {
> +       PLL(APMIXED_ARMPLL1, "armpll1", 0x200, 0x218, 0x80000001, 0, 21, 0x204, 24, 0x0, 0x204, 0),
> +       PLL(APMIXED_ARMPLL2, "armpll2", 0x2cc, 0x2e4, 0x80000001, 0, 21, 0x2d0, 24, 0x0, 0x2d0, 0),
> +       PLL(APMIXED_MAINPLL, "mainpll", 0x21c, 0x234, 0xf0000001, HAVE_RST_BAR, 21, 0x21c, 6, 0x0, 0x220, 0),
> +       PLL(APMIXED_UNIVPLL, "univpll", 0x238, 0x250, 0xf3000001, HAVE_RST_BAR, 7, 0x238, 6, 0x0, 0x238, 9),
> +       PLL(APMIXED_MMPLL, "mmpll", 0x254, 0x26c, 0xf0000001, HAVE_RST_BAR, 21, 0x254, 6, 0x0, 0x258, 0),
> +       PLL(APMIXED_MSDCPLL, "msdcpll", 0x278, 0x290, 0x80000001, 0, 21, 0x278, 6, 0x0, 0x27c, 0),
> +       PLL(APMIXED_TVDPLL, "tvdpll", 0x294, 0x2ac, 0x80000001, 0, 31, 0x296, 6, 0x0, 0x298, 0),
> +       PLL(APMIXED_LVDSPLL, "lvdspll", 0x2b0, 0x2c8,   0x80000001, 0, 21, 0x2b0, 6, 0x0, 0x2b4, 0),
> +       PLL(APMIXED_AUDPLL, "audpll", 0x2e8, 0x300, 0x80000001, 0, 31, 0x2e8, 6, 0x2f8, 0x2ec, 0),
> +       PLL(APMIXED_VDECPLL, "vdecpll", 0x304, 0x31c,   0x80000001, 0, 21, 0x2b0, 6, 0x0, 0x308, 0),
> +};
> +
> +static void __init mtk_apmixedsys_init(struct device_node *node)
> +{
> +       mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls));
> +}
> +CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt8135-apmixedsys",
> +               mtk_apmixedsys_init);
> diff --git a/include/dt-bindings/clock/mt8135-clk.h b/include/dt-bindings/clock/mt8135-clk.h
> new file mode 100644
> index 0000000..8aea762
> --- /dev/null
> +++ b/include/dt-bindings/clock/mt8135-clk.h
> @@ -0,0 +1,190 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: James Liao <jamesjj.liao@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_MT8135_H
> +#define _DT_BINDINGS_CLK_MT8135_H
> +
> +/* TOPCKGEN */
> +
> +#define TOP_DSI0_LNTC_DSICLK   1
> +#define TOP_HDMITX_CLKDIG_CTS  2
> +#define TOP_CLKPH_MCK          3
> +#define TOP_CPUM_TCK_IN                4
> +#define TOP_MAINPLL_806M       5
> +#define TOP_MAINPLL_537P3M     6
> +#define TOP_MAINPLL_322P4M     7
> +#define TOP_MAINPLL_230P3M     8
> +#define TOP_UNIVPLL_624M       9
> +#define TOP_UNIVPLL_416M       10
> +#define TOP_UNIVPLL_249P6M     11
> +#define TOP_UNIVPLL_178P3M     12
> +#define TOP_UNIVPLL_48M                13
> +#define TOP_MMPLL_D2           14
> +#define TOP_MMPLL_D3           15
> +#define TOP_MMPLL_D5           16
> +#define TOP_MMPLL_D7           17
> +#define TOP_MMPLL_D4           18
> +#define TOP_MMPLL_D6           19
> +#define TOP_SYSPLL_D2          20
> +#define TOP_SYSPLL_D4          21
> +#define TOP_SYSPLL_D6          22
> +#define TOP_SYSPLL_D8          23
> +#define TOP_SYSPLL_D10         24
> +#define TOP_SYSPLL_D12         25
> +#define TOP_SYSPLL_D16         26
> +#define TOP_SYSPLL_D24         27
> +#define TOP_SYSPLL_D3          28
> +#define TOP_SYSPLL_D2P5                29
> +#define TOP_SYSPLL_D5          30
> +#define TOP_SYSPLL_D3P5                31
> +#define TOP_UNIVPLL1_D2                32
> +#define TOP_UNIVPLL1_D4                33
> +#define TOP_UNIVPLL1_D6                34
> +#define TOP_UNIVPLL1_D8                35
> +#define TOP_UNIVPLL1_D10       36
> +#define TOP_UNIVPLL2_D2                37
> +#define TOP_UNIVPLL2_D4                38
> +#define TOP_UNIVPLL2_D6                39
> +#define TOP_UNIVPLL2_D8                40
> +#define TOP_UNIVPLL_D3         41
> +#define TOP_UNIVPLL_D5         42
> +#define TOP_UNIVPLL_D7         43
> +#define TOP_UNIVPLL_D10                44
> +#define TOP_UNIVPLL_D26                45
> +#define TOP_APLL_CK            46
> +#define TOP_APLL_D4            47
> +#define TOP_APLL_D8            48
> +#define TOP_APLL_D16           49
> +#define TOP_APLL_D24           50
> +#define TOP_LVDSPLL_D2         51
> +#define TOP_LVDSPLL_D4         52
> +#define TOP_LVDSPLL_D8         53
> +#define TOP_LVDSTX_CLKDIG_CT   54
> +#define TOP_VPLL_DPIX_CK       55
> +#define TOP_TVHDMI_H_CK                56
> +#define TOP_HDMITX_CLKDIG_D2   57
> +#define TOP_HDMITX_CLKDIG_D3   58
> +#define TOP_TVHDMI_D2          59
> +#define TOP_TVHDMI_D4          60
> +#define TOP_MEMPLL_MCK_D4      61
> +#define TOP_AXI_SEL            62
> +#define TOP_SMI_SEL            63
> +#define TOP_MFG_SEL            64
> +#define TOP_IRDA_SEL           65
> +#define TOP_CAM_SEL            66
> +#define TOP_AUD_INTBUS_SEL     67
> +#define TOP_JPG_SEL            68
> +#define TOP_DISP_SEL           69
> +#define TOP_MSDC30_1_SEL       70
> +#define TOP_MSDC30_2_SEL       71
> +#define TOP_MSDC30_3_SEL       72
> +#define TOP_MSDC30_4_SEL       73
> +#define TOP_USB20_SEL          74
> +#define TOP_VENC_SEL           75
> +#define TOP_SPI_SEL            76
> +#define TOP_UART_SEL           77
> +#define TOP_MEM_SEL            78
> +#define TOP_CAMTG_SEL          79
> +#define TOP_AUDIO_SEL          80
> +#define TOP_FIX_SEL            81
> +#define TOP_VDEC_SEL           82
> +#define TOP_DDRPHYCFG_SEL      83
> +#define TOP_DPILVDS_SEL                84
> +#define TOP_PMICSPI_SEL                85
> +#define TOP_MSDC30_0_SEL       86
> +#define TOP_SMI_MFG_AS_SEL     87
> +#define TOP_GCPU_SEL           88
> +#define TOP_DPI1_SEL           89
> +#define TOP_CCI_SEL            90
> +#define TOP_APLL_SEL           91
> +#define TOP_HDMIPLL_SEL                92
> +#define TOP_NR_CLK             93
> +
> +/* APMIXED_SYS */
> +
> +#define APMIXED_ARMPLL1                1
> +#define APMIXED_ARMPLL2                2
> +#define APMIXED_MAINPLL                3
> +#define APMIXED_UNIVPLL                4
> +#define APMIXED_MMPLL          5
> +#define APMIXED_MSDCPLL                6
> +#define APMIXED_TVDPLL         7
> +#define APMIXED_LVDSPLL                8
> +#define APMIXED_AUDPLL         9
> +#define APMIXED_VDECPLL                10
> +#define APMIXED_NR_CLK         11
> +
> +/* INFRA_SYS */
> +
> +#define INFRA_PMIC_WRAP_CK     1
> +#define INFRA_PMICSPI_CK       2
> +#define INFRA_CCIF1_AP_CTRL    3
> +#define INFRA_CCIF0_AP_CTRL    4
> +#define INFRA_KP_CK            5
> +#define INFRA_CPUM_CK          6
> +#define INFRA_M4U_CK           7
> +#define INFRA_MFGAXI_CK                8
> +#define INFRA_DEVAPC_CK                9
> +#define INFRA_AUDIO_CK         10
> +#define INFRA_MFG_BUS_CK       11
> +#define INFRA_SMI_CK           12
> +#define INFRA_DBGCLK_CK                13
> +#define INFRA_NR_CLK           14
> +
> +/* PERI_SYS */
> +
> +#define PERI_I2C5_CK           1
> +#define PERI_I2C4_CK           2
> +#define PERI_I2C3_CK           3
> +#define PERI_I2C2_CK           4
> +#define PERI_I2C1_CK           5
> +#define PERI_I2C0_CK           6
> +#define PERI_UART3_CK          7
> +#define PERI_UART2_CK          8
> +#define PERI_UART1_CK          9
> +#define PERI_UART0_CK          10
> +#define PERI_IRDA_CK           11
> +#define PERI_NLI_CK            12
> +#define PERI_MD_HIF_CK         13
> +#define PERI_AP_HIF_CK         14
> +#define PERI_MSDC30_3_CK       15
> +#define PERI_MSDC30_2_CK       16
> +#define PERI_MSDC30_1_CK       17
> +#define PERI_MSDC20_2_CK       18
> +#define PERI_MSDC20_1_CK       19
> +#define PERI_AP_DMA_CK         20
> +#define PERI_USB1_CK           21
> +#define PERI_USB0_CK           22
> +#define PERI_PWM_CK            23
> +#define PERI_PWM7_CK           24
> +#define PERI_PWM6_CK           25
> +#define PERI_PWM5_CK           26
> +#define PERI_PWM4_CK           27
> +#define PERI_PWM3_CK           28
> +#define PERI_PWM2_CK           29
> +#define PERI_PWM1_CK           30
> +#define PERI_THERM_CK          31
> +#define PERI_NFI_CK            32
> +#define PERI_USBSLV_CK         33
> +#define PERI_USB1_MCU_CK       34
> +#define PERI_USB0_MCU_CK       35
> +#define PERI_GCPU_CK           36
> +#define PERI_FHCTL_CK          37
> +#define PERI_SPI1_CK           38
> +#define PERI_AUXADC_CK         39
> +#define PERI_PERI_PWRAP_CK     40
> +#define PERI_I2C6_CK           41
> +#define PERI_NR_CLK            42
> +
> +#endif /* _DT_BINDINGS_CLK_MT8135_H */
> diff --git a/include/dt-bindings/reset-controller/mt8135-resets.h b/include/dt-bindings/reset-controller/mt8135-resets.h
> new file mode 100644
> index 0000000..1fb6295
> --- /dev/null
> +++ b/include/dt-bindings/reset-controller/mt8135-resets.h
> @@ -0,0 +1,64 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: Flora Fu, MediaTek
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8135
> +#define _DT_BINDINGS_RESET_CONTROLLER_MT8135
> +
> +/* INFRACFG resets */
> +#define MT8135_INFRA_EMI_REG_RST        0
> +#define MT8135_INFRA_DRAMC0_A0_RST      1
> +#define MT8135_INFRA_CCIF0_RST          2
> +#define MT8135_INFRA_APCIRQ_EINT_RST    3
> +#define MT8135_INFRA_APXGPT_RST         4
> +#define MT8135_INFRA_SCPSYS_RST         5
> +#define MT8135_INFRA_CCIF1_RST          6
> +#define MT8135_INFRA_PMIC_WRAP_RST      7
> +#define MT8135_INFRA_KP_RST             8
> +#define MT8135_INFRA_EMI_RST            32
> +#define MT8135_INFRA_DRAMC0_RST         34
> +#define MT8135_INFRA_SMI_RST            35
> +#define MT8135_INFRA_M4U_RST            36
> +
> +/*  PERICFG resets */
> +#define MT8135_PERI_UART0_SW_RST        0
> +#define MT8135_PERI_UART1_SW_RST        1
> +#define MT8135_PERI_UART2_SW_RST        2
> +#define MT8135_PERI_UART3_SW_RST        3
> +#define MT8135_PERI_IRDA_SW_RST         4
> +#define MT8135_PERI_PTP_SW_RST          5
> +#define MT8135_PERI_AP_HIF_SW_RST       6
> +#define MT8135_PERI_GPCU_SW_RST         7
> +#define MT8135_PERI_MD_HIF_SW_RST       8
> +#define MT8135_PERI_NLI_SW_RST          9
> +#define MT8135_PERI_AUXADC_SW_RST       10
> +#define MT8135_PERI_DMA_SW_RST          11
> +#define MT8135_PERI_NFI_SW_RST          14
> +#define MT8135_PERI_PWM_SW_RST          15
> +#define MT8135_PERI_THERM_SW_RST        16
> +#define MT8135_PERI_MSDC0_SW_RST        17
> +#define MT8135_PERI_MSDC1_SW_RST        18
> +#define MT8135_PERI_MSDC2_SW_RST        19
> +#define MT8135_PERI_MSDC3_SW_RST        20
> +#define MT8135_PERI_I2C0_SW_RST         22
> +#define MT8135_PERI_I2C1_SW_RST         23
> +#define MT8135_PERI_I2C2_SW_RST         24
> +#define MT8135_PERI_I2C3_SW_RST         25
> +#define MT8135_PERI_I2C4_SW_RST         26
> +#define MT8135_PERI_I2C5_SW_RST         27
> +#define MT8135_PERI_I2C6_SW_RST         28
> +#define MT8135_PERI_USB_SW_RST          29
> +#define MT8135_PERI_SPI1_SW_RST         33
> +#define MT8135_PERI_PWRAP_BRIDGE_SW_RST 34
> +
> +#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8135 */
> --
> 2.1.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
