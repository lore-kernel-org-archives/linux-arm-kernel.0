From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Sep 2011 10:44:39 +0200
Subject: [PATCH 2/6] arm/imx6q: add core definitions and low-level debug
	uart
In-Reply-To: <20110907110001.GI8148@S2100-06.ap.freescale.net>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-3-git-send-email-shawn.guo@linaro.org>
	<20110906202555.GQ28816@pengutronix.de>
	<20110907110001.GI8148@S2100-06.ap.freescale.net>
Message-ID: <20110912084439.GO31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 07:00:02PM +0800, Shawn Guo wrote:
> On Tue, Sep 06, 2011 at 10:25:55PM +0200, Uwe Kleine-K?nig wrote:
> > On Tue, Sep 06, 2011 at 05:58:36PM +0800, Shawn Guo wrote:
> > > It adds the core definitions and low-level debug uart support
> > > for imx6q.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > >  arch/arm/Kconfig                             |    2 +-
> > >  arch/arm/Kconfig.debug                       |    7 +++++
> > >  arch/arm/Makefile                            |    1 +
> > >  arch/arm/mach-imx/Kconfig                    |    4 +++
> > >  arch/arm/mach-imx/Makefile                   |    2 +
> > >  arch/arm/mach-imx/Makefile.boot              |    4 +++
> > >  arch/arm/mach-imx/lluart.c                   |   33 ++++++++++++++++++++++++++
> > >  arch/arm/plat-mxc/Kconfig                    |    5 ++++
> > >  arch/arm/plat-mxc/include/mach/debug-macro.S |    5 ++++
> > >  arch/arm/plat-mxc/include/mach/entry-macro.S |   15 +++++++++++-
> > >  arch/arm/plat-mxc/include/mach/hardware.h    |    1 +
> > >  arch/arm/plat-mxc/include/mach/irqs.h        |    9 ++++--
> > >  arch/arm/plat-mxc/include/mach/memory.h      |    3 ++
> > >  arch/arm/plat-mxc/include/mach/mx6q.h        |   29 ++++++++++++++++++++++
> > >  14 files changed, 115 insertions(+), 5 deletions(-)
> > >  create mode 100644 arch/arm/mach-imx/lluart.c
> > >  create mode 100644 arch/arm/plat-mxc/include/mach/mx6q.h
> > > 
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index 4ea9974..37c20a4 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -1348,7 +1348,7 @@ config SMP
> > >  	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
> > >  		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
> > >  		 ARCH_EXYNOS4 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
> > > -		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE
> > > +		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE || SOC_IMX6Q
> > >  	select USE_GENERIC_SMP_HELPERS
> > >  	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
> > >  	help
> > > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > > index 965d59a..68fc155 100644
> > > --- a/arch/arm/Kconfig.debug
> > > +++ b/arch/arm/Kconfig.debug
> > > @@ -155,6 +155,13 @@ choice
> > >  		  Say Y here if you want kernel low-level debugging support
> > >  		  on i.MX50 or i.MX53.
> > >  
> > > +	config DEBUG_IMX6Q_UART
> > > +		bool "i.MX6Q Debug UART"
> > > +		depends on SOC_IMX6Q
> > > +		help
> > > +		  Say Y here if you want kernel low-level debugging support
> > > +		  on i.MX6Q.
> > > +
> > >  	config DEBUG_S3C_UART0
> > >  		depends on PLAT_SAMSUNG
> > >  		bool "Use S3C UART 0 for low-level debug"
> > > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > > index 70c424e..3a0bbe4 100644
> > > --- a/arch/arm/Makefile
> > > +++ b/arch/arm/Makefile
> > > @@ -159,6 +159,7 @@ machine-$(CONFIG_ARCH_MX2)		:= imx
> > >  machine-$(CONFIG_ARCH_MX25)		:= imx
> > >  machine-$(CONFIG_ARCH_MX3)		:= imx
> > >  machine-$(CONFIG_ARCH_MX5)		:= mx5
> > > +machine-$(CONFIG_ARCH_MX6)		:= imx
> > >  machine-$(CONFIG_ARCH_MXS)		:= mxs
> > >  machine-$(CONFIG_ARCH_NETX)		:= netx
> > >  machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
> > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > > index 0519dd7..4cf5178 100644
> > > --- a/arch/arm/mach-imx/Kconfig
> > > +++ b/arch/arm/mach-imx/Kconfig
> > > @@ -58,6 +58,10 @@ config SOC_IMX35
> > >  	select ARCH_MX35
> > >  	select MXC_AVIC
> > >  
> > > +config SOC_IMX6Q
> > > +	bool
> > > +	select ARM_GIC
> > > +	select CPU_V7
> > >  
> > >  if ARCH_MX1
> > >  
> > > diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> > > index e9eb36d..96ecc96 100644
> > > --- a/arch/arm/mach-imx/Makefile
> > > +++ b/arch/arm/mach-imx/Makefile
> > > @@ -61,3 +61,5 @@ obj-$(CONFIG_MACH_MX35_3DS) += mach-mx35_3ds.o
> > >  obj-$(CONFIG_MACH_EUKREA_CPUIMX35) += mach-cpuimx35.o
> > >  obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD) += eukrea_mbimxsd35-baseboard.o
> > >  obj-$(CONFIG_MACH_VPR200) += mach-vpr200.o
> > > +
> > > +obj-$(CONFIG_DEBUG_LL) += lluart.o
> > > diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
> > > index ebee18b..389a0e3 100644
> > > --- a/arch/arm/mach-imx/Makefile.boot
> > > +++ b/arch/arm/mach-imx/Makefile.boot
> > > @@ -17,3 +17,7 @@ initrd_phys-$(CONFIG_MACH_MX27)	:= 0xA0800000
> > >  zreladdr-$(CONFIG_ARCH_MX3)	:= 0x80008000
> > >  params_phys-$(CONFIG_ARCH_MX3)	:= 0x80000100
> > >  initrd_phys-$(CONFIG_ARCH_MX3)	:= 0x80800000
> > > +
> > > +zreladdr-$(CONFIG_SOC_IMX6Q)	:= 0x10008000
> > > +params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100
> > > +initrd_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10800000
> > Do you really need params_phys and initrd_phys?
> > 
> I added them to make IMX6Q look consistent with other soc in the file,
> and leave it to a global cleanup, if we decide to clean later.

I vote to skip params_phys and initrd_phys now. Every recent bootloader
does not need them. As the i.MX6 is a new SoC, we have no reason to
handle legacy bootloaders. When we want to to a global cleanup for these
variables we already know that i.MX6 has no legacy bootloader problems.

BTW many variables have the name imx6q, I suppose the 'q' is for quad
cpu. From the FSL website I know that there are other versions of the
i.MX6 planned. Are these variables really imx6q specific? Otherwise
please skip the 'q'.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
