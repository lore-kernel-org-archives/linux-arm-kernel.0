From: atull@opensource.altera.com (atull)
Date: Fri, 26 Sep 2014 15:23:07 -0500
Subject: [PATCH 2/2] socfpga: support suspend to ram
In-Reply-To: <54257E8C.8000102@opensource.altera.com>
References: <1411590449-9794-1-git-send-email-atull@opensource.altera.com>
 <1411590449-9794-3-git-send-email-atull@opensource.altera.com>
 <54257E8C.8000102@opensource.altera.com>
Message-ID: <alpine.DEB.2.02.1409261519320.1444@atx-linux-37>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Sep 2014, Dinh Nguyen wrote:

> On 09/24/2014 03:27 PM, atull at opensource.altera.com wrote:
> > From: Alan Tull <atull@opensource.altera.com>
> > 
> > Add code that requests that the sdr controller go into
> > self-refresh mode.  This code is run from ocram.
> > 
> > This patch assumes that u-boot has already configured sdr:
> >   sdr.ctrlcfg.lowpwreq.selfrfshmask = 3
> >   sdr.ctrlcfg.lowpwrtiming.clkdisablecycles = 8
> >   sdr.ctrlcfg.dramtiming4.selfrfshexit = 512
> > 
> > How to suspend to ram:
> >  $ echo enabled > \
> > /sys/devices/soc/ffc02000.serial0/tty/ttyS0/power/wakeup
> > 
> >  $ echo -n mem > /sys/power/state
> > 
> > Signed-off-by: Alan Tull <atull@opensource.altera.com>
> > ---
> >  arch/arm/mach-socfpga/Makefile       |    1 +
> >  arch/arm/mach-socfpga/core.h         |    4 +
> >  arch/arm/mach-socfpga/pm.c           |  141 ++++++++++++++++++++++++++++++++
> >  arch/arm/mach-socfpga/self-refresh.S |  148 ++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-socfpga/socfpga.c      |   10 +++
> >  5 files changed, 304 insertions(+)
> >  create mode 100644 arch/arm/mach-socfpga/pm.c
> >  create mode 100644 arch/arm/mach-socfpga/self-refresh.S
> > 
> > diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
> > index 6dd7a93..0591927 100644
> > --- a/arch/arm/mach-socfpga/Makefile
> > +++ b/arch/arm/mach-socfpga/Makefile
> > @@ -4,3 +4,4 @@
> >  
> >  obj-y					:= socfpga.o
> >  obj-$(CONFIG_SMP)	+= headsmp.o platsmp.o
> > +obj-$(CONFIG_SUSPEND)	+= pm.o self-refresh.o
> > diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
> > index c4a0929..cc1a2fb 100644
> > --- a/arch/arm/mach-socfpga/core.h
> > +++ b/arch/arm/mach-socfpga/core.h
> > @@ -38,6 +38,7 @@ extern void socfpga_sysmgr_init(void);
> >  
> >  extern void __iomem *sys_manager_base_addr;
> >  extern void __iomem *rst_manager_base_addr;
> > +extern void __iomem *sdr_ctl_base_addr;
> >  
> >  extern struct smp_operations socfpga_smp_ops;
> >  extern char secondary_trampoline, secondary_trampoline_end;
> > @@ -46,4 +47,7 @@ extern unsigned long cpu1start_addr;
> >  
> >  #define SOCFPGA_SCU_VIRT_BASE   0xfffec000
> >  
> > +u32 socfpga_sdram_self_refresh(u32 sdr_base, u32 scu_base);
> > +extern unsigned int socfpga_sdram_self_refresh_sz;
> > +
> >  #endif
> > diff --git a/arch/arm/mach-socfpga/pm.c b/arch/arm/mach-socfpga/pm.c
> > new file mode 100644
> > index 0000000..02c3719
> > --- /dev/null
> > +++ b/arch/arm/mach-socfpga/pm.c
> > @@ -0,0 +1,141 @@
> > +/*
> > + *  arch/arm/mach-socfpga/pm.c
> > + *
> > + * Copyright (C) 2014 Altera Corporation. All rights reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/suspend.h>
> > +#include <asm/suspend.h>
> > +#include <asm/fncpy.h>
> > +#include "core.h"
> > +
> > +/* Pointer to function copied to ocram */
> > +static u32 (*socfpga_sdram_self_refresh_in_ocram)(u32 sdr_base, u32 scu_base);
> > +
> > +/* Round up a pointer address to fix aligment for fncpy() */
> > +static void *fncpy_align(void *ptr)
> > +{
> > +	u32 value = (u32)ptr;
> > +
> > +	if ((value & (FNCPY_ALIGN - 1)) != 0)
> > +		value = ((value & ~(FNCPY_ALIGN - 1)) + FNCPY_ALIGN);
> > +
> > +	return (void *)value;
> > +}
> > +
> > +static void *socfpga_init_ocram_exec(void)
> > +{
> > +	struct device_node *np;
> > +	const __be32 *prop;
> > +	u32 ocram_hwaddr, len;
> > +	void __iomem  *iomem_exec_ocram;
> > +	size_t size;
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "mmio-sram");
> > +	if (!np) {
> > +		pr_err("SOCFPGA: Unable to find mmio-sram in dtb\n");
> > +		return 0;
> > +	}
> > +
> > +	/* Determine the OCRAM address and size */
> > +	prop = of_get_property(np, "reg", &size);
> > +	ocram_hwaddr = be32_to_cpup(prop++);
> > +	len = be32_to_cpup(prop);
> > +
> > +	if (!prop || size < sizeof(*prop)) {
> > +		pr_err("SOCFPGA: Unable to find OCRAM mapping in dtb\n");
> > +		return 0;
> > +	}
> > +
> > +	iomem_exec_ocram = __arm_ioremap_exec(ocram_hwaddr, len, 0);
> 
> The call to __arm_ioremap_exec can fail. Also, this doesn't seem right,
> what if a good chunk of OCRAM has been used by some other driver in the
> system? From what I've seen, OCRAM should be using the generic allocator
> framework.

Good catch.  I will check for this faiure in v2.  Also, yes, use the generic
allocator framework.

> 
> > +
> > +	/* Fix alignment to work with fncpy */
> > +	iomem_exec_ocram = fncpy_align(iomem_exec_ocram);
> > +
> > +	return iomem_exec_ocram;
> > +}
> > +
> > +static int socfpga_setup_ocram_self_refresh(void)
> > +{
> > +	void *ocram_addr;
> > +
> > +	/* Configure ocram and make it executable */
> > +	ocram_addr = socfpga_init_ocram_exec();
> > +	WARN(!ocram_addr, "Unable to initialize ocram for pm");
> > +	if (!ocram_addr)
> > +		return -EFAULT;
> > +
> > +	/* Copy the code that puts DDR in self refresh to ocram */
> > +	socfpga_sdram_self_refresh_in_ocram =
> > +		(void *)fncpy((void *)ocram_addr,
> > +		      &socfpga_sdram_self_refresh,
> > +		      socfpga_sdram_self_refresh_sz);
> > +
> > +	WARN(!socfpga_sdram_self_refresh_in_ocram,
> > +	     "could not copy function to ocram");
> > +	if (!socfpga_sdram_self_refresh_in_ocram)
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> > +static int socfpga_pm_suspend(unsigned long arg)
> > +{
> > +	u32 ret;
> > +
> > +	ret = socfpga_sdram_self_refresh_in_ocram((u32)sdr_ctl_base_addr,
> > +						  (u32)socfpga_scu_base_addr);
> 
> What if sdr_ctl_base_addr is not valid?

I will check for NULL in v2.

Alan

> 
> BR,
> Dinh
> 
> 
