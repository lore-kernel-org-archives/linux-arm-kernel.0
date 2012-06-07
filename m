From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 7 Jun 2012 12:11:24 +0200
Subject: 
In-Reply-To: <1338993547.6875.65.camel@sauron.fi.intel.com>
References: <1338978796-26129-1-git-send-email-s.hauer@pengutronix.de>
 <1338993547.6875.65.camel@sauron.fi.intel.com>
Message-ID: <20120607101124.GH30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Artem,

On Wed, Jun 06, 2012 at 05:39:07PM +0300, Artem Bityutskiy wrote:
> On Wed, 2012-06-06 at 12:33 +0200, Sascha Hauer wrote:
> > The following adds i.MX53 nand support and generally devicetree
> > based probing for i.MX5 boards. The first three patches should go
> > via mtd, the last patch optionally aswell if all agree.
> > 
> > Sascha
> > 
> > The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:
> > 
> >   Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.pengutronix.de/git/imx/linux-2.6.git imx/nand-mx53
> > 
> > for you to fetch changes up to d55d1479a3bfaedbb9f0c6c956f4dff6bb6d6d61:
> > 
> >   ARM i.MX5: Add nand oftree support (2012-06-06 12:20:24 +0200)
> 
> Do you want this to go via the MTD tree? Would you be able to collect
> acks for the arch/arm bits? Meanwhile, please, take a look at these
> sparse warnings added by this patch-set and detected by aiaiai:
> 
> --------------------------------------------------------------------------------
> 
> Successfully built configuration "arm-mxc-imx_defconfig,arm,arm-unknown-linux-gnueabi-", results:
> 
> --- before_patching.log
> +++ after_patching.log
> @@ @@
> +drivers/mtd/nand/mxc_nand.c:1289:26: warning: incorrect type in initializer (different modifiers) [sparse]
> +drivers/mtd/nand/mxc_nand.c:1289:26:    expected void *data [sparse]
> +drivers/mtd/nand/mxc_nand.c:1289:26:    got struct mxc_nand_devtype_data static const [toplevel] *<noident> [sparse]
> +drivers/mtd/nand/mxc_nand.c:1289:3: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]

Fixing these warnings in the nand driver does not seem to be the correct
approach. Initializing mxc_nand_devtype_data as const seems sane, the
problem is that struct of_device_id expects a void * instead of a const
void *. A patch fixing this is outstanding here:

http://permalink.gmane.org/gmane.linux.drivers.devicetree/15069

(this will also fix the other sparse warnings from this driver)

I asked Uwe to resend this.

So I only added Shawns Ack to the arm-i.MX part, you can pull this into
the mtd tree:


The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:

  Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/mtd-imx53-nand-support

for you to fetch changes up to 25d097d575d7c06b76e4e6e2488718976b70c432:

  ARM i.MX5: Add nand oftree support (2012-06-07 11:59:19 +0200)

----------------------------------------------------------------
Nand support for i.MX53 and devicetree snippets for i.MX5 nand

----------------------------------------------------------------
Sascha Hauer (4):
      mtd nand mxc_nand: Use managed resources
      mtd nand mxc_nand: swap iomem resource order
      mtd nand mxc_nand: add i.MX53 support
      ARM i.MX5: Add nand oftree support

 arch/arm/boot/dts/imx51.dtsi                  |    7 ++
 arch/arm/boot/dts/imx53.dtsi                  |    7 ++
 arch/arm/mach-imx/clk-imx51-imx53.c           |    2 +
 arch/arm/plat-mxc/devices/platform-mxc_nand.c |   11 +-
 drivers/mtd/nand/mxc_nand.c                   |  137 ++++++++++++++-----------
 5 files changed, 97 insertions(+), 67 deletions(-)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
