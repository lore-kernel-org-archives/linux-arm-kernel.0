From: Peter.Chen@freescale.com (Peter Chen)
Date: Mon, 3 Mar 2014 01:58:21 +0000
Subject: [PATCH] ARM: i.MX6: clk: Remove usbphy clock hacks
In-Reply-To: <20140228101246.GA17250@pengutronix.de>
References: <1393489138-24406-1-git-send-email-s.hauer@pengutronix.de>
 <20140227120616.GA27749@shlinux1.ap.freescale.net>
 <20140227144744.GN17250@pengutronix.de>
 <20140228004050.GA23189@shlinux1.ap.freescale.net>
 <20140228101246.GA17250@pengutronix.de>
Message-ID: <b74eaca0df8144939f5d000addbc6666@BN1PR03MB235.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> On Fri, Feb 28, 2014 at 08:40:51AM +0800, Peter Chen wrote:
> > On Thu, Feb 27, 2014 at 03:47:45PM +0100, Sascha Hauer wrote:
> > > >  		portsc = PORTSC_PTS(PTS_UTMI) | PORTSC_PTW;
> > > >  		lpm = DEVLC_PTS(PTS_UTMI) | DEVLC_PTW;
> > > >  		break;
> > > >  	case USBPHY_INTERFACE_MODE_ULPI:
> > > >  		portsc = PORTSC_PTS(PTS_ULPI);
> > > >  		lpm = DEVLC_PTS(PTS_ULPI);
> > > > +		ret = usb_phy_init(ci->transceiver);
> > > > +		if (ret)
> > > > +			return ret;
> > > >  		break;
> > > >  	case USBPHY_INTERFACE_MODE_SERIAL:
> > > >  		portsc = PORTSC_PTS(PTS_SERIAL);
> > > >  		lpm = DEVLC_PTS(PTS_SERIAL);
> > > >  		sts = 1;
> > > > +		ret = usb_phy_init(ci->transceiver);
> > > > +		if (ret)
> > > > +			return ret;
> > > >  		break;
> > > >  	case USBPHY_INTERFACE_MODE_HSIC:
> > > > +		ret = usb_phy_init(ci->transceiver);
> > > > +		if (ret)
> > > > +			return ret;
> > > >  		portsc = PORTSC_PTS(PTS_HSIC);
> > > >  		lpm = DEVLC_PTS(PTS_HSIC);
> > >
> > > It seems you try to adjust the order in which PORTSC is configured
> > > and the phy is initialized. Instead of ordering the phy setup and
> > > register writes you just reorder some variable initializations.
> > >
> > > We discussed this back and forth here and think that the phy clock
> > > should be enabled/disabled via runtime pm ops as needed by the
> > > chipidea driver. Hacking the init order depending on the phy type
> > > like you did above doesn't sound like a good plan.
> > >
> >
> > The portsc.pts is only need to be set only time, at initialization
> > routine, the same for phy init.
> >
> > After init finishes, we can control phy clock by runtime pm, it was
> > what I did for PM patchset for chipidea driver.
> 
> I'm talking about runtime pm for the phy, not for the chipidea driver.
> 
 
The phy already has its APIs, .init, and .suspend, which can be called
at controller's driver, I don't see much benefits to call runtime pm API
to instead of them.

Besides, except we can access controller's register (like portsc.pts) at
phy driver, I don't know how we can unify the same phy APIs for different
phy drivers to finish initialization.

Peter
