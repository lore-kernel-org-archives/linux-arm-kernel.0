From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 12 Sep 2011 22:27:38 +0800
Subject: [PATCH 3/6] arm/imx6q: add core drivers clock, gpc, mmdc and src
In-Reply-To: <201109121440.35933.arnd@arndb.de>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<20110912114932.GH1258@S2100-06.ap.freescale.net>
	<20110912123635.GK28624@pengutronix.de>
	<201109121440.35933.arnd@arndb.de>
Message-ID: <20110912142737.GJ1258@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2011 at 02:40:35PM +0200, Arnd Bergmann wrote:
> On Monday 12 September 2011, Uwe Kleine-K?nig wrote:
> > On Mon, Sep 12, 2011 at 07:49:33PM +0800, Shawn Guo wrote:
> > > On Mon, Sep 12, 2011 at 11:46:34AM +0200, Sascha Hauer wrote:
> > > > On Tue, Sep 06, 2011 at 05:58:37PM +0800, Shawn Guo wrote:
> > > > > +static int __init imx_src_init(void)
> > > > > +{
> > > > > + struct device_node *np;
> > > > > +
> > > > > + np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-src");
> > > > > + src_base = of_iomap(np, 0);
> > > > > + WARN_ON(!src_base);
> > > > > +
> > > > > + return 0;
> > > > > +}
> > > > > +early_initcall(imx_src_init);
> > > > 
> > > > What I'm concerned about is that we carefully removed all assumptions
> > > > about which SoC the code runs on in the past. Now with this patchset
> > > > many of them come back. Here we have a initcall without any check
> > > > whether we really run on i.MX6.
> > > 
> > > The "check" has been done on Kconfig level as below.
> > > 
> > > config SOC_IMX6Q
> > >         bool "i.MX6 Quad support"
> > >         select HAVE_IMX_SRC
> > > 
> > > obj-$(CONFIG_HAVE_IMX_SRC) += src.o
> > Think multi-SoC-kernel that has SOC_IMX6Q and say SOC_IMX51.
> 
Aha, I did miss the point.  I was misled by "Now with this patchset
many of them come back".  SRC is the only one being called by initcall.
MMDC is a real platform driver.  GPC and Clock init are called by
specific platform code.

> I think the code is almost ok, since it's only active when there is
> a "fsl,imx6q-src" device node. However, the WARN_ON must be removed
> if we want this to work well on a multi-soc kernel.
> 
> The more important point is to ensure that src_base is not being used
> on other SoCs, but that's probably covered as well.
> 
Thanks, Arnd.

-- 
Regards,
Shawn
