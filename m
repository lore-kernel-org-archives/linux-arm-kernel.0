From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 16 Feb 2017 23:26:23 +0800
Subject: [PATCH RFC 2/3] coresight: add support for debug module
In-Reply-To: <20170215210805.GB29730@linaro.org>
References: <1486966298-16767-1-git-send-email-leo.yan@linaro.org>
 <1486966298-16767-3-git-send-email-leo.yan@linaro.org>
 <20170215210805.GB29730@linaro.org>
Message-ID: <20170216152623.GD544@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On Wed, Feb 15, 2017 at 02:08:05PM -0700, Mathieu Poirier wrote:
> On Mon, Feb 13, 2017 at 02:11:37PM +0800, Leo Yan wrote:
> > Coresight includes debug module and usually the module connects with CPU
> > debug logic. ARMv8 architecture reference manual (ARMv8-ARM) has defined
> > the debug registers in the chapter "H9: External Debug Register
> > Descriptions".
> > 
> > After enable the debug module we can check CPU state and PC value, etc.
> > So this is helpful for some CPU lockup bugs, e.g. if one CPU has run
> > into infinite loop with IRQ disabled. So the CPU cannot switch context
> > and handle any interrupt, so it cannot handle SMP call for stack dump,
> > etc. Furthermore, now ARMv8 introduces some other runtime firmwares like
> > ARM trusted firmware BL31, so sometime CPU hard lock may happen in the
> > firmware and cannot return back to kernel.
> > 
> > This patch is to enable coresight debug module and register callback
> > notifier for panic; so when system detect the CPU lockup we can utilize
> > debug module registers to get to know PC value for all CPUs; so we can
> > quickly know the hang address for CPUs.
> > 
> > This is initial driver for coresight debug module and could enhance it
> > later according to debugging requirement.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/hwtracing/coresight/Kconfig           |   8 ++
> >  drivers/hwtracing/coresight/Makefile          |   1 +
> >  drivers/hwtracing/coresight/coresight-debug.c | 169 ++++++++++++++++++++++++++
> >  3 files changed, 178 insertions(+)
> >  create mode 100644 drivers/hwtracing/coresight/coresight-debug.c
> > 
> > diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> > index 130cb21..dcf59cc 100644
> > --- a/drivers/hwtracing/coresight/Kconfig
> > +++ b/drivers/hwtracing/coresight/Kconfig
> > @@ -89,4 +89,12 @@ config CORESIGHT_STM
> >  	  logging useful software events or data coming from various entities
> >  	  in the system, possibly running different OSs
> >  
> > +config CORESIGHT_DEBUG
> > +	bool "CoreSight debug driver"
> > +	depends on ARM || ARM64
> > +	help
> > +	  This driver provides support for coresight debugging module. This
> > +	  is primarily used for printing out debug registers for panic and
> > +	  soft and hard lockup.
> > +
> >  endif
> > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> > index af480d9..d540d45 100644
> > --- a/drivers/hwtracing/coresight/Makefile
> > +++ b/drivers/hwtracing/coresight/Makefile
> > @@ -16,3 +16,4 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
> >  					coresight-etm4x-sysfs.o
> >  obj-$(CONFIG_CORESIGHT_QCOM_REPLICATOR) += coresight-replicator-qcom.o
> >  obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
> > +obj-$(CONFIG_CORESIGHT_DEBUG) += coresight-debug.o
> > diff --git a/drivers/hwtracing/coresight/coresight-debug.c b/drivers/hwtracing/coresight/coresight-debug.c
> > new file mode 100644
> > index 0000000..28206a83
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-debug.c
> > @@ -0,0 +1,169 @@
> > +/*
> > + * Copyright(C) 2017 Linaro Limited. All rights reserved.
> > + * Author: Leo Yan <leo.yan@linaro.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License version 2 as published by
> > + * the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/init.h>
> > +#include <linux/types.h>
> > +#include <linux/device.h>
> > +#include <linux/io.h>
> > +#include <linux/err.h>
> > +#include <linux/fs.h>
> > +#include <linux/slab.h>
> > +#include <linux/delay.h>
> > +#include <linux/smp.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/stat.h>
> > +#include <linux/clk.h>
> > +#include <linux/cpu.h>
> > +#include <linux/coresight.h>
> > +#include <linux/amba/bus.h>
> > +#include <linux/uaccess.h>
> 
> When possible, please try to order the header files alphabetically.

Will fix.

> > +
> > +#include "coresight-priv.h"
> > +
> > +#define EDPCSR_LO	0x0A0
> > +#define EDPCSR_HI	0x0AC
> > +#define EDOSLAR		0x300
> > +#define EDOSLSR		0x304
> > +#define EDPDCR		0x310
> > +#define EDPDSR		0x314
> 
> EDOSLSR, DEPDCR and EDPDSR aren't used in the code presented below.

Will remove them.

> > +
> > +struct debug_drvdata {
> > +	void __iomem	*base;
> > +	struct device	*dev;
> > +	int		cpu;
> > +};
> > +
> > +static struct debug_drvdata *debug_drvdata[NR_CPUS];
> > +
> > +static void debug_os_unlock(struct debug_drvdata *drvdata)
> > +{
> > +	/* Unlocks the debug registers */
> > +	writel_relaxed(0x0, drvdata->base + EDOSLAR);
> > +	isb();
> > +}
> > +
> > +static void debug_read_pcsr(struct debug_drvdata *drvdata)
> > +{
> > +	u32 pcsr_hi, pcsr_lo;
> > +
> > +	CS_UNLOCK(drvdata->base);
> > +
> > +	debug_os_unlock(drvdata);
> > +
> > +#ifdef CONFIG_64BIT
> > +	pcsr_lo = readl_relaxed(drvdata->base + EDPCSR_LO);
> > +	pcsr_hi = readl_relaxed(drvdata->base + EDPCSR_HI);
> > +
> > +	pr_emerg("CPU[%d]: PSCR=0x%lx\n", drvdata->cpu,
> > +		 ((unsigned long)pcsr_hi << 32 | (unsigned long)pcsr_lo));
> > +#else
> > +	pcsr_lo = readl_relaxed(drvdata->base + EDPCSR_LO);
> > +
> > +	pr_emerg("CPU[%d]: PSCR=0x%lx\n", drvdata->cpu,	pcsr_lo);
> > +#endif
> > +
> > +	CS_LOCK(drvdata->base);
> > +}
> > +
> > +/*
> > + * Dump out memory limit information on panic.
> > + */
> > +static int dump_debug(struct notifier_block *self, unsigned long v, void *p)
> > +{
> > +	int i;
> > +
> > +	pr_emerg("Coresight debug module:\n");
> > +
> > +	for_each_possible_cpu(i) {
> > +
> > +		if (!debug_drvdata[i])
> > +			continue;
> > +
> > +		debug_read_pcsr(debug_drvdata[i]);
> 
> Mark and Mike have raised a number of problems with this.  If I get things
> correctly the pseudocode (CreatePCSample() and EDPCSRlo[]), found in the
> reference manual, should be dealing with most of them. 

I reviewed the code for CreatePCSample() and EDPCSRlo[], they are
likely the pseudo code for hardware logic for PC sampling, but not
software code for how to read EDPCSR. But I think the code still
can give us some hints.

> One thing that is subtle in the peudocode is the memory-mapped access to these
> registers and something else that should be checked here before proceeding. 

Agree, I will follow Mike's suggestion.

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct notifier_block debug_notifier = {
> > +	.notifier_call = dump_debug,
> > +};
> > +
> > +static int __init register_coresight_debug_dumper(void)
> > +{
> > +	atomic_notifier_chain_register(&panic_notifier_list,
> > +				       &debug_notifier);
> > +	return 0;
> > +}
> > +__initcall(register_coresight_debug_dumper);
> > +
> > +static int debug_probe(struct amba_device *adev, const struct amba_id *id)
> > +{
> > +	void __iomem *base;
> > +	struct device *dev = &adev->dev;
> > +	struct coresight_platform_data *pdata = NULL;
> > +	struct debug_drvdata *drvdata;
> > +	struct resource *res = &adev->res;
> > +	struct device_node *np = adev->dev.of_node;
> > +
> > +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> > +	if (!drvdata)
> > +		return -ENOMEM;
> > +
> > +	if (np) {
> > +		pdata = of_get_coresight_platform_data(dev, np);
> > +		if (IS_ERR(pdata))
> > +			return PTR_ERR(pdata);
> > +		adev->dev.platform_data = pdata;
> > +	}
> > +
> > +	drvdata->dev = &adev->dev;
> > +	dev_set_drvdata(dev, drvdata);
> > +
> > +	/* Validity for the resource is already checked by the AMBA core */
> > +	base = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	drvdata->base = base;
> > +	drvdata->cpu = pdata ? pdata->cpu : 0;
> > +	debug_drvdata[drvdata->cpu] = drvdata;
> 
> Add atomic_notifier_chain_register() here rather than letting the infrastructure
> deal with it in an initcall.  That way we don't clutter the panic_notifier_list
> needlessly if the IP is not present.

Good point. Will fix.

[...]

Thanks,
Leo Yan
