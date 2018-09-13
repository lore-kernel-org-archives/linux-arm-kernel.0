From: lkp@intel.com (kbuild test robot)
Date: Thu, 13 Sep 2018 21:27:36 +0800
Subject: [arm-platforms:irq/generic_handle_domain_irq 11/11]
 arch/powerpc/platforms/ps3/interrupt.c:689:3: error: 'const struct
 irq_domain_ops' has no member named 'map'
Message-ID: <201809132126.Dvr0dBW5%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/generic_handle_domain_irq
head:   a20a4e3c0467a154a73e05293a853d5e7b24d63f
commit: a20a4e3c0467a154a73e05293a853d5e7b24d63f [11/11] irqdomain: Kill irq_domain_add_legacy_isa
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a20a4e3c0467a154a73e05293a853d5e7b24d63f
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/mce.c: In function 'init_debug_trig_function':
>> arch/powerpc/kernel/mce.c:514:9: error: implicit declaration of function 'of_get_cpu_node'; did you mean 'set_dev_node'? [-Werror=implicit-function-declaration]
     cpun = of_get_cpu_node(smp_processor_id(), NULL);
            ^~~~~~~~~~~~~~~
            set_dev_node
>> arch/powerpc/kernel/mce.c:514:7: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
     cpun = of_get_cpu_node(smp_processor_id(), NULL);
          ^
>> arch/powerpc/kernel/mce.c:516:3: error: implicit declaration of function 'of_property_for_each_string'; did you mean 'driver_for_each_device'? [-Werror=implicit-function-declaration]
      of_property_for_each_string(cpun, "ibm,hmi-special-triggers",
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      driver_for_each_device
>> arch/powerpc/kernel/mce.c:517:21: error: expected ';' before '{' token
             prop, str) {
                        ^
   cc1: all warnings being treated as errors
--
   arch/powerpc/sysdev/xics/icp-hv.c: In function 'icp_hv_get_irq':
>> arch/powerpc/sysdev/xics/icp-hv.c:117:8: error: implicit declaration of function 'irq_find_mapping'; did you mean 'kgid_has_mapping'? [-Werror=implicit-function-declaration]
     irq = irq_find_mapping(xics_host, vec);
           ^~~~~~~~~~~~~~~~
           kgid_has_mapping
   cc1: all warnings being treated as errors
--
   arch/powerpc/sysdev/xics/icp-opal.c: In function 'icp_opal_get_irq':
>> arch/powerpc/sysdev/xics/icp-opal.c:76:8: error: implicit declaration of function 'irq_find_mapping'; did you mean 'page_file_mapping'? [-Werror=implicit-function-declaration]
     irq = irq_find_mapping(xics_host, vec);
           ^~~~~~~~~~~~~~~~
           page_file_mapping
   cc1: all warnings being treated as errors
--
   arch/powerpc/platforms/cell/pmu.c: In function 'cbe_init_pm_irq':
>> arch/powerpc/platforms/cell/pmu.c:386:9: error: implicit declaration of function 'irq_create_mapping'; did you mean 'vmemmap_create_mapping'? [-Werror=implicit-function-declaration]
      irq = irq_create_mapping(NULL, IIC_IRQ_IOEX_PMI |
            ^~~~~~~~~~~~~~~~~~
            vmemmap_create_mapping
   arch/powerpc/platforms/cell/pmu.c: In function 'cbe_sync_irq':
>> arch/powerpc/platforms/cell/pmu.c:411:8: error: implicit declaration of function 'irq_find_mapping'; did you mean 'page_file_mapping'? [-Werror=implicit-function-declaration]
     irq = irq_find_mapping(NULL,
           ^~~~~~~~~~~~~~~~
           page_file_mapping
   cc1: all warnings being treated as errors
--
   arch/powerpc/platforms/ps3/interrupt.c: In function 'ps3_virq_setup':
>> arch/powerpc/platforms/ps3/interrupt.c:193:10: error: implicit declaration of function 'irq_create_mapping'; did you mean 'vmemmap_create_mapping'? [-Werror=implicit-function-declaration]
     *virq = irq_create_mapping(NULL, outlet);
             ^~~~~~~~~~~~~~~~~~
             vmemmap_create_mapping
>> arch/powerpc/platforms/ps3/interrupt.c:218:2: error: implicit declaration of function 'irq_dispose_mapping'; did you mean 'qid_has_mapping'? [-Werror=implicit-function-declaration]
     irq_dispose_mapping(*virq);
     ^~~~~~~~~~~~~~~~~~~
     qid_has_mapping
   arch/powerpc/platforms/ps3/interrupt.c: At top level:
   arch/powerpc/platforms/ps3/interrupt.c:682:11: error: 'enum irq_domain_bus_token' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
         enum irq_domain_bus_token bus_token)
              ^~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/platforms/ps3/interrupt.c:682:32: error: parameter 3 ('bus_token') has incomplete type
         enum irq_domain_bus_token bus_token)
                                   ^~~~~~~~~
>> arch/powerpc/platforms/ps3/interrupt.c:681:12: error: function declaration isn't a prototype [-Werror=strict-prototypes]
    static int ps3_host_match(struct irq_domain *h, struct device_node *np,
               ^~~~~~~~~~~~~~
>> arch/powerpc/platforms/ps3/interrupt.c:688:21: error: variable 'ps3_host_ops' has initializer but incomplete type
    static const struct irq_domain_ops ps3_host_ops = {
                        ^~~~~~~~~~~~~~
>> arch/powerpc/platforms/ps3/interrupt.c:689:3: error: 'const struct irq_domain_ops' has no member named 'map'
     .map = ps3_host_map,
      ^~~
   arch/powerpc/platforms/ps3/interrupt.c:689:9: error: excess elements in struct initializer [-Werror]
     .map = ps3_host_map,
            ^~~~~~~~~~~~
   arch/powerpc/platforms/ps3/interrupt.c:689:9: note: (near initialization for 'ps3_host_ops')
>> arch/powerpc/platforms/ps3/interrupt.c:690:3: error: 'const struct irq_domain_ops' has no member named 'match'
     .match = ps3_host_match,
      ^~~~~
   arch/powerpc/platforms/ps3/interrupt.c:690:11: error: excess elements in struct initializer [-Werror]
     .match = ps3_host_match,
              ^~~~~~~~~~~~~~
   arch/powerpc/platforms/ps3/interrupt.c:690:11: note: (near initialization for 'ps3_host_ops')
   arch/powerpc/platforms/ps3/interrupt.c: In function 'ps3_init_IRQ':
>> arch/powerpc/platforms/ps3/interrupt.c:757:9: error: implicit declaration of function 'irq_domain_add_nomap'; did you mean 'irq_data_get_node'? [-Werror=implicit-function-declaration]
     host = irq_domain_add_nomap(NULL, PS3_PLUG_MAX + 1, &ps3_host_ops, NULL);
            ^~~~~~~~~~~~~~~~~~~~
            irq_data_get_node
>> arch/powerpc/platforms/ps3/interrupt.c:757:7: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
     host = irq_domain_add_nomap(NULL, PS3_PLUG_MAX + 1, &ps3_host_ops, NULL);
          ^
>> arch/powerpc/platforms/ps3/interrupt.c:758:2: error: implicit declaration of function 'irq_set_default_host'; did you mean 'irq_set_affinity_hint'? [-Werror=implicit-function-declaration]
     irq_set_default_host(host);
     ^~~~~~~~~~~~~~~~~~~~
     irq_set_affinity_hint
   arch/powerpc/platforms/ps3/interrupt.c: At top level:
>> arch/powerpc/platforms/ps3/interrupt.c:688:36: error: storage size of 'ps3_host_ops' isn't known
    static const struct irq_domain_ops ps3_host_ops = {
                                       ^~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   arch/powerpc/platforms/pseries/ibmebus.c: In function 'ibmebus_request_irq':
>> arch/powerpc/platforms/pseries/ibmebus.c:231:21: error: implicit declaration of function 'irq_create_mapping'; did you mean 'vmemmap_create_mapping'? [-Werror=implicit-function-declaration]
     unsigned int irq = irq_create_mapping(NULL, ist);
                        ^~~~~~~~~~~~~~~~~~
                        vmemmap_create_mapping
   arch/powerpc/platforms/pseries/ibmebus.c: In function 'ibmebus_free_irq':
>> arch/powerpc/platforms/pseries/ibmebus.c:242:21: error: implicit declaration of function 'irq_find_mapping'; did you mean 'page_file_mapping'? [-Werror=implicit-function-declaration]
     unsigned int irq = irq_find_mapping(NULL, ist);
                        ^~~~~~~~~~~~~~~~
                        page_file_mapping
>> arch/powerpc/platforms/pseries/ibmebus.c:245:2: error: implicit declaration of function 'irq_dispose_mapping'; did you mean 'qid_has_mapping'? [-Werror=implicit-function-declaration]
     irq_dispose_mapping(irq);
     ^~~~~~~~~~~~~~~~~~~
     qid_has_mapping
   cc1: all warnings being treated as errors
--
   arch/powerpc/kvm/book3s_xive.c: In function 'xive_attach_escalation':
>> arch/powerpc/kvm/book3s_xive.c:118:23: error: implicit declaration of function 'irq_create_mapping'; did you mean 'vmemmap_create_mapping'? [-Werror=implicit-function-declaration]
     xc->esc_virq[prio] = irq_create_mapping(NULL, q->esc_irq);
                          ^~~~~~~~~~~~~~~~~~
                          vmemmap_create_mapping
>> arch/powerpc/kvm/book3s_xive.c:169:2: error: implicit declaration of function 'irq_dispose_mapping'; did you mean 'qid_has_mapping'? [-Werror=implicit-function-declaration]
     irq_dispose_mapping(xc->esc_virq[prio]);
     ^~~~~~~~~~~~~~~~~~~
     qid_has_mapping
   cc1: all warnings being treated as errors

vim +689 arch/powerpc/platforms/ps3/interrupt.c

2832a81df Geoff Levand           2006-11-23  680  
ad3aedfbb Marc Zyngier           2015-07-28 @681  static int ps3_host_match(struct irq_domain *h, struct device_node *np,
ad3aedfbb Marc Zyngier           2015-07-28 @682  			  enum irq_domain_bus_token bus_token)
8528ab84e Michael Ellerman       2007-08-28  683  {
8528ab84e Michael Ellerman       2007-08-28  684  	/* Match all */
8528ab84e Michael Ellerman       2007-08-28  685  	return 1;
8528ab84e Michael Ellerman       2007-08-28  686  }
8528ab84e Michael Ellerman       2007-08-28  687  
9f70b8eb3 Grant Likely           2012-01-26 @688  static const struct irq_domain_ops ps3_host_ops = {
9633ac8d1 Geoff Levand           2007-01-26 @689  	.map = ps3_host_map,
8528ab84e Michael Ellerman       2007-08-28 @690  	.match = ps3_host_match,
2832a81df Geoff Levand           2006-11-23  691  };
2832a81df Geoff Levand           2006-11-23  692  
2832a81df Geoff Levand           2006-11-23  693  void __init ps3_register_ipi_debug_brk(unsigned int cpu, unsigned int virq)
2832a81df Geoff Levand           2006-11-23  694  {
9633ac8d1 Geoff Levand           2007-01-26  695  	struct ps3_private *pd = &per_cpu(ps3_private, cpu);
2832a81df Geoff Levand           2006-11-23  696  
32b9074bf Geoff Levand           2011-11-29  697  	set_bit(63 - virq, &pd->ipi_debug_brk_mask);
2832a81df Geoff Levand           2006-11-23  698  
32b9074bf Geoff Levand           2011-11-29  699  	DBG("%s:%d: cpu %u, virq %u, mask %lxh\n", __func__, __LINE__,
32b9074bf Geoff Levand           2011-11-29  700  		cpu, virq, pd->ipi_debug_brk_mask);
2832a81df Geoff Levand           2006-11-23  701  }
2832a81df Geoff Levand           2006-11-23  702  
72f3bea07 Geoff Levand           2011-11-08  703  void __init ps3_register_ipi_irq(unsigned int cpu, unsigned int virq)
72f3bea07 Geoff Levand           2011-11-08  704  {
72f3bea07 Geoff Levand           2011-11-08  705  	struct ps3_private *pd = &per_cpu(ps3_private, cpu);
72f3bea07 Geoff Levand           2011-11-08  706  
72f3bea07 Geoff Levand           2011-11-08  707  	set_bit(63 - virq, &pd->ipi_mask);
72f3bea07 Geoff Levand           2011-11-08  708  
72f3bea07 Geoff Levand           2011-11-08  709  	DBG("%s:%d: cpu %u, virq %u, ipi_mask %lxh\n", __func__, __LINE__,
72f3bea07 Geoff Levand           2011-11-08  710  		cpu, virq, pd->ipi_mask);
72f3bea07 Geoff Levand           2011-11-08  711  }
72f3bea07 Geoff Levand           2011-11-08  712  
9263e85aa Geoff Levand           2007-06-16  713  static unsigned int ps3_get_irq(void)
2832a81df Geoff Levand           2006-11-23  714  {
69111bac4 Christoph Lameter      2014-10-21  715  	struct ps3_private *pd = this_cpu_ptr(&ps3_private);
861be32ce Geoff Levand           2007-01-26  716  	u64 x = (pd->bmp.status & pd->bmp.mask);
9cf9e1966 Benjamin Herrenschmidt 2007-01-26  717  	unsigned int plug;
2832a81df Geoff Levand           2006-11-23  718  
2832a81df Geoff Levand           2006-11-23  719  	/* check for ipi break first to stop this cpu ASAP */
2832a81df Geoff Levand           2006-11-23  720  
32b9074bf Geoff Levand           2011-11-29  721  	if (x & pd->ipi_debug_brk_mask)
32b9074bf Geoff Levand           2011-11-29  722  		x &= pd->ipi_debug_brk_mask;
2832a81df Geoff Levand           2006-11-23  723  
9cf9e1966 Benjamin Herrenschmidt 2007-01-26  724  	asm volatile("cntlzd %0,%1" : "=r" (plug) : "r" (x));
9cf9e1966 Benjamin Herrenschmidt 2007-01-26  725  	plug &= 0x3f;
2832a81df Geoff Levand           2006-11-23  726  
ef24ba709 Michael Ellerman       2016-09-06  727  	if (unlikely(!plug)) {
32b9074bf Geoff Levand           2011-11-29  728  		DBG("%s:%d: no plug found: thread_id %llu\n", __func__,
aab835007 Geoff Levand           2007-06-16  729  			__LINE__, pd->thread_id);
9633ac8d1 Geoff Levand           2007-01-26  730  		dump_bmp(&per_cpu(ps3_private, 0));
9633ac8d1 Geoff Levand           2007-01-26  731  		dump_bmp(&per_cpu(ps3_private, 1));
ef24ba709 Michael Ellerman       2016-09-06  732  		return 0;
2832a81df Geoff Levand           2006-11-23  733  	}
2832a81df Geoff Levand           2006-11-23  734  
2832a81df Geoff Levand           2006-11-23  735  #if defined(DEBUG)
9cf9e1966 Benjamin Herrenschmidt 2007-01-26  736  	if (unlikely(plug < NUM_ISA_INTERRUPTS || plug > PS3_PLUG_MAX)) {
9633ac8d1 Geoff Levand           2007-01-26  737  		dump_bmp(&per_cpu(ps3_private, 0));
9633ac8d1 Geoff Levand           2007-01-26  738  		dump_bmp(&per_cpu(ps3_private, 1));
2832a81df Geoff Levand           2006-11-23  739  		BUG();
2832a81df Geoff Levand           2006-11-23  740  	}
2832a81df Geoff Levand           2006-11-23  741  #endif
72f3bea07 Geoff Levand           2011-11-08  742  
72f3bea07 Geoff Levand           2011-11-08  743  	/* IPIs are EOIed here. */
72f3bea07 Geoff Levand           2011-11-08  744  
72f3bea07 Geoff Levand           2011-11-08  745  	if (test_bit(63 - plug, &pd->ipi_mask))
72f3bea07 Geoff Levand           2011-11-08  746  		lv1_end_of_interrupt_ext(pd->ppe_id, pd->thread_id, plug);
72f3bea07 Geoff Levand           2011-11-08  747  
2832a81df Geoff Levand           2006-11-23  748  	return plug;
2832a81df Geoff Levand           2006-11-23  749  }
2832a81df Geoff Levand           2006-11-23  750  
2832a81df Geoff Levand           2006-11-23  751  void __init ps3_init_IRQ(void)
2832a81df Geoff Levand           2006-11-23  752  {
2832a81df Geoff Levand           2006-11-23  753  	int result;
2832a81df Geoff Levand           2006-11-23  754  	unsigned cpu;
bae1d8f19 Grant Likely           2012-02-14  755  	struct irq_domain *host;
2832a81df Geoff Levand           2006-11-23  756  
6fa6c8e25 Grant Likely           2012-02-15 @757  	host = irq_domain_add_nomap(NULL, PS3_PLUG_MAX + 1, &ps3_host_ops, NULL);
2832a81df Geoff Levand           2006-11-23 @758  	irq_set_default_host(host);
2832a81df Geoff Levand           2006-11-23  759  
2832a81df Geoff Levand           2006-11-23  760  	for_each_possible_cpu(cpu) {
9633ac8d1 Geoff Levand           2007-01-26  761  		struct ps3_private *pd = &per_cpu(ps3_private, cpu);
2832a81df Geoff Levand           2006-11-23  762  
aab835007 Geoff Levand           2007-06-16  763  		lv1_get_logical_ppe_id(&pd->ppe_id);
aab835007 Geoff Levand           2007-06-16  764  		pd->thread_id = get_hard_smp_processor_id(cpu);
32b9074bf Geoff Levand           2011-11-29  765  		spin_lock_init(&pd->bmp_lock);
2832a81df Geoff Levand           2006-11-23  766  
32b9074bf Geoff Levand           2011-11-29  767  		DBG("%s:%d: ppe_id %llu, thread_id %llu, bmp %lxh\n",
aab835007 Geoff Levand           2007-06-16  768  			__func__, __LINE__, pd->ppe_id, pd->thread_id,
407e24a0c Geoff Levand           2007-01-26  769  			ps3_mm_phys_to_lpar(__pa(&pd->bmp)));
407e24a0c Geoff Levand           2007-01-26  770  
aab835007 Geoff Levand           2007-06-16  771  		result = lv1_configure_irq_state_bitmap(pd->ppe_id,
aab835007 Geoff Levand           2007-06-16  772  			pd->thread_id, ps3_mm_phys_to_lpar(__pa(&pd->bmp)));
2832a81df Geoff Levand           2006-11-23  773  
2832a81df Geoff Levand           2006-11-23  774  		if (result)
32b9074bf Geoff Levand           2011-11-29  775  			FAIL("%s:%d: lv1_configure_irq_state_bitmap failed:"
2832a81df Geoff Levand           2006-11-23  776  				" %s\n", __func__, __LINE__,
2832a81df Geoff Levand           2006-11-23  777  				ps3_result(result));
2832a81df Geoff Levand           2006-11-23  778  	}
2832a81df Geoff Levand           2006-11-23  779  
2832a81df Geoff Levand           2006-11-23  780  	ppc_md.get_irq = ps3_get_irq;
2832a81df Geoff Levand           2006-11-23  781  }
9263e85aa Geoff Levand           2007-06-16  782  

:::::: The code at line 689 was first introduced by commit
:::::: 9633ac8d172f74b8ee51e0fe85c06eb726039aa8 [POWERPC] ps3: rename interrupt symbols

:::::: TO: Geoff Levand <geoffrey.levand@am.sony.com>
:::::: CC: Paul Mackerras <paulus@samba.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23952 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180913/b876fed1/attachment-0001.gz>
