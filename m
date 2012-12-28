From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 28 Dec 2012 10:14:32 +0800
Subject: [PATCH v4 2/7] usb: chipidea: add otg file
In-Reply-To: <20121227104758.GV26326@pengutronix.de>
References: <1356591603-23323-1-git-send-email-peter.chen@freescale.com>
 <1356591603-23323-3-git-send-email-peter.chen@freescale.com>
 <20121227104758.GV26326@pengutronix.de>
Message-ID: <20121228021431.GB29123@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 27, 2012 at 11:47:58AM +0100, Sascha Hauer wrote:
> On Thu, Dec 27, 2012 at 02:59:58PM +0800, Peter Chen wrote:
> >  struct ci13xxx {
> >  	struct device			*dev;
> > @@ -164,6 +165,7 @@ struct ci13xxx {
> >  	bool				global_phy;
> >  	struct usb_phy			*transceiver;
> >  	struct usb_hcd			*hcd;
> > +	struct usb_otg      otg;
> 
> I'd really like to know how this is going to proceed.
> 
> The ULPI driver currently allocates a struct usb_otg and sets
> otg->set_host and otg->set_vbus. Since now the chipidea driver uses its
> own struct usb_otg, this will not work with ULPI support.
We discussed before that the otg is not related to phy.
The struct usb_otg is better allocated at the otg driver, not phy driver.

I have a look at other phy drivers(drivers/usb/phy), now, there
is no one to create struct usb_otg at their phy drivers. To solve this
problem, we may need to modify ulpi phy driver.

To integrate ULPI phy, we may need to do:
- Make ulpi as a platform driver
- Override otg.set_host, and otg.set_vbus with ulpi's at
otg_ulpi_create or what else.
- Call otg_ulpi_create at the end of ci13xxx_imx_probe (before
pm_runtime_no_callbacks) if the phy is ulpi.

> 
> I see some ways out of this:
> 
> - Use a pointer above instead of an own struct usb_otg in the ci driver.
> - move the set_host and set_vbus callbacks to struct usb_phy.
> 
> I'd like to have this solved before we merge this patch.
> 
> Sascha
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 

-- 

Best Regards,
Peter Chen
