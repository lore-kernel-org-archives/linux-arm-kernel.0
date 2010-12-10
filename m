From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 10 Dec 2010 16:03:51 +0800
Subject: [PATCH 5/6] arm: mx50: add core functions support
In-Reply-To: <20101209090259.GJ6017@pengutronix.de>
References: <1291903716-31388-1-git-send-email-richard.zhao@freescale.com>
	<1291903716-31388-5-git-send-email-richard.zhao@freescale.com>
	<20101209090259.GJ6017@pengutronix.de>
Message-ID: <20101210080351.GA29519@b20223-2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,
On Thu, Dec 09, 2010 at 10:02:59AM +0100, Sascha Hauer wrote:
> On Thu, Dec 09, 2010 at 10:08:35PM +0800, Richard Zhao wrote:
> > Add core definitions and memory map, clock, gpio, irq, iomux, uart device
> > support.
> >
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  arch/arm/mach-mx5/Kconfig                     |    8 +
> >  arch/arm/mach-mx5/Makefile                    |    2 +
> >  arch/arm/mach-mx5/Makefile.boot               |    3 +
> >  arch/arm/mach-mx5/clock-mx50.c                | 3262 +++++++++++++++++++++++++
> >  arch/arm/mach-mx5/crm_regs-mx50.h             |  607 +++++
> >  arch/arm/mach-mx5/devices-mx50.h              |   26 +
> >  arch/arm/mach-mx5/mm-mx50.c                   |   60 +
> >  arch/arm/plat-mxc/devices/platform-imx-uart.c |   13 +
> >  arch/arm/plat-mxc/gpio.c                      |   14 +
> >  arch/arm/plat-mxc/include/mach/common.h       |    4 +
> >  arch/arm/plat-mxc/include/mach/hardware.h     |    1 +
> >  arch/arm/plat-mxc/include/mach/iomux-mx50.h   |  595 +++++
> >  arch/arm/plat-mxc/include/mach/irqs.h         |    2 +
> >  arch/arm/plat-mxc/include/mach/memory.h       |    3 +
> >  arch/arm/plat-mxc/include/mach/mx50.h         |  306 +++
> >  arch/arm/plat-mxc/include/mach/mxc.h          |    2 +
> >  16 files changed, 4908 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-mx5/clock-mx50.c
> >  create mode 100644 arch/arm/mach-mx5/crm_regs-mx50.h
> >  create mode 100644 arch/arm/mach-mx5/devices-mx50.h
> >  create mode 100644 arch/arm/mach-mx5/mm-mx50.c
> >  create mode 100644 arch/arm/plat-mxc/include/mach/iomux-mx50.h
> >  create mode 100644 arch/arm/plat-mxc/include/mach/mx50.h
> >
> > diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> > index 5011f42..aae4014 100644
> > --- a/arch/arm/mach-mx5/Kconfig
> > +++ b/arch/arm/mach-mx5/Kconfig
> > @@ -12,6 +12,14 @@ config     SOC_IMX51
> >       select ARCH_HAS_CPUFREQ
> >       select ARCH_MX51
> >
> > +config SOC_IMX50
> > +     bool
> > +     select MXC_TZIC
> > +     select ARCH_MXC_IOMUX_V3
> > +     select ARCH_MXC_AUDMUX_V2
> > +     select ARCH_HAS_CPUFREQ
> > +
> > +
> >  comment "MX5 platforms:"
> >
> >  config MACH_MX51_BABBAGE
> > diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
> > index 026cd85..6f4f212 100644
> > --- a/arch/arm/mach-mx5/Makefile
> > +++ b/arch/arm/mach-mx5/Makefile
> > @@ -13,3 +13,5 @@ obj-$(CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD) += eukrea_mbimx51-baseboard.o
> >  obj-$(CONFIG_MACH_EUKREA_CPUIMX51SD) += board-cpuimx51sd.o
> >  obj-$(CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD) += eukrea_mbimxsd-baseboard.o
> >  obj-$(CONFIG_MACH_MX51_EFIKAMX) += board-mx51_efikamx.o
> > +
> > +obj-$(CONFIG_SOC_IMX50) += mm-mx50.o clock-mx50.o
> > diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
> > index 388d2e8..5f31bb7 100644
> > --- a/arch/arm/mach-mx5/Makefile.boot
> > +++ b/arch/arm/mach-mx5/Makefile.boot
> > @@ -1,3 +1,6 @@
> >     zreladdr-$(CONFIG_SOC_IMX51)      := 0x90008000
> >  params_phys-$(CONFIG_SOC_IMX51)      := 0x90000100
> >  initrd_phys-$(CONFIG_SOC_IMX51)      := 0x90800000
> > +   zreladdr-$(CONFIG_SOC_IMX50)      := 0x70008000
> > +params_phys-$(CONFIG_SOC_IMX50)      := 0x70000100
> > +initrd_phys-$(CONFIG_SOC_IMX50)      := 0x70800000
> > diff --git a/arch/arm/mach-mx5/clock-mx50.c b/arch/arm/mach-mx5/clock-mx50.c
> > new file mode 100644
> > index 0000000..1339085
> > --- /dev/null
> > +++ b/arch/arm/mach-mx5/clock-mx50.c
> > @@ -0,0 +1,3262 @@
> > +/*
> > + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > +
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > +
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, write to the Free Software Foundation, Inc.,
> > + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/types.h>
> > +#include <linux/time.h>
> > +#include <linux/hrtimer.h>
> > +#include <linux/mm.h>
> > +#include <linux/errno.h>
> > +#include <linux/delay.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <asm/clkdev.h>
> > +#include <asm/div64.h>
> > +#include <mach/hardware.h>
> > +#include <mach/common.h>
> > +#include <mach/clock.h>
> > +
> > +#include "crm_regs-mx50.h"
> > +
> > +/* External clock values passed-in by the board code */
> > +static unsigned long external_high_reference, external_low_reference;
> > +static unsigned long oscillator_reference, ckih2_reference;
> > +
> > +static struct clk pll1_main_clk;
> > +static struct clk pll1_sw_clk;
> > +static struct clk pll2_sw_clk;
> > +static struct clk pll3_sw_clk;
> > +static struct clk apbh_dma_clk;
> > +static struct clk apll_clk;
> > +static struct clk pfd0_clk;
> > +static struct clk pfd1_clk;
> > +static struct clk pfd2_clk;
> > +static struct clk pfd3_clk;
> > +static struct clk pfd4_clk;
> > +static struct clk pfd5_clk;
> > +static struct clk pfd6_clk;
> > +static struct clk pfd7_clk;
> > +static struct clk lp_apm_clk;
> > +static struct clk weim_clk[];
> > +static struct clk ddr_clk;
> > +static struct clk axi_a_clk;
> > +static struct clk axi_b_clk;
> > +static struct clk gpu2d_clk;
> > +
> > +static void __iomem *pll1_base;
> > +static void __iomem *pll2_base;
> > +static void __iomem *pll3_base;
> > +void __iomem *apll_base;
> 
> static?
yes
> 
> > +
> > +void __iomem *databahn;
> 
> static?
yes
> 
> > +
> > +#define DDR_SYNC_MODE                0x30000
> > +#define SPIN_DELAY   1000000 /* in nanoseconds */
> > +#define WAIT(exp, timeout) \
> > +({ \
> > +     struct timespec nstimeofday; \
> > +     struct timespec curtime; \
> > +     int result = 1; \
> > +     getnstimeofday(&nstimeofday); \
> > +     while (!(exp)) { \
> > +             getnstimeofday(&curtime); \
> > +             if ((curtime.tv_nsec - nstimeofday.tv_nsec) > (timeout)) { \
> > +                     result = 0; \
> > +                     break; \
> > +             } \
> > +     } \
> > +     result; \
> > +})
> > +
> > +#define MAX_AHB_CLK          133000000
> > +
> > +static struct clk esdhc3_clk[];
> > +
> > +static void __calc_pre_post_dividers(u32 div, u32 *pre, u32 *post)
> > +{
> > +     u32 min_pre, temp_pre, old_err, err;
> > +
> > +     if (div >= 512) {
> > +             *pre = 8;
> > +             *post = 64;
> > +     } else if (div >= 8) {
> > +             min_pre = (div - 1) / 64 + 1;
> > +             old_err = 8;
> > +             for (temp_pre = 8; temp_pre >= min_pre; temp_pre--) {
> > +                     err = div % temp_pre;
> > +                     if (err == 0) {
> > +                             *pre = temp_pre;
> > +                             break;
> > +                     }
> > +                     err = temp_pre - err;
> > +                     if (err < old_err) {
> > +                             old_err = err;
> > +                             *pre = temp_pre;
> > +                     }
> > +             }
> > +             *post = (div + *pre - 1) / *pre;
> > +     } else if (div < 8) {
> > +             *pre = div;
> > +             *post = 1;
> > +     }
> > +}
> 
> We already have this function. It should be made globally available and
> used here.
so I need to create a new clock.c?
> 
> > +
> > +static int _clk_enable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +     reg = __raw_readl(clk->enable_reg);
> > +     reg |= MXC_CCM_CCGRx_CG_MASK << clk->enable_shift;
> > +     __raw_writel(reg, clk->enable_reg);
> > +
> > +     return 0;
> > +}
> > +
> > +static int _clk_enable_inrun(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(clk->enable_reg);
> > +     reg &= ~(MXC_CCM_CCGRx_CG_MASK << clk->enable_shift);
> > +     reg |= 1 << clk->enable_shift;
> > +     __raw_writel(reg, clk->enable_reg);
> > +     return 0;
> > +}
> > +
> > +static void _clk_disable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +     reg = __raw_readl(clk->enable_reg);
> > +     reg &= ~(MXC_CCM_CCGRx_CG_MASK << clk->enable_shift);
> > +     __raw_writel(reg, clk->enable_reg);
> > +}
> > +
> > +static void _clk_disable_inwait(struct clk *clk)
> > +{
> > +     u32 reg;
> > +     reg = __raw_readl(clk->enable_reg);
> > +     reg &= ~(MXC_CCM_CCGRx_CG_MASK << clk->enable_shift);
> > +     reg |= 1 << clk->enable_shift;
> > +     __raw_writel(reg, clk->enable_reg);
> > +}
> > +
> > +static unsigned long _clk_round_rate_div(struct clk *clk,
> > +                                             unsigned long rate,
> > +                                             u32 max_div,
> > +                                             u32 *new_div)
> > +{
> 
> ditto.
> 
> BTW I don't know why you insist on these silly leading underscores in
> function names. Please please remove them.
"_" prefix says it's used internally, and avoid conflicts with global symbol.
Move to clock.c too?
> 
> > +     u32 div;
> > +     u32 parent_rate = clk_get_rate(clk->parent);
> > +
> > +     div = DIV_ROUND_UP(parent_rate, rate);
> > +     if (div > max_div)
> > +             div = max_div;
> > +     else if (div == 0)
> > +             div++;
> > +     if (new_div != NULL)
> > +             *new_div = div;
> > +
> > +     return parent_rate / div;
> > +}
> > +/*
> > + * For the 4-to-1 muxed input clock
> > + */
> > +static inline u32 _get_mux(struct clk *parent, struct clk *m0,
> > +                        struct clk *m1, struct clk *m2, struct clk *m3)
> > +{
> > +     if (parent == m0)
> > +             return 0;
> > +     else if (parent == m1)
> > +             return 1;
> > +     else if (parent == m2)
> > +             return 2;
> > +     else if (parent == m3)
> > +             return 3;
> > +     else
> > +             BUG();
> > +
> > +     return 0;
> > +}
> 
> Also in i.MX51-53 clock support
move to clock.c too
> 
> > +
> > +static unsigned long _clk_pll_get_rate(struct clk *clk)
> > +{
> > +     long mfi, mfn, mfd, pdf, ref_clk, mfn_abs;
> > +     unsigned long dp_op, dp_mfd, dp_mfn, dp_ctl, pll_hfsm, dbl;
> > +     void __iomem *pllbase;
> > +     s64 temp;
> > +
> > +     pllbase = _get_pll_base(clk);
> > +
> > +     dp_ctl = __raw_readl(pllbase + MXC_PLL_DP_CTL);
> > +     pll_hfsm = dp_ctl & MXC_PLL_DP_CTL_HFSM;
> > +     dbl = dp_ctl & MXC_PLL_DP_CTL_DPDCK0_2_EN;
> > +
> > +     if (pll_hfsm == 0) {
> > +             dp_op = __raw_readl(pllbase + MXC_PLL_DP_OP);
> > +             dp_mfd = __raw_readl(pllbase + MXC_PLL_DP_MFD);
> > +             dp_mfn = __raw_readl(pllbase + MXC_PLL_DP_MFN);
> > +     } else {
> > +             dp_op = __raw_readl(pllbase + MXC_PLL_DP_HFS_OP);
> > +             dp_mfd = __raw_readl(pllbase + MXC_PLL_DP_HFS_MFD);
> > +             dp_mfn = __raw_readl(pllbase + MXC_PLL_DP_HFS_MFN);
> > +     }
> > +     pdf = dp_op & MXC_PLL_DP_OP_PDF_MASK;
> > +     mfi = (dp_op & MXC_PLL_DP_OP_MFI_MASK) >> MXC_PLL_DP_OP_MFI_OFFSET;
> > +     mfi = (mfi <= 5) ? 5 : mfi;
> > +     mfd = dp_mfd & MXC_PLL_DP_MFD_MASK;
> > +     mfn = mfn_abs = dp_mfn & MXC_PLL_DP_MFN_MASK;
> > +     /* Sign extend to 32-bits */
> > +     if (mfn >= 0x04000000) {
> > +             mfn |= 0xFC000000;
> > +             mfn_abs = -mfn;
> > +     }
> > +
> > +     ref_clk = 2 * clk_get_rate(clk->parent);
> > +     if (dbl != 0)
> > +             ref_clk *= 2;
> > +
> > +     ref_clk /= (pdf + 1);
> > +     temp = (u64) ref_clk * mfn_abs;
> > +     do_div(temp, mfd + 1);
> > +     if (mfn < 0)
> > +             temp = -temp;
> > +     temp = (ref_clk * mfi) + temp;
> > +
> > +     return temp;
> > +}
> 
> I just realized we already have this functions in the tree two times.
> 
> I stop looking at the clock code at this point.
> 
> Please factor out the common code.
> 
> We are heading towards an unmaintainable mess with this clock code. I am
> tempted to say that I won't take any more clock code until we have a
> common struct clk and an idea how we can make the clock code more
> readable and maintainable across different
> almost-the-same-with-subtle-differences-i.MX-variants.
> 
> Honestly this clock code shows the complete failure of not the software
> but the hardware designers. Why must each and every i.MX SoC look
> different? Why is there no common register layout for one clock which is
> then repeated for the other clocks?
Well, the problem is the SoCs have already come out. I'll try to work out a common code.
The common code will be restrcited to mx5x temporaly?
> 
> > diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx50.h b/arch/arm/plat-mxc/include/mach/iomux-mx50.h
> > new file mode 100644
> > index 0000000..6aa76be
> > --- /dev/null
> > +++ b/arch/arm/plat-mxc/include/mach/iomux-mx50.h
> > @@ -0,0 +1,595 @@
> > +/*
> > + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > +
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > +
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, write to the Free Software Foundation, Inc.,
> > + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > + */
> > +
> > +#ifndef __MACH_IOMUX_MX50_H__
> > +#define __MACH_IOMUX_MX50_H__
> > +
> > +#include <mach/iomux-v3.h>
> > +
> > +/*
> > + * various IOMUX alternate output functions (1-7)
> > + */
> > +enum iomux_config {
> > +     IOMUX_CONFIG_ALT0,
> > +     IOMUX_CONFIG_ALT1,
> > +     IOMUX_CONFIG_ALT2,
> > +     IOMUX_CONFIG_ALT3,
> > +     IOMUX_CONFIG_ALT4,
> > +     IOMUX_CONFIG_ALT5,
> > +     IOMUX_CONFIG_ALT6,
> > +     IOMUX_CONFIG_ALT7,
> > +     IOMUX_CONFIG_GPIO,      /* added to help user use GPIO mode */
> > +     IOMUX_CONFIG_SION = 0x1 << 4,   /* LOOPBACK:MUX SION bit */
> > +};
> > +
> > +#define NON_MUX_I    0
> > +#define NON_PAD_I    NO_PAD_CTRL
> > +
> > +#define IOMUX_TO_IRQ_V3(pin)         (MXC_GPIO_IRQ_START + pin)
> > +
> > +#define MX50_ELCDIF_PAD_CTRL (PAD_CTL_PKE | \
> > +                                     PAD_CTL_DSE_HIGH)
> > +
> > +#define MX50_WVGA_PAD_CTRL   (PAD_CTL_PKE | PAD_CTL_DSE_HIGH)
> > +
> > +#define MX50_SD_PAD_CTRL             (PAD_CTL_DSE_HIGH | \
> > +                                     PAD_CTL_PUS_47K_UP | PAD_CTL_SRE_FAST)
> > +
> > +#define MX50_SD3_PAD_DAT     (PAD_CTL_HYS | PAD_CTL_PKE | PAD_CTL_PUE | \
> > +                                     PAD_CTL_PUS_47K_UP | PAD_CTL_DSE_HIGH)
> > +#define MX50_SD3_PAD_CMD     (PAD_CTL_HYS | PAD_CTL_PKE | PAD_CTL_PUE | \
> > +                                     PAD_CTL_PUS_100K_UP | PAD_CTL_DSE_HIGH)
> > +#define MX50_SD3_PAD_CLK     (PAD_CTL_PKE | PAD_CTL_PUE | \
> > +                                     PAD_CTL_PUS_47K_UP | PAD_CTL_DSE_HIGH)
> > +#define MX50_UART_PAD_CTRL   (PAD_CTL_DSE_HIGH | PAD_CTL_PKE)
> > +#define MX50_I2C_PAD_CTRL    (PAD_CTL_ODE | PAD_CTL_DSE_HIGH | \
> > +                                     PAD_CTL_PUS_100K_UP | PAD_CTL_HYS)
> > +#define MX50_USB_PAD_CTRL    (PAD_CTL_PKE | PAD_CTL_PUE | \
> > +                                     PAD_CTL_DSE_HIGH | PAD_CTL_PUS_47K_UP)
> > +
> > +#define MX50_FEC_PAD_CTRL    (PAD_CTL_HYS | PAD_CTL_PKE | PAD_CTL_PUE | \
> > +                                     PAD_CTL_PUS_22K_UP | PAD_CTL_ODE | \
> > +                                     PAD_CTL_DSE_HIGH)
> > +
> > +#define MX50_OWIRE_PAD_CTRL  (PAD_CTL_HYS | PAD_CTL_PKE | PAD_CTL_PUE | \
> > +                                     PAD_CTL_PUS_100K_UP | PAD_CTL_ODE | \
> > +                                     PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST)
> > +
> > +#define MX50_PAD_KEY_COL0__GPIO_4_0  IOMUX_PAD(0x2CC, 0x20, 1, 0x0, 0, NO_PAD_CTRL)
>                                                   ^^^^^
> 
> We sort the pins by this column. Also it would be really great if you
> could generate a complete list of the alternate functions from the excel
> sheets. I am getting really tired of all the iomux patches. I generated
> the list from the excel sheets for the i.MX35, and now compare the logs:
ok, I'll generate the full list, and sort by pad.
> 
> sha at octopus:~/octopus/linux/linux-2.6 git lg arch/arm/plat-mxc/include/mach/iomux-mx35.h
> 401d87d arm/imx: remove "NO_PAD_CTRL" from Copyright statements
> 66ddfc6 mx35: add a missing comma in a pad definition
> 218deaa MX35: Add iomux pin defintions
> sha at octopus:~/octopus/linux/linux-2.6 git lg arch/arm/plat-mxc/include/mach/iomux-mx25.h
> 6b63226 mx25: add PWM4 to iomux
> b04102b mx25: add iomux defines for UART4 on KPP pins
> 8402ed3 i.MX25: add AUDMUX and SSI support
> 49535a9 mx25: add platform code for imx-keypad
> 9b1489e Merge branch 'mxc-master' of git://git.pengutronix.de/git/imx/linux-2.6 into imx/master
> e76feb8 arm/imx/iomux-mx25: unify style and comment cleanup
> 401d87d arm/imx: remove "NO_PAD_CTRL" from Copyright statements
> 0f547dc mx25pdk: add LCD support
> dda71f1 mx25: s/NO_PAD_CTL/NO_PAD_CTRL/
> 8e5be21 i.MX25 iomux definitions (corrected version)
> sha at octopus:~/octopus/linux/linux-2.6 git lg arch/arm/plat-mxc/include/mach/iomux-mx51.h
> 0dea1c7 imx51: fix gpio_4_24 and gpio_4_25 pad configuration
> 82df68a imx51: add gpio mode for csi1 {h,v}sync
> 0a7d487 imx51: enhance iomux configuration for esdhc support
> db9d423 imx51: fix iomux configuration
> 47c5382 ARM: imx: Add gpio-keys to plat-mxc
> b545d9e iomux-mx51: fix GPIO_1_xx 's IOMUX configuration
> 217f580 iomux-mx51: fix SD1 and SD2's iomux configuration
> 4b5ee7a ARM: iomux-mx51: Add AUD5 pinmux definitions
> f781bc8 ARM: mx5/iomux-mx51: Fix input path of some pins in gpio mode
> 2e35bab ARM: mx5/iomux-mx51: Add aud3 primary function defines
> 8efd927 ARM: mx5/iomux-mx51: Add SPI controller pads
> eaa4fd0 ARM: mx5/iomux-mx51: add iomux definitions for eCSPI2 on the imx51_3ds board
> 3efee47 ARM: mx5/mx51_babbage: Add FEC support
> 6937aab iomux-mx51: add 4 pin definitions
> b3fb53a mx51/iomux: add UART and GPIO pad definitions for imx51_3ds board
> 310894b mx51/iomux: Fix mux mode and input path for two pads
> 68d03da [PATCH] mxc: Fix pad names for imx51
> 71c2e51 mx5: Add i2c to Freescale MX51 Babbage HW
> d6b273b mx5: bring usb phy out of reset on freescale mx51 babbage hw
> 282f152 mxc: Update GPIO for USB support on Freescale MX51 Babbage HW
> a329b48 mxc: Core support for Freescale i.MX5 series
> 
> 
> > diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
> > index e42e9e4..a085bf2 100644
> > --- a/arch/arm/plat-mxc/include/mach/irqs.h
> > +++ b/arch/arm/plat-mxc/include/mach/irqs.h
> > @@ -29,6 +29,8 @@
> >  #define MXC_GPIO_IRQS                (32 * 4)
> >  #elif defined CONFIG_ARCH_MX25
> >  #define MXC_GPIO_IRQS                (32 * 4)
> > +#elif defined CONFIG_SOC_IMX50
> > +#define MXC_GPIO_IRQS                (32 * 6)
> >  #elif defined CONFIG_SOC_IMX51
> >  #define MXC_GPIO_IRQS                (32 * 4)
> >  #elif defined CONFIG_ARCH_MXC91231
> 
> Above this block there is the following comment:
> 
> /* these are ordered by size to support multi-SoC kernels */
ok, I will move it to the first place. But I still think it's just a work around for multi-SoC.
> 
> 
> > diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
> > index 9a9a000..5022c32 100644
> > --- a/arch/arm/plat-mxc/include/mach/memory.h
> > +++ b/arch/arm/plat-mxc/include/mach/memory.h
> > @@ -16,6 +16,7 @@
> >  #define MX25_PHYS_OFFSET     UL(0x80000000)
> >  #define MX27_PHYS_OFFSET     UL(0xa0000000)
> >  #define MX3x_PHYS_OFFSET     UL(0x80000000)
> > +#define MX50_PHYS_OFFSET     UL(0x70000000)
> >  #define MX51_PHYS_OFFSET     UL(0x90000000)
> >  #define MX53_PHYS_OFFSET     UL(0x70000000)
> >  #define MXC91231_PHYS_OFFSET UL(0x90000000)
> > @@ -33,6 +34,8 @@
> >  #  define PHYS_OFFSET                MX3x_PHYS_OFFSET
> >  # elif defined CONFIG_ARCH_MXC91231
> >  #  define PHYS_OFFSET                MXC91231_PHYS_OFFSET
> > +# elif defined CONFIG_SOC_IMX50
> > +#  define PHYS_OFFSET                MX50_PHYS_OFFSET
> >  # elif defined CONFIG_ARCH_MX51
> >  #  define PHYS_OFFSET                MX51_PHYS_OFFSET
> >  # elif defined CONFIG_ARCH_MX53
> > diff --git a/arch/arm/plat-mxc/include/mach/mx50.h b/arch/arm/plat-mxc/include/mach/mx50.h
> > new file mode 100644
> > index 0000000..c754f70
> > --- /dev/null
> > +++ b/arch/arm/plat-mxc/include/mach/mx50.h
> > @@ -0,0 +1,306 @@
> > +#ifndef __MACH_MX50_H__
> > +#define __MACH_MX50_H__
> > +
> > +/*
> > + * IROM
> > + */
> > +#define MX50_IROM_BASE_ADDR          0x0
> > +#define MX50_IROM_SIZE                       SZ_64K
> > +
> > +/* TZIC */
> > +#define MX50_TZIC_BASE_ADDR          0x0FFFC000
> > +
> > +
> > +/*
> > + * IRAM
> > + */
> > +#define MX50_IRAM_BASE_ADDR  0xF8000000      /* internal ram */
> > +#define MX50_IRAM_PARTITIONS 16
> > +#define MX50_IRAM_SIZE               (MX50_IRAM_PARTITIONS * SZ_8K)  /* 128KB */
> > +
> > +/*
> > + * Databahn
> > + */
> > +#define MX50_DATABAHN_BASE_ADDR                      0x14000000
> > +#define DATABAHN_CTL_REG19                   0x4c
> > +#define DATABAHN_CTL_REG20                   0x50
> > +#define DATABAHN_CTL_REG21                   0x54
> > +#define DATABAHN_CTL_REG22                   0x58
> > +#define DATABAHN_CTL_REG23                   0x5c
> > +#define DATABAHN_CTL_REG42                   0xa8
> > +#define DATABAHN_CTL_REG43                   0xac
> > +#define DATABAHN_CTL_REG55                   0xdc
> > +#define DATABAHN_CTL_REG63                   0xFC
> > +#define LOWPOWER_CONTROL_MASK                        0x1F
> > +#define LOWPOWER_AUTOENABLE_MASK             0x1F
> > +#define LOWPOWER_EXTERNAL_CNT_MASK           (0xFFFF << 16)
> > +#define LOWPOWER_EXTERNAL_CNT_OFFSET         16
> > +#define LOWPOWER_INTERNAL_CNT_MASK           (0xFFFF << 8)
> > +#define LOWPOWER_INTERNAL_CNT_OFFSET         8
> > +#define LOWPOWER_REFRESH_ENABLE_MASK         (3 << 16)
> > +#define LOWPOWER_REFRESH_ENABLE_OFFSET               16
> > +#define LOWPOWER_REFRESH_HOLD_MASK           0xFFFF
> > +#define LOWPOWER_REFRESH_HOLD_OFFSET         0
> 
> What have we learned about properly prefixing defines?
my fault.
> 
> Also, where are these used besides the clock code? Do we really need
> these to be globally available?
In freescale code, it's used in:
mach-mx5/cpu.c
       |/pm.c
       |/clock_mx50.c
plat-mxc/zq_calib.c

> 
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
Thanks
Richard
