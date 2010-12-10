From: linuxzsc@gmail.com (Richard Zhao)
Date: Fri, 10 Dec 2010 20:51:11 +0800
Subject: [PATCH 5/6] arm: mx50: add core functions support
In-Reply-To: <20101210105653.GI17441@pengutronix.de>
References: <1291903716-31388-1-git-send-email-richard.zhao@freescale.com>
	<1291903716-31388-5-git-send-email-richard.zhao@freescale.com>
	<20101209082535.GK17441@pengutronix.de>
	<20101210070835.GB29383@b20223-2.ap.freescale.net>
	<20101210084248.GF17441@pengutronix.de>
	<20101210093000.GA29588@b20223-2.ap.freescale.net>
	<20101210105653.GI17441@pengutronix.de>
Message-ID: <AANLkTikiPkP_u3f95ivVbr5Sj-3xGw_2CPWSAgJO=+2N@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/12/10 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Richard,
>
> On Fri, Dec 10, 2010 at 05:30:00PM +0800, Richard Zhao wrote:
>> On Fri, Dec 10, 2010 at 09:42:48AM +0100, Uwe Kleine-K?nig wrote:
>> > On Fri, Dec 10, 2010 at 03:08:35PM +0800, Richard Zhao wrote:
>> > > On Thu, Dec 09, 2010 at 09:25:35AM +0100, Uwe Kleine-K?nig wrote:
>> > > > On Thu, Dec 09, 2010 at 10:08:35PM +0800, Richard Zhao wrote:
>> > > > > +#define WAIT(exp, timeout) \
>> > > > > +({ \
>> > > > > + ? ? struct timespec nstimeofday; \
>> > > > > + ? ? struct timespec curtime; \
>> > > > > + ? ? int result = 1; \
>> > > > > + ? ? getnstimeofday(&nstimeofday); \
>> > > > > + ? ? while (!(exp)) { \
>> > > > > + ? ? ? ? ? ? getnstimeofday(&curtime); \
>> > > > > + ? ? ? ? ? ? if ((curtime.tv_nsec - nstimeofday.tv_nsec) > (timeout)) { \
>> > > > > + ? ? ? ? ? ? ? ? ? ? result = 0; \
>> > > > > + ? ? ? ? ? ? ? ? ? ? break; \
>> > > > > + ? ? ? ? ? ? } \
>> > > > > + ? ? } \
>> > > > > + ? ? result; \
>> > > > this is broken. ?Consider getnstimeofday(&nstimeofday) returns with
>> > > > nstimeofday = { .ts_sec = 42, .ts_nsec = 999999999, }. ?If timeout is >0
>> > > > the break is never taken. ?And furthermore I'm sure that getnstimeofday
>> > > > isn't the right function for that job.
>> > > So, what do I suppose to use? udelay is not accurate here.
>> > I'd just busy-loop bounded by a loop count. ?Do you need exact timing
>> > here?
>> Yes. If the time is too short, the system may hang.
> What is the unit of the needed time? ?If it's clock ticks a busy loop is
> fine. ?Why udelay isn't accurate enough?
In most cases, it's some specific clock cycles.
udelay may depend on calibrate_delay(). I first used udelay, but it
won't work anyway, so I changed it to getnstimeofday.
I need to add a abs here to avoid overflow.
>
>> > > > > +static void __calc_pre_post_dividers(u32 div, u32 *pre, u32 *post)
>> > > > > +{
>> > > > > + ? ? u32 min_pre, temp_pre, old_err, err;
>> > > > > +
>> > > > > + ? ? if (div >= 512) {
>> > > > > + ? ? ? ? ? ? *pre = 8;
>> > > > > + ? ? ? ? ? ? *post = 64;
>> > > > > + ? ? } else if (div >= 8) {
>> > > > > + ? ? ? ? ? ? min_pre = (div - 1) / 64 + 1;
>> > > > > + ? ? ? ? ? ? old_err = 8;
>> > > > > + ? ? ? ? ? ? for (temp_pre = 8; temp_pre >= min_pre; temp_pre--) {
>> > > > > + ? ? ? ? ? ? ? ? ? ? err = div % temp_pre;
>> > > > > + ? ? ? ? ? ? ? ? ? ? if (err == 0) {
>> > > > > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? *pre = temp_pre;
>> > > > > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
>> > > > > + ? ? ? ? ? ? ? ? ? ? }
>> > > > > + ? ? ? ? ? ? ? ? ? ? err = temp_pre - err;
>> > > > > + ? ? ? ? ? ? ? ? ? ? if (err < old_err) {
>> > > > > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? old_err = err;
>> > > > > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? *pre = temp_pre;
>> > > > > + ? ? ? ? ? ? ? ? ? ? }
>> > > > > + ? ? ? ? ? ? }
>> > > > > + ? ? ? ? ? ? *post = (div + *pre - 1) / *pre;
>> > > > > + ? ? } else if (div < 8) {
>> > > > > + ? ? ? ? ? ? *pre = div;
>> > > > > + ? ? ? ? ? ? *post = 1;
>> > > > > + ? ? }
>> > > > You seem to have copied an old version of this function. ?The similarity
>> > > > to arch/arm/mach-mx5/clock-mx51.c makes me wonder if you shouldn't copy
>> > > > the Copyright lines from there, too.
>> > > It's freescale code. clock-mx51.c is originally freescale code too.
>> > If you copied from Freescale only that's obviously OK. ?Still I wonder
>> > about the years. ?clock-mx51 has
>> >
>> > ? ? ? ? ?* Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
>> > ? ? ? ? ?* Copyright (C) 2009-2010 Amit Kucheria <amit.kucheria@canonical.com>
>> >
>> > while your suggested clock-mx50.c has
>> >
>> > ? ? ? ? ?* Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
>> It's because this file was created in 2010.
> INAL, but I think it's in your (and/or your employer's) interest to have
> an early date here.
I'll check with professional.
>
>> > > > > +static int _clk_enable(struct clk *clk)
>> > > > > +{
>> > > > > + ? ? u32 reg;
>> > > > > + ? ? reg = __raw_readl(clk->enable_reg);
>> > > > > + ? ? reg |= MXC_CCM_CCGRx_CG_MASK << clk->enable_shift;
>> > > > > + ? ? __raw_writel(reg, clk->enable_reg);
>> > > > > +
>> > > > > + ? ? return 0;
>> > > > > +}
>> > > > These functions are refactored in arch/arm/mach-mx5/clock-mx51.c in the
>> > > > meantime, too.
>> > > Do you mean _clk_ccgr_xxx? Do I need to abstract common file clock.c, or
>> > > just repeat the function?
>> > See Sascha's comment. ?I agree that it makes sense to get the
>> > common clock stuff in first. ?With that I have the hope that we can
>> > simplify here considerably.
>> Where should I put the common code? plat-mxc or mach-mx5?
>> Is it ok for you if I only share the code between mx5x?
> hmm, don't know yet. ?This needs a deeper comparison in my opinion.
ok. I will look at mx3 and mx5.
>
>> /*
>> ?* Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
>> ?*
>> ?* The code contained herein is licensed under the GNU General Public
>> ?* License. You may obtain a copy of the GNU General Public License
>> ?* at the following locations:
>> ?*
>> ?* http://www.opensource.org/licenses/gpl-license.html
>> ?* http://www.gnu.org/copyleft/gpl.html
>> ?*/
>> Is above ok?
> I think this is something Freescale has to decide. ?I prefer the
> statement I wrote e.g. in arch/arm/plat-mxc/devices/platform-imx-dma.c,
> but as I said, it's up to you.
I will check with professional, and use the official one.
>
>> > > > > + ? ? tzic_virt = ioremap(tzic_addr, SZ_16K);
>> > > > > + ? ? if (!tzic_virt)
>> > > > > + ? ? ? ? ? ? panic("unable to map TZIC interrupt controller\n");
>> > > > Is it really necessary for soc code to map the irq controller? ?If yes
>> > > > that needs to be changed.
>> > > TZIC is in on-chip memory section. It's a large memory region. It's hare to
>> > > use current memory map routines to map it. I mean imx_map_entry.
>> > Hmm, MX50_TZIC_BASE_ADDR is at 0x0fffc000. ?If you add it to the
>> > statically mapped memory, your map looks as follows:
>> >
>> > ?* ? ? ?TZIC ? ?0x0fffc000+0x004000 ? ? -> ? ? ?0xf4bfc000+0x004000
>> > ?* ? ? ?SPBA0 ? 0x50000000+0x100000 ? ? -> ? ? ?0xf5400000+0x100000
>> > ?* ? ? ?AIPS1 ? 0x53f00000+0x100000 ? ? -> ? ? ?0xf5700000+0x100000
>> > ?* ? ? ?AIPS2 ? 0x63f00000+0x100000 ? ? -> ? ? ?0xf5300000+0x100000
>> >
>> > which is OK, isn't it?
>> Great! I will add a macro MX50_TZIC_SIZE.
> And maybe do the same for mx51.
ok
>
>> > > > > ?# ?define PHYS_OFFSET ? ? ? ? ? ? ? ?MX3x_PHYS_OFFSET
>> > > > > ?# elif defined CONFIG_ARCH_MXC91231
>> > > > > ?# ?define PHYS_OFFSET ? ? ? ? ? ? ? ?MXC91231_PHYS_OFFSET
>> > > > > +# elif defined CONFIG_SOC_IMX50
>> > > > > +# ?define PHYS_OFFSET ? ? ? ? ? ? ? ?MX50_PHYS_OFFSET
>> > > > I think introducing ARCH_MX50 would be nice and using it e.g. here.
>> > > Why? Isn't it redundant? They're all soc level macro.
>> > Right from a technical pov. ?For maintainability they have a different
>> > meaning. ?That is, ARCH_... needs further addressing for multi-SOC. ?I
>> > really like being able to grep for these places.
>> Is it the only reason that be easy to grep? I really think we only need one of
>> them, either a or b.
> IMHO the reason is good enough.
Both you and Sascha have made your decision? Then, OK.
No other platforms use SOC_XXX, I really can not understand the meaning.
>
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
Thanks
Richard
>
