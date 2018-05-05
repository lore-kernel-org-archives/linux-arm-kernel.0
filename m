From: lkp@intel.com (kbuild test robot)
Date: Sat, 5 May 2018 20:55:28 +0800
Subject: [arm-platforms:irq/level-msi 11/13]
 drivers/irqchip/irq-gic-v3-mbi.c:26:8: error: unknown type name 'mutex_t'
Message-ID: <201805052027.hZTvWITQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/level-msi
head:   899ce68260999a53b26b3ba17836a080882e0e08
commit: 37b3cc58b06bf28420f0bff0b20fddf21b9c6b01 [11/13] irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 37b3cc58b06bf28420f0bff0b20fddf21b9c6b01
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> drivers/irqchip/irq-gic-v3-mbi.c:26:8: error: unknown type name 'mutex_t'
    static mutex_t   mbi_lock;
           ^~~~~~~
   drivers/irqchip/irq-gic-v3-mbi.c: In function 'mbi_free_msi':
>> drivers/irqchip/irq-gic-v3-mbi.c:77:13: error: passing argument 1 of 'mutex_lock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     mutex_lock(&mbi_lock);
                ^
   In file included from include/linux/kernfs.h:13:0,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/dma-mapping.h:7,
                    from include/linux/dma-iommu.h:24,
                    from drivers/irqchip/irq-gic-v3-mbi.c:9:
   include/linux/mutex.h:181:13: note: expected 'struct mutex *' but argument is of type 'int *'
    extern void mutex_lock(struct mutex *lock);
                ^~~~~~~~~~
>> drivers/irqchip/irq-gic-v3-mbi.c:80:15: error: passing argument 1 of 'mutex_unlock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     mutex_unlock(&mbi_lock);
                  ^
   In file included from include/linux/kernfs.h:13:0,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/dma-mapping.h:7,
                    from include/linux/dma-iommu.h:24,
                    from drivers/irqchip/irq-gic-v3-mbi.c:9:
   include/linux/mutex.h:200:13: note: expected 'struct mutex *' but argument is of type 'int *'
    extern void mutex_unlock(struct mutex *lock);
                ^~~~~~~~~~~~
   drivers/irqchip/irq-gic-v3-mbi.c: In function 'mbi_irq_domain_alloc':
   drivers/irqchip/irq-gic-v3-mbi.c:89:13: error: passing argument 1 of 'mutex_lock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     mutex_lock(&mbi_lock);
                ^
   In file included from include/linux/kernfs.h:13:0,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/dma-mapping.h:7,
                    from include/linux/dma-iommu.h:24,
                    from drivers/irqchip/irq-gic-v3-mbi.c:9:
   include/linux/mutex.h:181:13: note: expected 'struct mutex *' but argument is of type 'int *'
    extern void mutex_lock(struct mutex *lock);
                ^~~~~~~~~~
   drivers/irqchip/irq-gic-v3-mbi.c:99:15: error: passing argument 1 of 'mutex_unlock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     mutex_unlock(&mbi_lock);
                  ^
   In file included from include/linux/kernfs.h:13:0,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/dma-mapping.h:7,
                    from include/linux/dma-iommu.h:24,
                    from drivers/irqchip/irq-gic-v3-mbi.c:9:
   include/linux/mutex.h:200:13: note: expected 'struct mutex *' but argument is of type 'int *'
    extern void mutex_unlock(struct mutex *lock);
                ^~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/mutex_t +26 drivers/irqchip/irq-gic-v3-mbi.c

     8	
   > 9	#include <linux/dma-iommu.h>
    10	#include <linux/irq.h>
    11	#include <linux/irqdomain.h>
    12	#include <linux/kernel.h>
    13	#include <linux/msi.h>
    14	#include <linux/of_address.h>
    15	#include <linux/slab.h>
    16	#include <linux/spinlock.h>
    17	
    18	#include <linux/irqchip/arm-gic-v3.h>
    19	
    20	struct mbi_range {
    21		u32			spi_start;
    22		u32			nr_spis;
    23		unsigned long		*bm;
    24	};
    25	
  > 26	static mutex_t			mbi_lock;
    27	static phys_addr_t		mbi_phys_base;
    28	static struct mbi_range		*mbi_ranges;
    29	static unsigned int		mbi_range_nr;
    30	
    31	static struct irq_chip mbi_irq_chip = {
    32		.name			= "MBI",
    33		.irq_mask		= irq_chip_mask_parent,
    34		.irq_unmask		= irq_chip_unmask_parent,
    35		.irq_eoi		= irq_chip_eoi_parent,
    36		.irq_set_type		= irq_chip_set_type_parent,
    37		.irq_set_affinity	= irq_chip_set_affinity_parent,
    38	};
    39	
    40	static int mbi_irq_gic_domain_alloc(struct irq_domain *domain,
    41					       unsigned int virq,
    42					       irq_hw_number_t hwirq)
    43	{
    44		struct irq_fwspec fwspec;
    45		struct irq_data *d;
    46		int err;
    47	
    48		/*
    49		 * Using ACPI? There is no MBI support in the spec, you
    50		 * shouldn't even be here.
    51		 */
    52		if (!is_of_node(domain->parent->fwnode))
    53			return -EINVAL;
    54	
    55		/*
    56		 * Let's default to edge. This is consistent with traditional
    57		 * MSIs, and systems requiring level signaling will just
    58		 * enforce the trigger on their own.
    59		 */
    60		fwspec.fwnode = domain->parent->fwnode;
    61		fwspec.param_count = 3;
    62		fwspec.param[0] = 0;
    63		fwspec.param[1] = hwirq - 32;
    64		fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
    65	
    66		err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
    67		if (err)
    68			return err;
    69	
    70		d = irq_domain_get_irq_data(domain->parent, virq);
    71		return d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
    72	}
    73	
    74	static void mbi_free_msi(struct mbi_range *mbi, unsigned int hwirq,
    75				 int nr_irqs)
    76	{
  > 77		mutex_lock(&mbi_lock);
    78		bitmap_release_region(mbi->bm, hwirq - mbi->spi_start,
    79				      get_count_order(nr_irqs));
  > 80		mutex_unlock(&mbi_lock);
    81	}
    82	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38203 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180505/e7fd47e4/attachment-0001.gz>
