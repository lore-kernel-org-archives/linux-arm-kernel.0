From: shawn.gsc@gmail.com (Shawn Guo)
Date: Wed, 1 Dec 2010 19:34:14 +0800
Subject: [PATCH v2 03/15] ARM: mxs: Add reset routines
In-Reply-To: <20101201105904.GF32355@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291031956-30314-3-git-send-email-shawn.guo@freescale.com>
	<20101130102505.GG20449@pengutronix.de>
	<AANLkTimvA2VUE0rGVorvtq607FOkZJDc4Mb4UTAF+ZAj@mail.gmail.com>
	<20101201105904.GF32355@pengutronix.de>
Message-ID: <AANLkTimzwSTxPPG63-C+G_AyNJ616bxUo0BJB7U4asL5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/12/1 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Wed, Dec 01, 2010 at 06:45:20PM +0800, Shawn Guo wrote:
>> Hi Uwe,
>>
>> 2010/11/30 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> > Hello,
>> >
>> > On Mon, Nov 29, 2010 at 07:59:13PM +0800, Shawn Guo wrote:
>> >> +/*
>> >> + * Reset the system. It is called by machine_restart().
>> >> + */
>> >> +void arch_reset(char mode, const char *cmd)
>> >> +{
>> >> + ? ? /* Set wdog count */
>> >> + ? ? __raw_writel(1, wdog_base + MXS_RTC_WATCHDOG);
>> > Which unit is used here? ?Does the timer only start running when it's
>> > enabled below? ?Does this apply when the watchdog is already in use,
>> > too?
>> >
>> The unit RTC (i.MX28 RM chapter 22) which has watchdog function inside
>> is used here.
> "unit" was meant as in "seconds". ?I assume it means seconds below, but
> it doesn't matter much.
>
Sorry.  The unit is 1ms.

>> Good catch here. ?I thought the watchdog counter only starts counting
>> after WATCHDOG_EN is set. ?But I just confirmed it with designer that
>> the watchdog counter starts counting once CLKGATE is cleared, and
>> WATCHDOG_EN bit only controls the watchdog reset generation. ?Even in
>> this case, 1ms should be long enough for the WATCHDOG_EN setting below
>> to get executed before counter goes to 0. ?What is your concern here?
> My concern is that it might happen that even though the timer is set to
> 1s, the first change happens nearly immediatly resulting in a zero.
> Depending on the hardware a reset occurs when the enable bit is only set
> after the counter reached zero.
>
Should the following changes be safe enough to address your concern?

        /* Set wdog timer 10 ms */
        __raw_writel(10, wdog_base + MXS_RTC_WATCHDOG);

        /* Enable wdog reset */
        __raw_writel(MXS_WATCHDOG_EN, wdog_base + MXS_SET_ADDR);

        /* Wait for reset to assert... */
        mdelay(10);

-- 
Regards,
Shawn
