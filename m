From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Apr 2016 09:51:52 +0200
Subject: [PATCH] ARM: imx25-pinfunc: remove SION from all modes
In-Reply-To: <20160419211958.GD19428@n2100.arm.linux.org.uk>
References: <1461095114-11745-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160419211958.GD19428@n2100.arm.linux.org.uk>
Message-ID: <20160420075152.GE29108@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 10:19:58PM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 19, 2016 at 09:45:14PM +0200, Uwe Kleine-K?nig wrote:
> > With the SION bit set a pin can be read as GPIO even though it's not muxed
> > as GPIO. This is useful at times. The downside however is that the signal
> > is not only routed to the GPIO IP but also all other IPs that can make use
> > of the pin. This resulted in more than one issue for me in the past. Things
> > like spi transfers that result in usb reenumeration or setting a GPIO to a
> > value that triggers an RTS irq for an UART.
> 
> Isn't SION required for all GPIOs such that reading the value of a GPIO
> pin returns the actual state of the pin, not the output value written
> to it?

The documentation for the i.MX25 tells for the GPIO Data Register:

	This register defines the value of the GPIO output when the
	signal is configured as an output (GDIR[n]=1). Writes to this
	register are stored in a register. Reading DR returns the value
	stored in the register if the signal is configured as an output
	(GDIR[n]=1), or the input signal's value if configured as an
	input (GDIR[n]=0).
	Note: The IOMUX must be configured to GPIO mode for the DR value
	to connect with the signal. Reading the data register with the
	input path disabled always returns a zero value.

And the gpio driver uses the GPIO Pad Status Register to implement
get_value, which has:

	Each read-only bit of the PSR stores the value of the
	corresponding input signal (as configured in the IOMUX).

I can confirm what's written in the manual on my i.MX25 machine:

	# KPP_COL1: no pull, open drain disabled
	barebox at i.MX25:/ mw 0x43fac3b4 0x0

	# configure KPP_COL1 as GPIO_3_2, SION off
	barebox at i.MX25:/ mw 0x43fac1bc 0x5

	# set output to 0
	barebox at i.MX25:/ mw 0x53fa4000 0xcddb8041

	# configure GPIO_3_2 as output
	barebox at i.MX25:/ mw 0x53fa4004 0x4

	# both DR and PSR have 0:
	barebox at i.MX25:/ md 0x53fa4000+12
	53fa4000: cddba061 00000004 cddb8041                         a.......A...

	# set output to 1
	barebox at i.MX25:/ mw 0x53fa4000 0xcddb8045

	# DR reports 1, PSR has 0:
	barebox at i.MX25:/ md 0x53fa4000+12
	53fa4000: cddb8045 00000004 cddb8061                         E.......a...

	# now set SION:
	barebox at i.MX25:/ mw 0x43fac1bc 0x15

	# both, DR and PSR report 1
	barebox at i.MX25:/ md 0x53fa4000+12
	53fa4000: cddb8065 00000004 cddb8065                         e.......e...

	# set output to 0
	barebox at i.MX25:/ mw 0x53fa4000 0xcddb8041

	# both, DR and PSR report 0
	barebox at i.MX25:/ md 0x53fa4000+12
	53fa4000: cddba041 00000004 cddb8061                         A.......a...

If I'm not mistaken, the gpio-mxc driver doesn't make use of SION
anyhow, because it uses BGPIOF_READ_OUTPUT_REG_SET (since commit
442b2494b17d ("gpio: mxc: read output value from GPIO_DR register")
which is included in 4.2-rc1).

> What about the ethernet pins?  I know that on iMX6, SION is required for
> correct functionality of certain phy clocking modes, and I wouldn't be
> surprised if this was true in earlier designs as well.

I don't know the details, then maybe we should default to SION=0 and
give the board.dts a simple way to set it for selected pins.

I found
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/200949.html.
That's what you have in mind, right?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
