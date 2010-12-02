From: shawn.gsc@gmail.com (Shawn Guo)
Date: Thu, 2 Dec 2010 18:16:29 +0800
Subject: [PATCH v2 03/15] ARM: mxs: Add reset routines
In-Reply-To: <20101202094045.GO32355@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291031956-30314-3-git-send-email-shawn.guo@freescale.com>
	<20101202094045.GO32355@pengutronix.de>
Message-ID: <AANLkTi=iDTuD1w2XFTYtA-_bWDrCjM8KVc-9S4CPBrqF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/12/2 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Shawn
>
> On Mon, Nov 29, 2010 at 07:59:13PM +0800, Shawn Guo wrote:
>> +/*
>> + * Reset the system. It is called by machine_restart().
>> + */
>> +void arch_reset(char mode, const char *cmd)
>> +{
>> + ? ? /* Set wdog count */
>> + ? ? __raw_writel(1, wdog_base + MXS_RTC_WATCHDOG);
>> +
>> + ? ? /* Assert SRS signal */
>> + ? ? __raw_writel(MXS_WATCHDOG_EN, wdog_base + MXS_SET_ADDR);
>> +
>> + ? ? /* Wait for reset to assert... */
>> + ? ? mdelay(500);
>> +
>> + ? ? pr_err("Watchdog reset failed to assert reset\n");
>> +
>> + ? ? /* Delay to allow the serial port to show the message */
>> + ? ? mdelay(50);
>> +
>> + ? ? /* We'll take a jump through zero as a poor second */
>> + ? ? cpu_reset(0);
> After reading a bit in IMX28RM, I wonder why do you bother with the
> watchdog at all? ?Doesn't
>
> ? ? ? ?__raw_writel(MXS_CLKCTRL_RESET_CHIP, MXS_CLKCTRL_RESET + MXS_SET_ADDR);
>
> work easier and without the need to worry about timeouts, sleeping while
> clk_{get,enable} and races?
> (Note I didn't check if i.MX23 has the same register at the same
> address.)
>
Yes, it's a good way to reset mxs SoC.  But the bad thing is the
offset of the register is different between MX23 and MX28.  Also there
is no SET_ADDR for this register.

-- 
Regards,
Shawn
