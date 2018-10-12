From: lkp@intel.com (kbuild test robot)
Date: Sat, 13 Oct 2018 02:44:22 +0800
Subject: [arm-platforms:irq/generic_handle_domain_irq 13/29]
 include/linux/irqdomain.h:425:2: error: implicit declaration of function
 'generic_handle_irq_desc'; did you mean 'generic_handle_domain_irq'?
Message-ID: <201810130200.HE9sRCe6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/generic_handle_domain_irq
head:   ce79686e608f93452f13339a5cadaa6836fe82b8
commit: adb0a1576e54885d5d15ebac86f98eb94da1f8e3 [13/29] irqdesc: Make __handle_domain_irq use irq_data instead of irq numbers
config: c6x-evmc6678_defconfig (attached as .config)
compiler: c6x-elf-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout adb0a1576e54885d5d15ebac86f98eb94da1f8e3
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=c6x 

All errors (new ones prefixed by >>):

   In file included from arch/c6x/include/asm/irq.h:16,
                    from include/linux/irq.h:23,
                    from include/asm-generic/hardirq.h:13,
                    from arch/c6x/include/asm/hardirq.h:18,
                    from include/linux/hardirq.h:9,
                    from include/linux/highmem.h:10,
                    from include/linux/pagemap.h:11,
                    from block//partitions/check.h:2,
                    from block//partitions/check.c:22:
   include/linux/irqdomain.h: In function 'irq_linear_revmap':
   include/linux/irqdomain.h:398:38: error: dereferencing pointer to incomplete type 'struct irq_data'
      return domain->linear_revmap[hwirq]->irq;
                                         ^~
   include/linux/irqdomain.h: In function 'generic_handle_domain_irq':
>> include/linux/irqdomain.h:425:2: error: implicit declaration of function 'generic_handle_irq_desc'; did you mean 'generic_handle_domain_irq'? [-Werror=implicit-function-declaration]
     generic_handle_irq_desc(irq_data_to_desc(data));
     ^~~~~~~~~~~~~~~~~~~~~~~
     generic_handle_domain_irq
>> include/linux/irqdomain.h:425:26: error: implicit declaration of function 'irq_data_to_desc'; did you mean 'irq_to_desc'? [-Werror=implicit-function-declaration]
     generic_handle_irq_desc(irq_data_to_desc(data));
                             ^~~~~~~~~~~~~~~~
                             irq_to_desc
   In file included from include/linux/irq.h:519,
                    from include/asm-generic/hardirq.h:13,
                    from arch/c6x/include/asm/hardirq.h:18,
                    from include/linux/hardirq.h:9,
                    from include/linux/highmem.h:10,
                    from include/linux/pagemap.h:11,
                    from block//partitions/check.h:2,
                    from block//partitions/check.c:22:
   include/linux/irqdesc.h: At top level:
>> include/linux/irqdesc.h:118:32: error: conflicting types for 'irq_data_to_desc'
    static inline struct irq_desc *irq_data_to_desc(struct irq_data *data)
                                   ^~~~~~~~~~~~~~~~
   In file included from arch/c6x/include/asm/irq.h:16,
                    from include/linux/irq.h:23,
                    from include/asm-generic/hardirq.h:13,
                    from arch/c6x/include/asm/hardirq.h:18,
                    from include/linux/hardirq.h:9,
                    from include/linux/highmem.h:10,
                    from include/linux/pagemap.h:11,
                    from block//partitions/check.h:2,
                    from block//partitions/check.c:22:
   include/linux/irqdomain.h:425:26: note: previous implicit declaration of 'irq_data_to_desc' was here
     generic_handle_irq_desc(irq_data_to_desc(data));
                             ^~~~~~~~~~~~~~~~
   In file included from include/linux/irq.h:519,
                    from include/asm-generic/hardirq.h:13,
                    from arch/c6x/include/asm/hardirq.h:18,
                    from include/linux/hardirq.h:9,
                    from include/linux/highmem.h:10,
                    from include/linux/pagemap.h:11,
                    from block//partitions/check.h:2,
                    from block//partitions/check.c:22:
   include/linux/irqdesc.h:152:20: warning: conflicting types for 'generic_handle_irq_desc'
    static inline void generic_handle_irq_desc(struct irq_desc *desc)
                       ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/irqdesc.h:152:20: error: static declaration of 'generic_handle_irq_desc' follows non-static declaration
   In file included from arch/c6x/include/asm/irq.h:16,
                    from include/linux/irq.h:23,
                    from include/asm-generic/hardirq.h:13,
                    from arch/c6x/include/asm/hardirq.h:18,
                    from include/linux/hardirq.h:9,
                    from include/linux/highmem.h:10,
                    from include/linux/pagemap.h:11,
                    from block//partitions/check.h:2,
                    from block//partitions/check.c:22:
   include/linux/irqdomain.h:425:2: note: previous implicit declaration of 'generic_handle_irq_desc' was here
     generic_handle_irq_desc(irq_data_to_desc(data));
     ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +425 include/linux/irqdomain.h

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
   402	extern struct irq_data *irq_resolve_mapping(struct irq_domain *host,
   403						    irq_hw_number_t hwirq);
   404	
   405	static inline unsigned int irq_find_mapping(struct irq_domain *host,
   406						    irq_hw_number_t hwirq)
   407	{
   408		struct irq_data *data;
   409	
   410		data = irq_resolve_mapping(host, hwirq);
   411		if (data)
   412			return data->irq;
   413	
   414		return 0;
   415	}
   416	
   417	static inline int generic_handle_domain_irq(struct irq_domain *domain,
   418						    unsigned int hwirq)
   419	{
   420		struct irq_data *data = irq_resolve_mapping(domain, hwirq);
   421	
   422		if (unlikely(!data))
   423			return -EINVAL;
   424	
 > 425		generic_handle_irq_desc(irq_data_to_desc(data));
   426		return 0;
   427	}
   428	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 5220 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181013/83c0cb37/attachment.gz>
