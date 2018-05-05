From: lkp@intel.com (kbuild test robot)
Date: Sat, 5 May 2018 19:56:59 +0800
Subject: [arm-platforms:irq/level-msi 5/13] kernel//irq/msi.c:88:12: error:
 'struct irq_domain' has no member named 'chip'
Message-ID: <201805051954.uYFIfOq3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/level-msi
head:   899ce68260999a53b26b3ba17836a080882e0e08
commit: 95d17381c804c678329b04e7967c4b3c94d44745 [5/13] genirq/msi: Allow level-triggered MSIs to be exposed by MSI providers
config: i386-randconfig-x013-201817 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout 95d17381c804c678329b04e7967c4b3c94d44745
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/bug.h:83:0,
                    from include/linux/bug.h:5,
                    from include/linux/debug_locks.h:7,
                    from include/linux/lockdep.h:28,
                    from include/linux/spinlock_types.h:18,
                    from include/linux/mutex.h:16,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from kernel//irq/msi.c:12:
   kernel//irq/msi.c: In function 'msi_check_level':
>> kernel//irq/msi.c:88:12: error: 'struct irq_domain' has no member named 'chip'
        (domain->chip->flags & IRQCHIP_SUPPORTS_LEVEL_MSI)) &&
               ^
   include/asm-generic/bug.h:112:25: note: in definition of macro 'WARN_ON'
     int __ret_warn_on = !!(condition);    \
                            ^~~~~~~~~
   kernel//irq/msi.c:88:28: error: 'IRQCHIP_SUPPORTS_LEVEL_MSI' undeclared (first use in this function); did you mean 'IRQCHIP_STATE_LINE_LEVEL'?
        (domain->chip->flags & IRQCHIP_SUPPORTS_LEVEL_MSI)) &&
                               ^
   include/asm-generic/bug.h:112:25: note: in definition of macro 'WARN_ON'
     int __ret_warn_on = !!(condition);    \
                            ^~~~~~~~~
   kernel//irq/msi.c:88:28: note: each undeclared identifier is reported only once for each function it appears in
        (domain->chip->flags & IRQCHIP_SUPPORTS_LEVEL_MSI)) &&
                               ^
   include/asm-generic/bug.h:112:25: note: in definition of macro 'WARN_ON'
     int __ret_warn_on = !!(condition);    \
                            ^~~~~~~~~

vim +88 kernel//irq/msi.c

  > 12	#include <linux/device.h>
    13	#include <linux/irq.h>
    14	#include <linux/irqdomain.h>
    15	#include <linux/msi.h>
    16	#include <linux/slab.h>
    17	
    18	#include "internals.h"
    19	
    20	/**
    21	 * alloc_msi_entry - Allocate an initialize msi_entry
    22	 * @dev:	Pointer to the device for which this is allocated
    23	 * @nvec:	The number of vectors used in this entry
    24	 * @affinity:	Optional pointer to an affinity mask array size of @nvec
    25	 *
    26	 * If @affinity is not NULL then a an affinity array[@nvec] is allocated
    27	 * and the affinity masks from @affinity are copied.
    28	 */
    29	struct msi_desc *
    30	alloc_msi_entry(struct device *dev, int nvec, const struct cpumask *affinity)
    31	{
    32		struct msi_desc *desc;
    33	
    34		desc = kzalloc(sizeof(*desc), GFP_KERNEL);
    35		if (!desc)
    36			return NULL;
    37	
    38		INIT_LIST_HEAD(&desc->list);
    39		desc->dev = dev;
    40		desc->nvec_used = nvec;
    41		if (affinity) {
    42			desc->affinity = kmemdup(affinity,
    43				nvec * sizeof(*desc->affinity), GFP_KERNEL);
    44			if (!desc->affinity) {
    45				kfree(desc);
    46				return NULL;
    47			}
    48		}
    49	
    50		return desc;
    51	}
    52	
    53	void free_msi_entry(struct msi_desc *entry)
    54	{
    55		kfree(entry->affinity);
    56		kfree(entry);
    57	}
    58	
    59	void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
    60	{
    61		*msg = entry->msg;
    62	}
    63	
    64	void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
    65	{
    66		struct msi_desc *entry = irq_get_msi_desc(irq);
    67	
    68		__get_cached_msi_msg(entry, msg);
    69	}
    70	EXPORT_SYMBOL_GPL(get_cached_msi_msg);
    71	
    72	#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
    73	static inline void irq_chip_write_msi_msg(struct irq_data *data,
    74						  struct msi_msg *msg)
    75	{
    76		data->chip->irq_write_msi_msg(data, msg);
    77	}
    78	
    79	static void msi_check_level(struct irq_domain *domain, struct msi_msg *msg)
    80	{
    81		struct msi_domain_info *info = domain->host_data;
    82	
    83		/*
    84		 * If the MSI provider has messed with the second message and
    85		 * not advertized that it is level-capable, signal the breakage.
    86		 */
    87		WARN_ON(!((info->flags & MSI_FLAG_LEVEL_CAPABLE) &&
  > 88			  (domain->chip->flags & IRQCHIP_SUPPORTS_LEVEL_MSI)) &&
    89			(msg[1].address_lo || msg[1].address_hi || msg[1].data));
    90	}
    91	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27761 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180505/64d1e552/attachment-0001.gz>
