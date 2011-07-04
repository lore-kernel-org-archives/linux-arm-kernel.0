From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 4 Jul 2011 09:33:25 -0600
Subject: [PATCH 2/2] serial/imx: add device tree probe support
In-Reply-To: <20110704073826.GC4338@pengutronix.de>
References: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
	<1309679760-22796-3-git-send-email-shawn.guo@linaro.org>
	<20110704065820.GY6069@pengutronix.de>
	<20110704073826.GC4338@pengutronix.de>
Message-ID: <20110704153325.GC29977@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 09:38:26AM +0200, Uwe Kleine-K?nig wrote:
> On Mon, Jul 04, 2011 at 08:58:20AM +0200, Sascha Hauer wrote:
> > On Sun, Jul 03, 2011 at 03:56:00PM +0800, Shawn Guo wrote:
> > > It adds device tree probe support for imx tty/serial driver.
> > > 
> > > Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> > > Signed-off-by: Jason Liu <jason.hui@linaro.org>
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > > Cc: Grant Likely <grant.likely@secretlab.ca>
> > > ---
> > >  .../bindings/tty/serial/fsl-imx-uart.txt           |   19 +++++
> > >  drivers/tty/serial/imx.c                           |   82 +++++++++++++++++---
> > >  2 files changed, 91 insertions(+), 10 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> > > new file mode 100644
> > > index 0000000..a9c0406
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> > > @@ -0,0 +1,19 @@
> > > +* Freescale i.MX Universal Asynchronous Receiver/Transmitter (UART)
> > > +
> > > +Required properties:
> > > +- compatible : Should be "fsl,<soc>-uart"
> > > +- reg : Address and length of the register set for the device
> > > +- interrupts : Should contain uart interrupt
> > > +
> > > +Optional properties:
> > > +- fsl,uart-has-rtscts : Indicate the uart has rts and cts
> > > +- fsl,irda-mode : Indicate the uart supports irda mode
> > > +
> > > +Example:
> > > +
> > > +uart at 73fbc000 {
> > > +	compatible = "fsl,imx51-uart", "fsl,imx21-uart";
> > > +	reg = <0x73fbc000 0x4000>;
> > > +	interrupts = <31>;
> > > +	fsl,uart-has-rtscts;
> > > +};
> > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > index 983f3bd..483c447 100644
> > > --- a/drivers/tty/serial/imx.c
> > > +++ b/drivers/tty/serial/imx.c
> > > @@ -45,6 +45,8 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/rational.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > >  
> > >  #include <asm/io.h>
> > >  #include <asm/irq.h>
> > > @@ -239,6 +241,12 @@ static struct platform_device_id imx_uart_devtype[] = {
> > >  	}
> > >  };
> > >  
> > > +static struct of_device_id imx_uart_dt_ids[] = {
> > > +	{ .compatible = "fsl,imx1-uart", .data = &imx_uart_devdata[IMX1_UART], },
> > > +	{ .compatible = "fsl,imx21-uart", .data = &imx_uart_devdata[IMX2_UART], },
> > > +	{ /* sentinel */ },
> > > +};
> > 
> > Isn't this table a bit too small? What about the other SoCs?
> I'd expect that using fsl,imx21-uart on imx51 would result in a working
> port, but it feels stange and if that's the intention the example above
> needs fixing.

If the newer parts claim compatibility with the older, then have a
terse of_device_id table is just fine.  ie, the compatible property
for an imx51 would be:

	compatible = "fsl,imx51-uart", "fsl,imx21-uart";

It would only be wrong if the device tree node omitted the
"fsl,imx51-uart" value from the list.

g.
