From: lkp@intel.com (kbuild test robot)
Date: Wed, 12 Sep 2018 22:19:11 +0800
Subject: [arm-platforms:irq/generic_handle_domain_irq 1/5]
 include/linux/irqdomain.h:394:38: error: dereferencing pointer to incomplete
 type 'struct irq_data'
Message-ID: <201809122209.NdJVtEmE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/generic_handle_domain_irq
head:   feacd6dd425a07c6e54d2fcca04665ac792c6cb0
commit: fc950b873d9bd2409655ced5b723abed6879c3c8 [1/5] irqdomain: Always store irq_data
config: mips-allmodconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout fc950b873d9bd2409655ced5b723abed6879c3c8
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   In file included from arch/mips/include/asm/irq.h:14:0,
                    from include/linux/irq.h:23,
                    from include/asm-generic/hardirq.h:13,
                    from arch/mips/include/asm/hardirq.h:16,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from arch/mips/include/asm/highmem.h:24,
                    from arch/mips/include/asm/pgtable-32.h:23,
                    from arch/mips/include/asm/pgtable.h:14,
                    from include/linux/memremap.h:7,
                    from include/linux/mm.h:27,
                    from arch/mips/kernel/asm-offsets.c:15:
   include/linux/irqdomain.h: In function 'irq_linear_revmap':
>> include/linux/irqdomain.h:394:38: error: dereferencing pointer to incomplete type 'struct irq_data'
      return domain->linear_revmap[hwirq]->irq;
                                         ^~
   make[2]: *** [arch/mips/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +394 include/linux/irqdomain.h

   379	
   380	/**
   381	 * irq_linear_revmap() - Find a linux irq from a hw irq number.
   382	 * @domain: domain owning this hardware interrupt
   383	 * @hwirq: hardware irq number in that domain space
   384	 *
   385	 * This is a fast path alternative to irq_find_mapping() that can be
   386	 * called directly by irq controller code to save a handful of
   387	 * instructions. It is always safe to call, but won't find irqs mapped
   388	 * using the radix tree.
   389	 */
   390	static inline unsigned int irq_linear_revmap(struct irq_domain *domain,
   391						     irq_hw_number_t hwirq)
   392	{
   393		if (hwirq < domain->revmap_size && domain->linear_revmap[hwirq])
 > 394			return domain->linear_revmap[hwirq]->irq;
   395	
   396		return 0;
   397	}
   398	extern unsigned int irq_find_mapping(struct irq_domain *host,
   399					     irq_hw_number_t hwirq);
   400	extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
   401	extern int irq_create_strict_mappings(struct irq_domain *domain,
   402					      unsigned int irq_base,
   403					      irq_hw_number_t hwirq_base, int count);
   404	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57390 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180912/7c73f195/attachment-0001.gz>
