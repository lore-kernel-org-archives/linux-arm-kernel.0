From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 3 Apr 2013 08:35:37 +0200
Subject: [GIT PULL] imx fixes for 3.9, take 5
In-Reply-To: <20130403031511.GB27874@quad.lixom.net>
References: <20130402134627.GF24039@S2101-09.ap.freescale.net>
 <20130403031511.GB27874@quad.lixom.net>
Message-ID: <20130403063537.GP1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 08:15:11PM -0700, Olof Johansson wrote:
> On Tue, Apr 02, 2013 at 09:46:29PM +0800, Shawn Guo wrote:
> > The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:
> > 
> >   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.9-5
> > 
> > for you to fetch changes up to 710b213d3f1cdb0451fa2d5a71faa2b1f510e3ad:
> > 
> >   ARM: imx35 Bugfix admux clock (2013-04-02 21:05:40 +0800)
> > 
> > ----------------------------------------------------------------
> > The imx fixes for 3.9, take 5:
> >  - One fix for the typo in use of Kconfig symbol
> >    MACH_EUKREA_CPUIMX27_USEUART4.  It's been there for a long time
> >    and got caught by code inspection recently.  It hasn't been noticed
> >    earlier probably because it does not cause any problem in real.
> 
> 2.6.35 to be exact.
> 
> It's more a sign that the board can be removed than that it should be fixed
> immediately for 3.9, wouldn't you say? Clearly no one seems to care about
> mainline functionality on that platform -- especially since it was now found
> through inspection and not usage.
> 
> >  - A couple of fixes on imx35 clock driver to have audmux functional
> >    and iomux pad configurable after a reboot.
> 
> These look like valid fixes but I can't from the commit messages tell
> when the problem was introduced, and what the actual breakage that the
> user sees it. It almost looks like it's adding a few clocks that were
> never used before, not a regression? I'm happy to be proven wrong though.

Maybe the commit log could be better, but they are real bug fixes.

ARM: imx35 Bugfix admux clock

This patch registers a new lookup so that the audmux driver finds the
clock and enables it (the clock is optional in the driver). Otherwise
the clock framework will find the clock unused and disables it during
late init time.

ARM: clk-imx35: Bugfix iomux clock

This patch enables a clock needed for the iomuxer, otherwise it gets
disabled during late init time and the iomux stops working. This usually
is not noticed because normally the iomux is configured before that
point.
The really correct solution is to add clock support to the iomux driver
instead of enabling it in the SoC clock driver. This requires changes for
all SoCs using this driver though which still should be done later.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
