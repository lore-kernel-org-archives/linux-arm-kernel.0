From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 9 Apr 2015 19:05:22 +0200
Subject: [PATCH 4/6] clk: mediatek: Add basic clocks for Mediatek MT8135.
In-Reply-To: <1427825817-26773-5-git-send-email-s.hauer@pengutronix.de>
References: <1427825817-26773-1-git-send-email-s.hauer@pengutronix.de>
 <1427825817-26773-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CABuKBeJKrDMR+xHSk_WvppGE7KftMy-QL8ATFi081++C3vaKEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-31 20:16 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
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
>  drivers/clk/mediatek/clk-mt8135.c                  | 640 +++++++++++++++++++++
>  include/dt-bindings/clock/mt8135-clk.h             | 190 ++++++
>  .../dt-bindings/reset-controller/mt8135-resets.h   |  64 +++
>  4 files changed, 895 insertions(+)
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
> index 0000000..a08f2fe
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8135.c
> @@ -0,0 +1,640 @@
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
> +static DEFINE_SPINLOCK(mt8135_clk_lock);
> +
> +static const struct mtk_fixed_factor root_clk_alias[] __initconst = {
> +       FACTOR(TOP_DSI0_LNTC_DSICLK, "dsi0_lntc_dsiclk", "clk_null", 1, 1),
> +       FACTOR(TOP_HDMITX_CLKDIG_CTS, "hdmitx_clkdig_cts", "clk_null", 1, 1),
> +       FACTOR(TOP_CLKPH_MCK, "clkph_mck", "clk_null", 1, 1),
> +       FACTOR(TOP_CPUM_TCK_IN, "cpum_tck_in", "clk_null", 1, 1),
> +};
> +
> +static const struct mtk_fixed_factor top_divs[] __initconst = {
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

shouldn't that be
FACTOR(TOP_UNIVPLL_D10, "univpll_d10", "univpll_249p6m", 1, 2),
as univpll_249p6m is univpll divided by 5?
