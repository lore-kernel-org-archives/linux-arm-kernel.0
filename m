From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 6 May 2013 11:05:28 -0400 (EDT)
Subject: [RFC PATCH v2] drivers: bus: add ARM CCI support
In-Reply-To: <1367425108-4698-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1367425108-4698-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1367425108-4698-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.03.1305011239240.11070@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Review comments below.

On Wed, 1 May 2013, Lorenzo Pieralisi wrote:

> index 0000000..fb9e8e0
> --- /dev/null
> +++ b/drivers/bus/arm-cci.c
> @@ -0,0 +1,372 @@
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

You don't need this include anymore.

> +#include <asm/smp_plat.h>
> +
> +#define DRIVER_NAME		"CCI"
> +
> +#define CCI_PORT_CTRL		0x0
> +#define CCI_CTRL_STATUS		0xc
> +
> +#define CCI_ENABLE_SNOOP_REQ	0x1
> +#define CCI_ENABLE_DVM_REQ	0x2
> +#define CCI_ENABLE_REQ		(CCI_ENABLE_SNOOP_REQ | CCI_ENABLE_DVM_REQ)
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

You could use: enum cci_ace_port_type type;

> +	struct device_node *dn;
> +};
> +
> +static struct cci_ace_port *ports;
> +static unsigned int nb_cci_ports;
> +
> +static void __iomem *cci_ctrl_base;
> +#define INVALID_PORT_IDX	-1
> +static int cpu_port[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_PORT_IDX };
> +
> +/*
> + * __cci_ace_get_port - Function to retrieve the port index connected to
> + *			a cpu or device.
> + *
> + * @dn = device node of the device to look-up
> + * @type = port type
> + *
> + * Return value:
> + *	- CCI port index if success
> + *	- -ENODEV if failure
> + */
> +static int __cci_ace_get_port(struct device_node *dn, int type)
> +{
> +	int i;
> +	bool ace_match;
> +	struct device_node *cci_portn;
> +
> +	cci_portn = of_parse_phandle(dn, "cci-control-port", 0);
> +	for (i = 0; i < nb_cci_ports; i++) {
> +		ace_match = ports[i].type == type;
> +		if (ace_match && cci_portn == ports[i].dn)
> +			return i;
> +	}
> +	return -ENODEV;
> +}
> +
> +int cci_ace_get_port(struct device_node *dn)
> +{
> +	return __cci_ace_get_port(dn, ACE_LITE_PORT);
> +}
> +EXPORT_SYMBOL_GPL(cci_ace_get_port);
> +
> +static void __init cci_ace_init_ports(void)
> +{
> +	int port, ac, cpu;
> +	u64 hwid;
> +	const u32 *cell;
> +	struct device_node *cpun, *cpus;
> +
> +	cpus = of_find_node_by_path("/cpus");
> +	if (WARN(!cpus, "Missing cpus node, bailing out\n"))
> +		return;
> +
> +	if (WARN_ON(of_property_read_u32(cpus, "#address-cells", &ac)))
> +		ac = of_n_addr_cells(cpus);
> +	/*
> +	 * Port index look-up speeds up the function disabling ports by CPU,
> +	 * since the logical to port index mapping is done once and does
> +	 * not change after system boot.
> +	 * The stashed index array is initialized for all possible CPUs
> +	 * at probe time.
> +	 */
> +	for_each_child_of_node(cpus, cpun) {
> +		if (of_node_cmp(cpun->type, "cpu"))
> +			continue;
> +		cell = of_get_property(cpun, "reg", NULL);
> +		if (WARN(!cell, "%s: missing reg property\n", cpun->full_name))
> +			continue;
> +		hwid = of_read_number(cell, ac);
> +		cpu = get_logical_index(hwid & MPIDR_HWID_BITMASK);
> +		if (cpu < 0)
> +			continue;
> +		port = __cci_ace_get_port(cpun, ACE_PORT);
> +		if (port < 0)
> +			continue;
> +		cpu_port[cpu] = port;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		WARN(cpu_port[cpu] == INVALID_PORT_IDX, "CPU %d has an invalid CCI port index\n",
> +							cpu);
> +	}
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
> +	writel_relaxed(enable ? CCI_ENABLE_REQ : 0, base + CCI_PORT_CTRL);
> +	/*
> +	 * This function is called from power down procedures
> +	 * and must not execute any instruction that might
> +	 * cause the processor to be put in a quiescent state
> +	 * (eg wfi). Hence, cpu_relax() can not be added to this
> +	 * read loop to optimize power, since it might hide possibly
> +	 * disruptive operations.
> +	 */
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

This is dangerous.  Same reasoning for not using cpu_relax() above 
should apply here too.  Better avoid any external calls and cache things 
locally by marking cpu_port[] entries with MPIDR values directly.

Furthermore, get_logical_index() might not be reliable when the cache or 
local coherency is off.  We'd have to flush all the data it might access 
to RAM just like it is done for our very own data structures in this 
code, but starting doing that outside of this driver would become rather 
ugly.

> +	if (cpu < 0 || cpu_port[cpu] == INVALID_PORT_IDX)
> +		return -ENODEV;
> +	cci_port_control(cpu_port[cpu], false);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cci_disable_port_by_cpu);
> +
> +/*
> + * __cci_control_port_by_device()
> + *	@dn = device node pointer of the device whose CCI port should be
> + *	      controlled
> + *	@enable = if true enables the port, if false disables it
> + *	Returns:
> + *		0 on success
> + *		-ENODEV on port look-up failure
> + */
> +int notrace __cci_control_port_by_device(struct device_node *dn, bool enable)
> +{
> +	int port;
> +
> +	if (!dn)
> +		return -ENODEV;
> +
> +	port = __cci_ace_get_port(dn, ACE_LITE_PORT);
> +	if (WARN_ONCE(port < 0, "node %s ACE lite port look-up failure\n",
> +				dn->full_name))
> +		return -ENODEV;
> +	cci_port_control(port, enable);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(__cci_control_port_by_device);
> +
> +/*
> + * __cci_control_port_by_index()
> + *	@port = port index previously retrieved with cci_ace_get_port()
> + *	@enable = if true enables the port, if false disables it
> + *	Returns:
> + *		0 on success
> + *		-ENODEV on port index out of range
> + *		-EPERM if operation carried out on an ACE PORT
> + */
> +int notrace __cci_control_port_by_index(u32 port, bool enable)
> +{
> +	if (port >= nb_cci_ports || ports[port].type == ACE_INVALID_PORT)
> +		return -ENODEV;
> +	/*
> +	 * CCI control for ports connected to CPUS is extremely fragile
> +	 * and must be made to go through a specific and controlled
> +	 * interface (ie cci_disable_port_by_cpu(); control by general purpose
> +	 * indexing is therefore disabled for ACE ports.
> +	 */
> +	if (ports[port].type == ACE_PORT)
> +		return -EPERM;
> +
> +	cci_port_control(port, enable);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(__cci_control_port_by_index);
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
> +static int __init cci_driver_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	struct cci_nb_ports const *cci_config;
> +	int ret, i, nb_ace = 0, nb_ace_lite = 0;
> +	struct device_node *np, *cp;
> +	const char *match_str;
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	match = of_match_device(arm_cci_matches, &pdev->dev);
> +
> +	if (!match)
> +		return -ENODEV;
> +
> +	cci_config = (struct cci_nb_ports const *)match->data;
> +	nb_cci_ports = cci_config->nb_ace + cci_config->nb_ace_lite;
> +	ports = kcalloc(sizeof(*ports), nb_cci_ports, GFP_KERNEL);
> +	if (!ports)
> +		return -ENOMEM;
> +
> +	np = pdev->dev.of_node;
> +
> +	cci_ctrl_base = devm_request_and_ioremap(&pdev->dev, res);
> +
> +	if (!cci_ctrl_base) {
> +		dev_err(&pdev->dev, "unable to ioremap CCI ctrl\n");
> +		ret = -ENXIO;
> +		goto memalloc_err;
> +	}
> +
> +	for_each_child_of_node(np, cp) {
> +		i = nb_ace + nb_ace_lite;
> +
> +		if (i >= nb_cci_ports)
> +			break;
> +
> +		if (of_property_read_string(cp, "interface-type",
> +					    &match_str)) {
> +			dev_err(&pdev->dev, "node %s missing interface-type property\n",
> +				  cp->full_name);
> +			continue;
> +		}
> +
> +		if (strcmp(match_str, "ace")
> +				&& strcmp(match_str, "ace-lite")) {
> +			dev_err(&pdev->dev, "node %s containing invalid interface-type property, skipping it\n",
> +					cp->full_name);
> +			continue;
> +		}
> +
> +		if (of_address_to_resource(cp, 0, res)) {
> +			dev_err(&pdev->dev, "node %s failure in retrieving resources\n",
> +				cp->full_name);
> +			continue;
> +		}
> +
> +		ports[i].base = devm_request_and_ioremap(&pdev->dev, res);
> +
> +		if (!ports[i].base) {
> +			dev_err(&pdev->dev, "unable to ioremap CCI port %d\n",
> +					    i);
> +			continue;
> +		}
> +
> +		if (!strcmp(match_str, "ace")) {
> +			if (WARN_ON(nb_ace >= cci_config->nb_ace))
> +				continue;
> +			ports[i].type = ACE_PORT;
> +			++nb_ace;
> +		} else if (!strcmp(match_str, "ace-lite")) {
> +			if (WARN_ON(nb_ace_lite >= cci_config->nb_ace_lite))
> +				continue;
> +			ports[i].type = ACE_LITE_PORT;
> +			++nb_ace_lite;
> +		}
> +		ports[i].dn = cp;
> +	}
> +	 /* initialize a stashed array of ACE ports to speed-up look-up */
> +	cci_ace_init_ports();
> +
> +	/*
> +	 * Multi-cluster systems may need this data when non-coherent, during
> +	 * cluster power-up/power-down. Make sure it reaches main memory.
> +	 */
> +	sync_cache_w(&cci_ctrl_base);
> +	__sync_cache_range_w(ports, sizeof(*ports) * nb_cci_ports);

This is not enough to flush the cache for the memory referenced by the 
ports pointer.  The pointer value itself has to be flushed to RAM as 
well.

> +	__sync_cache_range_w(cpu_port, sizeof cpu_port);

You might be able to use sync_cache_w(&cpu_port) here instead given it 
is a fixed size array object.

> +	dev_info(&pdev->dev, "ARM CCI driver probed\n");
> +	return 0;
> +
> +memalloc_err:
> +
> +	kfree(ports);
> +	return ret;
> +}
> +
> +static struct platform_driver cci_platform_driver = {
> +	.driver = {
> +		   .owner = THIS_MODULE,
> +		   .name = DRIVER_NAME,
> +		   .of_match_table = arm_cci_matches,
> +	},
> +};
> +/*
> + * CCI is inherently a non-hotpluggable device, since it represents
> + * the CPUs access point to the interconnect system.
> + */
> +static int __init cci_init(void)
> +{
> +	return platform_driver_probe(&cci_platform_driver, cci_driver_probe);
> +}
> +
> +module_init(cci_init);

When compiled in, module_init() is translated into device_initcall().  
This is way too late for bringing up secondary CPUs during boot via the 
MCPM layer.  That is not an issue as far as the code presented here is 
concerned since there is no integration with MCPM yet, but eventually 
we'd want the MCPM power_up_setup method to integrate with the port 
discovery performed here instead of having them hardcoded in the 
assembly code.  This means it would have to become early_initcall() 
instead.  And at that point the driver infrastructure isn't fully 
operational, meaning that driver_probe() won't be usable either (looking 
at what we did to the TC2 spc init code is a good example of what I mean 
here).


Nicolas
