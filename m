From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 5 Sep 2012 12:52:47 +0000
Subject: [st-ericsson] [PATCH 15/17] mfd: dbx540-prcmu creation
In-Reply-To: <CACRpkdavDUEvJukHfSFqG8-ueDDo+86SzoV1SA0ZdWghuUxTPg@mail.gmail.com>
References: <1346839153-6465-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <201209051210.04880.arnd@arndb.de>
 <CACRpkdavDUEvJukHfSFqG8-ueDDo+86SzoV1SA0ZdWghuUxTPg@mail.gmail.com>
Message-ID: <201209051252.48099.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 September 2012, Linus Walleij wrote:
> On Wed, Sep 5, 2012 at 2:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 05 September 2012, Loic Pallardy wrote:

> >> +#define PRCM_PLLDSITV_FREQ         (_PRCMU_BASE + 0x500)
> >> +#define PRCM_PLLDSITV_ENABLE       (_PRCMU_BASE + 0x504)
> >> +#define PRCM_PLLDSITV_LOCKP        (_PRCMU_BASE + 0x508)
> >> +#define PRCM_PLLDSILCD_FREQ        (_PRCMU_BASE + 0x290)
> >> +#define PRCM_PLLDSILCD_ENABLE      (_PRCMU_BASE + 0x294)
> >> +#define PRCM_PLLDSILCD_LOCKP       (_PRCMU_BASE + 0x298)
> >
> > Please get rid of the global _PRCMU_BASE variable, at least for new
> > code. Instead, please use ioremap() of the resources passed in the
> > device tree, like we do for all other drivers.
> 
> Sounds reasonable, but historically we needed to write and control the
> PRCMU before ioremap() is available. (Like at irq_init() time.)
> 
> If I'm not mistaken this has been fixed now, so what you say is true.

Ok, very good.

> >> +#define CLK_MGT_ENTRY(_name, _branch, _clk38div)[PRCMU_##_name] = \
> >> +     { (PRCM_##_name##_MGT), 0 , _branch, _clk38div}
> >> +static struct clk_mgt clk_mgt[PRCMU_NUM_REG_CLOCKS] = {
> >> +     CLK_MGT_ENTRY(SGACLK, PLL_DIV, false),
> >> +     CLK_MGT_ENTRY(UARTCLK, PLL_FIX, true),
> >(...)
> > Another option would be to put the table into the device tree so you
> > can abstract the differences between the two prmu versions more easily.
> 
> This falls back to the debate of whether SoC properties shall be
> heavily encoded into the device tree, a point of contention. Doing
> that may make the driver even harder to read than these macros,
> like you need the driver, the device tree and the data sheet and
> read all three simultaneously to understand what is going on.

Yes, and I'll gladly leave the choice of how far to move stuff into the
device tree in your hands as the platform maintainer, as you can best
tell how many other prcmu variants we are going to see in the future.
Generally, I think there is a stronger reason for putting stuff into
DT when you have a lot of chips that only differ in this data.

> >> +/**
> >> + * replug_cpu1 - Power gate ON CPU1 for U9540
> >> + * * void
> >> + * * Returns:
> >> + */
> >> +static int replug_cpu1(void)
> >> +{
> >> +     int r = 0;
> >> +#ifdef CONFIG_UX500_ROMCODE_SHARED_MUTEX
> >> +     struct upap_req req;
> >> +     struct upap_ack ack;
> >
> > Can you move these to a separate cpu-hotplug file?
> 
> Isn't this a more general comment such as that we should distribute
> out the code in the PRCMU out into the device drivers? I think you or
> someone else said that at some point, and that would then go for
> all of them I think, then the PRCMU driver would just be a MFD
> hub and mailbox/regmap provider in the end.
> 
> How to get there is another question...

Right. Splitting out the mailboxes and the clock handling would probably
a good step in that direction, then we can see what is left in the
MFD driver.

> >> +static unsigned long dbx540_prcmu_clock_rate(u8 clock)
> >> +{
> >> +     if (clock < PRCMU_NUM_REG_CLOCKS)
> >> +             return clock_rate(clock);
> >> +     else if (clock == PRCMU_TIMCLK)
> >> +             return ROOT_CLOCK_RATE / 16;
> >> +     else if (clock == PRCMU_SYSCLK)
> >> +             return ROOT_CLOCK_RATE;
> >> +     else if (clock == PRCMU_PLLSOC0)
> >> +             return pll_rate(PRCM_PLLSOC0_FREQ, ROOT_CLOCK_RATE, PLL_RAW);
> >> +     else if (clock == PRCMU_PLLSOC1)
> >> +             return pll_rate(PRCM_PLLSOC1_FREQ, ROOT_CLOCK_RATE, PLL_RAW);
> >> +     else if (clock == PRCMU_PLLDDR)
> >> +             return pll_rate(PRCM_PLLDDR_FREQ, ROOT_CLOCK_RATE, PLL_RAW);
> >> +     else if (clock == PRCMU_PLLDSI)
> >> +             return pll_rate(PRCM_PLLDSITV_FREQ, clock_rate(PRCMU_HDMICLK),
> >> +                     PLL_RAW);
> >> +     else if (clock == PRCMU_ARMSS)
> >> +             return KHZ_TO_HZ(armss_rate());
> >> +     else if (clock == PRCMU_ARMCLK)
> >> +             return KHZ_TO_HZ(get_arm_freq());
> >> +     else if ((clock == PRCMU_DSI0CLK) || (clock == PRCMU_DSI1CLK))
> >> +             return dsiclk_rate(clock - PRCMU_DSI0CLK, false);
> >> +     else if ((PRCMU_DSI0ESCCLK <= clock) && (clock <= PRCMU_DSI2ESCCLK))
> >> +             return dsiescclk_rate(clock - PRCMU_DSI0ESCCLK);
> >> +     else if (clock == PRCMU_PLLDSI_LCD)
> >> +             return pll_rate(PRCM_PLLDSILCD_FREQ,
> >> +                                     clock_rate(PRCMU_SPARE1CLK), PLL_RAW);
> >> +     else if ((clock == PRCMU_DSI0CLK_LCD) || (clock == PRCMU_DSI1CLK_LCD))
> >> +             return dsiclk_rate(clock - PRCMU_DSI0CLK_LCD, true);
> >> +     else
> >> +             return 0;
> >> +}
> >
> > Please use the common clock code for managing these.
> > No more private clock implementations.
> 
> So here again there is a driver split issue. I think Ulf's current clock
> implementation just use these implementations, so this would be a matter
> of pushing that code down into the clock driver and decentralize this
> PRCMU driver a bit more.

Right, I think the clock driver should really be the place that knows about
the different kinds of clocks, rather than just calling into a different
driver that handles all the details.

	Arnd
