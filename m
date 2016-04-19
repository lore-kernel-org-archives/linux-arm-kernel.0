From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 19 Apr 2016 09:30:23 +0200
Subject: [PATCH v2 1/2] ARM: dts: imx25-pinfunc: add all UART mux modes
In-Reply-To: <20160330131207.GK28207@tiger>
References: <1457085652-4748-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457552674-16602-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160330131207.GK28207@tiger>
Message-ID: <20160419073023.GH10108@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Shawn,

On Wed, Mar 30, 2016 at 09:12:08PM +0800, Shawn Guo wrote:
> On Wed, Mar 09, 2016 at 08:44:33PM +0100, Uwe Kleine-K?nig wrote:
> > Apart from a few additions this also contains two fixes where the daisy
> > chain input selection register was missing. Moreover dropped _MUX from
> > some pins for consistency.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Applied both, thanks.

I think I found yet another problem that involves the SION bit. On the
same hardware where I debugged that UART problem we also had an issue
that resulted in messages like:

[  108.939397] usb 1-1: new full-speed USB device number 6 using ci_hdrc
[  109.154390] usb 1-1: device descriptor read/64, error -71
[  109.469404] usb 1-1: device descriptor read/64, error -71
[  109.689385] usb 1-1: new full-speed USB device number 7 using ci_hdrc
[  109.904383] usb 1-1: device descriptor read/64, error -71
[  110.219376] usb 1-1: device descriptor read/64, error -71
[  110.439396] usb 1-1: new full-speed USB device number 8 using ci_hdrc
[  110.919379] usb 1-1: device not accepting address 8, error -71
[  111.034396] usb 1-1: new full-speed USB device number 9 using ci_hdrc
[  111.514384] usb 1-1: device not accepting address 9, error -71
[  111.522547] usb usb1-port1: unable to enumerate USB device

whenever the spi FRAM is accessed. Now I noticed that the involved
pin/functions (i.e. MX25_PAD_CSI_D2__CSPI3_MOSI,
MX25_PAD_CSI_D3__CSPI3_MISO, MX25_PAD_CSI_D6__GPIO_1_31 for CS) also
have the SION bit set and these have also an USBOTG function (which is
not defined in imx25-pinfunc.h, so you have to check the reference
manual).

Assuming that removing the SION bits fixes that issue (this is still to
be tested) I wonder if we should remove all SION bits.

What do you think?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
