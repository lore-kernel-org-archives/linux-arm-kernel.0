From: MNARANI@xilinx.com (Manish Narani)
Date: Mon, 24 Sep 2018 10:20:41 +0000
Subject: [PATCH v7 5/7] edac: synopsys: Add EDAC ECC support for ZynqMP
 DDRC
In-Reply-To: <20180921125527.GE30439@nazgul.tnic>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-6-git-send-email-manish.narani@xilinx.com>
 <20180921125527.GE30439@nazgul.tnic>
Message-ID: <DM6PR02MB522717E2B74148A7069FA57EC1170@DM6PR02MB5227.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Thanks for the review.


> From: Borislav Petkov [mailto:bp at alien8.de]
> Sent: Friday, September 21, 2018 6:26 PM
> On Mon, Sep 17, 2018 at 07:55:03PM +0530, Manish Narani wrote:
> > Add EDAC ECC support for ZynqMP DDRC IP. The IP supports interrupts
> > for corrected and uncorrected errors. Add interrupt handlers for the same.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  drivers/edac/Kconfig         |   2 +-
> >  drivers/edac/synopsys_edac.c | 304
> > ++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 287 insertions(+), 19 deletions(-)
> 
> ...
> > +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
> 
> This whole chunk together with the if, looks like it could be a separate function
> called maybe request_irq() or so.
May be I can keep it like edac_setup_irq() ?

> 
> > +		irq = platform_get_irq(pdev, 0);
> > +		if (irq < 0) {
> > +			edac_printk(KERN_ERR, EDAC_MC,
> > +					"No irq %d in DT\n", irq);
> 
> Align arguments on opening brace.
Okay

> 
> Then, here it is "irq"...
> 
> > +			rc = irq;
> > +			goto free_edac_mc;
> > +		}
> > +
> > +		rc = devm_request_irq(&pdev->dev, irq,
> > +			synps_edac_intr_handler,
> > +			0, dev_name(&pdev->dev), mci);
> 
> Also align on opening brace.
> 
> > +		if (rc < 0) {
> > +			edac_printk(KERN_ERR, EDAC_MC, "Failed to request
> Irq\n");
> 
> ... here it is "Irq".
> 
> I'd say it should be "IRQ" everywhere.
Okay

> 
> > +			goto free_edac_mc;
> > +		}
> > +
> > +		/* Enable UE/CE Interrupts */
> > +		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
> > +			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
> > +	}
> > +
> >  	rc = edac_mc_add_mc(mci);
> >  	if (rc) {
> >  		edac_printk(KERN_ERR, EDAC_MC,
> > @@ -684,7 +945,8 @@ static int synps_edac_mc_probe(struct
> platform_device *pdev)
> >  	 * Start capturing the correctable and uncorrectable errors. A write of
> >  	 * 0 starts the counters.
> >  	 */
> > -	writel(0x0, baseaddr + ECC_CTRL_OFST);
> > +	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
> > +		writel(0x0, baseaddr + ECC_CTRL_OFST);
> >  	return rc;
> >
> >  free_edac_mc:
> > @@ -702,7 +964,13 @@ static int synps_edac_mc_probe(struct
> > platform_device *pdev)  static int synps_edac_mc_remove(struct
> > platform_device *pdev)  {
> >  	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> > +	struct synps_edac_priv *priv;
> >
> > +	priv = mci->pvt_info;
> > +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
> > +		/* Disable UE/CE Interrupts */
> > +		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
> > +			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
> 
> This could be a disable_irq() function. Makes the code easier to follow.
Okay. Will update this in v8.

Thanks,
Manish
