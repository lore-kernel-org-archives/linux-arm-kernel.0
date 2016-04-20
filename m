From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Apr 2016 10:58:39 +0200
Subject: [PATCH] ARM: imx25-pinfunc: remove SION from all modes
In-Reply-To: <20160420104617.15cf8461@ipc1.ka-ro>
References: <1461095114-11745-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160419211958.GD19428@n2100.arm.linux.org.uk>
 <20160420104617.15cf8461@ipc1.ka-ro>
Message-ID: <20160420085839.GI29108@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 10:46:17AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> On Tue, 19 Apr 2016 22:19:58 +0100 Russell King - ARM Linux wrote:
> > On Tue, Apr 19, 2016 at 09:45:14PM +0200, Uwe Kleine-K?nig wrote:
> > > With the SION bit set a pin can be read as GPIO even though it's not muxed
> > > as GPIO. This is useful at times. The downside however is that the signal
> > > is not only routed to the GPIO IP but also all other IPs that can make use
> > > of the pin. This resulted in more than one issue for me in the past. Things
> > > like spi transfers that result in usb reenumeration or setting a GPIO to a
> > > value that triggers an RTS irq for an UART.
> > 
> > Isn't SION required for all GPIOs such that reading the value of a GPIO
> > pin returns the actual state of the pin, not the output value written
> > to it?
> > 
> > What about the ethernet pins?  I know that on iMX6, SION is required for
> > correct functionality of certain phy clocking modes, and I wouldn't be
> > surprised if this was true in earlier designs as well.
> > 
> SION essentially makes any OUTPUT pin (GPIO or other function)
> bidirectional.

Yes, and the bad thing is that the input is routed to all modules that
the pin can be muxed for. So if on i.MX25 you intend to set the value of
gpio 3.21 you also toggle UART5's RTS signal with SION set.

And note that SION also has an effect on input pins (i.e. it is routed
to all modules instead of only the muxed one).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
