From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 1 Dec 2010 10:25:29 +0100
Subject: [patch 1/2] imx51: fix gpiolib support
In-Reply-To: <20101201084257.327766974@rtp-net.org>
References: <20101201083715.625363724@rtp-net.org>
	<20101201084257.327766974@rtp-net.org>
Message-ID: <20101201092529.GE32355@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnaud,

On Wed, Dec 01, 2010 at 09:37:16AM +0100, Arnaud Patard wrote:
> The gpiolib code is always returning 0 when reading pad values if the pads
> are configured as output. Using DR registers instead of PSR is fixing that.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: linux-2.6-submit/arch/arm/plat-mxc/gpio.c
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/plat-mxc/gpio.c	2010-11-24 18:00:47.000000000 +0100
> +++ linux-2.6-submit/arch/arm/plat-mxc/gpio.c	2010-11-24 18:06:54.000000000 +0100
> @@ -276,6 +276,10 @@
>  {
>  	struct mxc_gpio_port *port =
>  		container_of(chip, struct mxc_gpio_port, chip);
> +	u32 l = __raw_readl(port->base + GPIO_GDIR);
> +
> +	if (cpu_is_mx51() && (l & (1 << offset)))
> +		return (__raw_readl(port->base + GPIO_DR) >> offset) & 1;
Maybe only read GDIR on mx51?  Isn't the direction saved by gpiolib
somewhere in RAM?  Is the same needed on other SoCs, too (see below for
my grouping)?  Technically it's not needed at all I think.
(Documentation/gpio.txt has: "However, note that not all platforms can
read the value of output pins; those that can't should always return
zero.".  I didn't check if the implementation conforms here though.)

I wonder if cpu_is_mx51 is the right macro to test, I'd prefer something
like imx_gpio_vX().  IMHO the gpio stuff needs a major overhaul getting
rid of most runtime checks.

We have at least the following groups:

	mx1
	mx21, mx27
	mx25, mx31, mx35, mx51, mxc91231

("at least" in the sense that socs on different lines are different.
I don't guarantee that e.g. mx35 and mxc91231 are really equivalent.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
