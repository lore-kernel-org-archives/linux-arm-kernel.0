From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 12 Aug 2013 10:34:43 +0200
Subject: [PATCH v5 2/3] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <CAL_JsqJLv-dUb=64vP+OeP8=Usw7=r6RKqJAXCSPryCFGZ89_w@mail.gmail.com>
References: <1376049119-12655-1-git-send-email-m.szyprowski@samsung.com>
 <1376049119-12655-3-git-send-email-m.szyprowski@samsung.com>
 <CAL_JsqJLv-dUb=64vP+OeP8=Usw7=r6RKqJAXCSPryCFGZ89_w@mail.gmail.com>
Message-ID: <52089E23.1090406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 8/10/2013 7:33 PM, Rob Herring wrote:
> On Fri, Aug 9, 2013 at 6:51 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > Add device tree support for contiguous and reserved memory regions
> > defined in device tree. Initialization is done in 2 steps. First, the
> > memory is reserved, what happens very early when only flattened device
>
> s/what/which/
>
> > tree is available. Then on device initialization the corresponding cma
> > and reserved regions are assigned to each device structure.
>
> What this commit message does not tell me is why does the reservation
> have to happen before the fdt is unflattened? It would greatly
> simplify the code if it didn't.

Large memory blocks can be RELIABLY reserved only during early boot. This
must happen before the whole memory management subsystem is initialized,
because we need to ensure that the given contiguous blocks are not yet
allocated by kernel. Also it must happen before kernel mappings for the
whole low memory are created, to ensure that there will be no mappings
(for reserved blocks) or mapping with special properties can be created
(for CMA blocks). This all happens before device tree structures are
unflattened, so we need to get reserved memory layout directly from fdt.


> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Acked-by: Michal Nazarewicz <mina86@mina86.com>
> > ---
> >  Documentation/devicetree/bindings/memory.txt |  152 ++++++++++++++++++++
> >  drivers/of/Kconfig                           |    6 +
> >  drivers/of/Makefile                          |    1 +
> >  drivers/of/of_reserved_mem.c                 |  197 ++++++++++++++++++++++++++
> >  drivers/of/platform.c                        |    5 +
> >  include/linux/of_reserved_mem.h              |   14 ++
> >  6 files changed, 375 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/memory.txt
> >  create mode 100644 drivers/of/of_reserved_mem.c
> >  create mode 100644 include/linux/of_reserved_mem.h
> >
> > diff --git a/Documentation/devicetree/bindings/memory.txt b/Documentation/devicetree/bindings/memory.txt
> > new file mode 100644
> > index 0000000..167d013
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/memory.txt
> > @@ -0,0 +1,152 @@
> > +*** Memory binding ***
> > +
> > +The /memory node provides basic information about the address and size
> > +of the physical memory. This node is usually filled or updated by the
> > +bootloader, depending on the actual memory configuration of the given
> > +hardware.
> > +
> > +The memory layout is described by the folllowing node:
>
> typo.
>
> > +
> > +memory {
> > +       device_type = "memory";
> > +       reg =  <(baseaddr1) (size1)
> > +               (baseaddr2) (size2)
> > +               ...
> > +               (baseaddrN) (sizeN)>;
> > +};
> > +
> > +baseaddrX:     the base address of the defined memory bank
> > +sizeX:         the size of the defined memory bank
> > +
> > +More than one memory bank can be defined.
> > +
> > +
> > +*** Reserved memory regions ***
> > +
> > +In /memory/reserved-memory node one can create additional nodes
> > +describing particular reserved (excluded from normal use) memory
> > +regions. Such memory regions are usually designed for the special usage
> > +by various device drivers. A good example are contiguous memory
> > +allocations or memory sharing with other operating system on the same
> > +hardware board. Those special memory regions might depend on the board
> > +configuration and devices used on the target system.
> > +
> > +Parameters for each memory region can be encoded into the device tree
> > +wit the following convention:
> > +
> > +[(label):] (name)@(address) {
> > +       compatible = "contiguous-memory-region", "reserved-memory-region";
> > +       reg = <(address) (size)>;
> > +       (linux,default-contiguous-region);
> > +};
> > +
> > +label:         label given to the defined region (optional)
> > +name:          an name given to the defined region
> > +address:       the base address of the defined region
> > +size:          the size of the memory region
> > +
> > +compatible:    "contiguous-memory-region" - enables binding of this
> > +               region to Contiguous Memory Allocator (special region for
> > +               contiguous memory allocations, shared with movable system
> > +               memory, Linux kernel-specific), alternatively if
> > +               "reserved-memory-region" - compatibility is defined, given
> > +               region is assigned for exclusive usage for DMA transfers
> > +
> > +linux,default-contiguous-region: property indicating that the region
> > +               is the default region for all contiguous memory
> > +               allocations, Linux specific (optional)
> > +
> > +Each defined region must use unique name. It is optional to specify the
> > +base address, so if one wants to use autoconfiguration of the base
> > +address, he must specify the '0' as base address in the 'reg' property
> > +and assign ann unique name to such regions.
> > +
> > +
> > +*** Device node's properties ***
> > +
> > +Once the regions in the /memory/reserved-memory node are defined, they
> > +can be assigned to device nodes to enable drivers for their special use.
> > +The following properties are defined:
> > +
> > +memory-region = <&phandle_to_defined_region>;
> > +
> > +This property indicates that the device driver should use the
> > +memory region pointed by the given phandle.
> > +
> > +
> > +*** Example ***
> > +
> > +This example defines a memory consisting of 4 memory banks. 3 contiguous
> > +regions are defined for Linux kernel, one default of all device drivers
> > +(named contig_mem, placed at 0x72000000, 64MiB), one dedicated to the
> > +framebuffer device (labelled display_mem, placed at 0x78000000, 8MiB)
> > +and one for multimedia processing (labelled multimedia_mem, placed at
> > +0x77000000, 64MiB). 'display_mem' region is then assigned to fb at 12300000
> > +device for DMA memory allocations (Linux kernel drivers will use CMA is
> > +available or dma-exclusive usage otherwise). 'multimedia_mem' is
> > +assigned to scaler at 12500000 and codec at 12600000 devices for contiguous
> > +memory allocations when CMA driver is enabled.
> > +
> > +The reason for creating a separate region for framebuffer device is to
> > +match the framebuffer base address to the one configured by bootloader,
> > +so once Linux kernel drivers starts no glitches on the displayed boot
> > +logo appears. Scaller and codec drivers should share the memory
> > +allocations.
> > +
> > +/ {
> > +       /* ... */
> > +       memory {
> > +               reg =  <0x40000000 0x10000000
> > +                       0x50000000 0x10000000
> > +                       0x60000000 0x10000000
> > +                       0x70000000 0x10000000>;
> > +
> > +               reserved-memory {
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +
> > +                       /*
> > +                        * global autoconfigured region for contiguous allocations
> > +                        * (used only with Contiguous Memory Allocator)
> > +                        */
> > +                       contig_region at 0 {
> > +                               compatible = "contiguous-memory-region";
> > +                               reg = <0x0 0x4000000>;
> > +                               linux,default-contiguous-region;
> > +                       };
> > +
> > +                       /*
> > +                        * special region for framebuffer
> > +                        */
> > +                       display_mem: region at 78000000 {
> > +                               compatible = "contiguous-memory-region", "reserved-memory-region";
> > +                               reg = <0x78000000 0x800000>;
> > +                       };
> > +
> > +                       /*
> > +                        * special region for multimedia processing devices
> > +                        */
> > +                       multimedia_mem: region at 77000000 {
> > +                               compatible = "contiguous-memory-region";
> > +                               reg = <0x77000000 0x4000000>;
> > +                       };
> > +               };
> > +       };
> > +
> > +       /* ... */
> > +
> > +       fb0: fb at 12300000 {
> > +               status = "okay";
> > +               memory-region = <&display_mem>;
> > +       };
> > +
> > +       scaler: scaler at 12500000 {
> > +               status = "okay";
> > +               memory-region = <&multimedia_mem>;
> > +       };
> > +
> > +       codec: codec at 12600000 {
> > +               status = "okay";
> > +               memory-region = <&multimedia_mem>;
> > +       };
> > +};
> > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > index 80e5c13..a83ab43 100644
> > --- a/drivers/of/Kconfig
> > +++ b/drivers/of/Kconfig
> > @@ -80,4 +80,10 @@ config OF_MTD
> >         depends on MTD
> >         def_bool y
> >
> > +config OF_RESERVED_MEM
> > +       depends on CMA || (HAVE_GENERIC_DMA_COHERENT && HAVE_MEMBLOCK)
> > +       def_bool y
> > +       help
> > +         Initialization code for DMA reserved memory
> > +
> >  endmenu # OF
> > diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> > index 1f9c0c4..e7e3322 100644
> > --- a/drivers/of/Makefile
> > +++ b/drivers/of/Makefile
> > @@ -10,3 +10,4 @@ obj-$(CONFIG_OF_MDIO) += of_mdio.o
> >  obj-$(CONFIG_OF_PCI)   += of_pci.o
> >  obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
> >  obj-$(CONFIG_OF_MTD)   += of_mtd.o
> > +obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
> > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> > new file mode 100644
> > index 0000000..b256b41
> > --- /dev/null
> > +++ b/drivers/of/of_reserved_mem.c
> > @@ -0,0 +1,197 @@
> > +/*
> > + * Device tree based initialization code for reserved memory.
> > + *
> > + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> > + *             http://www.samsung.com
> > + * Author: Marek Szyprowski <m.szyprowski@samsung.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of the
> > + * License or (at your optional) any later version of the license.
> > + */
> > +
> > +#include <asm/dma-contiguous.h>
> > +
> > +#include <linux/memblock.h>
> > +#include <linux/err.h>
> > +#include <linux/of.h>
> > +#include <linux/of_fdt.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/mm.h>
> > +#include <linux/sizes.h>
> > +#include <linux/mm_types.h>
> > +#include <linux/dma-contiguous.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/of_reserved_mem.h>
> > +
> > +#define MAX_RESERVED_REGIONS   16
> > +struct reserved_mem {
> > +       phys_addr_t             base;
> > +       unsigned long           size;
> > +       struct cma              *cma;
> > +       char                    name[32];
> > +};
> > +static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
> > +static int reserved_mem_count;
> > +
> > +static int __init reserved_mem_fdt_scan(unsigned long node, const char *uname,
> > +                                   int depth, void *data)
>
> early_init_dt_scan_reserved_mem would be a more consistent name.
>
> > +{
> > +       static int size_cells = OF_ROOT_NODE_SIZE_CELLS_DEFAULT;
> > +       static int addr_cells = OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
> > +       static int my_depth;
> > +       phys_addr_t base, size;
> > +       int is_cma, is_reserved;
> > +       unsigned long len;
> > +       __be32 *prop;
> > +
> > +       if (depth == 1 && my_depth == 0 && strcmp(uname, "memory") == 0) {
> > +               my_depth = depth;
> > +               /* scan next node */
> > +               return 0;
> > +       } else if (depth == 2 && my_depth == 1 &&
> > +           strcmp(uname, "reserved-memory") == 0) {
> > +               prop = of_get_flat_dt_prop(node, "#size-cells", NULL);
> > +               if (prop)
> > +                       size_cells = be32_to_cpup(prop);
> > +
> > +               prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
> > +               if (prop)
> > +                       addr_cells = be32_to_cpup(prop);
>
> I think we should just require these be the same size as the memory
> node which would be dt_root_*_cells.
>
> I'm fine with moving this into drivers/of/fdt.c if that simplifies things.

dt_root_*_cells are global variables, so its not a problem to get access to
them. However I wonder how can we ensure that user/device tree creator will
set #size-cells/#address-cells to the same values as for root memory node?
Would it be enough to state that in binding documentation? If so then the
reserved memory code can skip parsing them and use dt_root_*_cells directly,
what will simplify the code.

> > +
> > +               my_depth = depth;
> > +               /* scan next node */
> > +               return 0;
> > +       } else if (depth != 3 && my_depth != 2) {
> > +               /* scan next node */
> > +               return 0;
> > +       } else if (depth < my_depth) {
> > +               /* break scan now */
> > +               return 1;
> > +       }
>
> This code bothers me and is hard to follow. I don't think trying to
> use of_scan_flat_dt is the right approach here. What you really want
> here is check for reserved-memory node under the memory node and then
> scan each child node. This could all be done from
> early_init_dt_scan_memory.

early_init_dt_scan_memory() is also called from of_scan_flat_dt() and
it also implements similar state machine to parse fdt. The only
difference is the fact that "memory" is a direct child of root node,
so the state machine is much simpler (there is no need to parse
/memory/reserved-memory path).


>   u-boot has more rich flat DT functions than
> the kernel does since the kernel does very little with the flat DT.
> Look at fdt_next_node and it's callers in u-boot for some examples.
> But still my first question remains. Can we avoid the flat DT
> altogether?

I see no such possibility. FDT is unflattened too late to do reliably
all operation required for memory reservation.

> > +       /* now we are scanning a /memory/reserved-memory child */
> > +
> > +       is_cma = of_flat_dt_is_compatible(node, "linux,contiguous-memory-region");
> > +       is_reserved = of_flat_dt_is_compatible(node, "reserved-memory-region");
> > +
> > +       if (!is_reserved && !(is_cma && IS_ENABLED(CONFIG_CMA))) {
> > +               /* ignore node and scan next one */
> > +               return 0;
> > +       }
> > +
> > +       prop = of_get_flat_dt_prop(node, "reg", &len);
> > +       if (!prop || (len != (size_cells + addr_cells) * sizeof(__be32))) {
> > +               pr_err("Reserved mem: node %s, incorrect \"reg\" property\n",
> > +                      uname);
> > +               /* ignore node and scan next one */
> > +               return 0;
> > +       }
> > +       base = dt_mem_next_cell(addr_cells, &prop);
> > +       size = dt_mem_next_cell(size_cells, &prop);
> > +
> > +       if (!size) {
> > +               /* ignore node and scan next one */
> > +               return 0;
> > +       }
> > +
> > +       pr_info("Reserved mem: found %s, memory base %lx, size %ld MiB\n",
> > +               uname, (unsigned long)base, (unsigned long)size / SZ_1M);
> > +
> > +       if (reserved_mem_count == ARRAY_SIZE(reserved_mem))
> > +               return -ENOSPC;
> > +
> > +       reserved_mem[reserved_mem_count].base = base;
> > +       reserved_mem[reserved_mem_count].size = size;
> > +       strlcpy(reserved_mem[reserved_mem_count].name, uname,
> > +               sizeof(reserved_mem[reserved_mem_count].name));
> > +
> > +       if (IS_ENABLED(CONFIG_CMA) && is_cma) {
> > +               struct cma *cma;
> > +               if (dma_contiguous_reserve_area(size, base, 0, &cma) == 0) {
> > +                       reserved_mem[reserved_mem_count].cma = cma;
> > +                       reserved_mem_count++;
> > +
> > +                       if (of_get_flat_dt_prop(node,
> > +                                               "linux,default-contiguous-region",
> > +                                               NULL))
> > +                               dma_contiguous_default_area = cma;
> > +               }
> > +       } else if (is_reserved) {
> > +               if (memblock_remove(base, size) == 0)
> > +                       reserved_mem_count++;
> > +               else
> > +                       pr_err("Failed to reserve memory for %s\n", uname);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static struct reserved_mem *get_dma_memory_region(struct device *dev)
> > +{
> > +       struct device_node *node;
> > +       const char *name;
> > +       int i;
> > +
> > +       node = of_parse_phandle(dev->of_node, "memory-region", 0);
> > +       if (!node)
> > +               return NULL;
> > +
> > +       name = kbasename(node->full_name);
> > +       for (i = 0; i < reserved_mem_count; i++)
> > +               if (strcmp(name, reserved_mem[i].name) == 0)
> > +                       return &reserved_mem[i];
> > +       return NULL;
>
> Matching against a struct device_node pointer would be more common way
> to match. So it would be good to update reserved_mem with a
> device_node ptr when we unflatten the DT.

I wonder if it really makes sense. To get device_node ptr I will need to
scan /memody/reserved-memory node and match all its children BY NAME
with the structures parsed from FDT (stored in reserved_mem array). Then
I will need to iterate again for each device node with memory-region
property to find the needed entry. Names are unique, IMHO they can serve
as a key for matching structures between FDT and regular, unflattened DT.

> > +}
> > +
> > +/**
> > + * of_reserved_mem_device_init() - assign reserved memory region to given device
> > + *
> > + * This function assign memory region pointed by "dma-memory-region" device tree
> > + * property to the given device.
> > + */
> > +void of_reserved_mem_device_init(struct device *dev)
> > +{
> > +       struct reserved_mem *region = get_dma_memory_region(dev);
> > +       if (!region)
> > +               return;
> > +
> > +       if (region->cma) {
> > +               dev_set_cma_area(dev, region->cma);
> > +               pr_info("Assigned CMA %s to %s device\n", region->name,
> > +                       dev_name(dev));
> > +       } else {
> > +               if (dma_declare_coherent_memory(dev, region->base, region->base,
> > +                   region->size, DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE) != 0)
> > +                       pr_info("Declared reserved memory %s to %s device\n",
> > +                               region->name, dev_name(dev));
> > +       }
> > +}
> > +
> > +/**
> > + * of_reserved_mem_device_release() - release reserved memory device structures
> > + *
> > + * This function releases structures allocated for memory region handling for
> > + * the given device.
> > + */
> > +void of_reserved_mem_device_release(struct device *dev)
> > +{
> > +       struct reserved_mem *region = get_dma_memory_region(dev);
> > +       if (!region && !region->cma)
> > +               dma_release_declared_memory(dev);
> > +}
> > +
> > +/**
> > + * dma_reserved_mem_reserve() - grab memory reserved for device exclusive use
> > + *
> > + * This function grabs memory from early allocator for device exclusive use
> > + * defined in device tree structures. It should be called by arch specific code
> > + * once the early allocator (memblock) has been activated and all other
> > + * subsystems have already allocated/reserved memory.
> > + */
> > +void __init dma_reserved_mem_of_reserve(void)
> > +{
> > +       if (initial_boot_params)
> > +               of_scan_flat_dt(reserved_mem_fdt_scan, NULL);
> > +}
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index e0a6514..1e4e91d 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> > +#include <linux/of_reserved_mem.h>
> >  #include <linux/platform_device.h>
> >
> >  const struct of_device_id of_default_bus_match_table[] = {
> > @@ -196,6 +197,7 @@ EXPORT_SYMBOL(of_device_alloc);
> >   * Returns pointer to created platform device, or NULL if a device was not
> >   * registered.  Unavailable devices will not get registered.
> >   */
> > +
>
> stray ws change. Please remove.
>
> >  struct platform_device *of_platform_device_create_pdata(
> >                                         struct device_node *np,
> >                                         const char *bus_id,
> > @@ -218,6 +220,8 @@ struct platform_device *of_platform_device_create_pdata(
> >         dev->dev.bus = &platform_bus_type;
> >         dev->dev.platform_data = platform_data;
> >
> > +       of_reserved_mem_device_init(&dev->dev);
> > +
> >         /* We do not fill the DMA ops for platform devices by default.
> >          * This is currently the responsibility of the platform code
> >          * to do such, possibly using a device notifier
> > @@ -225,6 +229,7 @@ struct platform_device *of_platform_device_create_pdata(
> >
> >         if (of_device_add(dev) != 0) {
> >                 platform_device_put(dev);
> > +               of_reserved_mem_device_release(&dev->dev);
> >                 return NULL;
> >         }
> >
> > diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
> > new file mode 100644
> > index 0000000..1274946
> > --- /dev/null
> > +++ b/include/linux/of_reserved_mem.h
> > @@ -0,0 +1,14 @@
> > +#ifndef __OF_RESERVED_MEM_H
> > +#define __OF_RESERVED_MEM_H
> > +
> > +#ifdef CONFIG_OF_RESERVED_MEM
> > +void of_reserved_mem_device_init(struct device *dev);
> > +void of_reserved_mem_device_release(struct device *dev);
> > +void __init dma_reserved_mem_of_reserve(void);
>
> Declarations don't need __init annotation.
>
> > +#else
> > +#define of_reserved_mem_device_init(dev) (void)0
> > +#define of_reserved_mem_device_release(dev) (void)0
> > +#define dma_reserved_mem_of_reserve() (void)0
>
> static inline is preferred over defines.
>
> Rob
>

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
