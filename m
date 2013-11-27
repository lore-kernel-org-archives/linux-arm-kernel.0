From: matt.porter@linaro.org (Matt Porter)
Date: Wed, 27 Nov 2013 12:16:45 -0500
Subject: [PATCH v3 6/9] usb: gadget: s3c-hsotg: get phy bus width from
 phy subsystem
In-Reply-To: <529477DD.8000906@ti.com>
References: <1385403367-18144-1-git-send-email-matt.porter@linaro.org>
 <1385403367-18144-7-git-send-email-matt.porter@linaro.org>
 <529477DD.8000906@ti.com>
Message-ID: <20131127171645.GE31091@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 03:58:45PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 25 November 2013 11:46 PM, Matt Porter wrote:
> > Adds support for querying the phy bus width from the generic phy
> > subsystem. Configure UTMI bus width in GUSBCFG based on this value.
> > 
> > Signed-off-by: Matt Porter <matt.porter@linaro.org>
> > ---
> >  drivers/usb/gadget/s3c-hsotg.c | 14 +++++++++++++-
> >  drivers/usb/gadget/s3c-hsotg.h |  1 +
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
> > index 8dfe33f..be41585 100644
> > --- a/drivers/usb/gadget/s3c-hsotg.c
> > +++ b/drivers/usb/gadget/s3c-hsotg.c
> > @@ -144,6 +144,7 @@ struct s3c_hsotg_ep {
> >   * @regs: The memory area mapped for accessing registers.
> >   * @irq: The IRQ number we are using
> >   * @supplies: Definition of USB power supplies
> > + * @phyif: PHY interface width
> >   * @dedicated_fifos: Set if the hardware has dedicated IN-EP fifos.
> >   * @num_of_eps: Number of available EPs (excluding EP0)
> >   * @debug_root: root directrory for debugfs.
> > @@ -171,6 +172,7 @@ struct s3c_hsotg {
> >  
> >  	struct regulator_bulk_data supplies[ARRAY_SIZE(s3c_hsotg_supply_names)];
> >  
> > +	u32			phyif;
> >  	unsigned int		dedicated_fifos:1;
> >  	unsigned char           num_of_eps;
> >  
> > @@ -2276,7 +2278,7 @@ static void s3c_hsotg_core_init(struct s3c_hsotg *hsotg)
> >  	 */
> >  
> >  	/* set the PLL on, remove the HNP/SRP and set the PHY */
> > -	writel(GUSBCFG_PHYIf16 | GUSBCFG_TOutCal(7) |
> > +	writel(hsotg->phyif | GUSBCFG_TOutCal(7) |
> >  	       (0x5 << 10), hsotg->regs + GUSBCFG);
> >  
> >  	s3c_hsotg_init_fifo(hsotg);
> > @@ -3622,6 +3624,16 @@ static int s3c_hsotg_probe(struct platform_device *pdev)
> >  		goto err_supplies;
> >  	}
> >  
> > +	/* Set default UTMI width */
> > +	hsotg->phyif = GUSBCFG_PHYIf16;
> > +
> > +	/*
> > +	 * If using the generic PHY framework, check if the PHY bus
> > +	 * width is 8-bit and set the phyif appropriately.
> > +	 */
> > +	if (hsotg->phy && (phy_get_bus_width(phy) == 8))
> 
> what if the phy has error value here?

I'm addressing this like the other !IS_ERR checks. In the platform data
case, we'll have an error value here, and need to use the default. Until
the platform data case is removed (those platform board files removed),
we assume (correctly) that they use a phy interface width of 16.

-Matt
