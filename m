From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Dec 2010 08:27:50 +0100
Subject: [PATCH v2 03/15] ARM: mxs: Add reset routines
In-Reply-To: <AANLkTinavvbQFGQhcAZF+ZBV1OuiZYu0XaBYSM7YuuKG@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291031956-30314-3-git-send-email-shawn.guo@freescale.com>
	<20101130102505.GG20449@pengutronix.de>
	<AANLkTinavvbQFGQhcAZF+ZBV1OuiZYu0XaBYSM7YuuKG@mail.gmail.com>
Message-ID: <20101202072750.GM32355@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Thu, Dec 02, 2010 at 02:02:39PM +0800, Shawn Guo wrote:
> Hi Uwe,
> 
> 2010/11/30 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello,
> >
> [...]
> >
> >> + ? ? /* Poll CLKGATE set */
> >> + ? ? timeout = 0x400;
> >> + ? ? while ((!(__raw_readl(reset_addr) & MXS_MODULE_CLKGATE)) && --timeout)
> >> + ? ? ? ? ? ? /* nothing */;
> >> + ? ? if (!timeout)
> >> + ? ? ? ? ? ? goto error;
> >> +
> >> + ? ? /* Clear SFTRST */
> >> + ? ? val = __raw_readl(reset_addr);
> >> + ? ? val &= ~MXS_MODULE_SFTRST;
> >> + ? ? __raw_writel(val, reset_addr);
> >> + ? ? /* Wait 1us */
> >> + ? ? udelay(1);
> >> + ? ? /* Poll SFTRST cleared */
> >> + ? ? timeout = 0x400;
> >> + ? ? while ((__raw_readl(reset_addr) & MXS_MODULE_SFTRST) && --timeout)
> >> + ? ? ? ? ? ? /* nothing */;
> >> + ? ? if (!timeout)
> >> + ? ? ? ? ? ? goto error;
> >> +
> >> + ? ? /* Clear CLKGATE */
> >> + ? ? val = __raw_readl(reset_addr);
> >> + ? ? val &= ~MXS_MODULE_CLKGATE;
> >> + ? ? __raw_writel(val, reset_addr);
> >> + ? ? /* Wait 1us */
> >> + ? ? udelay(1);
> >> + ? ? /* Poll CLKGATE cleared */
> >> + ? ? timeout = 0x400;
> >> + ? ? while ((__raw_readl(reset_addr) & MXS_MODULE_CLKGATE) && --timeout)
> >> + ? ? ? ? ? ? /* nothing */;
> >> + ? ? if (!timeout)
> >> + ? ? ? ? ? ? goto error;
> >
> > There are quite some repetitions in this function. ?If you could get it
> > down to something that looks like
> >
> > ? ? ? ?clear SFTRST
> > ? ? ? ?udelay
> > ? ? ? ?poll SFTRST cleared
> >
> > ? ? ? ?clear CLKGATE
> > ? ? ? ?set SFTRST
> > ? ? ? ?udelay
> > ? ? ? ?poll CLKGATE set
> >
> > ? ? ? ?clear SFTRST
> > ? ? ? ?udelay
> > ? ? ? ?poll SFTRST cleared
> >
> > ? ? ? ?clear CLKGATE
> > ? ? ? ?udelay
> > ? ? ? ?poll CLKGATE cleared
> >
> > it's IMHO better than the comment above. ?If "clear CLKGATE" and "set
> > SFTRST" can be done in a single step this might be done like that:
> >
> > ? ? ? ?/* comment describing setmask_poll */
> > ? ? ? ?static int setmask_poll(void __iomem *addr, u32 set, u32 mask,
> > ? ? ? ? ? ? ? ?u32 pollval, u32 pollmask, u32 *curval)
> > ? ? ? ?{
> > ? ? ? ? ? ? ? ?int timeout = 0x400;
> >
> > ? ? ? ? ? ? ? ?*curval &= ~mask;
> > ? ? ? ? ? ? ? ?*curval |= set;
> > ? ? ? ? ? ? ? ?__raw_writel(*curval, addr)
> >
> > ? ? ? ? ? ? ? ?/*
> > ? ? ? ? ? ? ? ? * some nice comment about 1us being a good idea
> > ? ? ? ? ? ? ? ? */
> > ? ? ? ? ? ? ? ?udelay(1);
> >
> > ? ? ? ? ? ? ? ?do {
> > ? ? ? ? ? ? ? ? ? ? ? ?*curval = __raw_readl(addr);
> > ? ? ? ? ? ? ? ? ? ? ? ?if ((*curval & pollmask) == pollval)
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?return 0;
> >
> > ? ? ? ? ? ? ? ?} while(--timeout);
> >
> > ? ? ? ? ? ? ? ?return 1;
> > ? ? ? ?}
> >
> > ? ? ? ?int mxs_reset_block(void __iomem *reset_addr)
> > ? ? ? ?{
> > ? ? ? ? ? ? ? ?u32 val = __raw_readl(reset_addr);
> > ? ? ? ? ? ? ? ?int ret;
> >
> > ? ? ? ? ? ? ? ?/* clear SFTRST and poll SFTRST becoming clear */
> > ? ? ? ? ? ? ? ?ret = setmask_poll(reset_addr,
> > ? ? ? ? ? ? ? ? ? ? ? ?0, MXS_MODULE_SFTRST,
> > ? ? ? ? ? ? ? ? ? ? ? ?0, MXS_MODULE_SFTRST, &val);
> > ? ? ? ? ? ? ? ?if (ret)
> > ? ? ? ? ? ? ? ? ? ? ? ?goto error;
> >
> > ? ? ? ? ? ? ? ?/* clear CLKGATE, set SFTRST and poll CLKGATE becoming set */
> > ? ? ? ? ? ? ? ?ret = setmask_poll(reset_addr,
> > ? ? ? ? ? ? ? ? ? ? ? ?MXS_MODULE_SFTRST, MXS_MODULE_SFTRST | MXS_MODULE_CLKGATE,
> > ? ? ? ? ? ? ? ? ? ? ? ?0, MXS_MODULE_CLKGATE, &val);
> > ? ? ? ? ? ? ? ?if (ret)
> > ? ? ? ? ? ? ? ? ? ? ? ?goto error;
> >
> > ? ? ? ? ? ? ? ?...
> > ? ? ? ?}
> >
> > Well, not very nice, but IMHO better that your code. ?Maybe
> > mxs_reset_block fits in a Terminal that way without decreasing the font
> > size :-)
> >
> I checked designer about doing "clear CLKGATE" and "set SFTRST" in a
> single step, and got the following feedback.
> 
> "Per HW design, it is not safe to get those two done by write once
> time. By two step write, one instruction period interval can be
> ensured at least for clock  enabling before sync. Soft reset.  Your
> code is only once time write in fact, so it shall not be equal to two
> write operation."
> 
> In this case, how do the following changes look to you?
> 
> /*
>  * Clear the bit and poll it cleared, the bit has to be
>  * SFTRST(bit 31) or CLKGATE (bit 30) of block control register.
for the function it doesn't have to be one of these bits.  Maybe:

	Clear the bit and poll it cleared.  This is usually called with
	a reset address and mask being either SFTRST(bit 31) or CLKGATE
	(bit 30).

>  */
> static int clear_poll_bit(void __iomem *addr, u32 mask)
> {
>         int timeout = 0x400;
> 
>         /* clear the bit */
>         __raw_writel(mask, addr + MXS_CLR_ADDR);
ah, so there is a clr register, that's nice.

> 
>         /*
>          * SFTRST needs 3 GPMI clocks to settle, the reference manual
>          * recommends to wait 1us.
>          */
>         udelay(1);
> 
>         /* poll the bit becoming clear */
>         while ((__raw_readl(addr) & mask) && --timeout)
>                 /* nothing */;
> 
>         if (unlikely(!timeout))
>                 return 1;
> 
>         return 0;
return !timeout; ?

> }
> 
> int mxs_reset_block(void __iomem *reset_addr)
> {
>         int ret;
>         int timeout = 0x400;
> 
>         /* clear and poll SFTRST */
>         ret = clear_poll_bit(reset_addr, MXS_MODULE_SFTRST);
>         if (ret)
>                 goto error;
> 
>         /* clear CLKGATE */
>         __raw_writel(MXS_MODULE_CLKGATE, reset_addr + MXS_CLR_ADDR);
>         /* set SFTRST to reset the block */
>         __raw_writel(MXS_MODULE_SFTRST, reset_addr + MXS_SET_ADDR);
>         udelay(1);
>         /* poll CLKGATE becoming set */
>         while ((!(__raw_readl(reset_addr) & MXS_MODULE_CLKGATE)) && --timeout)
>                 /* nothing */;
>         if (unlikely(!timeout))
>                 goto error;
> 
>         /* clear and poll SFTRST */
>         ret = clear_poll_bit(reset_addr, MXS_MODULE_SFTRST);
>         if (ret)
>                 goto error;
> 
>         /* clear and poll CLKGATE */
>         ret = clear_poll_bit(reset_addr, MXS_MODULE_CLKGATE);
>         if (ret)
>                 goto error;
> 
	return 0;

> error:
>         pr_err("%s(%p): module reset timeout\n", __func__, reset_addr);
>         return -ETIMEDOUT;
> }
Other than that it looks much better IMHO.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
