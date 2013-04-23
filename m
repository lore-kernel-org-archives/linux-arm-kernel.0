From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 23 Apr 2013 15:27:41 +0100
Subject: [RFC PATCH] drivers: bus: add ARM CCI support
In-Reply-To: <1366725128.8473.21.camel@computer5.home>
References: <1365691679-28674-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1365691679-28674-2-git-send-email-lorenzo.pieralisi@arm.com>
 <1366725128.8473.21.camel@computer5.home>
Message-ID: <20130423142741.GH22946@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 02:52:08PM +0100, Jon Medhurst (Tixy) wrote:
> On Thu, 2013-04-11 at 15:47 +0100, Lorenzo Pieralisi wrote:
> [...]
> > diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> > new file mode 100644
> > index 0000000..81953de
> > --- /dev/null
> > +++ b/drivers/bus/arm-cci.c
> > @@ -0,0 +1,344 @@
> > +/*
> > + * CCI cache coherent interconnect driver
> > + *
> > + * Copyright (C) 2013 ARM Ltd.
> > + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > + * kind, whether express or implied; without even the implied warranty
> > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/arm-cci.h>
> > +#include <linux/device.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#include <asm/cacheflush.h>
> > +#include <asm/dt_affinity.h>
> > +#include <asm/outercache.h>
> > +#include <asm/smp_plat.h>
> > +
> > +#define DRIVER_NAME		"CCI"
> > +#define CCI_CTRL_STATUS		0xc
> > +
> > +#define CCI_PORT_CTRL		0x0
> > +
> > +struct cci_nb_ports {
> > +	unsigned int nb_ace;
> > +	unsigned int nb_ace_lite;
> > +};
> > +
> > +enum cci_ace_port_type {
> > +	ACE_INVALID_PORT = 0x0,
> > +	ACE_PORT,
> > +	ACE_LITE_PORT,
> > +};
> > +
> > +struct cci_ace_port {
> > +	void __iomem *base;
> > +	int type;
> > +	union {
> > +		cpumask_t match_mask;
> > +		struct device_node *np;
> > +	} match;
> > +};
> > +
> > +static struct cci_ace_port *ports;
> > +static unsigned int nb_cci_ports;
> > +
> > +static void __iomem *cci_ctrl_base;
> > +#define INVALID_PORT_IDX	-1
> > +static int cpu_port[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_PORT_IDX };
> > +
> > +static void __init cci_ace_init_ports(void)
> > +{
> > +	bool is_ace;
> > +	int port, cpu;
> > +	/*
> > +	 * Port index look-up speeds up the function disabling ports by CPU,
> > +	 * since the logical to port index mapping is done once and does
> > +	 * not change after system boot.
> > +	 * The stashed index array is initialized for all possible CPUs
> > +	 * at probe time.
> > +	 */
> > +	for_each_possible_cpu(cpu) {
> > +		for (port = 0; port < nb_cci_ports; port++) {
> > +			is_ace = ports[port].type == ACE_PORT;
> > +			if (is_ace && cpu_isset(cpu,
> > +					 ports[port].match.match_mask)) {
> > +				cpu_port[cpu] = port;
> > +				break;
> > +			}
> > +		}
> > +		WARN(cpu_port[cpu] == INVALID_PORT_IDX, "CPU %d has an invalid"
> > +							" CCI port index\n",
> 
> I think the convention is to not split user visible messages across
> multiple source lines as this makes grepping for them difficult.

Ok, I will address this issue on the entire patch.

> 
> > +							cpu);
> > +	}
> > +}
> > +
> > +/*
> > + * cci_ace_lite_port - Function to retrieve the port index corresponding to
> > + *		       a device tree node
> > + *
> > + * @np = device tree node to match
> > + *
> > + * Return value:
> > + *	- ACE LITE port index if success
> > + *	- -EINVAL if failure
> > + *
> > + */
> > +static int cci_ace_lite_port(struct device_node *np)
> > +{
> > +	int i;
> > +	bool is_ace_lite;
> > +
> > +	for (i = 0; i < nb_cci_ports; i++) {
> > +		is_ace_lite = ports[i].type == ACE_LITE_PORT;
> > +		if (is_ace_lite && np == ports[i].match.np)
> > +			return i;
> > +	}
> > +	return -ENODEV;
> > +}
> > +
> > +/*
> > + * Functions to enable/disable a CCI interconnect slave port
> > + *
> > + * They are called by low-level power management code to disable slave
> > + * interfaces snoops and DVM broadcast.
> > + * Since they may execute with cache data allocation disabled and
> > + * after the caches have been cleaned and invalidated the functions provide
> > + * no explicit locking since they may run with D-cache disabled, so normal
> > + * cacheable kernel locks based on ldrex/strex may not work.
> > + * Locking has to be provided by BSP implementations to ensure proper
> > + * operations.
> > + */
> > +
> > +/*
> > + * cci_port_control()
> > + *	@port = index of the port to setup
> > + *	@enable = if true enables the port, if false disables it
> > + */
> > +static void notrace cci_port_control(unsigned int port, bool enable)
> > +{
> > +	void __iomem *base = ports[port].base;
> > +
> > +	if (!base)
> > +		return;
> > +
> > +	writel_relaxed(enable, base + CCI_PORT_CTRL);
> 
> If enable is bool (0 or 1) then this is going to set snoops as specified
> but is always going to clear DVM broadcast as that is controlled by bit1
> of the register. So, does the API need specifying different to allow the
> caller to choose DVM state as well, or does this function need to assume
> DVM and snoops state should be equal? I.e.
> 
> 	writel_relaxed(enable ? 0x3 : 0x0, base + CCI_PORT_CTRL);

Well spotted. I will have to think about this, but you are spot-on, the
current interface is plain wrong.

[...]

> > +ioremap_err:
> > +	for (j = 0; j < nb_cci_ports; j++) {
> > +		if (j == i)
> > +			break;
> > +		iounmap(ports[j].base);
> > +	}
> 
> That loop would be simpler as:
> 
> 	while (--i >= 0)
> 		iounmap(ports[i].base);
> 
> and declaration of 'j' can dropped from the function start.

Yes, absolutely.

> > +
> > +	iounmap(cci_ctrl_base);
> > +memalloc_err:
> > +
> > +	kfree(ports);
> > +	return ret;
> > +}
> > +
> > +static int __exit cci_driver_remove(struct platform_device *pdev)
> 
> Under what circumstances would we want to remove the driver?

Consider this function gone, so 0 circumstances.

Thanks a lot for the review,
Lorenzo
