From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 30 Dec 2010 12:29:00 +0800
Subject: [PATCH 03/10] net/fec: add mac field into platform data and
	consolidate fec_get_mac
In-Reply-To: <20101229100520.GB19347@freescale.com>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-4-git-send-email-shawn.guo@freescale.com>
	<20101229065329.GB31010@jasper.tkos.co.il>
	<20101229100520.GB19347@freescale.com>
Message-ID: <20101230042858.GA20651@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Wed, Dec 29, 2010 at 06:05:20PM +0800, Shawn Guo wrote:
> Hi Baruch,
> 
> On Wed, Dec 29, 2010 at 08:53:30AM +0200, Baruch Siach wrote:
> > Hi Shawn,
> > 
> > Please add netdev at vger.kernel.org to the Cc of all your fec driver patches.
> > 
> > On Tue, Dec 28, 2010 at 10:55:48PM +0800, Shawn Guo wrote:
> > > Add mac field into fec_platform_data and consolidate function
> > > fec_get_mac to get mac address in following order.
> > > 
> > >  1) kernel command line fec_mac=xx:xx:xx...
> > 
> > In the case of dual MAC that you later add support for, the address which one 
> > is being set? Is there a way to set both in kernel command line?
> > 
> The fec0 gets fec_mac and fec1 gets fec_mac + 1. The following code
> in function fec_get_mac takes care of it.
> 
> 	/* Adjust MAC if using default MAC address */
> 	if (iap == fec_mac_default)
> 		dev->dev_addr[ETH_ALEN-1] = fec_mac_default[ETH_ALEN-1] + fep->pdev->id;
> 
> 
> > Also, instead of inventing another kernel command line parameter, it is better 
> > IMO to use the module parameters mechanism. The greth NIC driver already uses 
> > this method for setting MAC address. Look for 'macaddr' in 
> > drivers/net/greth.c, and the explanation at the beginning of 
> > Documentation/kernel-parameters.txt.
> > 
> Sounds good. Thanks.
> 
I just thought this over again. Module parameter might not be
the best here. fec is usually used to mount nfs during boot,
which requires a built-in driver other than module.

-- 
Regards,
Shawn
