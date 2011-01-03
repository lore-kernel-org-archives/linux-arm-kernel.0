From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jan 2011 10:35:39 +0000
Subject: [PATCH] ARM: mxs: Change duart device to use amba-pl011
In-Reply-To: <20101222202542.GT14221@pengutronix.de>
References: <1292857064-5032-1-git-send-email-shawn.guo@freescale.com>
	<1292937130-32155-1-git-send-email-shawn.guo@freescale.com>
	<20101222202542.GT14221@pengutronix.de>
Message-ID: <20110103103539.GD26785@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 22, 2010 at 09:25:42PM +0100, Uwe Kleine-K?nig wrote:
> Hello Shawn,
> 
> On Tue, Dec 21, 2010 at 09:12:10PM +0800, Shawn Guo wrote:
> > The mxs duart is actually an amba-pl011 device. This commit changes
> > the duart device code to dynamically allocate amba-pl011 device,
> > so that drivers/serial/amba-pl011.c can be used on mxs.
> I have problems using this.  The problem I found up to now is that
> during probe of the device (triggered by mxs_add_duart ->
> amba_device_register -> amba_put_disable_pclk) the uart clock is
> disabled.

Which uart clock is disabled?  The PCLK or the UARTCLK (names as defined
in the ARM PL011 TRM).

If the pclk code is disabling the UARTCLK, then add a dummy apb_pclk to
your clock lookups, which is what everyone else who can't control the
APB PCLK does.
