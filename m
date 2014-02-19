From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 19 Feb 2014 08:54:02 +0800
Subject: [PATCH v9 11/12] usb: phy-mxs: Add system suspend/resume API
In-Reply-To: <20140218165032.GN9878@saruman.home>
References: <1388111921-17326-1-git-send-email-peter.chen@freescale.com>
 <1388111921-17326-12-git-send-email-peter.chen@freescale.com>
 <20140218165032.GN9878@saruman.home>
Message-ID: <20140219005401.GB11878@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 10:50:32AM -0600, Felipe Balbi wrote:
> On Fri, Dec 27, 2013 at 10:38:40AM +0800, Peter Chen wrote:
> > We need this to keep PHY's power on or off during the system
> > suspend mode. If we need to enable USB wakeup, then we
> > must keep PHY's power being on during the system suspend mode.
> > Otherwise, we need to keep PHY's power being off to save power.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/phy/phy-mxs-usb.c |   61 +++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 61 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> > index 96aac05..53b8dad 100644
> > --- a/drivers/usb/phy/phy-mxs-usb.c
> > +++ b/drivers/usb/phy/phy-mxs-usb.c
> > @@ -57,6 +57,10 @@
> >  #define BM_USBPHY_DEBUG_CLKGATE			BIT(30)
> >  
> >  /* Anatop Registers */
> > +#define ANADIG_ANA_MISC0			0x150
> > +#define ANADIG_ANA_MISC0_SET			0x154
> > +#define ANADIG_ANA_MISC0_CLR			0x158
> > +
> >  #define ANADIG_USB1_VBUS_DET_STAT		0x1c0
> >  #define ANADIG_USB2_VBUS_DET_STAT		0x220
> >  
> > @@ -65,6 +69,9 @@
> >  #define ANADIG_USB2_LOOPBACK_SET		0x244
> >  #define ANADIG_USB2_LOOPBACK_CLR		0x248
> >  
> > +#define BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG	BIT(12)
> > +#define BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG_SL BIT(11)
> > +
> >  #define BM_ANADIG_USB1_VBUS_DET_STAT_VBUS_VALID	BIT(3)
> >  #define BM_ANADIG_USB2_VBUS_DET_STAT_VBUS_VALID	BIT(3)
> >  
> > @@ -134,6 +141,16 @@ struct mxs_phy {
> >  	int port_id;
> >  };
> >  
> > +static inline bool is_imx6q_phy(struct mxs_phy *mxs_phy)
> > +{
> > +	return mxs_phy->data == &imx6q_phy_data;
> > +}
> > +
> > +static inline bool is_imx6sl_phy(struct mxs_phy *mxs_phy)
> > +{
> > +	return mxs_phy->data == &imx6sl_phy_data;
> > +}
> > +
> >  static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
> >  {
> >  	int ret;
> > @@ -382,6 +399,8 @@ static int mxs_phy_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, mxs_phy);
> >  
> > +	device_set_wakeup_capable(&pdev->dev, true);
> > +
> >  	ret = usb_add_phy_dev(&mxs_phy->phy);
> >  	if (ret)
> >  		return ret;
> > @@ -398,6 +417,47 @@ static int mxs_phy_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_PM_SLEEP
> 
> please use CONFIG_PM instead.
> 

No.

See kernel/power/Kconfig

config PM_SLEEP
	def_bool y
	depends on SUSPEND || HIBERNATE_CALLBACKS
		
config PM
	def_bool y
	depends on PM_SLEEP || PM_RUNTIME

Here, we need suspend API for system suspend, if PM_RUNTIME
is enabled, but PM_SLEEP is disabled, we don't hope
this function is defined.

-- 

Best Regards,
Peter Chen
