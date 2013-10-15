From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Tue, 15 Oct 2013 10:12:16 +0300
Subject: [PATCH v3 12/13] usb: phy: msm: Properly check core interrupt
 number
In-Reply-To: <20131014225933.GF7446@radagast>
References: <1381764280-28420-1-git-send-email-iivanov@mm-sol.com>
 <1381764280-28420-13-git-send-email-iivanov@mm-sol.com>
 <20131014225933.GF7446@radagast>
Message-ID: <1381821136.29983.15.camel@iivanov-dev.int.mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-10-14 at 17:59 -0500, Felipe Balbi wrote: 
> On Mon, Oct 14, 2013 at 06:24:39PM +0300, Ivan T. Ivanov wrote:
> > From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> > 
> > IRQ with number 0 is valid case, so check for negative
> 
> not entirelly correct... IRQ 0 isn't supposed to be used as a linux IRQ
> number IIRC.

I am not really sure. NO_IRQ is -1 at least on ARM. Also when
taking into account irqdomain's zero as interrupt number is valid??

> 
> > numbers instead.
> > 
> > Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> > ---
> >  drivers/usb/phy/phy-msm-usb.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/phy/phy-msm-usb.c b/drivers/usb/phy/phy-msm-usb.c
> > index ca2abe6..f34c8a9 100644
> > --- a/drivers/usb/phy/phy-msm-usb.c
> > +++ b/drivers/usb/phy/phy-msm-usb.c
> > @@ -1415,7 +1415,7 @@ static int __init msm_otg_probe(struct platform_device *pdev)
> >  	dev_info(&pdev->dev, "OTG regs = %p\n", motg->regs);
> >  
> >  	motg->irq = platform_get_irq(pdev, 0);
> > -	if (!motg->irq) {
> > +	if (motg->irq < 0) {
> 
> this check is correct though, since platform_get_irq() will return
> -ENXIO if it doesn't find IRQ resource.
> 

Thanks,
Ivan
