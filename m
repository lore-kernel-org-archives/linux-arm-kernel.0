From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 10 Dec 2010 15:08:35 +0800
Subject: [PATCH 5/6] arm: mx50: add core functions support
In-Reply-To: <20101209082535.GK17441@pengutronix.de>
References: <1291903716-31388-1-git-send-email-richard.zhao@freescale.com>
	<1291903716-31388-5-git-send-email-richard.zhao@freescale.com>
	<20101209082535.GK17441@pengutronix.de>
Message-ID: <20101210070835.GB29383@b20223-2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 09, 2010 at 09:25:35AM +0100, Uwe Kleine-K?nig wrote:
Hi Uwe,

Thanks, see below comments.
> Hello Richard,
> 
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
> only a single empty line please
Yes. 
> 
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
> Please put that over the machine lines
Yes.
> 
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
> Do you need params_phys and initrd_phys?
If you insist on removing them, I can remove.
> 
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
> > +
> > +void __iomem *databahn;
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
> this is broken.  Consider getnstimeofday(&nstimeofday) returns with
> nstimeofday = { .ts_sec = 42, .ts_nsec = 999999999, }.  If timeout is >0
> the break is never taken.  And furthermore I'm sure that getnstimeofday
> isn't the right function for that job.
So, what do I suppose to use? udelay is not accurate here.
> 
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
> You seem to have copied an old version of this function.  The similarity
> to arch/arm/mach-mx5/clock-mx51.c makes me wonder if you shouldn't copy
> the Copyright lines from there, too.
It's freescale code. clock-mx51.c is originally freescale code too.
> 
> > +}
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
> These functions are refactored in arch/arm/mach-mx5/clock-mx51.c in the
> meantime, too.
Do you mean _clk_ccgr_xxx? Do I need to abstract common file clock.c, or 
just repeat the function?
> 
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
> > +
> > +/*
> > + * For the 4-to-1 muxed input clock
> 8-to-1 ?
Yes.
> 
> > + */
> > +static inline u32 _get_mux8(struct clk *parent, struct clk *m0, struct clk *m1,
> > +                         struct clk *m2, struct clk *m3, struct clk *m4,
> > +                         struct clk *m5, struct clk *m6, struct clk *m7)
> > +{
> > +     if (parent == m0)
> > +             return 0;
> > +     else if (parent == m1)
> > +             return 1;
> > +     else if (parent == m2)
> > +             return 2;
> > +     else if (parent == m3)
> > +             return 3;
> > +     else if (parent == m4)
> > +             return 4;
> > +     else if (parent == m5)
> > +             return 5;
> > +     else if (parent == m6)
> > +             return 6;
> > +     else if (parent == m7)
> > +             return 7;
> > +     else
> > +             BUG();
> > +
> > +     return 0;
> > +}
> > +
> > +static inline void __iomem *_get_pll_base(struct clk *pll)
> > +{
> > +     if (pll == &pll1_main_clk)
> > +             return pll1_base;
> > +     else if (pll == &pll2_sw_clk)
> > +             return pll2_base;
> > +     else if (pll == &pll3_sw_clk)
> > +             return pll3_base;
> > +     else
> > +             BUG();
> > +
> > +     return NULL;
> > +}
> > +
> > +static unsigned long get_high_reference_clock_rate(struct clk *clk)
> > +{
> > +     return external_high_reference;
> > +}
> > +
> > +static unsigned long get_low_reference_clock_rate(struct clk *clk)
> > +{
> > +     return external_low_reference;
> > +}
> > +
> > +static unsigned long get_oscillator_reference_clock_rate(struct clk *clk)
> > +{
> > +     return oscillator_reference;
> > +}
> > +
> > +static unsigned long get_ckih2_reference_clock_rate(struct clk *clk)
> > +{
> > +     return ckih2_reference;
> > +}
> > +
> > +/* External high frequency clock */
> > +static struct clk ckih_clk = {
> > +     .get_rate = get_high_reference_clock_rate,
> > +};
> > +
> > +static struct clk ckih2_clk = {
> > +     .get_rate = get_ckih2_reference_clock_rate,
> > +};
> > +
> > +static struct clk osc_clk = {
> > +     .get_rate = get_oscillator_reference_clock_rate,
> > +};
> > +
> > +/* External low frequency (32kHz) clock */
> > +static struct clk ckil_clk = {
> > +     .get_rate = get_low_reference_clock_rate,
> > +};
> > +
> > +static int apll_enable(struct clk *clk)
> > +{
> > +     __raw_writel(1, apll_base + MXC_ANADIG_MISC_SET);
> > +     return 0;
> > +}
> > +
> > +static void apll_disable(struct clk *clk)
> > +{
> > +     __raw_writel(1, apll_base + MXC_ANADIG_MISC_CLR);
> > +}
> > +
> > +static unsigned long apll_get_rate(struct clk *clk)
> > +{
> > +     return 480000000;
> > +}
> > +
> > +static struct clk apll_clk = {
> > +     .get_rate = apll_get_rate,
> > +     .enable = apll_enable,
> > +     .disable = apll_disable,
> > +};
> > +
> > +static unsigned long pfd_round_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 frac;
> > +     u64 tmp;
> > +     tmp = (u64)clk_get_rate(clk->parent) * 18;
> This can overflow e.g. when parent = apll
480M * 18 = 0x202FBF000, u64 can not overflow.
> 
> > +     do_div(tmp, rate);
> > +     frac = tmp;
> > +     frac = frac < 18 ? 18 : frac;
> > +     frac = frac > 35 ? 35 : frac;
> I remember having seen something like:
> 
> #define CLAMP(x, low, high) ((x) < (low) ? (low) : ((x) > (high) ? (high) : (x)))
> 
> Maybe this is something for <linux/kernel.h>, probably with better
> typing.
Yes, thanks. it's  clamp(val, min, max).
> 
> > +     do_div(tmp, frac);
> > +     return tmp;
> > +}
> > +
> > +static int pfd_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 frac;
> > +     u64 tmp;
> > +     tmp = (u64)clk_get_rate(clk->parent) * 18;
> > +
> > +     if (apbh_dma_clk.usecount == 0)
> > +             apbh_dma_clk.enable(&apbh_dma_clk);
> Why not just use clk_enable(apbh_dma)?
Yes, thanks.
> 
> > +     do_div(tmp, rate);
> > +     frac = tmp;
> > +     frac = frac < 18 ? 18 : frac;
> > +     frac = frac > 35 ? 35 : frac;
> > +     /* clear clk frac bits */
> > +     __raw_writel(MXC_ANADIG_PFD_FRAC_MASK << clk->enable_shift,
> > +                     apll_base + (int)clk->enable_reg + 8);
> What is 8?
Its read/set/clear reg are three different reg. The ip is from mxs series.
I can add a MXC_SET_OFFSET and MXC_CLEAR_OFFSET macro in crm-regs-mx50.h, if you need it.
> > +     /* set clk frac bits */
> > +     __raw_writel(frac << clk->enable_shift,
> > +                     apll_base + (int)clk->enable_reg + 4);
> What is 4?
same as above.
> 
> > +
> > +     tmp = (u64)clk_get_rate(clk->parent) * 18;
> overflow?
why?
> 
> > +     do_div(tmp, frac);
> > +
> > +     if (apbh_dma_clk.usecount == 0)
> > +             apbh_dma_clk.disable(&apbh_dma_clk);
> ... then you can balance here with an clk_disable that just does the
> right thing.
correct
> 
> > +     return 0;
> > +}
> > +
> > +static int pfd_enable(struct clk *clk)
> > +{
> > +     int index;
> > +
> > +     if (apbh_dma_clk.usecount == 0)
> > +             apbh_dma_clk.enable(&apbh_dma_clk);
> ditto
correct
> 
> > +     index = _get_mux8(clk, &pfd0_clk, &pfd1_clk, &pfd2_clk, &pfd3_clk,
> > +                     &pfd4_clk, &pfd5_clk, &pfd6_clk, &pfd7_clk);
> > +     __raw_writel(1 << (index + MXC_ANADIG_PFD_DIS_OFFSET),
> > +                     apll_base + MXC_ANADIG_PLLCTRL_CLR);
> > +     /* clear clk gate bit */
> Having an empty line before comments improves readability.
ok
> 
> > +     __raw_writel((1 << (clk->enable_shift + 7)),
> > +                     apll_base + (int)clk->enable_reg + 8);
> > +
> > +     /* check lock bit */
> > +     if (!WAIT(__raw_readl(apll_base + MXC_ANADIG_PLLCTRL)
> > +               & MXC_ANADIG_APLL_LOCK, 50000)) {
> > +             __raw_writel(MXC_ANADIG_APLL_FORCE_LOCK,
> > +                          apll_base + MXC_ANADIG_PLLCTRL_CLR);
> > +             __raw_writel(MXC_ANADIG_APLL_FORCE_LOCK,
> > +                          apll_base + MXC_ANADIG_PLLCTRL_SET);
> > +             if (!WAIT(__raw_readl(apll_base + MXC_ANADIG_PLLCTRL)
> > +                       & MXC_ANADIG_APLL_LOCK, SPIN_DELAY))
> > +                     panic("pfd_enable failed!\n");
> > +     }
> > +     if (apbh_dma_clk.usecount == 0)
> > +             apbh_dma_clk.disable(&apbh_dma_clk);
> > +     return 0;
> > +}
> > +
> > +static void pfd_disable(struct clk *clk)
> > +{
> > +     int index;
> > +
> > +     if (apbh_dma_clk.usecount == 0)
> > +             apbh_dma_clk.enable(&apbh_dma_clk);
> > +     index = _get_mux8(clk, &pfd0_clk, &pfd1_clk, &pfd2_clk, &pfd3_clk,
> > +                     &pfd4_clk, &pfd5_clk, &pfd6_clk, &pfd7_clk);
> > +     /* set clk gate bit */
> > +     __raw_writel((1 << (clk->enable_shift + 7)),
> > +                     apll_base + (int)clk->enable_reg + 4);
> > +     __raw_writel(1 << (index + MXC_ANADIG_PFD_DIS_OFFSET),
> > +                     apll_base + MXC_ANADIG_PLLCTRL_SET);
> > +     if (apbh_dma_clk.usecount == 0)
> > +             apbh_dma_clk.disable(&apbh_dma_clk);
> > +}
> > +
> > +static struct clk pfd0_clk = {
> > +     .parent = &apll_clk,
> > +     .enable_reg = (void *)MXC_ANADIG_FRAC0,
> > +     .enable_shift = MXC_ANADIG_PFD0_FRAC_OFFSET,
> > +     .set_rate = pfd_set_rate,
> > +     .round_rate = pfd_round_rate,
> > +     .enable = pfd_enable,
> > +     .disable = pfd_disable,
> > +};
> > +
> > +static struct clk pfd1_clk = {
> > +     .parent = &apll_clk,
> > +     .enable_reg = (void *)MXC_ANADIG_FRAC0,
> > +     .enable_shift = MXC_ANADIG_PFD1_FRAC_OFFSET,
> > +     .set_rate = pfd_set_rate,
> > +     .round_rate = pfd_round_rate,
> > +     .enable = pfd_enable,
> > +     .disable = pfd_disable,
> > +};
> > +
> > +static struct clk pfd2_clk = {
> > +     .parent = &apll_clk,
> > +     .enable_reg = (void *)MXC_ANADIG_FRAC0,
> > +     .enable_shift = MXC_ANADIG_PFD2_FRAC_OFFSET,
> > +     .set_rate = pfd_set_rate,
> > +     .round_rate = pfd_round_rate,
> > +     .enable = pfd_enable,
> > +     .disable = pfd_disable,
> > +};
> > +
> > +static struct clk pfd3_clk = {
> > +     .parent = &apll_clk,
> > +     .enable_reg = (void *)MXC_ANADIG_FRAC0,
> > +     .enable_shift = MXC_ANADIG_PFD3_FRAC_OFFSET,
> > +     .set_rate = pfd_set_rate,
> > +     .round_rate = pfd_round_rate,
> > +     .enable = pfd_enable,
> > +     .disable = pfd_disable,
> > +};
> > +
> > +static struct clk pfd4_clk = {
> > +     .parent = &apll_clk,
> > +     .enable_reg = (void *)MXC_ANADIG_FRAC1,
> > +     .enable_shift = MXC_ANADIG_PFD4_FRAC_OFFSET,
> > +     .set_rate = pfd_set_rate,
> > +     .round_rate = pfd_round_rate,
> > +     .enable = pfd_enable,
> > +     .disable = pfd_disable,
> > +};
> > +
> > +static struct clk pfd5_clk = {
> > +     .parent = &apll_clk,
> > +     .enable_reg = (void *)MXC_ANADIG_FRAC1,
> > +     .enable_shift = MXC_ANADIG_PFD5_FRAC_OFFSET,
> > +     .set_rate = pfd_set_rate,
> > +     .round_rate = pfd_round_rate,
> > +     .enable = pfd_enable,
> > +     .disable = pfd_disable,
> > +};
> > +
> > +static struct clk pfd6_clk = {
> > +     .parent = &apll_clk,
> > +     .enable_reg = (void *)MXC_ANADIG_FRAC1,
> > +     .enable_shift = MXC_ANADIG_PFD6_FRAC_OFFSET,
> > +     .set_rate = pfd_set_rate,
> > +     .round_rate = pfd_round_rate,
> > +     .enable = pfd_enable,
> > +     .disable = pfd_disable,
> > +};
> > +
> > +static struct clk pfd7_clk = {
> > +     .parent = &apll_clk,
> > +     .enable_reg = (void *)MXC_ANADIG_FRAC1,
> > +     .enable_shift = MXC_ANADIG_PFD7_FRAC_OFFSET,
> > +     .set_rate = pfd_set_rate,
> > +     .round_rate = pfd_round_rate,
> > +     .enable = pfd_enable,
> > +     .disable = pfd_disable,
> > +};
> Maybe define a macro to simplify these 8 definitions?
ok
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
> > +
> > +static int _clk_pll_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 reg, reg1;
> > +     void __iomem *pllbase;
> > +
> > +     long mfi, pdf, mfn, mfd = 999999;
> > +     s64 temp64;
> > +     unsigned long quad_parent_rate;
> > +     unsigned long pll_hfsm, dp_ctl;
> > +
> > +     pllbase = _get_pll_base(clk);
> > +
> > +     quad_parent_rate = 4 * clk_get_rate(clk->parent);
> > +     pdf = mfi = -1;
> > +     while (++pdf < 16 && mfi < 5)
> > +             mfi = rate * (pdf+1) / quad_parent_rate;
> > +     if (mfi > 15)
> > +             return -1;
> > +     pdf--;
> > +
> > +     temp64 = rate*(pdf+1) - quad_parent_rate*mfi;
> > +     do_div(temp64, quad_parent_rate/1000000);
> > +     mfn = (long)temp64;
> > +
> > +     dp_ctl = __raw_readl(pllbase + MXC_PLL_DP_CTL);
> > +     /* use dpdck0_2 */
> > +     __raw_writel(dp_ctl | 0x1000L, pllbase + MXC_PLL_DP_CTL);
> > +     pll_hfsm = dp_ctl & MXC_PLL_DP_CTL_HFSM;
> > +     if (pll_hfsm == 0) {
> > +             reg = mfi<<4 | pdf;
> > +             __raw_writel(reg, pllbase + MXC_PLL_DP_OP);
> > +             __raw_writel(mfd, pllbase + MXC_PLL_DP_MFD);
> > +             __raw_writel(mfn, pllbase + MXC_PLL_DP_MFN);
> > +     } else {
> > +             reg = mfi<<4 | pdf;
> > +             __raw_writel(reg, pllbase + MXC_PLL_DP_HFS_OP);
> > +             __raw_writel(mfd, pllbase + MXC_PLL_DP_HFS_MFD);
> > +             __raw_writel(mfn, pllbase + MXC_PLL_DP_HFS_MFN);
> > +     }
> > +     /* If auto restart is disabled, restart the PLL and
> > +       * wait for it to lock.
> > +       */
> > +     reg = __raw_readl(pllbase + MXC_PLL_DP_CTL);
> > +     if (reg & MXC_PLL_DP_CTL_UPEN) {
> > +             reg = __raw_readl(pllbase + MXC_PLL_DP_CONFIG);
> > +             if (!(reg & MXC_PLL_DP_CONFIG_AREN)) {
> > +                     reg1 = __raw_readl(pllbase + MXC_PLL_DP_CTL);
> > +                     reg1 |= MXC_PLL_DP_CTL_RST;
> > +                     __raw_writel(reg1, pllbase + MXC_PLL_DP_CTL);
> > +             }
> > +             /* Wait for lock */
> > +             if (!WAIT(__raw_readl(pllbase + MXC_PLL_DP_CTL)
> > +                       & MXC_PLL_DP_CTL_LRF, SPIN_DELAY))
> > +                     panic("pll_set_rate: pll relock failed\n");
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int _clk_pll_enable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +     void __iomem *pllbase;
> > +
> > +     pllbase = _get_pll_base(clk);
> > +     reg = __raw_readl(pllbase + MXC_PLL_DP_CTL);
> > +
> > +     if (reg & MXC_PLL_DP_CTL_UPEN)
> > +             return 0;
> > +
> > +     reg |=  MXC_PLL_DP_CTL_UPEN;
> > +     __raw_writel(reg, pllbase + MXC_PLL_DP_CTL);
> > +
> > +     /* Wait for lock */
> > +     if (!WAIT(__raw_readl(pllbase + MXC_PLL_DP_CTL) & MXC_PLL_DP_CTL_LRF,
> > +                             SPIN_DELAY))
> > +             panic("pll relock failed\n");
> > +     return 0;
> > +}
> > +
> > +static void _clk_pll_disable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +     void __iomem *pllbase;
> > +
> > +     pllbase = _get_pll_base(clk);
> > +     reg = __raw_readl(pllbase + MXC_PLL_DP_CTL) & ~MXC_PLL_DP_CTL_UPEN;
> > +     __raw_writel(reg, pllbase + MXC_PLL_DP_CTL);
> > +}
> > +
> > +static struct clk pll1_main_clk = {
> > +     .parent = &osc_clk,
> > +     .get_rate = _clk_pll_get_rate,
> > +     .enable = _clk_pll_enable,
> > +     .disable = _clk_pll_disable,
> > +};
> > +
> > +static int _clk_pll1_sw_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     reg = __raw_readl(MXC_CCM_CCSR);
> > +
> > +     if (parent == &pll1_main_clk) {
> > +             reg &= ~MXC_CCM_CCSR_PLL1_SW_CLK_SEL;
> > +             __raw_writel(reg, MXC_CCM_CCSR);
> > +             /* Set the step_clk parent to be lp_apm, to save power. */
> > +             mux = _get_mux(&lp_apm_clk, &lp_apm_clk, NULL, &pll2_sw_clk,
> > +                            &pll3_sw_clk);
> > +             reg = __raw_readl(MXC_CCM_CCSR);
> > +             reg = (reg & ~MXC_CCM_CCSR_STEP_SEL_MASK) |
> > +                 (mux << MXC_CCM_CCSR_STEP_SEL_OFFSET);
> > +     } else {
> > +             if (parent == &lp_apm_clk) {
> > +                     mux = _get_mux(parent, &lp_apm_clk, NULL, &pll2_sw_clk,
> > +                                    &pll3_sw_clk);
> > +                     reg = (reg & ~MXC_CCM_CCSR_STEP_SEL_MASK) |
> > +                         (mux << MXC_CCM_CCSR_STEP_SEL_OFFSET);
> > +                     __raw_writel(reg, MXC_CCM_CCSR);
> > +                     reg = __raw_readl(MXC_CCM_CCSR);
> > +                     reg |= MXC_CCM_CCSR_PLL1_SW_CLK_SEL;
> > +             } else {
> > +                     mux = _get_mux(parent, &lp_apm_clk, NULL, &pll2_sw_clk,
> > +                                    &pll3_sw_clk);
> > +                     reg = (reg & ~MXC_CCM_CCSR_STEP_SEL_MASK) |
> > +                         (mux << MXC_CCM_CCSR_STEP_SEL_OFFSET);
> > +                     __raw_writel(reg, MXC_CCM_CCSR);
> > +                     reg = __raw_readl(MXC_CCM_CCSR);
> > +                     reg |= MXC_CCM_CCSR_PLL1_SW_CLK_SEL;
> > +
> > +             }
> > +     }
> > +     __raw_writel(reg, MXC_CCM_CCSR);
> > +
> > +     return 0;
> > +}
> > +
> > +static unsigned long _clk_pll1_sw_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, div;
> > +     div = 1;
> > +     reg = __raw_readl(MXC_CCM_CCSR);
> > +
> > +     if (clk->parent == &pll2_sw_clk) {
> > +             div = ((reg & MXC_CCM_CCSR_PLL2_PODF_MASK) >>
> > +                    MXC_CCM_CCSR_PLL2_PODF_OFFSET) + 1;
> > +     } else if (clk->parent == &pll3_sw_clk) {
> > +             div = ((reg & MXC_CCM_CCSR_PLL3_PODF_MASK) >>
> > +                    MXC_CCM_CCSR_PLL3_PODF_OFFSET) + 1;
> > +     }
> > +     return clk_get_rate(clk->parent) / div;
> > +}
> > +
> > +/* pll1 switch clock */
> > +static struct clk pll1_sw_clk = {
> > +     .parent = &pll1_main_clk,
> > +     .set_parent = _clk_pll1_sw_set_parent,
> > +     .get_rate = _clk_pll1_sw_get_rate,
> > +};
> > +
> > +static int _clk_pll2_sw_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_CCSR);
> > +
> > +     if (parent == &pll2_sw_clk) {
> > +             reg &= ~MXC_CCM_CCSR_PLL2_SW_CLK_SEL;
> > +     } else {
> > +             reg = (reg & ~MXC_CCM_CCSR_PLL2_SW_CLK_SEL);
> > +             reg |= MXC_CCM_CCSR_PLL2_SW_CLK_SEL;
> > +     }
> > +     __raw_writel(reg, MXC_CCM_CCSR);
> > +     return 0;
> > +}
> > +
> > +/* same as pll2_main_clk. These two clocks should always be the same */
> > +static struct clk pll2_sw_clk = {
> > +     .parent = &osc_clk,
> > +     .get_rate = _clk_pll_get_rate,
> > +     .enable = _clk_pll_enable,
> > +     .disable = _clk_pll_disable,
> > +     .set_rate = _clk_pll_set_rate,
> > +     .set_parent = _clk_pll2_sw_set_parent,
> > +};
> > +
> > +/* same as pll3_main_clk. These two clocks should always be the same */
> > +static struct clk pll3_sw_clk = {
> > +     .parent = &osc_clk,
> > +     .set_rate = _clk_pll_set_rate,
> > +     .get_rate = _clk_pll_get_rate,
> > +     .enable = _clk_pll_enable,
> > +     .disable = _clk_pll_disable,
> > +};
> > +
> > +static int _clk_lp_apm_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg;
> > +
> > +     if (parent == &osc_clk)
> > +             reg = __raw_readl(MXC_CCM_CCSR) & ~MXC_CCM_CCSR_LP_APM_SEL;
> > +     else if (parent == &apll_clk)
> > +             reg = __raw_readl(MXC_CCM_CCSR) | MXC_CCM_CCSR_LP_APM_SEL;
> > +     else
> > +             return -EINVAL;
> > +
> > +     __raw_writel(reg, MXC_CCM_CCSR);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct clk lp_apm_clk = {
> > +     .parent = &osc_clk,
> > +     .set_parent = _clk_lp_apm_set_parent,
> > +};
> > +
> > +static unsigned long _clk_arm_get_rate(struct clk *clk)
> > +{
> > +     u32 cacrr, div;
> > +
> > +     cacrr = __raw_readl(MXC_CCM_CACRR);
> > +     div = (cacrr & MXC_CCM_CACRR_ARM_PODF_MASK) + 1;
> > +     return clk_get_rate(clk->parent) / div;
> > +}
> > +
> > +static unsigned long _clk_cpu_round_rate(struct clk *clk,
> > +                                             unsigned long rate)
> > +{
> > +     u32 cpu_podf;
> > +     unsigned long parent_rate;
> > +
> > +     parent_rate = clk_get_rate(clk->parent);
> > +     cpu_podf = parent_rate / rate;
> > +     cpu_podf = cpu_podf > 8 ? 8 : cpu_podf;
> > +     cpu_podf = cpu_podf < 1 ? 1 : cpu_podf;
> > +
> > +     return parent_rate / cpu_podf;
> > +}
> > +
> > +static int _clk_cpu_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 reg, cpu_podf;
> > +     unsigned long parent_rate;
> > +
> > +     rate = _clk_cpu_round_rate(clk, rate);
> > +     parent_rate = clk_get_rate(clk->parent);
> > +     cpu_podf = parent_rate / rate - 1;
> > +
> > +     reg = __raw_readl(MXC_CCM_CACRR);
> > +     reg &= ~MXC_CCM_CACRR_ARM_PODF_MASK;
> > +     reg |= cpu_podf << MXC_CCM_CACRR_ARM_PODF_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CACRR);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct clk cpu_clk = {
> > +     .parent = &pll1_sw_clk,
> > +     .get_rate = _clk_arm_get_rate,
> > +     .set_rate = _clk_cpu_set_rate,
> > +     .round_rate = _clk_cpu_round_rate,
> > +};
> > +
> > +static int _clk_main_bus_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk, &pll3_sw_clk,
> > +                     &lp_apm_clk);
> > +     reg = __raw_readl(MXC_CCM_CBCDR) & ~MXC_CCM_CBCDR_PERIPH_CLK_SEL_MASK;
> > +     reg |= (mux << MXC_CCM_CBCDR_PERIPH_CLK_SEL_OFFSET);
> > +     __raw_writel(reg, MXC_CCM_CBCDR);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct clk main_bus_clk = {
> > +     .parent = &pll2_sw_clk,
> > +     .set_parent = _clk_main_bus_set_parent,
> > +};
> > +
> > +static unsigned long _clk_axi_a_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, div;
> > +
> > +     reg = __raw_readl(MXC_CCM_CBCDR);
> > +     div = ((reg & MXC_CCM_CBCDR_AXI_A_PODF_MASK) >>
> > +            MXC_CCM_CBCDR_AXI_A_PODF_OFFSET) + 1;
> > +     return clk_get_rate(clk->parent) / div;
> > +}
> > +
> > +static int _clk_axi_a_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 reg, div;
> > +     u32 parent_rate = clk_get_rate(clk->parent);
> > +
> > +     div = parent_rate / rate;
> > +     if (div == 0)
> > +             div++;
> > +     if (((parent_rate / div) != rate) || (div > 8))
> > +             return -EINVAL;
> > +
> > +     reg = __raw_readl(MXC_CCM_CBCDR);
> > +     reg &= ~MXC_CCM_CBCDR_AXI_A_PODF_MASK;
> > +     reg |= (div - 1) << MXC_CCM_CBCDR_AXI_A_PODF_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CBCDR);
> > +
> > +     if (!WAIT(!(__raw_readl(MXC_CCM_CDHIPR)
> > +          & MXC_CCM_CDHIPR_AXI_A_PODF_BUSY), SPIN_DELAY))
> > +             panic("pll _clk_axi_a_set_rate failed\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static unsigned long _clk_axi_a_round_rate(struct clk *clk,
> > +                                             unsigned long rate)
> > +{
> > +     u32 div;
> > +     u32 parent_rate = clk_get_rate(clk->parent);
> > +
> > +     div = parent_rate / rate;
> > +
> > +     /* Make sure rate is not greater than the maximum value for the clock.
> > +      * Also prevent a div of 0.
> > +      */
> > +
> > +     if (div > 8)
> > +             div = 8;
> > +     else if (div == 0)
> > +             div++;
> > +
> > +     return parent_rate / div;
> > +}
> > +
> > +
> > +static struct clk axi_a_clk = {
> > +     .parent = &main_bus_clk,
> > +     .get_rate = _clk_axi_a_get_rate,
> > +     .set_rate = _clk_axi_a_set_rate,
> > +     .round_rate = _clk_axi_a_round_rate,
> > +};
> > +
> > +static unsigned long _clk_axi_b_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, div;
> > +
> > +     reg = __raw_readl(MXC_CCM_CBCDR);
> > +     div = ((reg & MXC_CCM_CBCDR_AXI_B_PODF_MASK) >>
> > +            MXC_CCM_CBCDR_AXI_B_PODF_OFFSET) + 1;
> > +     return clk_get_rate(clk->parent) / div;
> > +}
> > +
> > +static int _clk_axi_b_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 reg, div;
> > +     u32 parent_rate = clk_get_rate(clk->parent);
> > +
> > +     div = parent_rate / rate;
> > +     if (div == 0)
> > +             div++;
> > +     if (((parent_rate / div) != rate) || (div > 8))
> > +             return -EINVAL;
> > +
> > +     reg = __raw_readl(MXC_CCM_CBCDR);
> > +     reg &= ~MXC_CCM_CBCDR_AXI_B_PODF_MASK;
> > +     reg |= (div - 1) << MXC_CCM_CBCDR_AXI_B_PODF_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CBCDR);
> > +
> > +     if (!WAIT(!(__raw_readl(MXC_CCM_CDHIPR)
> > +          & MXC_CCM_CDHIPR_AXI_B_PODF_BUSY), SPIN_DELAY))
> > +             panic("_clk_axi_b_set_rate failed\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static unsigned long _clk_axi_b_round_rate(struct clk *clk,
> > +                                             unsigned long rate)
> > +{
> > +     u32 div;
> > +     u32 parent_rate = clk_get_rate(clk->parent);
> > +
> > +     div = parent_rate / rate;
> > +
> > +     /* Make sure rate is not greater than the maximum value for the clock.
> > +      * Also prevent a div of 0.
> > +      */
> > +
> > +     if (div > 8)
> > +             div = 8;
> > +     else if (div == 0)
> > +             div++;
> > +
> > +     return parent_rate / div;
> > +}
> > +
> > +
> > +static struct clk axi_b_clk = {
> > +     .parent = &main_bus_clk,
> > +     .get_rate = _clk_axi_b_get_rate,
> > +     .set_rate = _clk_axi_b_set_rate,
> > +     .round_rate = _clk_axi_b_round_rate,
> > +};
> > +
> > +static unsigned long _clk_ahb_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, div;
> > +
> > +     reg = __raw_readl(MXC_CCM_CBCDR);
> > +     div = ((reg & MXC_CCM_CBCDR_AHB_PODF_MASK) >>
> > +            MXC_CCM_CBCDR_AHB_PODF_OFFSET) + 1;
> > +     return clk_get_rate(clk->parent) / div;
> > +}
> > +
> > +
> > +static int _clk_ahb_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 reg, div;
> > +     u32 parent_rate = clk_get_rate(clk->parent);
> > +
> > +     div = parent_rate / rate;
> > +     if (div == 0)
> > +             div++;
> > +     if (((parent_rate / div) != rate) || (div > 8))
> > +             return -EINVAL;
> > +
> > +     reg = __raw_readl(MXC_CCM_CBCDR);
> > +     reg &= ~MXC_CCM_CBCDR_AHB_PODF_MASK;
> > +     reg |= (div - 1) << MXC_CCM_CBCDR_AHB_PODF_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CBCDR);
> > +
> > +     if (!WAIT(!(__raw_readl(MXC_CCM_CDHIPR) & MXC_CCM_CDHIPR_AHB_PODF_BUSY),
> > +                             SPIN_DELAY))
> > +                     panic("_clk_ahb_set_rate failed\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static unsigned long _clk_ahb_round_rate(struct clk *clk,
> > +                                             unsigned long rate)
> > +{
> > +     u32 div;
> > +     u32 parent_rate = clk_get_rate(clk->parent);
> > +
> > +     div = parent_rate / rate;
> > +
> > +     /* Make sure rate is not greater than the maximum value for the clock.
> > +      * Also prevent a div of 0.
> > +      */
> > +     if (div == 0)
> > +             div++;
> > +     if (parent_rate / div > MAX_AHB_CLK)
> > +             div++;
> > +
> > +     if (div > 8)
> > +             div = 8;
> > +
> > +     return parent_rate / div;
> This can return something > MAX_AHB_CLK, is this intended?
No, it's a bug. Thanks.
> 
> > +}
> > +
> > +
> > +static struct clk ahb_clk = {
> > +     .parent = &main_bus_clk,
> > +     .get_rate = _clk_ahb_get_rate,
> > +     .set_rate = _clk_ahb_set_rate,
> > +     .round_rate = _clk_ahb_round_rate,
> > +};
> > +
> > +static int _clk_max_enable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     _clk_enable(clk);
> > +
> > +     /* Handshake with MAX when LPM is entered. */
> > +     reg = __raw_readl(MXC_CCM_CLPCR);
> > +     reg &= ~MXC_CCM_CLPCR_BYPASS_MAX_LPM_HS;
> > +     __raw_writel(reg, MXC_CCM_CLPCR);
> > +
> > +     return 0;
> > +}
> > +
> > +
> > +static void _clk_max_disable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     _clk_disable_inwait(clk);
> > +
> > +     /* No Handshake with MAX when LPM is entered as its disabled. */
> s/H/h/
ok
> 
> > +     reg = __raw_readl(MXC_CCM_CLPCR);
> > +     reg |= MXC_CCM_CLPCR_BYPASS_MAX_LPM_HS;
> > +     __raw_writel(reg, MXC_CCM_CLPCR);
> > +}
> When enabling you do
> 
>         enable clk
>         enable handshake
> 
> ; when disabling you do
> 
>         disable clk
>         disable handshake
> 
> .  This is not symmetric.  Intended?
Yes, disable handshake is ahead of disable clk is better.
> 
> > +static struct clk ahb_max_clk = {
> > +     .parent = &ahb_clk,
> > +     .enable_reg = MXC_CCM_CCGR0,
> > +     .enable_shift = MXC_CCM_CCGRx_CG14_OFFSET,
> > +     .enable = _clk_max_enable,
> > +     .disable = _clk_max_disable,
> > +};
> > +
> > +static struct clk ahbmux1_clk = {
> > +     .id = 0,
> > +     .parent = &ahb_clk,
> > +     .secondary = &ahb_max_clk,
> > +     .enable = _clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR0,
> > +     .enable_shift = MXC_CCM_CCGRx_CG8_OFFSET,
> > +     .disable = _clk_disable_inwait,
> > +};
> > +
> > +static unsigned long _clk_ipg_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, div;
> > +
> > +     reg = __raw_readl(MXC_CCM_CBCDR);
> > +     div = ((reg & MXC_CCM_CBCDR_IPG_PODF_MASK) >>
> > +            MXC_CCM_CBCDR_IPG_PODF_OFFSET) + 1;
> > +     return clk_get_rate(clk->parent) / div;
> > +}
> > +
> > +static struct clk ipg_clk = {
> > +     .parent = &ahb_clk,
> > +     .get_rate = _clk_ipg_get_rate,
> > +};
> > +
> > +static unsigned long _clk_ipg_per_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, prediv1, prediv2, podf;
> > +
> > +     if (clk->parent == &main_bus_clk || clk->parent == &lp_apm_clk) {
> > +             /* the main_bus_clk is the one before the DVFS engine */
> > +             reg = __raw_readl(MXC_CCM_CBCDR);
> > +             prediv1 = ((reg & MXC_CCM_CBCDR_PERCLK_PRED1_MASK) >>
> > +                        MXC_CCM_CBCDR_PERCLK_PRED1_OFFSET) + 1;
> > +             prediv2 = ((reg & MXC_CCM_CBCDR_PERCLK_PRED2_MASK) >>
> > +                        MXC_CCM_CBCDR_PERCLK_PRED2_OFFSET) + 1;
> > +             podf = ((reg & MXC_CCM_CBCDR_PERCLK_PODF_MASK) >>
> > +                     MXC_CCM_CBCDR_PERCLK_PODF_OFFSET) + 1;
> > +             return clk_get_rate(clk->parent) / (prediv1 * prediv2 * podf);
> > +     } else if (clk->parent == &ipg_clk) {
> > +             return clk_get_rate(&ipg_clk);
> > +     }
> > +     BUG();
> > +     return 0;
> > +}
> > +
> > +static int _clk_ipg_per_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     reg = __raw_readl(MXC_CCM_CBCMR);
> > +     mux = _get_mux(parent, &main_bus_clk, &lp_apm_clk, &ipg_clk, NULL);
> > +     if (mux == 2) {
> > +             reg |= MXC_CCM_CBCMR_PERCLK_IPG_CLK_SEL;
> > +     } else {
> > +             reg &= ~MXC_CCM_CBCMR_PERCLK_IPG_CLK_SEL;
> > +             if (mux == 0)
> > +                     reg &= ~MXC_CCM_CBCMR_PERCLK_LP_APM_CLK_SEL;
> > +             else
> > +                     reg |= MXC_CCM_CBCMR_PERCLK_LP_APM_CLK_SEL;
> > +     }
> > +     __raw_writel(reg, MXC_CCM_CBCMR);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct clk ipg_perclk = {
> > +     .parent = &lp_apm_clk,
> > +     .get_rate = _clk_ipg_per_get_rate,
> > +     .set_parent = _clk_ipg_per_set_parent,
> > +};
> > +
> > +static struct clk ipmux1_clk = {
> > +     .enable_reg = MXC_CCM_CCGR5,
> > +     .enable_shift = MXC_CCM_CCGRx_CG6_OFFSET,
> > +     .enable = _clk_enable,
> > +     .disable = _clk_disable,
> > +};
> > +
> > +static struct clk ipmux2_clk = {
> > +     .enable_reg = MXC_CCM_CCGR6,
> > +     .enable_shift = MXC_CCM_CCGRx_CG0_OFFSET,
> > +     .enable = _clk_enable,
> > +     .disable = _clk_disable,
> > +};
> > +
> > +static int _clk_sys_clk_enable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_CLK_SYS);
> > +     reg &= ~(MXC_CCM_CLK_SYS_SYS_XTAL_CLKGATE_MASK |
> > +                             MXC_CCM_CLK_SYS_SYS_PLL_CLKGATE_MASK);
> > +     if (__raw_readl(MXC_CCM_CLKSEQ_BYPASS) & 0x1)
> > +             reg |= MXC_CCM_CLK_SYS_SYS_PLL_CLKGATE_MASK;
> > +     else
> > +             reg |= MXC_CCM_CLK_SYS_SYS_XTAL_CLKGATE_MASK;
> > +     __raw_writel(reg, MXC_CCM_CLK_SYS);
> > +     return 0;
> > +}
> > +
> > +static void _clk_sys_clk_disable(struct clk *clk)
> > +{
> > +     u32 reg, reg1;
> > +
> > +     reg1 = (__raw_readl(databahn + DATABAHN_CTL_REG55))
> > +                                     & DDR_SYNC_MODE;
> > +     reg = __raw_readl(MXC_CCM_CLK_SYS);
> > +     reg &= ~(MXC_CCM_CLK_SYS_SYS_XTAL_CLKGATE_MASK |
> > +                             MXC_CCM_CLK_SYS_SYS_PLL_CLKGATE_MASK);
> > +     if (__raw_readl(MXC_CCM_CLKSEQ_BYPASS) & 0x1)
> > +             reg |= 1 << MXC_CCM_CLK_SYS_SYS_PLL_CLKGATE_OFFSET;
> > +     else {
> > +             /* If DDR is sourced from SYS_CLK (in Sync mode), we cannot
> > +              * gate its clock when ARM is in wait if the DDR is not in
> > +              * self refresh.
> > +              */
> > +             if (reg1 == DDR_SYNC_MODE)
> > +                     reg |= 3 << MXC_CCM_CLK_SYS_SYS_XTAL_CLKGATE_OFFSET;
> > +             else
> > +                     reg |= 1 << MXC_CCM_CLK_SYS_SYS_XTAL_CLKGATE_OFFSET;
> > +     }
> > +     __raw_writel(reg, MXC_CCM_CLK_SYS);
> > +}
> > +
> > +static struct clk sys_clk = {
> > +     .enable = _clk_sys_clk_enable,
> > +     .disable = _clk_sys_clk_disable,
> > +};
> > +
> > +
> > +static int _clk_weim_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_CBCDR);
> > +     if (parent == &ahb_clk)
> > +             reg |= MXC_CCM_CBCDR_WEIM_CLK_SEL;
> > +     else if (parent == &main_bus_clk)
> > +             reg &= ~MXC_CCM_CBCDR_WEIM_CLK_SEL;
> > +     else
> > +             BUG();
> > +     __raw_writel(reg, MXC_CCM_CBCDR);
> > +
> > +     return 0;
> > +}
> > +
> > +static int _clk_weim_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 reg, div;
> > +     u32 parent_rate = clk_get_rate(clk->parent);
> > +
> > +     div = parent_rate / rate;
> > +     if (div == 0)
> > +             div++;
> > +     if (((parent_rate / div) != rate) || (div > 8))
> > +             return -EINVAL;
> > +     reg = __raw_readl(MXC_CCM_CBCDR);
> > +     reg &= ~MXC_CCM_CBCDR_WEIM_PODF_MASK;
> > +     reg |= (div - 1) << MXC_CCM_CBCDR_WEIM_PODF_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CBCDR);
> > +     if (!WAIT(!(__raw_readl(MXC_CCM_CDHIPR) & MXC_CCM_CDHIPR_WEIM_PODF_BUSY)
> > +             , SPIN_DELAY))
> > +             panic("_clk_emi_slow_set_rate failed\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static unsigned long _clk_weim_round_rate(struct clk *clk,
> > +                                           unsigned long rate)
> > +{
> > +     u32 div;
> > +     u32 parent_rate = clk_get_rate(clk->parent);
> > +
> > +     div = parent_rate / rate;
> > +     if (div > 8)
> > +             div = 8;
> > +     else if (div == 0)
> > +             div++;
> > +     return parent_rate / div;
> > +}
> > +
> > +static struct clk weim_clk[] = {
> > +     {
> > +     .parent = &main_bus_clk,
> > +     .set_parent = _clk_weim_set_parent,
> > +     .set_rate = _clk_weim_set_rate,
> > +     .round_rate = _clk_weim_round_rate,
> > +     .enable = _clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR5,
> > +     .enable_shift = MXC_CCM_CCGRx_CG8_OFFSET,
> > +     .disable = _clk_disable_inwait,
> > +     .secondary = &weim_clk[1],
> > +     },
> > +     {
> > +     .parent = &ipg_clk,
> > +     .secondary = &sys_clk,
> > +     .enable = _clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR5,
> > +     .enable_shift = MXC_CCM_CCGRx_CG9_OFFSET,
> > +     .disable = _clk_disable_inwait,
> > +     }
> > +};
> > +
> > +static int _clk_ocram_enable(struct clk *clk)
> > +{
> > +     return 0;
> > +}
> > +
> > +static void _clk_ocram_disable(struct clk *clk)
> > +{
> > +}
> > +
> > +static struct clk ocram_clk = {
> > +     .parent = &sys_clk,
> > +     .enable_reg = MXC_CCM_CCGR6,
> > +     .enable_shift = MXC_CCM_CCGRx_CG1_OFFSET,
> > +     .enable = _clk_ocram_enable,
> > +     .disable = _clk_ocram_disable,
> 
> This looks fishy.  .enable_reg and .enable_shift is unused because
> _clk_ocram_enable and _clk_ocram_disable are empty.
I'll add implementation.
> 
> > +};
> > +
> > +static struct clk aips_tz1_clk = {
> > +     .parent = &ahb_clk,
> > +     .secondary = &ahb_max_clk,
> > +     .enable_reg = MXC_CCM_CCGR0,
> > +     .enable_shift = MXC_CCM_CCGRx_CG12_OFFSET,
> > +     .enable = _clk_enable,
> > +     .disable = _clk_disable_inwait,
> > +};
> > +
> > +static struct clk aips_tz2_clk = {
> > +     .parent = &ahb_clk,
> > +     .secondary = &ahb_max_clk,
> > +     .enable_reg = MXC_CCM_CCGR0,
> > +     .enable_shift = MXC_CCM_CCGRx_CG13_OFFSET,
> > +     .enable = _clk_enable,
> > +     .disable = _clk_disable_inwait,
> > +};
> > +
> > +static struct clk gpc_dvfs_clk = {
> > +     .enable_reg = MXC_CCM_CCGR5,
> > +     .enable_shift = MXC_CCM_CCGRx_CG12_OFFSET,
> > +     .enable = _clk_enable,
> > +     .disable = _clk_disable,
> > +};
> > +
> > +static int _clk_sdma_enable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     _clk_enable(clk);
> > +
> > +     /* Handshake with SDMA when LPM is entered. */
> > +     reg = __raw_readl(MXC_CCM_CLPCR);
> > +     reg &= ~MXC_CCM_CLPCR_BYPASS_SDMA_LPM_HS;
> > +     __raw_writel(reg, MXC_CCM_CLPCR);
> > +
> > +     return 0;
> > +}
> > +
> > +static void _clk_sdma_disable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     _clk_disable(clk);
> > +     /* No handshake with SDMA as its not enabled. */
> > +     reg = __raw_readl(MXC_CCM_CLPCR);
> > +     reg |= MXC_CCM_CLPCR_BYPASS_SDMA_LPM_HS;
> > +     __raw_writel(reg, MXC_CCM_CLPCR);
> ditto
ok
> 
> > +}
> > +
> > +
> > +static struct clk sdma_clk[] = {
> > +     {
> > +      .parent = &ahb_clk,
> > +      .enable_reg = MXC_CCM_CCGR4,
> > +      .enable_shift = MXC_CCM_CCGRx_CG15_OFFSET,
> > +      .enable = _clk_sdma_enable,
> > +      .disable = _clk_sdma_disable,
> > +      },
> > +     {
> > +      .parent = &ipg_clk,
> > +      .secondary = &ddr_clk,
> > +      },
> > +};
> > +
> > +static struct clk spba_clk = {
> > +     .parent = &ipg_clk,
> > +     .enable_reg = MXC_CCM_CCGR5,
> > +     .enable_shift = MXC_CCM_CCGRx_CG0_OFFSET,
> > +     .enable = _clk_enable,
> > +     .disable = _clk_disable,
> > +};
> > +
> > +static unsigned long _clk_uart_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, prediv, podf;
> > +
> > +     reg = __raw_readl(MXC_CCM_CSCDR1);
> > +     prediv = ((reg & MXC_CCM_CSCDR1_UART_CLK_PRED_MASK) >>
> > +               MXC_CCM_CSCDR1_UART_CLK_PRED_OFFSET) + 1;
> > +     podf = ((reg & MXC_CCM_CSCDR1_UART_CLK_PODF_MASK) >>
> > +             MXC_CCM_CSCDR1_UART_CLK_PODF_OFFSET) + 1;
> > +
> > +     return clk_get_rate(clk->parent)/(prediv * podf) ;
> > +}
> > +
> > +static int _clk_uart_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk, &pll3_sw_clk,
> > +                    &lp_apm_clk);
> > +     reg = __raw_readl(MXC_CCM_CSCMR1) & ~MXC_CCM_CSCMR1_UART_CLK_SEL_MASK;
> > +     reg |= mux << MXC_CCM_CSCMR1_UART_CLK_SEL_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CSCMR1);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct clk uart_main_clk = {
> > +     .parent = &pll2_sw_clk,
> > +     .get_rate = _clk_uart_get_rate,
> > +     .set_parent = _clk_uart_set_parent,
> > +};
> > +
> > +static struct clk uart1_clk[] = {
> > +     {
> > +      .id = 0,
> > +      .parent = &uart_main_clk,
> > +      .secondary = &uart1_clk[1],
> > +      .enable_reg = MXC_CCM_CCGR1,
> > +      .enable_shift = MXC_CCM_CCGRx_CG4_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 0,
> > +      .parent = &ipg_clk,
> > +      .enable_reg = MXC_CCM_CCGR1,
> > +      .enable_shift = MXC_CCM_CCGRx_CG3_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +};
> > +
> > +static struct clk uart2_clk[] = {
> > +     {
> > +      .id = 1,
> > +      .parent = &uart_main_clk,
> > +      .secondary = &uart2_clk[1],
> > +      .enable_reg = MXC_CCM_CCGR1,
> > +      .enable_shift = MXC_CCM_CCGRx_CG6_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 1,
> > +      .parent = &ipg_clk,
> > +      .enable_reg = MXC_CCM_CCGR1,
> > +      .enable_shift = MXC_CCM_CCGRx_CG5_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +};
> > +
> > +static struct clk uart3_clk[] = {
> > +     {
> > +      .id = 2,
> > +      .parent = &uart_main_clk,
> > +      .secondary = &uart3_clk[1],
> > +      .enable_reg = MXC_CCM_CCGR1,
> > +      .enable_shift = MXC_CCM_CCGRx_CG8_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 2,
> > +      .parent = &ipg_clk,
> > +      .secondary = &spba_clk,
> > +      .enable_reg = MXC_CCM_CCGR1,
> > +      .enable_shift = MXC_CCM_CCGRx_CG7_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +};
> > +
> > +static struct clk uart4_clk[] = {
> > +     {
> > +      .id = 3,
> > +      .parent = &uart_main_clk,
> > +      .secondary = &uart4_clk[1],
> > +      .enable_reg = MXC_CCM_CCGR7,
> > +      .enable_shift = MXC_CCM_CCGRx_CG5_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 3,
> > +      .parent = &ipg_clk,
> > +      .secondary = &spba_clk,
> > +      .enable_reg = MXC_CCM_CCGR7,
> > +      .enable_shift = MXC_CCM_CCGRx_CG4_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +};
> > +
> > +static struct clk uart5_clk[] = {
> > +     {
> > +      .id = 4,
> > +      .parent = &uart_main_clk,
> > +      .secondary = &uart5_clk[1],
> > +      .enable_reg = MXC_CCM_CCGR7,
> > +      .enable_shift = MXC_CCM_CCGRx_CG7_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 4,
> > +      .parent = &ipg_clk,
> > +      .secondary = &spba_clk,
> > +      .enable_reg = MXC_CCM_CCGR7,
> > +      .enable_shift = MXC_CCM_CCGRx_CG6_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +};
> macro to define the uart clocks
ok
> 
> > +
> > +static struct clk gpt_clk[] = {
> > +     {
> > +      .parent = &ipg_perclk,
> > +      .id = 0,
> > +      .secondary = &gpt_clk[1],
> > +      .enable_reg = MXC_CCM_CCGR2,
> > +      .enable_shift = MXC_CCM_CCGRx_CG10_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 0,
> > +      .parent = &ipg_clk,
> > +      .enable_reg = MXC_CCM_CCGR2,
> > +      .enable_shift = MXC_CCM_CCGRx_CG9_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 0,
> > +      .parent = &ckil_clk,
> > +      },
> > +};
> > +
> > +static struct clk pwm1_clk[] = {
> > +     {
> > +      .parent = &ipg_perclk,
> > +      .id = 0,
> > +      .enable_reg = MXC_CCM_CCGR2,
> > +      .enable_shift = MXC_CCM_CCGRx_CG6_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      .secondary = &pwm1_clk[1],
> > +      },
> > +     {
> > +      .id = 0,
> > +      .parent = &ipg_clk,
> > +      .enable_reg = MXC_CCM_CCGR2,
> > +      .enable_shift = MXC_CCM_CCGRx_CG5_OFFSET,
> > +      .enable = _clk_enable_inrun, /*Active only when ARM is running. */
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 0,
> > +      .parent = &ckil_clk,
> > +      },
> > +};
> > +
> > +static struct clk pwm2_clk[] = {
> > +     {
> > +      .parent = &ipg_perclk,
> > +      .id = 1,
> > +      .enable_reg = MXC_CCM_CCGR2,
> > +      .enable_shift = MXC_CCM_CCGRx_CG8_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      .secondary = &pwm2_clk[1],
> > +      },
> > +     {
> > +      .id = 1,
> > +      .parent = &ipg_clk,
> > +      .enable_reg = MXC_CCM_CCGR2,
> > +      .enable_shift = MXC_CCM_CCGRx_CG7_OFFSET,
> > +      .enable = _clk_enable_inrun, /*Active only when ARM is running. */
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 1,
> > +      .parent = &ckil_clk,
> > +      },
> > +};
> macro?
ok
> 
> > +
> > +static struct clk i2c_clk[] = {
> > +     {
> > +      .id = 0,
> > +      .parent = &ipg_perclk,
> > +      .enable_reg = MXC_CCM_CCGR1,
> > +      .enable_shift = MXC_CCM_CCGRx_CG9_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 1,
> > +      .parent = &ipg_perclk,
> > +      .enable_reg = MXC_CCM_CCGR1,
> > +      .enable_shift = MXC_CCM_CCGRx_CG10_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 2,
> > +      .parent = &ipg_perclk,
> > +      .enable_reg = MXC_CCM_CCGR1,
> > +      .enable_shift = MXC_CCM_CCGRx_CG11_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +};
> > +
> > +static unsigned long _clk_cspi_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, prediv, podf;
> > +
> > +     reg = __raw_readl(MXC_CCM_CSCDR2);
> > +     prediv = ((reg & MXC_CCM_CSCDR2_CSPI_CLK_PRED_MASK) >>
> > +               MXC_CCM_CSCDR2_CSPI_CLK_PRED_OFFSET) + 1;
> > +     if (prediv == 1)
> > +             BUG();
> > +     podf = ((reg & MXC_CCM_CSCDR2_CSPI_CLK_PODF_MASK) >>
> > +             MXC_CCM_CSCDR2_CSPI_CLK_PODF_OFFSET) + 1;
> > +
> > +     return clk_get_rate(clk->parent) / (prediv * podf);
> > +}
> > +
> > +static int _clk_cspi_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk, &pll3_sw_clk,
> > +                    &lp_apm_clk);
> > +     reg = __raw_readl(MXC_CCM_CSCMR1) & ~MXC_CCM_CSCMR1_CSPI_CLK_SEL_MASK;
> > +     reg |= mux << MXC_CCM_CSCMR1_CSPI_CLK_SEL_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CSCMR1);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct clk cspi_main_clk = {
> > +     .parent = &pll3_sw_clk,
> > +     .get_rate = _clk_cspi_get_rate,
> > +     .set_parent = _clk_cspi_set_parent,
> > +};
> > +
> > +static struct clk cspi1_clk[] = {
> > +     {
> > +      .id = 0,
> > +      .parent = &cspi_main_clk,
> > +      .secondary = &cspi1_clk[1],
> > +      .enable_reg = MXC_CCM_CCGR4,
> > +      .enable_shift = MXC_CCM_CCGRx_CG10_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 0,
> > +      .parent = &ipg_clk,
> > +      .secondary = &spba_clk,
> > +      .enable_reg = MXC_CCM_CCGR4,
> > +      .enable_shift = MXC_CCM_CCGRx_CG9_OFFSET,
> > +      .enable = _clk_enable_inrun, /*Active only when ARM is running. */
> > +      .disable = _clk_disable,
> > +      },
> > +};
> > +
> > +static struct clk cspi2_clk[] = {
> > +     {
> > +      .id = 1,
> > +      .parent = &cspi_main_clk,
> > +      .secondary = &cspi2_clk[1],
> > +      .enable_reg = MXC_CCM_CCGR4,
> > +      .enable_shift = MXC_CCM_CCGRx_CG12_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 1,
> > +      .parent = &ipg_clk,
> > +      .secondary = &aips_tz2_clk,
> > +      .enable_reg = MXC_CCM_CCGR4,
> > +      .enable_shift = MXC_CCM_CCGRx_CG11_OFFSET,
> > +      .enable = _clk_enable_inrun, /*Active only when ARM is running. */
> > +      .disable = _clk_disable,
> > +      },
> > +};
> > +
> > +static struct clk cspi3_clk = {
> > +     .id = 2,
> > +     .parent = &ipg_clk,
> > +     .enable_reg = MXC_CCM_CCGR4,
> > +     .enable_shift = MXC_CCM_CCGRx_CG13_OFFSET,
> > +     .enable = _clk_enable,
> > +     .disable = _clk_disable,
> > +     .secondary = &aips_tz2_clk,
> > +};
> > +
> > +static int _clk_ssi_lp_apm_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_CSCMR1) & ~MXC_CCM_CSCMR1_SSI_APM_CLK_SEL;
> > +     if (parent == &lp_apm_clk)
> > +             reg |= MXC_CCM_CSCMR1_SSI_APM_CLK_SEL;
> > +     __raw_writel(reg, MXC_CCM_CSCMR1);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct clk ssi_lp_apm_clk = {
> > +     .parent = &ckih_clk,
> > +     .set_parent = _clk_ssi_lp_apm_set_parent,
> > +};
> > +
> > +static unsigned long _clk_ssi1_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, prediv, podf;
> > +
> > +     reg = __raw_readl(MXC_CCM_CS1CDR);
> > +     prediv = ((reg & MXC_CCM_CS1CDR_SSI1_CLK_PRED_MASK) >>
> > +               MXC_CCM_CS1CDR_SSI1_CLK_PRED_OFFSET) + 1;
> > +     if (prediv == 1)
> > +             BUG();
> > +     podf = ((reg & MXC_CCM_CS1CDR_SSI1_CLK_PODF_MASK) >>
> > +             MXC_CCM_CS1CDR_SSI1_CLK_PODF_OFFSET) + 1;
> > +
> > +     return clk_get_rate(clk->parent) / (prediv * podf);
> > +}
> > +static int _clk_ssi1_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk,
> > +                    &pll3_sw_clk, &ssi_lp_apm_clk);
> > +     reg = __raw_readl(MXC_CCM_CSCMR1) & ~MXC_CCM_CSCMR1_SSI1_CLK_SEL_MASK;
> > +     reg |= mux << MXC_CCM_CSCMR1_SSI1_CLK_SEL_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CSCMR1);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct clk ssi1_clk[] = {
> > +     {
> > +      .id = 0,
> > +      .parent = &pll3_sw_clk,
> > +      .set_parent = _clk_ssi1_set_parent,
> > +      .secondary = &ssi1_clk[1],
> > +      .get_rate = _clk_ssi1_get_rate,
> > +      .enable_reg = MXC_CCM_CCGR3,
> > +      .enable_shift = MXC_CCM_CCGRx_CG9_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 0,
> > +      .parent = &ipg_clk,
> > +      .secondary = &ssi1_clk[2],
> > +      .enable_reg = MXC_CCM_CCGR3,
> > +      .enable_shift = MXC_CCM_CCGRx_CG8_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 0,
> > +      .parent = &aips_tz2_clk,
> > +      },
> > +};
> > +
> > +static unsigned long _clk_ssi2_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, prediv, podf;
> > +
> > +     reg = __raw_readl(MXC_CCM_CS2CDR);
> > +     prediv = ((reg & MXC_CCM_CS2CDR_SSI2_CLK_PRED_MASK) >>
> > +               MXC_CCM_CS2CDR_SSI2_CLK_PRED_OFFSET) + 1;
> > +     if (prediv == 1)
> > +             BUG();
> > +     podf = ((reg & MXC_CCM_CS2CDR_SSI2_CLK_PODF_MASK) >>
> > +             MXC_CCM_CS2CDR_SSI2_CLK_PODF_OFFSET) + 1;
> > +
> > +     return clk_get_rate(clk->parent) / (prediv * podf);
> > +}
> > +
> > +static int _clk_ssi2_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk,
> > +                    &pll3_sw_clk, &ssi_lp_apm_clk);
> > +     reg = __raw_readl(MXC_CCM_CSCMR1) & ~MXC_CCM_CSCMR1_SSI2_CLK_SEL_MASK;
> > +     reg |= mux << MXC_CCM_CSCMR1_SSI2_CLK_SEL_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CSCMR1);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct clk ssi2_clk[] = {
> > +     {
> > +      .id = 1,
> > +      .parent = &pll3_sw_clk,
> > +      .set_parent = _clk_ssi2_set_parent,
> > +      .secondary = &ssi2_clk[1],
> > +      .get_rate = _clk_ssi2_get_rate,
> > +      .enable_reg = MXC_CCM_CCGR3,
> > +      .enable_shift = MXC_CCM_CCGRx_CG11_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 1,
> > +      .parent = &ipg_clk,
> > +      .secondary = &ssi2_clk[2],
> > +      .enable_reg = MXC_CCM_CCGR3,
> > +      .enable_shift = MXC_CCM_CCGRx_CG10_OFFSET,
> > +      .enable = _clk_enable,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 1,
> > +      .parent = &spba_clk,
> > +      },
> > +};
> > +
> > +static unsigned long _clk_ssi_ext1_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, prediv, podf;
> > +     u32 div = 1;
> > +
> > +     reg = __raw_readl(MXC_CCM_CSCMR1);
> > +     if ((reg & MXC_CCM_CSCMR1_SSI_EXT1_COM_CLK_SEL) == 0) {
> > +             reg = __raw_readl(MXC_CCM_CS1CDR);
> > +             prediv = ((reg & MXC_CCM_CS1CDR_SSI_EXT1_CLK_PRED_MASK) >>
> > +                       MXC_CCM_CS1CDR_SSI_EXT1_CLK_PRED_OFFSET) + 1;
> > +             if (prediv == 1)
> > +                     BUG();
> > +             podf = ((reg & MXC_CCM_CS1CDR_SSI_EXT1_CLK_PODF_MASK) >>
> > +                     MXC_CCM_CS1CDR_SSI_EXT1_CLK_PODF_OFFSET) + 1;
> > +             div = prediv * podf;
> > +     }
> > +     return clk_get_rate(clk->parent) / div;
> > +}
> > +
> > +static int _clk_ssi_ext1_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 reg, div, pre, post;
> > +     u32 parent_rate = clk_get_rate(clk->parent);
> > +
> > +     div = parent_rate / rate;
> > +     if (div == 0)
> > +             div++;
> > +     if (((parent_rate / div) != rate) || div > 512)
> > +             return -EINVAL;
> > +
> > +     __calc_pre_post_dividers(div, &pre, &post);
> > +
> > +     reg = __raw_readl(MXC_CCM_CS1CDR);
> > +     reg &= ~(MXC_CCM_CS1CDR_SSI_EXT1_CLK_PRED_MASK |
> > +              MXC_CCM_CS1CDR_SSI_EXT1_CLK_PODF_MASK);
> > +     reg |= (post - 1) << MXC_CCM_CS1CDR_SSI_EXT1_CLK_PODF_OFFSET;
> > +     reg |= (pre - 1) << MXC_CCM_CS1CDR_SSI_EXT1_CLK_PRED_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CS1CDR);
> > +
> > +     return 0;
> > +}
> > +
> > +static int _clk_ssi_ext1_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     reg = __raw_readl(MXC_CCM_CSCMR1);
> > +     if (parent == &ssi1_clk[0]) {
> > +             reg |= MXC_CCM_CSCMR1_SSI_EXT1_COM_CLK_SEL;
> > +     } else {
> > +             reg &= ~MXC_CCM_CSCMR1_SSI_EXT1_COM_CLK_SEL;
> > +             mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk, &pll3_sw_clk,
> > +                            &ssi_lp_apm_clk);
> > +             reg = (reg & ~MXC_CCM_CSCMR1_SSI_EXT1_CLK_SEL_MASK) |
> > +                 (mux << MXC_CCM_CSCMR1_SSI_EXT1_CLK_SEL_OFFSET);
> > +     }
> > +
> > +     __raw_writel(reg, MXC_CCM_CSCMR1);
> > +
> > +     return 0;
> > +}
> > +
> > +static unsigned long _clk_ssi_ext1_round_rate(struct clk *clk,
> > +                                             unsigned long rate)
> > +{
> > +     u32 pre, post;
> > +     u32 parent_rate = clk_get_rate(clk->parent);
> > +     u32 div = parent_rate / rate;
> > +
> > +     if (parent_rate % rate)
> > +             div++;
> > +
> > +     __calc_pre_post_dividers(div, &pre, &post);
> > +
> > +     return parent_rate / (pre * post);
> > +}
> > +
> > +static struct clk ssi_ext1_clk = {
> > +     .parent = &pll3_sw_clk,
> > +     .set_parent = _clk_ssi_ext1_set_parent,
> > +     .set_rate = _clk_ssi_ext1_set_rate,
> > +     .round_rate = _clk_ssi_ext1_round_rate,
> > +     .get_rate = _clk_ssi_ext1_get_rate,
> > +     .enable_reg = MXC_CCM_CCGR3,
> > +     .enable_shift = MXC_CCM_CCGRx_CG14_OFFSET,
> > +     .enable = _clk_enable,
> > +     .disable = _clk_disable,
> > +};
> > +
> > +static unsigned long _clk_ssi_ext2_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, prediv, podf;
> > +     u32 div = 1;
> > +
> > +     reg = __raw_readl(MXC_CCM_CSCMR1);
> > +     if ((reg & MXC_CCM_CSCMR1_SSI_EXT2_COM_CLK_SEL) == 0) {
> > +             reg = __raw_readl(MXC_CCM_CS2CDR);
> > +             prediv = ((reg & MXC_CCM_CS2CDR_SSI_EXT2_CLK_PRED_MASK) >>
> > +                       MXC_CCM_CS2CDR_SSI_EXT2_CLK_PRED_OFFSET) + 1;
> > +             if (prediv == 1)
> > +                     BUG();
> > +             podf = ((reg & MXC_CCM_CS2CDR_SSI_EXT2_CLK_PODF_MASK) >>
> > +                     MXC_CCM_CS2CDR_SSI_EXT2_CLK_PODF_OFFSET) + 1;
> > +             div = prediv * podf;
> > +     }
> > +     return clk_get_rate(clk->parent) / div;
> > +}
> > +
> > +static int _clk_ssi_ext2_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     reg = __raw_readl(MXC_CCM_CSCMR1);
> > +     if (parent == &ssi2_clk[0]) {
> > +             reg |= MXC_CCM_CSCMR1_SSI_EXT2_COM_CLK_SEL;
> > +     } else {
> > +             reg &= ~MXC_CCM_CSCMR1_SSI_EXT2_COM_CLK_SEL;
> > +             mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk, &pll3_sw_clk,
> > +                            &ssi_lp_apm_clk);
> > +             reg = (reg & ~MXC_CCM_CSCMR1_SSI_EXT2_CLK_SEL_MASK) |
> > +                 (mux << MXC_CCM_CSCMR1_SSI_EXT2_CLK_SEL_OFFSET);
> > +     }
> > +
> > +     __raw_writel(reg, MXC_CCM_CSCMR1);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct clk ssi_ext2_clk = {
> > +     .parent = &pll3_sw_clk,
> > +     .set_parent = _clk_ssi_ext2_set_parent,
> > +     .get_rate = _clk_ssi_ext2_get_rate,
> > +     .enable_reg = MXC_CCM_CCGR3,
> > +     .enable_shift = MXC_CCM_CCGRx_CG15_OFFSET,
> > +     .enable = _clk_enable,
> > +     .disable = _clk_disable,
> > +};
> > +
> > +static struct clk tmax2_clk = {
> > +      .id = 0,
> > +      .parent = &ahb_clk,
> > +      .secondary = &ahb_max_clk,
> > +      .enable = _clk_enable,
> > +      .enable_reg = MXC_CCM_CCGR1,
> > +      .enable_shift = MXC_CCM_CCGRx_CG1_OFFSET,
> > +      .disable = _clk_disable,
> > +};
> > +
> > +static struct clk usb_ahb_clk = {
> > +      .parent = &ipg_clk,
> > +      .secondary = &ddr_clk,
> > +      .enable = _clk_enable,
> > +      .enable_reg = MXC_CCM_CCGR2,
> > +      .enable_shift = MXC_CCM_CCGRx_CG13_OFFSET,
> > +      .disable = _clk_disable,
> > +};
> > +
> > +static struct clk usb_phy_clk[] = {
> > +     {
> > +     .id = 0,
> > +     .parent = &osc_clk,
> > +     .enable = _clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR4,
> > +     .enable_shift = MXC_CCM_CCGRx_CG5_OFFSET,
> > +     .disable = _clk_disable,
> > +     },
> > +     {
> > +     .id = 1,
> > +     .parent = &osc_clk,
> > +     .enable = _clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR4,
> > +     .enable_shift = MXC_CCM_CCGRx_CG6_OFFSET,
> > +     .disable = _clk_disable,
> > +     }
> > +};
> > +
> > +static struct clk esdhc_dep_clks = {
> > +      .parent = &spba_clk,
> > +      .secondary = &ddr_clk,
> > +};
> > +
> > +static unsigned long _clk_esdhc1_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, prediv, podf;
> > +
> > +     reg = __raw_readl(MXC_CCM_CSCDR1);
> > +     prediv = ((reg & MXC_CCM_CSCDR1_ESDHC1_MSHC2_CLK_PRED_MASK) >>
> > +               MXC_CCM_CSCDR1_ESDHC1_MSHC2_CLK_PRED_OFFSET) + 1;
> > +     podf = ((reg & MXC_CCM_CSCDR1_ESDHC1_MSHC2_CLK_PODF_MASK) >>
> > +             MXC_CCM_CSCDR1_ESDHC1_MSHC2_CLK_PODF_OFFSET) + 1;
> > +
> > +     return clk_get_rate(clk->parent) / (prediv * podf);
> > +}
> > +
> > +static int _clk_esdhc1_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     reg = __raw_readl(MXC_CCM_CSCMR1);
> > +     mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk, &pll3_sw_clk,
> > +                    &lp_apm_clk);
> > +     reg = reg & ~MXC_CCM_CSCMR1_ESDHC1_CLK_SEL_MASK;
> > +     reg |= mux << MXC_CCM_CSCMR1_ESDHC1_CLK_SEL_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CSCMR1);
> > +
> > +     return 0;
> > +}
> > +
> > +
> > +static int _clk_esdhc1_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 reg;
> > +     u32 div;
> > +     u32 pre, post;
> > +     u32 parent_rate = clk_get_rate(clk->parent);
> > +
> > +     div = parent_rate / rate;
> > +
> > +     if ((parent_rate / div) != rate)
> > +             return -EINVAL;
> > +
> > +      __calc_pre_post_dividers(div, &pre, &post);
> > +
> > +     /* Set sdhc1 clock divider */
> > +     reg = __raw_readl(MXC_CCM_CSCDR1) &
> > +             ~(MXC_CCM_CSCDR1_ESDHC1_MSHC2_CLK_PRED_MASK |
> > +             MXC_CCM_CSCDR1_ESDHC1_MSHC2_CLK_PODF_MASK);
> > +     reg |= (post - 1) << MXC_CCM_CSCDR1_ESDHC1_MSHC2_CLK_PODF_OFFSET;
> > +     reg |= (pre - 1) << MXC_CCM_CSCDR1_ESDHC1_MSHC2_CLK_PRED_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CSCDR1);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct clk esdhc1_clk[] = {
> > +     {
> > +      .id = 0,
> > +      .parent = &pll2_sw_clk,
> > +      .set_parent = _clk_esdhc1_set_parent,
> > +      .get_rate = _clk_esdhc1_get_rate,
> > +      .set_rate = _clk_esdhc1_set_rate,
> > +      .enable = _clk_enable,
> > +      .enable_reg = MXC_CCM_CCGR3,
> > +      .enable_shift = MXC_CCM_CCGRx_CG1_OFFSET,
> > +      .disable = _clk_disable,
> > +      .secondary = &esdhc1_clk[1],
> > +      },
> > +     {
> > +      .id = 0,
> > +      .parent = &ipg_clk,
> > +      .secondary = &esdhc1_clk[2],
> > +      .enable = _clk_enable,
> > +      .enable_reg = MXC_CCM_CCGR3,
> > +      .enable_shift = MXC_CCM_CCGRx_CG0_OFFSET,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 0,
> > +      .parent = &tmax2_clk,
> > +      .secondary = &esdhc_dep_clks,
> > +      },
> > +
> > +};
> > +
> > +static int _clk_esdhc2_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_CSCMR1);
> > +     if (parent == &esdhc1_clk[0])
> > +             reg &= ~MXC_CCM_CSCMR1_ESDHC2_CLK_SEL;
> > +     else if (parent == &esdhc3_clk[0])
> > +             reg |= MXC_CCM_CSCMR1_ESDHC2_CLK_SEL;
> > +     else
> > +             BUG();
> > +     __raw_writel(reg, MXC_CCM_CSCMR1);
> > +     return 0;
> > +}
> > +
> > +static struct clk esdhc2_clk[] = {
> > +     {
> > +      .id = 1,
> > +      .parent = &esdhc1_clk[0],
> > +      .set_parent = _clk_esdhc2_set_parent,
> > +      .enable = _clk_enable,
> > +      .enable_reg = MXC_CCM_CCGR3,
> > +      .enable_shift = MXC_CCM_CCGRx_CG3_OFFSET,
> > +      .disable = _clk_disable,
> > +      .secondary = &esdhc2_clk[1],
> > +      },
> > +     {
> > +      .id = 1,
> > +      .parent = &ipg_clk,
> > +      .secondary = &esdhc2_clk[2],
> > +      .enable = _clk_enable,
> > +      .enable_reg = MXC_CCM_CCGR3,
> > +      .enable_shift = MXC_CCM_CCGRx_CG2_OFFSET,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 0,
> > +      .parent = &tmax2_clk,
> > +      .secondary = &esdhc_dep_clks,
> > +      },
> > +};
> > +
> > +static int _clk_esdhc3_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     reg = __raw_readl(MXC_CCM_CSCMR1);
> > +     mux = _get_mux8(parent, &pll1_sw_clk, &pll2_sw_clk,
> > +                     &pll3_sw_clk, &lp_apm_clk, &pfd0_clk,
> > +                     &pfd1_clk, &pfd4_clk, &osc_clk);
> > +     reg = reg & ~MXC_CCM_CSCMR1_ESDHC3_CLK_SEL_MASK;
> > +     reg |= mux << MXC_CCM_CSCMR1_ESDHC3_CLK_SEL_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CSCMR1);
> > +
> > +     return 0;
> > +}
> > +
> > +static unsigned long _clk_esdhc3_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, prediv, podf;
> > +
> > +     reg = __raw_readl(MXC_CCM_CSCDR1);
> > +     prediv = ((reg & MXC_CCM_CSCDR1_ESDHC3_MSHC2_CLK_PRED_MASK) >>
> > +               MXC_CCM_CSCDR1_ESDHC3_MSHC2_CLK_PRED_OFFSET) + 1;
> > +     podf = ((reg & MXC_CCM_CSCDR1_ESDHC3_MSHC2_CLK_PODF_MASK) >>
> > +             MXC_CCM_CSCDR1_ESDHC3_MSHC2_CLK_PODF_OFFSET) + 1;
> > +
> > +     return clk_get_rate(clk->parent) / (prediv * podf);
> > +}
> > +
> > +static int _clk_esdhc3_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 reg;
> > +     u32 div;
> > +     u32 pre, post;
> > +     u32 parent_rate = clk_get_rate(clk->parent);
> > +
> > +     div = parent_rate / rate;
> > +
> > +     if ((parent_rate / div) != rate)
> > +             return -EINVAL;
> > +
> > +     __calc_pre_post_dividers(div, &pre, &post);
> > +
> > +     /* Set sdhc1 clock divider */
> > +     reg = __raw_readl(MXC_CCM_CSCDR1) &
> > +             ~(MXC_CCM_CSCDR1_ESDHC3_MSHC2_CLK_PRED_MASK |
> > +             MXC_CCM_CSCDR1_ESDHC3_MSHC2_CLK_PODF_MASK);
> > +     reg |= (post - 1) << MXC_CCM_CSCDR1_ESDHC3_MSHC2_CLK_PODF_OFFSET;
> > +     reg |= (pre - 1) << MXC_CCM_CSCDR1_ESDHC3_MSHC2_CLK_PRED_OFFSET;
> > +      __raw_writel(reg, MXC_CCM_CSCDR1);
> > +
> > +     return 0;
> > +}
> > +
> > +
> > +static struct clk esdhc3_clk[] = {
> > +     {
> > +      .id = 2,
> > +      .parent = &pll2_sw_clk,
> > +      .set_parent = _clk_esdhc3_set_parent,
> > +      .get_rate = _clk_esdhc3_get_rate,
> > +      .set_rate = _clk_esdhc3_set_rate,
> > +      .enable = _clk_enable,
> > +      .enable_reg = MXC_CCM_CCGR3,
> > +      .enable_shift = MXC_CCM_CCGRx_CG5_OFFSET,
> > +      .disable = _clk_disable,
> > +      .secondary = &esdhc3_clk[1],
> > +      },
> > +     {
> > +      .id = 2,
> > +      .parent = &ipg_clk,
> > +      .secondary = &esdhc3_clk[2],
> > +      .enable = _clk_enable,
> > +      .enable_reg = MXC_CCM_CCGR3,
> > +      .enable_shift = MXC_CCM_CCGRx_CG4_OFFSET,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 0,
> > +      .parent = &ahb_max_clk,
> > +      .secondary = &esdhc_dep_clks,
> > +      },
> > +};
> > +
> > +static int _clk_esdhc4_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_CSCMR1);
> > +     if (parent == &esdhc1_clk[0])
> > +             reg &= ~MXC_CCM_CSCMR1_ESDHC4_CLK_SEL;
> > +     else if (parent == &esdhc3_clk[0])
> > +             reg |= MXC_CCM_CSCMR1_ESDHC4_CLK_SEL;
> > +     else
> > +             BUG();
> > +     __raw_writel(reg, MXC_CCM_CSCMR1);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct clk esdhc4_clk[] = {
> > +     {
> > +      .id = 3,
> > +      .parent = &esdhc1_clk[0],
> > +      .set_parent = _clk_esdhc4_set_parent,
> > +      .enable = _clk_enable,
> > +      .enable_reg = MXC_CCM_CCGR3,
> > +      .enable_shift = MXC_CCM_CCGRx_CG7_OFFSET,
> > +      .disable = _clk_disable,
> > +      .secondary = &esdhc4_clk[1],
> > +      },
> > +     {
> > +      .id = 3,
> > +      .parent = &ipg_clk,
> > +      .secondary = &esdhc4_clk[2],
> > +      .enable = _clk_enable,
> > +      .enable_reg = MXC_CCM_CCGR3,
> > +      .enable_shift = MXC_CCM_CCGRx_CG6_OFFSET,
> > +      .disable = _clk_disable,
> > +      },
> > +     {
> > +      .id = 0,
> > +      .parent = &tmax2_clk,
> > +      .secondary = &esdhc_dep_clks,
> > +      },
> > +};
> > +
> > +static int _clk_ddr_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_CLK_DDR);
> > +     if (parent == &pfd0_clk)
> > +             reg |= MXC_CCM_CLK_DDR_DDR_PFD_SEL;
> > +     else if (parent == &pll1_sw_clk)
> > +             reg &= ~MXC_CCM_CLK_DDR_DDR_PFD_SEL;
> > +     else
> > +             return -EINVAL;
> > +     __raw_writel(reg, MXC_CCM_CLK_DDR);
> > +     return 0;
> > +}
> > +
> > +static unsigned long _clk_ddr_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, div;
> > +
> > +     reg = __raw_readl(MXC_CCM_CLK_DDR);
> > +     div = (reg & MXC_CCM_CLK_DDR_DDR_DIV_PLL_MASK) >>
> > +             MXC_CCM_CLK_DDR_DDR_DIV_PLL_OFFSET;
> > +     if (div)
> > +             return clk_get_rate(clk->parent) / div;
> > +
> > +     return 0;
> > +}
> > +
> > +static int _clk_ddr_enable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     _clk_enable(clk);
> > +     reg = (__raw_readl(databahn + DATABAHN_CTL_REG55)) &
> > +                             DDR_SYNC_MODE;
> > +     if (reg != DDR_SYNC_MODE) {
> > +             reg = __raw_readl(MXC_CCM_CLK_DDR);
> > +             reg |= MXC_CCM_CLK_DDR_DDR_CLKGATE_MASK;
> > +             __raw_writel(reg, MXC_CCM_CLK_DDR);
> > +     }
> > +     return 0;
> > +}
> > +
> > +static void _clk_ddr_disable(struct clk *clk)
> > +{
> > +     _clk_disable_inwait(clk);
> > +}
> > +
> > +
> > +static struct clk ddr_clk = {
> > +     .parent = &pll1_sw_clk,
> > +     .secondary = &sys_clk,
> > +     .set_parent = _clk_ddr_set_parent,
> > +     .get_rate = _clk_ddr_get_rate,
> > +     .enable = _clk_ddr_enable,
> > +     .enable_reg = MXC_CCM_CCGR6,
> > +     .enable_shift = MXC_CCM_CCGRx_CG15_OFFSET,
> > +     .disable = _clk_ddr_disable,
> > +};
> > +
> > +static unsigned long _clk_pgc_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, div;
> > +
> > +     reg = __raw_readl(MXC_CCM_CSCDR1);
> > +     div = (reg & MXC_CCM_CSCDR1_PGC_CLK_PODF_MASK) >>
> > +         MXC_CCM_CSCDR1_PGC_CLK_PODF_OFFSET;
> > +     div = 1 >> div;
> > +     return clk_get_rate(clk->parent) / div;
> > +}
> > +
> > +static struct clk pgc_clk = {
> > +     .parent = &ipg_clk,
> > +     .get_rate = _clk_pgc_get_rate,
> > +};
> > +
> > +static unsigned long _clk_usb_get_rate(struct clk *clk)
> > +{
> > +     return 60000000;
> > +}
> > +
> > +/*usb OTG clock */
> space after * please
ok
> 
> > +static struct clk usb_clk = {
> > +     .get_rate = _clk_usb_get_rate,
> > +};
> > +
> > +static struct clk rtc_clk = {
> > +     .parent = &ckil_clk,
> > +     .secondary = &ipg_clk,
> > +     .enable = _clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR4,
> > +     .enable_shift = MXC_CCM_CCGRx_CG14_OFFSET,
> > +     .disable = _clk_disable,
> > +};
> > +
> > +struct clk rng_clk = {
> > +     .parent = &ipg_clk,
> > +     .enable = _clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR7,
> > +     .enable_shift = MXC_CCM_CCGRx_CG1_OFFSET,
> > +     .disable = _clk_disable,
> > +};
> > +
> > +static struct clk owire_clk = {
> > +     .parent = &ipg_perclk,
> > +     .enable = _clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR2,
> > +     .enable_shift = MXC_CCM_CCGRx_CG11_OFFSET,
> > +     .disable = _clk_disable,
> > +};
> > +
> > +static struct clk fec_clk[] = {
> > +     {
> > +     .parent = &ipg_clk,
> > +     .secondary = &fec_clk[1],
> > +     .enable = _clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR2,
> > +     .enable_shift = MXC_CCM_CCGRx_CG12_OFFSET,
> > +     .disable = _clk_disable,
> > +     },
> > +     {
> > +      .parent = &aips_tz2_clk,
> > +      .secondary = &ddr_clk,
> > +     },
> > +};
> > +
> > +static int gpmi_clk_enable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_GPMI);
> > +     reg |= MXC_CCM_GPMI_CLKGATE_MASK;
> > +     __raw_writel(reg, MXC_CCM_GPMI);
> > +     _clk_enable(clk);
> > +     return 0;
> > +}
> > +
> > +static void gpmi_clk_disable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_GPMI);
> > +     reg &= ~MXC_CCM_GPMI_CLKGATE_MASK;
> > +     __raw_writel(reg, MXC_CCM_GPMI);
> > +     _clk_disable(clk);
> > +}
> > +
> > +static int bch_clk_enable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_BCH);
> > +     reg |= MXC_CCM_BCH_CLKGATE_MASK;
> > +     __raw_writel(reg, MXC_CCM_BCH);
> > +     _clk_enable(clk);
> > +     return 0;
> > +}
> > +
> > +static void bch_clk_disable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_BCH);
> > +     reg &= ~MXC_CCM_BCH_CLKGATE_MASK;
> > +     __raw_writel(reg, MXC_CCM_BCH);
> > +     _clk_disable(clk);
> > +}
> > +
> > +static int gpmi_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     /* Setting for ONFI nand which need PLL1(800MHZ) */
> > +     if (parent == &pll1_main_clk) {
> > +             u32 reg = __raw_readl(MXC_CCM_CLKSEQ_BYPASS);
> > +
> > +             reg = (reg & ~MXC_CCM_CLKSEQ_BYPASS_BYPASS_GPMI_CLK_SEL_MASK) |
> > +                (0x2 << MXC_CCM_CLKSEQ_BYPASS_BYPASS_GPMI_CLK_SEL_OFFSET);
> > +
> > +             __raw_writel(reg, MXC_CCM_CLKSEQ_BYPASS);
> > +
> > +             /* change to the new Parent */
> > +             clk->parent = parent;
> > +     } else
> > +             printk(KERN_WARNING "You should not call the %s\n", __func__);
> > +     return 0;
> > +}
> > +
> > +static int gpmi_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     /* Setting for ONFI nand which in different mode */
> > +     if (clk->parent == &pll1_main_clk) {
> > +             u32 value;
> > +             u32 reg;
> > +
> > +             value = clk_get_rate(clk->parent);
> > +             value /= rate;
> > +             value /= 2; /* HW_GPMI_CTRL1's GPMI_CLK_DIV2_EN will be set */
> > +
> > +             reg = __raw_readl(MXC_CCM_GPMI);
> > +             reg = (reg & ~MXC_CCM_GPMI_CLK_DIV_MASK) | value;
> > +
> > +             __raw_writel(reg, MXC_CCM_GPMI);
> > +     } else
> > +             printk(KERN_WARNING "You should not call the %s\n", __func__);
> > +     return 0;
> > +}
> > +
> > +static struct clk gpmi_nfc_clk[] = {
> > +     {       /* gpmi_io_clk */
> > +     .parent = &osc_clk,
> > +     .secondary = &gpmi_nfc_clk[1],
> > +     .set_parent = gpmi_set_parent,
> > +     .set_rate   = gpmi_set_rate,
> > +     .enable = gpmi_clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR7,
> > +     .enable_shift = MXC_CCM_CCGRx_CG9_OFFSET,
> > +     .disable = gpmi_clk_disable,
> > +     },
> > +     {       /* gpmi_apb_clk */
> > +     .parent = &ahb_clk,
> > +     .secondary = &gpmi_nfc_clk[2],
> > +     .enable = _clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR7,
> > +     .enable_shift = MXC_CCM_CCGRx_CG8_OFFSET,
> > +     .disable = _clk_disable,
> > +     },
> > +     {       /* bch_clk */
> > +     .parent = &osc_clk,
> > +     .secondary = &gpmi_nfc_clk[3],
> > +     .enable = bch_clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR7,
> > +     .enable_shift = MXC_CCM_CCGRx_CG0_OFFSET,
> > +     .disable = bch_clk_disable,
> > +     },
> > +     {       /* bch_apb_clk */
> > +     .parent = &ahb_clk,
> > +     .enable = _clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR7,
> > +     .enable_shift = MXC_CCM_CCGRx_CG12_OFFSET,
> > +     .disable = _clk_disable,
> > +     },
> > +};
> > +
> > +static struct clk ocotp_clk = {
> > +     .parent = &ahb_clk,
> > +     .enable = _clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR7,
> > +     .enable_shift = MXC_CCM_CCGRx_CG13_OFFSET,
> > +     .disable = _clk_disable,
> > +};
> > +
> > +static int _clk_gpu2d_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     reg = __raw_readl(MXC_CCM_CBCMR);
> > +     mux = _get_mux(parent, &axi_a_clk, &axi_b_clk, &weim_clk[0], &ahb_clk);
> > +     reg = (reg & ~MXC_CCM_CBCMR_GPU2D_CLK_SEL_MASK) |
> > +         (mux << MXC_CCM_CBCMR_GPU2D_CLK_SEL_OFFSET);
> > +     __raw_writel(reg, MXC_CCM_CBCMR);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct clk gpu2d_clk = {
> > +     .parent = &axi_a_clk,
> > +     .secondary = &ddr_clk,
> > +     .set_parent = _clk_gpu2d_set_parent,
> > +     .enable = _clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR6,
> > +     .enable_shift = MXC_CCM_CCGRx_CG7_OFFSET,
> > +     .disable = _clk_disable,
> > +};
> > +
> > +static struct clk apbh_dma_clk = {
> > +     .parent = &ahb_clk,
> > +     .secondary = &ddr_clk,
> > +     .enable = _clk_enable,
> > +     .disable = _clk_disable_inwait,
> > +     .enable_reg = MXC_CCM_CCGR7,
> > +     .enable_shift = MXC_CCM_CCGRx_CG10_OFFSET,
> > +};
> > +
> > +struct clk dcp_clk = {
> > +     .parent = &ahb_clk,
> > +     .secondary = &apbh_dma_clk,
> > +     .enable = _clk_enable,
> > +     .enable_reg = MXC_CCM_CCGR7,
> > +     .enable_shift = MXC_CCM_CCGRx_CG11_OFFSET,
> > +     .disable = _clk_disable,
> > +};
> > +
> > +static int _clk_display_axi_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     reg = __raw_readl(MXC_CCM_CLKSEQ_BYPASS);
> > +     mux = _get_mux(parent, &osc_clk, &pfd2_clk, &pll1_sw_clk, NULL);
> > +     reg = (reg & ~MXC_CCM_CLKSEQ_BYPASS_BYPASS_DISPLAY_AXI_CLK_SEL_MASK) |
> > +         (mux << MXC_CCM_CLKSEQ_BYPASS_BYPASS_DISPLAY_AXI_CLK_SEL_OFFSET);
> > +     __raw_writel(reg, MXC_CCM_CLKSEQ_BYPASS);
> > +
> > +     return 0;
> > +}
> > +
> > +static unsigned long _clk_display_axi_get_rate(struct clk *clk)
> > +{
> > +     u32 div;
> > +
> > +     div = __raw_readl(MXC_CCM_DISPLAY_AXI);
> > +     div &= MXC_CCM_DISPLAY_AXI_DIV_MASK;
> > +     if (div == 0) { /* gated off */
> > +             return clk_get_rate(clk->parent);
> > +     } else {
> > +             return clk_get_rate(clk->parent) / div;
> > +     }
> > +}
> > +
> > +static unsigned long _clk_display_axi_round_rate(struct clk *clk,
> > +                                             unsigned long rate)
> > +{
> > +     u32 max_div = (2 << 6) - 1;
> > +     return _clk_round_rate_div(clk, rate, max_div, NULL);
> > +}
> > +
> > +static int _clk_display_axi_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 new_div, max_div;
> > +     u32 reg;
> > +
> > +     max_div = (2 << 6) - 1;
> > +     _clk_round_rate_div(clk, rate, max_div, &new_div);
> > +
> > +     reg = __raw_readl(MXC_CCM_DISPLAY_AXI);
> > +     reg &= ~MXC_CCM_DISPLAY_AXI_DIV_MASK;
> > +     reg |= new_div << MXC_CCM_DISPLAY_AXI_DIV_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_DISPLAY_AXI);
> > +
> > +     while (__raw_readl(MXC_CCM_CSR2) & MXC_CCM_CSR2_DISPLAY_AXI_BUSY)
> > +             ;
> > +     return 0;
> > +}
> > +
> > +static struct clk display_axi_clk = {
> > +     .parent = &osc_clk,
> > +     .secondary = &apbh_dma_clk,
> > +     .set_parent = _clk_display_axi_set_parent,
> > +     .get_rate = _clk_display_axi_get_rate,
> > +     .set_rate = _clk_display_axi_set_rate,
> > +     .round_rate = _clk_display_axi_round_rate,
> > +     .enable = _clk_enable,
> > +     .disable = _clk_disable,
> > +     .enable_reg = MXC_CCM_DISPLAY_AXI,
> > +     .enable_shift = MXC_CCM_DISPLAY_AXI_CLKGATE_OFFSET,
> > +};
> > +
> > +/* TODO: check Auto-Slow Mode */
> > +static struct clk pxp_axi_clk = {
> > +     .parent = &display_axi_clk,
> > +     .enable = _clk_enable,
> > +     .disable = _clk_disable,
> > +     .enable_reg = MXC_CCM_CCGR6,
> > +     .enable_shift = MXC_CCM_CCGRx_CG9_OFFSET,
> > +};
> > +
> > +static struct clk elcdif_axi_clk = {
> > +     .parent = &display_axi_clk,
> > +     .enable = _clk_enable,
> > +     .disable = _clk_disable,
> > +     .enable_reg = MXC_CCM_CCGR6,
> > +     .enable_shift = MXC_CCM_CCGRx_CG10_OFFSET,
> > +};
> > +
> > +static int _clk_elcdif_pix_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     reg = __raw_readl(MXC_CCM_CLKSEQ_BYPASS);
> > +     mux = _get_mux(parent, &osc_clk, &pfd6_clk, &pll1_sw_clk, &ckih_clk);
> > +     reg = (reg & ~MXC_CCM_CLKSEQ_BYPASS_BYPASS_ELCDIF_PIX_CLK_SEL_MASK) |
> > +         (mux << MXC_CCM_CLKSEQ_BYPASS_BYPASS_ELCDIF_PIX_CLK_SEL_OFFSET);
> > +     __raw_writel(reg, MXC_CCM_CLKSEQ_BYPASS);
> > +
> > +     return 0;
> > +}
> > +
> > +static unsigned long _clk_elcdif_pix_get_rate(struct clk *clk)
> > +{
> > +     u32 reg, prediv, podf;
> > +
> > +     reg = __raw_readl(MXC_CCM_ELCDIFPIX);
> > +     prediv = ((reg & MXC_CCM_ELCDIFPIX_CLK_PRED_MASK) >>
> > +               MXC_CCM_ELCDIFPIX_CLK_PRED_OFFSET) + 1;
> > +     podf = ((reg & MXC_CCM_ELCDIFPIX_CLK_PODF_MASK) >>
> > +             MXC_CCM_ELCDIFPIX_CLK_PODF_OFFSET) + 1;
> > +
> > +     return clk_get_rate(clk->parent) / (prediv * podf);
> > +}
> > +
> > +static unsigned long _clk_elcdif_pix_round_rate(struct clk *clk,
> > +                                             unsigned long rate)
> > +{
> > +     u32 max_div = (2 << 12) - 1;
> > +     return _clk_round_rate_div(clk, rate, max_div, NULL);
> > +}
> > +
> > +static int _clk_elcdif_pix_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 new_div, max_div;
> > +     u32 reg;
> > +
> > +     max_div = (2 << 12) - 1;
> > +     _clk_round_rate_div(clk, rate, max_div, &new_div);
> > +
> > +     reg = __raw_readl(MXC_CCM_ELCDIFPIX);
> > +     /* Pre-divider set to 1 - only use PODF for clk dividing */
> > +     reg &= ~MXC_CCM_ELCDIFPIX_CLK_PRED_MASK;
> > +     reg |= 1 << MXC_CCM_ELCDIFPIX_CLK_PRED_OFFSET;
> > +     reg &= ~MXC_CCM_ELCDIFPIX_CLK_PODF_MASK;
> > +     reg |= new_div << MXC_CCM_ELCDIFPIX_CLK_PODF_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_ELCDIFPIX);
> > +
> > +     return 0;
> > +}
> > +
> > +static int _clk_elcdif_pix_enable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     _clk_enable(clk);
> > +     reg = __raw_readl(MXC_CCM_ELCDIFPIX);
> > +     reg |= 0x3 << MXC_CCM_ELCDIFPIX_CLKGATE_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_ELCDIFPIX);
> > +     return 0;
> > +}
> > +
> > +static void _clk_elcdif_pix_disable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_ELCDIFPIX);
> > +     reg &= ~MXC_CCM_ELCDIFPIX_CLKGATE_MASK;
> > +     __raw_writel(reg, MXC_CCM_ELCDIFPIX);
> > +     _clk_disable(clk);
> > +}
> > +
> > +static struct clk elcdif_pix_clk = {
> > +     .parent = &osc_clk,
> > +     .secondary = &ddr_clk,
> > +     .enable = _clk_elcdif_pix_enable,
> > +     .disable = _clk_elcdif_pix_disable,
> > +     .enable_reg = MXC_CCM_CCGR6,
> > +     .enable_shift = MXC_CCM_CCGRx_CG6_OFFSET,
> > +     .set_parent = _clk_elcdif_pix_set_parent,
> > +     .get_rate = _clk_elcdif_pix_get_rate,
> > +     .round_rate = _clk_elcdif_pix_round_rate,
> > +     .set_rate = _clk_elcdif_pix_set_rate,
> > +};
> > +
> > +static int _clk_epdc_axi_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     reg = __raw_readl(MXC_CCM_CLKSEQ_BYPASS);
> > +     mux = _get_mux(parent, &osc_clk, &pfd3_clk, &pll1_sw_clk, NULL);
> > +     reg = (reg & ~MXC_CCM_CLKSEQ_BYPASS_BYPASS_EPDC_AXI_CLK_SEL_MASK) |
> > +         (mux << MXC_CCM_CLKSEQ_BYPASS_BYPASS_EPDC_AXI_CLK_SEL_OFFSET);
> > +     __raw_writel(reg, MXC_CCM_CLKSEQ_BYPASS);
> > +
> > +     return 0;
> > +}
> > +
> > +static unsigned long _clk_epdc_axi_get_rate(struct clk *clk)
> > +{
> > +     u32 div;
> > +
> > +     div = __raw_readl(MXC_CCM_EPDC_AXI);
> > +     div &= MXC_CCM_EPDC_AXI_DIV_MASK;
> > +     if (div == 0) { /* gated off */
> > +             return clk_get_rate(clk->parent);
> > +     } else {
> > +             return clk_get_rate(clk->parent) / div;
> > +     }
> > +}
> > +
> > +static unsigned long _clk_epdc_axi_round_rate_div(struct clk *clk,
> > +                                             unsigned long rate,
> > +                                             u32 *new_div)
> > +{
> > +     u32 div, max_div;
> > +
> > +     max_div = (2 << 6) - 1;
> > +     div = DIV_ROUND_UP(clk_get_rate(clk->parent), rate);
> > +     if (div > max_div)
> > +             div = max_div;
> > +     else if (div == 0)
> > +             div++;
> > +     if (new_div != NULL)
> > +             *new_div = div;
> > +     return clk_get_rate(clk->parent) / div;
> > +}
> > +
> > +static unsigned long _clk_epdc_axi_round_rate(struct clk *clk,
> > +                                             unsigned long rate)
> > +{
> > +     return _clk_epdc_axi_round_rate_div(clk, rate, NULL);
> > +}
> > +
> > +static int _clk_epdc_axi_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 new_div;
> > +     u32 reg;
> > +
> > +     _clk_epdc_axi_round_rate_div(clk, rate, &new_div);
> > +
> > +     reg = __raw_readl(MXC_CCM_EPDC_AXI);
> > +     reg &= ~MXC_CCM_EPDC_AXI_DIV_MASK;
> > +     reg |= new_div << MXC_CCM_EPDC_AXI_DIV_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_EPDC_AXI);
> > +
> > +     while (__raw_readl(MXC_CCM_CSR2) & MXC_CCM_CSR2_EPDC_AXI_BUSY)
> > +             ;
> > +
> > +     return 0;
> > +}
> > +
> > +static int _clk_epdc_axi_enable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     _clk_enable(clk);
> > +
> > +     reg = __raw_readl(MXC_CCM_EPDC_AXI);
> > +     reg |= MXC_CCM_EPDC_AXI_CLKGATE_MASK;
> > +     __raw_writel(reg, MXC_CCM_EPDC_AXI);
> > +
> > +     return 0;
> > +}
> > +
> > +static void _clk_epdc_axi_disable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_EPDC_AXI);
> > +     reg &= ~MXC_CCM_EPDC_AXI_CLKGATE_MASK;
> > +     __raw_writel(reg, MXC_CCM_EPDC_AXI);
> > +     _clk_disable(clk);
> > +}
> > +
> > +/* TODO: check Auto-Slow Mode */
> > +static struct clk epdc_axi_clk = {
> > +     .parent = &osc_clk,
> > +     .secondary = &apbh_dma_clk,
> > +     .enable_reg = MXC_CCM_CCGR6,
> > +     .enable_shift = MXC_CCM_CCGRx_CG8_OFFSET,
> > +     .set_parent = _clk_epdc_axi_set_parent,
> > +     .get_rate = _clk_epdc_axi_get_rate,
> > +     .set_rate = _clk_epdc_axi_set_rate,
> > +     .round_rate = _clk_epdc_axi_round_rate,
> > +     .enable = _clk_epdc_axi_enable,
> > +     .disable = _clk_epdc_axi_disable,
> > +};
> > +
> > +
> > +static int _clk_epdc_pix_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 reg, mux;
> > +
> > +     reg = __raw_readl(MXC_CCM_CLKSEQ_BYPASS);
> > +     mux = _get_mux(parent, &osc_clk, &pfd5_clk, &pll1_sw_clk, &ckih_clk);
> > +     reg = (reg & ~MXC_CCM_CLKSEQ_BYPASS_BYPASS_EPDC_PIX_CLK_SEL_MASK) |
> > +         (mux << MXC_CCM_CLKSEQ_BYPASS_BYPASS_EPDC_PIX_CLK_SEL_OFFSET);
> > +     __raw_writel(reg, MXC_CCM_CLKSEQ_BYPASS);
> > +
> > +     return 0;
> > +}
> > +
> > +static unsigned long _clk_epdc_pix_get_rate(struct clk *clk)
> > +{
> > +     u32 div;
> > +
> > +     div = __raw_readl(MXC_CCM_EPDCPIX);
> > +     div &= MXC_CCM_EPDC_PIX_CLK_PODF_MASK;
> > +     if (div == 0) { /* gated off */
> > +             return clk_get_rate(clk->parent);
> > +     } else {
> > +             return clk_get_rate(clk->parent) / div;
> > +     }
> > +}
> > +
> > +static unsigned long _clk_epdc_pix_round_rate(struct clk *clk,
> > +                                             unsigned long rate)
> > +{
> > +     u32 max_div = (2 << 12) - 1;
> > +     return _clk_round_rate_div(clk, rate, max_div, NULL);
> > +}
> > +
> > +static int _clk_epdc_pix_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 new_div, max_div;
> > +     u32 reg;
> > +
> > +     max_div = (2 << 12) - 1;
> > +     _clk_round_rate_div(clk, rate, max_div, &new_div);
> > +
> > +     reg = __raw_readl(MXC_CCM_EPDCPIX);
> > +     /* Pre-divider set to 1 - only use PODF for clk dividing */
> > +     reg &= ~MXC_CCM_EPDC_PIX_CLK_PRED_MASK;
> > +     reg |= 1 << MXC_CCM_EPDC_PIX_CLK_PRED_OFFSET;
> > +     reg &= ~MXC_CCM_EPDC_PIX_CLK_PODF_MASK;
> > +     reg |= new_div << MXC_CCM_EPDC_PIX_CLK_PODF_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_EPDCPIX);
> > +
> > +     while (__raw_readl(MXC_CCM_CSR2) & MXC_CCM_CSR2_EPDC_PIX_BUSY)
> > +             ;
> > +
> > +     return 0;
> > +}
> > +
> > +static int _clk_epdc_pix_enable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     _clk_enable(clk);
> > +     reg = __raw_readl(MXC_CCM_EPDCPIX);
> > +     reg |= MXC_CCM_EPDC_PIX_CLKGATE_MASK;
> > +     __raw_writel(reg, MXC_CCM_EPDCPIX);
> > +
> > +     return 0;
> > +}
> > +
> > +static void _clk_epdc_pix_disable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_EPDCPIX);
> > +     reg &= ~MXC_CCM_EPDC_PIX_CLKGATE_MASK;
> > +     __raw_writel(reg, MXC_CCM_EPDCPIX);
> > +     _clk_disable(clk);
> > +}
> > +
> > +/* TODO: check Auto-Slow Mode */
> > +static struct clk epdc_pix_clk = {
> > +     .parent = &osc_clk,
> > +     .secondary = &apbh_dma_clk,
> > +     .enable_reg = MXC_CCM_CCGR6,
> > +     .enable_shift = MXC_CCM_CCGRx_CG5_OFFSET,
> > +     .set_parent = _clk_epdc_pix_set_parent,
> > +     .get_rate = _clk_epdc_pix_get_rate,
> > +     .set_rate = _clk_epdc_pix_set_rate,
> > +     .round_rate = _clk_epdc_pix_round_rate,
> > +     .enable = _clk_epdc_pix_enable,
> > +     .disable = _clk_epdc_pix_disable,
> > +};
> > +
> > +static unsigned long cko1_get_rate(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_CCOSR);
> > +     reg &= MXC_CCM_CCOSR_CKO1_DIV_MASK;
> > +     reg = reg >> MXC_CCM_CCOSR_CKO1_DIV_OFFSET;
> > +     return clk_get_rate(clk->parent) / (reg + 1);
> > +}
> > +
> > +static int cko1_enable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_CCOSR);
> > +     reg |= MXC_CCM_CCOSR_CKO1_EN;
> > +     __raw_writel(reg, MXC_CCM_CCOSR);
> > +     return 0;
> > +}
> > +
> > +static void cko1_disable(struct clk *clk)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __raw_readl(MXC_CCM_CCOSR);
> > +     reg &= ~MXC_CCM_CCOSR_CKO1_EN;
> > +     __raw_writel(reg, MXC_CCM_CCOSR);
> > +}
> > +
> > +static int cko1_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 reg, div;
> > +     u32 parent_rate = clk_get_rate(clk->parent);
> > +
> > +     div = (parent_rate/rate - 1) & 0x7;
> > +     reg = __raw_readl(MXC_CCM_CCOSR);
> > +     reg &= ~MXC_CCM_CCOSR_CKO1_DIV_MASK;
> > +     reg |= div << MXC_CCM_CCOSR_CKO1_DIV_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CCOSR);
> > +     return 0;
> > +}
> > +
> > +static unsigned long cko1_round_rate(struct clk *clk, unsigned long rate)
> > +{
> > +     u32 div;
> > +     u32 parent_rate = clk_get_rate(clk->parent);
> > +
> > +     div = parent_rate / rate;
> > +     div = div < 1 ? 1 : div;
> > +     div = div > 8 ? 8 : div;
> > +     return parent_rate / div;
> > +}
> > +
> > +static int cko1_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +     u32 sel, reg, fast;
> > +
> > +     if (parent == &cpu_clk) {
> > +             sel = 0;
> > +             fast = 1;
> > +     } else if (parent == &pll1_sw_clk) {
> > +             sel = 1;
> > +             fast = 1;
> > +     } else if (parent == &pll2_sw_clk) {
> > +             sel = 2;
> > +             fast = 1;
> > +     } else if (parent == &pll3_sw_clk) {
> > +             sel = 3;
> > +             fast = 1;
> > +     } else if (parent == &apll_clk) {
> > +             sel = 0;
> > +             fast = 0;
> > +     } else if (parent == &pfd0_clk) {
> > +             sel = 1;
> > +             fast = 0;
> > +     } else if (parent == &pfd1_clk) {
> > +             sel = 2;
> > +             fast = 0;
> > +     } else if (parent == &pfd2_clk) {
> > +             sel = 3;
> > +             fast = 0;
> > +     } else if (parent == &pfd3_clk) {
> > +             sel = 4;
> > +             fast = 0;
> > +     } else if (parent == &pfd4_clk) {
> > +             sel = 5;
> > +             fast = 0;
> > +     } else if (parent == &pfd5_clk) {
> > +             sel = 6;
> > +             fast = 0;
> > +     } else if (parent == &pfd6_clk) {
> > +             sel = 7;
> > +             fast = 0;
> > +     } else if (parent == &weim_clk[0]) {
> > +             sel = 10;
> > +             fast = 0;
> > +     } else if (parent == &ahb_clk) {
> > +             sel = 11;
> > +             fast = 0;
> > +     } else if (parent == &ipg_clk) {
> > +             sel = 12;
> > +             fast = 0;
> > +     } else if (parent == &ipg_perclk) {
> > +             sel = 13;
> > +             fast = 0;
> > +     } else if (parent == &pfd7_clk) {
> > +             sel = 15;
> > +             fast = 0;
> > +     } else
> > +             return -EINVAL;
> > +
> > +     reg = __raw_readl(MXC_CCM_CCOSR);
> > +     reg &= ~MXC_CCM_CCOSR_CKO1_SEL_MASK;
> > +     reg |= sel << MXC_CCM_CCOSR_CKO1_SEL_OFFSET;
> > +     if (fast)
> > +             reg &= ~MXC_CCM_CCOSR_CKO1_SLOW_SEL;
> > +     else
> > +             reg |= MXC_CCM_CCOSR_CKO1_SLOW_SEL;
> > +     __raw_writel(reg, MXC_CCM_CCOSR);
> > +     return 0;
> > +}
> > +
> > +static struct clk cko1_clk = {
> > +     .parent = &pll1_sw_clk,
> > +     .get_rate = cko1_get_rate,
> > +     .enable = cko1_enable,
> > +     .disable = cko1_disable,
> > +     .set_rate = cko1_set_rate,
> > +     .round_rate = cko1_round_rate,
> > +     .set_parent = cko1_set_parent,
> > +};
> > +
> > +#define _REGISTER_CLOCK(d, n, c) \
> > +     { \
> > +             .dev_id = d, \
> > +             .con_id = n, \
> > +             .clk = &c, \
> > +     }
> > +
> > +static struct clk_lookup lookups[] = {
> > +     _REGISTER_CLOCK(NULL, "osc", osc_clk),
> > +     _REGISTER_CLOCK(NULL, "ckih", ckih_clk),
> > +     _REGISTER_CLOCK(NULL, "ckih2", ckih2_clk),
> > +     _REGISTER_CLOCK(NULL, "ckil", ckil_clk),
> > +     _REGISTER_CLOCK(NULL, "pll1_main_clk", pll1_main_clk),
> > +     _REGISTER_CLOCK(NULL, "pll1_sw_clk", pll1_sw_clk),
> > +     _REGISTER_CLOCK(NULL, "pll2", pll2_sw_clk),
> > +     _REGISTER_CLOCK(NULL, "pll3", pll3_sw_clk),
> > +     _REGISTER_CLOCK(NULL, "apll", apll_clk),
> > +     _REGISTER_CLOCK(NULL, "pfd0", pfd0_clk),
> > +     _REGISTER_CLOCK(NULL, "pfd1", pfd1_clk),
> > +     _REGISTER_CLOCK(NULL, "pfd2", pfd2_clk),
> > +     _REGISTER_CLOCK(NULL, "pfd3", pfd3_clk),
> > +     _REGISTER_CLOCK(NULL, "pfd4", pfd4_clk),
> > +     _REGISTER_CLOCK(NULL, "pfd5", pfd5_clk),
> > +     _REGISTER_CLOCK(NULL, "pfd6", pfd6_clk),
> > +     _REGISTER_CLOCK(NULL, "pfd7", pfd7_clk),
> > +     _REGISTER_CLOCK(NULL, "gpc_dvfs_clk", gpc_dvfs_clk),
> > +     _REGISTER_CLOCK(NULL, "lp_apm", lp_apm_clk),
> > +     _REGISTER_CLOCK(NULL, "cpu_clk", cpu_clk),
> > +     _REGISTER_CLOCK(NULL, "main_bus_clk", main_bus_clk),
> > +     _REGISTER_CLOCK(NULL, "axi_a_clk", axi_a_clk),
> > +     _REGISTER_CLOCK(NULL, "axi_b_clk", axi_b_clk),
> > +     _REGISTER_CLOCK(NULL, "ahb_clk", ahb_clk),
> > +     _REGISTER_CLOCK(NULL, "ahb_max_clk", ahb_max_clk),
> > +     _REGISTER_CLOCK("mxc_sdma", "sdma_ahb_clk", sdma_clk[0]),
> > +     _REGISTER_CLOCK("mxc_sdma", "sdma_ipg_clk", sdma_clk[1]),
> > +     _REGISTER_CLOCK("imx-uart.0", NULL, uart1_clk[0]),
> > +     _REGISTER_CLOCK("imx-uart.1", NULL, uart2_clk[0]),
> > +     _REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk[0]),
> > +     _REGISTER_CLOCK("imx-uart.3", NULL, uart4_clk[0]),
> > +     _REGISTER_CLOCK("imx-uart.4", NULL, uart5_clk[0]),
> > +     _REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk[0]),
> > +     _REGISTER_CLOCK("imx-i2c.1", NULL, i2c_clk[1]),
> > +     _REGISTER_CLOCK("imx-i2c.2", NULL, i2c_clk[2]),
> > +     _REGISTER_CLOCK("mxc_pwm.0", NULL, pwm1_clk[0]),
> > +     _REGISTER_CLOCK("mxc_pwm.1", NULL, pwm2_clk[0]),
> > +     _REGISTER_CLOCK("mxc_spi.0", NULL, cspi1_clk[0]),
> > +     _REGISTER_CLOCK("mxc_spi.1", NULL, cspi2_clk[0]),
> > +     _REGISTER_CLOCK("mxc_spi.2", NULL, cspi3_clk),
> > +     _REGISTER_CLOCK(NULL, "ssi_lp_apm_clk", ssi_lp_apm_clk),
> > +     _REGISTER_CLOCK("mxc_ssi.0", NULL, ssi1_clk[0]),
> > +     _REGISTER_CLOCK("mxc_ssi.1", NULL, ssi2_clk[0]),
> > +     _REGISTER_CLOCK(NULL, "ssi_ext1_clk", ssi_ext1_clk),
> > +     _REGISTER_CLOCK(NULL, "ssi_ext2_clk", ssi_ext2_clk),
> > +     _REGISTER_CLOCK(NULL, "usb_ahb_clk", usb_ahb_clk),
> > +     _REGISTER_CLOCK(NULL, "usb_phy1_clk", usb_phy_clk[0]),
> > +     _REGISTER_CLOCK(NULL, "usb_phy2_clk", usb_phy_clk[1]),
> > +     _REGISTER_CLOCK(NULL, "usb_clk", usb_clk),
> > +     _REGISTER_CLOCK("mxsdhci.0", NULL, esdhc1_clk[0]),
> > +     _REGISTER_CLOCK("mxsdhci.1", NULL, esdhc2_clk[0]),
> > +     _REGISTER_CLOCK("mxsdhci.2", NULL, esdhc3_clk[0]),
> > +     _REGISTER_CLOCK("mxsdhci.3", NULL, esdhc4_clk[0]),
> > +     _REGISTER_CLOCK(NULL, "ddr_clk", ddr_clk),
> > +     _REGISTER_CLOCK("mxc_rtc.0", NULL, rtc_clk),
> > +     _REGISTER_CLOCK("mxc_w1.0", NULL, owire_clk),
> > +     _REGISTER_CLOCK(NULL, "gpu2d_clk", gpu2d_clk),
> > +     _REGISTER_CLOCK(NULL, "cko1", cko1_clk),
> > +     _REGISTER_CLOCK(NULL, "gpt", gpt_clk[0]),
> > +     _REGISTER_CLOCK("fec.0", NULL, fec_clk[0]),
> > +     _REGISTER_CLOCK(NULL, "fec_sec1_clk", fec_clk[1]),
> > +     _REGISTER_CLOCK("mxc_w1.0", NULL, owire_clk),
> > +     _REGISTER_CLOCK(NULL, "gpmi-nfc", gpmi_nfc_clk[0]),
> > +     _REGISTER_CLOCK(NULL, "gpmi-apb", gpmi_nfc_clk[1]),
> > +     _REGISTER_CLOCK(NULL, "bch", gpmi_nfc_clk[2]),
> > +     _REGISTER_CLOCK(NULL, "bch-apb", gpmi_nfc_clk[3]),
> > +     _REGISTER_CLOCK(NULL, "rng_clk", rng_clk),
> > +     _REGISTER_CLOCK(NULL, "dcp_clk", dcp_clk),
> > +     _REGISTER_CLOCK(NULL, "ocotp_ctrl_apb", ocotp_clk),
> > +     _REGISTER_CLOCK(NULL, "ocram_clk", ocram_clk),
> > +     _REGISTER_CLOCK(NULL, "apbh_dma_clk", apbh_dma_clk),
> > +     _REGISTER_CLOCK(NULL, "sys_clk", sys_clk),
> > +     _REGISTER_CLOCK(NULL, "elcdif_pix", elcdif_pix_clk),
> > +     _REGISTER_CLOCK(NULL, "display_axi", display_axi_clk),
> > +     _REGISTER_CLOCK(NULL, "elcdif_axi", elcdif_axi_clk),
> > +     _REGISTER_CLOCK(NULL, "pxp_axi", pxp_axi_clk),
> > +     _REGISTER_CLOCK("mxc_epdc_fb", "epdc_axi", epdc_axi_clk),
> > +     _REGISTER_CLOCK("mxc_epdc_fb", "epdc_pix", epdc_pix_clk),
> > +     _REGISTER_CLOCK("ahbmux1", NULL, ahbmux1_clk),
> > +     _REGISTER_CLOCK("ipmux1", NULL, ipmux1_clk),
> > +     _REGISTER_CLOCK("ipmux2", NULL, ipmux2_clk),
> > +     _REGISTER_CLOCK("aips_tz1", NULL, aips_tz1_clk),
> > +     _REGISTER_CLOCK("pgc", NULL, pgc_clk),
> > +};
> > +
> > +static void clk_tree_init(void)
> > +{
> > +     u32 reg;
> > +
> > +     ipg_perclk.set_parent(&ipg_perclk, &lp_apm_clk);
> > +
> > +     /*
> > +      *Initialise the IPG PER CLK dividers to 3. IPG_PER_CLK should be at
> > +      * 8MHz, its derived from lp_apm.
> > +      */
> > +     reg = __raw_readl(MXC_CCM_CBCDR);
> > +     reg &= ~MXC_CCM_CBCDR_PERCLK_PRED1_MASK;
> > +     reg &= ~MXC_CCM_CBCDR_PERCLK_PRED2_MASK;
> > +     reg &= ~MXC_CCM_CBCDR_PERCLK_PODF_MASK;
> > +     reg |= (2 << MXC_CCM_CBCDR_PERCLK_PRED1_OFFSET);
> > +     __raw_writel(reg, MXC_CCM_CBCDR);
> > +
> > +     /* set pll1_main_clk parent */
> > +     pll1_main_clk.parent = &osc_clk;
> > +
> > +     /* set pll2_sw_clk parent */
> > +     pll2_sw_clk.parent = &osc_clk;
> > +
> > +     /* set pll3_clk parent */
> > +     pll3_sw_clk.parent = &osc_clk;
> > +
> > +     /* set weim_clk parent */
> > +     weim_clk[0].parent = &main_bus_clk;
> > +     reg = __raw_readl(MXC_CCM_CBCDR);
> > +     if ((reg & MXC_CCM_CBCDR_WEIM_CLK_SEL) != 0)
> > +             weim_clk[0].parent = &ahb_clk;
> > +
> > +     /* set ipg_perclk parent */
> > +     ipg_perclk.parent = &lp_apm_clk;
> > +     reg = __raw_readl(MXC_CCM_CBCMR);
> > +     if ((reg & MXC_CCM_CBCMR_PERCLK_IPG_CLK_SEL) != 0) {
> > +             ipg_perclk.parent = &ipg_clk;
> > +     } else {
> > +             if ((reg & MXC_CCM_CBCMR_PERCLK_LP_APM_CLK_SEL) == 0)
> > +                     ipg_perclk.parent = &main_bus_clk;
> > +     }
> > +}
> > +
> > +int __init mx50_clocks_init(unsigned long ckil, unsigned long osc,
> > +                             unsigned long ckih1)
> > +{
> > +     __iomem void *base;
> > +     int i = 0, reg;
> > +     pll1_base = MX50_IO_ADDRESS(MX50_PLL1_BASE_ADDR);
> > +     pll2_base = MX50_IO_ADDRESS(MX50_PLL1_BASE_ADDR);
> > +     pll3_base = MX50_IO_ADDRESS(MX50_PLL1_BASE_ADDR);
> > +     apll_base = ioremap(MX50_ANATOP_BASE_ADDR, SZ_4K);
> > +     if (unlikely(!apll_base)) {
> > +             printk(KERN_ERR "apll ioremap failed!\n");
> > +             BUG();
> > +     }
> > +
> > +     /* Turn off all possible clocks */
> > +     __raw_writel(1 << MXC_CCM_CCGRx_CG0_OFFSET |
> > +                   3 << MXC_CCM_CCGRx_CG3_OFFSET |
> > +                   3 << MXC_CCM_CCGRx_CG8_OFFSET |
> > +                   1 << MXC_CCM_CCGRx_CG12_OFFSET |
> > +                   1 << MXC_CCM_CCGRx_CG13_OFFSET |
> > +                   3 << MXC_CCM_CCGRx_CG14_OFFSET, MXC_CCM_CCGR0);
> > +
> > +     __raw_writel(0, MXC_CCM_CCGR1);
> > +     __raw_writel(0, MXC_CCM_CCGR2);
> > +     __raw_writel(0, MXC_CCM_CCGR3);
> > +     __raw_writel(0, MXC_CCM_CCGR4);
> > +
> > +     __raw_writel(3 << MXC_CCM_CCGRx_CG6_OFFSET |
> > +                  1 << MXC_CCM_CCGRx_CG8_OFFSET |
> > +                  3 << MXC_CCM_CCGRx_CG9_OFFSET, MXC_CCM_CCGR5);
> > +
> > +     __raw_writel(3 << MXC_CCM_CCGRx_CG0_OFFSET |
> > +                             3 << MXC_CCM_CCGRx_CG1_OFFSET |
> > +                             2 << MXC_CCM_CCGRx_CG14_OFFSET |
> > +                             3 << MXC_CCM_CCGRx_CG15_OFFSET, MXC_CCM_CCGR6);
> > +
> > +     __raw_writel(0, MXC_CCM_CCGR7);
> > +
> > +     external_low_reference = ckil;
> > +     external_high_reference = ckih1;
> > +     oscillator_reference = osc;
> > +
> > +     usb_phy_clk[0].enable_reg = MXC_CCM_CCGR4;
> > +     usb_phy_clk[0].enable_shift = MXC_CCM_CCGRx_CG5_OFFSET;
> > +
> > +     clk_tree_init();
> > +
> > +     for (i = 0; i < ARRAY_SIZE(lookups); i++)
> > +             clkdev_add(&lookups[i]);
> > +
> > +     /* set DDR clock parent */
> > +     reg = __raw_readl(MXC_CCM_CLK_DDR) &
> > +                             MXC_CCM_CLK_DDR_DDR_PFD_SEL;
> > +     if (reg)
> > +             clk_set_parent(&ddr_clk, &pfd0_clk);
> > +     else
> > +             clk_set_parent(&ddr_clk, &pll1_sw_clk);
> > +
> > +     clk_set_parent(&esdhc1_clk[0], &pll2_sw_clk);
> > +     clk_set_parent(&esdhc1_clk[2], &tmax2_clk);
> > +     clk_set_parent(&esdhc2_clk[0], &esdhc1_clk[0]);
> > +     clk_set_parent(&esdhc3_clk[0], &pll2_sw_clk);
> > +     clk_enable(&cpu_clk);
> > +
> > +     clk_enable(&main_bus_clk);
> > +
> > +     clk_enable(&ocotp_clk);
> > +
> > +     databahn = ioremap(MX50_DATABAHN_BASE_ADDR, SZ_16K);
> > +
> > +     /* Initialise the parents to be axi_b, parents are set to
> > +      * axi_a when the clocks are enabled.
> > +      */
> > +
> > +     clk_set_parent(&gpu2d_clk, &axi_a_clk);
> > +
> > +     /* move cspi to 24MHz */
> > +     clk_set_parent(&cspi_main_clk, &lp_apm_clk);
> > +     clk_set_rate(&cspi_main_clk, 12000000);
> > +
> > +     /*
> > +      * Set DISPLAY_AXI to 200Mhz
> > +      * For Display AXI, source clocks must be
> > +      * enabled before dividers can be changed
> > +      */
> > +     clk_enable(&display_axi_clk);
> > +     clk_enable(&elcdif_axi_clk);
> > +     clk_enable(&pxp_axi_clk);
> > +     clk_set_parent(&display_axi_clk, &pfd2_clk);
> > +     clk_set_rate(&display_axi_clk, 200000000);
> > +     clk_disable(&display_axi_clk);
> > +     clk_disable(&pxp_axi_clk);
> > +     clk_disable(&elcdif_axi_clk);
> > +
> > +     clk_enable(&elcdif_pix_clk);
> > +     clk_set_parent(&elcdif_pix_clk, &pll1_sw_clk);
> > +     clk_disable(&elcdif_pix_clk);
> > +
> > +     /*
> > +      * Enable and set EPDC AXI to 200MHz
> > +      * For EPDC AXI, source clocks must be
> > +      * enabled before dividers can be changed
> > +      */
> > +     clk_enable(&epdc_axi_clk);
> > +     clk_set_parent(&epdc_axi_clk, &pfd3_clk);
> > +     clk_set_rate(&epdc_axi_clk, 200000000);
> > +     clk_disable(&epdc_axi_clk);
> > +
> > +     clk_set_parent(&epdc_pix_clk, &pfd5_clk);
> > +
> > +     /* Move SSI clocks to SSI_LP_APM clock */
> > +     clk_set_parent(&ssi_lp_apm_clk, &lp_apm_clk);
> > +
> > +     clk_set_parent(&ssi1_clk[0], &ssi_lp_apm_clk);
> > +     /* set the SSI dividers to divide by 2 */
> > +     reg = __raw_readl(MXC_CCM_CS1CDR);
> > +     reg &= ~MXC_CCM_CS1CDR_SSI1_CLK_PODF_MASK;
> > +     reg &= ~MXC_CCM_CS1CDR_SSI1_CLK_PRED_MASK;
> > +     reg |= 1 << MXC_CCM_CS1CDR_SSI1_CLK_PRED_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CS1CDR);
> > +
> > +     clk_set_parent(&ssi2_clk[0], &ssi_lp_apm_clk);
> > +     reg = __raw_readl(MXC_CCM_CS2CDR);
> > +     reg &= ~MXC_CCM_CS2CDR_SSI2_CLK_PODF_MASK;
> > +     reg &= ~MXC_CCM_CS2CDR_SSI2_CLK_PRED_MASK;
> > +     reg |= 1 << MXC_CCM_CS2CDR_SSI2_CLK_PRED_OFFSET;
> > +     __raw_writel(reg, MXC_CCM_CS2CDR);
> > +
> > +     /* Change the SSI_EXT1_CLK to be sourced from SSI1_CLK_ROOT */
> > +     clk_set_parent(&ssi_ext1_clk, &ssi1_clk[0]);
> > +     clk_set_parent(&ssi_ext2_clk, &ssi2_clk[0]);
> > +
> > +     /* move usb_phy_clk to 24MHz */
> > +     clk_set_parent(&usb_phy_clk[0], &osc_clk);
> > +     clk_set_parent(&usb_phy_clk[1], &osc_clk);
> > +
> > +     /* move gpmi-nfc to 24MHz */
> > +     clk_set_parent(&gpmi_nfc_clk[0], &osc_clk);
> > +
> > +     /* set SDHC root clock as 200MHZ*/
> > +     clk_set_rate(&esdhc1_clk[0], 200000000);
> > +     clk_set_rate(&esdhc3_clk[0], 200000000);
> > +
> > +     clk_set_parent(&uart_main_clk, &lp_apm_clk);
> > +     clk_set_parent(&gpu2d_clk, &axi_b_clk);
> > +
> > +     clk_set_parent(&weim_clk[0], &ahb_clk);
> > +     clk_set_rate(&weim_clk[0], clk_round_rate(&weim_clk[0], 130000000));
> > +
> > +     base = MX50_IO_ADDRESS(MX50_GPT1_BASE_ADDR);
> > +     mxc_timer_init(&gpt_clk[0], base, MX50_INT_GPT);
> > +     return 0;
> > +}
> > diff --git a/arch/arm/mach-mx5/crm_regs-mx50.h b/arch/arm/mach-mx5/crm_regs-mx50.h
> > new file mode 100644
> > index 0000000..f57e93c
> > --- /dev/null
> > +++ b/arch/arm/mach-mx5/crm_regs-mx50.h
> > @@ -0,0 +1,607 @@
> > +/*
> > + * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> Does that mean GPL v1 may be applied or not?
Does it need to mention all GPL version? I saw other files have such header too.
> 
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +#ifndef __ARCH_ARM_MACH_MX5_CRM_REGS_MX50_H__
> > +#define __ARCH_ARM_MACH_MX5_CRM_REGS_MX50_H__
> > +
> > +#define MXC_CCM_BASE (MX50_IO_ADDRESS(MX50_CCM_BASE_ADDR))
> > +
> > +/* PLL Register Offsets */
> > +#define MXC_PLL_DP_CTL                       0x00
> > +#define MXC_PLL_DP_CONFIG            0x04
> > +#define MXC_PLL_DP_OP                        0x08
> > +#define MXC_PLL_DP_MFD                       0x0C
> > +#define MXC_PLL_DP_MFN                       0x10
> > +#define MXC_PLL_DP_MFNMINUS          0x14
> > +#define MXC_PLL_DP_MFNPLUS           0x18
> > +#define MXC_PLL_DP_HFS_OP            0x1C
> > +#define MXC_PLL_DP_HFS_MFD           0x20
> > +#define MXC_PLL_DP_HFS_MFN           0x24
> > +#define MXC_PLL_DP_MFN_TOGC          0x28
> > +#define MXC_PLL_DP_DESTAT            0x2c
> > +
> > +/* PLL Register Bit definitions */
> > +#define MXC_PLL_DP_CTL_MUL_CTRL              0x2000
> > +#define MXC_PLL_DP_CTL_DPDCK0_2_EN   0x1000
> > +#define MXC_PLL_DP_CTL_DPDCK0_2_OFFSET       12
> > +#define MXC_PLL_DP_CTL_ADE           0x800
> > +#define MXC_PLL_DP_CTL_REF_CLK_DIV   0x400
> > +#define MXC_PLL_DP_CTL_REF_CLK_SEL_MASK      (3 << 8)
> > +#define MXC_PLL_DP_CTL_REF_CLK_SEL_OFFSET    8
> > +#define MXC_PLL_DP_CTL_HFSM          0x80
> > +#define MXC_PLL_DP_CTL_PRE           0x40
> > +#define MXC_PLL_DP_CTL_UPEN          0x20
> > +#define MXC_PLL_DP_CTL_RST           0x10
> > +#define MXC_PLL_DP_CTL_RCP           0x8
> > +#define MXC_PLL_DP_CTL_PLM           0x4
> > +#define MXC_PLL_DP_CTL_BRM0          0x2
> > +#define MXC_PLL_DP_CTL_LRF           0x1
> > +
> > +#define MXC_PLL_DP_CONFIG_BIST               0x8
> > +#define MXC_PLL_DP_CONFIG_SJC_CE     0x4
> > +#define MXC_PLL_DP_CONFIG_AREN               0x2
> > +#define MXC_PLL_DP_CONFIG_LDREQ              0x1
> > +
> > +#define MXC_PLL_DP_OP_MFI_OFFSET     4
> > +#define MXC_PLL_DP_OP_MFI_MASK               (0xF << 4)
> > +#define MXC_PLL_DP_OP_PDF_OFFSET     0
> > +#define MXC_PLL_DP_OP_PDF_MASK               0xF
> > +
> > +#define MXC_PLL_DP_MFD_OFFSET                0
> > +#define MXC_PLL_DP_MFD_MASK          0x07FFFFFF
> > +
> > +#define MXC_PLL_DP_MFN_OFFSET                0x0
> > +#define MXC_PLL_DP_MFN_MASK          0x07FFFFFF
> > +
> > +#define MXC_PLL_DP_MFN_TOGC_TOG_DIS  (1 << 17)
> > +#define MXC_PLL_DP_MFN_TOGC_TOG_EN   (1 << 16)
> > +#define MXC_PLL_DP_MFN_TOGC_CNT_OFFSET       0x0
> > +#define MXC_PLL_DP_MFN_TOGC_CNT_MASK 0xFFFF
> > +
> > +#define MXC_PLL_DP_DESTAT_TOG_SEL    (1 << 31)
> > +#define MXC_PLL_DP_DESTAT_MFN                0x07FFFFFF
> > +
> > +/* Register addresses of apll and pfd*/
> > +#define MXC_ANADIG_FRAC0             0x10
> > +#define MXC_ANADIG_FRAC0_SET         0x14
> > +#define MXC_ANADIG_FRAC0_CLR         0x18
> > +#define MXC_ANADIG_FRAC1             0x20
> > +#define MXC_ANADIG_FRAC1_SET         0x24
> > +#define MXC_ANADIG_FRAC1_CLR         0x28
> > +#define MXC_ANADIG_MISC                      0x60
> > +#define MXC_ANADIG_MISC_SET          0x64
> > +#define MXC_ANADIG_MISC_CLR          0x68
> > +#define MXC_ANADIG_PLLCTRL           0x70
> > +#define MXC_ANADIG_PLLCTRL_SET               0x74
> > +#define MXC_ANADIG_PLLCTRL_CLR               0x78
> > +
> > +/* apll and pfd Register Bit definitions */
> > +
> > +#define MXC_ANADIG_PFD3_CLKGATE              (1 << 31)
> > +#define MXC_ANADIG_PFD3_STABLE               (1 << 30)
> > +#define MXC_ANADIG_PFD3_FRAC_OFFSET  24
> > +#define MXC_ANADIG_PFD_FRAC_MASK     0x3F
> > +#define MXC_ANADIG_PFD2_CLKGATE              (1 << 23)
> > +#define MXC_ANADIG_PFD2_STABLE               (1 << 22)
> > +#define MXC_ANADIG_PFD2_FRAC_OFFSET  16
> > +#define MXC_ANADIG_PFD1_CLKGATE              (1 << 15)
> > +#define MXC_ANADIG_PFD1_STABLE               (1 << 14)
> > +#define MXC_ANADIG_PFD1_FRAC_OFFSET  8
> > +#define MXC_ANADIG_PFD0_CLKGATE              (1 << 7)
> > +#define MXC_ANADIG_PFD0_STABLE               (1 << 6)
> > +#define MXC_ANADIG_PFD0_FRAC_OFFSET  0
> > +
> > +#define MXC_ANADIG_PFD7_CLKGATE              (1 << 31)
> > +#define MXC_ANADIG_PFD7_STABLE               (1 << 30)
> > +#define MXC_ANADIG_PFD7_FRAC_OFFSET  24
> > +#define MXC_ANADIG_PFD6_CLKGATE              (1 << 23)
> > +#define MXC_ANADIG_PFD6_STABLE               (1 << 22)
> > +#define MXC_ANADIG_PFD6_FRAC_OFFSET  16
> > +#define MXC_ANADIG_PFD5_CLKGATE              (1 << 15)
> > +#define MXC_ANADIG_PFD5_STABLE               (1 << 14)
> > +#define MXC_ANADIG_PFD5_FRAC_OFFSET  8
> > +#define MXC_ANADIG_PFD4_CLKGATE              (1 << 7)
> > +#define MXC_ANADIG_PFD4_STABLE               (1 << 6)
> > +#define MXC_ANADIG_PFD4_FRAC_OFFSET  0
> > +
> > +#define MXC_ANADIG_APLL_LOCK         (1 << 31)
> > +#define MXC_ANADIG_APLL_FORCE_LOCK   (1 << 30)
> > +#define MXC_ANADIG_PFD_DIS_OFFSET    16
> > +#define MXC_ANADIG_PFD_DIS_MASK              0xff
> > +#define MXC_ANADIG_APLL_LOCK_CNT_OFFSET      0
> > +#define MXC_ANADIG_APLL_LOCK_CNT_MASK        0xffff
> > +
> > +/* Register addresses of CCM*/
> > +#define MXC_CCM_CCR          (MXC_CCM_BASE + 0x00)
> > +#define MXC_CCM_CCDR         (MXC_CCM_BASE + 0x04)
> > +#define MXC_CCM_CSR          (MXC_CCM_BASE + 0x08)
> > +#define MXC_CCM_CCSR         (MXC_CCM_BASE + 0x0C)
> > +#define MXC_CCM_CACRR                (MXC_CCM_BASE + 0x10)
> > +#define MXC_CCM_CBCDR                (MXC_CCM_BASE + 0x14)
> > +#define MXC_CCM_CBCMR                (MXC_CCM_BASE + 0x18)
> > +#define MXC_CCM_CSCMR1               (MXC_CCM_BASE + 0x1C)
> > +#define MXC_CCM_CSCMR2               (MXC_CCM_BASE + 0x20)
> > +#define MXC_CCM_CSCDR1               (MXC_CCM_BASE + 0x24)
> > +#define MXC_CCM_CS1CDR               (MXC_CCM_BASE + 0x28)
> > +#define MXC_CCM_CS2CDR               (MXC_CCM_BASE + 0x2C)
> > +#define MXC_CCM_CDCDR                (MXC_CCM_BASE + 0x30)
> > +#define MXC_CCM_CHSCDR               (MXC_CCM_BASE + 0x34)
> > +#define MXC_CCM_CSCDR2               (MXC_CCM_BASE + 0x38)
> > +#define MXC_CCM_CSCDR3               (MXC_CCM_BASE + 0x3C)
> > +#define MXC_CCM_CSCDR4               (MXC_CCM_BASE + 0x40)
> > +#define MXC_CCM_CWDR         (MXC_CCM_BASE + 0x44)
> > +#define MXC_CCM_CDHIPR               (MXC_CCM_BASE + 0x48)
> > +#define MXC_CCM_CDCR         (MXC_CCM_BASE + 0x4C)
> > +#define MXC_CCM_CTOR         (MXC_CCM_BASE + 0x50)
> > +#define MXC_CCM_CLPCR                (MXC_CCM_BASE + 0x54)
> > +#define MXC_CCM_CISR         (MXC_CCM_BASE + 0x58)
> > +#define MXC_CCM_CIMR         (MXC_CCM_BASE + 0x5C)
> > +#define MXC_CCM_CCOSR                (MXC_CCM_BASE + 0x60)
> > +#define MXC_CCM_CGPR         (MXC_CCM_BASE + 0x64)
> > +#define MXC_CCM_CCGR0                (MXC_CCM_BASE + 0x68)
> > +#define MXC_CCM_CCGR1                (MXC_CCM_BASE + 0x6C)
> > +#define MXC_CCM_CCGR2                (MXC_CCM_BASE + 0x70)
> > +#define MXC_CCM_CCGR3                (MXC_CCM_BASE + 0x74)
> > +#define MXC_CCM_CCGR4                (MXC_CCM_BASE + 0x78)
> > +#define MXC_CCM_CCGR5                (MXC_CCM_BASE + 0x7C)
> > +#define MXC_CCM_CCGR6                (MXC_CCM_BASE + 0x80)
> > +#define MXC_CCM_CCGR7                (MXC_CCM_BASE + 0x84)
> > +#define MXC_CCM_CMEOR                (MXC_CCM_BASE + 0x88)
> > +#define MXC_CCM_CSR2         (MXC_CCM_BASE + 0x8C)
> > +#define MXC_CCM_CLKSEQ_BYPASS        (MXC_CCM_BASE + 0x90)
> > +#define MXC_CCM_CLK_SYS              (MXC_CCM_BASE + 0x94)
> > +#define MXC_CCM_CLK_DDR              (MXC_CCM_BASE + 0x98)
> > +#define MXC_CCM_ELCDIFPIX    (MXC_CCM_BASE + 0x9C)
> > +#define MXC_CCM_EPDCPIX              (MXC_CCM_BASE + 0xA0)
> > +#define MXC_CCM_DISPLAY_AXI  (MXC_CCM_BASE + 0xA4)
> > +#define MXC_CCM_EPDC_AXI     (MXC_CCM_BASE + 0xA8)
> > +#define MXC_CCM_GPMI         (MXC_CCM_BASE + 0xAC)
> > +#define MXC_CCM_BCH          (MXC_CCM_BASE + 0xB0)
> > +#define MXC_CCM_MSHC_XMSCKI  (MXC_CCM_BASE + 0xB4)
> > +
> > +/* CCM Register Offsets. */
> > +#define MXC_CCM_CDCR_OFFSET          0x4C
> > +#define MXC_CCM_CACRR_OFFSET         0x10
> > +#define MXC_CCM_CDHIPR_OFFSET        0x48
> > +
> > +/* Define the bits in register CCR */
> > +#define MXC_CCM_CCR_COSC_EN          (1 << 12)
> > +#define MXC_CCM_CCR_CAMP1_EN         (1 << 9)
> > +#define MXC_CCM_CCR_OSCNT_OFFSET     (0)
> > +#define MXC_CCM_CCR_OSCNT_MASK       (0xFF)
> > +
> > +/* Define the bits in register CSR */
> > +#define MXC_CCM_CSR_COSR_READY       (1 << 5)
> > +#define MXC_CCM_CSR_LVS_VALUE                (1 << 4)
> > +#define MXC_CCM_CSR_CAMP1_READY      (1 << 2)
> > +#define MXC_CCM_CSR_TEMP_MON_ALARM   (1 << 1)
> > +#define MXC_CCM_CSR_REF_EN_B         (1 << 0)
> > +
> > +/* Define the bits in register CCSR */
> > +#define MXC_CCM_CCSR_PLL3_PFD_EN             (0x1 << 13)
> > +#define MXC_CCM_CCSR_PLL2_PFD_EN             (0x1 << 12)
> > +#define MXC_CCM_CCSR_PLL1_PFD_EN             (0x1 << 11)
> > +#define MXC_CCM_CCSR_LP_APM_SEL                      (0x1 << 10)
> > +#define MXC_CCM_CCSR_STEP_SEL_OFFSET         (7)
> > +#define MXC_CCM_CCSR_STEP_SEL_MASK           (0x3 << 7)
> > +#define MXC_CCM_CCSR_STEP_SEL_LP_APM    0
> > +#define MXC_CCM_CCSR_STEP_SEL_PLL1_BYPASS  1 /* Only when JTAG connected? */
> > +#define MXC_CCM_CCSR_STEP_SEL_PLL2_DIVIDED 2
> > +#define MXC_CCM_CCSR_STEP_SEL_PLL3_DIVIDED 3
> > +#define MXC_CCM_CCSR_PLL2_PODF_OFFSET        (5)
> > +#define MXC_CCM_CCSR_PLL2_PODF_MASK          (0x3 << 5)
> > +#define MXC_CCM_CCSR_PLL3_PODF_OFFSET        (3)
> > +#define MXC_CCM_CCSR_PLL3_PODF_MASK          (0x3 << 3)
> > +#define MXC_CCM_CCSR_PLL1_SW_CLK_SEL (1 << 2) /* 0: pll1_main_clk,
> > +                                                 1: step_clk */
> > +#define MXC_CCM_CCSR_PLL2_SW_CLK_SEL         (1 << 1)
> > +#define MXC_CCM_CCSR_PLL3_SW_CLK_SEL         (1 << 0)
> > +
> > +/* Define the bits in register CACRR */
> > +#define MXC_CCM_CACRR_ARM_PODF_OFFSET        (0)
> > +#define MXC_CCM_CACRR_ARM_PODF_MASK          (0x7)
> > +
> > +/* Define the bits in register CBCDR */
> > +#define MXC_CCM_CBCDR_WEIM_CLK_SEL           (0x1 << 27)
> > +#define MXC_CCM_CBCDR_PERIPH_CLK_SEL_OFFSET  (25)
> > +#define MXC_CCM_CBCDR_PERIPH_CLK_SEL_MASK    (0x3 << 25)
> > +#define MXC_CCM_CBCDR_WEIM_PODF_OFFSET       (22)
> > +#define MXC_CCM_CBCDR_WEIM_PODF_MASK         (0x7 << 22)
> > +#define MXC_CCM_CBCDR_AXI_B_PODF_OFFSET              (19)
> > +#define MXC_CCM_CBCDR_AXI_B_PODF_MASK                (0x7 << 19)
> > +#define MXC_CCM_CBCDR_AXI_A_PODF_OFFSET              (16)
> > +#define MXC_CCM_CBCDR_AXI_A_PODF_MASK                (0x7 << 16)
> > +#define MXC_CCM_CBCDR_AHB_PODF_OFFSET                (10)
> > +#define MXC_CCM_CBCDR_AHB_PODF_MASK                  (0x7 << 10)
> > +#define MXC_CCM_CBCDR_IPG_PODF_OFFSET                (8)
> > +#define MXC_CCM_CBCDR_IPG_PODF_MASK                  (0x3 << 8)
> > +#define MXC_CCM_CBCDR_PERCLK_PRED1_OFFSET            (6)
> > +#define MXC_CCM_CBCDR_PERCLK_PRED1_MASK              (0x3 << 6)
> > +#define MXC_CCM_CBCDR_PERCLK_PRED2_OFFSET            (3)
> > +#define MXC_CCM_CBCDR_PERCLK_PRED2_MASK              (0x7 << 3)
> > +#define MXC_CCM_CBCDR_PERCLK_PODF_OFFSET             (0)
> > +#define MXC_CCM_CBCDR_PERCLK_PODF_MASK               (0x7)
> > +
> > +/* Define the bits in register CBCMR */
> > +#define MXC_CCM_CBCMR_GPU2D_CLK_SEL_OFFSET           (16)
> > +#define MXC_CCM_CBCMR_GPU2D_CLK_SEL_MASK             (0x3 << 16)
> > +#define MXC_CCM_CBCMR_DBG_APB_CLK_SEL_OFFSET (2)
> > +#define MXC_CCM_CBCMR_DBG_APB_CLK_SEL_MASK   (0x3 << 2)
> > +#define MXC_CCM_CBCMR_PERCLK_LP_APM_CLK_SEL          (0x1 << 1)
> > +#define MXC_CCM_CBCMR_PERCLK_IPG_CLK_SEL             (0x1 << 0)
> > +
> > +/* Define the bits in register CSCMR1 */
> > +#define MXC_CCM_CSCMR1_SSI_EXT2_CLK_SEL_OFFSET               (30)
> > +#define MXC_CCM_CSCMR1_SSI_EXT2_CLK_SEL_MASK         (0x3 << 30)
> > +#define MXC_CCM_CSCMR1_SSI_EXT1_CLK_SEL_OFFSET               (28)
> > +#define MXC_CCM_CSCMR1_SSI_EXT1_CLK_SEL_MASK         (0x3 << 28)
> > +#define MXC_CCM_CSCMR1_UART_CLK_SEL_OFFSET                   (24)
> > +#define MXC_CCM_CSCMR1_UART_CLK_SEL_MASK                     (0x3 << 24)
> > +#define MXC_CCM_CSCMR1_ESDHC1_CLK_SEL_OFFSET (21)
> > +#define MXC_CCM_CSCMR1_ESDHC1_CLK_SEL_MASK   (0x3 << 21)
> > +#define MXC_CCM_CSCMR1_ESDHC2_CLK_SEL                        (0x1 << 20)
> > +#define MXC_CCM_CSCMR1_ESDHC4_CLK_SEL                        (0x1 << 19)
> > +#define MXC_CCM_CSCMR1_ESDHC3_CLK_SEL_OFFSET (16)
> > +#define MXC_CCM_CSCMR1_ESDHC3_CLK_SEL_MASK           (0x7 << 16)
> > +#define MXC_CCM_CSCMR1_SSI1_CLK_SEL_OFFSET                   (14)
> > +#define MXC_CCM_CSCMR1_SSI1_CLK_SEL_MASK                     (0x3 << 14)
> > +#define MXC_CCM_CSCMR1_SSI2_CLK_SEL_OFFSET                   (12)
> > +#define MXC_CCM_CSCMR1_SSI2_CLK_SEL_MASK                     (0x3 << 12)
> > +#define MXC_CCM_CSCMR1_SSI_APM_CLK_SEL               (0x1 << 8)
> > +#define MXC_CCM_CSCMR1_CSPI_CLK_SEL_OFFSET                   (4)
> > +#define MXC_CCM_CSCMR1_CSPI_CLK_SEL_MASK                     (0x3 << 4)
> > +#define MXC_CCM_CSCMR1_SSI_EXT2_COM_CLK_SEL                  (0x1 << 1)
> > +#define MXC_CCM_CSCMR1_SSI_EXT1_COM_CLK_SEL                  (0x1)
> > +
> > +/* Define the bits in register CSCDR1 */
> > +#define MXC_CCM_CSCDR1_ESDHC3_MSHC2_CLK_PRED_OFFSET  (22)
> > +#define MXC_CCM_CSCDR1_ESDHC3_MSHC2_CLK_PRED_MASK            (0x7 << 22)
> > +#define MXC_CCM_CSCDR1_ESDHC3_MSHC2_CLK_PODF_OFFSET  (19)
> > +#define MXC_CCM_CSCDR1_ESDHC3_MSHC2_CLK_PODF_MASK            (0x7 << 19)
> > +#define MXC_CCM_CSCDR1_ESDHC1_MSHC2_CLK_PRED_OFFSET  (16)
> > +#define MXC_CCM_CSCDR1_ESDHC1_MSHC2_CLK_PRED_MASK    (0x7 << 16)
> > +#define MXC_CCM_CSCDR1_PGC_CLK_PODF_OFFSET                   (14)
> > +#define MXC_CCM_CSCDR1_PGC_CLK_PODF_MASK                     (0x3 << 14)
> > +#define MXC_CCM_CSCDR1_ESDHC1_MSHC2_CLK_PODF_OFFSET  (11)
> > +#define MXC_CCM_CSCDR1_ESDHC1_MSHC2_CLK_PODF_MASK    (0x7 << 11)
> > +#define MXC_CCM_CSCDR1_UART_CLK_PRED_OFFSET          (3)
> > +#define MXC_CCM_CSCDR1_UART_CLK_PRED_MASK                    (0x7 << 3)
> > +#define MXC_CCM_CSCDR1_UART_CLK_PODF_OFFSET          (0)
> > +#define MXC_CCM_CSCDR1_UART_CLK_PODF_MASK                    (0x7)
> > +
> > +/* Define the bits in register CS1CDR and CS2CDR */
> > +#define MXC_CCM_CS1CDR_SSI_EXT1_CLK_PRED_OFFSET      (22)
> > +#define MXC_CCM_CS1CDR_SSI_EXT1_CLK_PRED_MASK        (0x7 << 22)
> > +#define MXC_CCM_CS1CDR_SSI_EXT1_CLK_PODF_OFFSET      (16)
> > +#define MXC_CCM_CS1CDR_SSI_EXT1_CLK_PODF_MASK        (0x3F << 16)
> > +#define MXC_CCM_CS1CDR_SSI1_CLK_PRED_OFFSET          (6)
> > +#define MXC_CCM_CS1CDR_SSI1_CLK_PRED_MASK            (0x7 << 6)
> > +#define MXC_CCM_CS1CDR_SSI1_CLK_PODF_OFFSET          (0)
> > +#define MXC_CCM_CS1CDR_SSI1_CLK_PODF_MASK            (0x3F)
> > +
> > +#define MXC_CCM_CS2CDR_SSI_EXT2_CLK_PRED_OFFSET      (22)
> > +#define MXC_CCM_CS2CDR_SSI_EXT2_CLK_PRED_MASK        (0x7 << 22)
> > +#define MXC_CCM_CS2CDR_SSI_EXT2_CLK_PODF_OFFSET      (16)
> > +#define MXC_CCM_CS2CDR_SSI_EXT2_CLK_PODF_MASK        (0x3F << 16)
> > +#define MXC_CCM_CS2CDR_SSI2_CLK_PRED_OFFSET          (6)
> > +#define MXC_CCM_CS2CDR_SSI2_CLK_PRED_MASK            (0x7 << 6)
> > +#define MXC_CCM_CS2CDR_SSI2_CLK_PODF_OFFSET          (0)
> > +#define MXC_CCM_CS2CDR_SSI2_CLK_PODF_MASK            (0x3F)
> > +
> > +/* Define the bits in register CSCDR2 */
> > +#define MXC_CCM_CSCDR2_CSPI_CLK_PRED_OFFSET          (25)
> > +#define MXC_CCM_CSCDR2_CSPI_CLK_PRED_MASK            (0x7 << 25)
> > +#define MXC_CCM_CSCDR2_CSPI_CLK_PODF_OFFSET          (19)
> > +#define MXC_CCM_CSCDR2_CSPI_CLK_PODF_MASK            (0x3F << 19)
> > +
> > +/* Define the bits in register CDHIPR */
> > +#define MXC_CCM_CDHIPR_ARM_PODF_BUSY                 (1 << 16)
> > +#define MXC_CCM_CDHIPR_WEIM_CLK_SEL_BUSY             (1 << 6)
> > +#define MXC_CCM_CDHIPR_PERIPH_CLK_SEL_BUSY           (1 << 5)
> > +#define MXC_CCM_CDHIPR_AHB_PODF_BUSY                 (1 << 3)
> > +#define MXC_CCM_CDHIPR_WEIM_PODF_BUSY                        (1 << 2)
> > +#define MXC_CCM_CDHIPR_AXI_B_PODF_BUSY                       (1 << 1)
> > +#define MXC_CCM_CDHIPR_AXI_A_PODF_BUSY                       (1 << 0)
> > +
> > +/* Define the bits in register CDCR */
> > +#define MX50_CCM_CDCR_SW_PERIPH_CLK_DIV_REQ_STATUS   (0x1 << 7)
> > +#define MX50_CCM_CDCR_SW_PERIPH_CLK_DIV_REQ          (0x1 << 6)
> > +#define MX50_CCM_CDCR_SW_DVFS_EN                             (0x1 << 5)
> > +#define MXC_CCM_CDCR_ARM_FREQ_SHIFT_DIVIDER                  (0x1 << 2)
> > +#define MXC_CCM_CDCR_PERIPH_CLK_DVFS_PODF_OFFSET             (0)
> > +#define MXC_CCM_CDCR_PERIPH_CLK_DVFS_PODF_MASK               (0x3)
> > +
> > +/* Define the bits in register CLPCR */
> > +#define MXC_CCM_CLPCR_BYPASS_MAX_LPM_HS                      (0x1 << 25)
> > +#define MXC_CCM_CLPCR_BYPASS_SDMA_LPM_HS                     (0x1 << 24)
> > +#define MX50_CCM_CLPCR_BYPASS_RNGB_LPM_HS            (0x1 << 23)
> > +#define MXC_CCM_CLPCR_BYPASS_WEIM_LPM_HS             (0x1 << 19)
> > +#define MXC_CCM_CLPCR_COSC_PWRDOWN                   (0x1 << 11)
> > +#define MXC_CCM_CLPCR_STBY_COUNT_OFFSET              (9)
> > +#define MXC_CCM_CLPCR_STBY_COUNT_MASK                (0x3 << 9)
> > +#define MXC_CCM_CLPCR_VSTBY                          (0x1 << 8)
> > +#define MXC_CCM_CLPCR_DIS_REF_OSC                    (0x1 << 7)
> > +#define MXC_CCM_CLPCR_SBYOS                          (0x1 << 6)
> > +#define MXC_CCM_CLPCR_ARM_CLK_DIS_ON_LPM             (0x1 << 5)
> > +#define MXC_CCM_CLPCR_BYPASS_PMIC_VFUNC_READY                (0x1 << 2)
> > +#define MXC_CCM_CLPCR_LPM_OFFSET                     (0)
> > +#define MXC_CCM_CLPCR_LPM_MASK                       (0x3)
> > +
> > +/* Define the bits in register CISR */
> > +#define MXC_CCM_CISR_ARM_PODF_LOADED         (0x1 << 26)
> > +#define MXC_CCM_CISR_TEMP_MON_ALARM                          (0x1 << 25)
> > +#define MXC_CCM_CISR_WEIM_CLK_SEL_LOADED                     (0x1 << 23)
> > +#define MXC_CCM_CISR_PER_CLK_SEL_LOADED                      (0x1 << 22)
> > +#define MXC_CCM_CISR_AHB_PODF_LOADED                 (0x1 << 20)
> > +#define MXC_CCM_CISR_WEIM_PODF_LOADED                                (0x1 << 19)
> > +#define MXC_CCM_CISR_AXI_B_PODF_LOADED                       (0x1 << 18)
> > +#define MXC_CCM_CISR_AXI_A_PODF_LOADED                       (0x1 << 17)
> > +#define MXC_CCM_CISR_DIVIDER_LOADED                          (0x1 << 16)
> > +#define MXC_CCM_CISR_COSC_READY                              (0x1 << 6)
> > +#define MXC_CCM_CISR_CKIH2_READY                             (0x1 << 5)
> > +#define MXC_CCM_CISR_CAMP1_READY                     (0x1 << 4)
> > +#define MXC_CCM_CISR_LRF_PLL3                                        (0x1 << 2)
> > +#define MXC_CCM_CISR_LRF_PLL2                                        (0x1 << 1)
> > +#define MXC_CCM_CISR_LRF_PLL1                                        (0x1)
> > +
> > +/* Define the bits in register CIMR */
> > +#define MXC_CCM_CIMR_MASK_ARM_PODF_LOADED            (0x1 << 26)
> > +#define MXC_CCM_CIMR_MASK_TEMP_MON_ALARM             (0x1 << 25)
> > +#define MXC_CCM_CIMR_MASK_WEIM_CLK_SEL_LOADED                (0x1 << 23)
> > +#define MXC_CCM_CIMR_MASK_PER_CLK_SEL_LOADED         (0x1 << 22)
> > +#define MXC_CCM_CIMR_MASK_AHB_PODF_LOADED            (0x1 << 20)
> > +#define MXC_CCM_CIMR_MASK_WEIM_PODF_LOADED           (0x1 << 19)
> > +#define MXC_CCM_CIMR_MASK_AXI_B_PODF_LOADED          (0x1 << 18)
> > +#define MXC_CCM_CIMR_MASK_AXI_A_PODF_LOADED          (0x1 << 17)
> > +#define MXC_CCM_CIMR_MASK_DIVIDER_LOADED             (0x1 << 16)
> > +#define MXC_CCM_CIMR_MASK_COSC_READY                 (0x1 << 6)
> > +#define MXC_CCM_CIMR_MASK_CAMP1_READY                        (0x1 << 4)
> > +#define MXC_CCM_CIMR_MASK_LRF_PLL3                   (0x1 << 2)
> > +#define MXC_CCM_CIMR_MASK_LRF_PLL2                   (0x1 << 1)
> > +#define MXC_CCM_CIMR_MASK_LRF_PLL1                   (0x1)
> > +
> > +/* Define the bits in register CCOSR */
> > +#define MXC_CCM_CCOSR_CKO2_EN_OFFSET                 (0x1 << 24)
> > +#define MXC_CCM_CCOSR_CKO2_DIV_OFFSET                        (21)
> > +#define MXC_CCM_CCOSR_CKO2_DIV_MASK                  (0x7 << 21)
> > +#define MXC_CCM_CCOSR_CKO2_SEL_OFFSET                        (16)
> > +#define MXC_CCM_CCOSR_CKO2_SEL_MASK                  (0x1F << 16)
> > +#define MXC_CCM_CCOSR_CKO1_SLOW_SEL                  (0x1 << 8)
> > +#define MXC_CCM_CCOSR_CKO1_EN                                (0x1 << 7)
> > +#define MXC_CCM_CCOSR_CKO1_DIV_OFFSET                        (4)
> > +#define MXC_CCM_CCOSR_CKO1_DIV_MASK                  (0x7 << 4)
> > +#define MXC_CCM_CCOSR_CKO1_SEL_OFFSET                        (0)
> > +#define MXC_CCM_CCOSR_CKO1_SEL_MASK                  (0xF)
> > +
> > +/* Define the bits in registers CCGRx */
> > +#define MXC_CCM_CCGRx_CG_MASK                                0x3
> > +#define MXC_CCM_CCGRx_MOD_OFF                                0x0
> > +#define MXC_CCM_CCGRx_MOD_ON                         0x3
> > +#define MXC_CCM_CCGRx_MOD_IDLE                               0x1
> > +
> > +#define MXC_CCM_CCGRx_CG15_MASK                              (0x3 << 30)
> > +#define MXC_CCM_CCGRx_CG14_MASK                              (0x3 << 28)
> > +#define MXC_CCM_CCGRx_CG13_MASK                              (0x3 << 26)
> > +#define MXC_CCM_CCGRx_CG12_MASK                              (0x3 << 24)
> > +#define MXC_CCM_CCGRx_CG11_MASK                              (0x3 << 22)
> > +#define MXC_CCM_CCGRx_CG10_MASK                              (0x3 << 20)
> > +#define MXC_CCM_CCGRx_CG9_MASK                               (0x3 << 18)
> > +#define MXC_CCM_CCGRx_CG8_MASK                               (0x3 << 16)
> > +#define MXC_CCM_CCGRx_CG5_MASK                               (0x3 << 10)
> > +#define MXC_CCM_CCGRx_CG4_MASK                               (0x3 << 8)
> > +#define MXC_CCM_CCGRx_CG3_MASK                               (0x3 << 6)
> > +#define MXC_CCM_CCGRx_CG2_MASK                               (0x3 << 4)
> > +#define MXC_CCM_CCGRx_CG1_MASK                               (0x3 << 2)
> > +#define MXC_CCM_CCGRx_CG0_MASK                               (0x3 << 0)
> > +
> > +#define MXC_CCM_CCGRx_CG15_OFFSET                    30
> > +#define MXC_CCM_CCGRx_CG14_OFFSET                    28
> > +#define MXC_CCM_CCGRx_CG13_OFFSET                    26
> > +#define MXC_CCM_CCGRx_CG12_OFFSET                    24
> > +#define MXC_CCM_CCGRx_CG11_OFFSET                    22
> > +#define MXC_CCM_CCGRx_CG10_OFFSET                    20
> > +#define MXC_CCM_CCGRx_CG9_OFFSET                     18
> > +#define MXC_CCM_CCGRx_CG8_OFFSET                     16
> > +#define MXC_CCM_CCGRx_CG7_OFFSET                     14
> > +#define MXC_CCM_CCGRx_CG6_OFFSET                     12
> > +#define MXC_CCM_CCGRx_CG5_OFFSET                     10
> > +#define MXC_CCM_CCGRx_CG4_OFFSET                     8
> > +#define MXC_CCM_CCGRx_CG3_OFFSET                     6
> > +#define MXC_CCM_CCGRx_CG2_OFFSET                     4
> > +#define MXC_CCM_CCGRx_CG1_OFFSET                     2
> > +#define MXC_CCM_CCGRx_CG0_OFFSET                     0
> > +
> > +#define MXC_CCM_CCGR5_CG6_1_OFFSET                   12
> > +#define MXC_CCM_CCGR5_CG6_2_OFFSET                   13
> > +
> > +/* Define the bits in registers CSR2  */
> > +#define MXC_CCM_CSR2_ELCDIF_PIX_BUSY                 (0x1 << 9)
> > +#define MXC_CCM_CSR2_EPDC_PIX_BUSY                   (0x1 << 8)
> > +#define MXC_CCM_CSR2_EPDC_AXI_BUSY                   (0x1 << 4)
> > +#define MXC_CCM_CSR2_DISPLAY_AXI_BUSY                        (0x1 << 3)
> > +
> > +/* Define the bits in registers CLKSEQ_BYPASS  */
> > +#define MXC_CCM_CLKSEQ_BYPASS_BYPASS_ELCDIF_PIX_CLK_SEL_OFFSET       14
> > +#define MXC_CCM_CLKSEQ_BYPASS_BYPASS_ELCDIF_PIX_CLK_SEL_MASK (0x3 << 14)
> > +#define MXC_CCM_CLKSEQ_BYPASS_BYPASS_EPDC_PIX_CLK_SEL_OFFSET 12
> > +#define MXC_CCM_CLKSEQ_BYPASS_BYPASS_EPDC_PIX_CLK_SEL_MASK   (0x3 << 12)
> > +#define MXC_CCM_CLKSEQ_BYPASS_BYPASS_GPMI_CLK_SEL_OFFSET     6
> > +#define MXC_CCM_CLKSEQ_BYPASS_BYPASS_GPMI_CLK_SEL_MASK               (0x3 << 6)
> > +#define MXC_CCM_CLKSEQ_BYPASS_BYPASS_EPDC_AXI_CLK_SEL_OFFSET 4
> > +#define MXC_CCM_CLKSEQ_BYPASS_BYPASS_EPDC_AXI_CLK_SEL_MASK   (0x3 << 4)
> > +#define MXC_CCM_CLKSEQ_BYPASS_BYPASS_DISPLAY_AXI_CLK_SEL_OFFSET      2
> > +#define MXC_CCM_CLKSEQ_BYPASS_BYPASS_DISPLAY_AXI_CLK_SEL_MASK        (0x3 << 2)
> > +
> > +/* Define the bits in registers CLK_SYS */
> > +#define MXC_CCM_CLK_SYS_SYS_XTAL_CLKGATE_OFFSET      (30)
> > +#define MXC_CCM_CLK_SYS_SYS_XTAL_CLKGATE_MASK        (0x3 << 30)
> > +#define MXC_CCM_CLK_SYS_SYS_PLL_CLKGATE_OFFSET               (28)
> > +#define MXC_CCM_CLK_SYS_SYS_PLL_CLKGATE_MASK (0x3 << 28)
> > +#define MXC_CCM_CLK_SYS_DIV_XTAL_OFFSET                      (6)
> > +#define MXC_CCM_CLK_SYS_DIV_XTAL_MASK                        (0xF << 6)
> > +#define MXC_CCM_CLK_SYS_DIV_PLL_OFFSET                       (0)
> > +#define MXC_CCM_CLK_SYS_DIV_PLL_MASK                         (0x3F)
> > +
> > +/* Define the bits in registers CLK_DDR */
> > +#define MXC_CCM_CLK_DDR_DDR_CLKGATE_OFFSET   (30)
> > +#define MXC_CCM_CLK_DDR_DDR_CLKGATE_MASK     (0x3 << 30)
> > +#define MXC_CCM_CLK_DDR_DDR_PFD_SEL          (1 << 6)
> > +#define MXC_CCM_CLK_DDR_DDR_DIV_PLL_OFFSET   (0)
> > +#define MXC_CCM_CLK_DDR_DDR_DIV_PLL_MASK     (0x3F)
> > +
> > +/* Define the bits in register DISPLAY_AXI */
> > +#define MXC_CCM_DISPLAY_AXI_CLKGATE_OFFSET   (30)
> > +#define MXC_CCM_DISPLAY_AXI_CLKGATE_MASK     (0x3 << 30)
> > +#define MXC_CCM_DISPLAY_AXI_DIV_OFFSET               (0)
> > +#define MXC_CCM_DISPLAY_AXI_DIV_MASK         (0x3F)
> > +
> > +/* Define the bits in register EPDC_AXI */
> > +#define MXC_CCM_EPDC_AXI_CLKGATE_OFFSET      (30)
> > +#define MXC_CCM_EPDC_AXI_CLKGATE_MASK        (0x3 << 30)
> > +#define MXC_CCM_EPDC_AXI_DIV_OFFSET          (0)
> > +#define MXC_CCM_EPDC_AXI_DIV_MASK            (0x3F)
> > +
> > +/* Define the bits in register EPDCPIX */
> > +#define MXC_CCM_EPDC_PIX_CLKGATE_OFFSET              (30)
> > +#define MXC_CCM_EPDC_PIX_CLKGATE_MASK                (0x3 << 30)
> > +#define MXC_CCM_EPDC_PIX_CLK_PRED_OFFSET     (12)
> > +#define MXC_CCM_EPDC_PIX_CLK_PRED_MASK               (0x3 << 12)
> > +#define MXC_CCM_EPDC_PIX_CLK_PODF_OFFSET     (0)
> > +#define MXC_CCM_EPDC_PIX_CLK_PODF_MASK               (0xFFF)
> > +
> > +/* Define the bits in register ELCDIFPIX */
> > +#define MXC_CCM_ELCDIFPIX_CLKGATE_OFFSET     (30)
> > +#define MXC_CCM_ELCDIFPIX_CLKGATE_MASK               (0x3 << 30)
> > +#define MXC_CCM_ELCDIFPIX_CLK_PRED_OFFSET    (12)
> > +#define MXC_CCM_ELCDIFPIX_CLK_PRED_MASK              (0x3 << 12)
> > +#define MXC_CCM_ELCDIFPIX_CLK_PODF_OFFSET    (0)
> > +#define MXC_CCM_ELCDIFPIX_CLK_PODF_MASK              (0xFFF)
> > +
> > +
> > +/* Define the bits in register GPMI */
> > +#define MXC_CCM_GPMI_CLKGATE_OFFSET          (30)
> > +#define MXC_CCM_GPMI_CLKGATE_MASK            (0x3 << 30)
> > +#define MXC_CCM_GPMI_CLK_DIV_OFFSET          (0)
> > +#define MXC_CCM_GPMI_CLK_DIV_MASK            (0x3F)
> > +
> > +/* Define the bits in register BCH */
> > +#define MXC_CCM_BCH_CLKGATE_OFFSET           (30)
> > +#define MXC_CCM_BCH_CLKGATE_MASK             (0x3 << 30)
> > +#define MXC_CCM_BCH_CLK_DIV_OFFSET           (0)
> > +#define MXC_CCM_BCH_CLK_DIV_MASK             (0x3F)
> > +
> > +#define MXC_GPC_BASE         (IO_ADDRESS(GPC_BASE_ADDR))
> > +#define MXC_DPTC_LP_BASE     (MXC_GPC_BASE + 0x80)
> > +#define MXC_DPTC_GP_BASE     (MXC_GPC_BASE + 0x100)
> > +#define MXC_DVFS_CORE_BASE   (MXC_GPC_BASE + 0x180)
> > +#define MXC_DVFS_PER_BASE    (MXC_GPC_BASE + 0x1C4)
> > +#define MXC_PGC_IPU_BASE     (MXC_GPC_BASE + 0x220)
> > +#define MXC_PGC_VPU_BASE     (MXC_GPC_BASE + 0x240)
> > +#define MXC_PGC_GPU_BASE     (MXC_GPC_BASE + 0x260)
> > +#define MXC_SRPG_NEON_BASE   (MXC_GPC_BASE + 0x280)
> > +#define MXC_SRPG_ARM_BASE    (MXC_GPC_BASE + 0x2A0)
> > +#define MXC_SRPG_EMPGC0_BASE (MXC_GPC_BASE + 0x2C0)
> > +#define MXC_SRPG_EMPGC1_BASE (MXC_GPC_BASE + 0x2D0)
> > +#define MXC_SRPG_MEGAMIX_BASE        (MXC_GPC_BASE + 0x2E0)
> > +#define MXC_SRPG_EMI_BASE    (MXC_GPC_BASE + 0x300)
> > +
> > +/* CORTEXA8 platform */
> > +extern void __iomem *arm_plat_base;
> > +#define MXC_CORTEXA8_BASE            (arm_plat_base)
> > +#define MXC_CORTEXA8_PLAT_PVID               (arm_plat_base + 0x0)
> > +#define MXC_CORTEXA8_PLAT_GPC                (arm_plat_base + 0x4)
> > +#define MXC_CORTEXA8_PLAT_PIC                (arm_plat_base + 0x8)
> > +#define MXC_CORTEXA8_PLAT_LPC                (arm_plat_base + 0xC)
> > +#define MXC_CORTEXA8_PLAT_NEON_LPC   (arm_plat_base + 0x10)
> > +#define MXC_CORTEXA8_PLAT_ICGC               (arm_plat_base + 0x14)
> > +#define MXC_CORTEXA8_PLAT_AMC                (arm_plat_base + 0x18)
> > +#define MXC_CORTEXA8_PLAT_NMC                (arm_plat_base + 0x20)
> > +#define MXC_CORTEXA8_PLAT_NMS                (arm_plat_base + 0x24)
> > +
> > +/* DVFS CORE */
> > +#define MXC_DVFSTHRS         (MXC_DVFS_CORE_BASE + 0x00)
> > +#define MXC_DVFSCOUN         (MXC_DVFS_CORE_BASE + 0x04)
> > +#define MXC_DVFSSIG1         (MXC_DVFS_CORE_BASE + 0x08)
> > +#define MXC_DVFSSIG0         (MXC_DVFS_CORE_BASE + 0x0C)
> > +#define MXC_DVFSGPC0         (MXC_DVFS_CORE_BASE + 0x10)
> > +#define MXC_DVFSGPC1         (MXC_DVFS_CORE_BASE + 0x14)
> > +#define MXC_DVFSGPBT         (MXC_DVFS_CORE_BASE + 0x18)
> > +#define MXC_DVFSEMAC         (MXC_DVFS_CORE_BASE + 0x1C)
> > +#define MXC_DVFSCNTR         (MXC_DVFS_CORE_BASE + 0x20)
> > +#define MXC_DVFSLTR0_0               (MXC_DVFS_CORE_BASE + 0x24)
> > +#define MXC_DVFSLTR0_1               (MXC_DVFS_CORE_BASE + 0x28)
> > +#define MXC_DVFSLTR1_0               (MXC_DVFS_CORE_BASE + 0x2C)
> > +#define MXC_DVFSLTR1_1               (MXC_DVFS_CORE_BASE + 0x30)
> > +#define MXC_DVFSPT0          (MXC_DVFS_CORE_BASE + 0x34)
> > +#define MXC_DVFSPT1          (MXC_DVFS_CORE_BASE + 0x38)
> > +#define MXC_DVFSPT2          (MXC_DVFS_CORE_BASE + 0x3C)
> > +#define MXC_DVFSPT3          (MXC_DVFS_CORE_BASE + 0x40)
> > +
> > +/* DVFS PER */
> > +#define MXC_DVFSPER_LTR0     (MXC_DVFS_PER_BASE)
> > +#define MXC_DVFSPER_LTR1     (MXC_DVFS_PER_BASE + 0x04)
> > +#define MXC_DVFSPER_LTR2     (MXC_DVFS_PER_BASE + 0x08)
> > +#define MXC_DVFSPER_LTR3     (MXC_DVFS_PER_BASE + 0x0C)
> > +#define MXC_DVFSPER_LTBR0    (MXC_DVFS_PER_BASE + 0x10)
> > +#define MXC_DVFSPER_LTBR1    (MXC_DVFS_PER_BASE + 0x14)
> > +#define MXC_DVFSPER_PMCR0    (MXC_DVFS_PER_BASE + 0x18)
> > +#define MXC_DVFSPER_PMCR1    (MXC_DVFS_PER_BASE + 0x1C)
> > +
> > +/* GPC */
> > +#define MXC_GPC_CNTR                         (MXC_GPC_BASE  + 0x0)
> > +#define MXC_GPC_PGR                          (MXC_GPC_BASE  + 0x4)
> > +#define MXC_GPC_VCR                          (MXC_GPC_BASE  + 0x8)
> > +#define MXC_GPC_CNTR_OFFSET          0x0
> > +#define MXC_GPC_PGR_OFFSET           0x4
> > +#define MXC_GPC_VCR_OFFSET           0x8
> > +
> > +/* PGC */
> > +#define MXC_PGC_IPU_PGCR     (MXC_PGC_IPU_BASE + 0x0)
> > +#define MXC_PGC_IPU_PGSR     (MXC_PGC_IPU_BASE + 0xC)
> > +#define MXC_PGC_VPU_PGCR     (MXC_PGC_VPU_BASE + 0x0)
> > +#define MXC_PGC_VPU_PGSR     (MXC_PGC_VPU_BASE + 0xC)
> > +#define MXC_PGC_GPU_PGCR     (MXC_PGC_GPU_BASE + 0x0)
> > +#define MXC_PGC_GPU_PGSR     (MXC_PGC_GPU_BASE + 0xC)
> > +
> > +#define MXC_PGCR_PCR         1
> > +#define MXC_SRPGCR_PCR               1
> > +#define MXC_EMPGCR_PCR               1
> > +#define MXC_PGSR_PSR         1
> > +
> > +
> > +#define MXC_CORTEXA8_PLAT_LPC_DSM    (1 << 0)
> > +#define MXC_CORTEXA8_PLAT_LPC_DBG_DSM        (1 << 1)
> > +
> > +/* SRPG */
> > +#define MXC_SRPG_NEON_SRPGCR (MXC_SRPG_NEON_BASE + 0x0)
> > +#define MXC_SRPG_NEON_PUPSCR (MXC_SRPG_NEON_BASE + 0x4)
> > +#define MXC_SRPG_NEON_PDNSCR (MXC_SRPG_NEON_BASE + 0x8)
> > +
> > +#define MXC_SRPG_ARM_SRPGCR  (MXC_SRPG_ARM_BASE + 0x0)
> > +#define MXC_SRPG_ARM_PUPSCR  (MXC_SRPG_ARM_BASE + 0x4)
> > +#define MXC_SRPG_ARM_PDNSCR  (MXC_SRPG_ARM_BASE + 0x8)
> > +
> > +#define MXC_SRPG_EMPGC0_SRPGCR       (MXC_SRPG_EMPGC0_BASE + 0x0)
> > +#define MXC_SRPG_EMPGC0_PUPSCR       (MXC_SRPG_EMPGC0_BASE + 0x4)
> > +#define MXC_SRPG_EMPGC0_PDNSCR       (MXC_SRPG_EMPGC0_BASE + 0x8)
> > +
> > +#define MXC_SRPG_EMPGC1_SRPGCR       (MXC_SRPG_EMPGC1_BASE + 0x0)
> > +#define MXC_SRPG_EMPGC1_PUPSCR       (MXC_SRPG_EMPGC1_BASE + 0x4)
> > +#define MXC_SRPG_EMPGC1_PDNSCR       (MXC_SRPG_EMPGC1_BASE + 0x8)
> > +
> > +#define MXC_SRPG_MEGAMIX_SRPGCR              (MXC_SRPG_MEGAMIX_BASE + 0x0)
> > +#define MXC_SRPG_MEGAMIX_PUPSCR              (MXC_SRPG_MEGAMIX_BASE + 0x4)
> > +#define MXC_SRPG_MEGAMIX_PDNSCR              (MXC_SRPG_MEGAMIX_BASE + 0x8)
> > +
> > +#define MXC_SRPGC_EMI_SRPGCR (MXC_SRPGC_EMI_BASE + 0x0)
> > +#define MXC_SRPGC_EMI_PUPSCR (MXC_SRPGC_EMI_BASE + 0x4)
> > +#define MXC_SRPGC_EMI_PDNSCR (MXC_SRPGC_EMI_BASE + 0x8)
> > +
> > +#endif                               /* __ARCH_ARM_MACH_MX5_CRM_REGS_MX50_H__ */
> > diff --git a/arch/arm/mach-mx5/devices-mx50.h b/arch/arm/mach-mx5/devices-mx50.h
> > new file mode 100644
> > index 0000000..98ab074
> > --- /dev/null
> > +++ b/arch/arm/mach-mx5/devices-mx50.h
> > @@ -0,0 +1,26 @@
> > +/*
> > + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> > + */
> > +
> > +/*
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
> > +#include <mach/mx50.h>
> > +#include <mach/devices-common.h>
> > +
> > +extern const struct imx_imx_uart_1irq_data imx50_imx_uart_data[] __initconst;
> > +#define imx50_add_imx_uart(id, pdata)        \
> > +     imx_add_imx_uart_1irq(&imx50_imx_uart_data[id], pdata)
> > diff --git a/arch/arm/mach-mx5/mm-mx50.c b/arch/arm/mach-mx5/mm-mx50.c
> > new file mode 100644
> > index 0000000..5818485
> > --- /dev/null
> > +++ b/arch/arm/mach-mx5/mm-mx50.c
> > @@ -0,0 +1,60 @@
> > +/*
> > + * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License.  You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + *
> > + * Create static mapping between physical to virtual memory.
> > + */
> > +
> > +#include <linux/mm.h>
> > +#include <linux/init.h>
> > +
> > +#include <asm/mach/map.h>
> > +
> > +#include <mach/hardware.h>
> > +#include <mach/common.h>
> > +#include <mach/iomux-v3.h>
> > +
> > +/*
> > + * Define the MX50 memory map.
> > + */
> > +static struct map_desc mx50_io_desc[] __initdata = {
> > +     imx_map_entry(MX50, AIPS1, MT_DEVICE),
> > +     imx_map_entry(MX50, SPBA0, MT_DEVICE),
> > +     imx_map_entry(MX50, AIPS2, MT_DEVICE),
> Did you verify that the exiting function works for mx50?
Yes, I calculated the physical->virtual map, no overlap.
And ccm and uart works.
> 
> > +};
> > +
> > +/*
> > + * This function initializes the memory map. It is called during the
> > + * system startup to create static physical to virtual memory mappings
> > + * for the IO modules.
> > + */
> > +void __init mx50_map_io(void)
> > +{
> > +     mxc_set_cpu_type(MXC_CPU_MX50);
> > +     mxc_iomux_v3_init(MX50_IO_ADDRESS(MX50_IOMUXC_BASE_ADDR));
> > +     mxc_arch_reset_init(MX50_IO_ADDRESS(MX50_WDOG_BASE_ADDR));
> > +     iotable_init(mx50_io_desc, ARRAY_SIZE(mx50_io_desc));
> > +}
> > +
> > +int imx50_register_gpios(void);
> > +
> > +void __init mx50_init_irq(void)
> > +{
> > +     unsigned long tzic_addr;
> > +     void __iomem *tzic_virt;
> > +
> > +     tzic_addr = MX50_TZIC_BASE_ADDR;
> > +
> > +     tzic_virt = ioremap(tzic_addr, SZ_16K);
> > +     if (!tzic_virt)
> > +             panic("unable to map TZIC interrupt controller\n");
> Is it really necessary for soc code to map the irq controller?  If yes
> that needs to be changed.
TZIC is in on-chip memory section. It's a large memory region. It's hare to
use current memory map routines to map it. I mean imx_map_entry.
> 
> > +
> > +     tzic_init_irq(tzic_virt);
> > +     imx50_register_gpios();
> > +}
> > diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/arm/plat-mxc/devices/platform-imx-uart.c
> > index 7b45b78..2146c09 100644
> > --- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
> > +++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
> > @@ -104,6 +104,19 @@ const struct imx_imx_uart_1irq_data imx51_imx_uart_data[] __initconst = {
> >  };
> >  #endif /* ifdef CONFIG_SOC_IMX51 */
> >
> > +#ifdef CONFIG_SOC_IMX50
> > +const struct imx_imx_uart_1irq_data imx50_imx_uart_data[] __initconst = {
> > +#define imx50_imx_uart_data_entry(_id, _hwid)                                \
> > +     imx_imx_uart_1irq_data_entry(MX50, _id, _hwid, SZ_4K)
> > +     imx50_imx_uart_data_entry(0, 1),
> > +     imx50_imx_uart_data_entry(1, 2),
> > +     imx50_imx_uart_data_entry(2, 3),
> > +     imx50_imx_uart_data_entry(3, 4),
> > +     imx50_imx_uart_data_entry(4, 5),
> > +};
> > +#endif /* ifdef CONFIG_SOC_IMX50 */
> > +
> > +
> double empty line
ok
> 
> >  struct platform_device *__init imx_add_imx_uart_3irq(
> >               const struct imx_imx_uart_3irq_data *data,
> >               const struct imxuart_platform_data *pdata)
> > diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
> > index 235985e..0c45aa8 100644
> > --- a/arch/arm/plat-mxc/gpio.c
> > +++ b/arch/arm/plat-mxc/gpio.c
> > @@ -445,3 +445,17 @@ static struct mxc_gpio_port imx35_gpio_ports[] = {
> >  DEFINE_REGISTER_FUNCTION(imx35)
> >
> >  #endif /* if defined(CONFIG_SOC_IMX35) */
> > +
> > +#if defined(CONFIG_SOC_IMX50)
> > +static struct mxc_gpio_port imx50_gpio_ports[] = {
> > +     _DEFINE_IMX_GPIO_PORT_IRQ(MX50, 0, 1, MX50_INT_GPIO1_LOW, MX50_INT_GPIO1_HIGH),
> > +     _DEFINE_IMX_GPIO_PORT_IRQ(MX50, 1, 2, MX50_INT_GPIO2_LOW, MX50_INT_GPIO2_HIGH),
> > +     _DEFINE_IMX_GPIO_PORT_IRQ(MX50, 2, 3, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH),
> > +     _DEFINE_IMX_GPIO_PORT_IRQ(MX50, 3, 4, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH),
> > +     _DEFINE_IMX_GPIO_PORT_IRQ(MX50, 4, 5, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH),
> > +     _DEFINE_IMX_GPIO_PORT_IRQ(MX50, 5, 6, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH),
> > +};
> > +
> > +DEFINE_REGISTER_FUNCTION(imx50)
> > +
> > +#endif /* if defined(CONFIG_SOC_IMX50) */
> > diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
> > index 9d58ce5..dcebfd7 100644
> > --- a/arch/arm/plat-mxc/include/mach/common.h
> > +++ b/arch/arm/plat-mxc/include/mach/common.h
> > @@ -22,6 +22,7 @@ extern void mx31_map_io(void);
> >  extern void mx35_map_io(void);
> >  extern void mx51_map_io(void);
> >  extern void mx53_map_io(void);
> > +extern void mx50_map_io(void);
> >  extern void mxc91231_map_io(void);
> >  extern void mxc_init_irq(void __iomem *);
> >  extern void tzic_init_irq(void __iomem *);
> > @@ -33,6 +34,7 @@ extern void mx31_init_irq(void);
> >  extern void mx35_init_irq(void);
> >  extern void mx51_init_irq(void);
> >  extern void mx53_init_irq(void);
> > +extern void mx50_init_irq(void);
> IMHO sort mx50 between mx35 and mx51.
ok
> 
> >  extern void mxc91231_init_irq(void);
> >  extern void epit_timer_init(struct clk *timer_clk, void __iomem *base, int irq);
> >  extern void mxc_timer_init(struct clk *timer_clk, void __iomem *, int);
> > @@ -46,6 +48,8 @@ extern int mx51_clocks_init(unsigned long ckil, unsigned long osc,
> >                       unsigned long ckih1, unsigned long ckih2);
> >  extern int mx53_clocks_init(unsigned long ckil, unsigned long osc,
> >                       unsigned long ckih1, unsigned long ckih2);
> > +extern int mx50_clocks_init(unsigned long ckil, unsigned long osc,
> > +                     unsigned long ckih1);
> >  extern int mxc91231_clocks_init(unsigned long fref);
> >  extern int mxc_register_gpios(void);
> >  extern int mxc_register_device(struct platform_device *pdev, void *data);
> > diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
> > index f9ed0ba..4eefc06 100644
> > --- a/arch/arm/plat-mxc/include/mach/hardware.h
> > +++ b/arch/arm/plat-mxc/include/mach/hardware.h
> > @@ -100,6 +100,7 @@
> >  #define IMX_IO_ADDRESS(x)    IOMEM(IMX_IO_P2V(x))
> >
> >  #ifdef CONFIG_ARCH_MX5
> > +#include <mach/mx50.h>
> >  #include <mach/mx51.h>
> >  #include <mach/mx53.h>
> >  #endif
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
> Shouldn't that go into iomux-v3.h?
Yes. I added it here because I saw other file also defined it.
I can send out a new patch to move it.
> 
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
> > +#define MX50_PAD_KEY_ROW0__GPIO_4_1  IOMUX_PAD(0x2D0, 0x24, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_KEY_COL1__GPIO_4_2  IOMUX_PAD(0x2D4, 0x28, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_KEY_ROW1__GPIO_4_3  IOMUX_PAD(0x2D8, 0x2C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_KEY_COL2__GPIO_4_4  IOMUX_PAD(0x2DC, 0x30, 1, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_KEY_ROW2__GPIO_4_5  IOMUX_PAD(0x2E0, 0x34, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_KEY_COL3__GPIO_4_6  IOMUX_PAD(0x2E4, 0x38, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_KEY_ROW3__GPIO_4_7  IOMUX_PAD(0x2E8, 0x3C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_I2C1_SCL__GPIO_6_18 IOMUX_PAD(0x2EC, 0x40, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_I2C1_SDA__GPIO_6_19 IOMUX_PAD(0x2F0, 0x44, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_I2C2_SCL__GPIO_6_20 IOMUX_PAD(0x2F4, 0x48, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_I2C2_SDA__GPIO_6_21 IOMUX_PAD(0x2F8, 0x4C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_I2C3_SCL__GPIO_6_22 IOMUX_PAD(0x2FC, 0x50, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_I2C3_SDA__GPIO_6_23 IOMUX_PAD(0x300, 0x54, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_PWM1__PWMO          IOMUX_PAD(0x304, 0x58, 0, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_PWM2__GPIO_6_25     IOMUX_PAD(0x308, 0x5C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_OWIRE__GPIO_6_26    IOMUX_PAD(0x30C, 0x60, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPITO__GPIO_6_27    IOMUX_PAD(0x310, 0x64, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_WDOG__GPIO_6_28     IOMUX_PAD(0x314, 0x68, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SSI_TXFS__GPIO_6_0  IOMUX_PAD(0x318, 0x6C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SSI_TXC__GPIO_6_1   IOMUX_PAD(0x31C, 0x70, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SSI_TXD__GPIO_6_2   IOMUX_PAD(0x320, 0x74, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SSI_RXD__GPIO_6_3   IOMUX_PAD(0x324, 0x78, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SSI_RXFS__GPIO_6_4  IOMUX_PAD(0x328, 0x7C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SSI_RXC__GPIO_6_5   IOMUX_PAD(0x32C, 0x80, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_UART1_TXD__GPIO_6_6 IOMUX_PAD(0x330, 0x84, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_UART1_RXD__GPIO_6_7 IOMUX_PAD(0x334, 0x88, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_UART1_CTS__GPIO_6_8 IOMUX_PAD(0x338, 0x8C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_UART1_RTS__GPIO_6_9 IOMUX_PAD(0x33C, 0x90, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_UART2_TXD__GPIO_6_10        IOMUX_PAD(0x340, 0x94, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_UART2_RXD__GPIO_6_11        IOMUX_PAD(0x344, 0x98, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_UART2_CTS__GPIO_6_12        IOMUX_PAD(0x348, 0x9C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_UART2_RTS__GPIO_6_13        IOMUX_PAD(0x34C, 0xA0, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_UART3_TXD__GPIO_6_14        IOMUX_PAD(0x350, 0xA4, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_UART3_RXD__GPIO_6_15        IOMUX_PAD(0x354, 0xA8, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_UART4_TXD__GPIO_6_16        IOMUX_PAD(0x358, 0xAC, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_UART4_RXD__GPIO_6_17        IOMUX_PAD(0x35C, 0xB0, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_CSPI_SCLK__GPIO_4_8 IOMUX_PAD(0x360, 0xB4, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_CSPI_MOSI__GPIO_4_9 IOMUX_PAD(0x364, 0xB8, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_CSPI_MISO__GPIO_4_10        IOMUX_PAD(0x368, 0xBC, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_CSPI_SS0__GPIO_4_11 IOMUX_PAD(0x36C, 0xC0, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_ECSPI1_SCLK__GPIO_4_12      IOMUX_PAD(0x370, 0xC4, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_ECSPI1_MOSI__GPIO_4_13      IOMUX_PAD(0x374, 0xC8, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_ECSPI1_MISO__GPIO_4_14      IOMUX_PAD(0x378, 0xCC, 1, 0x0, 0, NO_PAD_CTRL)
> > +
> > +/* HP detect */
> > +#define MX50_PAD_ECSPI1_SS0__GPIO_4_15       IOMUX_PAD(0x37C, 0xD0, 1, 0x0, 0, \
> > +                                                     PAD_CTL_PUS_100K_UP)
> > +#define MX50_PAD_ECSPI2_SCLK__GPIO_4_16      IOMUX_PAD(0x380, 0xD4, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_ECSPI2_MOSI__GPIO_4_17      IOMUX_PAD(0x384, 0xD8, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_ECSPI2_MISO__GPIO_4_18      IOMUX_PAD(0x388, 0xDC, 1, 0x0, 0, \
> > +                                                     PAD_CTL_PUS_100K_UP)
> > +#define MX50_PAD_ECSPI2_SS0__GPIO_4_19       IOMUX_PAD(0x38C, 0xE0, 1, 0x0, 0, MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD1_CLK__GPIO_5_0   IOMUX_PAD(0x390, 0xE4, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD1_CMD__GPIO_5_1   IOMUX_PAD(0x394, 0xE8, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD1_D0__GPIO_5_2    IOMUX_PAD(0x398, 0xEC, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD1_D1__GPIO_5_3    IOMUX_PAD(0x39C, 0xF0, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD1_D2__GPIO_5_4    IOMUX_PAD(0x3A0, 0xF4, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD1_D3__GPIO_5_5    IOMUX_PAD(0x3A4, 0xF8, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD2_CLK__GPIO_5_6   IOMUX_PAD(0x3A8, 0xFC, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD2_CMD__GPIO_5_7   IOMUX_PAD(0x3AC, 0x100, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD2_D0__GPIO_5_8    IOMUX_PAD(0x3B0, 0x104, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD2_D1__GPIO_5_9    IOMUX_PAD(0x3B4, 0x108, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD2_D2__GPIO_5_10   IOMUX_PAD(0x3B8, 0x10C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD2_D3__GPIO_5_11   IOMUX_PAD(0x3BC, 0x110, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD2_D4__GPIO_5_12   IOMUX_PAD(0x3C0, 0x114, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD2_D5__GPIO_5_13   IOMUX_PAD(0x3C4, 0x118, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD2_D6__GPIO_5_14   IOMUX_PAD(0x3C8, 0x11C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD2_D7__GPIO_5_15   IOMUX_PAD(0x3CC, 0x120, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD2_WP__GPIO_5_16   IOMUX_PAD(0x3D0, 0x124, 1, 0x0, 0, MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD2_CD__GPIO_5_17   IOMUX_PAD(0x3D4, 0x128, 1, 0x0, 0, MX50_SD_PAD_CTRL)
> > +
> > +#define MX50_PAD_PMIC_ON_REQ__PMIC_ON_REQ    IOMUX_PAD(0x3D8, NON_MUX_I, 0, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_PMIC_STBY_REQ__PMIC_STBY_REQ        IOMUX_PAD(0x3DC, NON_MUX_I, 0, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_PMIC_PORT_B__PMIC_PORT_B    IOMUX_PAD(0x3E0, NON_MUX_I, 0, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_PMIC_BOOT_MODE1__PMIC_BOOT_MODE1    IOMUX_PAD(0x3E4, NON_MUX_I, 0, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_PMIC_RESET_IN_B__PMIC_RESET_IN_B    IOMUX_PAD(0x3E8, NON_MUX_I, 0, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_PMIC_BOOT_MODE0__PMIC_BOOT_MODE0    IOMUX_PAD(0x3EC, NON_MUX_I, 0, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_PMIC_TEST_MODE__PMIC_TEST_MODE      IOMUX_PAD(0x3F0, NON_MUX_I, 0, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_PMIC_JTAG_TMS__PMIC_JTAG_TMS        IOMUX_PAD(0x3F4, NON_MUX_I, 0, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_PMIC_JTAG_MOD__PMIC_JTAG_MOD        IOMUX_PAD(0x3F8, NON_MUX_I, 0, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_PMIC_JTAG_TRSTB__PMIC_JTAG_TRSTB    IOMUX_PAD(0x3FC, NON_MUX_I, 0, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_PMIC_JTAG_TDI__PMIC_JTAG_TDI        IOMUX_PAD(0x400, NON_MUX_I, 0, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_PMIC_JTAG_TCK__PMIC_JTAG_TCK        IOMUX_PAD(0x404, NON_MUX_I, 0, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_PMIC_JTAG_TDO__PMIC_JTAG_TDO        IOMUX_PAD(0x408, NON_MUX_I, 0, 0x0, 0, NO_PAD_CTRL)
> > +
> > +#define MX50_PAD_DISP_D0__GPIO_2_0   IOMUX_PAD(0x40C, 0x12C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D1__GPIO_2_1   IOMUX_PAD(0x410, 0x130, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D2__GPIO_2_2   IOMUX_PAD(0x414, 0x134, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D3__GPIO_2_3   IOMUX_PAD(0x418, 0x138, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D4__GPIO_2_4   IOMUX_PAD(0x41C, 0x13C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D5__GPIO_2_5   IOMUX_PAD(0x420, 0x140, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D6__GPIO_2_6   IOMUX_PAD(0x424, 0x144, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D7__GPIO_2_7   IOMUX_PAD(0x428, 0x148, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_WR__GPIO_2_16  IOMUX_PAD(0x42C, 0x14C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_RD__GPIO_2_19  IOMUX_PAD(0x430, 0x150, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_RS__GPIO_2_17  IOMUX_PAD(0x434, 0x154, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_CS__GPIO_2_21  IOMUX_PAD(0x438, 0x158, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_BUSY__GPIO_2_18        IOMUX_PAD(0x43C, 0x15C, 1, 0x0, 0, \
> > +                                             MX50_ELCDIF_PAD_CTRL)
> > +#define MX50_PAD_DISP_BUSY__ELCDIF_HSYNC \
> > +                                     IOMUX_PAD(0x43C, 0x15C, 0, 0x6f8, 2, \
> > +                                             MX50_ELCDIF_PAD_CTRL)
> > +#define MX50_PAD_DISP_RESET__GPIO_2_20       IOMUX_PAD(0x440, 0x160, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD3_CMD__GPIO_5_18  IOMUX_PAD(0x444, 0x164, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD3_CLK__GPIO_5_19  IOMUX_PAD(0x448, 0x168, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD3_D0__GPIO_5_20   IOMUX_PAD(0x44C, 0x16C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD3_D1__GPIO_5_21   IOMUX_PAD(0x450, 0x170, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD3_D2__GPIO_5_22   IOMUX_PAD(0x454, 0x174, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD3_D3__GPIO_5_23   IOMUX_PAD(0x458, 0x178, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD3_D4__GPIO_5_24   IOMUX_PAD(0x45C, 0x17C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD3_D5__GPIO_5_25   IOMUX_PAD(0x460, 0x180, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD3_D6__GPIO_5_26   IOMUX_PAD(0x464, 0x184, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD3_D7__GPIO_5_27   IOMUX_PAD(0x468, 0x188, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_SD3_WP__GPIO_5_28   IOMUX_PAD(0x46C, 0x18C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D8__GPIO_2_8   IOMUX_PAD(0x470, 0x190, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D9__GPIO_2_9   IOMUX_PAD(0x474, 0x194, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D10__GPIO_2_10 IOMUX_PAD(0x478, 0x198, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D11__GPIO_2_11 IOMUX_PAD(0x47C, 0x19C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D12__GPIO_2_12 IOMUX_PAD(0x480, 0x1A0, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D13__GPIO_2_13 IOMUX_PAD(0x484, 0x1A4, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D14__GPIO_2_14 IOMUX_PAD(0x488, 0x1A8, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D15__GPIO_2_15 IOMUX_PAD(0x48C, 0x1AC, 1, 0x0, 0, NO_PAD_CTRL)
> > +
> > +#define MX50_PAD_EPDC_D0__GPIO_3_0   IOMUX_PAD(0x54C, 0x1B0, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D1__GPIO_3_1   IOMUX_PAD(0x550, 0x1B4, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D2__GPIO_3_2   IOMUX_PAD(0x554, 0x1B8, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D3__GPIO_3_3   IOMUX_PAD(0x558, 0x1BC, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D4__GPIO_3_4   IOMUX_PAD(0x55C, 0x1C0, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D5__GPIO_3_5   IOMUX_PAD(0x560, 0x1C4, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D6__GPIO_3_6   IOMUX_PAD(0x564, 0x1C8, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D7__GPIO_3_7   IOMUX_PAD(0x568, 0x1CC, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D8__GPIO_3_8   IOMUX_PAD(0x56C, 0x1D0, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D9__GPIO_3_9   IOMUX_PAD(0x570, 0x1D4, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D10__GPIO_3_10 IOMUX_PAD(0x574, 0x1D8, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D11__GPIO_3_11 IOMUX_PAD(0x578, 0x1DC, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D12__GPIO_3_12 IOMUX_PAD(0x57C, 0x1E0, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D13__GPIO_3_13 IOMUX_PAD(0x580, 0x1E4, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D14__GPIO_3_14 IOMUX_PAD(0x584, 0x1E8, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D15__GPIO_3_15 IOMUX_PAD(0x588, 0x1EC, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_GDCLK__GPIO_3_16       IOMUX_PAD(0x58C, 0x1F0, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_GDSP__GPIO_3_17        IOMUX_PAD(0x590, 0x1F4, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_GDOE__GPIO_3_18        IOMUX_PAD(0x594, 0x1F8, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_GDRL__GPIO_3_19        IOMUX_PAD(0x598, 0x1FC, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDCLK__GPIO_3_20       IOMUX_PAD(0x59C, 0x200, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDOEZ__GPIO_3_21       IOMUX_PAD(0x5A0, 0x204, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDOED__GPIO_3_22       IOMUX_PAD(0x5A4, 0x208, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDOE__GPIO_3_23        IOMUX_PAD(0x5A8, 0x20C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDLE__GPIO_3_24        IOMUX_PAD(0x5AC, 0x210, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDCLKN__GPIO_3_25      IOMUX_PAD(0x5B0, 0x214, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDSHR__GPIO_3_26       IOMUX_PAD(0x5B4, 0x218, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_PWRCOM__GPIO_3_27      IOMUX_PAD(0x5B8, 0x21C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_PWRSTAT__GPIO_3_28     IOMUX_PAD(0x5BC, 0x220, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_PWRCTRL0__GPIO_3_29    IOMUX_PAD(0x5C0, 0x224, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_PWRCTRL1__GPIO_3_30    IOMUX_PAD(0x5C4, 0x228, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_PWRCTRL2__GPIO_3_31    IOMUX_PAD(0x5C8, 0x22C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_PWRCTRL3__GPIO_4_20    IOMUX_PAD(0x5CC, 0x230, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_VCOM0__GPIO_4_21       IOMUX_PAD(0x5D0, 0x234, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_VCOM1__GPIO_4_22       IOMUX_PAD(0x5D4, 0x238, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_BDR0__GPIO_4_23        IOMUX_PAD(0x5D8, 0x23C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_BDR1__GPIO_4_24        IOMUX_PAD(0x5DC, 0x240, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDCE0__GPIO_4_25       IOMUX_PAD(0x5E0, 0x244, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDCE1__GPIO_4_26       IOMUX_PAD(0x5E4, 0x248, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDCE2__GPIO_4_27       IOMUX_PAD(0x5E8, 0x24C, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDCE3__GPIO_4_28       IOMUX_PAD(0x5EC, 0x250, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDCE4__GPIO_4_29       IOMUX_PAD(0x5F0, 0x254, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDCE5__GPIO_4_30       IOMUX_PAD(0x5F4, 0x258, 1, 0x0, 0, NO_PAD_CTRL)
> > +#define MX50_PAD_EIM_DA0__GPIO_1_0   IOMUX_PAD(0x5F8, 0x25C, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_DA1__GPIO_1_1   IOMUX_PAD(0x5FC, 0x260, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_DA2__GPIO_1_2   IOMUX_PAD(0x600, 0x264, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_DA3__GPIO_1_3   IOMUX_PAD(0x604, 0x268, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_DA4__GPIO_1_4   IOMUX_PAD(0x608, 0x26C, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_DA5__GPIO_1_5   IOMUX_PAD(0x60C, 0x270, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_DA6__GPIO_1_6   IOMUX_PAD(0x610, 0x274, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_DA7__GPIO_1_7   IOMUX_PAD(0x614, 0x278, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_DA8__GPIO_1_8   IOMUX_PAD(0x618, 0x27C, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_DA9__GPIO_1_9   IOMUX_PAD(0x61C, 0x280, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_DA10__GPIO_1_10 IOMUX_PAD(0x620, 0x284, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_DA11__GPIO_1_11 IOMUX_PAD(0x624, 0x288, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_DA12__GPIO_1_12 IOMUX_PAD(0x628, 0x28C, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_DA13__GPIO_1_13 IOMUX_PAD(0x62C, 0x290, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_DA14__GPIO_1_14 IOMUX_PAD(0x630, 0x294, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_DA15__GPIO_1_15 IOMUX_PAD(0x634, 0x298, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_CS2__GPIO_1_16  IOMUX_PAD(0x638, 0x29C, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_CS1__GPIO_1_17  IOMUX_PAD(0x63C, 0x2A0, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_CS0__GPIO_1_18  IOMUX_PAD(0x640, 0x2A4, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_EB0__GPIO_1_19  IOMUX_PAD(0x644, 0x2A8, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_EB1__GPIO_1_20  IOMUX_PAD(0x648, 0x2AC, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_WAIT__GPIO_1_21 IOMUX_PAD(0x64C, 0x2B0, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_BCLK__GPIO_1_22 IOMUX_PAD(0x650, 0x2B4, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_RDY__GPIO_1_23  IOMUX_PAD(0x654, 0x2B8, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_OE__GPIO_1_24   IOMUX_PAD(0x658, 0x2BC, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_RW__GPIO_1_25   IOMUX_PAD(0x65C, 0x2C0, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_LBA__GPIO_1_26  IOMUX_PAD(0x660, 0x2C4, 1, 0x0, 0, 0)
> > +#define MX50_PAD_EIM_CRE__GPIO_1_27  IOMUX_PAD(0x664, 0x2C8, 1, 0x0, 0, 0)
> > +
> > +/* SD1 */
> > +#define MX50_PAD_SD1_CMD__SD1_CMD    IOMUX_PAD(0x394, 0xE8, \
> > +                                     IOMUX_CONFIG_SION, 0x0, 0, \
> > +                                     MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD1_CLK__SD1_CLK    IOMUX_PAD(0x390, 0xE4, \
> > +                                     IOMUX_CONFIG_SION, 0x0, 0, \
> > +                                     MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD1_D0__SD1_D0      IOMUX_PAD(0x398, 0xEC, 0, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD1_D1__SD1_D1      IOMUX_PAD(0x39C, 0xF0, 0, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD1_D2__SD1_D2      IOMUX_PAD(0x3A0, 0xF4, 0, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD1_D3__SD1_D3      IOMUX_PAD(0x3A4, 0xF8, 0, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +
> > +/* SD2 */
> > +#define MX50_PAD_SD2_CLK__SD2_CLK    IOMUX_PAD(0x3A8, 0xFC, \
> > +                                             IOMUX_CONFIG_SION, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD2_CMD__SD2_CMD    IOMUX_PAD(0x3AC, 0x100, \
> > +                                             IOMUX_CONFIG_SION, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD2_D0__SD2_D0      IOMUX_PAD(0x3B0, 0x104, 0, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD2_D1__SD2_D1      IOMUX_PAD(0x3B4, 0x108, 0, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD2_D2__SD2_D2      IOMUX_PAD(0x3B8, 0x10C, 0, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD2_D3__SD2_D3      IOMUX_PAD(0x3BC, 0x110, 0, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD2_D4__SD2_D4      IOMUX_PAD(0x3C0, 0x114, 0, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD2_D5__SD2_D5      IOMUX_PAD(0x3C4, 0x118, 0, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD2_D6__SD2_D6      IOMUX_PAD(0x3C8, 0x11C, 0, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_SD2_D7__SD2_D7      IOMUX_PAD(0x3CC, 0x120, 0, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +
> > +/* SD3 */
> > +#define MX50_PAD_SD3_CMD__SD3_CMD    IOMUX_PAD(0x444, 0x164, 0, 0x0, 0, \
> > +                                             MX50_SD3_PAD_CMD)
> > +#define MX50_PAD_SD3_CLK__SD3_CLK    IOMUX_PAD(0x448, 0x168, 0, 0x0, 0, \
> > +                                             MX50_SD3_PAD_CLK)
> > +#define MX50_PAD_SD3_D0__SD3_D0      IOMUX_PAD(0x44C, 0x16C, 0, 0x0, 0, \
> > +                                             MX50_SD3_PAD_DAT)
> > +#define MX50_PAD_SD3_D1__SD3_D1      IOMUX_PAD(0x450, 0x170, 0, 0x0, 0, \
> > +                                             MX50_SD3_PAD_DAT)
> > +#define MX50_PAD_SD3_D2__SD3_D2      IOMUX_PAD(0x454, 0x174, 0, 0x0, 0, \
> > +                                             MX50_SD3_PAD_DAT)
> > +#define MX50_PAD_SD3_D3__SD3_D3      IOMUX_PAD(0x458, 0x178, 0, 0x0, 0, \
> > +                                             MX50_SD3_PAD_DAT)
> > +#define MX50_PAD_SD3_D4__SD3_D4      IOMUX_PAD(0x45C, 0x17C, 0, 0x0, 0, \
> > +                                             MX50_SD3_PAD_DAT)
> > +#define MX50_PAD_SD3_D5__SD3_D5      IOMUX_PAD(0x460, 0x180, 0, 0x0, 0, \
> > +                                             MX50_SD3_PAD_DAT)
> > +#define MX50_PAD_SD3_D6__SD3_D6      IOMUX_PAD(0x464, 0x184, 0, 0x0, 0, \
> > +                                             MX50_SD3_PAD_DAT)
> > +#define MX50_PAD_SD3_D7__SD3_D7      IOMUX_PAD(0x468, 0x188, 0, 0x0, 0, \
> > +                                             MX50_SD3_PAD_DAT)
> > +
> > +/* OWIRE */
> > +#define MX50_PAD_OWIRE__OWIRE        IOMUX_PAD(0x30C, 0x60, 0, 0x0, 0, \
> > +                                             MX50_OWIRE_PAD_CTRL)
> > +
> > +/* SSI */
> > +#define MX50_PAD_SSI_TXFS__SSI_TXFS  IOMUX_PAD(0x318, 0x6C, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_SSI_TXC__SSI_TXC    IOMUX_PAD(0x31C, 0x70, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_SSI_TXD__SSI_TXD    IOMUX_PAD(0x320, 0x74, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_SSI_RXD__SSI_RXD    IOMUX_PAD(0x324, 0x78, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +
> > +/* UART1 and UART2 */
> > +#define MX50_PAD_UART1_TXD__UART1_TXD        IOMUX_PAD(0x330, 0x84, 0, 0x0, 0, \
> > +                                             MX50_UART_PAD_CTRL)
> > +#define MX50_PAD_UART1_RXD__UART1_RXD        IOMUX_PAD(0x334, 0x88, 0, 0x7c4, 1, \
> > +                                             MX50_UART_PAD_CTRL)
> > +#define MX50_PAD_UART1_CTS__UART1_CTS        IOMUX_PAD(0x338, 0x8C, 0, 0x0, 0, \
> > +                                             MX50_UART_PAD_CTRL)
> > +#define MX50_PAD_UART1_RTS__UART1_RTS        IOMUX_PAD(0x33C, 0x90, 0, 0x7c0, 1, \
> > +                                             MX50_UART_PAD_CTRL)
> > +#define MX50_PAD_UART2_TXD__UART2_TXD        IOMUX_PAD(0x340, 0x94, 0, 0x0, 0, \
> > +                                             MX50_UART_PAD_CTRL)
> > +#define MX50_PAD_UART2_RXD__UART2_RXD        IOMUX_PAD(0x344, 0x98, 0, 0x7cc, 3, \
> > +                                             MX50_UART_PAD_CTRL)
> > +#define MX50_PAD_UART2_CTS__UART2_CTS        IOMUX_PAD(0x348, 0x9C, 0, 0x0, 0, \
> > +                                             MX50_UART_PAD_CTRL)
> > +#define MX50_PAD_UART2_RTS__UART2_RTS        IOMUX_PAD(0x34C, 0xA0, 0, 0x7c8, 3, \
> > +                                             MX50_UART_PAD_CTRL)
> > +
> > +/* I2C1, I2C2, I2C3 */
> > +#define MX50_PAD_I2C1_SCL__I2C1_SCL  IOMUX_PAD(0x2EC, 0x40, \
> > +                                             IOMUX_CONFIG_SION, 0x0, 0, \
> > +                                             MX50_I2C_PAD_CTRL)
> > +#define MX50_PAD_I2C1_SDA__I2C1_SDA  IOMUX_PAD(0x2F0, 0x44, \
> > +                                             IOMUX_CONFIG_SION, 0x0, 0, \
> > +                                             MX50_I2C_PAD_CTRL)
> > +#define MX50_PAD_I2C2_SCL__I2C2_SCL  IOMUX_PAD(0x2F4, 0x48, \
> > +                                             IOMUX_CONFIG_SION, 0x0, 0, \
> > +                                             MX50_I2C_PAD_CTRL)
> > +#define MX50_PAD_I2C2_SDA__I2C2_SDA  IOMUX_PAD(0x2F8, 0x4C, \
> > +                                             IOMUX_CONFIG_SION, 0x0, 0, \
> > +                                             MX50_I2C_PAD_CTRL)
> > +#define MX50_PAD_I2C3_SCL__I2C3_SCL  IOMUX_PAD(0x2FC, 0x50, \
> > +                                             IOMUX_CONFIG_SION, 0x0, 0, \
> > +                                             MX50_I2C_PAD_CTRL)
> > +#define MX50_PAD_I2C3_SDA__I2C3_SDA  IOMUX_PAD(0x300, 0x54, \
> > +                                             IOMUX_CONFIG_SION, 0x0, 0, \
> > +                                             MX50_I2C_PAD_CTRL)
> > +
> > +/* EPDC */
> > +#define MX50_PAD_EPDC_D0__EPDC_D0    IOMUX_PAD(0x54C, 0x1B0, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D1__EPDC_D1    IOMUX_PAD(0x550, 0x1B4, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D2__EPDC_D2    IOMUX_PAD(0x554, 0x1B8, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D3__EPDC_D3    IOMUX_PAD(0x558, 0x1BC, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D4__EPDC_D4    IOMUX_PAD(0x55C, 0x1C0, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D5__EPDC_D5    IOMUX_PAD(0x560, 0x1C4, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D6__EPDC_D6    IOMUX_PAD(0x564, 0x1C8, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_D7__EPDC_D7    IOMUX_PAD(0x568, 0x1CC, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_GDCLK__EPDC_GDCLK      IOMUX_PAD(0x58C, 0x1F0, 0, 0x0, 0, \
> > +                                                     NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_GDSP__EPDC_GDSP        IOMUX_PAD(0x590, 0x1F4, 0, 0x0, 0, \
> > +                                                     NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_GDOE__EPDC_GDOE        IOMUX_PAD(0x594, 0x1F8, 0, 0x0, 0, \
> > +                                                     NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_GDRL__EPDC_GDRL        IOMUX_PAD(0x598, 0x1FC, 0, 0x0, 0, \
> > +                                                     NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDCLK__EPDC_SDCLK      IOMUX_PAD(0x59C, 0x200, 0, 0x0, 0, \
> > +                                                     NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDOE__EPDC_SDOE        IOMUX_PAD(0x5A8, 0x20C, 0, 0x0, 0, \
> > +                                                     NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDLE__EPDC_SDLE        IOMUX_PAD(0x5AC, 0x210, 0, 0x0, 0, \
> > +                                                     NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDSHR__EPDC_SDSHR      IOMUX_PAD(0x5B4, 0x218, 0, 0x0, 0, \
> > +                                                     NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_BDR0__EPDC_BDR0        IOMUX_PAD(0x5D8, 0x23C, 0, 0x0, 0, \
> > +                                                     NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDCE0__EPDC_SDCE0      IOMUX_PAD(0x5E0, 0x244, 0, 0x0, 0, \
> > +                                                     NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDCE1__EPDC_SDCE1      IOMUX_PAD(0x5E4, 0x248, 0, 0x0, 0, \
> > +                                                     NO_PAD_CTRL)
> > +#define MX50_PAD_EPDC_SDCE2__EPDC_SDCE2      IOMUX_PAD(0x5E8, 0x24C, 0, 0x0, 0, \
> > +                                                     NO_PAD_CTRL)
> > +#define MX50_PAD_DISP_D8__DISP_D8    IOMUX_PAD(0x470, 0x190, 0, \
> > +                                     0x0, 0, MX50_ELCDIF_PAD_CTRL)
> > +#define MX50_PAD_DISP_D9__DISP_D9    IOMUX_PAD(0x474, 0x194, 0, 0x0, 0, \
> > +                                             MX50_ELCDIF_PAD_CTRL)
> > +#define MX50_PAD_DISP_D10__DISP_D10  IOMUX_PAD(0x478, 0x198, 0, 0x0, 0, \
> > +                                             MX50_ELCDIF_PAD_CTRL)
> > +#define MX50_PAD_DISP_D11__DISP_D11  IOMUX_PAD(0x47C, 0x19C, 0, 0x0, 0, \
> > +                                             MX50_ELCDIF_PAD_CTRL)
> > +#define MX50_PAD_DISP_D12__DISP_D12  IOMUX_PAD(0x480, 0x1A0, 0, 0x0, 0, \
> > +                                             MX50_ELCDIF_PAD_CTRL)
> > +#define MX50_PAD_DISP_D13__DISP_D13  IOMUX_PAD(0x484, 0x1A4, 0, 0x0, 0, \
> > +                                             MX50_ELCDIF_PAD_CTRL)
> > +#define MX50_PAD_DISP_D14__DISP_D14  IOMUX_PAD(0x488, 0x1A8, 0, 0x0, 0, \
> > +                                             MX50_ELCDIF_PAD_CTRL)
> > +#define MX50_PAD_DISP_D15__DISP_D15  IOMUX_PAD(0x48C, 0x1AC, 0, 0x0, 0, \
> > +                                             MX50_ELCDIF_PAD_CTRL)
> > +#define MX50_PAD_DISP_RS__ELCDIF_VSYNC       IOMUX_PAD(0x434, 0x154, 2, 0x73c, 1, \
> > +                                             MX50_ELCDIF_PAD_CTRL)
> > +#define MX50_PAD_DISP_CS__ELCDIF_HSYNC       IOMUX_PAD(0x438, 0x158, 2, 0x0, 0, \
> > +                                             MX50_ELCDIF_PAD_CTRL)
> > +#define MX50_PAD_DISP_RD__ELCDIF_EN  IOMUX_PAD(0x430, 0x150, 2, 0x0, 0, \
> > +                                             MX50_ELCDIF_PAD_CTRL)
> > +#define MX50_PAD_DISP_WR__ELCDIF_PIXCLK      IOMUX_PAD(0x42C, 0x14C, 2, 0x0, 0, \
> > +                                             MX50_ELCDIF_PAD_CTRL)
> > +
> > +/* USB */
> > +#define MX50_PAD_EPITO__USBH1_PWR    IOMUX_PAD(0x310, 0x64, 2, 0x0, 0, \
> > +                                             PAD_CTL_PKE | PAD_CTL_DSE_HIGH)
> > +#define MX50_PAD_OWIRE__USBH1_OC     IOMUX_PAD(0x30C, 0x60, 2, 0x0, 0, \
> > +                                             MX50_USB_PAD_CTRL)
> > +#define MX50_PAD_PWM2__USBOTG_PWR    IOMUX_PAD(0x308, 0x5C, 2, 0x0, 0, \
> > +                                             PAD_CTL_PKE | PAD_CTL_DSE_HIGH)
> > +#define MX50_PAD_PWM1__USBOTG_OC     IOMUX_PAD(0x304, 0x58, 2, 0x7E8, 1, \
> > +                                             MX50_USB_PAD_CTRL)
> > +#define MX50_PAD_I2C3_SCL__USBOTG_OC IOMUX_PAD(0x2FC, 0x50, 7, 0x7E8, 0, \
> > +     MX50_USB_PAD_CTRL)
> > +
> > +
> > +/* FEC */
> > +#define MX50_PAD_SSI_RXC__FEC_MDIO   IOMUX_PAD(0x32C, 0x80, 6, 0x774, 1, \
> > +                                             MX50_FEC_PAD_CTRL)
> > +#define MX50_PAD_DISP_D0__FEC_TXCLK  IOMUX_PAD(0x40C, 0x12C, 2, 0x0, 0, \
> > +                                             PAD_CTL_HYS | PAD_CTL_PKE)
> > +#define MX50_PAD_DISP_D1__FEC_RX_ER  IOMUX_PAD(0x410, 0x130, 2, 0x788, 0, \
> > +                                             PAD_CTL_HYS | PAD_CTL_PKE)
> > +#define MX50_PAD_DISP_D2__FEC_RX_DV  IOMUX_PAD(0x414, 0x134, 2, 0x784, 0, \
> > +                                             PAD_CTL_HYS | PAD_CTL_PKE)
> > +#define MX50_PAD_DISP_D3__FEC_RXD1   IOMUX_PAD(0x418, 0x138, 2, 0x77C, 0, \
> > +                                             PAD_CTL_HYS | PAD_CTL_PKE)
> > +#define MX50_PAD_DISP_D4__FEC_RXD0   IOMUX_PAD(0x41C, 0x13C, 2, 0x778, 0, \
> > +                                             PAD_CTL_HYS | PAD_CTL_PKE)
> > +#define MX50_PAD_DISP_D5__FEC_TX_EN  IOMUX_PAD(0x420, 0x140, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PAD_DISP_D6__FEC_TXD1   IOMUX_PAD(0x424, 0x144, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PAD_DISP_D7__FEC_TXD0   IOMUX_PAD(0x428, 0x148, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PAD_SSI_RXFS__FEC_MDC   IOMUX_PAD(0x328, 0x7C, 6, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +
> > +/* WVGA */
> > +#define MX50_PAD_DISP_D0__DISP_D0    IOMUX_PAD(0x40C, 0x12C, 0, 0x6fc, 0, \
> > +                                             MX50_WVGA_PAD_CTRL)
> > +#define MX50_PAD_DISP_D1__DISP_D1    IOMUX_PAD(0x410, 0x130, 0, 0x700, 0, \
> > +                                             MX50_WVGA_PAD_CTRL)
> > +#define MX50_PAD_DISP_D2__DISP_D2    IOMUX_PAD(0x414, 0x134, 0, 0x704, 0, \
> > +                                             MX50_WVGA_PAD_CTRL)
> > +#define MX50_PAD_DISP_D3__DISP_D3    IOMUX_PAD(0x418, 0x138, 0, 0x708, 0, \
> > +                                             MX50_WVGA_PAD_CTRL)
> > +#define MX50_PAD_DISP_D4__DISP_D4    IOMUX_PAD(0x41C, 0x13C, 0, 0x70c, 0, \
> > +                                             MX50_WVGA_PAD_CTRL)
> > +#define MX50_PAD_DISP_D5__DISP_D5    IOMUX_PAD(0x420, 0x140, 0, 0x710, 0, \
> > +                                             MX50_WVGA_PAD_CTRL)
> > +#define MX50_PAD_DISP_D6__DISP_D6    IOMUX_PAD(0x424, 0x144, 0, 0x714, 0, \
> > +                                             MX50_WVGA_PAD_CTRL)
> > +#define MX50_PAD_DISP_D7__DISP_D7    IOMUX_PAD(0x428, 0x148, 0, 0x718, 0, \
> > +                                             MX50_WVGA_PAD_CTRL)
> > +
> > +/* CSPI */
> > +#define MX50_PAD_CSPI_SS0__CSPI_SS0  IOMUX_PAD(0x36C, 0xC0, 0, 0x0, 0, \
> > +                                             PAD_CTL_PKE | PAD_CTL_PUE | \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PAD_ECSPI1_MOSI__CSPI_SS1       IOMUX_PAD(0x374, 0xC8, 2, 0x0, 0, \
> > +                                             PAD_CTL_PKE | PAD_CTL_PUE | \
> > +                                             PAD_CTL_PUS_22K_UP | \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PAD_CSPI_MOSI__CSPI_MOSI        IOMUX_PAD(0x364, 0xB8, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_CSPI_MISO__CSPI_MISO        IOMUX_PAD(0x368, 0xBC, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +
> > +/* NAND */
> > +#define MX50_PIN_EIM_DA8__NANDF_CLE  IOMUX_PAD(0x618, 0x27C, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_EIM_DA9__NANDF_ALE  IOMUX_PAD(0x61C, 0x280, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_EIM_DA10__NANDF_CE0 IOMUX_PAD(0x620, 0x284, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_EIM_DA11__NANDF_CE1 IOMUX_PAD(0x624, 0x288, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_EIM_DA12__NANDF_CE2 IOMUX_PAD(0x628, 0x28C, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_EIM_DA13__NANDF_CE3 IOMUX_PAD(0x62C, 0x290, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_EIM_DA14__NANDF_READY       IOMUX_PAD(0x630, 0x294, 2, 0x7B4, 2, \
> > +                                             PAD_CTL_PKE | \
> > +                                             PAD_CTL_PUE | \
> > +                                             PAD_CTL_PUS_100K_UP)
> > +#define MX50_PIN_EIM_DA15__NANDF_DQS IOMUX_PAD(0x634, 0x298, 2, 0x7B0, 2, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_SD3_D4__NANDF_D0    IOMUX_PAD(0x45C, 0x17C, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_SD3_D5__NANDF_D1    IOMUX_PAD(0x460, 0x180, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_SD3_D6__NANDF_D2    IOMUX_PAD(0x464, 0x184, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_SD3_D7__NANDF_D3    IOMUX_PAD(0x468, 0x188, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_SD3_D0__NANDF_D4    IOMUX_PAD(0x44C, 0x16C, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_SD3_D1__NANDF_D5    IOMUX_PAD(0x450, 0x170, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_SD3_D2__NANDF_D6    IOMUX_PAD(0x454, 0x174, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_SD3_D3__NANDF_D7    IOMUX_PAD(0x458, 0x178, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_SD3_CLK__NANDF_RDN  IOMUX_PAD(0x448, 0x168, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_SD3_CMD__NANDF_WRN  IOMUX_PAD(0x444, 0x164, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +#define MX50_PIN_SD3_WP__NANDF_RESETN        IOMUX_PAD(0x46C, 0x18C, 2, 0x0, 0, \
> > +                                             PAD_CTL_DSE_HIGH)
> > +
> > +/* Keypad */
> > +#define MX50_KEYPAD_CTRL        (PAD_CTL_HYS | PAD_CTL_PKE | PAD_CTL_PUE | \
> > +                                     PAD_CTL_PUS_100K_UP | PAD_CTL_DSE_HIGH)
> > +
> > +#define MX50_PAD_KEY_COL0__KEY_COL0  IOMUX_PAD(0x2CC, 0x20, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_KEY_ROW0__KEY_ROW0  IOMUX_PAD(0x2D0, 0x24, 0, 0x0, 0, \
> > +                                             MX50_KEYPAD_CTRL)
> > +#define MX50_PAD_KEY_COL1__KEY_COL1  IOMUX_PAD(0x2D4, 0x28, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_KEY_ROW1__KEY_ROW1  IOMUX_PAD(0x2D8, 0x2C, 0, 0x0, 0, \
> > +                                             MX50_KEYPAD_CTRL)
> > +#define MX50_PAD_KEY_COL2__KEY_COL2  IOMUX_PAD(0x2DC, 0x30, 0, 0x0, 0, \
> > +                                             MX50_SD_PAD_CTRL)
> > +#define MX50_PAD_KEY_ROW2__KEY_ROW2  IOMUX_PAD(0x2E0, 0x34, 0, 0x0, 0, \
> > +                                             MX50_KEYPAD_CTRL)
> > +#define MX50_PAD_KEY_COL3__KEY_COL3  IOMUX_PAD(0x2E4, 0x38, 0, 0x0, 0, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_KEY_ROW3__KEY_ROW3  IOMUX_PAD(0x2E8, 0x3C, 0, 0x0, 0, \
> > +                                             MX50_KEYPAD_CTRL)
> > +#define MX50_PAD_EIM_DA0__KEY_COL4   IOMUX_PAD(0x5f8, 0x25C, 3, 0x790, 2, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_EIM_DA1__KEY_ROW4   IOMUX_PAD(0x5fc, 0x260, 3, 0x7a0, 2, \
> > +                                             MX50_KEYPAD_CTRL)
> > +#define MX50_PAD_EIM_DA2__KEY_COL5   IOMUX_PAD(0x600, 0x264, 3, 0x794, 2, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_EIM_DA3__KEY_ROW5   IOMUX_PAD(0x604, 0x268, 3, 0x7a4, 2, \
> > +                                             MX50_KEYPAD_CTRL)
> > +#define MX50_PAD_EIM_DA4__KEY_COL6   IOMUX_PAD(0x608, 0x26C, 3, 0x798, 2, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_EIM_DA5__KEY_ROW6   IOMUX_PAD(0x60C, 0x270, 3, 0x7a8, 2, \
> > +                                             MX50_KEYPAD_CTRL)
> > +#define MX50_PAD_EIM_DA6__KEY_COL7   IOMUX_PAD(0x610, 0x274, 3, 0x79c, 2, \
> > +                                             NO_PAD_CTRL)
> > +#define MX50_PAD_EIM_DA7__KEY_ROW7   IOMUX_PAD(0x614, 0x278, 3, 0x7ac, 2, \
> > +                                             MX50_KEYPAD_CTRL)
> > +#endif /* __MACH_IOMUX_MX53_H__ */
> > +
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
> That is if you have a kernel with support for mx25 and mx50 you end up
> with MXC_GPIO_IRQS being defined as (32 * 4).
ok, I will move it to the first place. Anyway, I think it's just a work around for mult-SoC support.
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
> I think introducing ARCH_MX50 would be nice and using it e.g. here.
Why? Isn't it redundant? They're all soc level macro.
> 
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
> can you please use lower case letters for hex constants?
ok
> 
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
> > +
> > +
> > +
> > +/*
> > + * Graphics Memory of GPU
> > + */
> > +#define MX50_GPU2D_BASE_ADDR         0x20000000
> > +
> > +#define MX50_DEBUG_BASE_ADDR         0x40000000
> > +#define MX50_DEBUG_SIZE                      SZ_1M
> > +#define MX50_ETB_BASE_ADDR           (MX50_DEBUG_BASE_ADDR + 0x00001000)
> > +#define MX50_ETM_BASE_ADDR           (MX50_DEBUG_BASE_ADDR + 0x00002000)
> > +#define MX50_TPIU_BASE_ADDR          (MX50_DEBUG_BASE_ADDR + 0x00003000)
> > +#define MX50_CTI0_BASE_ADDR          (MX50_DEBUG_BASE_ADDR + 0x00004000)
> > +#define MX50_CTI1_BASE_ADDR          (MX50_DEBUG_BASE_ADDR + 0x00005000)
> > +#define MX50_CTI2_BASE_ADDR          (MX50_DEBUG_BASE_ADDR + 0x00006000)
> > +#define MX50_CTI3_BASE_ADDR          (MX50_DEBUG_BASE_ADDR + 0x00007000)
> > +#define MX50_CORTEX_DBG_BASE_ADDR    (MX50_DEBUG_BASE_ADDR + 0x00008000)
> > +
> > +#define MX50_APBHDMA_BASE_ADDR               (MX50_DEBUG_BASE_ADDR + 0x01000000)
> > +#define MX50_OCOTP_CTRL_BASE_ADDR    (MX50_DEBUG_BASE_ADDR + 0x01002000)
> > +#define MX50_DIGCTL_BASE_ADDR                (MX50_DEBUG_BASE_ADDR + 0x01004000)
> > +#define MX50_GPMI_BASE_ADDR          (MX50_DEBUG_BASE_ADDR + 0x01006000)
> > +#define MX50_BCH_BASE_ADDR           (MX50_DEBUG_BASE_ADDR + 0x01008000)
> > +#define MX50_ELCDIF_BASE_ADDR                (MX50_DEBUG_BASE_ADDR + 0x0100A000)
> > +#define MX50_EPXP_BASE_ADDR          (MX50_DEBUG_BASE_ADDR + 0x0100C000)
> > +#define MX50_DCP_BASE_ADDR           (MX50_DEBUG_BASE_ADDR + 0x0100E000)
> > +#define MX50_EPDC_BASE_ADDR          (MX50_DEBUG_BASE_ADDR + 0x01010000)
> > +#define MX50_QOSC_BASE_ADDR          (MX50_DEBUG_BASE_ADDR + 0x01012000)
> > +#define MX50_PERFMON_BASE_ADDR               (MX50_DEBUG_BASE_ADDR + 0x01014000)
> > +#define MX50_SSP_BASE_ADDR           (MX50_DEBUG_BASE_ADDR + 0x01016000)
> > +#define MX50_ANATOP_BASE_ADDR                (MX50_DEBUG_BASE_ADDR + 0x01018000)
> > +#define MX50_NIC_BASE_ADDR           (MX50_DEBUG_BASE_ADDR + 0x08000000)
> > +
> > +/*
> > + * SPBA global module enabled #0
> > + */
> > +#define MX50_SPBA0_BASE_ADDR         0x50000000
> > +#define MX50_SPBA0_SIZE                      SZ_1M
> > +
> > +#define MX50_MMC_SDHC1_BASE_ADDR     (MX50_SPBA0_BASE_ADDR + 0x00004000)
> > +#define MX50_MMC_SDHC2_BASE_ADDR     (MX50_SPBA0_BASE_ADDR + 0x00008000)
> > +#define MX50_UART3_BASE_ADDR         (MX50_SPBA0_BASE_ADDR + 0x0000C000)
> > +#define MX50_CSPI1_BASE_ADDR         (MX50_SPBA0_BASE_ADDR + 0x00010000)
> > +#define MX50_SSI2_BASE_ADDR          (MX50_SPBA0_BASE_ADDR + 0x00014000)
> > +#define MX50_MMC_SDHC3_BASE_ADDR     (MX50_SPBA0_BASE_ADDR + 0x00020000)
> > +#define MX50_MMC_SDHC4_BASE_ADDR     (MX50_SPBA0_BASE_ADDR + 0x00024000)
> > +
> > +/*
> > + * AIPS 1
> > + */
> > +#define MX50_AIPS1_BASE_ADDR 0x53F00000
> > +#define MX50_AIPS1_SIZE              SZ_1M
> > +
> > +#define MX50_OTG_BASE_ADDR   (MX50_AIPS1_BASE_ADDR + 0x00080000)
> > +#define MX50_GPIO1_BASE_ADDR (MX50_AIPS1_BASE_ADDR + 0x00084000)
> > +#define MX50_GPIO2_BASE_ADDR (MX50_AIPS1_BASE_ADDR + 0x00088000)
> > +#define MX50_GPIO3_BASE_ADDR (MX50_AIPS1_BASE_ADDR + 0x0008C000)
> > +#define MX50_GPIO4_BASE_ADDR (MX50_AIPS1_BASE_ADDR + 0x00090000)
> > +#define MX50_KPP_BASE_ADDR   (MX50_AIPS1_BASE_ADDR + 0x00094000)
> > +#define MX50_WDOG_BASE_ADDR  (MX50_AIPS1_BASE_ADDR + 0x00098000)
> > +#define MX50_GPT1_BASE_ADDR  (MX50_AIPS1_BASE_ADDR + 0x000A0000)
> > +#define MX50_SRTC_BASE_ADDR  (MX50_AIPS1_BASE_ADDR + 0x000A4000)
> > +#define MX50_IOMUXC_BASE_ADDR        (MX50_AIPS1_BASE_ADDR + 0x000A8000)
> > +#define MX50_EPIT1_BASE_ADDR (MX50_AIPS1_BASE_ADDR + 0x000AC000)
> > +#define MX50_PWM1_BASE_ADDR  (MX50_AIPS1_BASE_ADDR + 0x000B4000)
> > +#define MX50_PWM2_BASE_ADDR  (MX50_AIPS1_BASE_ADDR + 0x000B8000)
> > +#define MX50_UART1_BASE_ADDR (MX50_AIPS1_BASE_ADDR + 0x000BC000)
> > +#define MX50_UART2_BASE_ADDR (MX50_AIPS1_BASE_ADDR + 0x000C0000)
> > +#define MX50_SRC_BASE_ADDR   (MX50_AIPS1_BASE_ADDR + 0x000D0000)
> > +#define MX50_CCM_BASE_ADDR   (MX50_AIPS1_BASE_ADDR + 0x000D4000)
> > +#define MX50_GPC_BASE_ADDR   (MX50_AIPS1_BASE_ADDR + 0x000D8000)
> > +#define MX50_GPIO5_BASE_ADDR (MX50_AIPS1_BASE_ADDR + 0x000DC000)
> > +#define MX50_GPIO6_BASE_ADDR (MX50_AIPS1_BASE_ADDR + 0x000E0000)
> > +#define MX50_I2C3_BASE_ADDR  (MX50_AIPS1_BASE_ADDR + 0x000EC000)
> > +#define MX50_UART4_BASE_ADDR (MX50_AIPS1_BASE_ADDR + 0x000F0000)
> > +
> > +#define MX50_MSHC_BASE_ADDR  (MX50_AIPS1_BASE_ADDR + 0x000F4000)
> > +#define MX50_RNGB_BASE_ADDR  (MX50_AIPS1_BASE_ADDR + 0x000F8000)
> > +
> > +/*
> > + * AIPS 2
> > + */
> > +#define MX50_AIPS2_BASE_ADDR 0x63F00000
> > +#define MX50_AIPS2_SIZE              SZ_1M
> > +
> > +#define MX50_PLL1_BASE_ADDR  (MX50_AIPS2_BASE_ADDR + 0x00080000)
> > +#define MX50_PLL2_BASE_ADDR  (MX50_AIPS2_BASE_ADDR + 0x00084000)
> > +#define MX50_PLL3_BASE_ADDR  (MX50_AIPS2_BASE_ADDR + 0x00088000)
> > +#define MX50_UART5_BASE_ADDR (MX50_AIPS2_BASE_ADDR + 0x00090000)
> > +#define MX50_AHBMAX_BASE_ADDR        (MX50_AIPS2_BASE_ADDR + 0x00094000)
> > +#define MX50_ARM_BASE_ADDR   (MX50_AIPS2_BASE_ADDR + 0x000A0000)
> > +#define MX50_OWIRE_BASE_ADDR (MX50_AIPS2_BASE_ADDR + 0x000A4000)
> > +#define MX50_CSPI2_BASE_ADDR (MX50_AIPS2_BASE_ADDR + 0x000AC000)
> > +#define MX50_SDMA_BASE_ADDR  (MX50_AIPS2_BASE_ADDR + 0x000B0000)
> > +#define MX50_ROMCP_BASE_ADDR (MX50_AIPS2_BASE_ADDR + 0x000B8000)
> > +#define MX50_CSPI3_BASE_ADDR (MX50_AIPS2_BASE_ADDR + 0x000C0000)
> > +#define MX50_I2C2_BASE_ADDR  (MX50_AIPS2_BASE_ADDR + 0x000C4000)
> > +#define MX50_I2C1_BASE_ADDR  (MX50_AIPS2_BASE_ADDR + 0x000C8000)
> > +#define MX50_SSI1_BASE_ADDR  (MX50_AIPS2_BASE_ADDR + 0x000CC000)
> > +#define MX50_AUDMUX_BASE_ADDR        (MX50_AIPS2_BASE_ADDR + 0x000D0000)
> > +#define MX50_WEIM_BASE_ADDR  (MX50_AIPS2_BASE_ADDR + 0x000D8000)
> > +#define MX50_MXC_FEC_BASE_ADDR       (MX50_AIPS2_BASE_ADDR + 0x000EC000)
> > +
> > +/*
> > + * Memory regions and CS
> > + */
> > +#define MX50_CSD0_BASE_ADDR          0x70000000
> > +#define MX50_CSD1_BASE_ADDR          0xB0000000
> > +#define MX50_CS0_BASE_ADDR           0xF0000000
> > +
> > +#define MX50_IO_P2V(x)                       IMX_IO_P2V(x)
> > +#define MX50_IO_ADDRESS(x)           IOMEM(MX50_IO_P2V(x))
> > +
> > +/*
> > + * defines for SPBA modules
> > + */
> > +#define MX50_SPBA_SDHC1              0x04
> > +#define MX50_SPBA_SDHC2              0x08
> > +#define MX50_SPBA_UART3              0x0C
> > +#define MX50_SPBA_CSPI1              0x10
> > +#define MX50_SPBA_SSI2               0x14
> > +#define MX50_SPBA_SDHC3              0x20
> > +#define MX50_SPBA_SDHC4              0x24
> > +#define MX50_SPBA_SPDIF              0x28
> > +#define MX50_SPBA_ATA                0x30
> > +#define MX50_SPBA_SLIM               0x34
> > +#define MX50_SPBA_HSI2C              0x38
> > +#define MX50_SPBA_CTRL               0x3C
> > +
> > +/*
> > + * DMA request assignments
> > + */
> > +#define MX50_DMA_REQ_UART3_TX                43
> > +#define MX50_DMA_REQ_UART3_RX                42
> > +#define MX50_DMA_REQ_CSPI_TX         39
> > +#define MX50_DMA_REQ_CSPI_RX         38
> > +#define MX50_DMA_REQ_SSI1_TX1                29
> > +#define MX50_DMA_REQ_SSI1_RX1                28
> > +#define MX50_DMA_REQ_SSI1_TX2                27
> > +#define MX50_DMA_REQ_SSI1_RX2                26
> > +#define MX50_DMA_REQ_SSI2_TX1                25
> > +#define MX50_DMA_REQ_SSI2_RX1                24
> > +#define MX50_DMA_REQ_SSI2_TX2                23
> > +#define MX50_DMA_REQ_SSI2_RX2                22
> > +#define MX50_DMA_REQ_I2C2_SDHC2              21
> > +#define MX50_DMA_REQ_I2C1_SDHC1              20
> > +#define MX50_DMA_REQ_UART1_TX                19
> > +#define MX50_DMA_REQ_UART1_RX                18
> > +#define MX50_DMA_REQ_UART5_TX                17
> > +#define MX50_DMA_REQ_UART5_RX                16
> > +#define MX50_DMA_REQ_EXT1            15
> > +#define MX50_DMA_REQ_EXT0            14
> > +#define MX50_DMA_REQ_UART2_FIRI_TX   13
> > +#define MX50_DMA_REQ_UART2_FIRI_RX   12
> > +#define MX50_DMA_REQ_SDHC4           11
> > +#define MX50_DMA_REQ_I2C3_SDHC3              10
> > +#define MX50_DMA_REQ_CSPI2_TX                9
> > +#define MX50_DMA_REQ_CSPI2_RX                8
> > +#define MX50_DMA_REQ_CSPI1_TX                7
> > +#define MX50_DMA_REQ_CSPI1_RX                6
> > +#define MX50_DMA_REQ_ATA_UART4_TX    3
> > +#define MX50_DMA_REQ_ATA_UART4_RX    2
> > +#define MX50_DMA_REQ_GPC             1
> > +
> > +/*
> > + * Interrupt numbers
> > + */
> > +#define MX50_INT_MMC_SDHC1   1
> > +#define MX50_INT_MMC_SDHC2   2
> > +#define MX50_INT_MMC_SDHC3   3
> > +#define MX50_INT_MMC_SDHC4   4
> > +#define MX50_INT_DAP         5
> > +#define MX50_INT_SDMA                6
> > +#define MX50_INT_IOMUX               7
> > +#define MX50_INT_UART4               13
> > +#define MX50_INT_USB_H1              14
> > +#define MX50_INT_USB_OTG     18
> > +#define MX50_INT_DATABAHN    19
> > +#define MX50_INT_ELCDIF              20
> > +#define MX50_INT_EPXP                21
> > +#define MX50_INT_SRTC_NTZ    24
> > +#define MX50_INT_SRTC_TZ     25
> > +#define MX50_INT_EPDC                27
> > +#define MX50_INT_NIC         28
> > +#define MX50_INT_SSI1                29
> > +#define MX50_INT_SSI2                30
> > +#define MX50_INT_UART1               31
> > +#define MX50_INT_UART2               32
> > +#define MX50_INT_UART3               33
> > +#define MX50_INT_RESV34              34
> > +#define MX50_INT_RESV35              35
> > +#define MX50_INT_CSPI1               36
> > +#define MX50_INT_CSPI2               37
> > +#define MX50_INT_CSPI                38
> > +#define MX50_INT_GPT         39
> > +#define MX50_INT_EPIT1               40
> > +#define MX50_INT_GPIO1_INT7  42
> > +#define MX50_INT_GPIO1_INT6  43
> > +#define MX50_INT_GPIO1_INT5  44
> > +#define MX50_INT_GPIO1_INT4  45
> > +#define MX50_INT_GPIO1_INT3  46
> > +#define MX50_INT_GPIO1_INT2  47
> > +#define MX50_INT_GPIO1_INT1  48
> > +#define MX50_INT_GPIO1_INT0  49
> > +#define MX50_INT_GPIO1_LOW   50
> > +#define MX50_INT_GPIO1_HIGH  51
> > +#define MX50_INT_GPIO2_LOW   52
> > +#define MX50_INT_GPIO2_HIGH  53
> > +#define MX50_INT_GPIO3_LOW   54
> > +#define MX50_INT_GPIO3_HIGH  55
> > +#define MX50_INT_GPIO4_LOW   56
> > +#define MX50_INT_GPIO4_HIGH  57
> > +#define MX50_INT_WDOG1               58
> > +#define MX50_INT_KPP         60
> > +#define MX50_INT_PWM1                61
> > +#define MX50_INT_I2C1                62
> > +#define MX50_INT_I2C2                63
> > +#define MX50_INT_I2C3                64
> > +#define MX50_INT_RESV65              65
> > +#define MX50_INT_DCDC                66
> > +#define MX50_INT_THERMAL_ALARM       67
> > +#define MX50_INT_ANA3                68
> > +#define MX50_INT_ANA4                69
> > +#define MX50_INT_CCM1                71
> > +#define MX50_INT_CCM2                72
> > +#define MX50_INT_GPC1                73
> > +#define MX50_INT_GPC2                74
> > +#define MX50_INT_SRC         75
> > +#define MX50_INT_NM          76
> > +#define MX50_INT_PMU         77
> > +#define MX50_INT_CTI_IRQ     78
> > +#define MX50_INT_CTI1_TG0    79
> > +#define MX50_INT_CTI1_TG1    80
> > +#define MX50_INT_GPU2_IRQ    84
> > +#define MX50_INT_GPU2_BUSY   85
> > +#define MX50_INT_UART5               86
> > +#define MX50_INT_FEC         87
> > +#define MX50_INT_OWIRE               88
> > +#define MX50_INT_CTI1_TG2    89
> > +#define MX50_INT_SJC         90
> > +#define MX50_INT_DCP_CHAN1_3 91
> > +#define MX50_INT_DCP_CHAN0   92
> > +#define MX50_INT_PWM2                94
> > +#define MX50_INT_RNGB                97
> > +#define MX50_INT_CTI1_TG3    98
> > +#define MX50_INT_RAWNAND_BCH 100
> > +#define MX50_INT_RAWNAND_GPMI        102
> > +#define MX50_INT_GPIO5_LOW   103
> > +#define MX50_INT_GPIO5_HIGH  104
> > +#define MX50_INT_GPIO6_LOW   105
> > +#define MX50_INT_GPIO6_HIGH  106
> > +#define MX50_INT_MSHC                109
> > +#define MX50_INT_APBHDMA_CHAN0       110
> > +#define MX50_INT_APBHDMA_CHAN1       111
> > +#define MX50_INT_APBHDMA_CHAN2       112
> > +#define MX50_INT_APBHDMA_CHAN3       113
> > +#define MX50_INT_APBHDMA_CHAN4       114
> > +#define MX50_INT_APBHDMA_CHAN5       115
> > +#define MX50_INT_APBHDMA_CHAN6       116
> > +#define MX50_INT_APBHDMA_CHAN7       117
> > +
> > +#endif /* ifndef __MACH_MX50_H__ */
> > diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
> > index 04afa33..886d9fd 100644
> > --- a/arch/arm/plat-mxc/include/mach/mxc.h
> > +++ b/arch/arm/plat-mxc/include/mach/mxc.h
> > @@ -32,6 +32,7 @@
> >  #define MXC_CPU_MX27         27
> >  #define MXC_CPU_MX31         31
> >  #define MXC_CPU_MX35         35
> > +#define MXC_CPU_MX50         50
> >  #define MXC_CPU_MX51         51
> >  #define MXC_CPU_MX53         53
> >  #define MXC_CPU_MXC91231     91231
> > @@ -131,6 +132,7 @@ extern unsigned int __mxc_cpu_type;
> >  #  undef mxc_cpu_type
> >  # endif
> >  # define mxc_cpu_type __mxc_cpu_type
> > +# define cpu_is_mx50()               (mxc_cpu_type == MXC_CPU_MX50)
> >  # define cpu_is_mx51()               (mxc_cpu_type == MXC_CPU_MX51)
> >  # define cpu_is_mx53()               (mxc_cpu_type == MXC_CPU_MX53)
> >  #else
> This has the same problem as cpu_is_mx53 that I pointed out in the
> review to an earlier patch of this series
Ok.
> 
> Uwe
> 
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
Thanks
Richard
