From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 1 Dec 2010 11:59:04 +0100
Subject: [PATCH v2 03/15] ARM: mxs: Add reset routines
In-Reply-To: <AANLkTimvA2VUE0rGVorvtq607FOkZJDc4Mb4UTAF+ZAj@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291031956-30314-3-git-send-email-shawn.guo@freescale.com>
	<20101130102505.GG20449@pengutronix.de>
	<AANLkTimvA2VUE0rGVorvtq607FOkZJDc4Mb4UTAF+ZAj@mail.gmail.com>
Message-ID: <20101201105904.GF32355@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 01, 2010 at 06:45:20PM +0800, Shawn Guo wrote:
> Hi Uwe,
> 
> 2010/11/30 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello,
> >
> > On Mon, Nov 29, 2010 at 07:59:13PM +0800, Shawn Guo wrote:
> >> +/*
> >> + * Reset the system. It is called by machine_restart().
> >> + */
> >> +void arch_reset(char mode, const char *cmd)
> >> +{
> >> + ? ? /* Set wdog count */
> >> + ? ? __raw_writel(1, wdog_base + MXS_RTC_WATCHDOG);
> > Which unit is used here? ?Does the timer only start running when it's
> > enabled below? ?Does this apply when the watchdog is already in use,
> > too?
> >
> The unit RTC (i.MX28 RM chapter 22) which has watchdog function inside
> is used here.
"unit" was meant as in "seconds".  I assume it means seconds below, but
it doesn't matter much.

> Good catch here.  I thought the watchdog counter only starts counting
> after WATCHDOG_EN is set.  But I just confirmed it with designer that
> the watchdog counter starts counting once CLKGATE is cleared, and
> WATCHDOG_EN bit only controls the watchdog reset generation.  Even in
> this case, 1ms should be long enough for the WATCHDOG_EN setting below
> to get executed before counter goes to 0.  What is your concern here?
My concern is that it might happen that even though the timer is set to
1s, the first change happens nearly immediatly resulting in a zero.
Depending on the hardware a reset occurs when the enable bit is only set
after the counter reached zero.
 
> I should change mdelay(500) to mdelay(1).
> 
> >> +
> >> + ? ? /* Assert SRS signal */
> >> + ? ? __raw_writel(MXS_WATCHDOG_EN, wdog_base + MXS_SET_ADDR);
> >> +
> >> + ? ? /* Wait for reset to assert... */
> >> + ? ? mdelay(500);
> >> +
> >> + ? ? pr_err("Watchdog reset failed to assert reset\n");
> >> +
> >> + ? ? /* Delay to allow the serial port to show the message */
> >> + ? ? mdelay(50);
> >> +
> >> + ? ? /* We'll take a jump through zero as a poor second */
> >> + ? ? cpu_reset(0);
> >> +}
> >> +
> >> +void mxs_arch_reset_init(void __iomem *base)
> >> +{
> >> + ? ? struct clk *clk;
> >> +
> >> + ? ? wdog_base = base;
> >> +
> >> + ? ? clk = clk_get_sys("rtc", NULL);
> >> + ? ? if (!IS_ERR(clk))
> >> + ? ? ? ? ? ? clk_enable(clk);
> > Actually I'm not sure if it's worth to do this. ?It might hurt if you
> > want to save power.
> >
> > I'll try to find a time slot to look into that.
> >
> As this is the very initial support, I would not consider the power
> saving very much.  I will be very happy to applied your solution after
> it becomes available.
That's OK

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
