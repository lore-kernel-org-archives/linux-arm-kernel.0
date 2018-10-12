From: lkp@intel.com (kbuild test robot)
Date: Sat, 13 Oct 2018 02:31:32 +0800
Subject: [arm-platforms:irq/generic_handle_domain_irq 10/29]
 include/linux/irqdomain.h:398:38: error: dereferencing pointer to incomplete
 type 'struct irq_data'
Message-ID: <201810130208.sk6TQBXQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/generic_handle_domain_irq
head:   ce79686e608f93452f13339a5cadaa6836fe82b8
commit: 8e485a2a62aeb2799ee1743e895d2ad51431c272 [10/29] irqdomain: Consistently store irq_data instead of irq numbers
config: c6x-evmc6678_defconfig (attached as .config)
compiler: c6x-elf-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 8e485a2a62aeb2799ee1743e895d2ad51431c272
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=c6x 

All errors (new ones prefixed by >>):

   In file included from arch/c6x/include/asm/irq.h:16,
                    from include/linux/irq.h:23,
                    from kernel/irq/irqdesc.c:10:
   include/linux/irqdomain.h: In function 'irq_linear_revmap':
>> include/linux/irqdomain.h:398:38: error: dereferencing pointer to incomplete type 'struct irq_data'
      return domain->linear_revmap[hwirq]->irq;
                                         ^~
--
   In file included from arch/c6x/include/asm/irq.h:16,
                    from include/linux/irq.h:23,
                    from include/asm-generic/hardirq.h:13,
                    from arch/c6x/include/asm/hardirq.h:18,
                    from include/linux/hardirq.h:9,
                    from kernel/irq/irqdomain.c:7:
   include/linux/irqdomain.h: In function 'irq_linear_revmap':
>> include/linux/irqdomain.h:398:38: error: dereferencing pointer to incomplete type 'struct irq_data'
      return domain->linear_revmap[hwirq]->irq;
                                         ^~
   kernel/irq/irqdomain.c: In function 'irq_find_mapping':
   kernel/irq/irqdomain.c:914:31: warning: returning 'struct irq_data *' from a function with return type 'unsigned int' makes integer from pointer without a cast [-Wint-conversion]
      return domain->linear_revmap[hwirq];
             ~~~~~~~~~~~~~~~~~~~~~^~~~~~~

vim +398 include/linux/irqdomain.h

   382	
   383	/**
   384	 * irq_linear_revmap() - Find a linux irq from a hw irq number.
   385	 * @domain: domain owning this hardware interrupt
   386	 * @hwirq: hardware irq number in that domain space
   387	 *
   388	 * This is a fast path alternative to irq_find_mapping() that can be
   389	 * called directly by irq controller code to save a handful of
   390	 * instructions. It is always safe to call, but won't find irqs mapped
   391	 * using the radix tree.
   392	 */
   393	static inline unsigned int irq_linear_revmap(struct irq_domain *domain,
   394						     irq_hw_number_t hwirq)
   395	{
   396		if (!irq_domain_is_nomap(domain) && hwirq < domain->revmap_size &&
   397		    domain->linear_revmap[hwirq])
 > 398			return domain->linear_revmap[hwirq]->irq;
   399	
   400		return 0;
   401	}
   402	extern unsigned int irq_find_mapping(struct irq_domain *host,
   403					     irq_hw_number_t hwirq);
   404	extern int irq_create_strict_mappings(struct irq_domain *domain,
   405					      unsigned int irq_base,
   406					      irq_hw_number_t hwirq_base, int count);
   407	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 5220 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181013/a113a649/attachment-0001.gz>
