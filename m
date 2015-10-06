From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 6 Oct 2015 19:06:10 +0800
Subject: [arm-platforms:irq/gsi-irq-domain-v5 11/15]
 kernel/irq/irqdomain.c:49:24: sparse: incorrect type in argument 1
 (different base types)
Message-ID: <201510061906.Y48QmFgC%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/gsi-irq-domain-v5
head:   3d3e17e75176df073407aa467271d53aa0f6bfbd
commit: d8c82bb246fd3bd1691d221d5a1b680504123394 [11/15] genirq/irqdomain: Add a fwnode_handle allocator
reproduce:
        # apt-get install sparse
        git checkout d8c82bb246fd3bd1691d221d5a1b680504123394
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> kernel/irq/irqdomain.c:49:24: sparse: incorrect type in argument 1 (different base types)
   kernel/irq/irqdomain.c:49:24:    expected unsigned long [unsigned] [usertype] size
   kernel/irq/irqdomain.c:49:24:    got restricted gfp_t
>> kernel/irq/irqdomain.c:49:36: sparse: incorrect type in argument 2 (different base types)
   kernel/irq/irqdomain.c:49:36:    expected restricted gfp_t [usertype] flags
   kernel/irq/irqdomain.c:49:36:    got unsigned long

vim +49 kernel/irq/irqdomain.c

    33		void *data;
    34	};
    35	
    36	/**
    37	 * irq_domain_alloc_fwnode - Allocate a fwnode_handle suitable for
    38	 *                           identifying an irq domain
    39	 * @data: optional user-provided data
    40	 *
    41	 * Allocate a struct device_node, and return a poiner to the embedded
    42	 * fwnode_handle (or NULL on failure).
    43	 */
    44	struct fwnode_handle *irq_domain_alloc_fwnode(void *data)
    45	{
    46		struct irqchip_fwid *fwid;
    47		char *name;
    48	
  > 49		fwid = kzalloc(GFP_KERNEL, sizeof(*fwid));
    50		name = kasprintf(GFP_KERNEL, "irqchip@%p", data);
    51	
    52		if (!fwid || !name) {
    53			kfree(fwid);
    54			kfree(name);
    55			return NULL;
    56		}
    57	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
