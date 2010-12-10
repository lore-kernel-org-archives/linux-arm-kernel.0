From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 10 Dec 2010 09:42:48 +0100
Subject: [PATCH 5/6] arm: mx50: add core functions support
In-Reply-To: <20101210070835.GB29383@b20223-2.ap.freescale.net>
References: <1291903716-31388-1-git-send-email-richard.zhao@freescale.com>
	<1291903716-31388-5-git-send-email-richard.zhao@freescale.com>
	<20101209082535.GK17441@pengutronix.de>
	<20101210070835.GB29383@b20223-2.ap.freescale.net>
Message-ID: <20101210084248.GF17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Richard,

On Fri, Dec 10, 2010 at 03:08:35PM +0800, Richard Zhao wrote:
> On Thu, Dec 09, 2010 at 09:25:35AM +0100, Uwe Kleine-K?nig wrote:
> > On Thu, Dec 09, 2010 at 10:08:35PM +0800, Richard Zhao wrote:
> > > +#define WAIT(exp, timeout) \
> > > +({ \
> > > +     struct timespec nstimeofday; \
> > > +     struct timespec curtime; \
> > > +     int result = 1; \
> > > +     getnstimeofday(&nstimeofday); \
> > > +     while (!(exp)) { \
> > > +             getnstimeofday(&curtime); \
> > > +             if ((curtime.tv_nsec - nstimeofday.tv_nsec) > (timeout)) { \
> > > +                     result = 0; \
> > > +                     break; \
> > > +             } \
> > > +     } \
> > > +     result; \
> > this is broken.  Consider getnstimeofday(&nstimeofday) returns with
> > nstimeofday = { .ts_sec = 42, .ts_nsec = 999999999, }.  If timeout is >0
> > the break is never taken.  And furthermore I'm sure that getnstimeofday
> > isn't the right function for that job.
> So, what do I suppose to use? udelay is not accurate here.
I'd just busy-loop bounded by a loop count.  Do you need exact timing
here?

> > > +static void __calc_pre_post_dividers(u32 div, u32 *pre, u32 *post)
> > > +{
> > > +     u32 min_pre, temp_pre, old_err, err;
> > > +
> > > +     if (div >= 512) {
> > > +             *pre = 8;
> > > +             *post = 64;
> > > +     } else if (div >= 8) {
> > > +             min_pre = (div - 1) / 64 + 1;
> > > +             old_err = 8;
> > > +             for (temp_pre = 8; temp_pre >= min_pre; temp_pre--) {
> > > +                     err = div % temp_pre;
> > > +                     if (err == 0) {
> > > +                             *pre = temp_pre;
> > > +                             break;
> > > +                     }
> > > +                     err = temp_pre - err;
> > > +                     if (err < old_err) {
> > > +                             old_err = err;
> > > +                             *pre = temp_pre;
> > > +                     }
> > > +             }
> > > +             *post = (div + *pre - 1) / *pre;
> > > +     } else if (div < 8) {
> > > +             *pre = div;
> > > +             *post = 1;
> > > +     }
> > You seem to have copied an old version of this function.  The similarity
> > to arch/arm/mach-mx5/clock-mx51.c makes me wonder if you shouldn't copy
> > the Copyright lines from there, too.
> It's freescale code. clock-mx51.c is originally freescale code too.
If you copied from Freescale only that's obviously OK.  Still I wonder
about the years.  clock-mx51 has

	 * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
	 * Copyright (C) 2009-2010 Amit Kucheria <amit.kucheria@canonical.com>

while your suggested clock-mx50.c has

	 * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.

> > > +}
> > > +
> > > +static int _clk_enable(struct clk *clk)
> > > +{
> > > +     u32 reg;
> > > +     reg = __raw_readl(clk->enable_reg);
> > > +     reg |= MXC_CCM_CCGRx_CG_MASK << clk->enable_shift;
> > > +     __raw_writel(reg, clk->enable_reg);
> > > +
> > > +     return 0;
> > > +}
> > These functions are refactored in arch/arm/mach-mx5/clock-mx51.c in the
> > meantime, too.
> Do you mean _clk_ccgr_xxx? Do I need to abstract common file clock.c, or 
> just repeat the function?
See Sascha's comment.  I agree that it makes sense to get the
common clock stuff in first.  With that I have the hope that we can
simplify here considerably.

> > > +static unsigned long pfd_round_rate(struct clk *clk, unsigned long rate)
> > > +{
> > > +     u32 frac;
> > > +     u64 tmp;
> > > +     tmp = (u64)clk_get_rate(clk->parent) * 18;
> > This can overflow e.g. when parent = apll
> 480M * 18 = 0x202FBF000, u64 can not overflow.
ah, missed that u64.

> > 
> > > +     do_div(tmp, rate);
> > > +     frac = tmp;
> > > +     frac = frac < 18 ? 18 : frac;
> > > +     frac = frac > 35 ? 35 : frac;
> > I remember having seen something like:
> > 
> > #define CLAMP(x, low, high) ((x) < (low) ? (low) : ((x) > (high) ? (high) : (x)))
> > 
> > Maybe this is something for <linux/kernel.h>, probably with better
> > typing.
> Yes, thanks. it's  clamp(val, min, max).
ah, anticipatory obedience :-)

> > > +     /* clear clk frac bits */
> > > +     __raw_writel(MXC_ANADIG_PFD_FRAC_MASK << clk->enable_shift,
> > > +                     apll_base + (int)clk->enable_reg + 8);
> > What is 8?
> Its read/set/clear reg are three different reg. The ip is from mxs series.
> I can add a MXC_SET_OFFSET and MXC_CLEAR_OFFSET macro in crm-regs-mx50.h, if you need it.
ah, ok.  The (suggested) mxs barebox port uses 4 and 8, too.  I wonder
if it makes sense to introduce

	#define __raw_setl(val, addr)	__raw_writel(val, addr + 4)

and analogous __raw_clearl.  That together with a more defensive way to
define it.  (I.e. cast addr to char* (?) and __iomem (?) and use the
usual parenthesis.)

> > > diff --git a/arch/arm/mach-mx5/crm_regs-mx50.h b/arch/arm/mach-mx5/crm_regs-mx50.h
> > > new file mode 100644
> > > index 0000000..f57e93c
> > > --- /dev/null
> > > +++ b/arch/arm/mach-mx5/crm_regs-mx50.h
> > > @@ -0,0 +1,607 @@
> > > +/*
> > > + * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
> > > + *
> > > + * The code contained herein is licensed under the GNU General Public
> > > + * License. You may obtain a copy of the GNU General Public License
> > > + * Version 2 or later at the following locations:
> > Does that mean GPL v1 may be applied or not?
> Does it need to mention all GPL version?
I like specifying the exact terms.  Some people consider saying "version
X or later" OK.  So "licensed under the GNU General Public License"
without a version might be OK for you.  But then saying where to find a
copy of the GPL v2 or later seems strange to me.

>                                          I saw other files have such header too.
IMHO that's a bad excuse.  Feel free to make your work better than the
people before you!

> > > +/*
> > > + * Define the MX50 memory map.
> > > + */
> > > +static struct map_desc mx50_io_desc[] __initdata = {
> > > +     imx_map_entry(MX50, AIPS1, MT_DEVICE),
> > > +     imx_map_entry(MX50, SPBA0, MT_DEVICE),
> > > +     imx_map_entry(MX50, AIPS2, MT_DEVICE),
> > Did you verify that the exiting function works for mx50?
> Yes, I calculated the physical->virtual map, no overlap.
> And ccm and uart works.
OK, I added mx50 to my script that generates the comment for IMX_IOP2V.
(And it confirms your findings :-)

> > > +void __init mx50_init_irq(void)
> > > +{
> > > +     unsigned long tzic_addr;
> > > +     void __iomem *tzic_virt;
> > > +
> > > +     tzic_addr = MX50_TZIC_BASE_ADDR;
> > > +
> > > +     tzic_virt = ioremap(tzic_addr, SZ_16K);
> > > +     if (!tzic_virt)
> > > +             panic("unable to map TZIC interrupt controller\n");
> > Is it really necessary for soc code to map the irq controller?  If yes
> > that needs to be changed.
> TZIC is in on-chip memory section. It's a large memory region. It's hare to
> use current memory map routines to map it. I mean imx_map_entry.
Hmm, MX50_TZIC_BASE_ADDR is at 0x0fffc000.  If you add it to the
statically mapped memory, your map looks as follows:

 *	TZIC	0x0fffc000+0x004000	->	0xf4bfc000+0x004000
 *	SPBA0	0x50000000+0x100000	->	0xf5400000+0x100000
 *	AIPS1	0x53f00000+0x100000	->	0xf5700000+0x100000
 *	AIPS2	0x63f00000+0x100000	->	0xf5300000+0x100000

which is OK, isn't it?

> > > +/*
> > > + * various IOMUX alternate output functions (1-7)
> > > + */
> > > +enum iomux_config {
> > > +     IOMUX_CONFIG_ALT0,
> > > +     IOMUX_CONFIG_ALT1,
> > > +     IOMUX_CONFIG_ALT2,
> > > +     IOMUX_CONFIG_ALT3,
> > > +     IOMUX_CONFIG_ALT4,
> > > +     IOMUX_CONFIG_ALT5,
> > > +     IOMUX_CONFIG_ALT6,
> > > +     IOMUX_CONFIG_ALT7,
> > > +     IOMUX_CONFIG_GPIO,      /* added to help user use GPIO mode */
> > > +     IOMUX_CONFIG_SION = 0x1 << 4,   /* LOOPBACK:MUX SION bit */
> > > +};
> > Shouldn't that go into iomux-v3.h?
> Yes. I added it here because I saw other file also defined it.
> I can send out a new patch to move it.
Yes, that's a seperate patch at the beginning of the series, please.

> > > diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
> > > index e42e9e4..a085bf2 100644
> > > --- a/arch/arm/plat-mxc/include/mach/irqs.h
> > > +++ b/arch/arm/plat-mxc/include/mach/irqs.h
> > > @@ -29,6 +29,8 @@
> > >  #define MXC_GPIO_IRQS                (32 * 4)
> > >  #elif defined CONFIG_ARCH_MX25
> > >  #define MXC_GPIO_IRQS                (32 * 4)
> > > +#elif defined CONFIG_SOC_IMX50
> > > +#define MXC_GPIO_IRQS                (32 * 6)
> > >  #elif defined CONFIG_SOC_IMX51
> > >  #define MXC_GPIO_IRQS                (32 * 4)
> > >  #elif defined CONFIG_ARCH_MXC91231
> > That is if you have a kernel with support for mx25 and mx50 you end up
> > with MXC_GPIO_IRQS being defined as (32 * 4).
> ok, I will move it to the first place. Anyway, I think it's just a work around for mult-SoC support.
It's needed as long was we need to specify the number of irqs.  Unless
when using sparse irq it's good to keep this number low.  So this is the
strait forward approach.

> > > diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
> > > index 9a9a000..5022c32 100644
> > > --- a/arch/arm/plat-mxc/include/mach/memory.h
> > > +++ b/arch/arm/plat-mxc/include/mach/memory.h
> > > @@ -16,6 +16,7 @@
> > >  #define MX25_PHYS_OFFSET     UL(0x80000000)
> > >  #define MX27_PHYS_OFFSET     UL(0xa0000000)
> > >  #define MX3x_PHYS_OFFSET     UL(0x80000000)
> > > +#define MX50_PHYS_OFFSET     UL(0x70000000)
> > >  #define MX51_PHYS_OFFSET     UL(0x90000000)
> > >  #define MX53_PHYS_OFFSET     UL(0x70000000)
> > >  #define MXC91231_PHYS_OFFSET UL(0x90000000)
> > > @@ -33,6 +34,8 @@
> > >  #  define PHYS_OFFSET                MX3x_PHYS_OFFSET
> > >  # elif defined CONFIG_ARCH_MXC91231
> > >  #  define PHYS_OFFSET                MXC91231_PHYS_OFFSET
> > > +# elif defined CONFIG_SOC_IMX50
> > > +#  define PHYS_OFFSET                MX50_PHYS_OFFSET
> > I think introducing ARCH_MX50 would be nice and using it e.g. here.
> Why? Isn't it redundant? They're all soc level macro.
Right from a technical pov.  For maintainability they have a different
meaning.  That is, ARCH_... needs further addressing for multi-SOC.  I
really like being able to grep for these places.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
