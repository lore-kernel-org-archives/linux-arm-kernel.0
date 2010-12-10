From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 10 Dec 2010 10:12:53 +0100
Subject: [PATCH 4/4 v2] ARM: S5PV210: Add clock definition for MIPI-CSIS
	DPHY
In-Reply-To: <028901cb9829$1ad1cfb0$50756f10$%kim@samsung.com>
References: <1291405965-19482-1-git-send-email-s.nawrocki@samsung.com>
	<1291405965-19482-5-git-send-email-s.nawrocki@samsung.com>
	<028901cb9829$1ad1cfb0$50756f10$%kim@samsung.com>
Message-ID: <011101cb984a$701446d0$503cd470$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, December 10, 2010 6:14 AM Kukjin Kim wrote:

> Sylwester Nawrocki wrote:
> >
> > MIPI DPHY control register requires special handling since it is shared
> > between CSI (camera serial interface) and DSI (display serial interface).
> > By creating this clock a serialized interface is provided for mipi-csis
> > and mipi-dsim drivers, so DPHYs may be safely controlled by both drivers.
> > Similarly dsim_dphy clock could be added for mipi-dsim.
> >
> > ---
> >
> > I am not quite sure about_"dphy_clock", perhaps power domain
> > handling code would be better place for it.
> >
> Yeah, it is MIPI DPHY enable/disable control register not clock control.
> So its proper position is not here...
> 
> Hmm...how about driver's probe/open or some kind of setup in machine
> directory?

I'm not sure that this is the best way of handling this phy controller. Please
notice that mipi phy controller has different register location on S5PC110 and
S5PC210. Please also notice that S5PC210 has 2 mipi csci controllers and phy
interfaces, while s5pc110 has only one. Hiding all the logic and register
specific writes behind this 'csi_dphy' clock easily resolves all these issues
on all different samsung platforms and makes it easy to use it from the driver.
Similar patch has been proposed some time ago for usb_phy interface and imho
this is the right way to go.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
