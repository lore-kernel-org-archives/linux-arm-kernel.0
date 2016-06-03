From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 3 Jun 2016 15:32:47 +0200
Subject: [PATCH] ARM: imx25-pinfunc: remove SION from all modes
In-Reply-To: <20160420085839.GI29108@pengutronix.de>
References: <1461095114-11745-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160419211958.GD19428@n2100.arm.linux.org.uk>
 <20160420104617.15cf8461@ipc1.ka-ro>
 <20160420085839.GI29108@pengutronix.de>
Message-ID: <20160603133247.GV26768@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Apr 20, 2016 at 10:58:39AM +0200, Uwe Kleine-K?nig wrote:
> On Wed, Apr 20, 2016 at 10:46:17AM +0200, Lothar Wa?mann wrote:
> > On Tue, 19 Apr 2016 22:19:58 +0100 Russell King - ARM Linux wrote:
> > > On Tue, Apr 19, 2016 at 09:45:14PM +0200, Uwe Kleine-K?nig wrote:
> > > > With the SION bit set a pin can be read as GPIO even though it's not muxed
> > > > as GPIO. This is useful at times. The downside however is that the signal
> > > > is not only routed to the GPIO IP but also all other IPs that can make use
> > > > of the pin. This resulted in more than one issue for me in the past. Things
> > > > like spi transfers that result in usb reenumeration or setting a GPIO to a
> > > > value that triggers an RTS irq for an UART.
> > > 
> > > Isn't SION required for all GPIOs such that reading the value of a GPIO
> > > pin returns the actual state of the pin, not the output value written
> > > to it?
> > > 
> > > What about the ethernet pins?  I know that on iMX6, SION is required for
> > > correct functionality of certain phy clocking modes, and I wouldn't be
> > > surprised if this was true in earlier designs as well.
> > > 
> > SION essentially makes any OUTPUT pin (GPIO or other function)
> > bidirectional.
> 
> Yes, and the bad thing is that the input is routed to all modules that
> the pin can be muxed for. So if on i.MX25 you intend to set the value of
> gpio 3.21 you also toggle UART5's RTS signal with SION set.
> 
> And note that SION also has an effect on input pins (i.e. it is routed
> to all modules instead of only the muxed one).

I found a regression of the patch under discussion (which was not
applied, so no big problem). On the custom mx25 based hardware an
SD-card isn't detected any more after removing SION from
MX25_PAD_SD1_CMD__SD1_CMD. I verified the same happens on a tx25.

Is this expected? IMHO it's unfortunate (if not a silicon bug) that you
need the SION bit here as the SION bit has some more side effects.  If
you ask me, muxing a certain function for a pin should enable the input
path to the respective module if the pin is bidirectional.

Is there a list of pin/function pairs that need the SION bit set? Shawn,
would you agree to accept this patch with the high risk that it
introduces regressions? Or maybe we should make the SION bit more easily
overridable for board dts files (and default to off unless known it's
needed)?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
