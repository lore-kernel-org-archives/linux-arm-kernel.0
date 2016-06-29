From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 29 Jun 2016 19:34:11 +0800
Subject: [PATCH 13/21] usb: chipidea: msm: Allow core to get usb phy
In-Reply-To: <20160629064811.GH25236@shlinux2>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-14-stephen.boyd@linaro.org>
 <20160629064811.GH25236@shlinux2>
Message-ID: <20160629113411.GO25236@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 02:48:11PM +0800, Peter Chen wrote:
> On Sun, Jun 26, 2016 at 12:28:30AM -0700, Stephen Boyd wrote:
> > The chipidea core gets the usb phy and initializes the phy at the
> > right point now so we don't need to get the phy in this driver.
> > 
> > Cc: Peter Chen <peter.chen@nxp.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> > ---
> >  drivers/usb/chipidea/ci_hdrc_msm.c | 21 ---------------------
> >  1 file changed, 21 deletions(-)
> > 
> > diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
> > index 430856ef1be3..07cccd24a87f 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> > @@ -24,15 +24,6 @@ static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
> >  		dev_dbg(dev, "CI_HDRC_CONTROLLER_RESET_EVENT received\n");
> >  		/* use AHB transactor, allow posted data writes */
> >  		hw_write_id_reg(ci, HS_PHY_AHB_MODE, 0xffffffff, 0x8);
> > -		usb_phy_init(ci->usb_phy);
> > -		break;
> > -	case CI_HDRC_CONTROLLER_STOPPED_EVENT:
> > -		dev_dbg(dev, "CI_HDRC_CONTROLLER_STOPPED_EVENT received\n");
> > -		/*
> > -		 * Put the phy in non-driving mode. Otherwise host
> > -		 * may not detect soft-disconnection.
> > -		 */
> > -		usb_phy_notify_disconnect(ci->usb_phy, USB_SPEED_UNKNOWN);
> >  		break;
> >  	default:
> >  		dev_dbg(dev, "unknown ci_hdrc event\n");
> > @@ -53,21 +44,9 @@ static struct ci_hdrc_platform_data ci_hdrc_msm_platdata = {
> >  static int ci_hdrc_msm_probe(struct platform_device *pdev)
> >  {
> >  	struct platform_device *plat_ci;
> > -	struct usb_phy *phy;
> >  
> >  	dev_dbg(&pdev->dev, "ci_hdrc_msm_probe\n");
> >  
> > -	/*
> > -	 * OTG(PHY) driver takes care of PHY initialization, clock management,
> > -	 * powering up VBUS, mapping of registers address space and power
> > -	 * management.
> > -	 */
> > -	phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
> > -	if (IS_ERR(phy))
> > -		return PTR_ERR(phy);
> > -
> > -	ci_hdrc_msm_platdata.usb_phy = phy;
> > -
> >  	plat_ci = ci_hdrc_add_device(&pdev->dev,
> >  				pdev->resource, pdev->num_resources,
> >  				&ci_hdrc_msm_platdata);
> > -- 
> 

Wait, how about the UTMI PHY? You don't have a platform which needs
to get PHY through the phandle?

-- 

Best Regards,
Peter Chen
