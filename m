From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 23 Apr 2013 14:52:08 +0100
Subject: [RFC PATCH] drivers: bus: add ARM CCI support
In-Reply-To: <1365691679-28674-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1365691679-28674-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1365691679-28674-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1366725128.8473.21.camel@computer5.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-04-11 at 15:47 +0100, Lorenzo Pieralisi wrote:
[...]
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> new file mode 100644
> index 0000000..81953de
> --- /dev/null
> +++ b/drivers/bus/arm-cci.c
> @@ -0,0 +1,344 @@
> +/*
> + * CCI cache coherent interconnect driver
> + *
> + * Copyright (C) 2013 ARM Ltd.
> + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/arm-cci.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/dt_affinity.h>
> +#include <asm/outercache.h>
> +#include <asm/smp_plat.h>
> +
> +#define DRIVER_NAME		"CCI"
> +#define CCI_CTRL_STATUS		0xc
> +
> +#define CCI_PORT_CTRL		0x0
> +
> +struct cci_nb_ports {
> +	unsigned int nb_ace;
> +	unsigned int nb_ace_lite;
> +};
> +
> +enum cci_ace_port_type {
> +	ACE_INVALID_PORT = 0x0,
> +	ACE_PORT,
> +	ACE_LITE_PORT,
> +};
> +
> +struct cci_ace_port {
> +	void __iomem *base;
> +	int type;
> +	union {
> +		cpumask_t match_mask;
> +		struct device_node *np;
> +	} match;
> +};
> +
> +static struct cci_ace_port *ports;
> +static unsigned int nb_cci_ports;
> +
> +static void __iomem *cci_ctrl_base;
> +#define INVALID_PORT_IDX	-1
> +static int cpu_port[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_PORT_IDX };
> +
> +static void __init cci_ace_init_ports(void)
> +{
> +	bool is_ace;
> +	int port, cpu;
> +	/*
> +	 * Port index look-up speeds up the function disabling ports by CPU,
> +	 * since the logical to port index mapping is done once and does
> +	 * not change after system boot.
> +	 * The stashed index array is initialized for all possible CPUs
> +	 * at probe time.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		for (port = 0; port < nb_cci_ports; port++) {
> +			is_ace = ports[port].type == ACE_PORT;
> +			if (is_ace && cpu_isset(cpu,
> +					 ports[port].match.match_mask)) {
> +				cpu_port[cpu] = port;
> +				break;
> +			}
> +		}
> +		WARN(cpu_port[cpu] == INVALID_PORT_IDX, "CPU %d has an invalid"
> +							" CCI port index\n",

I think the convention is to not split user visible messages across
multiple source lines as this makes grepping for them difficult.

> +							cpu);
> +	}
> +}
> +
> +/*
> + * cci_ace_lite_port - Function to retrieve the port index corresponding to
> + *		       a device tree node
> + *
> + * @np = device tree node to match
> + *
> + * Return value:
> + *	- ACE LITE port index if success
> + *	- -EINVAL if failure
> + *
> + */
> +static int cci_ace_lite_port(struct device_node *np)
> +{
> +	int i;
> +	bool is_ace_lite;
> +
> +	for (i = 0; i < nb_cci_ports; i++) {
> +		is_ace_lite = ports[i].type == ACE_LITE_PORT;
> +		if (is_ace_lite && np == ports[i].match.np)
> +			return i;
> +	}
> +	return -ENODEV;
> +}
> +
> +/*
> + * Functions to enable/disable a CCI interconnect slave port
> + *
> + * They are called by low-level power management code to disable slave
> + * interfaces snoops and DVM broadcast.
> + * Since they may execute with cache data allocation disabled and
> + * after the caches have been cleaned and invalidated the functions provide
> + * no explicit locking since they may run with D-cache disabled, so normal
> + * cacheable kernel locks based on ldrex/strex may not work.
> + * Locking has to be provided by BSP implementations to ensure proper
> + * operations.
> + */
> +
> +/*
> + * cci_port_control()
> + *	@port = index of the port to setup
> + *	@enable = if true enables the port, if false disables it
> + */
> +static void notrace cci_port_control(unsigned int port, bool enable)
> +{
> +	void __iomem *base = ports[port].base;
> +
> +	if (!base)
> +		return;
> +
> +	writel_relaxed(enable, base + CCI_PORT_CTRL);

If enable is bool (0 or 1) then this is going to set snoops as specified
but is always going to clear DVM broadcast as that is controlled by bit1
of the register. So, does the API need specifying different to allow the
caller to choose DVM state as well, or does this function need to assume
DVM and snoops state should be equal? I.e.

	writel_relaxed(enable ? 0x3 : 0x0, base + CCI_PORT_CTRL);


> +	while (readl_relaxed(cci_ctrl_base + CCI_CTRL_STATUS) & 0x1)
> +			;
> +}
> +
> +/*
> + * cci_disable_port_by_cpu()
> + *	@mpidr = mpidr of the CPU whose CCI port should be disabled
> + *	Returns:
> + *		0 on success
> + *		-ENODEV on port look-up failure
> + *
> + * Disabling a CCI port for a CPU implies disabling the CCI port
> + * controlling that CPU cluster. Code disabling CPU CCI ports
> + * must make sure that the CPU running the code is the last active CPU
> + * in the cluster ie all other CPUs are quiescent in a low power state.
> + */
> +int notrace cci_disable_port_by_cpu(u64 mpidr)
> +{
> +	int cpu = get_logical_index(mpidr & MPIDR_HWID_BITMASK);
> +
> +	if (cpu < 0 || cpu_port[cpu] == INVALID_PORT_IDX)
> +		return -ENODEV;
> +	cci_port_control(cpu_port[cpu], false);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cci_disable_port_by_cpu);
> +
> +/*
> + * __cci_control_port_by_device()
> + *	@np = device_node of the device whose CCI port should be enabled
> + *	@enable = if true enables the port, if false disables it
> + *	Returns:
> + *		0 on success
> + *		-ENODEV on port look-up failure
> + */
> +int notrace __cci_control_port_by_device(struct device_node *np, bool enable)
> +{
> +	int port = cci_ace_lite_port(np);
> +	if (WARN_ONCE(port < 0,
> +		      "ACE lite port look-up failure, node %p\n", np))
> +		return -ENODEV;
> +	cci_port_control(port, enable);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(__cci_control_port_by_device);
> +
> +static const struct of_device_id arm_cci_matches[];
> +
> +static int __init cci_driver_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	struct cci_nb_ports const *cci_config;
> +	int ret, j, i, nb_ace = 0, nb_ace_lite = 0;
> +	struct device_node *np, *cp;
> +	const char *match_str;
> +
> +	match = of_match_device(arm_cci_matches, &pdev->dev);
> +
> +	if (!match)
> +		return -ENODEV;
> +
> +	cci_config = (struct cci_nb_ports const *)match->data;
> +	nb_cci_ports = cci_config->nb_ace + cci_config->nb_ace_lite;
> +	ports = kzalloc(sizeof(*ports) * nb_cci_ports, GFP_KERNEL);
> +	if (!ports)
> +		return -ENOMEM;
> +
> +	np = pdev->dev.of_node;
> +	cci_ctrl_base = of_iomap(np, 0);
> +
> +	if (!cci_ctrl_base) {
> +		dev_err(&pdev->dev, "unable to ioremap CCI ctrl\n");
> +		ret = -ENXIO;
> +		goto memalloc_err;
> +	}
> +	for_each_child_of_node(np, cp) {
> +		i = nb_ace + nb_ace_lite;
> +
> +		if (i >= nb_cci_ports)
> +			break;
> +
> +		if (of_property_read_string(cp, "interface-type",
> +					    &match_str)) {
> +			WARN(1, " * %s missing interface-type property\n",
> +				  cp->full_name);
> +			continue;
> +		}
> +
> +		/*
> +		 * A CCI interface has to define a "master" affinity
> +		 * property otherwise it is not considered valid
> +		 */
> +		if (!strcmp(match_str, "ace")) {
> +			if (WARN_ON(nb_ace >= cci_config->nb_ace))
> +				continue;
> +			cpumask_clear(&ports[i].match.match_mask);
> +			if (arm_dt_affine_get_mask(cp, "master", 0,
> +					&ports[i].match.match_mask))
> +				continue;
> +			ports[i].type = ACE_PORT;
> +			++nb_ace;
> +		} else if (!strcmp(match_str, "ace-lite")) {
> +			if (WARN_ON(nb_ace_lite >= cci_config->nb_ace_lite))
> +				continue;
> +
> +			ports[i].match.np =
> +				of_parse_phandle(cp, "master", 0);
> +
> +			if (!ports[i].match.np)
> +				continue;
> +			of_node_put(ports[i].match.np);
> +			ports[i].type = ACE_LITE_PORT;
> +			++nb_ace_lite;
> +		} else {
> +			WARN(1, " * %s containing invalid interface-type"
> +				" property, skipping it\n", cp->full_name);

Error message being split across multiple lines again.

> +			continue;
> +		}
> +
> +		ports[i].base = of_iomap(cp, 0);
> +
> +		if (!ports[i].base) {
> +			dev_err(&pdev->dev, "unable to ioremap "
> +					    "ace port %d\n", i);

Split error message again.

> +			ret = -ENXIO;
> +			goto ioremap_err;
> +		}
> +	}
> +	cci_ace_init_ports();
> +	/*
> +	 * Multi-cluster systems may need this data when non-coherent, during
> +	 * cluster power-up/power-down. Make sure it reaches main memory:
> +	 */
> +	__cpuc_flush_dcache_area(ports, sizeof(*ports) * nb_cci_ports);
> +	__cpuc_flush_dcache_area(&cci_ctrl_base, sizeof cci_ctrl_base);
> +	__cpuc_flush_dcache_area(cpu_port, sizeof cpu_port);
> +	outer_clean_range(virt_to_phys(ports),
> +			  virt_to_phys(ports + nb_cci_ports));
> +	outer_clean_range(virt_to_phys(&cci_ctrl_base),
> +			  virt_to_phys(&cci_ctrl_base + 1));
> +	outer_clean_range(virt_to_phys(cpu_port),
> +			  virt_to_phys(cpu_port + NR_CPUS));
> +	dev_info(&pdev->dev, "ARM CCI driver probed\n");
> +	return 0;
> +
> +ioremap_err:
> +	for (j = 0; j < nb_cci_ports; j++) {
> +		if (j == i)
> +			break;
> +		iounmap(ports[j].base);
> +	}

That loop would be simpler as:

	while (--i >= 0)
		iounmap(ports[i].base);

and declaration of 'j' can dropped from the function start.


> +
> +	iounmap(cci_ctrl_base);
> +memalloc_err:
> +
> +	kfree(ports);
> +	return ret;
> +}
> +
> +static int __exit cci_driver_remove(struct platform_device *pdev)

Under what circumstances would we want to remove the driver?

> +{
> +	int i;
> +
> +	for (i = 0; i < nb_cci_ports; i++)
> +		if (ports[i].base)
> +			iounmap(ports[i].base);
> +
> +	iounmap(cci_ctrl_base);
> +	kfree(ports);
> +	return 0;
> +}
> +
> +static const struct cci_nb_ports cci400_ports = {
> +	.nb_ace = 2,
> +	.nb_ace_lite = 3
> +};
> +
> +static const struct of_device_id arm_cci_matches[] = {
> +	{.compatible = "arm,cci-400", .data = &cci400_ports },
> +	{},
> +};
> +
> +static struct platform_driver cci_platform_driver = {
> +	.driver = {
> +		   .owner = THIS_MODULE,
> +		   .name = DRIVER_NAME,
> +		   .of_match_table = arm_cci_matches,
> +		   },
> +	.probe = cci_driver_probe,
> +	.remove = cci_driver_remove,
> +};
> +
> +static int __init cci_init(void)
> +{
> +	return platform_driver_register(&cci_platform_driver);
> +}
> +
> +static void __exit cci_exit(void)
> +{
> +	platform_driver_unregister(&cci_platform_driver);
> +}
> +
> +core_initcall(cci_init);
> +module_exit(cci_exit);
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ARM CCI support");
[...]

-- 
Tixy
