From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 19:47:34 +0200
Subject: [linux-sunxi] [PATCH v4 6/9] clk: sunxi-ng: Add A64 clocks
In-Reply-To: <CAGb2v67YnusPeJhQ-__ntW1MsVc6QMj4DY0YQn71xFteHDW3OA@mail.gmail.com>
References: <cover.024e1b023e41efe548dc6a004f7a946408d5c9a2.1476196031.git-series.maxime.ripard@free-electrons.com>
 <cd4dd81821b8910d40626baab2dbfdabd94b1b98.1476196031.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67YnusPeJhQ-__ntW1MsVc6QMj4DY0YQn71xFteHDW3OA@mail.gmail.com>
Message-ID: <20161020174734.pv6ijuscyhfgjhaf@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 11:50:21PM +0800, Chen-Yu Tsai wrote:
> On Tue, Oct 11, 2016 at 10:28 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Add the A64 CCU clocks set.
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  Documentation/devicetree/bindings/clock/sunxi-ccu.txt |   1 +-
> >  drivers/clk/sunxi-ng/Kconfig                          |  11 +-
> >  drivers/clk/sunxi-ng/Makefile                         |   1 +-
> >  drivers/clk/sunxi-ng/ccu-sun50i-a64.c                 | 918 +++++++++++-
> >  drivers/clk/sunxi-ng/ccu-sun50i-a64.h                 |  72 +-
> >  include/dt-bindings/clock/sun50i-a64-ccu.h            | 134 ++-
> >  include/dt-bindings/reset/sun50i-a64-ccu.h            |  98 +-
> >  7 files changed, 1235 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> >  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a64.h
> >  create mode 100644 include/dt-bindings/clock/sun50i-a64-ccu.h
> >  create mode 100644 include/dt-bindings/reset/sun50i-a64-ccu.h
> >
> > diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> > index 3868458a5feb..74d44a4273f2 100644
> > --- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> > +++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> > @@ -7,6 +7,7 @@ Required properties :
> >                 - "allwinner,sun8i-a23-ccu"
> >                 - "allwinner,sun8i-a33-ccu"
> >                 - "allwinner,sun8i-h3-ccu"
> > +               - "allwinner,sun50i-a64-ccu"
> >
> >  - reg: Must contain the registers base address and length
> >  - clocks: phandle to the oscillators feeding the CCU. Two are needed:
> > diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> > index 1b4c55a53d7a..8454c6e3dd65 100644
> > --- a/drivers/clk/sunxi-ng/Kconfig
> > +++ b/drivers/clk/sunxi-ng/Kconfig
> > @@ -53,6 +53,17 @@ config SUNXI_CCU_MP
> >
> >  # SoC Drivers
> >
> > +config SUN50I_A64_CCU
> > +       bool "Support for the Allwinner A64 CCU"
> > +       select SUNXI_CCU_DIV
> > +       select SUNXI_CCU_NK
> > +       select SUNXI_CCU_NKM
> > +       select SUNXI_CCU_NKMP
> > +       select SUNXI_CCU_NM
> > +       select SUNXI_CCU_MP
> > +       select SUNXI_CCU_PHASE
> > +       default ARM64 && ARCH_SUNXI
> > +
> >  config SUN6I_A31_CCU
> >         bool "Support for the Allwinner A31/A31s CCU"
> >         select SUNXI_CCU_DIV
> > diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> > index 106cba27c331..24fbc6e5deb8 100644
> > --- a/drivers/clk/sunxi-ng/Makefile
> > +++ b/drivers/clk/sunxi-ng/Makefile
> > @@ -18,6 +18,7 @@ obj-$(CONFIG_SUNXI_CCU_NM)    += ccu_nm.o
> >  obj-$(CONFIG_SUNXI_CCU_MP)     += ccu_mp.o
> >
> >  # SoC support
> > +obj-$(CONFIG_SUN50I_A64_CCU)   += ccu-sun50i-a64.o
> >  obj-$(CONFIG_SUN6I_A31_CCU)    += ccu-sun6i-a31.o
> >  obj-$(CONFIG_SUN8I_A23_CCU)    += ccu-sun8i-a23.o
> >  obj-$(CONFIG_SUN8I_A33_CCU)    += ccu-sun8i-a33.o
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> > new file mode 100644
> > index 000000000000..c0e96bf6d104
> > --- /dev/null
> > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> > @@ -0,0 +1,918 @@
> > +/*
> > + * Copyright (c) 2016 Maxime Ripard. All rights reserved.
> > + *
> > + * This software is licensed under the terms of the GNU General Public
> > + * License version 2, as published by the Free Software Foundation, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "ccu_common.h"
> > +#include "ccu_reset.h"
> > +
> > +#include "ccu_div.h"
> > +#include "ccu_gate.h"
> > +#include "ccu_mp.h"
> > +#include "ccu_mult.h"
> > +#include "ccu_nk.h"
> > +#include "ccu_nkm.h"
> > +#include "ccu_nkmp.h"
> > +#include "ccu_nm.h"
> > +#include "ccu_phase.h"
> > +
> > +#include "ccu-sun50i-a64.h"
> > +
> > +static struct ccu_nkmp pll_cpux_clk = {
> > +       .enable         = BIT(31),
> > +       .lock           = BIT(28),
> > +       .n              = _SUNXI_CCU_MULT(8, 5),
> > +       .k              = _SUNXI_CCU_MULT(4, 2),
> > +       .m              = _SUNXI_CCU_DIV(0, 2),
> > +       .p              = _SUNXI_CCU_DIV_MAX(16, 2, 4),
> > +       .common         = {
> > +               .reg            = 0x000,
> > +               .hw.init        = CLK_HW_INIT("pll-cpux",
> > +                                             "osc24M",
> > +                                             &ccu_nkmp_ops,
> > +                                             0),
> > +       },
> > +};
> > +
> > +/*
> > + * The Audio PLL is supposed to have 4 outputs: 3 fixed factors from
> > + * the base (2x, 4x and 8x), and one variable divider (the one true
> > + * pll audio).
> > + *
> > + * We don't have any need for the variable divider for now, so we just
> > + * hardcode it to match with the clock names
> > + */
> > +#define SUN50I_A64_PLL_AUDIO_REG       0x008
> > +
> > +static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
> > +                                  "osc24M", 0x008,
> > +                                  8, 7,        /* N */
> > +                                  0, 5,        /* M */
> > +                                  BIT(31),     /* gate */
> > +                                  BIT(28),     /* lock */
> > +                                  0);
> > +
> > +static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video0_clk, "pll-video0",
> > +                                       "osc24M", 0x010,
> > +                                       8, 7,           /* N */
> > +                                       0, 4,           /* M */
> > +                                       BIT(24),        /* frac enable */
> > +                                       BIT(25),        /* frac select */
> > +                                       270000000,      /* frac rate 0 */
> > +                                       297000000,      /* frac rate 1 */
> > +                                       BIT(31),        /* gate */
> > +                                       BIT(28),        /* lock */
> > +                                       0);
> > +
> > +static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
> > +                                       "osc24M", 0x018,
> > +                                       8, 7,           /* N */
> > +                                       0, 4,           /* M */
> > +                                       BIT(24),        /* frac enable */
> > +                                       BIT(25),        /* frac select */
> > +                                       270000000,      /* frac rate 0 */
> > +                                       297000000,      /* frac rate 1 */
> > +                                       BIT(31),        /* gate */
> > +                                       BIT(28),        /* lock */
> > +                                       0);
> > +
> > +static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_ddr0_clk, "pll-ddr0",
> > +                                   "osc24M", 0x020,
> > +                                   8, 5,       /* N */
> > +                                   4, 2,       /* K */
> > +                                   0, 2,       /* M */
> > +                                   BIT(31),    /* gate */
> > +                                   BIT(28),    /* lock */
> > +                                   0);
> > +
> > +static struct ccu_nk pll_periph0_clk = {
> > +       .enable         = BIT(31),
> > +       .lock           = BIT(28),
> > +       .n              = _SUNXI_CCU_MULT(8, 5),
> > +       .k              = _SUNXI_CCU_MULT_MIN(4, 2, 2),
> > +       .fixed_post_div = 2,
> > +       .common         = {
> > +               .reg            = 0x028,
> > +               .features       = CCU_FEATURE_FIXED_POSTDIV,
> > +               .hw.init        = CLK_HW_INIT("pll-periph0", "osc24M",
> > +                                             &ccu_nk_ops, 0),
> > +       },
> > +};
> > +
> > +static struct ccu_nk pll_periph1_clk = {
> > +       .enable         = BIT(31),
> > +       .lock           = BIT(28),
> > +       .n              = _SUNXI_CCU_MULT(8, 5),
> > +       .k              = _SUNXI_CCU_MULT_MIN(4, 2, 2),
> > +       .fixed_post_div = 2,
> > +       .common         = {
> > +               .reg            = 0x02c,
> > +               .features       = CCU_FEATURE_FIXED_POSTDIV,
> > +               .hw.init        = CLK_HW_INIT("pll-periph1", "osc24M",
> > +                                             &ccu_nk_ops, 0),
> > +       },
> > +};
> > +
> > +static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video1_clk, "pll-video1",
> > +                                       "osc24M", 0x030,
> > +                                       8, 7,           /* N */
> > +                                       0, 4,           /* M */
> > +                                       BIT(24),        /* frac enable */
> > +                                       BIT(25),        /* frac select */
> > +                                       270000000,      /* frac rate 0 */
> > +                                       297000000,      /* frac rate 1 */
> > +                                       BIT(31),        /* gate */
> > +                                       BIT(28),        /* lock */
> > +                                       0);
> > +
> > +static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
> > +                                       "osc24M", 0x038,
> > +                                       8, 7,           /* N */
> > +                                       0, 4,           /* M */
> > +                                       BIT(24),        /* frac enable */
> > +                                       BIT(25),        /* frac select */
> > +                                       270000000,      /* frac rate 0 */
> > +                                       297000000,      /* frac rate 1 */
> > +                                       BIT(31),        /* gate */
> > +                                       BIT(28),        /* lock */
> > +                                       0);
> > +
> > +/*
> > + * The output function can be changed to something more complex that
> > + * we do not handle yet.
> > + *
> > + * Hardcode the mode so that we don't fall in that case.
> > + */
> > +#define SUN50I_A64_PLL_MIPI_REG                0x040
> > +
> > +struct ccu_nkm pll_mipi_clk = {
> > +       .enable         = BIT(31),
> > +       .lock           = BIT(28),
> > +       .n              = _SUNXI_CCU_MULT(8, 4),
> > +       .k              = _SUNXI_CCU_MULT_MIN(4, 2, 2),
> > +       .m              = _SUNXI_CCU_DIV(0, 4),
> > +       .common         = {
> > +               .reg            = 0x040,
> > +               .hw.init        = CLK_HW_INIT("pll-mipi", "pll-video0",
> > +                                             &ccu_nkm_ops, 0),
> > +       },
> > +};
> > +
> > +static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_hsic_clk, "pll-hsic",
> > +                                       "osc24M", 0x044,
> > +                                       8, 7,           /* N */
> > +                                       0, 4,           /* M */
> > +                                       BIT(24),        /* frac enable */
> > +                                       BIT(25),        /* frac select */
> > +                                       270000000,      /* frac rate 0 */
> > +                                       297000000,      /* frac rate 1 */
> > +                                       BIT(31),        /* gate */
> > +                                       BIT(28),        /* lock */
> > +                                       0);
> > +
> > +static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_de_clk, "pll-de",
> > +                                       "osc24M", 0x048,
> > +                                       8, 7,           /* N */
> > +                                       0, 4,           /* M */
> > +                                       BIT(24),        /* frac enable */
> > +                                       BIT(25),        /* frac select */
> > +                                       270000000,      /* frac rate 0 */
> > +                                       297000000,      /* frac rate 1 */
> > +                                       BIT(31),        /* gate */
> > +                                       BIT(28),        /* lock */
> > +                                       0);
> > +
> > +static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_ddr1_clk, "pll-ddr1",
> > +                                  "osc24M", 0x04c,
> > +                                  8, 7,        /* N */
> > +                                  0, 2,        /* M */
> > +                                  BIT(31),     /* gate */
> > +                                  BIT(28),     /* lock */
> > +                                  0);
> 
> CLK_SET_RATE_UNGATE for all the PLLs?
> 
> > +
> > +static const char * const cpux_parents[] = { "osc32k", "osc24M",
> > +                                            "pll-cpux" , "pll-cpux" };
> > +static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
> > +                    0x050, 16, 2, CLK_IS_CRITICAL);
> 
> CLK_SET_RATE_PARENT.
> 
> [...]
> 
> > +static SUNXI_CCU_MP_WITH_MUX_GATE(ce_clk, "ce", mmc_default_parents, 0x09c,
> > +                                 0, 4,         /* M */
> > +                                 16, 2,        /* P */
> > +                                 24, 2,        /* mux */
> > +                                 BIT(31),      /* gate */
> > +                                 0);
> > +
> > +
> 
> Extra newline.
> 
> [...]
> 
> > +static const char * const dram_parents[] = { "pll-ddr0", "pll-ddr1" };
> > +static SUNXI_CCU_M_WITH_MUX(dram_clk, "dram", dram_parents,
> > +                           0x0f4, 0, 4, 20, 2, CLK_IS_CRITICAL);
> 
> The divider is only 2 bits wide.
> 
> > +static const char * const tcon1_parents[] = { "pll-video0", "pll-video1" };
> > +static const u8 tcon1_table[] = { 0, 2, };
> > +struct ccu_div tcon1_clk = {
> > +       .enable         = BIT(31),
> > +       .div            = _SUNXI_CCU_DIV(0, 4),
> > +       .mux            = _SUNXI_CCU_MUX_TABLE(24, 3, tcon1_table),
> 
> Mux is only 2 bits wide.
> 
> > +       .common         = {
> > +               .reg            = 0x11c,
> > +               .hw.init        = CLK_HW_INIT_PARENTS("tcon1",
> > +                                                     tcon1_parents,
> > +                                                     &ccu_div_ops,
> > +                                                     CLK_SET_RATE_PARENT),
> > +       },
> > +};
> > +
> 
> [...]
> 
> > +static const char * const dsi_dphy_parents[] = { "pll-video0", "pll-periph0" };
> > +static const u8 dsi_dphy_table[] = { 0, 2, };
> > +static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(dsi_dphy_clk, "dsi-dphy",
> > +                                      dsi_dphy_parents, dsi_dphy_table,
> > +                                      0x168, 0, 3, 24, 2, BIT(31), 0);
> 
> Divider is 4 bits wide, and mux offset is 8.

Good catches.

This is fixed, and I'll resend a new serie.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/db8362cc/attachment-0001.sig>
