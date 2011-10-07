From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 7 Oct 2011 20:40:28 +0800
Subject: [PATCH v2 5/7] ARM: highbank: add SMP support
In-Reply-To: <4E8C7F10.8070903@gmail.com>
References: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
	<1314841446-11006-6-git-send-email-robherring2@gmail.com>
	<20110906010105.GA7623@S2100-06.ap.freescale.net>
	<4E8C7F10.8070903@gmail.com>
Message-ID: <20111007124027.GE23105@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2011 at 11:00:16AM -0500, Rob Herring wrote:
> Shawn,
> 
> On 09/05/2011 08:01 PM, Shawn Guo wrote:
> > On Wed, Aug 31, 2011 at 08:44:04PM -0500, Rob Herring wrote:
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> This enables SMP support on highbank processor.
> >>
> >> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> >> ---
> >> Changes in v2:
> >>  - drop NULL check of scu_base
> >>  - use IPI #0 instead of #1 to boot secondary
> >>  - s/a9_base_addr/scu_base_addr/
> >>  - fix muliple mapping of twd registers
> >>
> >>  arch/arm/Kconfig                    |    2 +-
> >>  arch/arm/mach-highbank/Makefile     |    2 +
> >>  arch/arm/mach-highbank/localtimer.c |   38 +++++++++++++++++
> >>  arch/arm/mach-highbank/platsmp.c    |   78 +++++++++++++++++++++++++++++++++++
> >>  4 files changed, 119 insertions(+), 1 deletions(-)
> >>  create mode 100644 arch/arm/mach-highbank/localtimer.c
> >>  create mode 100644 arch/arm/mach-highbank/platsmp.c
> >>
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index 9019a56..6d2add5 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -1372,7 +1372,7 @@ config SMP
> >>  	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
> >>  		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
> >>  		 ARCH_EXYNOS4 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
> >> -		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE
> >> +		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE || ARCH_HIGHBANK
> >>  	select USE_GENERIC_SMP_HELPERS
> >>  	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
> >>  	help
> >> diff --git a/arch/arm/mach-highbank/Makefile b/arch/arm/mach-highbank/Makefile
> >> index 11d4010..311c0e8e 100644
> >> --- a/arch/arm/mach-highbank/Makefile
> >> +++ b/arch/arm/mach-highbank/Makefile
> >> @@ -1,2 +1,4 @@
> >>  obj-y					:= clock.o highbank.o system.o
> >>  obj-$(CONFIG_DEBUG_LL)			+= lluart.o
> >> +obj-$(CONFIG_SMP)			+= platsmp.o
> >> +obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o
> >> diff --git a/arch/arm/mach-highbank/localtimer.c b/arch/arm/mach-highbank/localtimer.c
> >> new file mode 100644
> >> index 0000000..344ea29
> >> --- /dev/null
> >> +++ b/arch/arm/mach-highbank/localtimer.c
> >> @@ -0,0 +1,38 @@
> >> +/*
> >> + * Copyright 2010-2011 Calxeda, Inc.
> >> + * Based on localtimer.c, Copyright (C) 2002 ARM Ltd.
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify it
> >> + * under the terms and conditions of the GNU General Public License,
> >> + * version 2, as published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope it will be useful, but WITHOUT
> >> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> >> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> >> + * more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License along with
> >> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> >> + */
> >> +#include <linux/init.h>
> >> +#include <linux/clockchips.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/of_irq.h>
> >> +
> >> +#include <asm/smp_twd.h>
> >> +
> >> +/*
> >> + * Setup the local clock events for a CPU.
> >> + */
> >> +int __cpuinit local_timer_setup(struct clock_event_device *evt)
> >> +{
> >> +	struct device_node *np;
> >> +
> >> +	np = of_find_compatible_node(NULL, NULL, "arm,smp-twd");
> >> +	if (!twd_base)
> >> +		twd_base = of_iomap(np, 0);
> > 
> > WARN_ON(!twd_base)?
> > 
> 
> Okay, will add it. Can I add your Reviewed-by for the series?
> 
Yes, if you'd like to ;)

-- 
Regards,
Shawn
