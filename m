From: b20788@freescale.com (Anson Huang)
Date: Wed, 20 Mar 2013 16:45:54 -0400
Subject: [PATCH 1/3] ARM: imx: enable anatop suspend/resume
In-Reply-To: <20130320072930.GC26941@S2101-09.ap.freescale.net>
References: <1363801180-8284-1-git-send-email-b20788@freescale.com>
 <20130320072930.GC26941@S2101-09.ap.freescale.net>
Message-ID: <20130320204554.GA13929@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 03:29:33PM +0800, Shawn Guo wrote:
> On Wed, Mar 20, 2013 at 01:39:38PM -0400, Anson Huang wrote:
> > anatop module have sereval configurations for user
> > to reduce the power consumption in suspend, provide
> > suspend/resume interface for further use and enable
> > fet_odrive to reduce CORE LDO leakage during suspend.
> > 
> > Signed-off-by: Anson Huang <b20788@freescale.com>
> > ---
> >  arch/arm/mach-imx/Kconfig      |    4 ++++
> >  arch/arm/mach-imx/Makefile     |    1 +
> >  arch/arm/mach-imx/anatop.c     |   50 ++++++++++++++++++++++++++++++++++++++++
> 
> I like the idea of having an anatop.c for all those anatop related
> setup.  Please move those anatop related code in mach-imx6q.c
> into there as well.  Leaving them out there beats the idea of having
> a centralized place for anatop configurations.
will do that in V2.
> 
> >  arch/arm/mach-imx/common.h     |    3 +++
> >  arch/arm/mach-imx/mach-imx6q.c |    1 +
> >  arch/arm/mach-imx/pm-imx6q.c   |    2 ++
> >  6 files changed, 61 insertions(+)
> >  create mode 100644 arch/arm/mach-imx/anatop.c
> > 
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index 4c9c6f9..7abaa6e 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -74,6 +74,9 @@ config HAVE_IMX_MMDC
> >  config HAVE_IMX_SRC
> >  	def_bool y if SMP
> >  
> > +config HAVE_IMX_ANATOP
> > +	bool
> > +
> 
> Please have it added before "config HAVE_IMX_GPC".  We are trying to
> have them sorted in alphabet.
Accepted
> 
> >  config IMX_HAVE_IOMUX_V1
> >  	bool
> >  
> > @@ -816,6 +819,7 @@ config SOC_IMX6Q
> >  	select HAVE_IMX_GPC
> >  	select HAVE_IMX_MMDC
> >  	select HAVE_IMX_SRC
> > +	select HAVE_IMX_ANATOP
> 
> Ditto
Accepted
> 
> >  	select HAVE_SMP
> >  	select MFD_SYSCON
> >  	select PINCTRL
> > diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> > index c4ce090..f4badaa 100644
> > --- a/arch/arm/mach-imx/Makefile
> > +++ b/arch/arm/mach-imx/Makefile
> > @@ -95,6 +95,7 @@ obj-$(CONFIG_MACH_VPR200) += mach-vpr200.o
> >  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
> >  obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
> >  obj-$(CONFIG_HAVE_IMX_SRC) += src.o
> > +obj-$(CONFIG_HAVE_IMX_ANATOP) += anatop.o
> 
> Ditto
Accepted
> 
> >  AFLAGS_headsmp.o :=-Wa,-march=armv7-a
> >  obj-$(CONFIG_SMP) += headsmp.o platsmp.o
> >  obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
> > diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
> > new file mode 100644
> > index 0000000..8f6ab27
> > --- /dev/null
> > +++ b/arch/arm/mach-imx/anatop.c
> > @@ -0,0 +1,50 @@
> > +/*
> > + * Copyright (C) 2013 Freescale Semiconductor, Inc.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/regmap.h>
> > +
> > +#define REG_SET		0x4
> > +#define REG_CLR		0x8
> > +#define ANA_REG_CORE	0x140
> 
> The abbreviation ANA is used here ...
> 
> > +
> > +#define BM_ANADIG_REG_CORE_FET_ODRIVE		0x20000000
> 
> ... while "ANADIG" is here.  Please be consistent.
Accepted.
> 
> > +
> > +static struct regmap *anatop;
> > +
> > +void imx_anatop_enable_fet_odrive(bool enable)
> 
> static?
Accepted.
> 
> > +{
> > +	regmap_write(anatop, ANA_REG_CORE + (enable ?
> > +		REG_SET : REG_CLR), BM_ANADIG_REG_CORE_FET_ODRIVE);
> 
> This is a nit, but I think the following indent is nicer for reading.
> 
> 	regmap_write(anatop, ANA_REG_CORE + (enable ? REG_SET : REG_CLR),
> 		     BM_ANADIG_REG_CORE_FET_ODRIVE);
Accepted.
> 
> > +}
> > +
> > +void imx_anatop_pre_suspend(void)
> 
> static?
This function will be called outside this file, so we can NOT use static here.
> 
> Shawn
> 
> > +{
> > +	imx_anatop_enable_fet_odrive(true);
> > +}
> > +
> > +void imx_anatop_post_resume(void)
> > +{
> > +	imx_anatop_enable_fet_odrive(false);
> > +}
> > +
> > +void __init imx_anatop_init(void)
> > +{
> > +	anatop = syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");
> > +	if (IS_ERR(anatop)) {
> > +		pr_err("%s: failed to find imx6q-anatop regmap!\n", __func__);
> > +		return;
> > +	}
> > +}
> > diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> > index 5a800bf..004c2b3 100644
> > --- a/arch/arm/mach-imx/common.h
> > +++ b/arch/arm/mach-imx/common.h
> > @@ -129,6 +129,9 @@ extern void imx_src_prepare_restart(void);
> >  extern void imx_gpc_init(void);
> >  extern void imx_gpc_pre_suspend(void);
> >  extern void imx_gpc_post_resume(void);
> > +extern void imx_anatop_init(void);
> > +extern void imx_anatop_pre_suspend(void);
> > +extern void imx_anatop_post_resume(void);
> >  extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
> >  extern void imx6q_set_chicken_bit(void);
> >  
> > diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> > index 9ffd103..aa867db 100644
> > --- a/arch/arm/mach-imx/mach-imx6q.c
> > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > @@ -197,6 +197,7 @@ static void __init imx6q_init_machine(void)
> >  
> >  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> >  
> > +	imx_anatop_init();
> >  	imx6q_pm_init();
> >  	imx6q_usb_init();
> >  	imx6q_1588_init();
> > diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
> > index 5faba7a..05b26cd 100644
> > --- a/arch/arm/mach-imx/pm-imx6q.c
> > +++ b/arch/arm/mach-imx/pm-imx6q.c
> > @@ -34,10 +34,12 @@ static int imx6q_pm_enter(suspend_state_t state)
> >  	case PM_SUSPEND_MEM:
> >  		imx6q_set_lpm(STOP_POWER_OFF);
> >  		imx_gpc_pre_suspend();
> > +		imx_anatop_pre_suspend();
> >  		imx_set_cpu_jump(0, v7_cpu_resume);
> >  		/* Zzz ... */
> >  		cpu_suspend(0, imx6q_suspend_finish);
> >  		imx_smp_prepare();
> > +		imx_anatop_post_resume();
> >  		imx_gpc_post_resume();
> >  		imx6q_set_lpm(WAIT_CLOCKED);
> >  		break;
> > -- 
> > 1.7.9.5
> > 
> > 
