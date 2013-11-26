From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 26 Nov 2013 10:34:34 +0100
Subject: [RESEND PATCH v3 2/4] usb: musb: Bugfix of_node assignment
In-Reply-To: <52937F76.107@linutronix.de>
References: <1384790078-15366-1-git-send-email-mpa@pengutronix.de>
 <1384790078-15366-3-git-send-email-mpa@pengutronix.de>
 <20131125161421.GH18046@saruman.home> <52937F76.107@linutronix.de>
Message-ID: <20131126093434.GC13532@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 25, 2013 at 05:48:54PM +0100, Sebastian Andrzej Siewior wrote:
> On 11/25/2013 05:14 PM, Felipe Balbi wrote:
> > Hi,
> > 
> > On Mon, Nov 18, 2013 at 04:54:36PM +0100, Markus Pargmann wrote:
> >> It is not safe to assign the of_node to a device without driver.
> >> The device is matched against a list of drivers and the of_node
> >> could lead to a DT match with the parent driver.
> >> 
> >> Signed-off-by: Markus Pargmann <mpa@pengutronix.de> --- 
> >> drivers/usb/musb/musb_core.c | 12 +++++++++++- 
> >> drivers/usb/musb/musb_dsps.c |  1 - 2 files changed, 11
> >> insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/usb/musb/musb_core.c
> >> b/drivers/usb/musb/musb_core.c index 8b7d903..d5ad9db 100644 ---
> >> a/drivers/usb/musb/musb_core.c +++
> >> b/drivers/usb/musb/musb_core.c @@ -1966,6 +1966,7 @@ static int
> >> musb_probe(struct platform_device *pdev) int		irq =
> >> platform_get_irq_byname(pdev, "mc"); struct resource	*iomem; void
> >> __iomem	*base; +	int ret;
> >> 
> >> iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0); if
> >> (!iomem || irq <= 0) @@ -1975,7 +1976,16 @@ static int
> >> musb_probe(struct platform_device *pdev) if (IS_ERR(base)) return
> >> PTR_ERR(base);
> >> 
> >> -	return musb_init_controller(dev, irq, base); +	if
> >> (dev->parent)
> 
> don't we always have a parent?
> 
> >> +		dev->of_node = dev->parent->of_node; + +	ret =
> >> musb_init_controller(dev, irq, base); +	if (ret) { +
> >> dev->of_node = NULL; +		return ret; +	} + +	return 0; }
> >> 
> >> static int musb_remove(struct platform_device *pdev) diff --git
> >> a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c 
> >> index 82e1da0..7b36d32 100644 --- a/drivers/usb/musb/musb_dsps.c 
> >> +++ b/drivers/usb/musb/musb_dsps.c @@ -485,7 +485,6 @@ static int
> >> dsps_create_musb_pdev(struct dsps_glue *glue, musb->dev.parent		=
> >> dev; musb->dev.dma_mask		= &musb_dmamask; 
> >> musb->dev.coherent_dma_mask	= musb_dmamask; -	musb->dev.of_node
> >> = of_node_get(dn);
> > 
> > Sebastian, does this look correct to you ?
> 
> Is this fixing a bug? Commit 4fc4b2 ("usb: musb: dsps: do not bind to
> "musb-hdrc") [0] should fix the problem that is described here.
> ux500 is affected by the same problem as dsps but it is only visible on
> dsps because we DEFER probe for few reasons there test the fail path.

Sorry, I didn't check again if this is fixed by some applied patches. I
first discovered this bug in september and send this patch in october.
It is the same bug.

> So by just looking at it should fix the same problem as the change I
> cited _but_ it would also cover ux500. Currently I can't think of any
> side effects by assigning of_node if the musb_init_*() did not do it.
> If we take this in I would suggest to remove the check I added (because
> it does no longer serve any purpose) and the description (why we do
> this, what is the problem exactly) is could be taken from my patch
> since I think it is better described (it safe to assign a node to a
> driver, it becomes unsafe if after platform_probe _also_ the DT probe
> is executed which was not to designed to work like this).

Your patch is already applied, so I could simply drop this one.

Regards,

Markus

> 
> In the long term I would suggest to move the DT probe over to the musb
> core code and we wouldn't need the node assignment anymore?
> 
> [0] http://www.spinics.net/lists/linux-usb/msg94701.html
> 
> Sebastian
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
