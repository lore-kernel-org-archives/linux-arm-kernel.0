From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 30 Jul 2013 09:50:58 +0800
Subject: [PATCH v13 03/14] usb: chipidea: imx: add return value check
 for devm_regulator_get
In-Reply-To: <20130729224717.GB7109@pengutronix.de>
References: <1374830310-21765-1-git-send-email-peter.chen@freescale.com>
 <1374830310-21765-4-git-send-email-peter.chen@freescale.com>
 <20130729224717.GB7109@pengutronix.de>
Message-ID: <20130730015057.GE27709@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 12:47:17AM +0200, Michael Grzeschik wrote:
> On Fri, Jul 26, 2013 at 05:18:19PM +0800, Peter Chen wrote:
> > - If devm_regulator_get returns -EPROBE_DEFER, we also return
> > -EPROBE_DEFER to wait regulator being ready later.
> > - If devm_regulator_get returns -ENODEV, we think there is
> > no "vbus-supply" node at DT, it means this board doesn't need
> > vbus control.
> > - If devm_regulator_get returns other error values, it means
> > there are something wrong for getting this regulator.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/chipidea/ci_hdrc_imx.c |   14 ++++++++++++--
> >  1 files changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> > index d06355e..0ced8c1 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> > @@ -144,8 +144,18 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
> >  
> >  	/* Get the vbus regulator */
> >  	pdata.reg_vbus = devm_regulator_get(&pdev->dev, "vbus");
> > -	if (IS_ERR(pdata.reg_vbus))
> > -		pdata.reg_vbus = NULL;
> > +	if (PTR_ERR(pdata.reg_vbus) == -EPROBE_DEFER) {
> > +		ret = -EPROBE_DEFER;
> > +		goto err_clk;
> > +	} else if (PTR_ERR(pdata.reg_vbus) == -ENODEV) {
> > +		pdata.reg_vbus = NULL; /* no vbus regualator is needed */
> > +	} else if (IS_ERR(pdata.reg_vbus)) {
> > +		dev_err(&pdev->dev,
> > +				"Getting regulator error: %ld\n",
> > +					PTR_ERR(pdata.reg_vbus));
> > +		ret = PTR_ERR(pdata.reg_vbus);
> > +		goto err_clk;
> > +	}
> >  
> >  	if (!pdev->dev.dma_mask)
> >  		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> > -- 
> 
> This is wrong, you should squash that into the previous patch. And
> as already mentioned, this can probably go into core.c as well.
> 
> Pick up the habit *not* to change code in one series which another patch
> of the same series introduced. This only adds *dusty* unused history in the
> patchstack that nobody needs. A *clean* and *coherent* series with discrete
> patches is much easier to review and will get accepted much faster.
> 

My rule is do ONE thing at ONE patch, is it not correct?

Previous one[2/14]: Remove the vbus operation at imx glue layer.
This one [3/14]: Fix a bug that vbus may be gotten delay (EPROBE_DEFER),
and vbus is valid at this case.

-- 

Best Regards,
Peter Chen
