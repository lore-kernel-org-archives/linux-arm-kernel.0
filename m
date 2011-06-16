From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 16 Jun 2011 09:30:18 +0200
Subject: [PATCH v2 5/6] ARM: mxc: all three imx51 TOs use TO1 version of
	sdma script
In-Reply-To: <20110615042948.GB31712@S2100-06.ap.freescale.net>
References: <1307950645-26529-6-git-send-email-shawn.guo@linaro.org>
	<1308032407-3860-1-git-send-email-shawn.guo@linaro.org>
	<20110614203809.GA23771@pengutronix.de>
	<20110615042948.GB31712@S2100-06.ap.freescale.net>
Message-ID: <20110616073018.GF23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 12:29:49PM +0800, Shawn Guo wrote:
> On Tue, Jun 14, 2011 at 10:38:09PM +0200, Sascha Hauer wrote:
> > On Tue, Jun 14, 2011 at 02:20:07PM +0800, Shawn Guo wrote:
> > > Though there are three TOs of imx51 soc, the sdma script never
> > > changes since TO1, which means all three TOs of imx51 uses TO1
> > > version of sdma script.
> > > 
> > > The current code passes TO number to imx-sdma driver to load
> > > different firmware for different TO.  That means we have to prepare
> > > 3 identical firmwares, sdma-imx51-to1.bin sdma-imx51-to2.bin and
> > > sdma-imx51-to3.bin, to have the kernel capable of running on all
> > > three TOs.  This just makes no sense.
> > > 
> > > The patch removes the TO number passing and get the default TO1
> > > version of sdma firmware work for all TOs.
> > 
> > I don't agree to this approach. The SDMA firmware has been different on
> > all TO versions of earlier i.MXs. For the linearity of the universe we
> > should keep this. What about providing a link in userspace?
> > 
> The fact is that mx31 and mx35 are the only two SoCs (relatively old
> ones) that have different SDMA firmwares on different TOs.  The
> relatively new ones, mx25 (TO1, TO1.1), mx50 (TO1, TO1.1), mx51
> (TO1, TO2, TO3) and mx53 (TO1, TO2) all have one version SDMA
> firmware for different TOs.  I do not see the mx31/35 case is a
> linearity of the universe.  Do we really want to bother ourselves
> with userspace link on so many latest SoCs?

Ok, then let's do it differently. Let's go away from "sdma-%s-to%d.bin"
in the sdma driver and pass the string from platform data instead.
Then we can pass the TO version where it's relevant and skip it where
only one firmware exists. Using a sdma-imx51-to1.bin for to2 and to3
is confusing.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
