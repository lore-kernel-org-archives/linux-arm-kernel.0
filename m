From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 7 May 2013 14:49:44 +0100
Subject: [RFC PATCH v2] drivers: bus: add ARM CCI support
In-Reply-To: <alpine.LFD.2.03.1305011239240.11070@syhkavp.arg>
References: <1367425108-4698-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1367425108-4698-2-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.03.1305011239240.11070@syhkavp.arg>
Message-ID: <20130507134943.GB19477@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 06, 2013 at 04:05:28PM +0100, Nicolas Pitre wrote:
> Review comments below.

Thanks Nico.

> On Wed, 1 May 2013, Lorenzo Pieralisi wrote:
> 
> > index 0000000..fb9e8e0
> > --- /dev/null
> > +++ b/drivers/bus/arm-cci.c
> > @@ -0,0 +1,372 @@
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
> 
> You don't need this include anymore.

True.

> > +#include <asm/smp_plat.h>
> > +
> > +#define DRIVER_NAME          "CCI"
> > +
> > +#define CCI_PORT_CTRL                0x0
> > +#define CCI_CTRL_STATUS              0xc
> > +
> > +#define CCI_ENABLE_SNOOP_REQ 0x1
> > +#define CCI_ENABLE_DVM_REQ   0x2
> > +#define CCI_ENABLE_REQ               (CCI_ENABLE_SNOOP_REQ | CCI_ENABLE_DVM_REQ)
> > +
> > +struct cci_nb_ports {
> > +     unsigned int nb_ace;
> > +     unsigned int nb_ace_lite;
> > +};
> > +
> > +enum cci_ace_port_type {
> > +     ACE_INVALID_PORT = 0x0,
> > +     ACE_PORT,
> > +     ACE_LITE_PORT,
> > +};
> > +
> > +struct cci_ace_port {
> > +     void __iomem *base;
> > +     int type;
> 
> You could use: enum cci_ace_port_type type;

Ok.

[...]

> > + * Disabling a CCI port for a CPU implies disabling the CCI port
> > + * controlling that CPU cluster. Code disabling CPU CCI ports
> > + * must make sure that the CPU running the code is the last active CPU
> > + * in the cluster ie all other CPUs are quiescent in a low power state.
> > + */
> > +int notrace cci_disable_port_by_cpu(u64 mpidr)
> > +{
> > +     int cpu = get_logical_index(mpidr & MPIDR_HWID_BITMASK);
> 
> This is dangerous.  Same reasoning for not using cpu_relax() above
> should apply here too.  Better avoid any external calls and cache things
> locally by marking cpu_port[] entries with MPIDR values directly.

Ok, I will stash them at boot.

> Furthermore, get_logical_index() might not be reliable when the cache or
> local coherency is off.  We'd have to flush all the data it might access
> to RAM just like it is done for our very own data structures in this
> code, but starting doing that outside of this driver would become rather
> ugly.

That's correct.

> > +     if (cpu < 0 || cpu_port[cpu] == INVALID_PORT_IDX)
> > +             return -ENODEV;
> > +     cci_port_control(cpu_port[cpu], false);
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(cci_disable_port_by_cpu);
> > +
> > +/*
> > + * __cci_control_port_by_device()
> > + *   @dn = device node pointer of the device whose CCI port should be
> > + *         controlled
> > + *   @enable = if true enables the port, if false disables it
> > + *   Returns:
> > + *           0 on success
> > + *           -ENODEV on port look-up failure
> > + */
> > +int notrace __cci_control_port_by_device(struct device_node *dn, bool enable)
> > +{
> > +     int port;
> > +
> > +     if (!dn)
> > +             return -ENODEV;
> > +
> > +     port = __cci_ace_get_port(dn, ACE_LITE_PORT);
> > +     if (WARN_ONCE(port < 0, "node %s ACE lite port look-up failure\n",
> > +                             dn->full_name))
> > +             return -ENODEV;
> > +     cci_port_control(port, enable);
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(__cci_control_port_by_device);
> > +
> > +/*
> > + * __cci_control_port_by_index()
> > + *   @port = port index previously retrieved with cci_ace_get_port()
> > + *   @enable = if true enables the port, if false disables it
> > + *   Returns:
> > + *           0 on success
> > + *           -ENODEV on port index out of range
> > + *           -EPERM if operation carried out on an ACE PORT
> > + */
> > +int notrace __cci_control_port_by_index(u32 port, bool enable)
> > +{
> > +     if (port >= nb_cci_ports || ports[port].type == ACE_INVALID_PORT)
> > +             return -ENODEV;
> > +     /*
> > +      * CCI control for ports connected to CPUS is extremely fragile
> > +      * and must be made to go through a specific and controlled
> > +      * interface (ie cci_disable_port_by_cpu(); control by general purpose
> > +      * indexing is therefore disabled for ACE ports.
> > +      */
> > +     if (ports[port].type == ACE_PORT)
> > +             return -EPERM;
> > +
> > +     cci_port_control(port, enable);
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(__cci_control_port_by_index);
> > +
> > +static const struct cci_nb_ports cci400_ports = {
> > +     .nb_ace = 2,
> > +     .nb_ace_lite = 3
> > +};
> > +
> > +static const struct of_device_id arm_cci_matches[] = {
> > +     {.compatible = "arm,cci-400", .data = &cci400_ports },
> > +     {},
> > +};
> > +
> > +static int __init cci_driver_probe(struct platform_device *pdev)
> > +{
> > +     const struct of_device_id *match;
> > +     struct cci_nb_ports const *cci_config;
> > +     int ret, i, nb_ace = 0, nb_ace_lite = 0;
> > +     struct device_node *np, *cp;
> > +     const char *match_str;
> > +     struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +
> > +     match = of_match_device(arm_cci_matches, &pdev->dev);
> > +
> > +     if (!match)
> > +             return -ENODEV;
> > +
> > +     cci_config = (struct cci_nb_ports const *)match->data;
> > +     nb_cci_ports = cci_config->nb_ace + cci_config->nb_ace_lite;
> > +     ports = kcalloc(sizeof(*ports), nb_cci_ports, GFP_KERNEL);
> > +     if (!ports)
> > +             return -ENOMEM;
> > +
> > +     np = pdev->dev.of_node;
> > +
> > +     cci_ctrl_base = devm_request_and_ioremap(&pdev->dev, res);
> > +
> > +     if (!cci_ctrl_base) {
> > +             dev_err(&pdev->dev, "unable to ioremap CCI ctrl\n");
> > +             ret = -ENXIO;
> > +             goto memalloc_err;
> > +     }
> > +
> > +     for_each_child_of_node(np, cp) {
> > +             i = nb_ace + nb_ace_lite;
> > +
> > +             if (i >= nb_cci_ports)
> > +                     break;
> > +
> > +             if (of_property_read_string(cp, "interface-type",
> > +                                         &match_str)) {
> > +                     dev_err(&pdev->dev, "node %s missing interface-type property\n",
> > +                               cp->full_name);
> > +                     continue;
> > +             }
> > +
> > +             if (strcmp(match_str, "ace")
> > +                             && strcmp(match_str, "ace-lite")) {
> > +                     dev_err(&pdev->dev, "node %s containing invalid interface-type property, skipping it\n",
> > +                                     cp->full_name);
> > +                     continue;
> > +             }
> > +
> > +             if (of_address_to_resource(cp, 0, res)) {
> > +                     dev_err(&pdev->dev, "node %s failure in retrieving resources\n",
> > +                             cp->full_name);
> > +                     continue;
> > +             }
> > +
> > +             ports[i].base = devm_request_and_ioremap(&pdev->dev, res);
> > +
> > +             if (!ports[i].base) {
> > +                     dev_err(&pdev->dev, "unable to ioremap CCI port %d\n",
> > +                                         i);
> > +                     continue;
> > +             }
> > +
> > +             if (!strcmp(match_str, "ace")) {
> > +                     if (WARN_ON(nb_ace >= cci_config->nb_ace))
> > +                             continue;
> > +                     ports[i].type = ACE_PORT;
> > +                     ++nb_ace;
> > +             } else if (!strcmp(match_str, "ace-lite")) {
> > +                     if (WARN_ON(nb_ace_lite >= cci_config->nb_ace_lite))
> > +                             continue;
> > +                     ports[i].type = ACE_LITE_PORT;
> > +                     ++nb_ace_lite;
> > +             }
> > +             ports[i].dn = cp;
> > +     }
> > +      /* initialize a stashed array of ACE ports to speed-up look-up */
> > +     cci_ace_init_ports();
> > +
> > +     /*
> > +      * Multi-cluster systems may need this data when non-coherent, during
> > +      * cluster power-up/power-down. Make sure it reaches main memory.
> > +      */
> > +     sync_cache_w(&cci_ctrl_base);
> > +     __sync_cache_range_w(ports, sizeof(*ports) * nb_cci_ports);
> 
> This is not enough to flush the cache for the memory referenced by the
> ports pointer.  The pointer value itself has to be flushed to RAM as
> well.

Gah, you are right.

> > +     __sync_cache_range_w(cpu_port, sizeof cpu_port);
> 
> You might be able to use sync_cache_w(&cpu_port) here instead given it
> is a fixed size array object.

Yes.

> > +     dev_info(&pdev->dev, "ARM CCI driver probed\n");
> > +     return 0;
> > +
> > +memalloc_err:
> > +
> > +     kfree(ports);
> > +     return ret;
> > +}
> > +
> > +static struct platform_driver cci_platform_driver = {
> > +     .driver = {
> > +                .owner = THIS_MODULE,
> > +                .name = DRIVER_NAME,
> > +                .of_match_table = arm_cci_matches,
> > +     },
> > +};
> > +/*
> > + * CCI is inherently a non-hotpluggable device, since it represents
> > + * the CPUs access point to the interconnect system.
> > + */
> > +static int __init cci_init(void)
> > +{
> > +     return platform_driver_probe(&cci_platform_driver, cci_driver_probe);
> > +}
> > +
> > +module_init(cci_init);
> 
> When compiled in, module_init() is translated into device_initcall().
> This is way too late for bringing up secondary CPUs during boot via the
> MCPM layer.  That is not an issue as far as the code presented here is
> concerned since there is no integration with MCPM yet, but eventually
> we'd want the MCPM power_up_setup method to integrate with the port
> discovery performed here instead of having them hardcoded in the
> assembly code.  This means it would have to become early_initcall()
> instead.  And at that point the driver infrastructure isn't fully
> operational, meaning that driver_probe() won't be usable either (looking
> at what we did to the TC2 spc init code is a good example of what I mean
> here).

Yes, I thought about that. This means that CCI driver should not rely on
platform device structs, and yes I can mirror SPC probing code to take care
of ordering issues. I am quite tempted to remove the platform device/driver
infrastructure altogether and just rely on the DT layer (as GIC, PL310
do) to initialize CCI. What do you think ? I think I will leave the
platform driver infrastructure, and at probe it will check if data
structures have already been initialized by an exported function, say:

cci_of_init()

if the data structures are already initialized basically the probe
function will do precious little and just succeeds otherwise it will
initialize the driver as it does now.

Is there really a point in having the CCI driver represented as a
platform driver ? Not sure at all.

Thanks,
Lorenzo
