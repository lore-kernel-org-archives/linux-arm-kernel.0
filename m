From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 12 Sep 2016 16:12:45 +0200
Subject: [PATCH] BUG: atmel_serial: Interrupts not disabled on close
In-Reply-To: <20160912133441.14597-1-richard.genoud@gmail.com>
References: <20160912133441.14597-1-richard.genoud@gmail.com>
Message-ID: <20160912141245.u6h6ugvuybc2lr66@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 03:34:41PM +0200, Richard Genoud wrote:
> Since commit 18dfef9c7f87 ("serial: atmel: convert to irq handling
> provided mctrl-gpio"), interrupts from GPIOs are not disabled any more
> when the serial port is closed, leading to an oops when the one of the
> input pin is toggled (CTS/DSR/DCD/RNG).
> 
> This is only the case if those pins are used as GPIOs, i.e. declared
> like that:
> usart1: serial at f8020000 {
>         /* CTS and DTS will be handled by GPIO */
>         status = "okay";
>         rts-gpios = <&pioB 17 GPIO_ACTIVE_LOW>;
>         cts-gpios = <&pioB 16 GPIO_ACTIVE_LOW>;
>         dtr-gpios = <&pioB 14 GPIO_ACTIVE_LOW>;
>         dsr-gpios = <&pioC 31 GPIO_ACTIVE_LOW>;
>         rng-gpios = <&pioB 12 GPIO_ACTIVE_LOW>;
>         dcd-gpios = <&pioB 15 GPIO_ACTIVE_LOW>;
> };
> 
> That's because modem interrupts used to be freed in atmel_shutdown().
> After commit 18dfef9c7f87 ("serial: atmel: convert to irq handling
> provided mctrl-gpio"), this code was just removed.
> Calling atmel_disable_ms() disables the interrupts and everything works
> fine again.
> 
> Tested on at91sam9g35-cm
> 
> (This patch doesn't apply on -stable kernels, fixes for 4.4 and 4.7 will
> be sent after this one is applied.)
AFAIK this is no reason to not put stable on Cc. If then
$stablemaintainer fails to backport the change, he will contact you.

> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> Fixes: 18dfef9c7f87 ("serial: atmel: convert to irq handling provided mctrl-gpio")
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks for caring
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
