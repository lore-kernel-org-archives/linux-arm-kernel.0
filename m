From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 27 Sep 2011 23:15:47 +0800
Subject: [PATCH v3 4/6] arm/imx6q: add smp and cpu hotplug support
In-Reply-To: <20110927134401.GE17997@S2100-06.ap.freescale.net>
References: <1317021651-17359-1-git-send-email-shawn.guo@linaro.org>
	<1317021651-17359-5-git-send-email-shawn.guo@linaro.org>
	<20110926110634.GR31404@pengutronix.de>
	<20110927134401.GE17997@S2100-06.ap.freescale.net>
Message-ID: <20110927151546.GF17997@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 09:44:02PM +0800, Shawn Guo wrote:
> On Mon, Sep 26, 2011 at 01:06:34PM +0200, Sascha Hauer wrote:
> > On Mon, Sep 26, 2011 at 03:20:49PM +0800, Shawn Guo wrote:
> > > It adds smp and cpu hotplug support for imx6q.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > >  arch/arm/mach-imx/Kconfig               |    1 +
> > >  arch/arm/mach-imx/Makefile              |    4 ++
> > >  arch/arm/mach-imx/head-v7.S             |   71 ++++++++++++++++++++++++++
> > >  arch/arm/mach-imx/hotplug.c             |   44 ++++++++++++++++
> > >  arch/arm/mach-imx/localtimer.c          |   35 +++++++++++++
> > >  arch/arm/mach-imx/platsmp.c             |   85 +++++++++++++++++++++++++++++++
> > >  arch/arm/plat-mxc/include/mach/common.h |    5 ++
> > >  7 files changed, 245 insertions(+), 0 deletions(-)
> > >  create mode 100644 arch/arm/mach-imx/head-v7.S
> > >  create mode 100644 arch/arm/mach-imx/hotplug.c
> > >  create mode 100644 arch/arm/mach-imx/localtimer.c
> > >  create mode 100644 arch/arm/mach-imx/platsmp.c
> > > 
> > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > > index af73b3e..6ec758d 100644
> > > --- a/arch/arm/mach-imx/Kconfig
> > > +++ b/arch/arm/mach-imx/Kconfig
> > > @@ -623,6 +623,7 @@ config SOC_IMX6Q
> > >  	bool "i.MX6 Quad support"
> > >  	select ARM_GIC
> > >  	select CPU_V7
> > > +	select HAVE_ARM_SCU
> > >  	select HAVE_IMX_GPC
> > >  	select HAVE_IMX_MMDC
> > >  	select HAVE_IMX_SRC
> > > diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> > > index 8c21fda..d46b2e7 100644
> > > --- a/arch/arm/mach-imx/Makefile
> > > +++ b/arch/arm/mach-imx/Makefile
> > > @@ -66,4 +66,8 @@ obj-$(CONFIG_DEBUG_LL) += lluart.o
> > >  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
> > >  obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
> > >  obj-$(CONFIG_HAVE_IMX_SRC) += src.o
> > > +obj-$(CONFIG_CPU_V7) += head-v7.o
> > 
> > Can we have a
> > 
> > AFLAGS_head-v7.o :=-Wa,-march=armv7-a
> > 
> > here?
> > 
> > Then you only have to adjust some Kconfig variables and can compile
> > i.MX3 and i.MX6 together. I just gave it a test and it works on i.MX3, I
> > don't have a i.MX6 platform to test on though.
> > 
> I tested it on imx6q, and it does not work.  I tracked it to the point
> at mxc_init_l2x0() which is an early_initcall.  Because we do not have
> mxc_cpu_type and cpu_is_mx6q() defined, the execution goes through the
> (!cpu_is_mx31() && !cpu_is_mx35()) check and ends up with Oops on
> imx6q.
> 
> I do not want to add mxc_cpu_type and cpu_is_mx6q() stuff, so I intend
> to remove early_initcall there, and let imx31/35_soc_init() explicitly
> calls mxc_init_l2x0().
> 
I'm changing my mind (so quickly).  It turns out we will fall into a
number of other traps if we build imx6q with imx3 without mxc_cpu_type
set up for imx6q, arch_idle(), __imx_ioremap(), etc.  So for now, I
want to add mxc_cpu_type for imx6q to cooperate with all these traps.

-- 
Regards,
Shawn
