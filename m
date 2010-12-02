From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Dec 2010 10:40:45 +0100
Subject: [PATCH v2 03/15] ARM: mxs: Add reset routines
In-Reply-To: <1291031956-30314-3-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291031956-30314-3-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101202094045.GO32355@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn

On Mon, Nov 29, 2010 at 07:59:13PM +0800, Shawn Guo wrote:
> +/*
> + * Reset the system. It is called by machine_restart().
> + */
> +void arch_reset(char mode, const char *cmd)
> +{
> +	/* Set wdog count */
> +	__raw_writel(1, wdog_base + MXS_RTC_WATCHDOG);
> +
> +	/* Assert SRS signal */
> +	__raw_writel(MXS_WATCHDOG_EN, wdog_base + MXS_SET_ADDR);
> +
> +	/* Wait for reset to assert... */
> +	mdelay(500);
> +
> +	pr_err("Watchdog reset failed to assert reset\n");
> +
> +	/* Delay to allow the serial port to show the message */
> +	mdelay(50);
> +
> +	/* We'll take a jump through zero as a poor second */
> +	cpu_reset(0);
After reading a bit in IMX28RM, I wonder why do you bother with the
watchdog at all?  Doesn't 

	__raw_writel(MXS_CLKCTRL_RESET_CHIP, MXS_CLKCTRL_RESET + MXS_SET_ADDR);

work easier and without the need to worry about timeouts, sleeping while
clk_{get,enable} and races?
(Note I didn't check if i.MX23 has the same register at the same
address.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
