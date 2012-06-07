From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 7 Jun 2012 16:27:40 -0400
Subject: [PATCH 1/3] spi-orion: add device tree binding
In-Reply-To: <201206032348.49208.michael@walle.cc>
References: <1338754678-17000-1-git-send-email-michael@walle.cc>
 <20120603210123.GL14756@titan.lakedaemon.net>
 <201206032348.49208.michael@walle.cc>
Message-ID: <20120607202740.GP14756@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 03, 2012 at 11:48:49PM +0200, Michael Walle wrote:
> Hi Jason,
> 
> Am Sonntag 03 Juni 2012, 23:01:23 schrieb Jason Cooper:
> > On Sun, Jun 03, 2012 at 10:17:56PM +0200, Michael Walle wrote:
> > > Signed-off-by: Michael Walle <michael@walle.cc>
> > > ---
> > > 
> > >  .../devicetree/bindings/spi/spi-orion.txt          |    5 +++++
> > >  drivers/spi/spi-orion.c                            |   11 +++++++++++
> > >  2 files changed, 16 insertions(+), 0 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/spi/spi-orion.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-orion.txt
> > > b/Documentation/devicetree/bindings/spi/spi-orion.txt new file mode
> > > 100644
> > > index 0000000..e68597a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
> > > @@ -0,0 +1,5 @@
> > > +Marvell Orion SPI device
> > > +
> > > +Required properties:
> > > +- compatible : should be "marvell,orion-spi".
> > 
> > The above is correct, and a change in policy from when dreamplug DT
> > support was first added.
> > 
> > > +- reg : offset and length of the register set for the device
> > > diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> > > index 2760450..2de58bb 100644
> > > --- a/drivers/spi/spi-orion.c
> > > +++ b/drivers/spi/spi-orion.c
> > > @@ -17,6 +17,7 @@
> > > 
> > >  #include <linux/io.h>
> > >  #include <linux/spi/spi.h>
> > >  #include <linux/module.h>
> > > 
> > > +#include <linux/of.h>
> > > 
> > >  #include <linux/clk.h>
> > >  #include <asm/unaligned.h>
> > > 
> > > @@ -506,6 +507,7 @@ static int __init orion_spi_probe(struct
> > > platform_device *pdev)
> > > 
> > >  	if (orion_spi_reset(spi) < 0)
> > >  	
> > >  		goto out_rel_mem;
> > > 
> > > +	master->dev.of_node = pdev->dev.of_node;
> > > 
> > >  	status = spi_register_master(master);
> > >  	if (status < 0)
> > >  	
> > >  		goto out_rel_mem;
> > > 
> > > @@ -547,10 +549,19 @@ static int __exit orion_spi_remove(struct
> > > platform_device *pdev)
> > > 
> > >  MODULE_ALIAS("platform:" DRIVER_NAME);
> > > 
> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id orion_spi_of_match_table[]
> > > __devinitdata = { +	{ .compatible = "mrvl,orion-spi", },
> > 
> > Please make this consistent with the documentation, "marvell,orion-spi",
> > thanks.  That'll be one less to convert over later.
> 
> oh, actually i forgot to change the documentation. wasnt the convention to use 
> the name used in the stock exchange?

It was, but after discussing this recently with Russell, Arnd, and
Nicolas, we decided this was a bad idea because powerpc has used
"marvell" for years and has devices in the field using it that way.
Since there was no technical justification for the change, we opted to
follow powerpc's lead.

This was brought up in the discussion thread around the proposed
'mach-armada/' patch series.

hth,

Jason.
