From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 31 May 2016 00:15:28 +0800
Subject: [PATCH 15/16] clk: sunxi-ng: Add H3 clocks
In-Reply-To: <1462737711-10017-16-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-16-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67RUCZfFaXnM2LxomV5DBSVApXHHs0noiNEbReOh_3W9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 9, 2016 at 4:01 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Add the list of clocks and resets found in the H3 CCU.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/Makefile        |   2 +
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c  | 757 +++++++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/sun8i-h3.h | 162 ++++++++
>  include/dt-bindings/reset/sun8i-h3.h | 103 +++++
>  4 files changed, 1024 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>  create mode 100644 include/dt-bindings/clock/sun8i-h3.h
>  create mode 100644 include/dt-bindings/reset/sun8i-h3.h
>
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index c794f57b6fb1..67ff6a92f124 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -13,3 +13,5 @@ obj-y += ccu_nkmp.o
>  obj-y += ccu_nm.o
>  obj-y += ccu_p.o
>  obj-y += ccu_phase.o
> +
> +obj-y += ccu-sun8i-h3.o
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> new file mode 100644
> index 000000000000..5ce699e95c32
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> @@ -0,0 +1,757 @@
> +/*
> + * Copyright (c) 2016 Maxime Ripard. All rights reserved.
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
> +#include <linux/clk-provider.h>
> +
> +#include <dt-bindings/clock/sun8i-h3.h>
> +#include <dt-bindings/reset/sun8i-h3.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_reset.h"
> +
> +#include "ccu_div_table.h"
> +#include "ccu_factor.h"
> +#include "ccu_fixed_factor.h"
> +#include "ccu_gate.h"
> +#include "ccu_m.h"
> +#include "ccu_mp.h"
> +#include "ccu_nk.h"
> +#include "ccu_nkm.h"
> +#include "ccu_nkmp.h"
> +#include "ccu_nm.h"
> +#include "ccu_p.h"
> +#include "ccu_phase.h"
> +
> +static struct ccu_nkmp pll_cpux_clk = {
> +       .enable         = BIT(31),
> +       .lock           = BIT(28),
> +
> +       .m              = SUNXI_CLK_FACTOR(0, 2),
> +       .k              = SUNXI_CLK_FACTOR(4, 2),
> +       .n              = SUNXI_CLK_FACTOR(8, 5),
> +       .p              = SUNXI_CLK_FACTOR(16, 2),

We should find a way to specify a table for p.

> +
> +       .common         = {
> +               .reg            = 0x000,
> +               .features       = CCU_FEATURE_GATE | CCU_FEATURE_LOCK,
> +               .hw.init        = SUNXI_HW_INIT("pll-cpux",
> +                                               "osc24M",

osc24M is an outside reference. Shouldn't we use put it in a "clocks"
property in the DT, and use of_clk_get_parent_name()?

osc24M can be controlled from the PRCM on other chips. I suspect the
same with the H3. osc32k might also be from the PRCM.

> +                                               &ccu_nkmp_ops,
> +                                               0),
> +       },
> +};
> +
> +static struct ccu_nm pll_audio_base_clk = {
> +       .enable         = BIT(31),
> +       .lock           = BIT(28),
> +
> +       .m              = SUNXI_CLK_FACTOR(0, 5),
> +       .n              = SUNXI_CLK_FACTOR(8, 7),
> +
> +       .common         = {
> +               .reg            = 0x008,
> +               .features       = CCU_FEATURE_GATE | CCU_FEATURE_LOCK,
> +               .hw.init        = SUNXI_HW_INIT("pll-audio-base",
> +                                               "osc24M",
> +                                               &ccu_nm_ops,
> +                                               0),
> +       },
> +};
> +
> +static SUNXI_CCU_M(pll_audio_clk, "pll-audio", "pll-audio-base",
> +                  0x008, 16, 4, 0);
> +
> +static SUNXI_CCU_FIXED_FACTOR(pll_audio_2x_clk, "pll-audio-2x",
> +                             "pll-audio-base", 2, 1, 0);
> +static SUNXI_CCU_FIXED_FACTOR(pll_audio_4x_clk, "pll-audio-4x",
> +                             "pll-audio-base", 1, 1, 0);
> +static SUNXI_CCU_FIXED_FACTOR(pll_audio_8x_clk, "pll-audio-8x",
> +                             "pll-audio-base", 1, 2, 0);
> +
> +static struct ccu_nm pll_video_clk = {
> +       .enable         = BIT(31),
> +       .lock           = BIT(28),
> +
> +       .m              = SUNXI_CLK_FACTOR(0, 4),
> +       .n              = SUNXI_CLK_FACTOR(8, 7),
> +
> +       .common         = {
> +               .reg            = 0x010,
> +               .features       = CCU_FEATURE_GATE | CCU_FEATURE_LOCK,
> +               .hw.init        = SUNXI_HW_INIT("pll-video",
> +                                               "osc24M",
> +                                               &ccu_nm_ops,
> +                                               0),
> +       },
> +};
> +
> +static struct ccu_nm pll_ve_clk = {
> +       .enable         = BIT(31),
> +       .lock           = BIT(28),
> +
> +       .m              = SUNXI_CLK_FACTOR(0, 4),
> +       .n              = SUNXI_CLK_FACTOR(8, 7),
> +
> +       .common         = {
> +               .reg            = 0x018,
> +               .features       = CCU_FEATURE_GATE | CCU_FEATURE_LOCK,
> +               .hw.init        = SUNXI_HW_INIT("pll-ve",
> +                                               "osc24M",
> +                                               &ccu_nm_ops,
> +                                               0),
> +       },
> +};
> +
> +static struct ccu_nkm pll_ddr_clk = {
> +       .enable         = BIT(31),
> +       .lock           = BIT(28),
> +
> +       .n              = SUNXI_CLK_FACTOR(8, 5),
> +       .k              = SUNXI_CLK_FACTOR(4, 2),
> +       .m              = SUNXI_CLK_FACTOR(0, 2),

We need a special "update" bit (bit 20) for this clock, otherwise changes
don't really take effect.

> +
> +       .common         = {
> +               .reg            = 0x020,
> +               .features       = CCU_FEATURE_GATE | CCU_FEATURE_LOCK,
> +               .hw.init        = SUNXI_HW_INIT("pll-ddr",
> +                                               "osc24M",
> +                                               &ccu_nkm_ops,
> +                                               0),
> +       },
> +};
> +
> +static struct ccu_nk pll_periph0_clk = {
> +       .enable         = BIT(31),
> +       .lock           = BIT(28),
> +
> +       .k              = SUNXI_CLK_FACTOR(4, 2),
> +       .n              = SUNXI_CLK_FACTOR(8, 5),
> +       .fixed_post_div = 2,
> +
> +       .common         = {
> +               .reg            = 0x028,
> +               .features       = (CCU_FEATURE_GATE |
> +                                  CCU_FEATURE_LOCK |
> +                                  CCU_FEATURE_FIXED_POSTDIV),
> +               .hw.init        = SUNXI_HW_INIT("pll-periph0",
> +                                               "osc24M",
> +                                               &ccu_nk_ops,
> +                                               0),
> +       },
> +};
> +
> +static SUNXI_CCU_FIXED_FACTOR(pll_periph0_2x_clk, "pll-periph0-2x",
> +                             "pll-periph0", 1, 2, 0);
> +
> +static struct ccu_nm pll_gpu_clk = {
> +       .enable         = BIT(31),
> +       .lock           = BIT(28),
> +
> +       .m              = SUNXI_CLK_FACTOR(0, 4),
> +       .n              = SUNXI_CLK_FACTOR(8, 7),
> +
> +       .common         = {
> +               .reg            = 0x038,
> +               .features       = CCU_FEATURE_GATE | CCU_FEATURE_LOCK,
> +               .hw.init        = SUNXI_HW_INIT("pll-gpu",
> +                                               "osc24M",
> +                                               &ccu_nm_ops,
> +                                               0),
> +       },
> +};
> +
> +static struct ccu_nk pll_periph1_clk = {
> +       .enable         = BIT(31),
> +       .lock           = BIT(28),
> +
> +       .k              = SUNXI_CLK_FACTOR(4, 2),
> +       .n              = SUNXI_CLK_FACTOR(8, 5),
> +       .fixed_post_div = 2,
> +
> +       .common         = {
> +               .reg            = 0x044,
> +               .features       = (CCU_FEATURE_GATE |
> +                                  CCU_FEATURE_LOCK |
> +                                  CCU_FEATURE_FIXED_POSTDIV),
> +               .hw.init        = SUNXI_HW_INIT("pll-periph1",
> +                                               "osc24M",
> +                                               &ccu_nk_ops,
> +                                               0),
> +       },
> +};
> +
> +static struct ccu_nm pll_de_clk = {
> +       .enable         = BIT(31),
> +       .lock           = BIT(28),
> +
> +       .m              = SUNXI_CLK_FACTOR(0, 4),
> +       .n              = SUNXI_CLK_FACTOR(8, 7),
> +
> +       .common         = {
> +               .reg            = 0x048,
> +               .features       = CCU_FEATURE_GATE | CCU_FEATURE_LOCK,
> +               .hw.init        = SUNXI_HW_INIT("pll-de",
> +                                               "osc24M",
> +                                               &ccu_nm_ops,
> +                                               0),
> +       },
> +};
> +
> +static const char * const cpux_parents[] = { "osc32k", "osc24M", "pll-cpux" , "pll-cpux" };
> +static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
> +                    0x050, 16, 2, CLK_IS_CRITICAL);

Nit: Is it necessary to split this line?

> +
> +static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x050, 0, 2, 0);

This register also has a "System APB" clock. Any idea what that is?

> +
> +static const char * const ahb1_parents[] = { "osc32k", "osc24M", "axi" , "pll-periph0" };
> +static struct ccu_p ahb1_clk = {
> +       .p              = SUNXI_CLK_FACTOR(4, 2),
> +
> +       .mux            = {
> +               .shift  = 12,
> +               .width  = 2,
> +
> +               .variable_prediv        = {
> +                       .index  = 3,
> +                       .shift  = 6,
> +                       .width  = 2,
> +               },
> +       },
> +
> +       .common         = {
> +               .reg            = 0x054,
> +               .features       = CCU_FEATURE_VARIABLE_PREDIV,
> +               .hw.init        = SUNXI_HW_INIT_PARENTS("ahb1",
> +                                                       ahb1_parents,
> +                                                       &ccu_p_ops,
> +                                                       0),
> +       },
> +};
> +
> +static u8 apb1_div_table [] = { 2, 2, 4, 8 };
> +static SUNXI_CCU_DIV_TABLE(apb1_clk, "apb1", "ahb1",
> +                          0x054, 8, 2, apb1_div_table, 0);
> +
> +static const char * const apb2_parents[] = { "osc32k", "osc24M",
> +                                            "pll-periph0" , "pll-periph0" };
> +static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", apb2_parents, 0x058,
> +                            0, 5,      /* M */
> +                            16, 2,     /* P */
> +                            24, 2,     /* mux */
> +                            0);
> +
> +static const char * const ahb2_parents[] = { "ahb1" , "pll-periph0" };
> +static struct ccu_mux ahb2_clk = {
> +       .mux            = {
> +               .shift  = 0,
> +               .width  = 1,
> +
> +               .fixed_prediv   = {
> +                       .index  = 1,
> +                       .div    = 2,
> +               },
> +       },
> +
> +       .common         = {
> +               .reg            = 0x05c,
> +               .features       = CCU_FEATURE_FIXED_PREDIV,
> +               .hw.init        = SUNXI_HW_INIT_PARENTS("ahb2",
> +                                                       ahb2_parents,
> +                                                       &ccu_mux_ops,
> +                                                       0),
> +       },
> +};
> +
> +static SUNXI_CCU_GATE(bus_ce_clk,      "bus-ce",       "ahb1",
> +                     0x060, BIT(5), 0);
> +static SUNXI_CCU_GATE(bus_dma_clk,     "bus-dma",      "ahb1",
> +                     0x060, BIT(6), 0);
> +static SUNXI_CCU_GATE(bus_mmc0_clk,    "bus-mmc0",     "ahb1",
> +                     0x060, BIT(8), 0);
> +static SUNXI_CCU_GATE(bus_mmc1_clk,    "bus-mmc1",     "ahb1",
> +                     0x060, BIT(9), 0);
> +static SUNXI_CCU_GATE(bus_mmc2_clk,    "bus-mmc2",     "ahb1",
> +                     0x060, BIT(10), 0);
> +static SUNXI_CCU_GATE(bus_nand_clk,    "bus-nand",     "ahb1",
> +                     0x060, BIT(13), 0);
> +static SUNXI_CCU_GATE(bus_dram_clk,    "bus-dram",     "ahb1",
> +                     0x060, BIT(14), 0);
> +static SUNXI_CCU_GATE(bus_emac_clk,    "bus-emac",     "ahb2",
> +                     0x060, BIT(17), 0);
> +static SUNXI_CCU_GATE(bus_ts_clk,      "bus-ts",       "ahb1",
> +                     0x060, BIT(18), 0);
> +static SUNXI_CCU_GATE(bus_hstimer_clk, "bus-hstimer",  "ahb1",
> +                     0x060, BIT(19), 0);
> +static SUNXI_CCU_GATE(bus_spi0_clk,    "bus-spi0",     "ahb1",
> +                     0x060, BIT(20), 0);
> +static SUNXI_CCU_GATE(bus_spi1_clk,    "bus-spi1",     "ahb1",
> +                     0x060, BIT(21), 0);
> +static SUNXI_CCU_GATE(bus_otg_clk,     "bus-otg",      "ahb1",
> +                     0x060, BIT(23), 0);
> +static SUNXI_CCU_GATE(bus_ehci0_clk,   "bus-ehci0",    "ahb2",

Clock diagram says ?HCI 1/2/3 are on ahb2, while otg (I assume it includes
both the OTG controller and the associated ?HCI) is on ahb1.

> +                     0x060, BIT(24), 0);
> +static SUNXI_CCU_GATE(bus_ehci1_clk,   "bus-ehci1",    "ahb2",
> +                     0x060, BIT(25), 0);
> +static SUNXI_CCU_GATE(bus_ehci2_clk,   "bus-ehci2",    "ahb2",
> +                     0x060, BIT(26), 0);
> +static SUNXI_CCU_GATE(bus_ehci3_clk,   "bus-ehci3",    "ahb2",
> +                     0x060, BIT(27), 0);
> +static SUNXI_CCU_GATE(bus_ohci0_clk,   "bus-ohci0",    "ahb2",
> +                     0x060, BIT(28), 0);
> +static SUNXI_CCU_GATE(bus_ohci1_clk,   "bus-ohci1",    "ahb2",
> +                     0x060, BIT(29), 0);
> +static SUNXI_CCU_GATE(bus_ohci2_clk,   "bus-ohci2",    "ahb2",
> +                     0x060, BIT(30), 0);
> +static SUNXI_CCU_GATE(bus_ohci3_clk,   "bus-ohci3",    "ahb2",
> +                     0x060, BIT(31), 0);
> +
> +static SUNXI_CCU_GATE(bus_ve_clk,      "bus-ve",       "ahb1",
> +                     0x064, BIT(0), 0);
> +static SUNXI_CCU_GATE(bus_tcon0_clk,   "bus-tcon0",    "ahb1",
> +                     0x064, BIT(3), 0);
> +static SUNXI_CCU_GATE(bus_tcon1_clk,   "bus-tcon1",    "ahb1",
> +                     0x064, BIT(4), 0);
> +static SUNXI_CCU_GATE(bus_deinterlace_clk,     "bus-deinterlace",      "ahb1",
> +                     0x064, BIT(5), 0);
> +static SUNXI_CCU_GATE(bus_csi_clk,     "bus-csi",      "ahb1",
> +                     0x064, BIT(8), 0);
> +static SUNXI_CCU_GATE(bus_tve_clk,     "bus-tve",      "ahb1",
> +                     0x064, BIT(9), 0);
> +static SUNXI_CCU_GATE(bus_hdmi_clk,    "bus-hdmi",     "ahb1",
> +                     0x064, BIT(11), 0);
> +static SUNXI_CCU_GATE(bus_de_clk,      "bus-de",       "ahb1",
> +                     0x064, BIT(12), 0);
> +static SUNXI_CCU_GATE(bus_gpu_clk,     "bus-gpu",      "ahb1",
> +                     0x064, BIT(20), 0);
> +static SUNXI_CCU_GATE(bus_msgbox_clk,  "bus-msgbox",   "ahb1",
> +                     0x064, BIT(21), 0);
> +static SUNXI_CCU_GATE(bus_spinlock_clk,        "bus-spinlock", "ahb1",
> +                     0x064, BIT(22), 0);
> +
> +static SUNXI_CCU_GATE(bus_codec_clk,   "bus-codec",    "apb1",
> +                     0x068, BIT(0), 0);
> +static SUNXI_CCU_GATE(bus_spdif_clk,   "bus-spdif",    "apb1",
> +                     0x068, BIT(1), 0);
> +static SUNXI_CCU_GATE(bus_pio_clk,     "bus-pio",      "apb1",
> +                     0x068, BIT(5), 0);
> +static SUNXI_CCU_GATE(bus_ths_clk,     "bus-ths",      "apb1",
> +                     0x068, BIT(8), 0);
> +static SUNXI_CCU_GATE(bus_i2s0_clk,    "bus-i2s0",     "apb1",
> +                     0x068, BIT(12), 0);
> +static SUNXI_CCU_GATE(bus_i2s1_clk,    "bus-i2s1",     "apb1",
> +                     0x068, BIT(13), 0);
> +static SUNXI_CCU_GATE(bus_i2s2_clk,    "bus-i2s2",     "apb1",
> +                     0x068, BIT(14), 0);
> +
> +static SUNXI_CCU_GATE(bus_i2c0_clk,    "bus-i2c0",     "apb2",
> +                     0x06c, BIT(0), 0);
> +static SUNXI_CCU_GATE(bus_i2c1_clk,    "bus-i2c1",     "apb2",
> +                     0x06c, BIT(1), 0);
> +static SUNXI_CCU_GATE(bus_i2c2_clk,    "bus-i2c2",     "apb2",
> +                     0x06c, BIT(2), 0);
> +static SUNXI_CCU_GATE(bus_uart0_clk,   "bus-uart0",    "apb2",
> +                     0x06c, BIT(16), 0);
> +static SUNXI_CCU_GATE(bus_uart1_clk,   "bus-uart1",    "apb2",
> +                     0x06c, BIT(17), 0);
> +static SUNXI_CCU_GATE(bus_uart2_clk,   "bus-uart2",    "apb2",
> +                     0x06c, BIT(18), 0);
> +static SUNXI_CCU_GATE(bus_uart3_clk,   "bus-uart3",    "apb2",
> +                     0x06c, BIT(19), 0);
> +static SUNXI_CCU_GATE(bus_scr_clk,     "bus-scr",      "apb2",
> +                     0x06c, BIT(20), 0);
> +
> +static SUNXI_CCU_GATE(bus_ephy_clk,    "bus-ephy",     "ahb1",
> +                     0x070, BIT(0), 0);
> +static SUNXI_CCU_GATE(bus_dbg_clk,     "bus-dbg",      "ahb1",
> +                     0x070, BIT(7), 0);

Maybe not split these lines? IMHO it's easier to read as table.

> +
> +static u8 ths_div_table [] = { 1, 2, 4, 6 };
> +static SUNXI_CCU_DIV_TABLE_WITH_GATE(ths_clk, "ths", "osc24M",
> +                                    0x074, 0, 2, ths_div_table, BIT(31), 0);

The clock actually has a mux, which has only one valid parent.
Should we include it?

> +
> +static const char * const nand_parents[] = { "osc24M", "pll-periph0",
> +                                            "pll-periph1" };
> +static SUNXI_CCU_MP_WITH_MUX_GATE(nand_clk, "nand", nand_parents, 0x080,
> +                                 0, 4,         /* M */
> +                                 16, 2,        /* P */
> +                                 24, 2,        /* mux */
> +                                 BIT(31),      /* gate */
> +                                 0);
> +
> +static const char * const mmc0_parents[] = { "osc24M", "pll-periph0",
> +                                            "pll-periph1" };
> +static SUNXI_CCU_MP_WITH_MUX_GATE(mmc0_clk, "mmc0", mmc0_parents, 0x088,
> +                                 0, 4,         /* M */
> +                                 16, 2,        /* P */
> +                                 24, 2,        /* mux */
> +                                 BIT(31),      /* gate */
> +                                 0);
> +
> +static SUNXI_CCU_PHASE(mmc0_sample_clk, "mmc0_sample", "mmc0",
> +                      0x088, 20, 3, 0);
> +static SUNXI_CCU_PHASE(mmc0_output_clk, "mmc0_output", "mmc0",
> +                      0x088, 8, 3, 0);
> +
> +static const char * const mmc1_parents[] = { "osc24M", "pll-periph0",
> +                                            "pll-periph1" };
> +static SUNXI_CCU_MP_WITH_MUX_GATE(mmc1_clk, "mmc1", mmc1_parents, 0x08c,
> +                                 0, 4,         /* M */
> +                                 16, 2,        /* P */
> +                                 24, 2,        /* mux */
> +                                 BIT(31),      /* gate */
> +                                 0);
> +
> +static SUNXI_CCU_PHASE(mmc1_sample_clk, "mmc1_sample", "mmc1",
> +                      0x08c, 20, 3, 0);
> +static SUNXI_CCU_PHASE(mmc1_output_clk, "mmc1_output", "mmc1",
> +                      0x08c, 8, 3, 0);
> +
> +static const char * const mmc2_parents[] = { "osc24M", "pll-periph0",
> +                                            "pll-periph1" };
> +static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mmc2_parents, 0x090,
> +                                 0, 4,         /* M */
> +                                 16, 2,        /* P */
> +                                 24, 2,        /* mux */
> +                                 BIT(31),      /* gate */
> +                                 0);
> +
> +static SUNXI_CCU_PHASE(mmc2_sample_clk, "mmc2_sample", "mmc2",
> +                      0x090, 20, 3, 0);
> +static SUNXI_CCU_PHASE(mmc2_output_clk, "mmc2_output", "mmc2",
> +                      0x090, 8, 3, 0);
> +
> +static const char * const ts_parents[] = { "osc24M", "pll-periph0", };
> +static SUNXI_CCU_MP_WITH_MUX_GATE(ts_clk, "ts", ts_parents, 0x098,
> +                                 0, 4,         /* M */
> +                                 16, 2,        /* P */
> +                                 24, 1,        /* mux */

The mux is 4 bits wide with only 2 valid parents.

> +                                 BIT(31),      /* gate */
> +                                 0);
> +
> +static const char * const ce_parents[] = { "osc24M", "pll-periph0",
> +                                          "pll-periph1" };
> +static SUNXI_CCU_MP_WITH_MUX_GATE(ce_clk, "ce", ce_parents, 0x09c,
> +                                 0, 4,         /* M */
> +                                 16, 2,        /* P */
> +                                 24, 2,        /* mux */
> +                                 BIT(31),      /* gate */
> +                                 0);
> +
> +static const char * const spi0_parents[] = { "osc24M", "pll-periph0",
> +                                            "pll-periph1" };
> +static SUNXI_CCU_MP_WITH_MUX_GATE(spi0_clk, "spi0", spi0_parents, 0x0a0,
> +                                 0, 4,         /* M */
> +                                 16, 2,        /* P */
> +                                 24, 2,        /* mux */
> +                                 BIT(31),      /* gate */
> +                                 0);
> +
> +static const char * const spi1_parents[] = { "osc24M", "pll-periph0",
> +                                            "pll-periph1" };
> +static SUNXI_CCU_MP_WITH_MUX_GATE(spi1_clk, "spi1", spi1_parents, 0x0a4,
> +                                 0, 4,         /* M */
> +                                 16, 2,        /* P */
> +                                 24, 2,        /* mux */
> +                                 BIT(31),      /* gate */
> +                                 0);
> +
> +static const char * const i2s0_parents[] = { "pll-audio-8x", "pll-audio-4x",
> +                                            "pll-audio-2x" , "pll-audio" };
> +static SUNXI_CCU_MUX_WITH_GATE(i2s0_clk, "i2s0", i2s0_parents,
> +                              0x0b0, 16, 2, BIT(31), 0);
> +
> +static const char * const i2s1_parents[] = { "pll-audio-8x", "pll-audio-4x",
> +                                            "pll-audio-2x" , "pll-audio" };
> +static SUNXI_CCU_MUX_WITH_GATE(i2s1_clk, "i2s1", i2s1_parents,
> +                              0x0b4, 16, 2, BIT(31), 0);
> +
> +static const char * const i2s2_parents[] = { "pll-audio-8x", "pll-audio-4x",
> +                                            "pll-audio-2x" , "pll-audio" };
> +static SUNXI_CCU_MUX_WITH_GATE(i2s2_clk, "i2s2", i2s2_parents,
> +                              0x0b8, 16, 2, BIT(31), 0);
> +
> +static SUNXI_CCU_M_WITH_GATE(spdif_clk, "spdif", "pll-audio",
> +                            0x0c0, 0, 4, BIT(31), 0);
> +
> +static SUNXI_CCU_GATE(usb_phy0_clk,    "usb-phy0",     "osc24M",
> +                     0x0cc, BIT(8), 0);
> +static SUNXI_CCU_GATE(usb_phy1_clk,    "usb-phy1",     "osc24M",
> +                     0x0cc, BIT(9), 0);
> +static SUNXI_CCU_GATE(usb_phy2_clk,    "usb-phy2",     "osc24M",
> +                     0x0cc, BIT(10), 0);
> +static SUNXI_CCU_GATE(usb_phy3_clk,    "usb-phy3",     "osc24M",
> +                     0x0cc, BIT(11), 0);
> +static SUNXI_CCU_GATE(usb_ohci0_clk,   "usb-ohci0",    "osc24M",
> +                     0x0cc, BIT(16), 0);
> +static SUNXI_CCU_GATE(usb_ohci1_clk,   "usb-ohci1",    "osc24M",
> +                     0x0cc, BIT(17), 0);
> +static SUNXI_CCU_GATE(usb_ohci2_clk,   "usb-ohci2",    "osc24M",
> +                     0x0cc, BIT(18), 0);
> +static SUNXI_CCU_GATE(usb_ohci3_clk,   "usb-ohci3",    "osc24M",
> +                     0x0cc, BIT(19), 0);
> +
> +static const char * const dram_parents[] = { "pll-ddr", "pll-periph0-2x" };
> +static SUNXI_CCU_M_WITH_MUX(dram_clk, "dram", dram_parents,
> +                           0x0f4, 0, 4, 20, 1, 0);

Mux is 2 bits wide. Also need an update bit setting for this clock.
(or mark it read-only?)

> +
> +static SUNXI_CCU_GATE(dram_ve_clk,     "dram-ve",      "dram",
> +                     0x100, BIT(0), 0);
> +static SUNXI_CCU_GATE(dram_csi_clk,    "dram-csi",     "dram",
> +                     0x100, BIT(1), 0);
> +static SUNXI_CCU_GATE(dram_deinterlace_clk,    "dram-deinterlace",     "dram",
> +                     0x100, BIT(2), 0);
> +static SUNXI_CCU_GATE(dram_ts_clk,     "dram-ts",      "dram",
> +                     0x100, BIT(3), 0);
> +
> +static const char * const de_parents[] = { "pll-periph0-2x", "pll-de" };
> +static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
> +                                0x104, 0, 4, 24, 1, BIT(31), 0);
> +
> +static SUNXI_CCU_M_WITH_GATE(tcon_clk, "tcon", "pll-video",
> +                            0x118, 0, 4, BIT(31), 0);
> +
> +static const char * const tve_parents[] = { "pll-de", "pll-periph1" };
> +static SUNXI_CCU_M_WITH_MUX_GATE(tve_clk, "tve", tve_parents,
> +                                0x120, 0, 4, 24, 1, BIT(31), 0);
> +
> +static const char * const deinterlace_parents[] = { "pll-periph0", "pll-periph1" };
> +static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk, "deinterlace", deinterlace_parents,
> +                                0x124, 0, 4, 24, 1, BIT(31), 0);

Mux is 3 bits wide for DE, TCON, TVE, and DEINTERLACE clocks.

> +
> +static SUNXI_CCU_GATE(csi_misc_clk,    "csi-misc",     "osc24M",
> +                     0x130, BIT(31), 0);
> +
> +static const char * const csi_sclk_parents[] = { "pll-periph0", "pll-periph1" };
> +static SUNXI_CCU_M_WITH_MUX_GATE(csi_sclk_clk, "csi-sclk", csi_sclk_parents,
> +                                0x134, 16, 4, 24, 1, BIT(31), 0);

Mux is 3 bits wide.

> +
> +static const char * const csi_mclk_parents[] = { "osc24M", "pll-video", "pll-periph0" };
> +static SUNXI_CCU_M_WITH_MUX_GATE(csi_mclk_clk, "csi-mclk", csi_mclk_parents,
> +                                0x134, 0, 5, 8, 2, BIT(15), 0);

Same here.

> +
> +static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve",
> +                            0x13c, 16, 3, BIT(31), 0);
> +
> +static SUNXI_CCU_GATE(ac_dig_clk,      "ac-dig",       "pll-audio",
> +                     0x140, BIT(31), 0);
> +static SUNXI_CCU_GATE(avs_clk,         "avs",          "osc24M",
> +                     0x144, BIT(31), 0);
> +
> +static SUNXI_CCU_M_WITH_GATE(hdmi_clk, "hdmi", "pll-video",
> +                            0x150, 0, 4, BIT(31), 0);

2 bit mux?

> +
> +static SUNXI_CCU_GATE(hdmi_ddc_clk,    "hdmi-ddc",     "osc24M",
> +                     0x154, BIT(31), 0);
> +
> +static const char * const mbus_parents[] = { "osc24M", "pll-periph0-2x", "pll-ddr" };
> +static SUNXI_CCU_M_WITH_MUX_GATE(mbus_clk, "mbus", mbus_parents,
> +                                0x15c, 0, 3, 24, 2, BIT(31), CLK_IS_CRITICAL);
> +
> +static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
> +                            0x1a0, 0, 3, BIT(31), 0);
> +
> +static struct ccu_common *sun8i_h3_ccu_clks[] = {
> +       [CLK_PLL_CPUX]          = &pll_cpux_clk.common,
> +       [CLK_PLL_AUDIO_BASE]    = &pll_audio_base_clk.common,
> +       [CLK_PLL_AUDIO]         = &pll_audio_clk.common,
> +       [CLK_PLL_AUDIO_2X]      = &pll_audio_2x_clk.common,
> +       [CLK_PLL_AUDIO_4X]      = &pll_audio_4x_clk.common,
> +       [CLK_PLL_AUDIO_8X]      = &pll_audio_8x_clk.common,
> +       [CLK_PLL_VIDEO]         = &pll_video_clk.common,
> +       [CLK_PLL_VE]            = &pll_ve_clk.common,
> +       [CLK_PLL_DDR]           = &pll_ddr_clk.common,
> +       [CLK_PLL_PERIPH0]       = &pll_periph0_clk.common,
> +       [CLK_PLL_PERIPH0_2X]    = &pll_periph0_2x_clk.common,
> +       [CLK_PLL_GPU]           = &pll_gpu_clk.common,
> +       [CLK_PLL_PERIPH1]       = &pll_periph1_clk.common,
> +       [CLK_PLL_DE]            = &pll_de_clk.common,
> +       [CLK_CPUX]              = &cpux_clk.common,
> +       [CLK_AXI]               = &axi_clk.common,
> +       [CLK_AHB1]              = &ahb1_clk.common,
> +       [CLK_APB1]              = &apb1_clk.common,
> +       [CLK_APB2]              = &apb2_clk.common,
> +       [CLK_AHB2]              = &ahb2_clk.common,
> +       [CLK_BUS_CE]            = &bus_ce_clk.common,
> +       [CLK_BUS_DMA]           = &bus_dma_clk.common,
> +       [CLK_BUS_MMC0]          = &bus_mmc0_clk.common,
> +       [CLK_BUS_MMC1]          = &bus_mmc1_clk.common,
> +       [CLK_BUS_MMC2]          = &bus_mmc2_clk.common,
> +       [CLK_BUS_NAND]          = &bus_nand_clk.common,
> +       [CLK_BUS_DRAM]          = &bus_dram_clk.common,
> +       [CLK_BUS_EMAC]          = &bus_emac_clk.common,
> +       [CLK_BUS_TS]            = &bus_ts_clk.common,
> +       [CLK_BUS_HSTIMER]       = &bus_hstimer_clk.common,
> +       [CLK_BUS_SPI0]          = &bus_spi0_clk.common,
> +       [CLK_BUS_SPI1]          = &bus_spi1_clk.common,
> +       [CLK_BUS_OTG]           = &bus_otg_clk.common,
> +       [CLK_BUS_EHCI0]         = &bus_ehci0_clk.common,
> +       [CLK_BUS_EHCI1]         = &bus_ehci1_clk.common,
> +       [CLK_BUS_EHCI2]         = &bus_ehci2_clk.common,
> +       [CLK_BUS_EHCI3]         = &bus_ehci3_clk.common,
> +       [CLK_BUS_OHCI0]         = &bus_ohci0_clk.common,
> +       [CLK_BUS_OHCI1]         = &bus_ohci1_clk.common,
> +       [CLK_BUS_OHCI2]         = &bus_ohci2_clk.common,
> +       [CLK_BUS_OHCI3]         = &bus_ohci3_clk.common,
> +       [CLK_BUS_VE]            = &bus_ve_clk.common,
> +       [CLK_BUS_TCON0]         = &bus_tcon0_clk.common,
> +       [CLK_BUS_TCON1]         = &bus_tcon1_clk.common,
> +       [CLK_BUS_DEINTERLACE]   = &bus_deinterlace_clk.common,
> +       [CLK_BUS_CSI]           = &bus_csi_clk.common,
> +       [CLK_BUS_TVE]           = &bus_tve_clk.common,
> +       [CLK_BUS_HDMI]          = &bus_hdmi_clk.common,
> +       [CLK_BUS_DE]            = &bus_de_clk.common,
> +       [CLK_BUS_GPU]           = &bus_gpu_clk.common,
> +       [CLK_BUS_MSGBOX]        = &bus_msgbox_clk.common,
> +       [CLK_BUS_SPINLOCK]      = &bus_spinlock_clk.common,
> +       [CLK_BUS_CODEC]         = &bus_codec_clk.common,
> +       [CLK_BUS_SPDIF]         = &bus_spdif_clk.common,
> +       [CLK_BUS_PIO]           = &bus_pio_clk.common,
> +       [CLK_BUS_THS]           = &bus_ths_clk.common,
> +       [CLK_BUS_I2S0]          = &bus_i2s0_clk.common,
> +       [CLK_BUS_I2S1]          = &bus_i2s1_clk.common,
> +       [CLK_BUS_I2S2]          = &bus_i2s2_clk.common,
> +       [CLK_BUS_I2C0]          = &bus_i2c0_clk.common,
> +       [CLK_BUS_I2C1]          = &bus_i2c1_clk.common,
> +       [CLK_BUS_I2C2]          = &bus_i2c2_clk.common,
> +       [CLK_BUS_UART0]         = &bus_uart0_clk.common,
> +       [CLK_BUS_UART1]         = &bus_uart1_clk.common,
> +       [CLK_BUS_UART2]         = &bus_uart2_clk.common,
> +       [CLK_BUS_UART3]         = &bus_uart3_clk.common,
> +       [CLK_BUS_SCR]           = &bus_scr_clk.common,
> +       [CLK_BUS_EPHY]          = &bus_ephy_clk.common,
> +       [CLK_BUS_DBG]           = &bus_dbg_clk.common,
> +       [CLK_THS]               = &ths_clk.common,
> +       [CLK_NAND]              = &nand_clk.common,
> +       [CLK_MMC0]              = &mmc0_clk.common,
> +       [CLK_MMC0_SAMPLE]       = &mmc0_sample_clk.common,
> +       [CLK_MMC0_OUTPUT]       = &mmc0_output_clk.common,
> +       [CLK_MMC1]              = &mmc1_clk.common,
> +       [CLK_MMC1_SAMPLE]       = &mmc1_sample_clk.common,
> +       [CLK_MMC1_OUTPUT]       = &mmc1_output_clk.common,
> +       [CLK_MMC2]              = &mmc2_clk.common,
> +       [CLK_MMC2_SAMPLE]       = &mmc2_sample_clk.common,
> +       [CLK_MMC2_OUTPUT]       = &mmc2_output_clk.common,
> +       [CLK_TS]                = &ts_clk.common,
> +       [CLK_CE]                = &ce_clk.common,
> +       [CLK_SPI0]              = &spi0_clk.common,
> +       [CLK_SPI1]              = &spi1_clk.common,
> +       [CLK_I2S0]              = &i2s0_clk.common,
> +       [CLK_I2S1]              = &i2s1_clk.common,
> +       [CLK_I2S2]              = &i2s2_clk.common,
> +       [CLK_SPDIF]             = &spdif_clk.common,
> +       [CLK_USB_PHY0]          = &usb_phy0_clk.common,
> +       [CLK_USB_PHY1]          = &usb_phy1_clk.common,
> +       [CLK_USB_PHY2]          = &usb_phy2_clk.common,
> +       [CLK_USB_PHY3]          = &usb_phy3_clk.common,
> +       [CLK_USB_OHCI0]         = &usb_ohci0_clk.common,
> +       [CLK_USB_OHCI1]         = &usb_ohci1_clk.common,
> +       [CLK_USB_OHCI2]         = &usb_ohci2_clk.common,
> +       [CLK_USB_OHCI3]         = &usb_ohci3_clk.common,
> +       [CLK_DRAM]              = &dram_clk.common,
> +       [CLK_DRAM_VE]           = &dram_ve_clk.common,
> +       [CLK_DRAM_CSI]          = &dram_csi_clk.common,
> +       [CLK_DRAM_DEINTERLACE]  = &dram_deinterlace_clk.common,
> +       [CLK_DRAM_TS]           = &dram_ts_clk.common,
> +       [CLK_DE]                = &de_clk.common,
> +       [CLK_TCON0]             = &tcon_clk.common,
> +       [CLK_TVE]               = &tve_clk.common,
> +       [CLK_DEINTERLACE]       = &deinterlace_clk.common,
> +       [CLK_CSI_MISC]          = &csi_misc_clk.common,
> +       [CLK_CSI_SCLK]          = &csi_sclk_clk.common,
> +       [CLK_CSI_MCLK]          = &csi_mclk_clk.common,
> +       [CLK_VE]                = &ve_clk.common,
> +       [CLK_AC_DIG]            = &ac_dig_clk.common,
> +       [CLK_AVS]               = &avs_clk.common,
> +       [CLK_HDMI]              = &hdmi_clk.common,
> +       [CLK_HDMI_DDC]          = &hdmi_ddc_clk.common,
> +       [CLK_MBUS]              = &mbus_clk.common,
> +       [CLK_GPU]               = &gpu_clk.common,
> +};
> +
> +static struct ccu_reset_map sun8i_h3_ccu_resets[] = {
> +       [RST_USB_PHY0]          =  { 0x0cc, BIT(0) },
> +       [RST_USB_PHY1]          =  { 0x0cc, BIT(1) },
> +       [RST_USB_PHY2]          =  { 0x0cc, BIT(2) },
> +       [RST_USB_PHY3]          =  { 0x0cc, BIT(3) },
> +
> +       [RST_MBUS]              =  { 0x0fc, BIT(31) },
> +
> +       [RST_BUS_CE]            =  { 0x2c0, BIT(5) },
> +       [RST_BUS_DMA]           =  { 0x2c0, BIT(6) },
> +       [RST_BUS_MMC0]          =  { 0x2c0, BIT(8) },
> +       [RST_BUS_MMC1]          =  { 0x2c0, BIT(9) },
> +       [RST_BUS_MMC2]          =  { 0x2c0, BIT(10) },
> +       [RST_BUS_NAND]          =  { 0x2c0, BIT(13) },
> +       [RST_BUS_DRAM]          =  { 0x2c0, BIT(14) },
> +       [RST_BUS_EMAC]          =  { 0x2c0, BIT(17) },
> +       [RST_BUS_TS]            =  { 0x2c0, BIT(18) },
> +       [RST_BUS_HSTIMER]       =  { 0x2c0, BIT(19) },
> +       [RST_BUS_SPI0]          =  { 0x2c0, BIT(20) },
> +       [RST_BUS_SPI1]          =  { 0x2c0, BIT(21) },
> +       [RST_BUS_OTG]           =  { 0x2c0, BIT(23) },
> +       [RST_BUS_EHCI0]         =  { 0x2c0, BIT(24) },
> +       [RST_BUS_EHCI1]         =  { 0x2c0, BIT(25) },
> +       [RST_BUS_EHCI2]         =  { 0x2c0, BIT(26) },
> +       [RST_BUS_EHCI3]         =  { 0x2c0, BIT(27) },
> +       [RST_BUS_OHCI0]         =  { 0x2c0, BIT(28) },
> +       [RST_BUS_OHCI1]         =  { 0x2c0, BIT(29) },
> +       [RST_BUS_OHCI2]         =  { 0x2c0, BIT(30) },
> +       [RST_BUS_OHCI3]         =  { 0x2c0, BIT(31) },
> +
> +       [RST_BUS_VE]            =  { 0x2c4, BIT(0) },
> +       [RST_BUS_TCON0]         =  { 0x2c4, BIT(3) },
> +       [RST_BUS_TCON1]         =  { 0x2c4, BIT(4) },
> +       [RST_BUS_DEINTERLACE]   =  { 0x2c4, BIT(5) },
> +       [RST_BUS_CSI]           =  { 0x2c4, BIT(8) },
> +       [RST_BUS_TVE]           =  { 0x2c4, BIT(9) },
> +       [RST_BUS_HDMI0]         =  { 0x2c4, BIT(10) },
> +       [RST_BUS_HDMI1]         =  { 0x2c4, BIT(11) },
> +       [RST_BUS_DE]            =  { 0x2c4, BIT(12) },
> +       [RST_BUS_GPU]           =  { 0x2c4, BIT(20) },
> +       [RST_BUS_MSGBOX]        =  { 0x2c4, BIT(21) },
> +       [RST_BUS_SPINLOCK]      =  { 0x2c4, BIT(22) },
> +       [RST_BUS_DBG]           =  { 0x2c4, BIT(31) },
> +
> +       [RST_BUS_EPHY]          =  { 0x2c8, BIT(2) },
> +
> +       [RST_BUS_CODEC]         =  { 0x2d0, BIT(0) },
> +       [RST_BUS_SPDIF]         =  { 0x2d0, BIT(1) },
> +       [RST_BUS_THS]           =  { 0x2d0, BIT(8) },
> +       [RST_BUS_I2S0]          =  { 0x2d0, BIT(12) },
> +       [RST_BUS_I2S1]          =  { 0x2d0, BIT(13) },
> +       [RST_BUS_I2S2]          =  { 0x2d0, BIT(14) },
> +
> +       [RST_BUS_I2C0]          =  { 0x2d4, BIT(0) },
> +       [RST_BUS_I2C1]          =  { 0x2d4, BIT(1) },
> +       [RST_BUS_I2C2]          =  { 0x2d4, BIT(2) },
> +       [RST_BUS_UART0]         =  { 0x2d4, BIT(16) },
> +       [RST_BUS_UART1]         =  { 0x2d4, BIT(17) },
> +       [RST_BUS_UART2]         =  { 0x2d4, BIT(18) },
> +       [RST_BUS_UART3]         =  { 0x2d4, BIT(19) },
> +       [RST_BUS_SCR]           =  { 0x2d4, BIT(20) },
> +};
> +
> +static const struct sunxi_ccu_desc sun8i_h3_ccu_desc = {
> +       .clks           = sun8i_h3_ccu_clks,
> +       .num_clks       = ARRAY_SIZE(sun8i_h3_ccu_clks),
> +
> +       .resets         = sun8i_h3_ccu_resets,
> +       .num_resets     = ARRAY_SIZE(sun8i_h3_ccu_resets),
> +};
> +
> +static void __init sun8i_h3_ccu_setup(struct device_node *node)
> +{
> +       sunxi_ccu_probe(node, &sun8i_h3_ccu_desc);
> +}
> +CLK_OF_DECLARE(sun8i_h3_ccu, "allwinner,sun8i-h3-ccu",
> +              sun8i_h3_ccu_setup);
> diff --git a/include/dt-bindings/clock/sun8i-h3.h b/include/dt-bindings/clock/sun8i-h3.h
> new file mode 100644
> index 000000000000..96eced56e7a2
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun8i-h3.h
> @@ -0,0 +1,162 @@
> +/*
> + * Copyright (C) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_SUN8I_H3_H_
> +#define _DT_BINDINGS_CLK_SUN8I_H3_H_
> +
> +#define CLK_PLL_CPUX           0
> +#define CLK_PLL_AUDIO_BASE     1
> +#define CLK_PLL_AUDIO          2
> +#define CLK_PLL_AUDIO_2X       3
> +#define CLK_PLL_AUDIO_4X       4
> +#define CLK_PLL_AUDIO_8X       5
> +#define CLK_PLL_VIDEO          6
> +#define CLK_PLL_VE             7
> +#define CLK_PLL_DDR            8
> +#define CLK_PLL_PERIPH0                9
> +#define CLK_PLL_PERIPH0_2X     10
> +#define CLK_PLL_GPU            11
> +#define CLK_PLL_PERIPH1                12
> +#define CLK_PLL_DE             13
> +#define CLK_CPUX               14
> +#define CLK_AXI                        15
> +#define CLK_AHB1               16
> +#define CLK_APB1               17
> +#define CLK_APB2               18
> +#define CLK_AHB2               19
> +#define CLK_BUS_CE             20
> +#define CLK_BUS_DMA            21
> +#define CLK_BUS_MMC0           22
> +#define CLK_BUS_MMC1           23
> +#define CLK_BUS_MMC2           24
> +#define CLK_BUS_NAND           25
> +#define CLK_BUS_DRAM           26
> +#define CLK_BUS_EMAC           27
> +#define CLK_BUS_TS             28
> +#define CLK_BUS_HSTIMER                29
> +#define CLK_BUS_SPI0           30
> +#define CLK_BUS_SPI1           31
> +#define CLK_BUS_OTG            32
> +#define CLK_BUS_EHCI0          33
> +#define CLK_BUS_EHCI1          34
> +#define CLK_BUS_EHCI2          35
> +#define CLK_BUS_EHCI3          36
> +#define CLK_BUS_OHCI0          37
> +#define CLK_BUS_OHCI1          38
> +#define CLK_BUS_OHCI2          39
> +#define CLK_BUS_OHCI3          40
> +#define CLK_BUS_VE             41
> +#define CLK_BUS_TCON0          42
> +#define CLK_BUS_TCON1          43
> +#define CLK_BUS_DEINTERLACE    44
> +#define CLK_BUS_CSI            45
> +#define CLK_BUS_TVE            46
> +#define CLK_BUS_HDMI           47
> +#define CLK_BUS_DE             48
> +#define CLK_BUS_GPU            49
> +#define CLK_BUS_MSGBOX         50
> +#define CLK_BUS_SPINLOCK       51
> +#define CLK_BUS_CODEC          52
> +#define CLK_BUS_SPDIF          53
> +#define CLK_BUS_PIO            54
> +#define CLK_BUS_THS            55
> +#define CLK_BUS_I2S0           56
> +#define CLK_BUS_I2S1           57
> +#define CLK_BUS_I2S2           58
> +#define CLK_BUS_I2C0           59
> +#define CLK_BUS_I2C1           60
> +#define CLK_BUS_I2C2           61
> +#define CLK_BUS_UART0          62
> +#define CLK_BUS_UART1          63
> +#define CLK_BUS_UART2          64
> +#define CLK_BUS_UART3          65
> +#define CLK_BUS_SCR            66
> +#define CLK_BUS_EPHY           67
> +#define CLK_BUS_DBG            68
> +#define CLK_THS                        69
> +#define CLK_NAND               70
> +#define CLK_MMC0               71
> +#define CLK_MMC0_SAMPLE                72
> +#define CLK_MMC0_OUTPUT                73
> +#define CLK_MMC1               74
> +#define CLK_MMC1_SAMPLE                75
> +#define CLK_MMC1_OUTPUT                76
> +#define CLK_MMC2               77
> +#define CLK_MMC2_SAMPLE                78
> +#define CLK_MMC2_OUTPUT                79
> +#define CLK_TS                 80
> +#define CLK_CE                 81
> +#define CLK_SPI0               82
> +#define CLK_SPI1               83
> +#define CLK_I2S0               84
> +#define CLK_I2S1               85
> +#define CLK_I2S2               86
> +#define CLK_SPDIF              87
> +#define CLK_USB_PHY0           88
> +#define CLK_USB_PHY1           89
> +#define CLK_USB_PHY2           90
> +#define CLK_USB_PHY3           91
> +#define CLK_USB_OHCI0          92
> +#define CLK_USB_OHCI1          93
> +#define CLK_USB_OHCI2          94
> +#define CLK_USB_OHCI3          95
> +#define CLK_DRAM               96
> +#define CLK_DRAM_VE            97
> +#define CLK_DRAM_CSI           98
> +#define CLK_DRAM_DEINTERLACE   99
> +#define CLK_DRAM_TS            100
> +#define CLK_DE                 101
> +#define CLK_TCON0              102
> +#define CLK_TVE                        103
> +#define CLK_DEINTERLACE                104
> +#define CLK_CSI_MISC           105
> +#define CLK_CSI_SCLK           106
> +#define CLK_CSI_MCLK           107
> +#define CLK_VE                 108
> +#define CLK_AC_DIG             109
> +#define CLK_AVS                        110
> +#define CLK_HDMI               111
> +#define CLK_HDMI_DDC           112
> +#define CLK_MBUS               113
> +#define CLK_GPU                        114
> +
> +#endif /* _DT_BINDINGS_CLK_SUN8I_H3_H_ */
> diff --git a/include/dt-bindings/reset/sun8i-h3.h b/include/dt-bindings/reset/sun8i-h3.h
> new file mode 100644
> index 000000000000..6b7af80c26ec
> --- /dev/null
> +++ b/include/dt-bindings/reset/sun8i-h3.h
> @@ -0,0 +1,103 @@
> +/*
> + * Copyright (C) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef _DT_BINDINGS_RST_SUN8I_H3_H_
> +#define _DT_BINDINGS_RST_SUN8I_H3_H_
> +
> +#define RST_USB_PHY0           0
> +#define RST_USB_PHY1           1
> +#define RST_USB_PHY2           2
> +#define RST_USB_PHY3           3
> +
> +#define RST_MBUS               4
> +
> +#define RST_BUS_CE             5
> +#define RST_BUS_DMA            6
> +#define RST_BUS_MMC0           7
> +#define RST_BUS_MMC1           8
> +#define RST_BUS_MMC2           9
> +#define RST_BUS_NAND           10
> +#define RST_BUS_DRAM           11
> +#define RST_BUS_EMAC           12
> +#define RST_BUS_TS             13
> +#define RST_BUS_HSTIMER                14
> +#define RST_BUS_SPI0           15
> +#define RST_BUS_SPI1           16
> +#define RST_BUS_OTG            17
> +#define RST_BUS_EHCI0          18
> +#define RST_BUS_EHCI1          19
> +#define RST_BUS_EHCI2          20
> +#define RST_BUS_EHCI3          21
> +#define RST_BUS_OHCI0          22
> +#define RST_BUS_OHCI1          23
> +#define RST_BUS_OHCI2          24
> +#define RST_BUS_OHCI3          25
> +#define RST_BUS_VE             26
> +#define RST_BUS_TCON0          27
> +#define RST_BUS_TCON1          28
> +#define RST_BUS_DEINTERLACE    29
> +#define RST_BUS_CSI            30
> +#define RST_BUS_TVE            31
> +#define RST_BUS_HDMI0          32
> +#define RST_BUS_HDMI1          33
> +#define RST_BUS_DE             34
> +#define RST_BUS_GPU            35
> +#define RST_BUS_MSGBOX         36
> +#define RST_BUS_SPINLOCK       37
> +#define RST_BUS_DBG            38
> +#define RST_BUS_EPHY           39
> +#define RST_BUS_CODEC          40
> +#define RST_BUS_SPDIF          41
> +#define RST_BUS_THS            42
> +#define RST_BUS_I2S0           43
> +#define RST_BUS_I2S1           44
> +#define RST_BUS_I2S2           45
> +#define RST_BUS_I2C0           46
> +#define RST_BUS_I2C1           47
> +#define RST_BUS_I2C2           48
> +#define RST_BUS_UART0          49
> +#define RST_BUS_UART1          50
> +#define RST_BUS_UART2          51
> +#define RST_BUS_UART3          52
> +#define RST_BUS_SCR            53
> +
> +#endif /* _DT_BINDINGS_RST_SUN8I_H3_H_ */
> --
> 2.8.2
>

The rest looks good. Sorry it took so long.

About the mux widths, I prefer to have the full width, even if only the first
few values are valid. It would prevent someone playing with the registers (or
bad code) and the values sticking, before the kernel loads. Then the kernel
won't think that it set a valid parent, but the high bit was not cleared, and
whatever peripheral ended up not working.


Regards
ChenYu
