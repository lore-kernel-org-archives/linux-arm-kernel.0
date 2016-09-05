From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 5 Sep 2016 14:34:21 +0800
Subject: [PATCH 4/6] clk: sunxi-ng: Add A33 CCU support
In-Reply-To: <20160901141617.9777-5-maxime.ripard@free-electrons.com>
References: <20160901141617.9777-1-maxime.ripard@free-electrons.com>
 <20160901141617.9777-5-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66z4KMbfOr2kcNXSSXzVqXQ1uZ9p_-uNyvb_7_ACdNCqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 1, 2016 at 10:16 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> This commit introduces the clocks found in the Allwinner A33 CCU.
>
> Since this SoC is very similar to the A23, and we share a significant share
> of the DTSI, the clock IDs that are going to be used will also be shared
> with the A23, hence the name of the various header files.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
>  drivers/clk/sunxi-ng/Kconfig                       |  12 +
>  drivers/clk/sunxi-ng/Makefile                      |   1 +
>  drivers/clk/sunxi-ng/ccu-sun8i-a23-a33.h           |  63 ++
>  drivers/clk/sunxi-ng/ccu-sun8i-a33.c               | 772 +++++++++++++++++++++
>  include/dt-bindings/clock/sun8i-a23-a33-ccu.h      | 127 ++++
>  include/dt-bindings/reset/sun8i-a23-a33-ccu.h      |  87 +++
>  7 files changed, 1063 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a23-a33.h
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a33.c
>  create mode 100644 include/dt-bindings/clock/sun8i-a23-a33-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun8i-a23-a33-ccu.h
>
> diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> index eac458720b28..8fd765ea3660 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> @@ -4,6 +4,7 @@ Allwinner Clock Control Unit Binding
>  Required properties :
>  - compatible: must contain one of the following compatibles:
>                 - "allwinner,sun6i-a31-ccu"
> +               - "allwinner,sun8i-a33-ccu"
>                 - "allwinner,sun8i-h3-ccu"
>
>  - reg: Must contain the registers base address and length
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index c7258779daa8..dff3feff9c3c 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -65,6 +65,18 @@ config SUN6I_A31_CCU
>         select SUNXI_CCU_PHASE
>         default MACH_SUN6I
>
> +config SUN8I_A33_CCU
> +       bool "Support for the Allwinner A33 CCU"
> +       select SUNXI_CCU_DIV
> +       select SUNXI_CCU_MULT
> +       select SUNXI_CCU_NK
> +       select SUNXI_CCU_NKM
> +       select SUNXI_CCU_NKMP
> +       select SUNXI_CCU_NM
> +       select SUNXI_CCU_MP
> +       select SUNXI_CCU_PHASE
> +       default MACH_SUN8I
> +
>  config SUN8I_H3_CCU
>         bool "Support for the Allwinner H3 CCU"
>         select SUNXI_CCU_DIV
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 462a5f8383ed..4f7e99fb433f 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -19,4 +19,5 @@ obj-$(CONFIG_SUNXI_CCU_MP)    += ccu_mp.o
>
>  # SoC support
>  obj-$(CONFIG_SUN6I_A31_CCU)    += ccu-sun6i-a31.o
> +obj-$(CONFIG_SUN8I_A33_CCU)    += ccu-sun8i-a33.o
>  obj-$(CONFIG_SUN8I_H3_CCU)     += ccu-sun8i-h3.o
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23-a33.h b/drivers/clk/sunxi-ng/ccu-sun8i-a23-a33.h
> new file mode 100644
> index 000000000000..62c0f8d49ef8
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23-a33.h
> @@ -0,0 +1,63 @@
> +/*
> + * Copyright 2016 Maxime Ripard
> + *
> + * Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _CCU_SUN8I_A23_A33_H_
> +#define _CCU_SUN8I_A23_A33_H_
> +
> +#include <dt-bindings/clock/sun8i-a23-a33-ccu.h>
> +#include <dt-bindings/reset/sun8i-a23-a33-ccu.h>
> +
> +#define CLK_PLL_CPUX           0
> +#define CLK_PLL_AUDIO_BASE     1
> +#define CLK_PLL_AUDIO          2
> +#define CLK_PLL_AUDIO_2X       3
> +#define CLK_PLL_AUDIO_4X       4
> +#define CLK_PLL_AUDIO_8X       5
> +#define CLK_PLL_VIDEO          6
> +#define CLK_PLL_VIDEO_2X       7
> +#define CLK_PLL_VE             8
> +#define CLK_PLL_DDR0           9
> +#define CLK_PLL_PERIPH         10
> +#define CLK_PLL_PERIPH_2X      11
> +#define CLK_PLL_GPU            12
> +#define CLK_PLL_MIPI           13
> +#define CLK_PLL_HSIC           14
> +#define CLK_PLL_DE             15
> +#define CLK_PLL_DDR1           16
> +#define CLK_PLL_DDR            17
> +
> +/* The CPUX clock is exported */
> +
> +#define CLK_AXI                        19
> +#define CLK_AHB1               20
> +#define CLK_APB1               21
> +#define CLK_APB2               22
> +
> +/* All the bus gates are exported */
> +
> +/* The first part of the mod clocks is exported */
> +
> +#define CLK_DRAM               79
> +
> +/* Some more module clocks are exported */
> +
> +#define CLK_MBUS               95
> +
> +/* And the last module clocks are exported */
> +
> +#define CLK_NUMBER             (CLK_ATS + 1)
> +
> +#endif /* _CCU_SUN8I_A23_A33_H_ */
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
> new file mode 100644
> index 000000000000..420bacb88e6e
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
> @@ -0,0 +1,772 @@
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
> +#include <linux/of_address.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_reset.h"
> +
> +#include "ccu_div.h"
> +#include "ccu_gate.h"
> +#include "ccu_mp.h"
> +#include "ccu_mult.h"
> +#include "ccu_nk.h"
> +#include "ccu_nkm.h"
> +#include "ccu_nkmp.h"
> +#include "ccu_nm.h"
> +#include "ccu_phase.h"
> +
> +#include "ccu-sun8i-a23-a33.h"
> +
> +static SUNXI_CCU_NKMP_WITH_GATE_LOCK(pll_cpux_clk, "pll-cpux",
> +                                    "osc24M", 0x000,
> +                                    8, 5,              /* N */
> +                                    4, 2,              /* K */
> +                                    0, 2,              /* M */
> +                                    16, 2,             /* P */

Manual says there's no divider for P = 0x3.
You'll need a table here.

> +                                    BIT(31),           /* gate */
> +                                    BIT(28),           /* lock */
> +                                    0);
> +
> +/*
> + * The Audio PLL is supposed to have 4 outputs: 3 fixed factors from
> + * the base (2x, 4x and 8x), and one variable divider (the one true
> + * pll audio).
> + *
> + * We don't have any need for the variable divider for now, so we just
> + * hardcode it to match with the clock names
> + */
> +#define SUN8I_A33_PLL_AUDIO_REG        0x008
> +
> +static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
> +                                  "osc24M", 0x008,
> +                                  8, 7,                /* N */
> +                                  0, 5,                /* M */
> +                                  BIT(31),             /* gate */
> +                                  BIT(28),             /* lock */
> +                                  CLK_SET_RATE_UNGATE);

Are you sure about this? I suspect CLK_SET_RATE_GATE (clk must be
gated before set rate) is what you want, given the non-DVFS
nature of the PLL. Same for the other PLLs.

[...]

> +static SUNXI_CCU_GATE(bus_mipi_dsi_clk,        "bus-mipi-dsi", "ahb1",
> +                     0x060, BIT(1), 0);

Nit: we know which bus these peripherals are on.
Can we be more explicit with the names?

> +static SUNXI_CCU_GATE(bus_ce_clk,      "bus-ce",       "ahb1",
> +                     0x060, BIT(5), 0);

Nit: manual says Security System.

(Maybe I should change the name on sun6i to say Crypto Engine
 if that's what we're going with?)

[...]

> +static SUNXI_CCU_GATE(usb_hsic_12M_clk,        "usb-hsic-12M", "osc24M",
> +                     0x0cc, BIT(11), 0);

A TODO note saying we should have a fixed-factor-gate for this
would be nice.

[...]

> diff --git a/include/dt-bindings/clock/sun8i-a23-a33-ccu.h b/include/dt-bindings/clock/sun8i-a23-a33-ccu.h
> new file mode 100644
> index 000000000000..3782e56b84cd
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun8i-a23-a33-ccu.h
> @@ -0,0 +1,127 @@
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
> +#ifndef _DT_BINDINGS_CLK_SUN8I_A23_A33_H_
> +#define _DT_BINDINGS_CLK_SUN8I_A23_A33_H_
> +
> +#define CLK_CPUX               18
> +
> +#define CLK_BUS_MIPI_DSI       23
> +#define CLK_BUS_CE             24
> +#define CLK_BUS_DMA            25
> +#define CLK_BUS_MMC0           26
> +#define CLK_BUS_MMC1           27
> +#define CLK_BUS_MMC2           28
> +#define CLK_BUS_NAND           29
> +#define CLK_BUS_DRAM           30
> +#define CLK_BUS_HSTIMER                31
> +#define CLK_BUS_SPI0           32
> +#define CLK_BUS_SPI1           33
> +#define CLK_BUS_OTG            34
> +#define CLK_BUS_EHCI           35
> +#define CLK_BUS_OHCI           36
> +#define CLK_BUS_VE             37
> +#define CLK_BUS_LCD            38
> +#define CLK_BUS_CSI            39
> +#define CLK_BUS_DE_BE          40
> +#define CLK_BUS_DE_FE          41
> +#define CLK_BUS_GPU            42
> +#define CLK_BUS_MSGBOX         43
> +#define CLK_BUS_SPINLOCK       44
> +#define CLK_BUS_DRC            45
> +#define CLK_BUS_SAT            46
> +#define CLK_BUS_CODEC          47
> +#define CLK_BUS_PIO            48
> +#define CLK_BUS_I2S0           49
> +#define CLK_BUS_I2S1           50
> +#define CLK_BUS_I2C0           51
> +#define CLK_BUS_I2C1           52
> +#define CLK_BUS_I2C2           53
> +#define CLK_BUS_UART0          54
> +#define CLK_BUS_UART1          55
> +#define CLK_BUS_UART2          56
> +#define CLK_BUS_UART3          57
> +#define CLK_BUS_UART4          58

Same with the bus name here.

> +#define CLK_NAND               59
> +#define CLK_MMC0               60
> +#define CLK_MMC0_SAMPLE                61
> +#define CLK_MMC0_OUTPUT                62
> +#define CLK_MMC1               63
> +#define CLK_MMC1_SAMPLE                64
> +#define CLK_MMC1_OUTPUT                65
> +#define CLK_MMC2               66
> +#define CLK_MMC2_SAMPLE                67
> +#define CLK_MMC2_OUTPUT                68
> +#define CLK_CE                 69
> +#define CLK_SPI0               70
> +#define CLK_SPI1               71
> +#define CLK_I2S0               72
> +#define CLK_I2S1               73
> +#define CLK_USB_PHY0           74
> +#define CLK_USB_PHY1           75
> +#define CLK_USB_HSIC           76
> +#define CLK_USB_HSIC_12M       77
> +#define CLK_USB_OHCI           78
> +
> +#define CLK_DRAM_VE            80
> +#define CLK_DRAM_CSI           81
> +#define CLK_DRAM_DRC           82
> +#define CLK_DRAM_DE_FE         83
> +#define CLK_DRAM_DE_BE         84
> +#define CLK_DE_BE              85
> +#define CLK_DE_FE              86
> +#define CLK_LCD_CH0            87
> +#define CLK_LCD_CH1            88
> +#define CLK_CSI_SCLK           89
> +#define CLK_CSI_MCLK           90
> +#define CLK_VE                 91
> +#define CLK_AC_DIG             92
> +#define CLK_AC_DIG_4X          93
> +#define CLK_AVS                        94
> +
> +#define CLK_DSI_SCLK           96
> +#define CLK_DSI_DPHY           97
> +#define CLK_DRC                        98
> +#define CLK_GPU                        99
> +#define CLK_ATS                        100
> +
> +#endif /* _DT_BINDINGS_CLK_SUN8I_A23_A33_H_ */
> diff --git a/include/dt-bindings/reset/sun8i-a23-a33-ccu.h b/include/dt-bindings/reset/sun8i-a23-a33-ccu.h
> new file mode 100644
> index 000000000000..03555a2f4175
> --- /dev/null
> +++ b/include/dt-bindings/reset/sun8i-a23-a33-ccu.h
> @@ -0,0 +1,87 @@
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
> +#ifndef _DT_BINDINGS_RST_SUN8I_A23_A33_H_
> +#define _DT_BINDINGS_RST_SUN8I_A23_A33_H_
> +
> +#define RST_USB_PHY0           0
> +#define RST_USB_PHY1           1
> +#define RST_USB_HSIC           2
> +#define RST_MBUS               3
> +#define RST_BUS_MIPI_DSI       4
> +#define RST_BUS_CE             5
> +#define RST_BUS_DMA            6
> +#define RST_BUS_MMC0           7
> +#define RST_BUS_MMC1           8
> +#define RST_BUS_MMC2           9
> +#define RST_BUS_NAND           10
> +#define RST_BUS_DRAM           11
> +#define RST_BUS_HSTIMER                12
> +#define RST_BUS_SPI0           13
> +#define RST_BUS_SPI1           14
> +#define RST_BUS_OTG            15
> +#define RST_BUS_EHCI           16
> +#define RST_BUS_OHCI           17
> +#define RST_BUS_VE             18
> +#define RST_BUS_LCD            19
> +#define RST_BUS_CSI            20
> +#define RST_BUS_DE_BE          21
> +#define RST_BUS_DE_FE          22
> +#define RST_BUS_GPU            23
> +#define RST_BUS_MSGBOX         24
> +#define RST_BUS_SPINLOCK       25
> +#define RST_BUS_DRC            26
> +#define RST_BUS_SAT            27
> +#define RST_BUS_LVDS           28
> +#define RST_BUS_CODEC          29
> +#define RST_BUS_I2S0           30
> +#define RST_BUS_I2S1           31
> +#define RST_BUS_I2C0           32
> +#define RST_BUS_I2C1           33
> +#define RST_BUS_I2C2           34
> +#define RST_BUS_UART0          35
> +#define RST_BUS_UART1          36
> +#define RST_BUS_UART2          37
> +#define RST_BUS_UART3          38
> +#define RST_BUS_UART4          39

Same with the bus name here.

Regards
ChenYu

> +
> +#endif /* _DT_BINDINGS_RST_SUN8I_A23_A33_H_ */
> --
> 2.9.2
>
