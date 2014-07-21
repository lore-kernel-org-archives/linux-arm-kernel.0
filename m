From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 21 Jul 2014 10:03:07 +0200
Subject: [PATCH 8/9] usb: phy: am335x: call
 usb_gen_phy_init()/usb_gen_phy_shutdown() in
 am335x_init()/am335x_shutdown()
In-Reply-To: <20140718135713.GH24914@saruman.home>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-2-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-3-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-4-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-5-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-6-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-7-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-8-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-9-git-send-email-LW@KARO-electronics.de>
 <20140718135713.GH24914@saruman.home>
Message-ID: <20140721100307.21172b65@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Fri, Jul 18, 2014 at 11:31:29AM +0200, Lothar Wa?mann wrote:
> > This patch makes it possible to use the musb driver with HW that
> > requires external regulators or clocks.
> 
> can you provide an example of such HW ? Are you not using the internal
> PHYs ?
> 
The Ka-Ro electronics TX48 module uses the mmc0_clk pin as VBUSEN
rathern than usb0_drvvbus. This patch makes it possible to use an
external regulator to handle the VBUS switch through the 'vcc-supply'
property of the underlying generic_phy device.

> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > ---
> >  drivers/usb/phy/phy-am335x.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/usb/phy/phy-am335x.c b/drivers/usb/phy/phy-am335x.c
> > index 6522fa7..de25674 100644
> > --- a/drivers/usb/phy/phy-am335x.c
> > +++ b/drivers/usb/phy/phy-am335x.c
> > @@ -22,6 +22,7 @@ static int am335x_init(struct usb_phy *phy)
> >  {
> >  	struct am335x_phy *am_phy = dev_get_drvdata(phy->dev);
> >  
> > +	usb_gen_phy_init(phy);
> >  	phy_ctrl_power(am_phy->phy_ctrl, am_phy->id, true);
> >  	return 0;
> >  }
> > @@ -31,6 +32,7 @@ static void am335x_shutdown(struct usb_phy *phy)
> >  	struct am335x_phy *am_phy = dev_get_drvdata(phy->dev);
> >  
> >  	phy_ctrl_power(am_phy->phy_ctrl, am_phy->id, false);
> > +	usb_gen_phy_shutdown(phy);
> >  }
> >  
> >  static int am335x_phy_probe(struct platform_device *pdev)
> > -- 
> > 1.7.10.4
> > 
> 


-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
