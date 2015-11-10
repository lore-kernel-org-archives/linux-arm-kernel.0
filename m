From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Nov 2015 10:28:46 +0100
Subject: [PATCH] PCI: imx6:don't sleep in atomic context
In-Reply-To: <1447144878.3142.3.camel@pengutronix.de>
References: <1447066080-5859-1-git-send-email-sanjeev_sharma@mentor.com>
 <1447144878.3142.3.camel@pengutronix.de>
Message-ID: <4800389.dqcmlJY3HC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 November 2015 09:41:18 Lucas Stach wrote:
> > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > index 233a196..9769b13 100644
> > --- a/drivers/pci/host/pci-imx6.c
> > +++ b/drivers/pci/host/pci-imx6.c
> > @@ -499,7 +499,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
> >                * Wait a little bit, then re-check if the link finished
> >                * the training.
> >                */
> > -             usleep_range(1000, 2000);
> > +             mdelay(1000);
> 
> A mdelay(1000) is a whole different timescale than a usleep(1000). If
> this patch works for you with mdelay(1) or maybe mdelay(2) I would be
> fine with it.

mdelay(1) is still a really long time to block the CPU for, on potentially
every config space access.

Everybody else just returns the link status here, which seems to be
the better alternative. If you need to delay the startup, better have
a msleep(1) loop in the initial probe function where you are allowed to
sleep.

	Arnd
